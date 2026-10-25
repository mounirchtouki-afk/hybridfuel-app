// /api/billing-portal — opent het Stripe-klantportaal zodat een abonnee zelf kan
// opzeggen, wijzigen of z'n facturen kan zien.
//
// App stuurt { userId }. We halen de stripe_customer_id uit Supabase (service-role),
// maken een portaalsessie en geven de URL terug.
//
// Env-vars: STRIPE_SECRET_KEY, SUPABASE_URL (of VITE_SUPABASE_URL),
//           SUPABASE_SERVICE_ROLE_KEY, PUBLIC_APP_URL (optioneel).

function appBase(req) {
  if (process.env.PUBLIC_APP_URL) return process.env.PUBLIC_APP_URL.replace(/\/$/, "");
  const proto = (req.headers["x-forwarded-proto"] || "https").split(",")[0];
  const host = req.headers["x-forwarded-host"] || req.headers.host;
  return proto + "://" + host;
}

export default async function handler(req, res) {
  if (req.method !== "POST") { res.setHeader("Allow", "POST"); return res.status(405).end(); }

  let body = req.body;
  if (typeof body === "string") { try { body = JSON.parse(body); } catch (e) { body = {}; } }
  const userId = (body && body.userId || "").trim();
  if (!userId) return res.status(400).json({ error: "no_user" });

  const stripeKey = process.env.STRIPE_SECRET_KEY;
  const supaUrl = (process.env.SUPABASE_URL || process.env.VITE_SUPABASE_URL || "").replace(/\/$/, "");
  const svcKey = process.env.SUPABASE_SERVICE_ROLE_KEY;
  if (!stripeKey || !supaUrl || !svcKey) return res.status(503).json({ error: "not_configured" });

  try {
    const r = await fetch(supaUrl + "/rest/v1/subscriptions?select=stripe_customer_id&user_id=eq." + encodeURIComponent(userId), {
      headers: { apikey: svcKey, Authorization: "Bearer " + svcKey },
    });
    const rows = await r.json().catch(() => []);
    const customer = rows && rows[0] && rows[0].stripe_customer_id;
    if (!customer) return res.status(404).json({ error: "no_customer" });

    const params = new URLSearchParams();
    params.set("customer", customer);
    params.set("return_url", appBase(req) + "/?portal=back");
    const pr = await fetch("https://api.stripe.com/v1/billing_portal/sessions", {
      method: "POST",
      headers: { Authorization: "Bearer " + stripeKey, "Content-Type": "application/x-www-form-urlencoded" },
      body: params.toString(),
    });
    const s = await pr.json().catch(() => ({}));
    if (!pr.ok || !s.url) return res.status(502).json({ error: "stripe_error", detail: s && s.error && s.error.message });
    return res.status(200).json({ ok: true, url: s.url });
  } catch (err) {
    console.error("billing-portal error", err);
    return res.status(500).json({ error: "server_error" });
  }
}
