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
  snack2: { nl: "Snack", en: "Snack" },
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
  const R1 = (x) => Math.round(num(x) * 10) / 10;
  const rows = (meal.ing || []).map((x) => {
    const g0 = num(x.g);
    const prod = pbn[String(x.n || "").toLowerCase().trim()] || null;
    // per-100 uit eigen macro's, anders uit het gekoppelde product, anders uit een
    // per100 die het ingrediënt zelf meedraagt.
    let p100 = null;
    if (g0 > 0 && (num(x.kcal) || num(x.p) || num(x.c) || num(x.f))) {
      p100 = { kcal: num(x.kcal) / g0 * 100, p: num(x.p) / g0 * 100, c: num(x.c) / g0 * 100, f: num(x.f) / g0 * 100 };
    } else if (prod) { p100 = per100(prod); }
    else if (x.per100) { p100 = { kcal: num(x.per100.kcal), p: num(x.per100.p), c: num(x.per100.c), f: num(x.per100.f) }; }
    const serv = (prod && num(prod.per_100 && prod.per_100.serving_g) > 0) ? Math.round(num(prod.per_100.serving_g))
      : (x.per100 && num(x.per100.serving_g) > 0) ? Math.round(num(x.per100.serving_g)) : 0;
    const role = classify({ name: x.n, category: prod && prod.category, per_100: p100 || {} });
    return { n: x.n, g: g0, p100, serv, role };
  });
  const kcalOf = (r, g) => (r.p100 ? r.p100.kcal * g / 100 : 0);
  // Basis = werkelijke kcal UIT de ingrediënten (nooit de mogelijk foute opgeslagen totalen).
  const base = rows.reduce((a, r) => a + kcalOf(r, r.g), 0);
  if (base <= 0) { // geen voedingswaarde bekend → eenvoudige schaling op opgeslagen macro's
    const b = num(meal.macros.kcal) || 1;
    const f0 = Math.max(0.3, Math.min(2.5, kcalTarget / b));
    const ing = rows.map((r) => ({ n: r.n, g: roundG(r.g * f0) }));
    return { t: label, n: meal.name || label, kcal: Math.round(num(meal.macros.kcal) * f0), p: Math.round(num(meal.macros.p) * f0), c: Math.round(num(meal.macros.c) * f0), f: Math.round(num(meal.macros.f) * f0), ing };
  }
  const f = Math.max(0.3, Math.min(2.5, kcalTarget / base));
  // 1) Alles proportioneel richting doel: stuk-producten in HELE stuks (min 1),
  //    de rest binnen z'n portie-kader.
  rows.forEach((r) => {
    let g = r.g * f;
    if (r.serv > 0) g = Math.max(1, Math.round(g / r.serv)) * r.serv;
    else g = roundG(clampG(g, r.role));
    r.g = g;
  });
  // 2) De koolhydraatbasis (geen stuk-product) vangt het restant op zodat de dag klopt.
  const carb = rows.find((r) => CARB_ROLES.includes(r.role) && !r.serv && r.p100 && r.p100.kcal > 0);
  if (carb) {
    const othersKcal = rows.filter((r) => r !== carb).reduce((a, r) => a + kcalOf(r, r.g), 0);
    carb.g = roundG(clampG((kcalTarget - othersKcal) / (carb.p100.kcal / 100), carb.role));
  }
  // 3) Totalen + per100 (incl. portiegewicht) uit de uiteindelijke grammen — zodat het
  //    plan stuk-producten als stuks toont en het totaal altijd klopt met de ingrediënten.
  let kcal = 0, p = 0, c = 0, ff = 0; const ing = [];
  rows.forEach((r) => {
    if (r.p100) { kcal += r.p100.kcal * r.g / 100; p += r.p100.p * r.g / 100; c += r.p100.c * r.g / 100; ff += r.p100.f * r.g / 100; }
    const pr = r.p100 ? { kcal: R1(r.p100.kcal), p: R1(r.p100.p), c: R1(r.p100.c), f: R1(r.p100.f) } : null;
    if (pr && r.serv > 0) pr.serving_g = r.serv;
    ing.push(pr ? { n: r.n, g: r.g, per100: pr } : { n: r.n, g: r.g });
  });
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

