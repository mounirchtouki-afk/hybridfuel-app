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
// customer.subscription.deleted, charge.refunded.

import crypto from "crypto";
import { kv } from "./_kv.js";

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

// --- Publieke-checkout koppeling (2-klik flow) -------------------------------
// Betaalt iemand zonder vooraf ingelogd te zijn, dan is er nog geen Supabase-user.
// We maken (of vinden) die op e-mail en geven de id terug, zodat de subscription
// aan een echte account hangt.
async function findOrCreateUser(email) {
  if (!email) return null;
  const url = supaBase();
  const key = process.env.SUPABASE_SERVICE_ROLE_KEY;
  if (!url || !key) return null;
  // 1) Aanmaken (e-mail meteen bevestigd zodat de inlog-link direct werkt).
  try {
    const cr = await fetch(url + "/auth/v1/admin/users", {
      method: "POST",
      headers: { apikey: key, Authorization: "Bearer " + key, "Content-Type": "application/json" },
      body: JSON.stringify({ email, email_confirm: true }),
    });
    if (cr.ok) { const u = await cr.json().catch(() => ({})); if (u && u.id) return u.id; }
  } catch (e) {}
  // 2) Bestond al → opzoeken in de admin-lijst (paginerend, op e-mail).
  for (let page = 1; page <= 10; page++) {
    try {
      const lr = await fetch(url + "/auth/v1/admin/users?page=" + page + "&per_page=200", {
        headers: { apikey: key, Authorization: "Bearer " + key },
      });
      if (!lr.ok) break;
      const d = await lr.json().catch(() => ({}));
      const list = (d && (d.users || (Array.isArray(d) ? d : []))) || [];
      const hit = list.find((x) => (x.email || "").toLowerCase() === email);
      if (hit && hit.id) return hit.id;
      if (list.length < 200) break;
    } catch (e) { break; }
  }
  return null;
}

// Mailt een magic-link (gebruikt de ingestelde SMTP = Resend) zodat de klant na
// betaling in de app komt zonder eerst een wachtwoord te hoeven kiezen.
async function sendMagicLink(email) {
  if (!email) return;
  const url = supaBase();
  const anon = process.env.SUPABASE_ANON_KEY || process.env.VITE_SUPABASE_ANON_KEY || "sb_publishable_5CJ_waXIVhhzkkqD96iqMA_63yJJnaH";
  try {
    await fetch(url + "/auth/v1/otp", {
      method: "POST",
      headers: { apikey: anon, "Content-Type": "application/json" },
      body: JSON.stringify({ email, create_user: false }),
    });
  } catch (e) {}
}

// Zet user_id op de Stripe-subscription, zodat latere updated/deleted-events ook
// aan de juiste gebruiker gekoppeld worden.
async function setStripeSubMeta(subId, userId) {
  if (!subId || !userId) return;
  const params = new URLSearchParams();
  params.set("metadata[user_id]", userId);
  try {
    await fetch("https://api.stripe.com/v1/subscriptions/" + encodeURIComponent(subId), {
      method: "POST",
      headers: { Authorization: "Bearer " + process.env.STRIPE_SECRET_KEY, "Content-Type": "application/x-www-form-urlencoded" },
      body: params.toString(),
    });
  } catch (e) {}
}

// Zoekt de user_id bij een Stripe-customer, zodat we bij een refund weten wiens
// toegang we moeten intrekken (de eenmalige betaling zette stripe_customer_id op de rij).
async function findUserByCustomer(customerId) {
  if (!customerId) return null;
  const url = supaBase();
  const key = process.env.SUPABASE_SERVICE_ROLE_KEY;
  if (!url || !key) return null;
  try {
    const r = await fetch(url + "/rest/v1/subscriptions?stripe_customer_id=eq." + encodeURIComponent(customerId) + "&select=user_id&limit=1", {
      headers: { apikey: key, Authorization: "Bearer " + key },
    });
    if (!r.ok) return null;
    const rows = await r.json().catch(() => []);
    return (rows && rows[0] && rows[0].user_id) || null;
  } catch (e) { return null; }
}

// --- Bestelmelding naar de eigenaar ------------------------------------------
// Stuurt bij een geslaagde betaling een mail met de orderdetails naar de eigenaar,
// via dezelfde Make-webhook die de verlengmails relayt ({to, subject, html} -> Gmail).
// Dedup op de sessie-id (KV, 7 dagen) zodat een resend/retry niet dubbel mailt.
const ORDER_LABEL = { basis: "Basic", pro: "Pro" };
function eur(cents) { return "€" + (Number(cents || 0) / 100).toFixed(2).replace(".", ","); }
function orderRow(k, v) { return "<tr><td style='padding:3px 16px 3px 0;color:#67646E;vertical-align:top'>" + k + "</td><td style='padding:3px 0;font-weight:600'>" + v + "</td></tr>"; }

