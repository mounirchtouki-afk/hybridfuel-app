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

// Is de ingelogde gebruiker een gym-lid/coach, en zo ja: welke tier (basis/pro)?
// Toegang loopt via de sportschool, niet via een abonnement. De tier bepaalt het
// maandbudget aan AI-generaties en welk model draait. LEIDEND is de gym-licentie
// (orgs.license_tier) — dat is waarop we factureren; org_members.member_tier staat
// standaard op 'pro' en is dus géén betrouwbare budget-indicator. Default basis.
// RLS geeft het lid alleen de eigen org (policy "org read own") terug.
async function gymProfile(authToken) {
  if (!authToken || typeof authToken !== "string") return { access: false, tier: "basis" };
  const url = (process.env.SUPABASE_URL || process.env.VITE_SUPABASE_URL || "https://tkmyjpsmdijaalwgzqdy.supabase.co").replace(/\/$/, "");
  const anon = process.env.SUPABASE_ANON_KEY || process.env.VITE_SUPABASE_ANON_KEY || "sb_publishable_5CJ_waXIVhhzkkqD96iqMA_63yJJnaH";
  const headers = { apikey: anon, Authorization: "Bearer " + authToken };
  let access = false, orgTier = null;
  try {
    const r = await fetch(url + "/rest/v1/org_members?select=role&active=eq.true&limit=1", { headers });
    if (r.ok) { const rows = await r.json().catch(() => []); if (Array.isArray(rows) && rows.length) access = true; }
  } catch (e) {}
  if (access) {
    try {
      const o = await fetch(url + "/rest/v1/orgs?select=license_tier&limit=1", { headers });
      if (o.ok) { const rows = await o.json().catch(() => []); if (Array.isArray(rows) && rows.length) orgTier = rows[0].license_tier || null; }
    } catch (e) {}
  }
  const t = String(orgTier || "basis").toLowerCase();
  return { access, tier: t === "pro" ? "pro" : "basis" };
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
    const prof = {
      protein_g_per_kg: raw.protein_g_per_kg != null ? raw.protein_g_per_kg : m.protein_g_per_kg,
      fat_g_per_kg: raw.fat_g_per_kg != null ? raw.fat_g_per_kg : m.fat_g_per_kg,
      cut_pct: raw.cut_pct != null ? raw.cut_pct : g.cut_pct,
      gain_pct: raw.gain_pct != null ? raw.gain_pct : g.gain_pct,
    };
    // Per-lid override (indien ingesteld) gaat vóór de org-formule — alleen de gevulde velden.
    try {
      const mr = await fetch(url + "/rest/v1/org_members?select=calc_override&limit=1", { headers: { apikey: anon, Authorization: "Bearer " + authToken } });
      if (mr.ok) {
        const ov = (await mr.json().catch(() => []))[0];
        const o = ov && ov.calc_override;
        if (o && typeof o === "object") {
          ["protein_g_per_kg", "fat_g_per_kg", "cut_pct", "gain_pct"].forEach((k) => { if (o[k] != null && o[k] !== "") prof[k] = o[k]; });
        }
      }
    } catch (e) {}
    return prof;
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
        ? `- Keep each Snack small (roughly 8-15% of the day's calories) and simple; let the 3 main meals carry the rest. Spread the snacks between the main meals so the day is well distributed. If the person listed Snack choices in the MEAL CHOICES block, use those; otherwise good concrete options to draw from: ${snackCands}. ${varyAcross} If in doubt, a banana is the most obvious default.`
        : `- Houd elk Tussendoortje klein (ongeveer 8-15% van de dagcalorieën) en simpel; de 3 hoofdmaaltijden dragen de rest. Spreid de tussendoortjes tussen de hoofdmaaltijden zodat de dag goed verdeeld is. Koos de persoon Tussendoortjes in het MAALTIJDKEUZES-blok, gebruik die; anders zijn goede concrete opties: ${snackCands}. ${varyAcross} Bij twijfel is een banaan de meest voor de hand liggende keuze.`)
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

  // Per-eetmoment keuzes uit "Wat eet je graag?" (chips). Deze MOETEN leidend zijn:
  // elke maaltijd van een moment komt uit de lijst van dát moment, nooit verschoven
  // naar een ander moment. Dit veld werd eerder genegeerd -> AI verzon eigen maaltijden.
  const MM = lang === "en"
    ? { breakfast: "Breakfast", lunch: "Lunch", dinner: "Dinner", snack: "Snack" }
    : { breakfast: "Ontbijt", lunch: "Lunch", dinner: "Diner", snack: "Tussendoortje" };
  const mp = (b.mealPrefs && typeof b.mealPrefs === "object") ? b.mealPrefs : {};
  const mealPrefRows = ["breakfast", "lunch", "dinner", "snack"].map((k) => {
    const arr = Array.isArray(mp[k]) ? mp[k].slice(0, 12).map((x) => cleanStr(x, 40)).filter(Boolean) : [];
    return arr.length ? `- ${MM[k]}: ${arr.join(", ")}` : null;
  }).filter(Boolean);
  const mealPrefBlock = mealPrefRows.length
    ? (lang === "en"
        ? `MEAL CHOICES PER MOMENT (HARD CONSTRAINT — the person explicitly picked these for each meal moment). Build each day's meal from the MATCHING list only, and NEVER move a choice to another meal moment (a Dinner choice must not appear at Lunch, nor a Lunch choice at Breakfast). Use the listed options (rotate across them over the week unless a fixed daily pattern is requested above); scale portions to hit each day's targets. Do not invent dishes outside these lists for a listed moment:\n${mealPrefRows.join("\n")}\nFor any meal moment NOT listed here, choose something that fits the overall preferences.`
        : `MAALTIJDKEUZES PER MOMENT (HARDE EIS — de persoon koos deze expliciet per eetmoment). Bouw elke maaltijd ALLEEN uit de bijbehorende lijst en verplaats NOOIT een keuze naar een ander eetmoment (een Diner-keuze mag niet bij Lunch staan, een Lunch-keuze niet bij Ontbijt). Gebruik de genoemde opties (wissel er over de week tussen, tenzij hierboven een vast dagpatroon is gevraagd); schaal porties naar de dagdoelen. Verzin voor een genoemd moment geen gerechten buiten deze lijst:\n${mealPrefRows.join("\n")}\nVoor een eetmoment dat hier NIET genoemd is, kies iets dat bij de algemene voorkeuren past.`)
    : "";

  // De receptenlijst is inspiratie, maar mag NOOIT de keuzes hierboven overrulen.
  // Bij keuzes per moment: recepten alleen voor momenten ZONDER keuze.
  const recipeIntro = mealPrefRows.length
    ? `Recipe ideas below are ONLY inspiration for meal moments that have NO chosen option in the MEAL CHOICES block above. For any moment WITH a chosen option, build the meal from that option and IGNORE this list entirely — do not rename or swap it to a recipe from here. Whatever you use must still fit the day's targets, the diet and the avoid-list, and no novelty/"superfood" ingredients unless preferences mention them:`
    : `Optional recipe ideas that suit this person's taste — use any that fit the day's targets, the diet and the avoid-list, scaling portions to hit the numbers. Otherwise build your own simple, realistic meals around their stated preferences. Do NOT introduce novelty or "superfood" ingredients (matcha, ashwagandha, etc.) unless their preferences above mention them:`;

  return `You are a sports nutrition coach. Build these meal-days, each hitting ITS OWN targets:
${dayLines}

${mealPrefBlock ? mealPrefBlock + "\n\n" : ""}Diet: ${diet}. Avoid: ${avoid}.
Preferences: ${prefText}
${varietyRule}

${recipeIntro}
${recipeLines}

Keep protein high and roughly equal on every day; put the calorie difference between training and rest days mainly into carbohydrates (rice, oats, potato, fruit). ${cookLine}

Rules:
${L.rule1}
${L.rule2}${L.snackGuide ? "\n" + L.snackGuide : ""}
- For EACH meal list 2-4 main ingredients with weights in grams.
- COHERENCE — every meal must be realistic and appetizing: use ONLY ingredients that genuinely belong together in that specific dish. A "bread with topping" = bread + a fitting topping (chicken, cheese, egg, tuna) and maybe some veg; it does NOT contain quark or banana. Do not stuff unrelated foods into one meal to force the numbers. Hit the targets by adjusting PORTION SIZES and by adding a side that fits the dish; if you cannot hit the target exactly without breaking coherence, get CLOSE with sensible ingredients rather than adding things that do not belong. Fruit, quark/yoghurt and other snack-type foods belong in the Snack slots, not mixed into a bread, rice or pasta main meal.
- Each meal's kcal and p/c/f MUST match the listed ingredient weights.
- Each day's meals should sum close to THAT day's targets above (slightly off is fine if it keeps meals realistic).
${L.ruleN}${mealPrefRows.length ? "\n- CRITICAL: the dish for each meal moment that has chosen options (see MEAL CHOICES at the top) MUST be one of those chosen options — name it accordingly and build its ingredients with items that fit THAT dish. Do NOT replace it with a recipe-idea dish, and do NOT pad it with ingredients that don't belong. Only invent freely for moments without chosen options." : ""}

Return ONLY valid JSON, no markdown, exactly this shape (keep the JSON keys in English, set "d" to each day's label above):
${L.example}`;
}