// ===========================================================================
// SOLVER — "Herbereken naar doel" (goal programming)
// Stelt de porties van de flexibele ingrediënten zó bij dat kcal/eiwit/koolh/vet
// zo dicht mogelijk bij het dagdoel komen, binnen realistische kaders en met hele
// stuks waar serving_g is ingevuld. Eiwit weegt zwaarder (herstel). Altijd een
// oplossing; geeft terug hoever elke macro nog mist (eerlijk tekort-signaal).
// Accenten/sauzen (honing, choco, olie-accent) blijven vast — nooit opschalen.
// ===========================================================================
export function resolveP100(ing, pbn) {
  if (ing && ing.per100 && (num(ing.per100.kcal) || num(ing.per100.p) || num(ing.per100.c) || num(ing.per100.f)))
    return { kcal: num(ing.per100.kcal), p: num(ing.per100.p), c: num(ing.per100.c), f: num(ing.per100.f), serving_g: num(ing.per100.serving_g) };
  const g = num(ing && ing.g);
  if (g > 0 && (num(ing.kcal) || num(ing.p) || num(ing.c) || num(ing.f)))
    return { kcal: num(ing.kcal) / g * 100, p: num(ing.p) / g * 100, c: num(ing.c) / g * 100, f: num(ing.f) / g * 100, serving_g: 0 };
  const prod = pbn && pbn[String((ing && ing.n) || "").toLowerCase().trim()];
  if (prod) { const x = per100(prod); return { ...x, serving_g: num(prod.per_100 && prod.per_100.serving_g) }; }
  return null;
}
export function solveDayToTargets(day, target, prodByName) {
  const pbn = prodByName || {};
  const T = { kcal: num(target && target.kcal), p: num(target && target.p), c: num(target && target.c), f: num(target && target.f) };
  if (!(T.kcal > 0) || !day || !day.m) return { day, dev: null, off: [] };
  const W = { kcal: 1 / Math.max(T.kcal, 1), p: 1.6 / Math.max(T.p, 1), c: 1 / Math.max(T.c, 1), f: 1 / Math.max(T.f, 1) };
  const levers = []; const fixed = { kcal: 0, p: 0, c: 0, f: 0 };
  (day.m || []).forEach((m, mi) => {
    (m.ing || []).forEach((ing, ii) => {
      const p100 = resolveP100(ing, pbn), g = num(ing.g);
      if (!p100) return;                                   // onbekend ingrediënt -> schaalt niet mee
      const role = classify({ name: ing.n, category: null, per_100: p100 });
      const serv = num(p100.serving_g) > 0 ? Math.round(num(p100.serving_g)) : 0;
      if (role === "accent") { fixed.kcal += p100.kcal * g / 100; fixed.p += p100.p * g / 100; fixed.c += p100.c * g / 100; fixed.f += p100.f * g / 100; return; }
      const k = KADER[role] || KADER.other;
      let lo, hi, step;
      if (serv > 0) { const pmax = Math.max(1, Math.min(Math.floor(k.max / serv), serv <= 25 ? 6 : 4)); lo = serv; hi = pmax * serv; step = serv; }  // realistische stuks: kleine plakjes max 6, grotere max 4
      else { lo = k.min; hi = k.max; step = 0; }
      levers.push({ mi, ii, p100, g: Math.min(hi, Math.max(lo, g)), lo, hi, step });
    });
  });
  const totals = () => { const t = { ...fixed }; levers.forEach((L) => { t.kcal += L.p100.kcal * L.g / 100; t.p += L.p100.p * L.g / 100; t.c += L.p100.c * L.g / 100; t.f += L.p100.f * L.g / 100; }); return t; };
  const obj = (t) => W.kcal * Math.abs(t.kcal - T.kcal) + W.p * Math.abs(t.p - T.p) + W.c * Math.abs(t.c - T.c) + W.f * Math.abs(t.f - T.f);
  for (let sweep = 0; sweep < 12; sweep++) {
    let improved = false;
    for (const L of levers) {
      const t = totals();
      const base = { kcal: t.kcal - L.p100.kcal * L.g / 100, p: t.p - L.p100.p * L.g / 100, c: t.c - L.p100.c * L.g / 100, f: t.f - L.p100.f * L.g / 100 };
      const at = (g) => obj({ kcal: base.kcal + L.p100.kcal * g / 100, p: base.p + L.p100.p * g / 100, c: base.c + L.p100.c * g / 100, f: base.f + L.p100.f * g / 100 });
      let cands;
      if (L.step > 0) { cands = []; for (let p = 1; p <= Math.floor(L.hi / L.step); p++) cands.push(p * L.step); }
      else {
        cands = [L.lo, L.hi];
        [["kcal", L.p100.kcal], ["p", L.p100.p], ["c", L.p100.c], ["f", L.p100.f]].forEach(([m, dens]) => { if (dens > 0) { const x = (T[m] - base[m]) / (dens / 100); if (x >= L.lo && x <= L.hi) cands.push(Math.round(x)); } });
      }
      let bestG = L.g, bestO = at(L.g);
      for (const g of cands) { const o = at(g); if (o < bestO - 1e-9) { bestO = o; bestG = g; } }
      if (bestG !== L.g) { L.g = bestG; improved = true; }
    }
    if (!improved) break;
  }
  const R1 = (x) => Math.round(x * 10) / 10;
  const gByKey = {}; levers.forEach((L) => { gByKey[L.mi + "_" + L.ii] = L.g; });
  const newM = (day.m || []).map((m, mi) => {
    let kcal = 0, p = 0, c = 0, f = 0;
    const ing = (m.ing || []).map((x, ii) => {
      const ng = gByKey[mi + "_" + ii] != null ? gByKey[mi + "_" + ii] : num(x.g), p100 = resolveP100(x, pbn);
      if (p100) { kcal += p100.kcal * ng / 100; p += p100.p * ng / 100; c += p100.c * ng / 100; f += p100.f * ng / 100; const pr = { kcal: R1(p100.kcal), p: R1(p100.p), c: R1(p100.c), f: R1(p100.f) }; if (num(p100.serving_g) > 0) pr.serving_g = Math.round(num(p100.serving_g)); return { ...x, g: ng, per100: pr }; }
      return { ...x, g: ng };
    });
    return { ...m, kcal: Math.round(kcal), p: Math.round(p), c: Math.round(c), f: Math.round(f), ing };
  });
  const fin = totals();
  const dev = { kcal: Math.round(fin.kcal - T.kcal), p: Math.round(fin.p - T.p), c: Math.round(fin.c - T.c), f: Math.round(fin.f - T.f) };
  const off = [];
  if (T.p - fin.p > 12) off.push("p");
  if (Math.abs(dev.c) > 25) off.push("c");
  if (Math.abs(dev.f) > 18) off.push("f");
  if (Math.abs(dev.kcal) > 120) off.push("kcal");
  return { day: { ...day, m: newM }, dev, off };
}

