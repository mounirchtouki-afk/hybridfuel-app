// Server-geverifieerd betaalslot.
// Na betaling stuurt Stripe de klant terug naar de app met ?session_id=...
// Deze functie controleert BIJ STRIPE of die sessie echt betaald is, en geeft
// alleen dan een ondertekend token terug. Dat token geeft /api/plan vrij om het
// AI-maaltijdplan te maken. Zonder geldige betaling → geen token → geen plan.
//
// Nodig als environment variables in Vercel (vanavond instellen):
//   STRIPE_SECRET_KEY = je Stripe secret key (sk_live_... of sk_test_...)
//   UNLOCK_SECRET     = een willekeurige lange geheime string (zelf verzinnen)

import crypto from "crypto";
import { kv } from "./_kv.js";
import { ipLimited } from "./_ratelimit.js";

export default async function handler(req, res) {
  if (await ipLimited(req, "verify", 30, 3600)) return res.status(429).json({ ok: false, error: "rate_limited" });
  const sid =
    (req.query && req.query.session_id) ||
    (req.body && (typeof req.body === "string" ? JSON.parse(req.body).session_id : req.body.session_id));

  if (!sid || typeof sid !== "string" || sid.length > 200) {
    return res.status(400).json({ ok: false, error: "no session_id" });
  }

  const stripeKey = process.env.STRIPE_SECRET_KEY;
  const unlockSecret = process.env.UNLOCK_SECRET;
  if (!stripeKey || !unlockSecret) {
    return res.status(500).json({ ok: false, error: "server not configured" });
  }

  try {
    const r = await fetch("https://api.stripe.com/v1/checkout/sessions/" + encodeURIComponent(sid), {
      headers: { Authorization: "Bearer " + stripeKey },
    });
    if (!r.ok) {
      return res.status(502).json({ ok: false, error: "stripe " + r.status });
    }
    const s = await r.json();
    const paid = s.payment_status === "paid" || s.status === "complete";
    if (!paid) {
      return res.status(200).json({ ok: false, error: "not paid" });
    }
    // Bundel (incl. Hyrox-gids) vanaf ~€17; anders week. Bedrag is in centen.
    const tier = (s.amount_total || 0) >= 1600 ? "bundle" : "week";
    const sig = crypto.createHmac("sha256", unlockSecret).update(sid).digest("hex");
    const token = sid + "." + sig;

    // Optie B: ken credits toe aan deze betaling. NX = alleen zetten als er nog
    // geen record is, zodat de teller niet reset als de klant de pagina herlaadt.
    // (Doet niets als er geen credit-opslag is gekoppeld.)
    const credits = parseInt(process.env.CREDITS_PER_PAYMENT || "3", 10);
    try { await kv(["SET", "cr:" + sid, String(credits), "EX", "15552000", "NX"]); } catch (e) {}

    return res.status(200).json({ ok: true, token, tier, credits });
  } catch (e) {
    return res.status(500).json({ ok: false, error: String(e).slice(0, 120) });
  }
}
