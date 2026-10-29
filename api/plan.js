// Backend-proxy naar Claude. Draait serverzijdig op Vercel.
// De API-key zit in een environment variable (ANTHROPIC_API_KEY), NOOIT in de frontend.
// De frontend stuurt alleen ingevulde velden; deze functie bouwt de prompt zelf.

import crypto from "crypto";
import { RECIPES, snackOptions } from "../src/recipes.js";
import { kv, kvConfigured } from "./_kv.js";

const ACTIVITY = { light: 1.375, moderate: 1.55, high: 1.725, athlete: 1.9 };
const GOAL_ADJ = { cut: -0.18, maintain: 0, gain: 0.08 }; // gelijk aan de webcalculator

// Controleert het token uit /api/verify. Is UNLOCK_SECRET niet gezet, dan is het
// slot nog niet geactiveerd en gedraagt de app zich zoals nu (paid-vlag volstaat).
// Haalt de sessie-id (= Stripe session_id) uit het token "sid.handtekening".
function tokenSid(token) {
  if (typeof token !== "string") return "";
  const i = token.lastIndexOf(".");
  return i > 0 ? token.slice(0, i) : "";
}

function validToken(token) {
  const secret = process.env.UNLOCK_SECRET;
  if (!secret) return true; // slot niet actief
  if (typeof token !== "string" || token.indexOf(".") < 0) return false;
  const i = token.lastIndexOf(".");
  const sid = token.slice(0, i);
  const sig = token.slice(i + 1);
  const exp = crypto.createHmac("sha256", secret).update(sid).digest("hex");
  try {
    return sig.length === exp.length && crypto.timingSafeEqual(Buffer.from(sig), Buffer.from(exp));
  } catch (e) {
    return false;
  }
}

// Haalt de gebruikers-id (sub-claim) uit een Supabase-JWT. Alleen gebruikt nadat
// subActive() het token al bij Supabase heeft geverifieerd, dus hier geen extra check.
function jwtSub(token) {
  try {
    const p = (token || "").split(".")[1];
    if (!p) return "";
    const json = Buffer.from(p.replace(/-/g, "+").replace(/_/g, "/"), "base64").toString("utf8");
    const o = JSON.parse(json);
    return typeof o.sub === "string" ? o.sub : "";
  } catch (e) { return ""; }
}

// --- Abonnement-verificatie ----------------------------------------------
// Checkt via de Supabase-sessie (JWT) of de ingelogde gebruiker een actief
// Basis/Pro/Plus-abonnement heeft. RLS zorgt dat de query alleen de eigen rij teruggeeft.
async function subActive(authToken) {
  if (!authToken || typeof authToken !== "string") return false;
  const url = (process.env.SUPABASE_URL || process.env.VITE_SUPABASE_URL || "https://tkmyjpsmdijaalwgzqdy.supabase.co").replace(/\/$/, "");
  const anon = process.env.SUPABASE_ANON_KEY || process.env.VITE_SUPABASE_ANON_KEY || "sb_publishable_5CJ_waXIVhhzkkqD96iqMA_63yJJnaH";
  if (!url) return false;
  try {
    const r = await fetch(url + "/rest/v1/subscriptions?select=tier,status,current_period_end", {
      headers: { apikey: anon, Authorization: "Bearer " + authToken },
    });
    if (!r.ok) return false;
    const rows = await r.json().catch(() => []);
    const s = rows && rows[0];
    if (!s) return false;
    const activeStatus = s.status === "active" || s.status === "trialing";
    const paidTier = s.tier === "basis" || s.tier === "pro" || s.tier === "plus";
    // Eenmalige betaling: toegang vervalt op current_period_end (geen auto-verlenging).
    // Zonder geldige, niet-verlopen datum = geen toegang.
    const notExpired = !!s.current_period_end && new Date(s.current_period_end).getTime() > Date.now();
    return !!(activeStatus && paidTier && notExpired);
  } catch (e) { return false; }
}