// Basis-foods: kleine gecureerde set kwaliteits-staples waaruit we mogen aanvullen
// als de eigen voorraad een macro niet haalt. per_100 = per 100 g; serving_g waar telbaar.
export const BASE_FOODS = [
  // --- Eiwit: zuivel ---
  { name: "Magere kwark", category: "dairy", per_100: { kcal: 57, p: 10, c: 4, f: 0.2 } },
  { name: "Magere kwark naturel 0%", category: "dairy", per_100: { kcal: 47, p: 10, c: 4, f: 0 } },
  { name: "Magere Griekse yoghurt", category: "dairy", per_100: { kcal: 59, p: 10, c: 4, f: 0.4 } },
  { name: "Skyr", category: "dairy", per_100: { kcal: 63, p: 11, c: 4, f: 0.2 } },
  { name: "Hüttenkäse (cottage cheese)", category: "dairy", per_100: { kcal: 98, p: 11, c: 3, f: 4.3 } },
  { name: "Magere melk", category: "dairy", per_100: { kcal: 42, p: 3.4, c: 5, f: 1 } },
  // --- Eiwit: vlees & gevogelte ---
  { name: "Kipfilet", category: "vlees", per_100: { kcal: 110, p: 23, c: 0, f: 1.5 } },
  { name: "Kipdijfilet", category: "vlees", per_100: { kcal: 170, p: 19, c: 0, f: 10 } },
  { name: "Kalkoenfilet (gebraden)", category: "vlees", per_100: { kcal: 110, p: 22, c: 1, f: 2 } },
  { name: "Magere runderbiefstuk", category: "vlees", per_100: { kcal: 150, p: 26, c: 0, f: 5 } },
  { name: "Mager rundergehakt 5%", category: "vlees", per_100: { kcal: 137, p: 21, c: 0, f: 6 } },
  { name: "Varkenshaas", category: "vlees", per_100: { kcal: 143, p: 21, c: 0, f: 6 } },
  // --- Eiwit: vis ---
  { name: "Witvis (kabeljauw)", category: "vis", per_100: { kcal: 82, p: 18, c: 0, f: 0.7 } },
  { name: "Tonijn in water", category: "vis", per_100: { kcal: 103, p: 24, c: 0, f: 1 } },
  { name: "Zalmfilet", category: "vis", per_100: { kcal: 208, p: 20, c: 0, f: 13, serving_g: 150 } },
  { name: "Garnalen", category: "vis", per_100: { kcal: 85, p: 20, c: 0, f: 0.5 } },
  // --- Eiwit: ei, plant & supp ---
  { name: "Eieren", category: "eieren", per_100: { kcal: 143, p: 13, c: 1, f: 10, serving_g: 55 } },
  { name: "Eiwit (eiwitten los)", category: "eieren", per_100: { kcal: 52, p: 11, c: 0.7, f: 0.2 } },
  { name: "Tofu", category: "vlees", per_100: { kcal: 144, p: 17, c: 3, f: 9 } },
  { name: "Tempeh", category: "vlees", per_100: { kcal: 192, p: 20, c: 8, f: 11 } },
  { name: "Kidneybonen (gekookt)", category: "grain", per_100: { kcal: 127, p: 8.7, c: 20, f: 0.5 } },
  { name: "Kikkererwten (gekookt)", category: "grain", per_100: { kcal: 164, p: 9, c: 27, f: 2.6 } },
  { name: "Linzen (gekookt)", category: "grain", per_100: { kcal: 116, p: 9, c: 20, f: 0.4 } },
  { name: "Whey proteïne", category: "supp", per_100: { kcal: 375, p: 75, c: 10, f: 5, serving_g: 30 } },
  { name: "Erwtenproteïne", category: "supp", per_100: { kcal: 360, p: 80, c: 5, f: 6, serving_g: 30 } },
  // --- Koolhydraten: granen & zetmeel ---
  { name: "Witte rijst (droog)", category: "grain", per_100: { kcal: 355, p: 7, c: 78, f: 1 } },
  { name: "Zilvervliesrijst (droog)", category: "grain", per_100: { kcal: 360, p: 8, c: 76, f: 3 } },
  { name: "Volkoren pasta (droog)", category: "grain", per_100: { kcal: 350, p: 13, c: 64, f: 2.5 } },
  { name: "Pasta wit (droog)", category: "grain", per_100: { kcal: 371, p: 13, c: 75, f: 1.5 } },
  { name: "Quinoa (droog)", category: "grain", per_100: { kcal: 368, p: 14, c: 64, f: 6 } },
  { name: "Couscous (droog)", category: "grain", per_100: { kcal: 376, p: 13, c: 77, f: 0.6 } },
  { name: "Havermout", category: "oats", per_100: { kcal: 370, p: 13, c: 60, f: 7 } },
  { name: "Aardappel", category: "potato", per_100: { kcal: 77, p: 2, c: 17, f: 0.1 } },
  { name: "Zoete aardappel", category: "potato", per_100: { kcal: 86, p: 1.6, c: 20, f: 0.1 } },
  // --- Koolhydraten: brood ---
  { name: "Volkorenbrood", category: "bread", per_100: { kcal: 247, p: 9, c: 42, f: 3, serving_g: 35 } },
  { name: "Bruin brood", category: "bread", per_100: { kcal: 245, p: 9, c: 45, f: 2.5, serving_g: 35 } },
  { name: "Proteïne knäckebröd", category: "bread", per_100: { kcal: 350, p: 22, c: 60, f: 5, serving_g: 16 } },
  { name: "Volkoren wrap", category: "bread", per_100: { kcal: 297, p: 9, c: 49, f: 6, serving_g: 60 } },
  // --- Fruit ---
  { name: "Banaan", category: "fruit", per_100: { kcal: 89, p: 1.1, c: 23, f: 0.3, serving_g: 120 } },
  { name: "Appel", category: "fruit", per_100: { kcal: 52, p: 0.3, c: 14, f: 0.2, serving_g: 150 } },
  { name: "Blauwe bessen", category: "fruit", per_100: { kcal: 57, p: 0.7, c: 14, f: 0.3 } },
  { name: "Aardbeien", category: "fruit", per_100: { kcal: 32, p: 0.7, c: 8, f: 0.3 } },
  { name: "Sinaasappel", category: "fruit", per_100: { kcal: 47, p: 0.9, c: 12, f: 0.1, serving_g: 130 } },
  { name: "Mango", category: "fruit", per_100: { kcal: 60, p: 0.8, c: 15, f: 0.4 } },
  { name: "Rozijnen", category: "fruit", per_100: { kcal: 299, p: 3, c: 79, f: 0.5 } },
  // --- Vet: olie, noten, zaden ---
  { name: "Olijfolie", category: "sauce", per_100: { kcal: 884, p: 0, c: 0, f: 100 } },
  { name: "Roomboter", category: "sauce", per_100: { kcal: 717, p: 0.9, c: 0.1, f: 81 } },
  { name: "Amandelen", category: "nuts", per_100: { kcal: 579, p: 21, c: 22, f: 50 } },
  { name: "Walnoten", category: "nuts", per_100: { kcal: 654, p: 15, c: 14, f: 65 } },
  { name: "Cashewnoten", category: "nuts", per_100: { kcal: 553, p: 18, c: 30, f: 44 } },
  { name: "Pindakaas", category: "nuts", per_100: { kcal: 588, p: 25, c: 20, f: 50 } },
  { name: "Chiazaad", category: "nuts", per_100: { kcal: 486, p: 17, c: 42, f: 31 } },
  { name: "Lijnzaad", category: "nuts", per_100: { kcal: 534, p: 18, c: 29, f: 42 } },
  { name: "Pompoenpitten", category: "nuts", per_100: { kcal: 559, p: 30, c: 11, f: 49 } },
  { name: "Avocado", category: "fruit", per_100: { kcal: 160, p: 2, c: 9, f: 15 } },
  // --- Groente ---
  { name: "Broccoli", category: "veg", per_100: { kcal: 34, p: 2.8, c: 7, f: 0.4 } },
  { name: "Spinazie", category: "veg", per_100: { kcal: 23, p: 2.9, c: 3.6, f: 0.4 } },
  { name: "Courgette", category: "veg", per_100: { kcal: 17, p: 1.2, c: 3.1, f: 0.3 } },
  { name: "Paprika", category: "veg", per_100: { kcal: 31, p: 1, c: 6, f: 0.3 } },
  { name: "Wortel", category: "veg", per_100: { kcal: 41, p: 0.9, c: 10, f: 0.2 } },
  { name: "Groene boontjes", category: "veg", per_100: { kcal: 31, p: 1.8, c: 7, f: 0.1 } },
  { name: "Tomaat", category: "veg", per_100: { kcal: 18, p: 0.9, c: 3.9, f: 0.2 } },
];

