// Stelt een weekplan samen uit de EIGEN producten (en optioneel eigen opgeslagen
// maaltijden) van de klant, zonder AI. Macro-bewust: mikt per maaltijd op eiwit +
// koolhydraten (eiwit eerst), niet alleen op calorieën.
//
// Product: { name, brand, per_100:{kcal,p,c,f}, meal_types?:['breakfast'|'lunch'|'dinner'|'snack'] }
//   leeg meal_types = overal bruikbaar.
// Opgeslagen maaltijd (optioneel): { name, type, ing:[{n,g}], macros:{kcal,p,c,f} }
//
// Output = exact dezelfde vorm als de AI-generator:
//   { days: [ { d, train, m: [ { t, n, kcal, p, c, f, ing:[{n,g}] } ] } ] }

const SLOT_LABEL = {
  breakfast: { nl: "Ontbijt", en: "Breakfast" },
  lunch: { nl: "Lunch", en: "Lunch" },
  dinner: { nl: "Diner", en: "Dinner" },
  snack: { nl: "Snack", en: "Snack" },
};

function num(v) { const n = parseFloat(v); return isNaN(n) ? 0 : n; }
function per100(p) { const x = (p && p.per_100) || {}; return { kcal: num(x.kcal), p: num(x.p), c: num(x.c), f: num(x.f) }; }
function productName(p) { const nm = (p && p.name) || ""; const br = (p && p.brand) || ""; return br ? nm + " (" + br + ")" : nm; }
function roundG(g) { let r = Math.round(g / 5) * 5; if (r < 10) r = 10; return r; }

// Kandidaten voor een maaltijdtype: getagd voor dit type, plus producten zonder tags.
function candidatesFor(products, slot) {
  return products.filter((p) => {
    if (per100(p).kcal <= 0) return false;
    const mt = Array.isArray(p.meal_types) ? p.meal_types : [];
    return mt.length === 0 || mt.includes(slot);
  });
}
function mealsForSlot(meals, slot) {
  return (meals || []).filter((m) => m && m.macros && num(m.macros.kcal) > 0 && (!m.type || m.type === slot));
}

// Schaalt een opgeslagen maaltijd naar de doel-kcal (gewichten + macro's mee).
function scaleSavedMeal(meal, kcalTarget, label) {
  const base = num(meal.macros.kcal) || 1;
  const f = Math.max(0.3, Math.min(2.5, kcalTarget / base));
  const ing = (meal.ing || []).map((x) => ({ n: x.n, g: roundG(num(x.g) * f) }));
  return {
    t: label, n: meal.name || label,
    kcal: Math.round(num(meal.macros.kcal) * f), p: Math.round(num(meal.macros.p) * f),
    c: Math.round(num(meal.macros.c) * f), f: Math.round(num(meal.macros.f) * f),
    ing,
  };
}

// Kiest een item uit een lijst, geroteerd per dag/slot voor variatie.
function pick(list, offset) { return list.length ? list[((offset % list.length) + list.length) % list.length] : null; }
const idOf = (p) => p && (p.id || p.name);

// Rol van een product op basis van z'n dominante macro (en caloriedichtheid).
// 'veg' = caloriearme vulling (bv. broccoli), nooit een hoofd-koolhydraatbron.
function roleOf(p) {
  const x = per100(p);
  if (x.kcal < 55) return "veg";
  const ps = x.p * 4, cs = x.c * 4, fs = x.f * 9;
  if (ps >= cs && ps >= fs) return "protein";
  if (fs >= cs && fs > ps) return "fat";
  if (x.kcal < 80) return "veg"; // caloriearm + koolhydraat-dominant = vulling
  return "carb";
}

