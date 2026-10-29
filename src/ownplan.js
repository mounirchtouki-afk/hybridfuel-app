// Stelt een weekplan samen uit de EIGEN producten van de klant (gescand/aangemaakt),
// zonder AI. Elk product heeft per_100 {kcal,p,c,f} en optioneel meal_types
// (['breakfast'|'lunch'|'dinner'|'snack']). Leeg meal_types = bruikbaar in elke maaltijd.
//
// Output heeft exact dezelfde vorm als de AI-generator, zodat de app 'm 1-op-1 toont:
//   { days: [ { d, train, m: [ { t, n, kcal, p, c, f, ing:[{n,g}] } ] } ] }

const SLOT_LABEL = {
  breakfast: { nl: "Ontbijt", en: "Breakfast" },
  lunch: { nl: "Lunch", en: "Lunch" },
  dinner: { nl: "Diner", en: "Dinner" },
  snack: { nl: "Snack", en: "Snack" },
};

function num(v) { const n = parseFloat(v); return isNaN(n) ? 0 : n; }
function per100(p) { const x = (p && p.per_100) || {}; return { kcal: num(x.kcal), p: num(x.p), c: num(x.c), f: num(x.f) }; }
function productName(p, lang) { const nm = (p && p.name) || ""; const br = (p && p.brand) || ""; return br ? nm + " (" + br + ")" : nm; }

// Kandidaten voor een maaltijdtype: producten getagd voor dit type, plus producten
// zonder tags (overal bruikbaar). Producten zonder bruikbare kcal vallen af.
function candidatesFor(products, slot) {
  return products.filter((p) => {
    if (per100(p).kcal <= 0) return false;
    const mt = Array.isArray(p.meal_types) ? p.meal_types : [];
    return mt.length === 0 || mt.includes(slot);
  });
}

// Bouwt één maaltijd: kies tot `k` producten (geroteerd per dag voor variatie),
// zet ze op 100 g elk, schaal daarna alles zodat de kcal het doel benaderen.
function buildMeal(cands, slot, kcalTarget, dayIdx, lang, k) {
  if (!cands.length || kcalTarget <= 0) return null;
  const n = cands.length;
  const take = Math.max(1, Math.min(k, n));
  const chosen = [];
  for (let i = 0; i < take; i++) chosen.push(cands[(dayIdx * 2 + i) % n]);
  // Dedup (kleine lijsten kunnen herhalen).
  const uniq = [];
  const seen = new Set();
  for (const c of chosen) { const id = c.id || c.name; if (!seen.has(id)) { seen.add(id); uniq.push(c); } }

  const kcalAt100 = uniq.reduce((s, p) => s + per100(p).kcal, 0);
  if (kcalAt100 <= 0) return null;
  const factor = kcalTarget / kcalAt100; // zelfde factor op elk product (100 g * factor)

  const ing = [];
  let kcal = 0, p = 0, c = 0, f = 0;
  for (const prod of uniq) {
    let g = Math.round((100 * factor) / 5) * 5;
    if (g < 10) g = 10;
    const pc = per100(prod);
    kcal += (pc.kcal * g) / 100; p += (pc.p * g) / 100; c += (pc.c * g) / 100; f += (pc.f * g) / 100;
    ing.push({ n: productName(prod, lang), g });
  }
  const label = SLOT_LABEL[slot][lang === "nl" ? "nl" : "en"];
  return {
    t: label,
    n: uniq.map((x) => (x.name || "")).filter(Boolean).join(" + ") || label,
    kcal: Math.round(kcal), p: Math.round(p), c: Math.round(c), f: Math.round(f),
    ing,
  };
}

// Geeft per dag de maaltijden terug. `nSnacks` = aantal tussendoortjes (0-3).
function buildDay(products, dayKcal, dayIdx, nSnacks, lang) {
  const snackShare = Math.min(0.12 * nSnacks, 0.3);
  const mainShare = 1 - snackShare;
  const mains = [
    ["breakfast", 0.3 * mainShare],
    ["lunch", 0.35 * mainShare],
    ["dinner", 0.35 * mainShare],
  ];
  const meals = [];
  for (const [slot, share] of mains) {
    const cands = candidatesFor(products, slot);
    const meal = buildMeal(cands, slot, Math.round(dayKcal * share), dayIdx, lang, 2);
    if (meal) meals.push(meal);
  }
  for (let s = 0; s < nSnacks; s++) {
    const cands = candidatesFor(products, "snack");
    const meal = buildMeal(cands, "snack", Math.round((dayKcal * snackShare) / Math.max(1, nSnacks)), dayIdx + s, lang, 1);
    if (meal) meals.push(meal);
  }
  return meals;
}

// Hoeveel maaltijdtypes kunnen we überhaupt vullen? (Voor een nette foutmelding.)
export function productPlanReadiness(products) {
  const list = Array.isArray(products) ? products.filter((p) => per100(p).kcal > 0) : [];
  const cover = { breakfast: 0, lunch: 0, dinner: 0, snack: 0 };
  for (const slot of Object.keys(cover)) cover[slot] = candidatesFor(list, slot).length;
  const mainsCovered = ["breakfast", "lunch", "dinner"].every((s) => cover[s] > 0);
  return { total: list.length, cover, mainsCovered };
}

// Hoofdfunctie. targets = { kcal, train:{kcal}, rest:{kcal}, trainingCount } ; intake = { trainingDays, snacks, lang }.
export function buildDaysFromProducts({ products, targets, intake, WD }) {
  const lang = (intake && intake.lang === "nl") ? "nl" : "en";
  const list = Array.isArray(products) ? products.filter((p) => per100(p).kcal > 0) : [];
  const names = WD[lang] || WD.en;
  const td = (intake && intake.trainingDays) || [];
  const nTrain = td.length;
  const nSnacks = Math.max(0, Math.min(3, parseInt(intake && intake.snacks, 10) || 0));
  const trainKcal = (targets && targets.train && targets.train.kcal) || (targets && targets.kcal) || 2000;
  const restKcal = (targets && targets.rest && targets.rest.kcal) || (targets && targets.kcal) || 2000;

  const days = names.map((d, i) => {
    const isTrain = nTrain === 7 ? true : nTrain === 0 ? false : td.includes(i);
    const dayKcal = isTrain ? trainKcal : restKcal;
    return { d, train: isTrain, m: buildDay(list, dayKcal, i, nSnacks, lang) };
  });
  return { days };
}
