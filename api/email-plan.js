// /api/email-plan — mailt de volledige tracker (met het plan) naar het betaaladres.
// Wordt door de app aangeroepen zodra een betaalde klant een plan genereert, als
// vangnet: ze hebben hun plan altijd in hun inbox, ook als ze vergeten te downloaden.
//
// Flow: app stuurt {lang, week, shopping, token} → deze functie checkt de betaling,
// haalt het betaaladres uit Stripe, bouwt de tracker (zelfde als de download), en
// stuurt 'm base64 naar een Make-webhook die er een Gmail met bijlage van maakt.
//
// Nodig als env-var in Vercel:  EMAIL_PLAN_WEBHOOK = de Make-webhook-URL

import crypto from "crypto";
import { fillTracker } from "./tracker.js";

function tokenSid(token) {
  if (typeof token !== "string") return "";
  const i = token.lastIndexOf(".");
  return i > 0 ? token.slice(0, i) : "";
}
function validToken(token) {
  const secret = process.env.UNLOCK_SECRET;
  if (!secret) return true; // slot niet actief
  if (typeof token !== "string" || token.indexOf(".") < 0) return false;
  const i = token.lastIndexOf(".");
  const sid = token.slice(0, i), sig = token.slice(i + 1);
  const exp = crypto.createHmac("sha256", secret).update(sid).digest("hex");
  try { return sig.length === exp.length && crypto.timingSafeEqual(Buffer.from(sig), Buffer.from(exp)); }
  catch (e) { return false; }
}

export default async function handler(req, res) {
  if (req.method !== "POST") {
    res.setHeader("Allow", "POST");
    return res.status(405).json({ error: "Method not allowed" });
  }
  try {
    let body = req.body;
    if (typeof body === "string") { try { body = JSON.parse(body); } catch (e) { body = {}; } }
    const lang = (body && body.lang) === "nl" ? "nl" : "en";
    const week = body && body.week;
    const token = body && body.token;

    if (!week || !Array.isArray(week.days) || !week.days.length) {
      return res.status(400).json({ ok: false, error: "no plan" });
    }
    if (!validToken(token)) {
      return res.status(200).json({ ok: false, error: "not verified" });
    }

    const webhook = process.env.EMAIL_PLAN_WEBHOOK;
    if (!webhook) return res.status(200).json({ ok: false, emailed: false }); // nog niet gekoppeld

    // Betaaladres ophalen uit de Stripe-sessie.
    let email = "";
    const sid = tokenSid(token);
    const stripeKey = process.env.STRIPE_SECRET_KEY;
    if (sid && stripeKey) {
      try {
        const r = await fetch("https://api.stripe.com/v1/checkout/sessions/" + encodeURIComponent(sid), {
          headers: { Authorization: "Bearer " + stripeKey },
        });
        if (r.ok) { const s = await r.json(); email = (s.customer_details && s.customer_details.email) || s.customer_email || ""; }
      } catch (e) {}
    }
    if (!email) return res.status(200).json({ ok: false, emailed: false, error: "no email" });

    // Tracker bouwen (identiek aan de download) en base64 naar Make sturen.
    const tplUrl = `https://www.hybridfuelco.com/tracker-${lang}.xlsx`;
    const tr = await fetch(tplUrl);
    if (!tr.ok) return res.status(502).json({ ok: false, error: "template" });
    const buf = Buffer.from(await tr.arrayBuffer());
    const out = await fillTracker(buf, lang, week, Array.isArray(body.shopping) ? body.shopping : []);
    const fileB64 = Buffer.from(out).toString("base64");

    await fetch(webhook, {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ email, lang, filename: "HybridFuelCo_MealPlan.xlsx", file: fileB64 }),
    });

    return res.status(200).json({ ok: true, emailed: true });
  } catch (e) {
    return res.status(500).json({ ok: false, error: String(e).slice(0, 150) });
  }
}
