// /api/access-verify — valideert een toegangs-token van de QR. Bedoeld voor een
// deurscanner / toegangssysteem: scan de QR, POST (of GET) het token hierheen, en
// krijg {ok, uid, exp} terug. Controleert de handtekening (timing-safe) en of het
// token nog niet verlopen is. De scanner/backend beslist daarna wat te doen
// (bv. UniFi Access-deur ontgrendelen of een relay schakelen).

import crypto from "crypto";
import { ipLimited } from "./_ratelimit.js";

function secret() { return process.env.ACCESS_QR_SECRET || process.env.UNLOCK_SECRET || ""; }
function b64url(buf) { return Buffer.from(buf).toString("base64").replace(/\+/g, "-").replace(/\//g, "_").replace(/=+$/, ""); }

export default async function handler(req, res) {
  if (await ipLimited(req, "access-verify", 120, 3600)) return res.status(429).json({ ok: false, error: "rate_limited" });

  const sec = secret();
  if (!sec) return res.status(503).json({ ok: false, error: "not_configured" });

  let token = "";
  if (req.method === "GET") {
    token = (req.query && req.query.token) || "";
  } else {
    let body = req.body;
    if (typeof body === "string") { try { body = JSON.parse(body); } catch (e) { body = {}; } }
    token = (body && body.token) || "";
  }
  token = (token || "").toString().trim();

  const parts = token.split(".");
  if (parts.length !== 3 || parts[0] !== "HF1") return res.status(200).json({ ok: false, error: "bad_token" });
  const payload = parts[1], sig = parts[2];

  const expect = b64url(crypto.createHmac("sha256", sec).update(payload).digest());
  let good = false;
  try { good = crypto.timingSafeEqual(Buffer.from(sig), Buffer.from(expect)); } catch (e) { good = false; }
  if (!good) return res.status(200).json({ ok: false, error: "bad_sig" });

  let data = {};
  try { data = JSON.parse(Buffer.from(payload.replace(/-/g, "+").replace(/_/g, "/"), "base64").toString()); }
  catch (e) { return res.status(200).json({ ok: false, error: "bad_payload" }); }

  const now = Math.floor(Date.now() / 1000);
  if (!data.exp || data.exp < now) return res.status(200).json({ ok: false, error: "expired" });

  return res.status(200).json({ ok: true, uid: data.uid, exp: data.exp });
}