// --- Ingrediënt-voedingswaarde invullen (AI-plan heeft alleen naam + grammen) ---
// Een AI-maaltijd levert per ingrediënt alleen {n, g}; geen per-100g. Deze
// resolver vult die per100 op NAAM uit (1) je gescande producten en (2) de
// basistabel hierboven. Ingrediënten die al een echte per100 dragen (zelf
// samengesteld / gekoppeld) blijven ongemoeid. Geen match -> leeg laten
// (nooit verzinnen). Zo worden de maaltijdtotalen daarna uit échte
// ingrediënt-data herrekend.
const BASE_BY_NAME = {};
BASE_FOODS.forEach((f) => { BASE_BY_NAME[String(f.name).toLowerCase().trim()] = f; });
const normName = (s) => String(s || "").toLowerCase().trim().replace(/\s+/g, " ");
function matchProduct(nm, pbn) {
  if (!nm) return null;
  if (pbn[nm]) return pbn[nm];
  // Zuinige deel-match op je eigen producten: ingrediëntnaam zit in de
  // productnaam of andersom (min. 5 tekens, zodat korte woorden niet vals matchen).
  if (nm.length >= 5) {
    for (const k in pbn) { if (k.length >= 5 && (k.indexOf(nm) >= 0 || nm.indexOf(k) >= 0)) return pbn[k]; }
  }
  return null;
}
function per100From(src) {
  const x = (src && (src.per_100 || src)) || {};
  if (!(num(x.kcal) || num(x.p) || num(x.c) || num(x.f))) return null;
  const p = { kcal: num(x.kcal), p: num(x.p), c: num(x.c), f: num(x.f) };
  if (num(x.serving_g) > 0) p.serving_g = Math.round(num(x.serving_g));
  return p;
}
export function fillIngredientPer100(meal, prodByName) {
  if (!meal || !Array.isArray(meal.ing) || !meal.ing.length) return meal;
  const pbn = prodByName || {};
  let changed = false;
  const ing = meal.ing.map((x) => {
    if (x && x.per100 && (num(x.per100.kcal) || num(x.per100.p) || num(x.per100.c) || num(x.per100.f))) return x; // al echt
    const nm = normName(x && x.n);
    if (!nm) return x;
    const prod = matchProduct(nm, pbn);
    if (prod) { const p = per100From(prod); if (p) { changed = true; return { ...x, per100: p, pid: prod.id != null ? prod.id : x.pid }; } }
    const base = BASE_BY_NAME[nm];
    if (base) { const p = per100From(base); if (p) { changed = true; return { ...x, per100: p }; } }
    return x; // geen match -> leeg laten
  });
  return changed ? { ...meal, ing } : meal;
}