// Bouwt één maaltijd greedy: eiwit eerst (op eiwitdoel), dan koolhydraten (op
// koolhydraatdoel), dan evt. vet + een groente-side. Realistische porties.
function buildMealMacro(cands, target, dayIdx, label) {
  if (!cands.length) return null;
  const P = Math.max(0, num(target.p)), C = Math.max(0, num(target.c)), F = Math.max(0, num(target.f)), K = Math.max(0, num(target.kcal));
  const byRole = (r) => cands.filter((p) => roleOf(p) === r);
  const protList = byRole("protein").sort((a, b) => per100(b).p - per100(a).p);
  const carbList = byRole("carb").sort((a, b) => per100(b).c - per100(a).c);
  const fatList = byRole("fat").sort((a, b) => per100(b).f - per100(a).f);
  const vegList = byRole("veg");

  const protSrc = pick(protList.slice(0, Math.min(3, protList.length)), dayIdx);
  let carbSrc = pick(carbList.slice(0, Math.min(3, carbList.length)), dayIdx + 1);
  if (carbSrc && protSrc && idOf(carbSrc) === idOf(protSrc)) carbSrc = carbList.find((x) => idOf(x) !== idOf(protSrc)) || null;

  // Geen eiwit- én geen koolhydraatbron herkend → val terug op kcal-schalen.
  if (!protSrc && !carbSrc) return scaleToKcal(cands, target, dayIdx, label);

  const items = [];
  const used = new Set();
  const addItem = (prod, grams) => { if (prod && !used.has(idOf(prod)) && grams >= 8) { items.push([prod, roundG(grams)]); used.add(idOf(prod)); } };

  let remP = P, remC = C, remF = F;
  const sub = (prod, g) => { const x = per100(prod); remP -= x.p * g / 100; remC -= x.c * g / 100; remF -= x.f * g / 100; };

  // 1) Eiwit: dek ~75% van het eiwitdoel met de eiwitbron (de rest komt uit
  //    koolhydraat-/vetbronnen die ook eiwit bevatten → voorkomt overschot).
  if (protSrc) { const pp = per100(protSrc).p || 1; const g = Math.max(20, Math.min(300, (P * 0.75) / (pp / 100))); addItem(protSrc, g); sub(protSrc, roundG(g)); }
  // 2) Koolhydraten: dek de resterende koolhydraten met de koolhydraatbron.
  if (carbSrc && remC > 5) { const cc = per100(carbSrc).c || 1; const g = Math.max(20, Math.min(400, remC / (cc / 100))); addItem(carbSrc, g); sub(carbSrc, roundG(g)); }
  // 3) Vet: als er nog vet mist en er is een vetbron (noten/olie/vette vis) → toevoegen.
  if (remF > 5 && fatList.length) { const fat = pick(fatList, dayIdx + 2); const ff = per100(fat).f || 1; const g = Math.max(8, Math.min(70, remF / (ff / 100))); addItem(fat, g); sub(fat, roundG(g)); }
  // 4) Groente-side voor volume (klein, vast) bij hoofdmaaltijden.
  if (vegList.length && label && items.length) { const veg = pick(vegList, dayIdx + 3); addItem(veg, 120); }

  if (!items.length) return scaleToKcal(cands, target, dayIdx, label);
  let meal = assemble(items, label);
  // Te veel calorieën? Schaal de staples (niet de vaste groente) evenredig terug.
  if (K > 0 && meal.kcal > K * 1.3) {
    const f = (K * 1.1) / meal.kcal;
    meal = assemble(items.map(([prod, g]) => [prod, roundG(g * f)]), label);
  }
  return meal;
}

// Schaalt tot calorie-doel (fallback als macro-oplossen niet kan).
function scaleToKcal(cands, target, dayIdx, label) {
  const take = Math.min(2, cands.length);
  const chosen = [];
  const seen = new Set();
  for (let i = 0; i < take; i++) { const c = pick(cands, dayIdx * 2 + i); const id = c && (c.id || c.name); if (c && !seen.has(id)) { seen.add(id); chosen.push(c); } }
  const kcalAt100 = chosen.reduce((s, p) => s + per100(p).kcal, 0);
  if (kcalAt100 <= 0) return null;
  const f = Math.max(0, num(target.kcal)) / kcalAt100;
  return assemble(chosen.map((p) => [p, roundG(100 * f)]), label);
}

