// /api/delete-account — verwijdert het account + alle data van de ingelogde gebruiker.
// De app stuurt de Supabase access token (JWT) mee. We verifiëren die, halen de user-id
// op, en verwijderen de auth-gebruiker via de admin-API (service role). Alle tabellen
// hebben "on delete cascade" op user_id, dus alle data gaat automatisch mee weg (AVG).
//
// Env-vars: SUPABASE_URL (of VITE_SUPABASE_URL), SUPABASE_SERVICE_ROLE_KEY,
//           SUPABASE_ANON_KEY (of VITE_SUPABASE_ANON_KEY / publishable fallback).

import { ipLimited } from "./_ratelimit.js";

export default async function handler(req, res) {
  if (req.method !== "POST") { res.setHeader("Allow", "POST"); return res.status(405).json({ error: "Method not allowed" }); }
  if (await ipLimited(req, "delete-account", 5, 3600)) return res.status(429).json({ error: "rate_limited" });
  let body = req.body;
  if (typeof body === "string") { try { body = JSON.parse(body); } catch (e) { body = {}; } }
  const authToken = (body && body.authToken || "").trim();
  if (!authToken) return res.status(401).json({ error: "no_auth" });

  const url = (process.env.SUPABASE_URL || process.env.VITE_SUPABASE_URL || "https://tkmyjpsmdijaalwgzqdy.supabase.co").replace(/\/$/, "");
  const svc = process.env.SUPABASE_SERVICE_ROLE_KEY;
  const anon = process.env.SUPABASE_ANON_KEY || process.env.VITE_SUPABASE_ANON_KEY || "sb_publishable_5CJ_waXIVhhzkkqD96iqMA_63yJJnaH";
  if (!url || !svc) return res.status(503).json({ error: "not_configured" });

  try {
    // 1) Verifieer het token en haal de user-id op.
    const ur = await fetch(url + "/auth/v1/user", { headers: { apikey: anon, Authorization: "Bearer " + authToken } });
    if (!ur.ok) return res.status(401).json({ error: "invalid_token" });
    const u = await ur.json().catch(() => ({}));
    const uid = u && u.id;
    if (!uid) return res.status(401).json({ error: "no_user" });

    // 2) Verwijder de auth-gebruiker (cascade verwijdert alle gekoppelde data).
    const dr = await fetch(url + "/auth/v1/admin/users/" + encodeURIComponent(uid), {
      method: "DELETE", headers: { apikey: svc, Authorization: "Bearer " + svc },
    });
    if (!dr.ok) { const txt = await dr.text().catch(() => ""); console.error("delete user faalde", dr.status, txt); return res.status(502).json({ error: "delete_failed" }); }
    return res.status(200).json({ ok: true });
  } catch (err) {
    console.error("delete-account error", err);
    return res.status(500).json({ error: "server_error" });
  }
}
