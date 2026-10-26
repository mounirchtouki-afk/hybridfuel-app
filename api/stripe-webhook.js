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

// Harde fallback op de project-URL, zodat een ontbrekende SUPABASE_URL op Preview
// niet stilletjes de write laat falen (zelfde URL als supabaseClient.js).
function supaBase() { return (process.env.SUPABASE_URL || process.env.VITE_SUPABASE_URL || "https://tkmyjpsmdijaalwgzqdy.supabase.co").replace(/\/$/, ""); }

async function setSub(userId, fields) {
  const url = supaBase();
  const key = process.env.SUPABASE_SERVICE_ROLE_KEY;
  if (!url || !key || !userId) return { ok: false, reason: "missing", hasUrl: !!url, hasKey: !!key, hasUserId: !!userId };
  // Upsert op user_id (unique): werkt de rij bij, of maakt 'm aan als de signup-trigger
  // geen rij heeft gezet. Zo is de tier-update niet afhankelijk van de trigger.
  const r = await fetch(url + "/rest/v1/subscriptions?on_conflict=user_id", {
    method: "POST",
    headers: { apikey: key, Authorization: "Bearer " + key, "Content-Type": "application/json", Prefer: "resolution=merge-duplicates,return=minimal" },
    body: JSON.stringify({ user_id: userId, ...fields, updated_at: new Date().toISOString() }),
  });
  if (!r.ok) { const txt = await r.text().catch(() => ""); console.error("supabase upsert faalde", r.status, txt); return { ok: false, status: r.status, body: txt.slice(0, 300) }; }
  return { ok: true };
}

async function stripeGet(path) {
  const r = await fetch("https://api.stripe.com/v1/" + path, { headers: { Authorization: "Bearer " + process.env.STRIPE_SECRET_KEY } });
  return r.ok ? r.json() : null;
}

// Haalt de ECHTE huidige status van een subscription bij Stripe op, zodat de tier
// niet afhangt van de volgorde waarin webhook-events binnenkomen. Niet op te halen
// (404 = opgezegd/weg) → null, en de aanroeper behandelt dat als 'free'.
async function fetchSubState(subId) {
  if (!subId) return null;
  const sub = await stripeGet("subscriptions/" + encodeURIComponent(subId));
  if (!sub || !sub.id) return null;
  const active = sub.status === "active" || sub.status === "trialing";
  const interval = sub.items && sub.items.data && sub.items.data[0] && sub.items.data[0].price && sub.items.data[0].price.recurring && sub.items.data[0].price.recurring.interval;
  return {
    tier: active ? ((sub.metadata && sub.metadata.tier) || "basis") : "free",
    status: sub.status,
    interval: interval || null,
    periodEnd: sub.current_period_end ? new Date(sub.current_period_end * 1000).toISOString() : null,
    cancelAtPeriodEnd: !!sub.cancel_at_period_end,
    customer: sub.customer || null,
    userId: (sub.metadata && sub.metadata.user_id) || null,
  };
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

  let db = { skipped: evt.type };
  try {
    const o = evt.data && evt.data.object;
    if (evt.type === "checkout.session.completed" && o && o.mode === "subscription") {
      const userId = o.client_reference_id || (o.metadata && o.metadata.user_id);
      const st = o.subscription ? await fetchSubState(o.subscription) : null; // echte status bij Stripe
      db = await setSub(userId, {
        stripe_customer_id: o.customer || (st && st.customer) || null,
        stripe_subscription_id: o.subscription || null,
        tier: (st && st.tier) || (o.metadata && o.metadata.tier) || "basis",
        status: (st && st.status) || "active",
        interval: st ? st.interval : null,
        current_period_end: st ? st.periodEnd : null,
        cancel_at_period_end: st ? st.cancelAtPeriodEnd : false,
      });
    } else if (evt.type === "customer.subscription.updated" && o) {
      const userId = o.metadata && o.metadata.user_id;
      // Niet op het event vertrouwen: haal de echte status op. Niet-ophaalbaar = weg = free.
      const st = await fetchSubState(o.id);
      db = st
        ? await setSub(userId, { tier: st.tier, status: st.status, interval: st.interval, current_period_end: st.periodEnd, cancel_at_period_end: st.cancelAtPeriodEnd })
        : await setSub(userId, { tier: "free", status: "canceled", cancel_at_period_end: false });
    } else if (evt.type === "customer.subscription.deleted" && o) {
      const userId = o.metadata && o.metadata.user_id;
      db = await setSub(userId, { tier: "free", status: "canceled", cancel_at_period_end: false });
    }
  } catch (err) {
    console.error("stripe-webhook handler error", err);
    db = { ok: false, reason: "handler_error", message: String(err && err.message || err).slice(0, 200) };
  }

  // db wordt teruggegeven zodat de oorzaak zichtbaar is in het Stripe-antwoord (debug).
  return res.status(200).json({ received: true, db });
}
