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

// Schaalt een opgeslagen recept naar de doel-kcal, MAAR met dezelfde logica als
// een vers plan: stuk-/portie-producten (serving_g, bv. zalm 150 g) blijven op
// hele porties, de overige ingrediënten herverdelen binnen hun kader, en
// sauzen/accenten worden nooit opgeblazen. prodByName koppelt een ingrediënt
// terug aan het product (voor categorie + portiegewicht).
function scaleSavedMeal(meal, kcalTarget, label, prodByName) {
  const pbn = prodByName || {};
  const rows = (meal.ing || []).map((x) => {
    const g0 = num(x.g);
    const prod = pbn[String(x.n || "").toLowerCase().trim()] || null;
    let p100 = null;
    if (g0 > 0 && (num(x.kcal) || num(x.p) || num(x.c) || num(x.f))) {
      p100 = { kcal: num(x.kcal) / g0 * 100, p: num(x.p) / g0 * 100, c: num(x.c) / g0 * 100, f: num(x.f) / g0 * 100 };
    } else if (prod) { p100 = per100(prod); }
    const serv = prod && num(prod.per_100 && prod.per_100.serving_g) > 0 ? Math.round(num(prod.per_100.serving_g)) : 0;
    const role = classify({ name: x.n, category: prod && prod.category, per_100: p100 || {} });
    return { n: x.n, g: g0, p100, serv, role, locked: false };
  });
  const hasData = rows.some((r) => r.p100);
  if (!hasData) { // geen voedingswaarde per ingrediënt bekend → oude eenvoudige schaling
    const base = num(meal.macros.kcal) || 1;
    const f = Math.max(0.3, Math.min(2.5, kcalTarget / base));
    const ing = rows.map((r) => ({ n: r.n, g: roundG(r.g * f) }));
    return { t: label, n: meal.name || label, kcal: Math.round(num(meal.macros.kcal) * f), p: Math.round(num(meal.macros.p) * f), c: Math.round(num(meal.macros.c) * f), f: Math.round(num(meal.macros.f) * f), ing };
  }
  const kcalOf = (r, g) => (r.p100 ? r.p100.kcal * g / 100 : 0);
  // Stuk-producten: snap op hele porties en hou ze vast.
  rows.forEach((r) => { if (r.serv > 0) { const pcs = Math.max(1, Math.round(r.g / r.serv)); r.g = pcs * r.serv; r.locked = true; } });
  const lockedKcal = rows.filter((r) => r.locked).reduce((a, r) => a + kcalOf(r, r.g), 0);
  const flex = rows.filter((r) => !r.locked);
  // De koolhydraatbasis vangt de resterende calorieën op (binnen kader); de rest
  // (groente/fruit/accent/vet) krijgt een nette vaste portie binnen z'n kader.
  const flexCarb = flex.find((r) => CARB_ROLES.includes(r.role) && r.p100 && r.p100.kcal > 0);
  flex.forEach((r) => { if (r === flexCarb) return; const base = r.g > 0 ? r.g : ((KADER[r.role] || KADER.other).min); r.g = roundG(clampG(base, r.role)); });
  if (flexCarb) {
    const othersKcal = flex.filter((r) => r !== flexCarb).reduce((a, r) => a + kcalOf(r, r.g), 0);
    const remK = kcalTarget - lockedKcal - othersKcal;
    flexCarb.g = roundG(clampG(remK / (flexCarb.p100.kcal / 100), flexCarb.role));
  } else {
    // Geen koolhydraatbasis: schaal de flex-items proportioneel, binnen kader.
    const flexKcal0 = flex.reduce((a, r) => a + kcalOf(r, r.g), 0) || 1;
    const f = Math.max(0.3, Math.min(3, (kcalTarget - lockedKcal) / flexKcal0));
    flex.forEach((r) => { r.g = roundG(clampG(r.g * f, r.role)); });
  }
  // Totalen herberekenen uit de uiteindelijke grammen.
  let kcal = 0, p = 0, c = 0, ff = 0; const ing = [];
  rows.forEach((r) => { if (r.p100) { kcal += r.p100.kcal * r.g / 100; p += r.p100.p * r.g / 100; c += r.p100.c * r.g / 100; ff += r.p100.f * r.g / 100; } ing.push({ n: r.n, g: r.g }); });
  return { t: label, n: meal.name || label, kcal: Math.round(kcal), p: Math.round(p), c: Math.round(c), f: Math.round(ff), ing };
}

