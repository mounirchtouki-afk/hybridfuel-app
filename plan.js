// Backend-proxy naar Claude. Draait serverzijdig op Vercel.
// De API-key zit in een environment variable (ANTHROPIC_API_KEY), NOOIT in de frontend.
// De frontend stuurt alleen ingevulde velden; deze functie bouwt de prompt zelf.

const ACTIVITY = { light: 1.375, moderate: 1.55, high: 1.725, athlete: 1.9 };
const GOAL_ADJ = { cut: -0.2, maintain: 0, gain: 0.12 };

// --- Simpele rate-limit (per IP, per dag) --------------------------------
// In-memory: reset bij elke nieuwe serverstart. Genoeg om misbruik af te remmen.
// Voor echt zware bescherming later Upstash/Redis, maar dit + de spend-cap volstaat om te starten.
const MAX_PER_DAY = 15;
const hits = new Map(); // ip -> { day, count }

function rateLimited(ip) {
  const today = new Date().toISOString().slice(0, 10);
  const rec = hits.get(ip);
  if (!rec || rec.day !== today) {
    hits.set(ip, { day: today, count: 1 });
    return false;
  }
  if (rec.count >= MAX_PER_DAY) return true;
  rec.count += 1;
  return false;
}

// --- Invoer opschonen -----------------------------------------------------
function clampNum(v, min, max, dflt) {
  const n = parseFloat(v);
  if (isNaN(n)) return dflt;
  return Math.min(max, Math.max(min, n));
}
function pick(v, allowed, dflt) {
  return allowed.includes(v) ? v : dflt;
}
function cleanStr(v, max) {
  return typeof v === "string" ? v.slice(0, max).replace(/[<>]/g, "") : "";
}

function computeTargets(b) {
  const kg = clampNum(b.weight, 35, 300, 80);
  const cm = clampNum(b.height, 120, 230, 180);
  const age = clampNum(b.age, 14, 100, 35);
  const sex = pick(b.sex, ["male", "female"], "male");
  const activity = pick(b.activity, Object.keys(ACTIVITY), "moderate");
  const goal = pick(b.goal, Object.keys(GOAL_ADJ), "maintain");

  const bmr = sex === "male"
    ? 10 * kg + 6.25 * cm - 5 * age + 5
    : 10 * kg + 6.25 * cm - 5 * age - 161;
  const maintenance = Math.round((bmr * ACTIVITY[activity]) / 10) * 10;
  const kcal = Math.round((maintenance * (1 + GOAL_ADJ[goal])) / 10) * 10;
  const protein = Math.round(kg * 2.0);
  const fat = Math.round(kg * 0.9);
  const carbs = Math.max(40, Math.round((kcal - protein * 4 - fat * 9) / 4));
  return { kcal, protein, carbs, fat, maintenance, kg };
}

function buildPrompt(b, t) {
  const diet = cleanStr(b.diet, 40) || "No restriction";
  const avoid = cleanStr(b.avoid, 200) || "nothing specific";
  const likes = cleanStr(b.likes, 200);
  const proteins = Array.isArray(b.proteins) ? b.proteins.slice(0, 10).map((x) => cleanStr(x, 30)).join(", ") : "";
  const cuisines = Array.isArray(b.cuisines) ? b.cuisines.slice(0, 10).map((x) => cleanStr(x, 30)).join(", ") : "";
  const labels = Array.isArray(b.labels) ? b.labels.slice(0, 4).map((x) => cleanStr(x, 6)) : ["D1"];
  const week = clampNum(b.weekIndex, 0, 5, 0);

  const prefs = [];
  if (likes) prefs.push(`Loves / wants included: ${likes}`);
  if (proteins) prefs.push(`Preferred proteins: ${proteins}`);
  if (cuisines) prefs.push(`Cuisine leaning: ${cuisines}`);
  const prefText = prefs.length ? prefs.join(". ") + "." : "No strong preferences.";

  return `You are a sports nutrition coach. Build distinct meal-days labelled: ${labels.join(", ")}.

Daily targets per day: ${t.kcal} kcal, ${t.protein}g protein, ${t.carbs}g carbs, ${t.fat}g fat.
Diet: ${diet}. Avoid: ${avoid}.
Preferences: ${prefText}
Week ${week + 1}. Make the labelled days differ from each other.

Rules:
- 4 meals/day: Breakfast, Lunch, Dinner, Snack.
- For EACH meal list 2-4 main ingredients with weights in grams.
- Each meal's kcal and p/c/f MUST match the listed ingredient weights.
- Each day's meals should sum close to the daily targets.
- Lean into the preferred foods, proteins and cuisines. Short ingredient names.

Return ONLY valid JSON, no markdown, exactly this shape:
{"days":[{"d":"${labels[0]}","m":[{"t":"Breakfast","n":"Name","kcal":0,"p":0,"c":0,"f":0,"ing":[{"n":"Oats","g":60}]}]}]}`;
}

export default async function handler(req, res) {
  // CORS niet nodig: frontend en backend draaien op hetzelfde Vercel-domein.
  if (req.method !== "POST") {
    return res.status(405).json({ error: "Method not allowed" });
  }

  const ip = (req.headers["x-forwarded-for"] || "unknown").split(",")[0].trim();
  if (rateLimited(ip)) {
    return res.status(429).json({ error: "Dagelijkse limiet bereikt. Probeer morgen opnieuw." });
  }

  const key = process.env.ANTHROPIC_API_KEY;
  if (!key) {
    return res.status(500).json({ error: "Server mist API-key (ANTHROPIC_API_KEY)." });
  }

  try {
    const body = typeof req.body === "string" ? JSON.parse(req.body) : req.body || {};
    const targets = computeTargets(body);
    const prompt = buildPrompt(body, targets);

    const r = await fetch("https://api.anthropic.com/v1/messages", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "x-api-key": key,
        "anthropic-version": "2023-06-01",
      },
      body: JSON.stringify({
        model: "claude-sonnet-4-6",
        max_tokens: 1200,
        messages: [{ role: "user", content: prompt }],
      }),
    });

    if (!r.ok) {
      const txt = await r.text();
      return res.status(502).json({ error: "AI-aanroep mislukt (" + r.status + ")", detail: txt.slice(0, 200) });
    }

    const data = await r.json();
    let text = (data.content || []).filter((x) => x.type === "text").map((x) => x.text).join("").trim();
    text = text.replace(/```json/gi, "").replace(/```/g, "").trim();

    let plan;
    try {
      plan = JSON.parse(text);
    } catch (e) {
      return res.status(502).json({ error: "Antwoord onleesbaar (mogelijk afgekapt).", detail: text.slice(0, 120) });
    }

    // Stuur plan + de serverzijdig berekende targets terug.
    return res.status(200).json({ targets, plan });
  } catch (e) {
    return res.status(500).json({ error: "Serverfout", detail: String(e).slice(0, 200) });
  }
}
