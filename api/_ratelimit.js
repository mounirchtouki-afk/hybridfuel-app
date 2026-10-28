// Eenvoudige per-IP rate-limit via KV (Upstash/Vercel KV). Backstop tegen bulk-misbruik
// op publieke, ongeauthenticeerde endpoints (nieuwsbrief/lead-capture).
// Faalt OPEN: is er geen KV gekoppeld of hapert die, dan wordt er niet geblokkeerd,
// zodat echte bezoekers nooit onterecht vastlopen.
import { kv } from "./_kv.js";

export async function ipLimited(req, bucket, max, windowSec) {
  try {
    const ip = ((req.headers["x-forwarded-for"] || "") + "").split(",")[0].trim() || "unknown";
    const win = Math.floor(Date.now() / (windowSec * 1000));
    const key = "rl:" + bucket + ":" + ip + ":" + win;
    const r = await kv(["INCR", key]);
    if (!r.configured) return false; // geen KV -> niet limiteren
    const n = typeof r.result === "number" ? r.result : parseInt(r.result, 10);
    if (n === 1) { try { await kv(["EXPIRE", key, String(windowSec)]); } catch (e) {} }
    return n > max;
  } catch (e) { return false; }
}
