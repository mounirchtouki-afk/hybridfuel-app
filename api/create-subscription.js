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
  // GET = publieke flow vanaf de website: géén login, Stripe verzamelt de e-mail,
  //       en we redirecten de bezoeker direct naar de betaalpagina (2-klik checkout).
  // POST = in-app flow: ingelogde gebruiker upgradet; we geven de betaal-URL als JSON terug.
  const isGet = req.method === "GET";
  if (req.method !== "POST" && !isGet) {
    res.setHeader("Allow", "GET, POST");
    return res.status(405).json({ error: "Method not allowed" });
  }

  let body = req.body;
  if (typeof body === "string") { try { body = JSON.parse(body); } catch (e) { body = {}; } }
  const src = isGet ? (req.query || {}) : (body || {});
  const userId = (src.userId || "").toString().trim();
  const email = (src.email || "").toString().trim().toLowerCase();
  const tier = src.tier === "pro" ? "pro" : "basis";
  const interval = src.interval === "year" ? "year" : "month";
  // Alleen de in-app (POST) flow eist een ingelogde user. De publieke GET-flow niet.
  if (!isGet && !userId) return res.status(400).json({ error: "no_user" });

  const stripeKey = process.env.STRIPE_SECRET_KEY;
  const priceId = process.env[PRICE_ENV[tier + ":" + interval]];
  if (!stripeKey || !priceId) {
    if (isGet) return res.redirect(303, appBase(req) + "/?sub=unavailable");
    return res.status(503).json({ error: "not_configured", detail: "Stripe-prijzen of secret key nog niet ingesteld." });
  }

  const base = appBase(req);
  const params = new URLSearchParams();
  params.set("mode", "subscription");
  params.set("line_items[0][price]", priceId);
  params.set("line_items[0][quantity]", "1");
  params.set("success_url", base + "/?sub=success&cs={CHECKOUT_SESSION_ID}");
  params.set("cancel_url", base + "/?sub=cancel");
  params.set("allow_promotion_codes", "true");
  params.set("metadata[tier]", tier);
  params.set("subscription_data[metadata][tier]", tier);
  if (userId) {
    // Ingelogde flow: koppel meteen aan de bestaande account.
    params.set("client_reference_id", userId);
    params.set("metadata[user_id]", userId);
    params.set("subscription_data[metadata][user_id]", userId);
  }
  if (email) params.set("customer_email", email);
  // Herroepingsrecht: klant moet expliciet akkoord gaan met de voorwaarden
  // (die de afstand bij directe digitale levering bevatten). Vereist een
  // Terms-of-Service-URL in Stripe (Settings -> Public business information).
  params.set("consent_collection[terms_of_service]", "required");
  params.set("custom_text[terms_of_service_acceptance][message]",
    "I agree to immediate access to the digital service and understand my 14-day right of withdrawal ends once delivery begins.");

  try {
    const r = await fetch("https://api.stripe.com/v1/checkout/sessions", {
      method: "POST",
      headers: { Authorization: "Bearer " + stripeKey, "Content-Type": "application/x-www-form-urlencoded" },
      body: params.toString(),
    });
    const s = await r.json().catch(() => ({}));
    if (!r.ok || !s.url) {
      console.error("stripe checkout error", r.status, s && s.error);
      if (isGet) return res.redirect(303, base + "/?sub=error");
      return res.status(502).json({ error: "stripe_error", detail: (s && s.error && s.error.message) || ("status " + r.status) });
    }
    if (isGet) return res.redirect(303, s.url);
    return res.status(200).json({ ok: true, url: s.url });
  } catch (err) {
    console.error("create-subscription error", err);
    if (isGet) return res.redirect(303, appBase(req) + "/?sub=error");
    return res.status(500).json({ error: "server_error" });
  }
}