// Kies een basis-food om het grootste tekort te dichten na het solven. Geeft
// { food, grams } of null. protein-gat -> magere eiwitbron; koolh-gat -> zetmeel;
// vet-gat -> gezond vet. Nooit voor een overschot.
export function suggestGapFood(dev, exclude) {
  if (!dev) return null;
  const ex = exclude || [];
  const need = { p: -dev.p, c: -dev.c, f: -dev.f };          // positief = tekort
  // Grootste tekort eerst (eiwit telt zwaarder voor herstel), met drempels.
  const order = [["p", need.p, 12, 1.4], ["c", need.c, 20, 1], ["f", need.f, 12, 1]]
    .filter(([, v, thr]) => v > thr).sort((a, b) => (b[1] * b[3]) - (a[1] * a[3]));
  if (!order.length) return null;
  const macro = order[0][0];
  const pref = {
    p: ["Magere kwark", "Kipfilet", "Skyr", "Magere Griekse yoghurt", "Kalkoenfilet (gebraden)", "Hüttenkäse (cottage cheese)", "Tonijn in water", "Whey proteïne"],
    c: ["Witte rijst (droog)", "Havermout", "Zoete aardappel", "Aardappel", "Banaan", "Volkoren pasta (droog)", "Volkorenbrood", "Quinoa (droog)"],
    f: ["Avocado", "Amandelen", "Walnoten", "Pindakaas", "Olijfolie"],
  }[macro];
  const food = BASE_FOODS.find((b) => pref.includes(b.name) && !ex.includes(b.name));  // sla al toegevoegde over
  if (!food) return null;
  const dens = num(food.per_100[macro]) / 100;                // gram-macro per gram food
  if (dens <= 0) return null;
  let grams = need[macro] / dens;
  const serv = num(food.per_100.serving_g);
  if (serv > 0) grams = Math.max(serv, Math.round(grams / serv) * serv);
  else grams = Math.max(20, Math.round(grams / 10) * 10);
  grams = Math.min(grams, 400);
  return { food, grams };
}

