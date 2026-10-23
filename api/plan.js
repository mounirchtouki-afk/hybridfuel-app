// Backend-proxy naar Claude. Draait serverzijdig op Vercel.
// De API-key zit in een environment variable (ANTHROPIC_API_KEY), NOOIT in de frontend.
// De frontend stuurt alleen ingevulde velden; deze functie bouwt de prompt zelf.

const ACTIVITY = { light: 1.375, moderate: 1.55, high: 1.725, athlete: 1.9 };
const GOAL_ADJ = { cut: -0.2, maintain: 0, gain: 0.12 };

// --- Simpele rate-limit (per IP, per dag) --------------------------------
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

// Basis-dagdoelen (gemiddelde dag, vóór trainings-/rustcycling).
function computeBase(b) {
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

// Houd eiwit en vet gelijk; de calorie-swing gaat naar koolhydraten (carb cycling).
function dayMacros(kcal, base) {
  const protein = base.protein;
  const fat = base.fat;
  const carbs = Math.max(40, Math.round((kcal - protein * 4 - fat * 9) / 4));
  return { kcal, protein, carbs, fat };
}

// Verdeel de week: trainingsdagen omhoog, rustdagen omlaag, weekgemiddelde = basis.
function computeCycle(base, nTrainRaw) {
  const nTrain = Math.max(0, Math.min(7, parseInt(nTrainRaw, 10) || 0));
  const nRest = 7 - nTrain;
  const baseDay = dayMacros(base.kcal, base);
  if (nTrain === 0 || nTrain === 7) {
    return { base: baseDay, train: baseDay, rest: baseDay, trainingCount: nTrain };
  }
  let restKcal = Math.round((base.kcal * 0.88) / 10) * 10;             // ~12% onder basis
  let trainKcal = Math.round(((7 * base.kcal - nRest * restKcal) / nTrain) / 10) * 10;
  const cap = Math.round((base.kcal * 1.35) / 10) * 10;
  const floor = Math.round((base.kcal * 0.8) / 10) * 10;
  if (trainKcal > cap) {
    trainKcal = cap;
    restKcal = Math.round(((7 * base.kcal - nTrain * trainKcal) / nRest) / 10) * 10;
  }
  if (restKcal < floor) restKcal = floor;
  return { base: baseDay, train: dayMacros(trainKcal, base), rest: dayMacros(restKcal, base), trainingCount: nTrain };
}

function buildPrompt(b, cyc) {
  const diet = cleanStr(b.diet, 40) || "No restriction";
  const avoid = cleanStr(b.avoid, 200) || "nothing specific";
  const likes = cleanStr(b.likes, 200);
  const proteins = Array.isArray(b.proteins) ? b.proteins.slice(0, 10).map((x) => cleanStr(x, 30)).join(", ") : "";
  const cuisines = Array.isArray(b.cuisines) ? b.cuisines.slice(0, 10).map((x) => cleanStr(x, 30)).join(", ") : "";

  // Welke dag-templates moeten we bouwen? [{label, level}] met level train/rest/base.
  let reqs = Array.isArray(b.request) ? b.request.slice(0, 3) : [{ label: "D1", level: "base" }];
  reqs = reqs.map((r) => ({ label: cleanStr(r.label, 8) || "D1", level: pick(r.level, ["train", "rest", "base"], "base") }));

  const lang = b.lang === "en" ? "en" : "nl";

  const prefs = [];
  if (likes) prefs.push(`Loves / wants included: ${likes}`);
  if (proteins) prefs.push(`Preferred proteins: ${proteins}`);
  if (cuisines) prefs.push(`Cuisine leaning: ${cuisines}`);
  const prefText = prefs.length ? prefs.join(". ") + "." : "No strong preferences.";

  const tgtFor = (lvl) => (lvl === "train" ? cyc.train : lvl === "rest" ? cyc.rest : cyc.base);
  const dayLines = reqs.map((r) => {
    const t = tgtFor(r.level);
    const tag = r.level === "train"
      ? "TRAINING DAY — higher carbs to fuel training"
      : r.level === "rest"
        ? "REST DAY — lower carbs, protein stays high"
        : "DAY";
    return `- "${r.label}" = ${tag}: ${t.kcal} kcal, ${t.protein}g protein, ${t.carbs}g carbs, ${t.fat}g fat`;
  }).join("\n");

  const L = lang === "en"
    ? {
        rule1: "- Write ALL meal names, ingredient names and meal types in ENGLISH.",
        rule2: '- 4 meals/day. Use exactly these meal types for "t": Breakfast, Lunch, Dinner, Snack.',
        ruleN: "- Lean into the preferred foods, proteins and cuisines. Short ingredient names.",
        example: '{"days":[{"d":"' + reqs[0].label + '","m":[{"t":"Breakfast","n":"Oats with quark","kcal":0,"p":0,"c":0,"f":0,"ing":[{"n":"Oats","g":60}]}]}]}',
      }
    : {
        rule1: "- Write ALL meal names, ingredient names and meal types in DUTCH (Nederlands).",
        rule2: '- 4 meals/day. Use exactly these Dutch meal types for "t": Ontbijt, Lunch, Diner, Snack.',
        ruleN: "- Lean into the preferred foods, proteins and cuisines. Short Dutch ingredient names.",
        example: '{"days":[{"d":"' + reqs[0].label + '","m":[{"t":"Ontbijt","n":"Havermout met kwark","kcal":0,"p":0,"c":0,"f":0,"ing":[{"n":"Havermout","g":60}]}]}]}',
      };

  return `You are a sports nutrition coach. Build these meal-days, each hitting ITS OWN targets:
${dayLines}

Diet: ${diet}. Avoid: ${avoid}.
Preferences: ${prefText}
Keep protein high and roughly equal on every day; put the calorie difference between training and rest days mainly into carbohydrates (rice, oats, potato, fruit). Make the days distinct and realistic to cook.

Rules:
${L.rule1}
${L.rule2}
- For EACH meal list 2-4 main ingredients with weights in grams.
- Each meal's kcal and p/c/f MUST match the listed ingredient weights.
- Each day's meals should sum close to THAT day's targets above.
${L.ruleN}

Return ONLY valid JSON, no markdown, exactly this shape (keep the JSON keys in English, set "d" to each day's label above):
${L.example}`;
}

export default async function handler(req, res) {
  if (req.method !== "POST") {
    return res.status(405).json({ error: "Method not allowed" });
  }

  const autoSecret = process.env.AUTOMATION_SECRET;
  const trusted = autoSecret && req.headers["x-automation-secret"] === autoSecret;

  try {
    const body = typeof req.body === "string" ? JSON.parse(req.body) : req.body || {};
    const base = computeBase(body);
    const cyc = computeCycle(base, body.trainingCount);
    const targets = {
      kcal: base.kcal, protein: base.protein, carbs: base.carbs, fat: base.fat,
      maintenance: base.maintenance,
      train: cyc.train, rest: cyc.rest, trainingCount: cyc.trainingCount,
    };

    // GRATIS: alleen de (formule-)targets. Geen AI, geen kosten, niets om te stapelen
    // tot een maaltijdplan. De AI-maaltijden draaien pas bij een betaalde aanvraag.
    const isPaid = body.paid === true;
    if (!trusted && !isPaid) {
      return res.status(200).json({ targets, plan: null, locked: true });
    }

    // BETAALD (of vertrouwde automatisering): AI-generatie, met rate-limit als backstop.
    if (!trusted) {
      const ip = (req.headers["x-forwarded-for"] || "unknown").split(",")[0].trim();
      if (rateLimited(ip)) {
        return res.status(429).json({ error: "Dagelijkse limiet bereikt. Probeer morgen opnieuw." });
      }
    }

    const key = process.env.ANTHROPIC_API_KEY;
    if (!key) {
      return res.status(500).json({ error: "Server mist API-key (ANTHROPIC_API_KEY)." });
    }

    const prompt = buildPrompt(body, cyc);

    const r = await fetch("https://api.anthropic.com/v1/messages", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "x-api-key": key,
        "anthropic-version": "2023-06-01",
      },
      body: JSON.stringify({
        model: "claude-sonnet-4-6",
        max_tokens: 1600,
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

    return res.status(200).json({ targets, plan });
  } catch (e) {
    return res.status(500).json({ error: "Serverfout", detail: String(e).slice(0, 200) });
  }
}
