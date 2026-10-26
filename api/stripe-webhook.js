// /api/stripe-webhook — ontvangt Stripe-abonnementsevents en zet de laag (tier +
// status) per gebruiker in Supabase. Verifieert de Stripe-signature zelf (geen SDK).
//
// Env-vars in Vercel:
//   STRIPE_SECRET_KEY            sk_live_... / sk_test_...   (staat al)
//   STRIPE_WEBHOOK_SECRET        whsec_...   (uit Stripe → Developers → Webhooks)
//   SUPABASE_URL                 https://tkmyjpsmdijaalwgzqdy.supabase.co
//                                (of VITE_SUPABASE_URL — die wordt ook gelezen)
//   SUPABASE_SERVICE_ROLE_KEY    de service-role key (GEHEIM — alleen server-side!)
//
// Zet in Stripe de webhook-endpoint op:  https://<app>/api/stripe-webhook
// en abonneer op: checkout.session.completed, customer.subscription.updated,
// customer.subscription.deleted.

import crypto from "crypto";

// Vercel mag de body NIET parsen — we hebben de rauwe bytes nodig voor de signature.
export const config = { api: { bodyParser: false } };

function readRaw(req) {
  return new Promise((resolve, reject) => {
    const chunks = [];
    req.on("data", (c) => chunks.push(Buffer.isBuffer(c) ? c : Buffer.from(c)));
    req.on("end", () => resolve(Buffer.concat(chunks)));
    req.on("error", reject);
  });
}

function verify(raw, sigHeader, secret) {
  if (!sigHeader) return false;
  const parts = Object.fromEntries(sigHeader.split(",").map((kv) => kv.split("=")));
  const t = parts.t, v1 = parts.v1;
  if (!t || !v1) return false;
  const expected = crypto.createHmac("sha256", secret).update(t + "." + raw.toString("utf8")).digest("hex");
  try {
    if (!crypto.timingSafeEqual(Buffer.from(expected), Buffer.from(v1))) return false;
  } catch (e) { return false; }
  // Replay-bescherming: niet ouder dan 5 min.
  const age = Math.abs(Date.now() / 1000 - Number(t));
  return age < 300;
}

function supaBase() { return (process.env.SUPABASE_URL || process.env.VITE_SUPABASE_URL || "").replace(/\/$/, ""); }

async function setSub(userId, fields) {
  const url = supaBase();
  const key = process.env.SUPABASE_SERVICE_ROLE_KEY;
  if (!url || !key || !userId) { console.warn("stripe-webhook: supabase niet geconfigureerd of geen userId"); return; }
  // Upsert op user_id (unique): werkt de rij bij, of maakt 'm aan als de signup-trigger
  // geen rij heeft gezet. Zo is de tier-update niet afhankelijk van de trigger.
  const r = await fetch(url + "/rest/v1/subscriptions?on_conflict=user_id", {
    method: "POST",
    headers: { apikey: key, Authorization: "Bearer " + key, "Content-Type": "application/json", Prefer: "resolution=merge-duplicates,return=minimal" },
    body: JSON.stringify({ user_id: userId, ...fields, updated_at: new Date().toISOString() }),
  });
  if (!r.ok) { const txt = await r.text().catch(() => ""); console.error("supabase upsert faalde", r.status, txt); }
}

async function stripeGet(path) {
  const r = await fetch("https://api.stripe.com/v1/" + path, { headers: { Authorization: "Bearer " + process.env.STRIPE_SECRET_KEY } });
  return r.ok ? r.json() : null;
}

export default async function handler(req, res) {
  if (req.method !== "POST") { res.setHeader("Allow", "POST"); return res.status(405).end(); }

  const secret = process.env.STRIPE_WEBHOOK_SECRET;
  if (!secret) return res.status(503).json({ error: "not_configured" });

  let raw;
  try { raw = await readRaw(req); } catch (e) { return res.status(400).json({ error: "no_body" }); }
  if (!verify(raw, req.headers["stripe-signature"], secret)) {
    return res.status(400).json({ error: "bad_signature" });
  }

  let evt;
  try { evt = JSON.parse(raw.toString("utf8")); } catch (e) { return res.status(400).json({ error: "bad_json" }); }

  try {
    const o = evt.data && evt.data.object;
    if (evt.type === "checkout.session.completed" && o && o.mode === "subscription") {
      const userId = o.client_reference_id || (o.metadata && o.metadata.user_id);
      const tier = (o.metadata && o.metadata.tier) || "basis";
      let interval = null, periodEnd = null;
      if (o.subscription) {
        const sub = await stripeGet("subscriptions/" + encodeURIComponent(o.subscription));
        if (sub) {
          interval = sub.items && sub.items.data && sub.items.data[0] && sub.items.data[0].price && sub.items.data[0].price.recurring && sub.items.data[0].price.recurring.interval;
          if (sub.current_period_end) periodEnd = new Date(sub.current_period_end * 1000).toISOString();
        }
      }
      await setSub(userId, {
        stripe_customer_id: o.customer || null,
        stripe_subscription_id: o.subscription || null,
        tier, status: "active", interval, current_period_end: periodEnd, cancel_at_period_end: false,
      });
    } else if (evt.type === "customer.subscription.updated" && o) {
      const userId = o.metadata && o.metadata.user_id;
      const active = o.status === "active" || o.status === "trialing";
      const tier = active ? ((o.metadata && o.metadata.tier) || "basis") : "free";
      const interval = o.items && o.items.data && o.items.data[0] && o.items.data[0].price && o.items.data[0].price.recurring && o.items.data[0].price.recurring.interval;
      await setSub(userId, {
        tier, status: o.status,
        interval: interval || null,
        current_period_end: o.current_period_end ? new Date(o.current_period_end * 1000).toISOString() : null,
        cancel_at_period_end: !!o.cancel_at_period_end,
      });
    } else if (evt.type === "customer.subscription.deleted" && o) {
      const userId = o.metadata && o.metadata.user_id;
      await setSub(userId, { tier: "free", status: "canceled", cancel_at_period_end: false });
    }
  } catch (err) {
    console.error("stripe-webhook handler error", err);
    // 200 teruggeven zodat Stripe niet eindeloos opnieuw probeert bij een eigen bug;
    // de fout staat in de logs.
  }

  return res.status(200).json({ received: true });
}
