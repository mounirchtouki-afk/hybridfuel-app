// Download-beveiliging voor de betaalde Hyrox-voedingsgids (bundel, ~€17,95).
// Voorheen stond de PDF publiek op de website — iedereen met de URL kon 'm pakken.
// Nu: de PDF staat in een PRIVÉ Supabase Storage-bucket en is alleen te downloaden
// met een geldig betaaltoken dat ook écht een BUNDEL-aankoop was.
//
// Flow:
//   1. Client roept /api/guide?lang=nl&token=<hf_token> aan (token komt van /api/verify).
//   2. We verifiëren de HMAC van het token (kan niet vervalst worden).
//   3. We hercheckken BIJ STRIPE dat die sessie betaald is én het bundelbedrag had.
//   4. We maken een signed URL (5 min geldig) uit de privé-bucket en 302-redirecten.
//   Geen geldig bundeltoken → 403, geen bestand.
//
// Env-vars in Vercel (server-side, geheim waar aangegeven):
//   STRIPE_SECRET_KEY           sk_live_... (zelfde als /api/verify)
//   UNLOCK_SECRET               zelfde geheime string als /api/verify
//   SUPABASE_URL                https://tkmyjpsmdijaalwgzqdy.supabase.co
//   SUPABASE_SERVICE_ROLE_KEY   service-role key (GEHEIM — alleen server-side!)
//   GUIDE_BUCKET                optioneel, standaard "guides"
//
// Setup eenmalig: maak in Supabase Storage een PRIVÉ bucket "guides" en upload
// hyrox-guide-nl.pdf en hyrox-guide-en.pdf. Verwijder de publieke PDF's van de site.

import crypto from "crypto";

function tokenValid(token) {
  if (!token || typeof token !== "string" || token.length > 400) return null;
  const i = token.lastIndexOf(".");
  if (i < 1) return null;
  const sid = token.slice(0, i);
  const sig = token.slice(i + 1);
  const secret = process.env.UNLOCK_SECRET;
  if (!secret) return null;
  const expect = crypto.createHmac("sha256", secret).update(sid).digest("hex");
  // timing-safe vergelijk
  const a = Buffer.from(sig);
  const b = Buffer.from(expect);
  if (a.length !== b.length) return null;
  try { if (!crypto.timingSafeEqual(a, b)) return null; } catch (e) { return null; }
  return sid;
}

async function isBundle(sid) {
  const stripeKey = process.env.STRIPE_SECRET_KEY;
  if (!stripeKey) return false;
  try {
    const r = await fetch("https://api.stripe.com/v1/checkout/sessions/" + encodeURIComponent(sid), {
      headers: { Authorization: "Bearer " + stripeKey },
    });
    if (!r.ok) return false;
    const s = await r.json();
    const paid = s.payment_status === "paid" || s.status === "complete";
    return !!(paid && (s.amount_total || 0) >= 1600);
  } catch (e) { return false; }
}

async function signedUrl(lang) {
  const url = (process.env.SUPABASE_URL || process.env.VITE_SUPABASE_URL || "").replace(/\/$/, "");
  const svc = process.env.SUPABASE_SERVICE_ROLE_KEY;
  const bucket = process.env.GUIDE_BUCKET || "guides";
  if (!url || !svc) return null;
  const obj = "hyrox-guide-" + (lang === "en" ? "en" : "nl") + ".pdf";
  try {
    const r = await fetch(url + "/storage/v1/object/sign/" + bucket + "/" + encodeURIComponent(obj), {
      method: "POST",
      headers: { apikey: svc, Authorization: "Bearer " + svc, "Content-Type": "application/json" },
      body: JSON.stringify({ expiresIn: 300 }),
    });
    if (!r.ok) return null;
    const j = await r.json().catch(() => null);
    if (!j || !j.signedURL) return null;
    return url + "/storage/v1" + j.signedURL;
  } catch (e) { return null; }
}

export default async function handler(req, res) {
  const q = req.query || {};
  const lang = q.lang === "en" ? "en" : "nl";
  const token = q.token || (req.body && (typeof req.body === "string" ? safeParse(req.body).token : req.body.token));

  const sid = tokenValid(token);
  if (!sid) return res.status(403).json({ ok: false, error: "geen geldig toegangstoken / no valid access token" });

  const ok = await isBundle(sid);
  if (!ok) return res.status(403).json({ ok: false, error: "deze aankoop bevat de gids niet / this purchase does not include the guide" });

  const link = await signedUrl(lang);
  if (!link) return res.status(503).json({ ok: false, error: "gids tijdelijk niet beschikbaar / guide temporarily unavailable" });

  if (q.json === "1") return res.status(200).json({ ok: true, url: link });
  res.setHeader("Cache-Control", "no-store");
  res.writeHead(302, { Location: link });
  return res.end();
}

function safeParse(s) { try { return JSON.parse(s); } catch (e) { return {}; } }
