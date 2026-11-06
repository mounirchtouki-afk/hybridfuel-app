// /api/product-scan — herkent een product + voedingswaarden uit 1-4 foto's.
// Vision-model (Haiku, met Sonnet-terugval). Vult ALLEEN het formulier voor;
// de gebruiker controleert en slaat zelf op. Gegate op een ingelogde gebruiker.
// Env: ANTHROPIC_API_KEY / OPENROUTER_API_KEY, AI_PROVIDER, SUPABASE_URL, SUPABASE_ANON_KEY.

function supa() {
  const url = (process.env.SUPABASE_URL || process.env.VITE_SUPABASE_URL || "https://tkmyjpsmdijaalwgzqdy.supabase.co").replace(/\/$/, "");
  const anon = process.env.SUPABASE_ANON_KEY || process.env.VITE_SUPABASE_ANON_KEY || "sb_publishable_5CJ_waXIVhhzkkqD96iqMA_63yJJnaH";
  return { url, anon };
}

async function validUser(authToken) {
  if (!authToken || typeof authToken !== "string") return false;
  try {
    const { url, anon } = supa();
    const r = await fetch(url + "/auth/v1/user", { headers: { apikey: anon, Authorization: "Bearer " + authToken } });
    if (!r.ok) return false;
    const u = await r.json().catch(() => ({}));
    return !!(u && u.id);
  } catch (e) { return false; }
}

// data:-URL -> { media_type, data(base64) }. Alleen jpeg/png/webp, max ~5 MB elk.
function parseDataUrl(s) {
  const m = /^data:(image\/(?:jpeg|png|webp));base64,([A-Za-z0-9+/=]+)$/.exec(String(s || ""));
  if (!m) return null;
  if (m[2].length > 7000000) return null; // ~5 MB
  return { media_type: m[1], data: m[2] };
}

function parseJsonLoose(text) {
  let t = (text || "").replace(/```json/gi, "").replace(/```/g, "").trim();
  try { return JSON.parse(t); } catch (e) {
    const a = t.indexOf("{"), b = t.lastIndexOf("}");
    if (a >= 0 && b > a) { try { return JSON.parse(t.slice(a, b + 1)); } catch (e2) {} }
    return null;
  }
}

const PROMPT_NL = `Je krijgt 1-4 foto's van ÉÉN voedingsproduct (meestal de voorkant + de voedingswaardentabel).
Haal eruit: productnaam, merk, en de voedingswaarden PER 100 g (of per 100 ml): kcal, eiwit (g), koolhydraten (g), vet (g).
Regels:
- Lees de getallen uit de tabel. Staat de tabel per portie i.p.v. per 100 g, reken dan om naar per 100 g.
- Zie je een waarde niet duidelijk? Zet die op null. NOOIT een getal verzinnen of schatten.
- Geen product of geen leesbare tabel? Geef alles null en confident:false.
Antwoord UITSLUITEND als JSON, niets eromheen:
{"name":"...","brand":"...","per_100":{"kcal":123,"p":12.3,"c":4.5,"f":0.2},"confident":true}`;

const PROMPT_EN = `You get 1-4 photos of ONE food product (usually the front + the nutrition table).
Extract: product name, brand, and nutrition PER 100 g (or per 100 ml): kcal, protein (g), carbs (g), fat (g).
Rules:
- Read the numbers from the table. If it's per serving instead of per 100 g, convert to per 100 g.
- Can't read a value clearly? Set it to null. NEVER invent or estimate a number.
- No product or no readable table? Return all null and confident:false.
Reply ONLY as JSON, nothing around it:
{"name":"...","brand":"...","per_100":{"kcal":123,"p":12.3,"c":4.5,"f":0.2},"confident":true}`;

async function callAnthropicVision(imgs, lang) {
  const key = process.env.ANTHROPIC_API_KEY;
  if (!key) return { err: "ANTHROPIC_API_KEY ontbreekt" };
  const model = process.env.AI_MODEL_VISION || process.env.AI_MODEL_HAIKU || "claude-3-5-haiku-latest";
  const content = imgs.map((im) => ({ type: "image", source: { type: "base64", media_type: im.media_type, data: im.data } }));
  content.push({ type: "text", text: lang === "en" ? PROMPT_EN : PROMPT_NL });
  const r = await fetch("https://api.anthropic.com/v1/messages", {
    method: "POST",
    headers: { "Content-Type": "application/json", "x-api-key": key, "anthropic-version": "2023-06-01" },
    body: JSON.stringify({ model, max_tokens: 700, messages: [{ role: "user", content }] }),
  });
  if (!r.ok) return { err: "anthropic " + r.status, detail: (await r.text()).slice(0, 200) };
  const d = await r.json();
  return { text: (d.content || []).filter((x) => x.type === "text").map((x) => x.text).join("").trim() };
}

