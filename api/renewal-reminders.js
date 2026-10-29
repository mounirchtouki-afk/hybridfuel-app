// /api/renewal-reminders — dagelijkse Vercel Cron-job (zie vercel.json).
// Twee segmenten in één run:
//   A) VERLENG-herinnering: eenmalige toegang die binnen ~5 dagen afloopt.
//      Mail met 30-dagen-verleng (trouwkorting) + jaar-upsell.
//   B) WIN-BACK + FEEDBACK: toegang die ~2-3 dagen GELEDEN is afgelopen en
//      niet verlengd (anders stond current_period_end in de toekomst). Mail
//      met link naar het feedbackformulier + een terugkom-aanbod.
// Beide POST'en per klant naar een Make-webhook (die 'm via Gmail verstuurt).
// Dedup via KV zodat niemand dezelfde mail twee keer krijgt.
//
// Env-vars (optioneel, met fallback):
//   SUPABASE_SERVICE_ROLE_KEY   (verplicht — lezen van subscriptions + e-mail)
//   UNLOCK_SECRET               (handmatig aanroepen: ?key=<secret>; Cron hoeft dat niet)
//   RENEWAL_WEBHOOK             (Make-webhook; valt terug op de vaste URL hieronder)
//   PUBLIC_SITE_URL             (website met het feedbackformulier; default www.hybridfuelco.com)
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
function siteBase() {
  return (process.env.PUBLIC_SITE_URL || "https://www.hybridfuelco.com").replace(/\/$/, "");
}

const RENEWAL_WEBHOOK = process.env.RENEWAL_WEBHOOK || "https://hook.eu1.make.com/1o3ll8fvbtyewn9wyfrax5sd9ywofnln";
const RENEW_PRICE = { basis: "€8,95", pro: "€13,45" };
const YEAR_PRICE = { basis: "€99,50", pro: "€149,50" };
const MONTH_PRICE = { basis: "€9,95", pro: "€14,95" };
const LABEL = { basis: "Basic", pro: "Pro" };

function btn(href, label, primary) {
  const bg = primary ? "#E11D48" : "#ffffff";
  const col = primary ? "#ffffff" : "#E11D48";
  return "<a href='" + href + "' style='display:inline-block;background:" + bg + ";color:" + col +
    ";text-decoration:none;font-weight:bold;padding:12px 22px;border-radius:8px;border:1px solid #E11D48'>" + label + "</a>";
}

// --- Segment A: verleng-mail (30 dagen + jaar-upsell) ---
function renewHtml(lang, tier, interval, monthLink, yearLink) {
  const label = LABEL[tier];
  const renewMonth = RENEW_PRICE[tier], monthNormal = MONTH_PRICE[tier], yearPrice = YEAR_PRICE[tier];
  const wrap = function (inner) {
    return "<div style='font-family:Arial,Helvetica,sans-serif;color:#141215;max-width:560px;line-height:1.6'>" + inner +
      "<p style='font-size:14px;color:#67646E'>" + (lang === "nl"
        ? "Veilig betalen met iDEAL. Geen automatische afschrijving, jij houdt de controle."
        : "Pay securely with iDEAL. No automatic charges, you stay in control.") + "</p>" +
      "<p>Fuel the work.<br>HybridFuelCo</p></div>";
  };
  if (lang === "nl") {
    if (interval === "year") {
      return wrap(
        "<p>Hoi,</p>" +
        "<p>Je HybridFuelCo " + label + "-jaartoegang loopt binnenkort af. Verleng nu, dan blijven je weekplan, recepten en tracking gewoon doorlopen.</p>" +
        "<p><strong>Verleng je jaar voor " + yearPrice + ".</strong></p>" +
        "<p>" + btn(yearLink, "Verleng een jaar met iDEAL", true) + "</p>");
    }
    return wrap(
      "<p>Hoi,</p>" +
      "<p>Je HybridFuelCo " + label + "-toegang loopt binnenkort af. Verleng nu, dan blijven je weekplan, recepten en tracking gewoon doorlopen.</p>" +
      "<p><strong>Trouwkorting: verleng 30 dagen voor " + renewMonth + " i.p.v. " + monthNormal + ".</strong></p>" +
      "<p>" + btn(monthLink, "Verleng 30 dagen met iDEAL", true) + "</p>" +
      "<div style='background:#F7F6F4;border-left:3px solid #E11D48;padding:14px 16px;border-radius:0 8px 8px 0;margin:18px 0'>" +
        "<p style='margin:0 0 10px'><strong>Slimmer: pak meteen een heel jaar.</strong><br>Een jaar kost " + yearPrice + ", oftewel 2 maanden gratis. Nooit meer tussendoor verlengen, het hele seizoen door.</p>" +
        "<p style='margin:0'>" + btn(yearLink, "Pak 1 jaar voor " + yearPrice, false) + "</p>" +
      "</div>");
  }
  if (interval === "year") {
    return wrap(
      "<p>Hi,</p>" +
      "<p>Your HybridFuelCo " + label + " yearly access is about to end. Renew now to keep your week plan, recipes and tracking running.</p>" +
      "<p><strong>Renew your year for " + yearPrice + ".</strong></p>" +
      "<p>" + btn(yearLink, "Renew a year with iDEAL", true) + "</p>");
  }
  return wrap(
    "<p>Hi,</p>" +
    "<p>Your HybridFuelCo " + label + " access is about to end. Renew now to keep your week plan, recipes and tracking running.</p>" +
    "<p><strong>Loyalty discount: renew 30 days for " + renewMonth + " instead of " + monthNormal + ".</strong></p>" +
    "<p>" + btn(monthLink, "Renew 30 days with iDEAL", true) + "</p>" +
    "<div style='background:#F7F6F4;border-left:3px solid #E11D48;padding:14px 16px;border-radius:0 8px 8px 0;margin:18px 0'>" +
      "<p style='margin:0 0 10px'><strong>Smarter: grab a full year.</strong><br>A year is " + yearPrice + ", that is 2 months free. No more renewing in between, all season long.</p>" +
      "<p style='margin:0'>" + btn(yearLink, "Get 1 year for " + yearPrice, false) + "</p>" +
    "</div>");
}