async function sendOrderNotification(o) {
  const to = process.env.ORDER_NOTIFY_EMAIL || "hybridfuelco@gmail.com";
  const hook = process.env.ORDER_NOTIFY_WEBHOOK || process.env.RENEWAL_WEBHOOK || "https://hook.eu1.make.com/1o3ll8fvbtyewn9wyfrax5sd9ywofnln";
  if (!to || !hook) return;
  // Dedup: één mail per order.
  try {
    const d = await kv(["SET", "ord:" + (o.id || ""), "1", "EX", "604800", "NX"]);
    if (d.configured && d.result !== "OK") return;
  } catch (e) {}
  const tier = (o.metadata && o.metadata.tier) || "basis";
  const interval = (o.metadata && o.metadata.interval) === "year" ? "year" : "month";
  const days = (o.metadata && o.metadata.period_days) || (interval === "year" ? "365" : "30");
  const label = ORDER_LABEL[tier] || tier;
  const cust = o.customer_details || {};
  const addr = cust.address || {};
  const addrLine = [addr.line1, addr.postal_code, addr.city, addr.country].filter(Boolean).join(", ");
  let when = new Date().toISOString();
  try { when = new Date().toLocaleString("nl-NL", { timeZone: "Europe/Amsterdam" }); } catch (e) {}
  const subject = "Nieuwe bestelling: HybridFuelCo " + label + " (" + days + " dagen), " + eur(o.amount_total);
  const html =
    "<div style='font-family:Arial,sans-serif;color:#141215;max-width:560px;line-height:1.6'>" +
    "<h2 style='color:#E11D48;margin:0 0 12px'>Nieuwe bestelling</h2>" +
    "<table style='border-collapse:collapse;font-size:14px'>" +
    orderRow("Pakket", "HybridFuelCo " + label + " (" + days + " dagen toegang)") +
    orderRow("Bedrag", eur(o.amount_total) + " " + (o.currency || "eur").toUpperCase()) +
    orderRow("Interval", interval === "year" ? "Jaar" : "Maand") +
    orderRow("Klant", (cust.name || "-") + " (" + (cust.email || "-") + ")") +
    (addrLine ? orderRow("Adres", addrLine) : "") +
    orderRow("Order-ID", o.id || "-") +
    orderRow("Payment intent", o.payment_intent || "-") +
    orderRow("Datum", when) +
    "</table>" +
    "<p style='font-size:13px;color:#67646E;margin-top:14px'>Automatisch verstuurd bij een geslaagde betaling.</p></div>";
  try {
    await fetch(hook, { method: "POST", headers: { "Content-Type": "application/json" }, body: JSON.stringify({ to, subject, html }) });
  } catch (e) {}
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
    if (evt.type === "checkout.session.completed" && o && (o.mode === "payment" || o.mode === "subscription")) {
      let userId = o.client_reference_id || (o.metadata && o.metadata.user_id);
      const email = ((o.customer_details && o.customer_details.email) || o.customer_email || "").toLowerCase();
      if (!userId) {
        // Publieke 2-klik flow: geen account vooraf. Maak/zoek de user op e-mail en mail een inlog-link.
        userId = await findOrCreateUser(email);
        if (userId && o.subscription) await setStripeSubMeta(o.subscription, userId);
        if (userId && email) await sendMagicLink(email);
      }
      if (o.mode === "payment") {
        // Eenmalige betaling: geef toegang voor de gekochte periode (metadata.period_days).
        const tier = (o.metadata && o.metadata.tier) || "basis";
        const days = parseInt((o.metadata && o.metadata.period_days) || "30", 10) || 30;
        const until = new Date(Date.now() + days * 86400000).toISOString();
        db = await setSub(userId, {
          stripe_customer_id: o.customer || null,
          stripe_subscription_id: null,
          tier,
          status: "active",
          interval: (o.metadata && o.metadata.interval) || null,
          current_period_end: until,
          cancel_at_period_end: false,
        });
      } else {
        // Legacy doorlopend abonnement (mocht er nog een bestaan).
        const st = o.subscription ? await fetchSubState(o.subscription) : null;
        db = await setSub(userId, {
          stripe_customer_id: o.customer || (st && st.customer) || null,
          stripe_subscription_id: o.subscription || null,
          tier: (st && st.tier) || (o.metadata && o.metadata.tier) || "basis",
          status: (st && st.status) || "active",
          interval: st ? st.interval : null,
          current_period_end: st ? st.periodEnd : null,
          cancel_at_period_end: st ? st.cancelAtPeriodEnd : false,
        });
      }
      // Bestelmelding naar de eigenaar (faalt nooit de webhook).
      await sendOrderNotification(o);
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
    } else if (evt.type === "charge.refunded" && o) {
      // Volledige terugbetaling → toegang direct intrekken. Gedeeltelijke refund laat toegang staan.
      const amount = typeof o.amount === "number" ? o.amount : null;
      const refunded = typeof o.amount_refunded === "number" ? o.amount_refunded : null;
      const fully = o.refunded === true || (amount !== null && refunded !== null && refunded >= amount);
      if (!fully) {
        db = { skipped: "partial_refund", amount, refunded };
      } else {
        let userId = (o.metadata && o.metadata.user_id) || null;
        if (!userId && o.customer) userId = await findUserByCustomer(o.customer);
        db = userId
          ? await setSub(userId, { tier: "free", status: "canceled", cancel_at_period_end: false, current_period_end: new Date().toISOString() })
          : { ok: false, reason: "refund_no_user", customer: o.customer || null };
      }
    }
  } catch (err) {
    console.error("stripe-webhook handler error", err);
    db = { ok: false, reason: "handler_error", message: String(err && err.message || err).slice(0, 200) };
  }

  // db wordt teruggegeven zodat de oorzaak zichtbaar is in het Stripe-antwoord (debug).
  return res.status(200).json({ received: true, db });
}