// ============================================================================
// DATABASE-FIRST: bouw het plan uit de gerechten-bibliotheek (Supabase).
// Matcht gerechten op de gekozen eetmoment-keuzes, schaalt porties naar de
// dagdoelen. AI wordt alleen het vangnet als een moment geen enkel gerecht heeft.
// ============================================================================
function supaBase() {
  const url = (process.env.SUPABASE_URL || process.env.VITE_SUPABASE_URL || "https://tkmyjpsmdijaalwgzqdy.supabase.co").replace(/\/$/, "");
  const anon = process.env.SUPABASE_ANON_KEY || process.env.VITE_SUPABASE_ANON_KEY || "sb_publishable_5CJ_waXIVhhzkkqD96iqMA_63yJJnaH";
  return { url, anon, headers: { apikey: anon, Authorization: "Bearer " + anon } };
}
let _ingCache = null, _ingAt = 0;
async function getIngredients() {
  if (_ingCache && (Date.now() - _ingAt) < 600000) return _ingCache;
  const { url, headers } = supaBase();
  try {
    const r = await fetch(url + "/rest/v1/ingredients?select=slug,name_nl,name_en,kcal,protein,carbs,fat,category", { headers });
    if (!r.ok) return _ingCache || {};
    const rows = await r.json().catch(() => []);
    const map = {}; (rows || []).forEach((x) => { map[x.slug] = x; });
    if (Object.keys(map).length) { _ingCache = map; _ingAt = Date.now(); }
    return _ingCache || map;
  } catch (e) { return _ingCache || {}; }
}
function dishMac(items, ing) {
  let kcal = 0, p = 0, c = 0, f = 0;
  for (const it of items || []) { const m = ing[it.slug]; if (!m) continue; const k = (it.g || 0) / 100; kcal += m.kcal * k; p += m.protein * k; c += m.carbs * k; f += m.fat * k; }
  return { kcal, p, c, f };
}
async function fetchDishes(moment, chipIds) {
  const { url, headers } = supaBase();
  let q = url + "/rest/v1/dishes?select=slug,name_nl,name_en,moments,goals,items,tags,prefs,steps,steps_en,technique,temp&active=eq.true&source=eq.core&moments=ov.%7B" + encodeURIComponent(moment) + "%7D&limit=400";
  if (chipIds && chipIds.length) q += "&prefs=ov.%7B" + chipIds.map(encodeURIComponent).join(",") + "%7D";
  try {
    const r = await fetch(q, { headers });
    if (!r.ok) return [];
    return (await r.json().catch(() => [])) || [];
  } catch (e) { return []; }
}
async function buildFromLibrary(body, cyc) {
  const lang = body.lang === "en" ? "en" : "nl";
  const ing = await getIngredients();
  if (!ing || !Object.keys(ing).length) return { complete: false };
  const nSnack = Math.max(0, Math.min(3, parseInt(body.snacks, 10) || 0));
  const prefIds = (body.mealPrefIds && typeof body.mealPrefIds === "object") ? body.mealPrefIds : {};
  const chosenProducts = Array.isArray(body.chosenProducts) ? body.chosenProducts : [];
  const diet = cleanStr(body.diet, 40) || "";
  const avoid = (cleanStr(body.avoid, 200) || "").toLowerCase().split(/[,;\n]/).map((s) => s.trim()).filter((x) => x.length > 2);
  const isVegan = /vegan|veganis/i.test(diet);
  const isVeg = /vegetar/i.test(diet);
  const variety = cleanStr(body.variety, 20) || "mix";
  // Voorkeurs-eiwitbronnen (ids uit de app) -> toegestane eiwit-families.
  const PROT_FAM_MAP = { chicken: ["kip"], beef: ["rund"], fish: ["zalm", "tonijn", "garnaal", "witvis"], eggs: ["ei"], tofu: ["soja"], quark: ["zuivel"], beans: ["peulvrucht"] };
  const allowedProt = new Set();
  (Array.isArray(body.proteinIds) ? body.proteinIds : []).forEach((id) => (PROT_FAM_MAP[id] || []).forEach((f) => allowedProt.add(f)));
  const name = (m) => (m ? m["name_" + lang] || m.name_en || m.name_nl : "");
  const filt = (rows) => (rows || []).filter((d) => {
    if (isVegan && !(d.tags || []).includes("vegan")) return false;
    if (isVeg && !(d.tags || []).includes("vegetarian")) return false;
    if (avoid.length && (d.items || []).some((it) => { const m = ing[it.slug]; if (!m) return false; const nm = ((m.name_nl || "") + " " + (m.name_en || "")).toLowerCase(); return avoid.some((a) => nm.includes(a)); })) return false;
    return true;
  });
  // Matcht de keuze van de gebruiker ("wat eet je graag") op het recept zelf
  // (ingrediënten + naam), zodat de keuze gehonoreerd wordt ook als de prefs-kolom
  // in de database leeg is. Zo krijgt "Volkoren brood + beleg" ook écht een boterham.
  function matchesPref(d, chip) {
    const slugs = (d.items || []).map((it) => it.slug);
    const has = (s) => slugs.includes(s);
    const any = (arr) => arr.some((s) => slugs.includes(s));
    const nm = ((d.name_nl || "") + " " + (d.name_en || "")).toLowerCase();
    const chicken = any(["chicken_breast", "chicken_thigh", "chicken_mince", "turkey_breast", "turkey_mince"]);
    const rice = any(["rice_dry", "rice_yellow", "brown_rice"]);
    const bread = any(["bread_whole", "sourdough", "crackers_whole"]);
    const wrap = any(["wrap_whole", "pita_whole"]);
    const tuna = any(["tuna_can", "tuna_steak"]);
    const salmon = any(["salmon", "smoked_salmon", "trout"]);
    const pasta = has("pasta_whole");
    const mince = any(["beef_mince5", "chicken_mince", "turkey_mince"]);
    const steak = any(["beef_lean", "flat_iron"]);
    const potato = any(["potato", "sweet_potato"]);
    const noodle = any(["noodles_whole", "rice_noodles"]);
    const egg = any(["egg", "egg_white"]);
    const dairy = any(["quark_lowfat", "skyr", "greek_yoghurt", "cottage", "yoghurt_lowfat", "soy_yoghurt"]);
    const fruit = any(["banana", "apple", "blueberries", "strawberry", "mixed_berries", "mango", "pear", "cherries", "grapes", "pineapple", "raspberry", "orange", "kiwi"]);
    const nuts = any(["almonds", "walnuts", "cashew", "peanut_butter", "almond_butter", "pumpkin_seeds"]);
    const omeletRe = /omelet|menemen|shakshuka|roerei|tortilla|frittata/;
    const soupy = d.technique === "soup" || /soep|soup|minestrone|pho|gazpacho|taginestoof|stoofpot/.test(nm);
    const wokky = noodle || /wok|chow mein|pad |bulgogi|kung pao|roerbak|japchae|teriyaki|bibimbap|nasi/.test(nm);
    const curryish = /curry|tikka|masala|tandoori|rendang|\bdal\b|biryani|keema|saag|chana|misir|makhani/.test(nm) || has("curry_paste");
    switch (chip) {
      case "quarkfruit": return dairy && fruit;
      case "eggs": return egg && !omeletRe.test(nm);
      case "omelet": return omeletRe.test(nm);
      case "smoothie": return /smoothie/.test(nm);
      case "wholebread": return bread && !wrap;
      case "protpancake": return /pannenkoek|pancake|wafel|waffle/.test(nm);
      case "chickenwrap": return wrap && chicken;
      case "ricechicken": return rice && chicken;
      case "tunasalad": return tuna;
      case "sandwich": return bread && !wrap;
      case "soup": return soupy;
      case "poke": return /poke|poké|sushi|bowl/.test(nm);
      case "saladegg": return /salade|salad/.test(nm) && egg;
      case "salmonveg": return salmon;
      case "pastabol": return pasta && mince;
      case "chickenrice": return chicken && rice;
      case "stamppot": return /stamppot/.test(nm);
      case "curryrice": return curryish && rice;
      case "steakpotato": return steak && potato;
      case "woknoodles": return wokky;
      case "shake": return has("whey") && /shake|smoothie/.test(nm);
      case "quark": return dairy;
      case "nuts": return nuts && !dairy;
      case "bar": return /balletjes|energie|energy|bar|reep/.test(nm);
      case "fruit": return fruit && !dairy;
      case "ricecakepb": return has("rice_cakes");
      default: return false;
    }
  }
  const cache = {};
  async function candidatesFor(momId) {
    if (cache[momId]) return cache[momId];
    const chips = (prefIds[momId] || []).filter((x) => typeof x === "string" && x.indexOf("prod:") !== 0);
    let rows = filt(await fetchDishes(momId, null)); // alle recepten voor dit moment (dieet/avoid al toegepast)
    if (chips.length) {
      const matched = rows.filter((d) => chips.some((c) => matchesPref(d, c)));
      if (matched.length) rows = matched; // per-moment keuze is leidend; geen match -> algemene set
    }
    if (allowedProt.size) {
      const pf = rows.filter((d) => allowedProt.has(protFamOf(d))); // binnen de keuze: voorkeurs-eiwitten
      if (pf.length) rows = pf; // geen enkel passend eiwit op dit moment -> set houden (bv. ontbijt)
    }
    cache[momId] = rows;
    return rows;
  }
  // Hulp: categorie + het eiwit-ingrediënt van een gerecht (voor rotatie).
  const catOf = (slug) => (ing[slug] || {}).category || "";
  const isCarbSlug = (slug) => catOf(slug) === "granen" || slug === "potato" || slug === "sweet_potato";
  const hasCarb = (dish) => (dish.items || []).some((it) => isCarbSlug(it.slug));
  const protSlug = (dish) => { const it = (dish.items || []).find((x) => ["vlees", "vis", "vega", "peulvrucht"].includes(catOf(x.slug)) || x.slug === "egg" || catOf(x.slug) === "zuivel"); return it ? it.slug : (dish.items && dish.items[0] && dish.items[0].slug) || dish.slug; };
  // Rotatie op FAMILIE, niet op exacte sleutel: kipdij en kipfilet = allebei "kip",
  // zoete aardappel en aardappel = allebei "aardappel", alle noten = "noten".
  const protFamily = (s0) => { const s = s0 || ""; if (/chicken|kip|turkey|kalkoen|poultry/.test(s)) return "kip"; if (/beef|steak|biefstuk|flat_iron|rund|gehakt|mince/.test(s)) return "rund"; if (/salmon|zalm/.test(s)) return "zalm"; if (/tuna|tonijn/.test(s)) return "tonijn"; if (/shrimp|garnaal|prawn/.test(s)) return "garnaal"; if (/cod|tilapia|haddock|white_fish|vis\b/.test(s)) return "witvis"; if (/pork|varken|ham|bacon|spek/.test(s)) return "varken"; if (/lamb|lams/.test(s)) return "lam"; if (/duck|eend/.test(s)) return "eend"; if (/egg|\bei\b/.test(s)) return "ei"; if (/whey|casein|eiwitpoeder|protein_powder/.test(s)) return "shake"; if (/tofu|tempeh|soy|soja/.test(s)) return "soja"; if (/lentil|chickpea|bean|linz|kikkererwt|boon|peul/.test(s)) return "peulvrucht"; if (/almond|walnut|pecan|cashew|pistach|hazel|noot|noten|pinda|seed|pit/.test(s)) return "noten"; if (/quark|skyr|yoghurt|yogurt|kwark|cottage|hutten|cheese|kaas|milk|melk|dairy/.test(s)) return "zuivel"; return s; };
  const carbFamily = (s0) => { const s = s0 || ""; if (/potato|aardappel/.test(s)) return "aardappel"; if (/rice|rijst/.test(s)) return "rijst"; if (/oat|havermout|muesli|granola/.test(s)) return "havermout"; if (/pasta|noodle|spaghetti|penne/.test(s)) return "pasta"; if (/quinoa/.test(s)) return "quinoa"; if (/bread|brood|wrap|tortilla|toast/.test(s)) return "brood"; if (/couscous|bulgur/.test(s)) return "couscous"; return s; };
  const protFamOf = (dish) => protFamily(protSlug(dish));
  const carbFamOf = (dish) => { const it = (dish.items || []).find((x) => isCarbSlug(x.slug)); return it ? carbFamily(it.slug) : null; };
  const stepsOf = (dish) => lang === "en" ? (dish.steps_en || dish.steps || "") : (dish.steps || "");
  // BORDMETHODE / eiwit-eerst: schaal het gerecht op het eiwit-doel van de maaltijd
  // (niet op kcal) -> realistische porties + gelijkmatige eiwitverdeling. Daarna
  // schaalt ALLEEN het zetmeel mee met de trainingsbelasting (carb-periodisering).
  function scaleDish(dish, pTarget, maxFactor, carbMult, fatCap) {
    const base = dishMac(dish.items, ing);
    let factor = base.p > 4 ? pTarget / base.p : (base.kcal > 0 ? (pTarget * 9) / base.kcal : 1);
    factor = Math.max(0.5, Math.min(maxFactor || 2.2, factor));
    // Vet-plafond: bij vette eiwitbronnen (ei, zalm, noten) blaast eiwit-eerst het
    // vet op. Knijp de portie terug zodat vet onder de grens blijft (eiwit mag dan
    // iets lager uitvallen — liever gebalanceerd dan 34 g vet in één maaltijd).
    if (fatCap && base.f > 0 && base.f * factor > fatCap) factor = Math.max(0.5, fatCap / base.f);
    const cm = carbMult || 1;
    const scaled = (dish.items || []).map((it) => ({ slug: it.slug, g: it.g * factor * (isCarbSlug(it.slug) ? cm : 1) }));
    const items = scaled.map((it) => ({ n: name(ing[it.slug]) || it.slug, g: Math.round(it.g) }));
    const mac = dishMac(scaled, ing);
    return { t: null, n: name(dish), kcal: Math.round(mac.kcal), p: Math.round(mac.p), c: Math.round(mac.c), f: Math.round(mac.f), ing: items, steps: stepsOf(dish), technique: dish.technique || null, temp: dish.temp || null };
  }
  function scaleProduct(prod, targetKcal) {
    const per = prod.per_100 || {}; const k100 = Number(per.kcal) || 0; if (!(k100 > 0)) return null;
    const maxG = k100 > 300 ? 90 : k100 > 140 ? 280 : 450;
    let g = Math.round(targetKcal / (k100 / 100)); g = Math.max(25, Math.min(maxG, g));
    const f2 = g / 100;
    return { t: null, n: prod.name, kcal: Math.round(k100 * f2), p: Math.round((Number(per.p) || 0) * f2), c: Math.round((Number(per.c) || 0) * f2), f: Math.round((Number(per.f) || 0) * f2), ing: [{ n: prod.name, g }], steps: "", technique: null, temp: null };
  }
  // Kies, vanaf een rotatie-offset, het eerste gerecht dat aan okFn voldoet.
  function pick(cands, offset, okFn) {
    if (!cands.length) return null;
    for (let i = 0; i < cands.length; i++) { const d = cands[(offset + i) % cands.length]; if (okFn(d)) return d; }
    return cands[offset % cands.length];
  }
  const moments = [
    { id: "breakfast", label: lang === "en" ? "Breakfast" : "Ontbijt", rot: 0 },
    { id: "lunch", label: lang === "en" ? "Lunch" : "Lunch", rot: 1 },
    { id: "dinner", label: lang === "en" ? "Dinner" : "Diner", rot: 2 },
  ];
  const snackLabel = lang === "en" ? "Snack" : "Tussendoortje";
  const reqs = (Array.isArray(body.week) && body.week.length) ? body.week.slice(0, 7)
    : ((Array.isArray(body.request) && body.request.length) ? body.request.slice(0, 3) : [{ label: "D1", level: "base" }]);
  const lastProt = {}; // per moment: eiwit van gisteren (niet twee dagen achter elkaar hetzelfde)
  const fixedMain = {}; // variety "fixed": gekozen gerecht per moment, hergebruikt elke dag
  const fixedSnack = {}; // idem voor snacks (per snack-index)
  const avoidYesterday = variety !== "mix"; // "varied"/"fixed": ook niet hetzelfde als gisteren
  const days = [];
  const gaps = []; // eetmomenten zonder passend gerecht (voedt het gat-logboek)
  for (let ti = 0; ti < reqs.length; ti++) {
    const r = reqs[ti];
    const dayT = r.level === "train" ? cyc.train : r.level === "rest" ? cyc.rest : cyc.base;
    const carbMult = r.level === "train" ? 1.2 : r.level === "rest" ? 0.8 : 1.0; // alleen zetmeel
    const dayP = dayT.protein || 150;
    const pMain = Math.max(28, Math.min(42, Math.round(dayP * 0.26)));
    const pSnack = Math.max(12, Math.min(26, Math.round(dayP * 0.09)));
    const usedProt = new Set();  // eiwit-families die vandaag al gebruikt zijn
    const usedCarb = new Set();  // koolhydraat-families die vandaag al gebruikt zijn
    const meals = [];
    let miss = false;
    for (const md of moments) {
      const prods = chosenProducts.filter((p) => p.moment === md.id);
      let meal = prods.length ? scaleProduct(prods[ti % prods.length], Math.round(dayT.kcal * 0.32)) : null;
      if (!meal) {
        const cands = await candidatesFor(md.id);
        if (cands.length) {
          let dish;
          if (variety === "fixed" && fixedMain[md.id] && cands.indexOf(fixedMain[md.id]) !== -1) {
            dish = fixedMain[md.id]; // vaste patronen: zelfde gerecht, alleen porties schalen
          } else {
            // 1e keus: koolhydraat-houdend, nieuwe eiwit-familie (niet vandaag, bij variatie
            // ook niet gisteren) én nieuwe koolhydraat-familie. Daarna lossere pogingen.
            const freshP = (d) => !usedProt.has(protFamOf(d)) && (!avoidYesterday || lastProt[md.id] !== protFamOf(d));
            const freshC = (d) => { const cf = carbFamOf(d); return !cf || !usedCarb.has(cf); };
            const off = ti * 3 + md.rot;
            dish = pick(cands, off, (d) => hasCarb(d) && freshP(d) && freshC(d));
            if (!dish) dish = pick(cands, off, (d) => hasCarb(d) && freshP(d));
            if (!dish) dish = pick(cands, off, (d) => freshP(d));
            if (!dish) dish = cands[off % cands.length];
            if (variety === "fixed") fixedMain[md.id] = dish;
          }
          meal = scaleDish(dish, pMain, 2.2, carbMult, 26);
          usedProt.add(protFamOf(dish)); lastProt[md.id] = protFamOf(dish);
          const cf = carbFamOf(dish); if (cf) usedCarb.add(cf);
        }
      }
      if (!meal) { gaps.push({ moment: md.id, chips: (prefIds[md.id] || []).filter((x) => typeof x === "string") }); miss = true; break; }
      meal.t = md.label; meals.push(meal);
    }
    if (miss) return { complete: false, gaps };
    for (let s = 0; s < nSnack; s++) {
      const prods = chosenProducts.filter((p) => p.moment === "snack");
      let meal = prods.length ? scaleProduct(prods[(ti + s) % prods.length], Math.round(dayT.kcal * 0.10)) : null;
      if (!meal) {
        const cands = await candidatesFor("snack");
        if (cands.length) {
          let dish;
          if (variety === "fixed" && fixedSnack[s] && cands.indexOf(fixedSnack[s]) !== -1) {
            dish = fixedSnack[s];
          } else {
            const off = ti * 2 + s;
            dish = pick(cands, off, (d) => !usedProt.has(protFamOf(d)));
            if (!dish) dish = cands[off % cands.length];
            if (variety === "fixed") fixedSnack[s] = dish;
          }
          meal = scaleDish(dish, pSnack, 1.6, 1, 20);
          usedProt.add(protFamOf(dish));
        }
      }
      if (!meal) { gaps.push({ moment: "snack", chips: (prefIds.snack || []).filter((x) => typeof x === "string") }); miss = true; break; }
      meal.t = snackLabel; meals.push(meal);
    }
    if (miss) return { complete: false, gaps };
    days.push({ d: r.label, m: meals });
  }
  if (!days.length) return { complete: false, gaps };
  return { complete: true, plan: { days } };
}

