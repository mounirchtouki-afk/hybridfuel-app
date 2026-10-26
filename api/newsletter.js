// /api/newsletter — nieuwsbrief aan/uit zetten. App stuurt { email, on }.
// Aan = inschrijven (active), uit = uitschrijven (unsubscribed). Werkt met MailerLite
// of een webhook (zelfde config als /api/subscribe). Zonder config: app werkt gewoon,
// maar er wordt niets opgeslagen.
//
// Env-vars: MAILERLITE_API_KEY (+ MAILERLITE_GROUP_ID), of SUBSCRIBE_WEBHOOK.

export default async function handler(req, res) {
  if (req.method !== "POST") { res.setHeader("Allow", "POST"); return res.status(405).json({ error: "Method not allowed" }); }
  let body = req.body;
  if (typeof body === "string") { try { body = JSON.parse(body); } catch (e) { body = {}; } }
  const email = ((body && body.email) || "").trim().toLowerCase();
  const on = body && body.on !== false; // default aan
  if (!/^[^@\s]+@[^@\s]+\.[^@\s]+$/.test(email)) return res.status(400).json({ error: "Invalid email" });

  const ML_KEY = process.env.MAILERLITE_API_KEY;
  const ML_GROUP = process.env.MAILERLITE_GROUP_ID;
  const WEBHOOK = process.env.SUBSCRIBE_WEBHOOK;

  try {
    if (ML_KEY) {
      const payload = { email, status: on ? "active" : "unsubscribed", fields: { source: "app" } };
      if (ML_GROUP && on) payload.groups = [ML_GROUP];
      const r = await fetch("https://connect.mailerlite.com/api/subscribers", {
        method: "POST",
        headers: { "Content-Type": "application/json", Accept: "application/json", Authorization: "Bearer " + ML_KEY },
        body: JSON.stringify(payload),
      });
      if (!r.ok && r.status !== 200 && r.status !== 201) { const txt = await r.text().catch(() => ""); console.error("MailerLite newsletter error", r.status, txt); return res.status(200).json({ ok: true, stored: false }); }
      return res.status(200).json({ ok: true, stored: true });
    }
    if (WEBHOOK) {
      await fetch(WEBHOOK, { method: "POST", headers: { "Content-Type": "application/json" }, body: JSON.stringify({ email, newsletter: on, ts: new Date().toISOString() }) }).catch(() => {});
      return res.status(200).json({ ok: true, stored: true });
    }
    return res.status(200).json({ ok: true, stored: false });
  } catch (err) {
    console.error("newsletter error", err);
    return res.status(200).json({ ok: true, stored: false });
  }
}