async function callOpenRouterVision(imgs, lang) {
  const key = process.env.OPENROUTER_API_KEY;
  if (!key) return { err: "OPENROUTER_API_KEY ontbreekt" };
  const model = process.env.AI_MODEL_VISION_OR || "anthropic/claude-3.5-haiku";
  const content = imgs.map((im) => ({ type: "image_url", image_url: { url: "data:" + im.media_type + ";base64," + im.data } }));
  content.push({ type: "text", text: lang === "en" ? PROMPT_EN : PROMPT_NL });
  const r = await fetch("https://openrouter.ai/api/v1/chat/completions", {
    method: "POST",
    headers: { "Content-Type": "application/json", Authorization: "Bearer " + key, "HTTP-Referer": "https://hybridfuelco.com", "X-Title": "HybridFuelCo" },
    body: JSON.stringify({ model, max_tokens: 700, messages: [{ role: "user", content }] }),
  });
  if (!r.ok) return { err: "openrouter " + r.status, detail: (await r.text()).slice(0, 200) };
  const d = await r.json();
  const m = d.choices && d.choices[0] && d.choices[0].message;
  let c = m && m.content; if (Array.isArray(c)) c = c.map((x) => (x && x.text) || "").join("");
  return { text: (c || "").trim() };
}

function cleanNum(v) {
  if (v == null) return null;
  const n = parseFloat(String(v).replace(",", "."));
  if (!isFinite(n) || n < 0 || n > 10000) return null;
  return Math.round(n * 10) / 10;
}

export default async function handler(req, res) {
  if (req.method !== "POST") return res.status(405).json({ error: "Method not allowed" });
  try {
    const body = typeof req.body === "string" ? JSON.parse(req.body) : req.body || {};
    const lang = body.lang === "en" ? "en" : "nl";

    if (!(await validUser(body.authToken))) {
      return res.status(401).json({ error: lang === "nl" ? "Log in om foto-herkenning te gebruiken." : "Log in to use photo recognition." });
    }

    const raw = Array.isArray(body.images) ? body.images.slice(0, 4) : [];
    const imgs = raw.map(parseDataUrl).filter(Boolean);
    if (!imgs.length) {
      return res.status(400).json({ error: lang === "nl" ? "Geen geldige foto's ontvangen." : "No valid photos received." });
    }

    const provider = (process.env.AI_PROVIDER || "anthropic").toLowerCase();
    let out = provider === "openrouter" ? await callOpenRouterVision(imgs, lang) : await callAnthropicVision(imgs, lang);
    if ((out.err || !out.text)) {
      const alt = provider === "openrouter" ? await callAnthropicVision(imgs, lang) : await callOpenRouterVision(imgs, lang);
      if (!alt.err && alt.text) out = alt;
    }
    if (out.err || !out.text) {
      return res.status(502).json({ error: lang === "nl" ? "Herkenning lukte niet. Probeer het opnieuw of vul handmatig in." : "Recognition failed. Try again or fill in manually.", detail: out.err });
    }

    const j = parseJsonLoose(out.text);
    if (!j || typeof j !== "object") {
      return res.status(502).json({ error: lang === "nl" ? "Kon de foto's niet lezen. Vul handmatig in." : "Couldn't read the photos. Fill in manually." });
    }
    const per = j.per_100 || {};
    const result = {
      name: String(j.name || "").slice(0, 120).trim(),
      brand: String(j.brand || "").slice(0, 80).trim(),
      per_100: { kcal: cleanNum(per.kcal), p: cleanNum(per.p), c: cleanNum(per.c), f: cleanNum(per.f) },
      confident: j.confident !== false,
    };
    return res.status(200).json({ result });
  } catch (e) {
    return res.status(500).json({ error: "scan_failed", detail: String(e).slice(0, 200) });
  }
}