// Rolfamilie van een rol (voor coherente plaatsing van een aanvulling).
function roleFamily(role) {
  if (["protein", "mince", "fish", "eggs", "dairy"].includes(role)) return "p";
  if (["carbdry", "carbwet", "potato", "bread", "oats", "fruit"].includes(role)) return "c";
  if (["nuts", "oil", "cheese"].includes(role)) return "f";
  return "x";
}
// Solve + (indien nodig) aanvullen uit de basis-foods, max een paar keer. Plaatst een
// aanvulling in de maaltijd met dezelfde rolfamilie (kwark bij zuivel, kip bij hartig),
// en laat de solver 'm daarna mee-portioneren. Geeft de opgeloste dag + wat is toegevoegd.
export function solveDayWithFill(day, target, prodByName, maxAdds) {
  const pbn = prodByName || {}, cap = maxAdds == null ? 2 : maxAdds;
  let cur = solveDayToTargets(day, target, pbn);
  const added = [];
  for (let i = 0; i < cap; i++) {
    const sug = suggestGapFood(cur.dev, added);
    if (!sug) break;
    const fam = roleFamily(classify(sug.food));
    let mi = 0, best = -1;
    (cur.day.m || []).forEach((m, idx) => {
      let score = 0;
      (m.ing || []).forEach((x) => { const p100 = resolveP100(x, pbn); if (p100 && roleFamily(classify({ name: x.n, category: null, per_100: p100 })) === fam) score++; });
      if (score > best) { best = score; mi = idx; }
    });
    const per100 = { kcal: sug.food.per_100.kcal, p: sug.food.per_100.p, c: sug.food.per_100.c, f: sug.food.per_100.f };
    if (num(sug.food.per_100.serving_g) > 0) per100.serving_g = Math.round(num(sug.food.per_100.serving_g));
    const nd = { ...cur.day, m: cur.day.m.map((m, idx) => idx === mi ? { ...m, ing: [...(m.ing || []), { n: sug.food.name, g: sug.grams, per100, base: true }] } : m) };
    cur = solveDayToTargets(nd, target, pbn);
    added.push(sug.food.name);
  }
  return { ...cur, added };
}

