// /api/create-subscription — start een Stripe-abonnement (Checkout, mode=subscription).
//
// De app stuurt { userId, email, tier: "basis"|"pro", interval: "month"|"year" }.
// Wij maken een Stripe Checkout Session en geven de betaal-URL terug; de app
// stuurt de gebruiker daarheen. Na betaling vangt /api/stripe-webhook het op en
// zet de laag (tier) in Supabase.
//
// Env-vars in Vercel (prijs-IDs komen uit Stripe → Producten):
//   STRIPE_SECRET_KEY            sk_live_... of sk_test_...   (staat al)
//   STRIPE_PRICE_BASIS_MONTH     price_...   (€9,95 / maand)
//   STRIPE_PRICE_BASIS_YEAR      price_...   (€99,50 / jaar)
//   STRIPE_PRICE_PRO_MONTH       price_...   (€14,95 / maand)
//   STRIPE_PRICE_PRO_YEAR        price_...   (€149,50 / jaar)
//   PUBLIC_APP_URL               https://app.hybridfuelco.com  (optioneel; anders uit request)
//
// Zonder prijs-IDs geeft de functie een nette 503 terug en verandert er niets aan
// de bestaande eenmalige download-flow (die blijft los hiervan werken).

const PRICE_ENV = {
  "basis:month": "STRIPE_PRICE_BASIS_MONTH",
  "basis:year": "STRIPE_PRICE_BASIS_YEAR",
  "pro:month": "STRIPE_PRICE_PRO_MONTH",
  "pro:year": "STRIPE_PRICE_PRO_YEAR",
};

function appBase(req) {
  if (process.env.PUBLIC_APP_URL) return process.env.PUBLIC_APP_URL.replace(/\/$/, "");
  const proto = (req.headers["x-forwarded-proto"] || "https").split(",")[0];
  const host = req.headers["x-forwarded-host"] || req.headers.host;
  return proto + "://" + host;
}

export default async function handler(req, res) {
  if (req.method !== "POST") {
    res.setHeader("Allow", "POST");
    return res.status(405).json({ error: "Method not allowed" });
  }

  let body = req.body;
  if (typeof body === "string") { try { body = JSON.parse(body); } catch (e) { body = {}; } }
  const userId = (body && body.userId || "").trim();
  const email = (body && body.email || "").trim().toLowerCase();
  const tier = (body && body.tier) === "pro" ? "pro" : "basis";
  const interval = (body && body.interval) === "year" ? "year" : "month";

  if (!userId) return res.status(400).json({ error: "no_user" });

  const stripeKey = process.env.STRIPE_SECRET_KEY;
  const priceId = process.env[PRICE_ENV[tier + ":" + interval]];
  if (!stripeKey || !priceId) {
    return res.status(503).json({ error: "not_configured", detail: "Stripe-prijzen of secret key nog niet ingesteld." });
  }

  const base = appBase(req);
  const params = new URLSearchParams();
  params.set("mode", "subscription");
  params.set("line_items[0][price]", priceId);
  params.set("line_items[0][quantity]", "1");
  params.set("success_url", base + "/?sub=success&cs={CHECKOUT_SESSION_ID}");
  params.set("cancel_url", base + "/?sub=cancel");
  params.set("client_reference_id", userId);
  if (email) params.set("customer_email", email);
  params.set("allow_promotion_codes", "true");
  params.set("metadata[user_id]", userId);
  params.set("metadata[tier]", tier);
  params.set("subscription_data[metadata][user_id]", userId);
  params.set("subscription_data[metadata][tier]", tier);

  try {
    const r = await fetch("https://api.stripe.com/v1/checkout/sessions", {
      method: "POST",
      headers: { Authorization: "Bearer " + stripeKey, "Content-Type": "application/x-www-form-urlencoded" },
      body: params.toString(),
    });
    const s = await r.json().catch(() => ({}));
    if (!r.ok || !s.url) {
      console.error("stripe checkout error", r.status, s && s.error);
      return res.status(502).json({ error: "stripe_error", detail: (s && s.error && s.error.message) || ("status " + r.status) });
    }
    return res.status(200).json({ ok: true, url: s.url });
  } catch (err) {
    console.error("create-subscription error", err);
    return res.status(500).json({ error: "server_error" });
  }
}
