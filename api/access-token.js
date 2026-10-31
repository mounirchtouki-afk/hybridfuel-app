// /api/access-token — geeft een kortlevend, ondertekend toegangstoken voor de
// INGELOGDE gebruiker. De app toont dit als dynamische QR (ververst elke minuut);
// een deur-scanner POST't de gescande waarde naar /api/access-verify.
//
// Secret: UNLOCK_SECRET (zelfde als de betaal-tokens). Geen persoonsgegevens in de QR,
// alleen user-id + vervaltijd + handtekening.
import crypto from "crypto";
import { ipLimited } from "./_ratelimit.js";

async function verifyUser(authToken) {
  try {
    const url = (process.env.SUPABASE_URL || process.env.VITE_SUPABASE_URL || "https://tkmyjpsmdijaalwgzqdy.supabase.co").replace(/\/$/, "");
    const anon = process.env.SUPABASE_ANON_KEY || process.env.VITE_SUPABASE_ANON_KEY || "sb_publishable_5CJ_waXIVhhzkkqD96iqMA_63yJJnaH";
    const r = await fetch(url + "/auth/v1/user", { headers: { apikey: anon, Authorization: "Bearer " + authToken } });
    if (!r.ok) return null;
    const u = await r.json().catch(() => ({}));
    return (u && u.id) || null;
  } catch (e) { return null; }
}

export default async function handler(req, res) {
  if (req.method !== "POST") { res.setHeader("Allow", "POST"); return res.status(405).json({ error: "Method not allowed" }); }
  if (await ipLimited(req, "access-token", 120, 3600)) return res.status(429).json({ error: "rate_limited" });

  let body = req.body;
  if (typeof body === "string") { try { body = JSON.parse(body); } catch (e) { body = {}; } }
  const authToken = (body && body.authToken || "").trim();
  const secret = process.env.UNLOCK_SECRET;
  if (!secret) return res.status(503).json({ error: "not_configured" });
  if (!authToken) return res.status(401).json({ error: "no_auth" });

  const userId = await verifyUser(authToken);
  if (!userId) return res.status(401).json({ error: "invalid_token" });

  const exp = Math.floor(Date.now() / 1000) + 90; // 90s geldig (de app ververst elke 60s)
  const payload = userId + "." + exp;
  const sig = crypto.createHmac("sha256", secret).update("access:" + payload).digest("hex").slice(0, 32);
  return res.status(200).json({ token: payload + "." + sig, exp });
}
