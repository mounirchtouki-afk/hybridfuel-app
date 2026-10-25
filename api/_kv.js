// Kleine helper voor de credit-opslag (Optie B).
// Praat via de REST-API met Vercel KV of Upstash Redis (gratis tier).
// Werkt zodra de env-vars gezet zijn; is dat niet zo, dan doet de credit-logica
// niets (de app gedraagt zich dan zoals voorheen — backward compatible).
//
// Ondersteunt beide naamgevingen:
//   Vercel KV : KV_REST_API_URL / KV_REST_API_TOKEN
//   Upstash   : UPSTASH_REDIS_REST_URL / UPSTASH_REDIS_REST_TOKEN

function kvUrl() { return process.env.KV_REST_API_URL || process.env.UPSTASH_REDIS_REST_URL; }
function kvToken() { return process.env.KV_REST_API_TOKEN || process.env.UPSTASH_REDIS_REST_TOKEN; }

export function kvConfigured() {
  return !!(kvUrl() && kvToken());
}

// cmd is een Redis-commando als array, bv. ["DECR", "cr:abc"] of
// ["SET", "cr:abc", "5", "EX", "15552000", "NX"].
export async function kv(cmd) {
  const url = kvUrl(), token = kvToken();
  if (!url || !token) return { configured: false, result: null };
  try {
    const r = await fetch(url, {
      method: "POST",
      headers: { Authorization: "Bearer " + token, "Content-Type": "application/json" },
      body: JSON.stringify(cmd),
    });
    const j = await r.json().catch(() => ({}));
    return { configured: true, ok: r.ok, result: j.result };
  } catch (e) {
    return { configured: true, ok: false, error: String(e) };
  }
}
