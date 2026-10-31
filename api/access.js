// /api/access — toegangs-QR in één functie (Vercel Hobby staat max 12 functies toe).
//   POST { authToken }            -> mint een kortlevend (90s), ondertekend token  (voor de app)
//   POST { token } / GET ?token=  -> verifieer het token                            (voor de deurscanner)
//
// Ondertekening met ACCESS_QR_SECRET of fallback op UNLOCK_SECRET (geen nieuwe env nodig).

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

function verifyToken(token, sec) {
  const parts = (token || "").toString().trim().split(".");
  if (parts.length !== 3 || parts[0] !== "HF1") return { ok: false, error: "bad_token" };
  const expect = b64url(crypto.createHmac("sha256", sec).update(parts[1]).digest());
  let good = false;
  try { good = crypto.timingSafeEqual(Buffer.from(parts[2]), Buffer.from(expect)); } catch (e) { good = false; }
  if (!good) return { ok: false, error: "bad_sig" };
  let data = {};
  try { data = JSON.parse(Buffer.from(parts[1].replace(/-/g, "+").replace(/_/g, "/"), "base64").toString()); }
  catch (e) { return { ok: false, error: "bad_payload" }; }
  if (!data.exp || data.exp < Math.floor(Date.now() / 1000)) return { ok: false, error: "expired" };
  return { ok: true, uid: data.uid, exp: data.exp };
}

export default async function handler(req, res) {
  const sec = secret();
  if (!sec) return res.status(503).json({ ok: false, error: "not_configured" });

  let body = req.body;
  if (typeof body === "string") { try { body = JSON.parse(body); } catch (e) { body = {}; } }
  body = body || {};
  const qtoken = (req.query && req.query.token) || "";
  const token = (body.token || qtoken || "").toString().trim();

  // --- Verifieer-modus (deurscanner): er is een token meegegeven ---
  if (token) {
    if (await ipLimited(req, "access-verify", 120, 3600)) return res.status(429).json({ ok: false, error: "rate_limited" });
    return res.status(200).json(verifyToken(token, sec));
  }

  // --- Mint-modus (app): ingelogd lid vraagt een nieuwe QR ---
  if (req.method !== "POST") { res.setHeader("Allow", "POST"); return res.status(405).json({ error: "Method not allowed" }); }
  if (await ipLimited(req, "access-token", 60, 3600)) return res.status(429).json({ error: "rate_limited" });

  const authToken = (body.authToken || "").toString().trim();
  if (!authToken) return res.status(401).json({ error: "no_auth" });
  const uid = await verifyUser(authToken);
  if (!uid) return res.status(401).json({ error: "invalid_token" });

  const ttl = 90;
  const exp = Math.floor(Date.now() / 1000) + ttl;
  const payload = b64url(JSON.stringify({ uid, exp }));
  const sig = b64url(crypto.createHmac("sha256", sec).update(payload).digest());
  return res.status(200).json({ token: "HF1." + payload + "." + sig, exp, ttl });
}