// Kiest een item uit een lijst, geroteerd per dag/slot voor variatie.
function pick(list, offset) { return list.length ? list[((offset % list.length) + list.length) % list.length] : null; }
const idOf = (p) => p && (p.id || p.name);

// Realistische portie-kaders per rol (gram), afgestemd met de kok.
const KADER = {
  protein: { min: 120, max: 200 }, mince: { min: 100, max: 150 }, fish: { min: 120, max: 180 },
  eggs: { min: 100, max: 200 }, dairy: { min: 150, max: 300 },
  carbdry: { min: 60, max: 120 }, carbwet: { min: 120, max: 250 }, potato: { min: 200, max: 350 },
  bread: { min: 70, max: 140 }, oats: { min: 40, max: 80 },
  veg: { min: 100, max: 200 }, fruit: { min: 100, max: 200 },
  nuts: { min: 20, max: 40 }, oil: { min: 5, max: 15 }, cheese: { min: 20, max: 40 },
  accent: { min: 5, max: 20 }, bar: { min: 30, max: 80 }, other: { min: 40, max: 200 },
};
// Naam is het sterkste signaal (werkt ongeacht categorie).
const NAME_ROLE = [
  [/honing|honey|siroop|syrup|ketjap|sojasaus|soja|\bsaus\b|sauce|mayo|dressing|\bjam\b|pesto|sambal|mosterd|mustard|hagelslag|\bchoco/i, "accent"],
  [/\bbes\b|bessen|\bberry|berries|banaan|banana|\bappel|\bapple|\bpeer\b|\bpear|aardbei|strawberry|framboos|raspberry|\bmango|\bdruif|druiven|\bgrape|sinaasappel|\borange|\bkiwi|ananas|pineapple|meloen|\bmelon|perzik|\bpeach|abrikoos|\bpruim|\bvijg|dadel|rozijn|\bfruit\b/i, "fruit"],
  [/aardappel|potato|puree|friet|\bfries\b/i, "potato"],
  [/havermout|oats|oatmeal|muesli|granola|cruesli/i, "oats"],
  [/brood|bread|wrap|tortilla|cracker|beschuit|toast|bagel|pita|crackers|knackebrod/i, "bread"],
  [/rijst|\brice\b|pasta|spaghetti|penne|macaroni|couscous|quinoa|bulgur|noedel|noodle|\bmie\b/i, "carb"],
  [/kwark|skyr|yoghurt|yogurt|kefir/i, "dairy"],
  [/kaas|cheese|feta|mozzarella|parmezaan/i, "cheese"],
  [/pindakaas|peanut butter|notenpasta|amandelpasta/i, "nuts"],
  [/\bnoot|noten|nuts|amandel|almond|walnoot|cashew|\bpinda|hazelnoot|zaden|seeds|pit\b/i, "nuts"],
  [/olijfolie|\bolie\b|\boil\b|roomboter|\bboter\b|butter/i, "oil"],
  [/gehakt|mince/i, "mince"],
  [/\bei\b|eieren|\beggs?\b|omelet/i, "eggs"],
  [/zalm|salmon|tonijn|tuna|\bvis\b|\bfish\b|kabeljauw|witvis|garnaal|shrimp|makreel|haring|pangasius|tilapia/i, "fish"],
  [/\bkip|chicken|kalkoen|turkey|\brund|beef|steak|biefstuk|varken|pork|tofu|tempeh|\bham\b|filet|worst|\bspek|bacon|shoarma|peulvrucht|linze|\bbo(o|)n/i, "protein"],
];
function classify(p) {
  const nm = ((p && p.name) || "") + " " + ((p && p.brand) || "");
  const x = per100(p);
  for (const [re, role] of NAME_ROLE) if (re.test(nm)) {
    if (role === "carb") return x.kcal >= 250 ? "carbdry" : "carbwet";
    return role;
  }
  const cat = p && p.category;
  // Fijne categorieën (nieuw) — de categorie wint.
  if (cat === "sauce") return "accent";
  if (cat === "nuts") return "nuts";
  if (cat === "vis") return "fish";
  if (cat === "eieren") return "eggs";
  if (cat === "vlees") return (x.p >= 24 && x.f >= 12) ? "mince" : "protein";
  if (cat === "fruit") return "fruit";
  if (cat === "potato") return "potato";
  if (cat === "bread") return "bread";
  if (cat === "oats") return "oats";
  if (cat === "grain") return x.kcal >= 250 ? "carbdry" : "carbwet";
  if (cat === "dairy") return (x.f * 9 >= x.kcal * 0.5 && x.kcal >= 250) ? "cheese" : "dairy";
  if (cat === "snack") return "bar";
  // Grove/oude categorie "veg" (= groente+fruit) en "meat" (= vlees+vis): op macro splitsen.
  if (cat === "veg") return (x.c >= 10 && x.kcal >= 50) ? "fruit" : "veg";
  if (cat === "meat") return (x.p >= 24 && x.f >= 12) ? "mince" : (x.f >= 8 && x.kcal >= 180 ? "fish" : "protein");
  // Laatste redmiddel: macro's + densiteit.
  const ps = x.p * 4, cs = x.c * 4, fs = x.f * 9;
  if (x.kcal < 55) return "veg";
  if (fs >= cs && fs > ps) return x.kcal >= 700 ? "oil" : "nuts";
  if (ps >= cs && ps >= fs) return "protein";
  if (x.kcal < 80) return "veg";
  return x.kcal >= 250 ? "carbdry" : "carbwet";
}
const PROTEIN_ROLES = ["protein", "mince", "fish", "eggs"];
const CARB_ROLES = ["carbdry", "carbwet", "potato", "bread", "oats"];
const clampG = (g, role) => { const k = KADER[role] || KADER.other; return Math.max(k.min, Math.min(k.max, g)); };