// Generieke AI-call voor korte JSON-taken (weekreview). Zelfde provider-switch
// + fallback als de maaltijd-generatie, maar los herbruikbaar en met klein budget.
async function callModel(prompt, haiku) {
  const anKey = process.env.ANTHROPIC_API_KEY;
  const orKey = process.env.OPENROUTER_API_KEY;
  const provider = (process.env.AI_PROVIDER || "anthropic").toLowerCase();
  if (!anKey && !orKey) return { err: "geen AI-sleutel" };
  const mAn = haiku ? (process.env.AI_MODEL_HAIKU || "claude-3-5-haiku-latest") : (process.env.AI_MODEL_ANTHROPIC || "claude-sonnet-4-6");
  const mOr = haiku ? (process.env.AI_MODEL_HAIKU_OR || "anthropic/claude-3.5-haiku") : (process.env.AI_MODEL || "anthropic/claude-sonnet-4");
  async function an() {
    if (!anKey) return { err: "ANTHROPIC_API_KEY ontbreekt" };
    const r = await fetch("https://api.anthropic.com/v1/messages", { method: "POST", headers: { "Content-Type": "application/json", "x-api-key": anKey, "anthropic-version": "2023-06-01" }, body: JSON.stringify({ model: mAn, max_tokens: 1500, messages: [{ role: "user", content: prompt }] }) });
    if (!r.ok) return { err: "anthropic " + r.status, detail: (await r.text()).slice(0, 200) };
    const d = await r.json(); return { text: (d.content || []).filter((x) => x.type === "text").map((x) => x.text).join("").trim() };
  }
  async function or() {
    if (!orKey) return { err: "OPENROUTER_API_KEY ontbreekt" };
    const r = await fetch("https://openrouter.ai/api/v1/chat/completions", { method: "POST", headers: { "Content-Type": "application/json", "Authorization": "Bearer " + orKey, "HTTP-Referer": "https://hybridfuelco.com", "X-Title": "HybridFuelCo" }, body: JSON.stringify({ model: mOr, max_tokens: 1500, messages: [{ role: "user", content: prompt }] }) });
    if (!r.ok) return { err: "openrouter " + r.status, detail: (await r.text()).slice(0, 200) };
    const d = await r.json(); const m = d.choices && d.choices[0] && d.choices[0].message; let c = m && m.content; if (Array.isArray(c)) c = c.map((x) => (x && x.text) || "").join(""); return { text: (c || "").trim() };
  }
  let out = provider === "openrouter" ? await or() : await an();
  if ((out.err || !out.text) && (provider === "openrouter" ? anKey : orKey)) out = provider === "openrouter" ? await an() : await or();
  return out;
}
function parseJsonLoose(text) {
  let t = (text || "").replace(/```json/gi, "").replace(/```/g, "").trim();
  try { return JSON.parse(t); } catch (e) { const a = t.indexOf("{"), b = t.lastIndexOf("}"); if (a >= 0 && b > a) { try { return JSON.parse(t.slice(a, b + 1)); } catch (e2) {} } return null; }
}
// Weekreview-prompt: coachen BINNEN de kaders. Kerndoelen (kcal/macro's) liggen
// vast en veranderen NOOIT; alleen kleine, veilige aanpassingen voor de indeling
// van komende week, afgestemd op de trainingsmethode (train/rust-dagen).
function weekReviewPrompt(rv, lang) {
  const nl = lang !== "en";
  const t = rv.targets || {};
  const tr = t.train || {}, rs = t.rest || {};
  const facts = [
    `window: ${rv.window && rv.window.start} .. ${rv.window && rv.window.end} (7 days)`,
    `days logged: ${rv.daysLogged} / 7`,
    `avg kcal eaten: ${rv.avgKcalEaten || "unknown"}`,
    `target kcal: ${t.kcal || "unknown"} (protein ${t.protein || "?"}g / carbs ${t.carbs || "?"}g / fat ${t.fat || "?"}g)`,
    `training-day target kcal: ${tr.kcal || "?"} · rest-day target kcal: ${rs.kcal || "?"}`,
    `trainings planned: ${rv.trainingPlanned} · trainings done: ${rv.trainingDone}`,
    `weight start: ${rv.weightStart != null ? rv.weightStart + " kg" : "unknown"} · weight end: ${rv.weightEnd != null ? rv.weightEnd + " kg" : "unknown"}`,
  ].join("\n");
  const rules = nl
    ? `Je bent de HybridFuel coaching-engine. Beoordeel de afgelopen 7 dagen van deze sporter en stel een KORTE review op.
HARDE REGELS:
- De kerndoelen (kcal + macro's) liggen VAST en veranderen NOOIT. Stel die niet bij.
- Geef alleen kleine, veilige aanpassingen voor de INDELING van komende week: consistentie van loggen, eiwit halen, en vooral de afstemming op de trainingsmethode (meer koolhydraten/energie op trainingsdagen, minder op rustdagen) en of de geplande trainingen gehaald zijn.
- Blijf binnen de veilige tempo-normen (vetverlies 0,5–1%/wk, onderhoud ±0,5%, opbouw 0,25–0,5%). Nooit crash-advies.
- Weinig data (weinig dagen gelogd of onbekende waarden)? Zeg dat eerlijk en houd het mild; verzin geen cijfers.
- Jij adviseert, de gebruiker beslist. Geen medische claims.
Toon = "attention" als er iets duidelijk afwijkt (veel onder/boven de kcal, trainingen gemist, gewicht verkeerde kant op t.o.v. doel), anders "ok".
Antwoord UITSLUITEND als JSON, geen tekst eromheen:
{"tone":"ok"|"attention","headline":"korte kop (max ~8 woorden)","summary":"2-4 zinnen in het Nederlands","actions":["actie 1","actie 2","actie 3"]}
Maximaal 3 acties, elk één concrete zin.`
    : `You are the HybridFuel coaching engine. Review this athlete's last 7 days and write a SHORT review.
HARD RULES:
- Core targets (kcal + macros) are FIXED and NEVER change. Do not adjust them.
- Only suggest small, safe tweaks to how NEXT week is laid out: logging consistency, hitting protein, and above all fit to the training method (more carbs/energy on training days, less on rest days) and whether planned trainings were done.
- Stay within safe-rate norms (fat loss 0.5–1%/wk, maintenance ±0.5%, lean gain 0.25–0.5%). Never crash advice.
- Thin data (few days logged or unknown values)? Say so honestly and keep it gentle; do not invent numbers.
- You advise, the user decides. No medical claims.
Tone = "attention" if something clearly deviates (well under/over kcal, missed trainings, weight moving wrong way vs goal), else "ok".
Reply ONLY as JSON, no surrounding text:
{"tone":"ok"|"attention","headline":"short headline (max ~8 words)","summary":"2-4 sentences in English","actions":["action 1","action 2","action 3"]}
At most 3 actions, each one concrete sentence.`;
  return rules + "\n\nDATA:\n" + facts;
}
async function buildWeekReview(body) {
  const lang = body.lang === "en" ? "en" : "nl";
  const out = await callModel(weekReviewPrompt(body.review || {}, lang), true); // Haiku: kort + goedkoop
  if (out.err || !out.text) return { err: out.err || "leeg antwoord", detail: out.detail };
  const j = parseJsonLoose(out.text);
  if (!j || typeof j !== "object") return { err: "onleesbaar" };
  const headline = String(j.headline || "").slice(0, 120).trim();
  const summary = String(j.summary || "").slice(0, 700).trim();
  if (!headline || !summary) return { err: "incompleet" };
  const actions = Array.isArray(j.actions) ? j.actions.map((a) => String(a).slice(0, 200).trim()).filter(Boolean).slice(0, 3) : [];
  return { review: { tone: j.tone === "attention" ? "attention" : "ok", headline, summary, actions } };
}

