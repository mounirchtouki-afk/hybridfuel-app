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

// ---------------------------------------------------------------------------
// Macro-herbalans per dag: trekt kcal, EIWIT, koolhydraten EN vet naar het
// dagdoel toe door de porties bij te stellen (eiwit eerst), binnen realistische
// kaders en met stuk-producten in hele stuks. Vult eiwit automatisch bij uit de
// eigen producten als het met de gekozen items niet lukt; markeert de dag als
// het eiwit daarna nog te laag is. Werkt op een al-gebouwde week (AI of software).
const R1v = (x) => Math.round(num(x) * 10) / 10;
function dayRows(day, pbn) {
  const rows = [];
  (day.m || []).forEach((m, mi) => {
    (m.ing || []).forEach((x) => {
      const g0 = num(x.g);
      const prod = pbn[String(x.n || "").toLowerCase().trim()] || null;
      let p100 = null;
      if (x.per100 && (num(x.per100.kcal) || num(x.per100.p) || num(x.per100.c) || num(x.per100.f))) p100 = { kcal: num(x.per100.kcal), p: num(x.per100.p), c: num(x.per100.c), f: num(x.per100.f) };
      else if (g0 > 0 && (num(x.kcal) || num(x.p) || num(x.c) || num(x.f))) p100 = { kcal: num(x.kcal) / g0 * 100, p: num(x.p) / g0 * 100, c: num(x.c) / g0 * 100, f: num(x.f) / g0 * 100 };
      else if (prod) p100 = per100(prod);
      const serv = (x.per100 && num(x.per100.serving_g) > 0) ? Math.round(num(x.per100.serving_g)) : (prod && num(prod.per_100 && prod.per_100.serving_g) > 0 ? Math.round(num(prod.per_100.serving_g)) : 0);
      const role = classify({ name: x.n, category: prod && prod.category, per_100: p100 || {} });
      rows.push({ mi, n: x.n, g: g0, p100, serv, role });
    });
  });
  return rows;
}
function macroTot(rows) {
  let kcal = 0, p = 0, c = 0, f = 0;
  rows.forEach((r) => { if (r.p100) { kcal += r.p100.kcal * r.g / 100; p += r.p100.p * r.g / 100; c += r.p100.c * r.g / 100; f += r.p100.f * r.g / 100; } });
  return { kcal, p, c, f };
}
function setRowG(r, g) {
  if (!r.p100) return;
  if (r.serv > 0) {
    const k = KADER[r.role] || KADER.other;
    const maxPc = Math.max(1, Math.floor(k.max / r.serv));   // stuks ook binnen het portie-kader
    const pc = Math.max(1, Math.min(maxPc, Math.round(g / r.serv)));
    r.g = pc * r.serv;
  } else r.g = roundG(clampG(g, r.role));
}
// Schaal een lever-groep zodat hun gezamenlijke bijdrage aan macro `key` = want.
function scaleGroup(levers, key, want) {
  const cur = levers.reduce((a, r) => a + (r.p100 ? r.p100[key] * r.g / 100 : 0), 0);
  if (cur <= 0 || want <= 0) return;
  const f = want / cur;
  levers.forEach((r) => setRowG(r, r.g * f));
}
const PROT_LEVER = ["protein", "mince", "fish", "eggs", "dairy"];
const CARB_LEVER = ["carbdry", "carbwet", "potato", "bread", "oats", "fruit"];
const FAT_LEVER = ["nuts", "oil", "cheese"];
function rebalanceDay(day, target, pbn, products, lang) {
  const rows = dayRows(day, pbn).filter((r) => r.p100 && num(r.p100.kcal) >= 0);
  if (!rows.length || !target || !(num(target.kcal) > 0)) return { ...day };
  // Guard: kennen we de ingrediënt-macro's niet (bv. een kaal AI-plan), dan niets
  // herbalanceren — anders zouden we een dag kapotmaken die we niet kunnen zien.
  const declared = (day.m || []).reduce((a, m) => a + num(m.kcal), 0);
  if (declared > 0 && macroTot(rows).kcal < declared * 0.6) return { ...day };
  const T = { kcal: num(target.kcal), p: num(target.p), c: num(target.c), f: num(target.f) };
  const protLev = rows.filter((r) => PROT_LEVER.includes(r.role) && r.p100.p >= 5);
  const carbLev = rows.filter((r) => CARB_LEVER.includes(r.role) && r.p100.c >= 5);
  const fatLev = rows.filter((r) => FAT_LEVER.includes(r.role) && r.p100.f >= 10);
  const sub = (tot, levs, key) => tot - levs.reduce((a, r) => a + (r.p100[key] * r.g / 100), 0);
  for (let it = 0; it < 5; it++) {
    let t = macroTot(rows);
    if (protLev.length) scaleGroup(protLev, "p", T.p - sub(t.p, protLev, "p"));
    t = macroTot(rows);
    if (fatLev.length) scaleGroup(fatLev, "f", T.f - sub(t.f, fatLev, "f"));
    t = macroTot(rows);
    if (carbLev.length) scaleGroup(carbLev, "c", T.c - sub(t.c, carbLev, "c"));
  }
  // Eiwit automatisch bijvullen uit de eigen producten als het nog te laag is.
  let tot = macroTot(rows);
  if (tot.p < T.p - 12 && Array.isArray(products) && products.length) {
    const lean = products.map((p) => ({ p, x: per100(p) }))
      .filter((o) => o.x.p >= 10 && o.x.kcal > 0 && (o.x.p * 4) / o.x.kcal >= 0.45)
      .sort((a, b) => (b.x.p * 4 / b.x.kcal) - (a.x.p * 4 / a.x.kcal))[0];
    if (lean) {
      const serv = num(lean.p.per_100 && lean.p.per_100.serving_g);
      let g = roundG((T.p - tot.p) / (lean.x.p / 100));
      if (serv > 0) g = Math.max(serv, Math.round(g / serv) * serv);
      g = Math.min(g, 400);
      const pr = { kcal: R1v(lean.x.kcal), p: R1v(lean.x.p), c: R1v(lean.x.c), f: R1v(lean.x.f) };
      if (serv > 0) pr.serving_g = Math.round(serv);
      const mi = day.m.length ? day.m.length - 1 : 0;
      rows.push({ mi, n: productName(lean.p), g, p100: { kcal: lean.x.kcal, p: lean.x.p, c: lean.x.c, f: lean.x.f }, serv: serv > 0 ? Math.round(serv) : 0, role: classify(lean.p), _pr: pr });
      for (let it = 0; it < 3; it++) { const t = macroTot(rows); if (carbLev.length) scaleGroup(carbLev, "c", T.c - sub(t.c, carbLev, "c")); }
    }
  }
  tot = macroTot(rows);
  const proteinLow = tot.p < T.p - 15;
  // Grammen terugschrijven + per maaltijd herrekenen.
  const newM = (day.m || []).map((m, mi) => {
    const mrows = rows.filter((r) => r.mi === mi);
    let kcal = 0, p = 0, c = 0, f = 0; const ing = [];
    mrows.forEach((r) => {
      if (r.p100) { kcal += r.p100.kcal * r.g / 100; p += r.p100.p * r.g / 100; c += r.p100.c * r.g / 100; f += r.p100.f * r.g / 100; }
      const pr = r._pr || (r.p100 ? { kcal: R1v(r.p100.kcal), p: R1v(r.p100.p), c: R1v(r.p100.c), f: R1v(r.p100.f) } : null);
      if (pr && r.serv > 0 && !pr.serving_g) pr.serving_g = r.serv;
      ing.push(pr ? { n: r.n, g: r.g, per100: pr } : { n: r.n, g: r.g });
    });
    return { ...m, kcal: Math.round(kcal), p: Math.round(p), c: Math.round(c), f: Math.round(f), ing };
  });
  return { ...day, m: newM, proteinLow };
}
// Past de herbalans toe op elke dag van de week. targets = { kcal,protein,carbs,fat,
// train:{...}, rest:{...}, trainingCount }. Markeert dagen met te laag eiwit via day.proteinLow.
export function enforceMacros(week, opts) {
  if (!week || !week.days) return week;
  const o = opts || {};
  const targets = o.targets || {};
  const pbn = o.prodByName || {};
  const products = o.products || [];
  const hasCycle = targets.train && targets.rest && targets.trainingCount > 0 && targets.trainingCount < 7;
  const macroOf = (dm) => ({ kcal: num(dm && dm.kcal), p: num(dm && (dm.protein != null ? dm.protein : dm.p)), c: num(dm && (dm.carbs != null ? dm.carbs : dm.c)), f: num(dm && (dm.fat != null ? dm.fat : dm.f)) });
  const baseM = macroOf(targets), trainM = macroOf(targets.train || targets), restM = macroOf(targets.rest || targets);
  const days = week.days.map((d) => rebalanceDay(d, hasCycle ? (d.train ? trainM : restM) : baseM, pbn, products, o.lang));
  return { ...week, days };
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