// --- Simpele rate-limit (per IP, per dag) --------------------------------
// Losse anti-misbruik-backstop per IP per dag. De échte rem is Optie B (credits per
// betaling). Ruim gezet zodat echte klanten (ook meerdere op één IP) niet geraakt worden.
const MAX_PER_DAY = parseInt(process.env.MAX_PER_DAY_IP || "30", 10);
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
// Optioneel org-profiel (sportschool stelt eigen formule in, binnen veilige grenzen).
// Alleen eiwit/vet per kg en de cut/gain-correcties zijn instelbaar; BMR (Mifflin),
// activiteitsfactoren en de veiligheidsvloer blijven vast.
function computeBase(b, p) {
  const toNum = (v, d) => { const n = parseFloat(v); return isNaN(n) ? d : n; };
  p = p || {};
  const pPerKg = Math.min(3.5, Math.max(1.2, toNum(p.protein_g_per_kg, 2.0)));   // grenzen = verantwoord
  const fPerKg = Math.min(2.0, Math.max(0.4, toNum(p.fat_g_per_kg, 0.9)));
  const cutAdj = p.cut_pct != null ? Math.max(-0.30, Math.min(0, toNum(p.cut_pct, -18) / 100)) : GOAL_ADJ.cut;
  const gainAdj = p.gain_pct != null ? Math.max(0, Math.min(0.25, toNum(p.gain_pct, 8) / 100)) : GOAL_ADJ.gain;
  const GOAL = { cut: cutAdj, maintain: 0, gain: gainAdj };

  const kg = clampNum(b.weight, 35, 300, 80);
  const cm = clampNum(b.height, 120, 230, 180);
  const age = clampNum(b.age, 18, 100, 35); // 18+ (Mifflin is voor volwassenen gevalideerd)
  const sex = pick(b.sex, ["male", "female"], "male");
  const activity = pick(b.activity, Object.keys(ACTIVITY), "moderate");
  let goal = pick(b.goal, Object.keys(GOAL), "maintain");

  // Verantwoord: wie al (bijna) ondergewicht heeft niet verder laten afvallen.
  const bmi = cm > 0 ? kg / Math.pow(cm / 100, 2) : 22;
  let lowBmi = false;
  if (goal === "cut" && bmi < 18.5) { goal = "maintain"; lowBmi = true; }

  const bmr = sex === "male"
    ? 10 * kg + 6.25 * cm - 5 * age + 5
    : 10 * kg + 6.25 * cm - 5 * age - 161;
  const maintenance = Math.round((bmr * ACTIVITY[activity]) / 10) * 10;
  // Veiligheidsvloer: nooit onder BMR×1,1 én nooit onder de absolute ondergrens
  // (1500 kcal man / 1200 kcal vrouw — Harvard Health). Zelfde regel als de webcalculator.
  const sexMin = sex === "male" ? 1500 : 1200;
  const safeFloor = Math.max(Math.round((bmr * 1.1) / 10) * 10, sexMin);
  let kcal = Math.round((maintenance * (1 + GOAL[goal])) / 10) * 10;
  let floored = false;
  if (kcal < safeFloor) { kcal = safeFloor; floored = true; }
  const protein = Math.round(kg * pPerKg);
  const fat = Math.round(kg * fPerKg);
  const carbs = Math.max(40, Math.round((kcal - protein * 4 - fat * 9) / 4));
  return { kcal, protein, carbs, fat, maintenance, kg, bmi: Math.round(bmi * 10) / 10, lowBmi, floored };
}

