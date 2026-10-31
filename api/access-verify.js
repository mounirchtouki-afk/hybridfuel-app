// /api/access-verify — valideert een toegangstoken dat een deur-scanner aanbiedt.
// Controleert handtekening + vervaltijd. Geeft { ok, userId } terug. De deur-kant
// (scanner -> deze endpoint -> ontgrendelen via UniFi-API of relay) is een aparte
// hardware-stap; dit endpoint is de beslisser.
//
// Secret: UNLOCK_SECRET.
import crypto from "crypto";
import { ipLimited } from "./_ratelimit.js";

export default async function handler(req, res) {
  if (req.method !== "POST") { res.setHeader("Allow", "POST"); return res.status(405).json({ ok: false, error: "Method not allowed" }); }
  if (await ipLimited(req, "access-verify", 600, 3600)) return res.status(429).json({ ok: false, error: "rate_limited" });

  let body = req.body;
  if (typeof body === "string") { try { body = JSON.parse(body); } catch (e) { body = {}; } }
  const token = (body && body.token || "").trim();
  const secret = process.env.UNLOCK_SECRET;
  if (!secret) return res.status(503).json({ ok: false, error: "not_configured" });

  const parts = token.split(".");
  if (parts.length !== 3) return res.status(400).json({ ok: false, error: "bad_token" });
  const [userId, exp, sig] = parts;

  const expected = crypto.createHmac("sha256", secret).update("access:" + userId + "." + exp).digest("hex").slice(0, 32);
  let okSig = false;
  try { okSig = crypto.timingSafeEqual(Buffer.from(sig), Buffer.from(expected)); } catch (e) { okSig = false; }
  if (!okSig) return res.status(200).json({ ok: false, error: "bad_sig" });
  if (Number(exp) < Math.floor(Date.now() / 1000)) return res.status(200).json({ ok: false, error: "expired" });

  return res.status(200).json({ ok: true, userId });
}