// --- Segment B: win-back + feedback ---
function winbackHtml(lang, tier, feedbackLink, rebuyLink) {
  const renewMonth = RENEW_PRICE[tier];
  const wrap = function (inner) {
    return "<div style='font-family:Arial,Helvetica,sans-serif;color:#141215;max-width:560px;line-height:1.6'>" + inner +
      "<p>Fuel the work.<br>HybridFuelCo</p></div>";
  };
  if (lang === "nl") {
    return wrap(
      "<p>Hoi,</p>" +
      "<p>Je HybridFuelCo-toegang is een paar dagen geleden gestopt. Jammer dat je weg bent.</p>" +
      "<p>Mogen we je 30 seconden vragen? Eén eerlijk antwoord helpt ons de app echt beter te maken.</p>" +
      "<p>" + btn(feedbackLink, "Vertel ons waarom", true) + "</p>" +
      "<div style='background:#F7F6F4;border-left:3px solid #E11D48;padding:14px 16px;border-radius:0 8px 8px 0;margin:18px 0'>" +
        "<p style='margin:0 0 10px'>Toch terug? Je plan, recepten en tracking staan klaar. Als welkom-terug pak je 30 dagen voor " + renewMonth + ".</p>" +
        "<p style='margin:0'>" + btn(rebuyLink, "Weer toegang, " + renewMonth, false) + "</p>" +
      "</div>" +
      "<p style='font-size:14px;color:#67646E'>Geen zin om terug te komen? Dan hoor je verder niets meer van ons hierover.</p>");
  }
  return wrap(
    "<p>Hi,</p>" +
    "<p>Your HybridFuelCo access ended a few days ago. Sorry to see you go.</p>" +
    "<p>Can we have 30 seconds? One honest answer helps us make the app genuinely better.</p>" +
    "<p>" + btn(feedbackLink, "Tell us why", true) + "</p>" +
    "<div style='background:#F7F6F4;border-left:3px solid #E11D48;padding:14px 16px;border-radius:0 8px 8px 0;margin:18px 0'>" +
      "<p style='margin:0 0 10px'>Want back in? Your plan, recipes and tracking are ready. As a welcome back, get 30 days for " + renewMonth + ".</p>" +
      "<p style='margin:0'>" + btn(rebuyLink, "Get access, " + renewMonth, false) + "</p>" +
    "</div>" +
    "<p style='font-size:14px;color:#67646E'>Not coming back? You will not hear from us about this again.</p>");
}

async function fetchRows(url, svc, fromISO, toISO) {
  try {
    const q = "/rest/v1/subscriptions?select=user_id,tier,interval,current_period_end" +
      "&status=eq.active&tier=neq.free" +
      "&current_period_end=gte." + encodeURIComponent(fromISO) +
      "&current_period_end=lt." + encodeURIComponent(toISO) + "&limit=500";
    const r = await fetch(url + q, { headers: { apikey: svc, Authorization: "Bearer " + svc } });
    if (r.ok) return await r.json().catch(() => []);
  } catch (e) {}
  return [];
}