// Bouwt één maaltijd BINNEN de kaders: 1 eiwitbron + 1 koolhydraatbasis + groente,
// elk op z'n macro-doel maar geklemd op een realistische portie. Accenten/sauzen
// worden NOOIT opgeschaald om macro's te halen. Snacks = één logisch tussendoortje.
function buildMealMacro(cands, target, dayIdx, label, slot) {
  if (!cands.length) return null;
  const P = Math.max(0, num(target.p)), C = Math.max(0, num(target.c)), K = Math.max(0, num(target.kcal));
  const tagged = cands.map((p) => ({ p, role: classify(p) }));
  const of = (roles) => tagged.filter((t) => roles.includes(t.role)).map((t) => t.p);

  if (slot === "snack") {
    const pools = [of(["fruit"]), of(["dairy"]), of(["bar"]), of(["nuts"])].filter((l) => l.length);
    const pool = pools.length ? pools[((dayIdx % pools.length) + pools.length) % pools.length] : cands;
    const it = pick(pool, dayIdx);
    if (!it) return scaleToKcal(cands, target, dayIdx, label);
    const r = classify(it), kc = per100(it).kcal || 1;
    return assemble([[it, roundG(clampG((K / kc) * 100, r))]], label);
  }

  const meatish = of(["protein", "mince", "fish"]).sort((a, b) => per100(b).p - per100(a).p);
  const eggs = of(["eggs"]);
  const dairy = of(["dairy"]);
  const vegs = of(["veg"]);
  // Eiwitkeuze: ontbijt pakt zuivel/ei en NOOIT vlees/vis (tenzij er niets anders is).
  const protPool = slot === "breakfast"
    ? ((eggs.length || dairy.length) ? eggs.concat(dairy) : meatish)
    : meatish.concat(eggs);
  // Koolhydraatbasis: ontbijt liefst havermout/brood; lunch/diner rijst/pasta/
  //  aardappel/brood (havermout hoort niet bij een hoofdmaaltijd).
  const carbsAll = of(CARB_ROLES);
  const carbs = slot === "breakfast"
    ? ((of(["oats", "bread"]).length) ? of(["oats", "bread"]) : carbsAll)
    : ((of(["carbdry", "carbwet", "potato", "bread"]).length) ? of(["carbdry", "carbwet", "potato", "bread"]) : carbsAll);

  const protSrc = pick(protPool.slice(0, Math.min(3, protPool.length)), dayIdx) || pick(dairy, dayIdx);
  const carbSrc = pick(carbs.slice(0, Math.min(3, carbs.length)), dayIdx + 1);
  if (!protSrc && !carbSrc) return scaleToKcal(cands, target, dayIdx, label);

  const items = [];
  const used = new Set();
  const add = (prod, grams, role) => { if (prod && !used.has(idOf(prod))) { items.push([prod, roundG(clampG(grams, role))]); used.add(idOf(prod)); } };

  // 1) Eiwitbron op ~90% van het eiwitdoel, binnen kader.
  if (protSrc) { const r = classify(protSrc), pp = per100(protSrc).p || 1; add(protSrc, (P * 0.9) / (pp / 100), r); }
  // 2) Koolhydraatbasis op het koolhydraatdoel, binnen kader.
  if (carbSrc) { const r = classify(carbSrc), cc = per100(carbSrc).c || 1; add(carbSrc, C / (cc / 100), r); }
  // 3) Side. Lunch/diner: groente (fruit hoort daar NIET, dat is voor de snacks).
  //    Ontbijt: liever fruit (havermout + bessen) als dat er is, anders groente.
  if (slot === "breakfast") {
    const fr = of(["fruit"]);
    if (fr.length) add(pick(fr, dayIdx + 2), 150, "fruit");
    else if (vegs.length) add(pick(vegs, dayIdx + 2), 150, "veg");
  } else if (vegs.length) {
    add(pick(vegs, dayIdx + 2), 150, "veg");
  }

  if (!items.length) return scaleToKcal(cands, target, dayIdx, label);
  let meal = assemble(items, label);
  // Fijn-afstemming op kcal: schaal ALLEEN eiwit+koolhydraat, en blijf in hun kader.
  if (K > 0 && meal.kcal > 0) {
    const f = K / meal.kcal;
    if (f < 0.9 || f > 1.12) {
      const adj = items.map(([prod, g]) => { const r = classify(prod); const flex = PROTEIN_ROLES.includes(r) || CARB_ROLES.includes(r); return [prod, flex ? roundG(clampG(g * f, r)) : g]; });
      meal = assemble(adj, label);
    }
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

function buildDay(products, meals, dayMacros, dayIdx, nSnacks, lang, prodByName) {
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
      if (meal) { out.push(scaleSavedMeal(meal, target.kcal, label, prodByName)); return; }
    }
    const cands = candidatesFor(products, slot);
    const meal = buildMealMacro(cands, target, dayIdx + idx, label, slot);
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
  // Naam → product, zodat recept-ingrediënten hun categorie + portiegewicht terugvinden.
  const prodByName = {};
  list.forEach((p) => { if (p && p.name) prodByName[String(p.name).toLowerCase().trim()] = p; });

  const days = names.map((d, i) => {
    const isTrain = nTrain === 7 ? true : nTrain === 0 ? false : td.includes(i);
    const dm = isTrain ? trainM : restM;
    return { d, train: isTrain, m: buildDay(list, meals, dm, i, nSnacks, lang, prodByName) };
  });
  return { days };
}