// Zet gekozen [product, grammen] om naar een maaltijd-object.
function assemble(items, label) {
  let kcal = 0, p = 0, c = 0, f = 0; const ing = [];
  for (const [prod, g] of items) {
    const pc = per100(prod);
    kcal += pc.kcal * g / 100; p += pc.p * g / 100; c += pc.c * g / 100; f += pc.f * g / 100;
    ing.push({ n: productName(prod), g });
  }
  if (!ing.length) return null;
  return {
    t: label, n: items.map(([prod]) => (prod.name || "")).filter(Boolean).join(" + ") || label,
    kcal: Math.round(kcal), p: Math.round(p), c: Math.round(c), f: Math.round(f), ing,
  };
}

// Dag-macro's → per-maaltijd macro-doel.
function slice(dayMacros, share) {
  return { kcal: dayMacros.kcal * share, p: dayMacros.p * share, c: dayMacros.c * share, f: dayMacros.f * share };
}

function buildDay(products, meals, dayMacros, dayIdx, nSnacks, lang) {
  const snackShare = Math.min(0.12 * nSnacks, 0.3);
  const mainShare = 1 - snackShare;
  const slots = [["breakfast", 0.3 * mainShare], ["lunch", 0.35 * mainShare], ["dinner", 0.35 * mainShare]];
  const out = [];
  for (let s = 0; s < nSnacks; s++) slots.push(["snack", snackShare / Math.max(1, nSnacks)]);
  slots.forEach(([slot, share], idx) => {
    const label = SLOT_LABEL[slot][lang === "nl" ? "nl" : "en"];
    const target = slice(dayMacros, share);
    const savedForSlot = mealsForSlot(meals, slot);
    if (savedForSlot.length) { // eigen opgeslagen maaltijd heeft voorrang
      const meal = pick(savedForSlot, dayIdx + idx);
      if (meal) { out.push(scaleSavedMeal(meal, target.kcal, label)); return; }
    }
    const cands = candidatesFor(products, slot);
    const meal = buildMealMacro(cands, target, dayIdx + idx, label);
    if (meal) out.push(meal);
  });
  return out;
}

export function productPlanReadiness(products, meals) {
  const list = Array.isArray(products) ? products.filter((p) => per100(p).kcal > 0) : [];
  const cover = { breakfast: 0, lunch: 0, dinner: 0, snack: 0 };
  for (const slot of Object.keys(cover)) cover[slot] = candidatesFor(list, slot).length + mealsForSlot(meals, slot).length;
  const mainsCovered = ["breakfast", "lunch", "dinner"].every((s) => cover[s] > 0);
  return { total: list.length, cover, mainsCovered };
}

// Hoofdfunctie. targets heeft per dag macro's: { kcal, protein, carbs, fat, train:{...}, rest:{...} }.
export function buildDaysFromProducts({ products, meals, targets, intake, WD }) {
  const lang = (intake && intake.lang === "nl") ? "nl" : "en";
  const list = Array.isArray(products) ? products.filter((p) => per100(p).kcal > 0) : [];
  const names = WD[lang] || WD.en;
  const td = (intake && intake.trainingDays) || [];
  const nTrain = td.length;
  const nSnacks = Math.max(0, Math.min(3, parseInt(intake && intake.snacks, 10) || 0));
  const macroOf = (dm) => ({ kcal: num(dm && dm.kcal) || 2000, p: num(dm && dm.protein), c: num(dm && dm.carbs), f: num(dm && dm.fat) });
  const trainM = macroOf((targets && targets.train) || targets);
  const restM = macroOf((targets && targets.rest) || targets);

  const days = names.map((d, i) => {
    const isTrain = nTrain === 7 ? true : nTrain === 0 ? false : td.includes(i);
    const dm = isTrain ? trainM : restM;
    return { d, train: isTrain, m: buildDay(list, meals, dm, i, nSnacks, lang) };
  });
  return { days };
}