// Bouwt één maaltijd BINNEN de kaders: 1 eiwitbron + 1 koolhydraatbasis + groente,
// elk op z'n macro-doel maar geklemd op een realistische portie. Accenten/sauzen
// worden NOOIT opgeschaald om macro's te halen. Snacks = één logisch tussendoortje.
function buildMealMacro(cands, target, dayIdx, label, slot) {
  if (!cands.length) return null;
  const P = Math.max(0, num(target.p)), C = Math.max(0, num(target.c)), K = Math.max(0, num(target.kcal));
  const tagged = cands.map((p) => ({ p, role: classify(p) }));
  const of = (roles) => tagged.filter((t) => roles.includes(t.role)).map((t) => t.p);

  if (slot === "snack" || slot === "snack2") {
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
  const R1 = (x) => Math.round(num(x) * 10) / 10;
  let kcal = 0, p = 0, c = 0, f = 0; const ing = [];
  for (const [prod, g] of items) {
    const pc = per100(prod);
    kcal += pc.kcal * g / 100; p += pc.p * g / 100; c += pc.c * g / 100; f += pc.f * g / 100;
    const sg = num(prod.per_100 && prod.per_100.serving_g);
    const pr = { kcal: R1(pc.kcal), p: R1(pc.p), c: R1(pc.c), f: R1(pc.f) };
    if (sg > 0) pr.serving_g = Math.round(sg);
    ing.push({ n: productName(prod), g, per100: pr });
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
  for (let s = 0; s < nSnacks; s++) slots.push([s === 0 ? "snack" : "snack2", snackShare / Math.max(1, nSnacks)]);
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

// Rol van één product (voor de compleetheids-check in de intake).
export function productRole(p) { return classify(p); }

// HARDE overschrijving: voor elk moment waar de gebruiker recept(en) koos, zet
// die recepten op dat moment (afgewisseld over de week, geschaald naar het
// per-maaltijd-doel, piece-aware + binnen de kaders). Momenten zonder gekozen
// recept blijven zoals de AI/software ze maakte. Werkt op een bestaand weekplan.
export function overlayChosenRecipes(week, opts) {
  const o = opts || {};
  if (!week || !Array.isArray(week.days) || !o.recipesById) return week;
  const L = o.lang === "nl" ? "nl" : "en";
  const prodByName = {};
  (o.products || []).forEach((p) => { if (p && p.name) prodByName[String(p.name).toLowerCase().trim()] = p; });
  const td = Array.isArray(o.trainingDays) ? o.trainingDays : [];
  const nTrain = td.length;
  const ns = Math.max(0, Math.min(2, (o.nSnacks | 0)));
  const moments = ["breakfast", "lunch", "dinner"]; if (ns >= 1) moments.push("snack"); if (ns >= 2) moments.push("snack2");
  const snackShare = Math.min(0.12 * ns, 0.3), mainShare = 1 - snackShare;
  const shareOf = (m) => m === "breakfast" ? 0.3 * mainShare : m === "lunch" ? 0.35 * mainShare : m === "dinner" ? 0.35 * mainShare : (snackShare / Math.max(1, ns));
  const recIdsFor = (m) => (((o.mealPrefs && o.mealPrefs[m]) || []).filter((id) => typeof id === "string" && id.indexOf("rec:") === 0).map((id) => id.slice(4)));
  if (!moments.some((m) => recIdsFor(m).length)) return week;
  const t = o.targets || {};
  const dayMacro = (isTrain) => { const s = isTrain ? (t.train || t) : (t.rest || t); return { kcal: num(s.kcal), p: num(s.protein != null ? s.protein : s.p), c: num(s.carbs != null ? s.carbs : s.c), f: num(s.fat != null ? s.fat : s.f) }; };
  const label = (m) => (SLOT_LABEL[m] ? SLOT_LABEL[m][L] : m);
  week.days.forEach((day, i) => {
    if (!day || !Array.isArray(day.m)) return;
    const isTrain = nTrain === 7 ? true : nTrain === 0 ? false : td.includes(i);
    const dm = dayMacro(isTrain);
    const build = (m) => { const ids = recIdsFor(m); if (!ids.length) return null; const rec = o.recipesById[ids[((i % ids.length) + ids.length) % ids.length]]; if (!rec) return null; return scaleSavedMeal(rec, dm.kcal * shareOf(m), label(m), prodByName); };
    if (day.m.length === moments.length) {
      day.m = moments.map((m, k) => build(m) || day.m[k]);
    } else {
      const used = [];
      moments.forEach((m) => {
        const nm = build(m); if (!nm) return; const lbl = label(m);
        let idx = day.m.findIndex((mm, j) => !used.includes(j) && mm && mm.t === lbl);
        if (idx < 0 && (m === "snack" || m === "snack2")) idx = day.m.findIndex((mm, j) => !used.includes(j) && mm && /snack|tussen/i.test(mm.t || ""));
        if (idx >= 0) { day.m[idx] = nm; used.push(idx); } else { day.m.push(nm); used.push(day.m.length - 1); }
      });
    }
  });
  return week;
}
