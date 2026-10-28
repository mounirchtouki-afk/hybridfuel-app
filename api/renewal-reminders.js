// /api/renewal-reminders — stuurt een verleng-herinnering voor eenmalige betalingen
// die binnen ~5 dagen aflopen. Wordt dagelijks getriggerd door Vercel Cron (zie
// vercel.json). Haalt bijna-verlopen accounts uit Supabase, bouwt de mail en POST
// die per klant naar een Make-webhook (die 'm via Gmail verstuurt). Dedup via KV,
// zodat niemand twee keer dezelfde herinnering krijgt.
//
// Env-vars (optioneel, met fallback):
//   SUPABASE_SERVICE_ROLE_KEY   (verplicht — lezen van subscriptions + e-mail)
//   UNLOCK_SECRET               (handmatig aanroepen: ?key=<secret>; Cron hoeft dat niet)
//   RENEWAL_WEBHOOK             (Make-webhook; valt terug op de vaste URL hieronder)
//   KV_REST_API_URL / _TOKEN    (dedup; zonder KV stuurt hij elke run, dus KV aan laten)

import { kv } from "./_kv.js";

function supaBase() {
  return (process.env.SUPABASE_URL || process.env.VITE_SUPABASE_URL || "https://tkmyjpsmdijaalwgzqdy.supabase.co").replace(/\/$/, "");
}
function appBase(req) {
  if (process.env.PUBLIC_APP_URL) return process.env.PUBLIC_APP_URL.replace(/\/$/, "");
  const proto = (req.headers["x-forwarded-proto"] || "https").split(",")[0];
  const host = req.headers["x-forwarded-host"] || req.headers.host;
  return proto + "://" + host;
}

const RENEWAL_WEBHOOK = process.env.RENEWAL_WEBHOOK || "https://hook.eu1.make.com/1o3ll8fvbtyewn9wyfrax5sd9ywofnln";
const RENEW_PRICE = { basis: "€8,95", pro: "€13,45" };
const YEAR_PRICE = { basis: "€99,50", pro: "€149,50" };
const MONTH_PRICE = { basis: "€9,95", pro: "€14,95" };
const LABEL = { basis: "Basic", pro: "Pro" };

function emailHtml(lang, tier, interval, link, price, normal) {
  const label = LABEL[tier];
  if (lang === "nl") {
    const deal = interval === "year"
      ? "Verleng je jaar voor " + price + "."
      : "Trouwkorting: verleng maandelijks voor " + price + " i.p.v. " + normal + ".";
    return "<div style='font-family:Arial,sans-serif;color:#141215;max-width:560px;line-height:1.6'>" +
      "<p>Hoi,</p>" +
      "<p>Je HybridFuelCo " + label + "-toegang loopt binnenkort af. Verleng nu, dan blijven je weekplan, recepten en tracking gewoon doorlopen.</p>" +
      "<p><strong>" + deal + "</strong></p>" +
      "<p><a href='" + link + "' style='display:inline-block;background:#E11D48;color:#ffffff;text-decoration:none;font-weight:bold;padding:12px 22px;border-radius:8px'>Verleng met iDEAL</a></p>" +
      "<p style='font-size:14px;color:#67646E'>Veilig betalen met iDEAL. Geen automatische afschrijving, jij houdt de controle.</p>" +
      "<p>Fuel the work.<br>HybridFuelCo</p></div>";
  }
  const deal = interval === "year"
    ? "Renew your year for " + price + "."
    : "Loyalty discount: renew monthly for " + price + " instead of " + normal + ".";
  return "<div style='font-family:Arial,sans-serif;color:#141215;max-width:560px;line-height:1.6'>" +
    "<p>Hi,</p>" +
    "<p>Your HybridFuelCo " + label + " access is about to end. Renew now to keep your week plan, recipes and tracking running.</p>" +
    "<p><strong>" + deal + "</strong></p>" +
    "<p><a href='" + link + "' style='display:inline-block;background:#E11D48;color:#ffffff;text-decoration:none;font-weight:bold;padding:12px 22px;border-radius:8px'>Renew with iDEAL</a></p>" +
    "<p style='font-size:14px;color:#67646E'>Pay securely with iDEAL. No automatic charges, you stay in control.</p>" +
    "<p>Fuel the work.<br>HybridFuelCo</p></div>";
}

export default async function handler(req, res) {
  const secret = process.env.UNLOCK_SECRET;
  const authed = req.headers["x-vercel-cron"] || (secret && req.query && req.query.key === secret);
  if (!authed) return res.status(401).json({ error: "unauthorized" });

  const url = supaBase();
  const svc = process.env.SUPABASE_SERVICE_ROLE_KEY;
  if (!url || !svc) return res.status(503).json({ error: "not_configured" });

  const now = Date.now();
  const from = new Date(now + 4 * 86400000).toISOString();
  const to = new Date(now + 6 * 86400000).toISOString();

  let rows = [];
  try {
    const q = "/rest/v1/subscriptions?select=user_id,tier,interval,current_period_end" +
      "&status=eq.active&tier=neq.free" +
      "&current_period_end=gte." + encodeURIComponent(from) +
      "&current_period_end=lt." + encodeURIComponent(to) + "&limit=500";
    const r = await fetch(url + q, { headers: { apikey: svc, Authorization: "Bearer " + svc } });
    if (r.ok) rows = await r.json().catch(() => []);
  } catch (e) {}

  const base = appBase(req);
  let sent = 0, skipped = 0;
  for (const row of rows) {
    const uid = row.user_id, pend = row.current_period_end;
    if (!uid || !pend) continue;
    // Dedup: één herinnering per periode (20 dagen TTL).
    const dkey = "rr:" + uid + ":" + String(pend).slice(0, 10);
    const d = await kv(["SET", dkey, "1", "EX", "1728000", "NX"]);
    if (d.configured && d.result !== "OK") { skipped++; continue; }
    // E-mail (en taal) ophalen.
    let email = "", lang = "en";
    try {
      const ur = await fetch(url + "/auth/v1/admin/users/" + encodeURIComponent(uid), { headers: { apikey: svc, Authorization: "Bearer " + svc } });
      if (ur.ok) { const u = await ur.json().catch(() => ({})); email = (u && u.email) || ""; lang = (u && u.user_metadata && u.user_metadata.lang) || "en"; }
    } catch (e) {}
    if (!email) { skipped++; continue; }
    const tier = row.tier === "pro" ? "pro" : "basis";
    const interval = row.interval === "year" ? "year" : "month";
    const link = base + "/api/create-subscription?tier=" + tier + "&interval=" + interval + "&renew=1&email=" + encodeURIComponent(email);
    const price = interval === "year" ? YEAR_PRICE[tier] : RENEW_PRICE[tier];
    const normal = interval === "year" ? YEAR_PRICE[tier] : MONTH_PRICE[tier];
    const html = emailHtml(lang, tier, interval, link, price, normal);
    const subject = lang === "nl" ? "Je HybridFuelCo-toegang loopt bijna af" : "Your HybridFuelCo access is about to end";
    try {
      await fetch(RENEWAL_WEBHOOK, { method: "POST", headers: { "Content-Type": "application/json" }, body: JSON.stringify({ to: email, subject, html }) });
      sent++;
    } catch (e) { skipped++; }
  }
  return res.status(200).json({ ok: true, candidates: rows.length, sent, skipped });
}