async function userInfo(url, svc, uid) {
  let email = "", lang = "en";
  try {
    const ur = await fetch(url + "/auth/v1/admin/users/" + encodeURIComponent(uid), { headers: { apikey: svc, Authorization: "Bearer " + svc } });
    if (ur.ok) { const u = await ur.json().catch(() => ({})); email = (u && u.email) || ""; lang = (u && u.user_metadata && u.user_metadata.lang) || "en"; }
  } catch (e) {}
  return { email, lang };
}

async function dedup(key, ttlSec) {
  const d = await kv(["SET", key, "1", "EX", String(ttlSec), "NX"]);
  // configured + niet "OK" => al verstuurd. Zonder KV (niet configured) => altijd doorsturen.
  return !(d.configured && d.result !== "OK");
}

export default async function handler(req, res) {
  const secret = process.env.UNLOCK_SECRET;
  const authed = req.headers["x-vercel-cron"] || (secret && req.query && req.query.key === secret);
  if (!authed) return res.status(401).json({ error: "unauthorized" });

  const url = supaBase();
  const svc = process.env.SUPABASE_SERVICE_ROLE_KEY;
  if (!url || !svc) return res.status(503).json({ error: "not_configured" });

  const now = Date.now();
  const base = appBase(req);
  const site = siteBase();
  const out = { ok: true, renew: { candidates: 0, sent: 0, skipped: 0 }, winback: { candidates: 0, sent: 0, skipped: 0 } };

  // --- Segment A: verleng-herinnering (afloop over ~4-6 dagen) ---
  const aFrom = new Date(now + 4 * 86400000).toISOString();
  const aTo = new Date(now + 6 * 86400000).toISOString();
  const aRows = await fetchRows(url, svc, aFrom, aTo);
  out.renew.candidates = aRows.length;
  for (const row of aRows) {
    const uid = row.user_id, pend = row.current_period_end;
    if (!uid || !pend) continue;
    if (!(await dedup("rr:" + uid + ":" + String(pend).slice(0, 10), 1728000))) { out.renew.skipped++; continue; }
    const { email, lang } = await userInfo(url, svc, uid);
    if (!email) { out.renew.skipped++; continue; }
    const tier = row.tier === "pro" ? "pro" : "basis";
    const interval = row.interval === "year" ? "year" : "month";
    const monthLink = base + "/api/create-subscription?tier=" + tier + "&interval=month&renew=1&email=" + encodeURIComponent(email);
    const yearLink = base + "/api/create-subscription?tier=" + tier + "&interval=year&email=" + encodeURIComponent(email);
    const html = renewHtml(lang, tier, interval, monthLink, yearLink);
    const subject = lang === "nl" ? "Je HybridFuelCo-toegang loopt bijna af" : "Your HybridFuelCo access is about to end";
    try {
      await fetch(RENEWAL_WEBHOOK, { method: "POST", headers: { "Content-Type": "application/json" }, body: JSON.stringify({ to: email, subject, html }) });
      out.renew.sent++;
    } catch (e) { out.renew.skipped++; }
  }

  // --- Segment B: win-back + feedback (afgelopen 2-3 dagen geleden, niet verlengd) ---
  const bFrom = new Date(now - 3 * 86400000).toISOString();
  const bTo = new Date(now - 2 * 86400000).toISOString();
  const bRows = await fetchRows(url, svc, bFrom, bTo);
  out.winback.candidates = bRows.length;
  for (const row of bRows) {
    const uid = row.user_id, pend = row.current_period_end;
    if (!uid || !pend) continue;
    if (!(await dedup("wb:" + uid + ":" + String(pend).slice(0, 10), 2592000))) { out.winback.skipped++; continue; }
    const { email, lang } = await userInfo(url, svc, uid);
    if (!email) { out.winback.skipped++; continue; }
    const tier = row.tier === "pro" ? "pro" : "basis";
    const feedbackLink = site + "/feedback.html?lang=" + (lang === "nl" ? "nl" : "en");
    const rebuyLink = base + "/api/create-subscription?tier=" + tier + "&interval=month&renew=1&email=" + encodeURIComponent(email);
    const html = winbackHtml(lang, tier, feedbackLink, rebuyLink);
    const subject = lang === "nl" ? "Je bent weg, mogen we vragen waarom?" : "You are gone, may we ask why?";
    try {
      await fetch(RENEWAL_WEBHOOK, { method: "POST", headers: { "Content-Type": "application/json" }, body: JSON.stringify({ to: email, subject, html }) });
      out.winback.sent++;
    } catch (e) { out.winback.skipped++; }
  }

  return res.status(200).json(out);
}
