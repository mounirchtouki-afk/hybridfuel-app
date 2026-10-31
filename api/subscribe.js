// /api/subscribe — slaat een e-mailadres op voor je nieuwsbrief/weggever.
//
// Werkt op twee manieren (kies er één, zet de env-vars in Vercel):
//   1) MailerLite (aanrader — gratis, en je kunt er later mee mailen):
//        MAILERLITE_API_KEY   = je MailerLite API-token
//        MAILERLITE_GROUP_ID  = id van de groep "HybridFuel Leads"
//   2) Of een webhook (Make.com / Zapier → Google Sheet):
//        SUBSCRIBE_WEBHOOK    = de webhook-URL
//
// Zonder config werkt de app gewoon (de bezoeker krijgt de gratis gids te zien),
// maar wordt het adres NIET opgeslagen. Stel dus eerst één van de twee in.

import { ipLimited } from "./_ratelimit.js";

export default async function handler(req, res) {
  if (req.method !== "POST") {
    res.setHeader("Allow", "POST");
    return res.status(405).json({ error: "Method not allowed" });
  }

  let body = req.body;
  if (typeof body === "string") { try { body = JSON.parse(body); } catch (e) { body = {}; } }
  const email = ((body && body.email) || "").trim().toLowerCase();
  const lang = (body && body.lang) === "nl" ? "nl" : "en";
  // Nieuwsbrief aan/uit (voorheen /api/newsletter): aanwezig = toggle, afwezig = lead-add.
  const hasOn = body && typeof body.on === "boolean";
  const on = hasOn ? body.on : true;

  // Simpele validatie
  if (!/^[^@\s]+@[^@\s]+\.[^@\s]+$/.test(email)) {
    return res.status(400).json({ error: "Invalid email" });
  }

  // Backstop tegen bulk-inschrijven vanaf één IP (lijstvervuiling / quota-misbruik).
  if (await ipLimited(req, "subscribe", 12, 3600)) {
    return res.status(429).json({ error: "Too many requests" });
  }

  const ML_KEY = process.env.MAILERLITE_API_KEY;
  const ML_GROUP = process.env.MAILERLITE_GROUP_ID;
  const WEBHOOK = process.env.SUBSCRIBE_WEBHOOK;

  try {
    if (ML_KEY) {
      // MailerLite — nieuwe (connect) API
      const payload = {
        email,
        fields: { source: "app", language: lang },
      };
      if (hasOn) payload.status = on ? "active" : "unsubscribed";
      if (ML_GROUP && on) payload.groups = [ML_GROUP];
      const r = await fetch("https://connect.mailerlite.com/api/subscribers", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer " + ML_KEY,
        },
        body: JSON.stringify(payload),
      });
      if (!r.ok && r.status !== 200 && r.status !== 201) {
        const txt = await r.text().catch(() => "");
        console.error("MailerLite error", r.status, txt);
        // Val niet hard — de bezoeker krijgt zijn gids toch.
        return res.status(200).json({ ok: true, stored: false });
      }
      return res.status(200).json({ ok: true, stored: true });
    }

    if (WEBHOOK) {
      await fetch(WEBHOOK, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ email, lang, newsletter: on, ts: new Date().toISOString() }),
      }).catch(() => {});
      return res.status(200).json({ ok: true, stored: true });
    }

    // Niets geconfigureerd: app werkt, maar nog niet opgeslagen.
    console.warn("subscribe: geen MAILERLITE_API_KEY of SUBSCRIBE_WEBHOOK ingesteld — adres niet opgeslagen:", email);
    return res.status(200).json({ ok: true, stored: false });
  } catch (err) {
    console.error("subscribe error", err);
    // Nog steeds 200 zodat de bezoeker de gratis gids krijgt.
    return res.status(200).json({ ok: true, stored: false });
  }
}
