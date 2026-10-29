// /api/subscribe — e-maillijst-acties (samengevoegd met de oude /api/newsletter
// om binnen de Vercel-functielimiet te blijven).
//
//   lead-inschrijving (default):  { email, lang }           -> opslaan + in de leadgroep
//   nieuwsbrief aan/uit:          { action:"newsletter", email, on } -> status active/unsubscribed
//
// Werkt met MailerLite (MAILERLITE_API_KEY + MAILERLITE_GROUP_ID) of een webhook
// (SUBSCRIBE_WEBHOOK). Zonder config werkt de app gewoon, maar wordt niets opgeslagen.

import { ipLimited } from "./_ratelimit.js";

export default async function handler(req, res) {
  if (req.method !== "POST") { res.setHeader("Allow", "POST"); return res.status(405).json({ error: "Method not allowed" }); }

  let body = req.body;
  if (typeof body === "string") { try { body = JSON.parse(body); } catch (e) { body = {}; } }
  const email = ((body && body.email) || "").trim().toLowerCase();
  const lang = (body && body.lang) === "nl" ? "nl" : "en";
  const isNewsletter = (body && body.action === "newsletter") || (body && typeof body.on !== "undefined");
  const on = !(body && body.on === false); // default aan

  if (!/^[^@\s]+@[^@\s]+\.[^@\s]+$/.test(email)) return res.status(400).json({ error: "Invalid email" });
  // Backstop tegen bulk vanaf één IP.
  if (await ipLimited(req, isNewsletter ? "newsletter" : "subscribe", 12, 3600)) return res.status(429).json({ error: "Too many requests" });

  const ML_KEY = process.env.MAILERLITE_API_KEY;
  const ML_GROUP = process.env.MAILERLITE_GROUP_ID;
  const WEBHOOK = process.env.SUBSCRIBE_WEBHOOK;

  try {
    if (ML_KEY) {
      const payload = { email, fields: isNewsletter ? { source: "app" } : { source: "app", language: lang } };
      if (isNewsletter) payload.status = on ? "active" : "unsubscribed";
      if (ML_GROUP && (!isNewsletter || on)) payload.groups = [ML_GROUP];
      const r = await fetch("https://connect.mailerlite.com/api/subscribers", {
        method: "POST",
        headers: { "Content-Type": "application/json", Accept: "application/json", Authorization: "Bearer " + ML_KEY },
        body: JSON.stringify(payload),
      });
      if (!r.ok && r.status !== 200 && r.status !== 201) { const txt = await r.text().catch(() => ""); console.error("MailerLite error", r.status, txt); return res.status(200).json({ ok: true, stored: false }); }
      return res.status(200).json({ ok: true, stored: true });
    }
    if (WEBHOOK) {
      const wbody = isNewsletter ? { email, newsletter: on, ts: new Date().toISOString() } : { email, lang, ts: new Date().toISOString() };
      await fetch(WEBHOOK, { method: "POST", headers: { "Content-Type": "application/json" }, body: JSON.stringify(wbody) }).catch(() => {});
      return res.status(200).json({ ok: true, stored: true });
    }
    return res.status(200).json({ ok: true, stored: false });
  } catch (err) {
    console.error("subscribe error", err);
    return res.status(200).json({ ok: true, stored: false });
  }
}