// Haalt het org-rekenprofiel op voor een ingelogd gym-lid (RLS geeft alleen de eigen org).
async function orgCalcProfile(authToken) {
  if (!authToken || typeof authToken !== "string") return null;
  const url = (process.env.SUPABASE_URL || process.env.VITE_SUPABASE_URL || "https://tkmyjpsmdijaalwgzqdy.supabase.co").replace(/\/$/, "");
  const anon = process.env.SUPABASE_ANON_KEY || process.env.VITE_SUPABASE_ANON_KEY || "sb_publishable_5CJ_waXIVhhzkkqD96iqMA_63yJJnaH";
  try {
    const r = await fetch(url + "/rest/v1/org_config?select=calc_profile&limit=1", { headers: { apikey: anon, Authorization: "Bearer " + authToken } });
    if (!r.ok) return null;
    const rows = await r.json().catch(() => []);
    const raw = rows && rows[0] && rows[0].calc_profile;
    if (!raw || typeof raw !== "object") return null;
    const m = raw.macros || {}, g = raw.goal || {};
    return {
      protein_g_per_kg: raw.protein_g_per_kg != null ? raw.protein_g_per_kg : m.protein_g_per_kg,
      fat_g_per_kg: raw.fat_g_per_kg != null ? raw.fat_g_per_kg : m.fat_g_per_kg,
      cut_pct: raw.cut_pct != null ? raw.cut_pct : g.cut_pct,
      gain_pct: raw.gain_pct != null ? raw.gain_pct : g.gain_pct,
    };
  } catch (e) { return null; }
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
  const variety = cleanStr(b.variety, 20) || "mix";

  // Welke dag-templates moeten we bouwen? [{label, level}] met level train/rest/base.
  let reqs = Array.isArray(b.request) ? b.request.slice(0, 3) : [{ label: "D1", level: "base" }];
  reqs = reqs.map((r) => ({ label: cleanStr(r.label, 8) || "D1", level: pick(r.level, ["train", "rest", "base"], "base") }));

  const lang = b.lang === "en" ? "en" : "nl";

  // Tussendoortjes: aantal (0-3) + voorkeuren. Bepaalt hoeveel maaltijden de dag telt
  // en hoe de kcal verdeeld worden (hoofdmaaltijden + kleine snacks).
  const nSnackRaw = parseInt(b.snacks, 10);
  const nSnackSafe = isNaN(nSnackRaw) ? 0 : Math.max(0, Math.min(3, nSnackRaw));
  // snackLikes = gekozen type-ids (fruit/nuts/...). Kies concrete opties uit de
  // database — banaan vooraan als default. Zo wordt "fruit" niet letterlijk, maar
  // gevarieerd ingevuld vanuit de DB.
  const snackCandList = nSnackSafe > 0 ? snackOptions(Array.isArray(b.snackLikes) ? b.snackLikes : []).slice(0, 14) : [];
  const snackCands = snackCandList.map((s) => (lang === "en" ? s.en : s.nl)).join(", ");
  const totalMeals = 3 + nSnackSafe;

  const prefs = [];
  if (likes) prefs.push(`Loves / wants included: ${likes}`);
  if (proteins) prefs.push(`Preferred proteins: ${proteins}`);
  if (cuisines) prefs.push(`Cuisine leaning: ${cuisines}`);
  const prefText = prefs.length ? prefs.join(". ") + "." : "No strong preferences.";

  // Kok-recepten als optionele inspiratie. "Trend"-recepten (matcha, ashwagandha,
  // chia/lupine) komen ALLEEN mee als de voorkeuren dat ingrediënt noemen — anders
  // bouwt de AI gewone maaltijden rond de voorkeuren, geen opgedrongen trends.
  const prefBlob = `${likes} ${proteins} ${cuisines} ${diet}`.toLowerCase();
  const TREND = {
    3: ["matcha", "overnight oats", "green tea", "groene thee"],
    6: ["ashwagandha", "adaptogen", "shake", "smoothie"],
    9: ["chia", "lupine", "lupin", "pudding"],
  };
  const chosenRecipes = RECIPES.filter((r) => {
    const kws = TREND[r.id];
    if (!kws) return true; // staple: altijd beschikbaar als inspiratie
    return kws.some((k) => prefBlob.includes(k)); // trend: alleen bij matchende voorkeur
  });
  const recipeLines = chosenRecipes.map((r) => {
    const ings = r.ing.map((x) => `${x.g}g ${x[lang] || x.en}`).join(", ");
    return `- ${r.name[lang] || r.name.en} [${r.type}, ${r.macros.kcal}kcal ${r.macros.p}P/${r.macros.c}C/${r.macros.f}F]: ${ings}`;
  }).join("\n");

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

  const snackWord = lang === "en" ? "Snack" : "Tussendoortje";
  const snackLine = nSnackSafe > 0
    ? (lang === "en"
        ? `- ${totalMeals} meals/day: Breakfast, Lunch, Dinner and ${nSnackSafe} ${snackWord}${nSnackSafe > 1 ? "s" : ""}. Use exactly these meal types for "t": Breakfast, Lunch, Dinner, Snack.`
        : `- ${totalMeals} maaltijden/dag: Ontbijt, Lunch, Diner en ${nSnackSafe} ${snackWord}${nSnackSafe > 1 ? "s" : ""}. Gebruik precies deze types voor "t": Ontbijt, Lunch, Diner, Tussendoortje.`)
    : (lang === "en"
        ? '- 3 meals/day. Use exactly these meal types for "t": Breakfast, Lunch, Dinner.'
        : '- 3 maaltijden/dag. Gebruik precies deze types voor "t": Ontbijt, Lunch, Diner.');
  const varyAcross = variety === "fixed"
    ? (lang === "en" ? "Use the same snack(s) each day — repetition is wanted here." : "Gebruik elke dag dezelfde tussendoortjes — herhaling is hier gewenst.")
    : variety === "varied"
      ? (lang === "en" ? "Vary them across the days — avoid repeating the same snack." : "Varieer ze over de dagen — vermijd elke dag hetzelfde.")
      : (lang === "en" ? "Keep one or two staples but rotate a snack or two across the week." : "Houd één of twee vaste tussendoortjes maar wissel er een paar af over de week.");
  const snackGuide = nSnackSafe > 0
    ? (lang === "en"
        ? `- Keep each Snack small (roughly 8-15% of the day's calories) and simple; let the 3 main meals carry the rest. Spread the snacks between the main meals so the day is well distributed. Pick snacks FROM this list: ${snackCands}. ${varyAcross} If in doubt, a banana is the most obvious default.`
        : `- Houd elk Tussendoortje klein (ongeveer 8-15% van de dagcalorieën) en simpel; de 3 hoofdmaaltijden dragen de rest. Spreid de tussendoortjes tussen de hoofdmaaltijden zodat de dag goed verdeeld is. Kies de tussendoortjes UIT deze lijst: ${snackCands}. ${varyAcross} Bij twijfel is een banaan de meest voor de hand liggende keuze.`)
    : "";
  const L = lang === "en"
    ? {
        rule1: "- Write ALL meal names, ingredient names and meal types in ENGLISH.",
        rule2: snackLine,
        snackGuide,
        ruleN: "- Lean into the preferred foods, proteins and cuisines. Short ingredient names.",
        example: '{"days":[{"d":"' + reqs[0].label + '","m":[{"t":"Breakfast","n":"Oats with quark","kcal":0,"p":0,"c":0,"f":0,"ing":[{"n":"Oats","g":60}]}]}]}',
      }
    : {
        rule1: "- Write ALL meal names, ingredient names and meal types in DUTCH (Nederlands).",
        rule2: snackLine,
        snackGuide,
        ruleN: "- Lean into the preferred foods, proteins and cuisines. Short Dutch ingredient names.",
        example: '{"days":[{"d":"' + reqs[0].label + '","m":[{"t":"Ontbijt","n":"Havermout met kwark","kcal":0,"p":0,"c":0,"f":0,"ing":[{"n":"Havermout","g":60}]}]}]}',
      };

  const varietyRule = variety === "fixed"
    ? "MEAL VARIETY — the person prefers FIXED daily patterns. Use the SAME Breakfast, Lunch and Dinner (and the same snacks) on EVERY day; only adjust the portion sizes per day to hit that day's targets. Do NOT vary the dishes across days — repetition is intended and wanted."
    : variety === "varied"
      ? "MEAL VARIETY — the person wants LOTS of variety. Make each day's meals different and avoid repeating the same dish across days."
      : "MEAL VARIETY — keep a few staple meals that repeat, but rotate 2-3 meals across the week for some variety.";
  const cookLine = variety === "fixed"
    ? "Keep meals realistic and easy to cook."
    : "Make the days distinct and realistic to cook.";

  return `You are a sports nutrition coach. Build these meal-days, each hitting ITS OWN targets:
${dayLines}

Diet: ${diet}. Avoid: ${avoid}.
Preferences: ${prefText}
${varietyRule}

Optional recipe ideas that suit this person's taste — use any that fit the day's targets, the diet and the avoid-list, scaling portions to hit the numbers. Otherwise build your own simple, realistic meals around their stated preferences. Do NOT introduce novelty or "superfood" ingredients (matcha, ashwagandha, etc.) unless their preferences above mention them:
${recipeLines}

Keep protein high and roughly equal on every day; put the calorie difference between training and rest days mainly into carbohydrates (rice, oats, potato, fruit). ${cookLine}

Rules:
${L.rule1}
${L.rule2}${L.snackGuide ? "\n" + L.snackGuide : ""}
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
    // Gym-lid? Dan de formule van de sportschool gebruiken (anders de standaardformule).
    const orgProfile = await orgCalcProfile(body.authToken);
    const base = computeBase(body, orgProfile);
    const cyc = computeCycle(base, body.trainingCount);
    const targets = {
      kcal: base.kcal, protein: base.protein, carbs: base.carbs, fat: base.fat,
      maintenance: base.maintenance, bmi: base.bmi, lowBmi: base.lowBmi, floored: base.floored,
      train: cyc.train, rest: cyc.rest, trainingCount: cyc.trainingCount,
    };

    // GRATIS: alleen de (formule-)targets. Geen AI, geen kosten, niets om te stapelen.
    // Betaald telt alleen als er een geldig token uit /api/verify meekomt (zodra het
    // slot actief is via UNLOCK_SECRET). Zonder die env var volstaat de paid-vlag.
    const isPaid = body.paid === true;
    const subVerified = await subActive(body.authToken);
    const paidVerified = isPaid && (trusted || subVerified || validToken(body.token));
    if (!trusted && !paidVerified) {
      return res.status(200).json({ targets, plan: null, locked: true });
    }

    // BETAALD (of vertrouwde automatisering): AI-generatie, met rate-limit als backstop.
    if (!trusted) {
      const ip = (req.headers["x-forwarded-for"] || "unknown").split(",")[0].trim();
      if (rateLimited(ip)) {
        return res.status(429).json({ error: "Te veel aanvragen op dit moment. Probeer het over een paar minuten opnieuw." });
      }
    }

    // OPTIE B: credits per betaling. Elke generatie telt er één af; bij 0 → opnieuw
    // betalen. Alleen voor echte betaalde gebruikers (niet voor trusted automatisering),
    // en alleen als er een credit-opslag gekoppeld is (anders verandert er niets).
    if (!trusted && !subVerified && kvConfigured()) {
      const sid = tokenSid(body.token);
      const dec = sid ? await kv(["DECR", "cr:" + sid]) : { result: -1 };
      const n = typeof dec.result === "number" ? dec.result : parseInt(dec.result, 10);
      if (!(n >= 0)) {
        // Geen credits meer (of geen geldig record) → klem op 0 en terug naar de betaalmuur.
        if (sid) { try { await kv(["SET", "cr:" + sid, "0", "EX", "15552000"]); } catch (e) {} }
        return res.status(200).json({ targets, plan: null, locked: true, reason: "no_credits" });
      }
    }

    // Per-account eerlijk-gebruik-limiet voor abonnees (maandelijks). Voorkomt dat
    // iemand eindeloos AI-plannen genereert op onze kosten. Ruim gezet (standaard 100/mnd),
    // onzichtbaar voor normaal gebruik, alleen een backstop tegen misbruik.
    // Alleen actief als er een credit-opslag (Upstash) gekoppeld is; faalt OPEN zodat
    // echte klanten nooit vastlopen bij een opslagstoring. Env PLAN_LIMIT_PER_MONTH (0 = uit).
    const MONTH_CAP = parseInt(process.env.PLAN_LIMIT_PER_MONTH || "100", 10);
    if (!trusted && subVerified && kvConfigured() && MONTH_CAP > 0) {
      const uid = jwtSub(body.authToken);
      if (uid) {
        try {
          const mk = "gen:" + uid + ":" + new Date().toISOString().slice(0, 7);
          const inc = await kv(["INCR", mk]);
          const n = typeof inc.result === "number" ? inc.result : parseInt(inc.result, 10);
          if (n === 1) { try { await kv(["EXPIRE", mk, "3456000"]); } catch (e) {} } // ~40 dagen
          if (n > MONTH_CAP) {
            return res.status(429).json({ error: "Je hebt deze maand het maximum aantal plannen gegenereerd — volgende maand kun je weer. / You've reached this month's plan limit; it resets next month." });
          }
        } catch (e) { /* opslag onbereikbaar → niet blokkeren */ }
      }
    }

    // AI-provider-schakelaar. Standaard Anthropic-direct; zet AI_PROVIDER=openrouter
    // in Vercel om via OpenRouter te draaien (één key, model-fallback, uitgavenlimiet).
    // Model per provider via env: AI_MODEL_ANTHROPIC / AI_MODEL (OpenRouter-slug).
    // Als de primaire provider faalt en de andere key bestaat, valt 't automatisch terug.
    const anKey = process.env.ANTHROPIC_API_KEY;
    const orKey = process.env.OPENROUTER_API_KEY;
    const provider = (process.env.AI_PROVIDER || "anthropic").toLowerCase();
    if (!anKey && !orKey) {
      return res.status(500).json({ error: "Server mist AI-sleutel (ANTHROPIC_API_KEY of OPENROUTER_API_KEY)." });
    }

    const prompt = buildPrompt(body, cyc);

    async function callAnthropic() {
      if (!anKey) return { err: "ANTHROPIC_API_KEY ontbreekt" };
      const r = await fetch("https://api.anthropic.com/v1/messages", {
        method: "POST",
        headers: { "Content-Type": "application/json", "x-api-key": anKey, "anthropic-version": "2023-06-01" },
        body: JSON.stringify({
          model: process.env.AI_MODEL_ANTHROPIC || "claude-sonnet-4-6",
          max_tokens: 3000,
          messages: [{ role: "user", content: prompt }],
        }),
      });
      if (!r.ok) return { err: "anthropic " + r.status, detail: (await r.text()).slice(0, 200) };
      const d = await r.json();
      return { text: (d.content || []).filter((x) => x.type === "text").map((x) => x.text).join("").trim() };
    }

    async function callOpenRouter() {
      if (!orKey) return { err: "OPENROUTER_API_KEY ontbreekt" };
      const r = await fetch("https://openrouter.ai/api/v1/chat/completions", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer " + orKey,
          "HTTP-Referer": "https://hybridfuelco.com",
          "X-Title": "HybridFuelCo",
        },
        body: JSON.stringify({
          model: process.env.AI_MODEL || "anthropic/claude-sonnet-4",
          max_tokens: 3000,
          messages: [{ role: "user", content: prompt }],
        }),
      });
      if (!r.ok) return { err: "openrouter " + r.status, detail: (await r.text()).slice(0, 200) };
      const d = await r.json();
      const m = d.choices && d.choices[0] && d.choices[0].message;
      let c = m && m.content;
      if (Array.isArray(c)) c = c.map((x) => (x && x.text) || "").join("");
      return { text: (c || "").trim() };
    }

    let out = provider === "openrouter" ? await callOpenRouter() : await callAnthropic();
    // Fallback naar de andere provider als die key bestaat.
    if ((out.err || !out.text) && (provider === "openrouter" ? anKey : orKey)) {
      out = provider === "openrouter" ? await callAnthropic() : await callOpenRouter();
    }
    if (out.err || !out.text) {
      return res.status(502).json({ error: "AI-aanroep mislukt", detail: (out.err || "leeg antwoord") + (out.detail ? " · " + out.detail : "") });
    }

    let text = out.text;
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