// Gat-logboek: elk eetmoment zonder passend gerecht wordt vastgelegd, zodat
// zichtbaar wordt welke recepten de bibliotheek mist. Best-effort: faalt stil,
// blokkeert nooit een plan. Lijst wordt op 1000 regels gehouden.
async function logGaps(gaps) {
  try {
    const ts = new Date().toISOString();
    for (const g of gaps.slice(0, 8)) {
      const line = JSON.stringify({ ts, moment: g.moment, chips: (g.chips || []).slice(0, 10) });
      try { console.log("[recipe-gap] " + line); } catch (e) {}
      if (kvConfigured()) { try { await kv(["RPUSH", "hf:gaps", line]); } catch (e) {} }
    }
    if (kvConfigured()) { try { await kv(["LTRIM", "hf:gaps", "-1000", "-1"]); } catch (e) {} }
  } catch (e) { /* nooit blokkeren */ }
}

// --- Foto-AI productherkenning (mode: "product-scan") ---------------------
// Pro-abonnee: subscriptions-rij met tier=pro, actief/trialing, niet verlopen.
async function proSub(authToken) {
  if (!authToken || typeof authToken !== "string") return false;
  try {
    const { url, headers } = supaBase();
    const r = await fetch(url + "/rest/v1/subscriptions?select=tier,status,current_period_end", { headers: { apikey: headers.apikey, Authorization: "Bearer " + authToken } });
    if (!r.ok) return false;
    const s = (await r.json().catch(() => []))[0];
    if (!s) return false;
    const activeStatus = s.status === "active" || s.status === "trialing";
    const notExpired = !!s.current_period_end && new Date(s.current_period_end).getTime() > Date.now();
    return !!(activeStatus && s.tier === "pro" && notExpired);
  } catch (e) { return false; }
}
function parseDataUrl(s) {
  const m = /^data:(image\/(?:jpeg|png|webp));base64,([A-Za-z0-9+/=]+)$/.exec(String(s || ""));
  if (!m) return null;
  if (m[2].length > 7000000) return null; // ~5 MB
  return { media_type: m[1], data: m[2] };
}
function cleanNum(v) {
  if (v == null) return null;
  const n = parseFloat(String(v).replace(",", "."));
  if (!isFinite(n) || n < 0 || n > 10000) return null;
  return Math.round(n * 10) / 10;
}
const SCAN_PROMPT_NL = `Je krijgt 1-4 foto's van ÉÉN voedingsproduct (meestal de voorkant + de voedingswaardentabel).
Haal eruit: productnaam, merk, en de voedingswaarden PER 100 g (of per 100 ml): kcal, eiwit (g), koolhydraten (g), vet (g).
Regels:
- Lees de getallen uit de tabel. Staat de tabel per portie i.p.v. per 100 g, reken dan om naar per 100 g.
- Zie je een waarde niet duidelijk? Zet die op null. NOOIT een getal verzinnen of schatten.
- Geen product of geen leesbare tabel? Geef alles null en confident:false.
Antwoord UITSLUITEND als JSON, niets eromheen:
{"name":"...","brand":"...","per_100":{"kcal":123,"p":12.3,"c":4.5,"f":0.2},"confident":true}`;
const SCAN_PROMPT_EN = `You get 1-4 photos of ONE food product (usually the front + the nutrition table).
Extract: product name, brand, and nutrition PER 100 g (or per 100 ml): kcal, protein (g), carbs (g), fat (g).
Rules:
- Read the numbers from the table. If it's per serving instead of per 100 g, convert to per 100 g.
- Can't read a value clearly? Set it to null. NEVER invent or estimate a number.
- No product or no readable table? Return all null and confident:false.
Reply ONLY as JSON, nothing around it:
{"name":"...","brand":"...","per_100":{"kcal":123,"p":12.3,"c":4.5,"f":0.2},"confident":true}`;
async function callVisionAnthropic(imgs, lang) {
  const key = process.env.ANTHROPIC_API_KEY;
  if (!key) return { err: "ANTHROPIC_API_KEY ontbreekt" };
  const model = process.env.AI_MODEL_VISION || process.env.AI_MODEL_HAIKU || "claude-3-5-haiku-latest";
  const content = imgs.map((im) => ({ type: "image", source: { type: "base64", media_type: im.media_type, data: im.data } }));
  content.push({ type: "text", text: lang === "en" ? SCAN_PROMPT_EN : SCAN_PROMPT_NL });
  const r = await fetch("https://api.anthropic.com/v1/messages", { method: "POST", headers: { "Content-Type": "application/json", "x-api-key": key, "anthropic-version": "2023-06-01" }, body: JSON.stringify({ model, max_tokens: 700, messages: [{ role: "user", content }] }) });
  if (!r.ok) return { err: "anthropic " + r.status, detail: (await r.text()).slice(0, 200) };
  const d = await r.json();
  return { text: (d.content || []).filter((x) => x.type === "text").map((x) => x.text).join("").trim() };
}
async function callVisionOpenRouter(imgs, lang) {
  const key = process.env.OPENROUTER_API_KEY;
  if (!key) return { err: "OPENROUTER_API_KEY ontbreekt" };
  const model = process.env.AI_MODEL_VISION_OR || "anthropic/claude-3.5-haiku";
  const content = imgs.map((im) => ({ type: "image_url", image_url: { url: "data:" + im.media_type + ";base64," + im.data } }));
  content.push({ type: "text", text: lang === "en" ? SCAN_PROMPT_EN : SCAN_PROMPT_NL });
  const r = await fetch("https://openrouter.ai/api/v1/chat/completions", { method: "POST", headers: { "Content-Type": "application/json", Authorization: "Bearer " + key, "HTTP-Referer": "https://hybridfuelco.com", "X-Title": "HybridFuelCo" }, body: JSON.stringify({ model, max_tokens: 700, messages: [{ role: "user", content }] }) });
  if (!r.ok) return { err: "openrouter " + r.status, detail: (await r.text()).slice(0, 200) };
  const d = await r.json();
  const m = d.choices && d.choices[0] && d.choices[0].message;
  let c = m && m.content; if (Array.isArray(c)) c = c.map((x) => (x && x.text) || "").join("");
  return { text: (c || "").trim() };
}
async function buildProductScan(body) {
  const lang = body.lang === "en" ? "en" : "nl";
  const raw = Array.isArray(body.images) ? body.images.slice(0, 4) : [];
  const imgs = raw.map(parseDataUrl).filter(Boolean);
  if (!imgs.length) return { err: "no_images" };
  const provider = (process.env.AI_PROVIDER || "anthropic").toLowerCase();
  let out = provider === "openrouter" ? await callVisionOpenRouter(imgs, lang) : await callVisionAnthropic(imgs, lang);
  if (out.err || !out.text) { const alt = provider === "openrouter" ? await callVisionAnthropic(imgs, lang) : await callVisionOpenRouter(imgs, lang); if (!alt.err && alt.text) out = alt; }
  if (out.err || !out.text) return { err: out.err || "leeg" };
  const j = parseJsonLoose(out.text);
  if (!j || typeof j !== "object") return { err: "onleesbaar" };
  const per = j.per_100 || {};
  return { result: { name: String(j.name || "").slice(0, 120).trim(), brand: String(j.brand || "").slice(0, 80).trim(), per_100: { kcal: cleanNum(per.kcal), p: cleanNum(per.p), c: cleanNum(per.c), f: cleanNum(per.f) }, confident: j.confident !== false } };
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
    const gym = await gymProfile(body.authToken); // { access, tier } — toegang via de sportschool
    const gymOk = gym.access;
    const access = subVerified || gymOk; // echte toegang zonder betaalmuur

    // WEEKREVIEW: korte AI-coaching op de 7-daagse logging, binnen de kaders.
    // Alleen voor abonnees/leden; eigen (goedkope) Haiku-call, met rate-limit-backstop.
    if (body.mode === "weekreview") {
      const wlang = body.lang === "en" ? "en" : "nl";
      if (!trusted && !access) {
        return res.status(200).json({ error: wlang === "nl" ? "Weekreview is voor abonnees en leden." : "Week review is for subscribers and members." });
      }
      if (!trusted) {
        const ip = (req.headers["x-forwarded-for"] || "unknown").split(",")[0].trim();
        if (rateLimited(ip)) return res.status(429).json({ error: wlang === "nl" ? "Even te druk — probeer het zo weer." : "Too busy right now — try again shortly." });
      }
      const wr = await buildWeekReview(body);
      if (wr.err || !wr.review) {
        return res.status(502).json({ error: wlang === "nl" ? "Kon de review niet maken. Probeer het zo opnieuw." : "Couldn't build the review. Try again shortly.", detail: wr.err || "leeg" });
      }
      return res.status(200).json({ review: wr.review });
    }

    // FOTO-AI PRODUCTHERKENNING: naam + merk + voedingswaarden per 100 g uit 1-4
    // foto's. Gate = Pro-abonnee OF gym-lid (gelijk aan de app-gate op Producten).
    if (body.mode === "product-scan") {
      const slang = body.lang === "en" ? "en" : "nl";
      const okAccess = trusted || gymOk || (await proSub(body.authToken));
      if (!okAccess) {
        return res.status(403).json({ error: slang === "nl" ? "Foto-herkenning zit in Pro (of je sportschool-lidmaatschap)." : "Photo recognition is part of Pro (or your gym membership)." });
      }
      if (!trusted) {
        const ip = (req.headers["x-forwarded-for"] || "unknown").split(",")[0].trim();
        if (rateLimited(ip)) return res.status(429).json({ error: slang === "nl" ? "Even te druk — probeer het zo weer." : "Too busy right now — try again shortly." });
      }
      const ps = await buildProductScan(body);
      if (ps.err || !ps.result) {
        if (ps.err === "no_images") return res.status(400).json({ error: slang === "nl" ? "Geen geldige foto's ontvangen." : "No valid photos received." });
        return res.status(502).json({ error: slang === "nl" ? "Herkenning lukte niet. Probeer het opnieuw of vul handmatig in." : "Recognition failed. Try again or fill in manually.", detail: ps.err });
      }
      return res.status(200).json({ result: ps.result });
    }

    const paidVerified = isPaid && (trusted || access || validToken(body.token));
    if (!trusted && !paidVerified) {
      return res.status(200).json({ targets, plan: null, locked: true });
    }

    // DATABASE-FIRST: voor abonnees/gym-leden (en automatisering) eerst uit de
    // gerechten-bibliotheek bouwen — gratis, instant, geen AI-kosten, geen credit.
    // Alleen als een eetmoment geen enkel passend gerecht heeft, valt 't door naar AI.
    if (trusted || access) {
      try {
        const lib = await buildFromLibrary(body, cyc);
        if (lib && lib.complete && lib.plan && lib.plan.days && lib.plan.days.length) {
          return res.status(200).json({ targets, plan: lib.plan, source: "library" });
        }
        // Gat-logboek: welke eetmomenten + keuzes hadden geen passend gerecht?
        // Stuurt welke recepten Mounir moet toevoegen. Best-effort, blokkeert nooit.
        if (lib && Array.isArray(lib.gaps) && lib.gaps.length) await logGaps(lib.gaps);
      } catch (e) { /* bibliotheek onbereikbaar → AI-vangnet hieronder */ }
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
    if (!trusted && !access && kvConfigured()) {
      const sid = tokenSid(body.token);
      const dec = sid ? await kv(["DECR", "cr:" + sid]) : { result: -1 };
      const n = typeof dec.result === "number" ? dec.result : parseInt(dec.result, 10);
      if (!(n >= 0)) {
        // Geen credits meer (of geen geldig record) → klem op 0 en terug naar de betaalmuur.
        if (sid) { try { await kv(["SET", "cr:" + sid, "0", "EX", "15552000"]); } catch (e) {} }
        return res.status(200).json({ targets, plan: null, locked: true, reason: "no_credits" });
      }
    }

    // Credit-budget per member (maandelijks). 1 credit = 1 verse AI-generatie.
    // Gym-lid: budget per tier — Basis en Pro, instelbaar via env (CREDITS_BASIS/CREDITS_PRO).
    // Abonnee zonder gym-tier: ruime fair-use-backstop (PLAN_LIMIT_PER_MONTH).
    // Op = GEEN MUUR: val terug op de software-kant (macro-targets + dagindeling,
    // en waar mogelijk een plan uit de eigen/gym-producten) — geen AI, geen kosten.
    // Reset maandelijks (key bevat de maand). Faalt OPEN bij opslagstoring.
    const CREDITS = {
      basis: parseInt(process.env.CREDITS_BASIS || "15", 10),
      pro: parseInt(process.env.CREDITS_PRO || "40", 10),
    };
    let softwareFallback = false;
    if (!trusted && access && kvConfigured()) {
      const uid = jwtSub(body.authToken);
      const budget = gymOk ? CREDITS[gym.tier] : parseInt(process.env.PLAN_LIMIT_PER_MONTH || "100", 10);
      if (uid && budget > 0) {
        try {
          const mk = "gen:" + uid + ":" + new Date().toISOString().slice(0, 7);
          const inc = await kv(["INCR", mk]);
          const n = typeof inc.result === "number" ? inc.result : parseInt(inc.result, 10);
          if (n === 1) { try { await kv(["EXPIRE", mk, "3456000"]); } catch (e) {} } // ~40 dagen
          if (n > budget) {
            softwareFallback = true;
            // Boven budget rekenen we geen AI-generatie → teller terugzetten op het budget.
            try { await kv(["DECR", mk]); } catch (e) {}
          }
        } catch (e) { /* opslag onbereikbaar → niet blokkeren */ }
      }
    }
    if (softwareFallback) {
      // Geen betaalmuur: de app bouwt zelf verder op deze targets (software).
      return res.status(200).json({ targets, plan: null, softwareFallback: true, tier: gym.tier });
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

    // Model per tier: Basis draait op Haiku (snel + goedkoop), Pro op Sonnet (betere plannen).
    // Gym-tier bepaalt het model; abonnees/overig blijven op Sonnet. Alles via env te zetten.
    const useHaiku = gymOk && gym.tier === "basis";
    const modelAnthropic = useHaiku
      ? (process.env.AI_MODEL_HAIKU || "claude-3-5-haiku-latest")
      : (process.env.AI_MODEL_ANTHROPIC || "claude-sonnet-4-6");
    const modelOpenRouter = useHaiku
      ? (process.env.AI_MODEL_HAIKU_OR || "anthropic/claude-3.5-haiku")
      : (process.env.AI_MODEL || "anthropic/claude-sonnet-4");

    async function callAnthropic() {
      if (!anKey) return { err: "ANTHROPIC_API_KEY ontbreekt" };
      const r = await fetch("https://api.anthropic.com/v1/messages", {
        method: "POST",
        headers: { "Content-Type": "application/json", "x-api-key": anKey, "anthropic-version": "2023-06-01" },
        body: JSON.stringify({
          model: modelAnthropic,
          max_tokens: 8000,
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
          model: modelOpenRouter,
          max_tokens: 8000,
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
      // Robuuster: pak het JSON-object tussen de eerste { en de laatste }
      // (vangt omringende tekst of lichte rommel op).
      try {
        const a = text.indexOf("{"), b = text.lastIndexOf("}");
        if (a >= 0 && b > a) plan = JSON.parse(text.slice(a, b + 1));
        else throw e;
      } catch (e2) {
        return res.status(502).json({ error: "Antwoord onleesbaar (mogelijk afgekapt).", detail: text.slice(0, 120) });
      }
    }

    return res.status(200).json({ targets, plan, source: "ai" });
  } catch (e) {
    return res.status(500).json({ error: "Serverfout", detail: String(e).slice(0, 200) });
  }
}



