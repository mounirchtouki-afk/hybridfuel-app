// /api/create-subscription — start een EENMALIGE betaling (Stripe Checkout, mode=payment).
//
// Geen doorlopend abonnement: je koopt toegang voor een periode (30 of 365 dagen).
// Daarna loopt het af en sturen we een verleng-herinnering. Zo werkt iDEAL native
// (geen SEPA-machtiging nodig) en voelt het niet als een maandelijkse kost.
//
// GET  = publieke flow vanaf de website: géén login, Stripe verzamelt de e-mail,
//        we redirecten direct naar de betaalpagina (2-klik checkout).
// POST = in-app flow: ingelogde gebruiker koopt; we geven de betaal-URL als JSON terug.
//
// Query/body: { tier: "basis"|"pro", interval: "month"|"year", renew?: "1", userId?, email? }
//
// Env-vars in Vercel:
//   STRIPE_SECRET_KEY   sk_live_... / sk_test_...
//   PUBLIC_APP_URL      https://app.hybridfuelco.com  (optioneel; anders uit request)

// Bedragen in centen.
const AMOUNTS = {
  "basis:month": 995, "basis:year": 9950,
  "pro:month": 1495, "pro:year": 14950,
};
// Verleng-korting: alleen op maand-verlengingen (de "speciale actie" in de herinneringsmail).
// 12x een verlenging komt nét boven het jaarbedrag uit, zodat het jaarplan de beste deal blijft.
const RENEW_AMOUNTS = { "basis:month": 895, "pro:month": 1345 };
const PERIOD_DAYS = { month: 30, year: 365 };
const LABEL = { basis: "Basic", pro: "Pro" };

function appBase(req) {
  if (process.env.PUBLIC_APP_URL) return process.env.PUBLIC_APP_URL.replace(/\/$/, "");
  const proto = (req.headers["x-forwarded-proto"] || "https").split(",")[0];
  const host = req.headers["x-forwarded-host"] || req.headers.host;
  return proto + "://" + host;
}

export default async function handler(req, res) {
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
  const renew = String(src.renew || "") === "1";
  // Alleen de in-app (POST) flow eist een ingelogde user. De publieke GET-flow niet.
  if (!isGet && !userId) return res.status(400).json({ error: "no_user" });

  const stripeKey = process.env.STRIPE_SECRET_KEY;
  const key = tier + ":" + interval;
  // Verleng-korting alleen op maand; jaar houdt altijd z'n gewone prijs.
  const amount = (renew && interval === "month" && RENEW_AMOUNTS[key]) || AMOUNTS[key];
  const periodDays = PERIOD_DAYS[interval];
  if (!stripeKey || !amount) {
    if (isGet) return res.redirect(303, appBase(req) + "/?sub=unavailable");
    return res.status(503).json({ error: "not_configured", detail: "Stripe secret key of bedrag ontbreekt." });
  }

  const base = appBase(req);
  const periodLabel = interval === "year" ? "1 year access" : "30 days access";
  const name = "HybridFuelCo " + LABEL[tier] + " — " + periodLabel;

  const params = new URLSearchParams();
  params.set("mode", "payment");
  params.set("line_items[0][quantity]", "1");
  params.set("line_items[0][price_data][currency]", "eur");
  params.set("line_items[0][price_data][unit_amount]", String(amount));
  params.set("line_items[0][price_data][product_data][name]", name);
  params.set("success_url", base + "/?sub=success&cs={CHECKOUT_SESSION_ID}");
  params.set("cancel_url", base + "/?sub=cancel");
  params.set("allow_promotion_codes", "true");
  params.set("customer_creation", "always");
  params.set("metadata[tier]", tier);
  params.set("metadata[interval]", interval);
  params.set("metadata[period_days]", String(periodDays));
  if (userId) {
    params.set("client_reference_id", userId);
    params.set("metadata[user_id]", userId);
  }
  if (email) params.set("customer_email", email);
  // Herroepingsrecht: klant gaat akkoord met directe digitale levering (afstand van herroeping).
  // Vereist een Terms-URL in Stripe (Settings -> Public business information).
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
