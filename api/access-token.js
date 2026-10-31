// /api/access-token — geeft een kortlevend, ondertekend toegangs-token voor de
// toegangs-QR in de app. Het lid moet ingelogd zijn (Supabase access-token mee).
// De QR toont dit token; een deurscanner valideert het via /api/access-verify.
//
// Ondertekening met ACCESS_QR_SECRET, of valt terug op UNLOCK_SECRET (al gezet),
// zodat er geen nieuwe env-var nodig is. Token verloopt na 90s (dynamisch, niet
// te delen/screenshotten).

import crypto from "crypto";
import { ipLimited } from "./_ratelimit.js";

const SUPA = () => (process.env.SUPABASE_URL || process.env.VITE_SUPABASE_URL || "https://tkmyjpsmdijaalwgzqdy.supabase.co").replace(/\/$/, "");
const ANON = () => process.env.SUPABASE_ANON_KEY || process.env.VITE_SUPABASE_ANON_KEY || "sb_publishable_5CJ_waXIVhhzkkqD96iqMA_63yJJnaH";
function secret() { return process.env.ACCESS_QR_SECRET || process.env.UNLOCK_SECRET || ""; }
function b64url(buf) { return Buffer.from(buf).toString("base64").replace(/\+/g, "-").replace(/\//g, "_").replace(/=+$/, ""); }

async function verifyUser(authToken) {
  try {
    const r = await fetch(SUPA() + "/auth/v1/user", { headers: { apikey: ANON(), Authorization: "Bearer " + authToken } });
    if (!r.ok) return null;
    const u = await r.json().catch(() => ({}));
    return (u && u.id) || null;
  } catch (e) { return null; }
}

export default async function handler(req, res) {
  if (req.method !== "POST") { res.setHeader("Allow", "POST"); return res.status(405).json({ error: "Method not allowed" }); }
  if (await ipLimited(req, "access-token", 60, 3600)) return res.status(429).json({ error: "rate_limited" });

  const sec = secret();
  if (!sec) return res.status(503).json({ error: "not_configured" });

  let body = req.body;
  if (typeof body === "string") { try { body = JSON.parse(body); } catch (e) { body = {}; } }
  const authToken = (body && body.authToken || "").toString().trim();
  if (!authToken) return res.status(401).json({ error: "no_auth" });

  const uid = await verifyUser(authToken);
  if (!uid) return res.status(401).json({ error: "invalid_token" });

  const ttl = 90;
  const exp = Math.floor(Date.now() / 1000) + ttl;
  const payload = b64url(JSON.stringify({ uid, exp }));
  const sig = b64url(crypto.createHmac("sha256", sec).update(payload).digest());
  const token = "HF1." + payload + "." + sig;
  return res.status(200).json({ token, exp, ttl });
}
