// Gedeelde huisstijl-tokens, stijlhelpers en kleine utils.
// Eén bron van waarheid zodat App én de losse views er identiek uitzien.

export const INK = "#0A0A0A", INK2 = "#161616", EMBER = "#E11D48", EMBER_SOFT = "#FB7185",
  PAPER = "#F4F4F4", MUTED = "#8C8C8C", LINE = "#242424", SAGE = "#B5B5B5";

export const disp = { fontFamily: "Oswald, sans-serif" };
export const num = (v, d = 0) => { const n = parseFloat(v); return isNaN(n) ? d : n; };
// Macro-letters per taal: NL eiwit/koolhydraten/vet = e/k/v, EN protein/carbs/fat = p/c/f.
export const macroLetters = (lang) => (lang === "nl"
  ? { p: "e", c: "k", f: "v", P: "E", C: "K", F: "V" }
  : { p: "p", c: "c", f: "f", P: "P", C: "C", F: "F" });

export const WD = {
  nl: ["Ma", "Di", "Wo", "Do", "Vr", "Za", "Zo"],
  en: ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"],
};
// JS getDay(): 0=zo..6=za  ->  onze index 0=ma..6=zo
export const jsDayToIdx = (d) => (d === 0 ? 6 : d - 1);

export const label = { fontFamily: "Inter, sans-serif", fontSize: 11, letterSpacing: 1, textTransform: "uppercase", color: MUTED, marginBottom: 6, display: "block", fontWeight: 600 };
export const input = { width: "100%", background: INK, border: `1px solid ${LINE}`, color: PAPER, padding: "11px 12px", fontFamily: "Inter, sans-serif", fontSize: 14, borderRadius: 8, outline: "none", boxSizing: "border-box" };
export const card = { background: INK2, border: `1px solid ${LINE}`, borderRadius: 14, padding: 16 };
export const sectionTitle = { ...disp, fontSize: 15, fontWeight: 600, textTransform: "uppercase", letterSpacing: 1.5, color: EMBER };

export const chipS = (on) => ({ padding: "7px 12px", borderRadius: 20, border: `1px solid ${on ? EMBER : LINE}`, background: on ? "rgba(225,29,72,0.14)" : "transparent", fontSize: 12.5, fontWeight: 600, cursor: "pointer", color: on ? PAPER : MUTED });
export const segS = (on) => ({ flex: 1, textAlign: "center", padding: "9px 4px", borderRadius: 8, border: `1px solid ${on ? EMBER : LINE}`, background: on ? "rgba(225,29,72,0.12)" : "transparent", fontSize: 12, fontWeight: 600, cursor: "pointer", color: on ? PAPER : MUTED });
export const primaryBtn = { width: "100%", background: EMBER, color: PAPER, border: "none", padding: "13px 0", borderRadius: 10, ...disp, fontWeight: 700, fontSize: 15, letterSpacing: 1, textTransform: "uppercase", cursor: "pointer" };
export const ghostBtn = { background: "transparent", color: EMBER, border: `1px solid ${EMBER}`, padding: "11px 18px", borderRadius: 8, ...disp, fontWeight: 700, fontSize: 13, letterSpacing: 0.3, cursor: "pointer" };

// localStorage helpers (nooit crashen)
export const load = (k, d) => { try { const v = JSON.parse(localStorage.getItem(k)); return v == null ? d : v; } catch (e) { return d; } };
export const save = (k, v) => { try { localStorage.setItem(k, JSON.stringify(v)); } catch (e) {} };

export const todayISO = () => { const d = new Date(); return d.getFullYear() + "-" + String(d.getMonth() + 1).padStart(2, "0") + "-" + String(d.getDate()).padStart(2, "0"); };
export const fmtDate = (iso, lang) => {
  try { const [y, m, d] = iso.split("-").map(Number); return new Date(y, m - 1, d).toLocaleDateString(lang === "nl" ? "nl-NL" : "en-GB", { day: "numeric", month: "short" }); }
  catch (e) { return iso; }
};

// ===== Auto-bereidingswijze op basis van ingrediënten (regelgebaseerd) =====
export function classifyIngr(name) {
  const n = (name || "").toLowerCase();
  if (/chicken|kip|beef|rund|gehakt|steak|biefstuk|turkey|kalkoen|pork|varken|\begg|\bei\b|eieren|tofu|tempeh|salmon|zalm|tuna|tonijn|\bfish|\bvis\b|shrimp|garnaal|\bham\b|bacon|worst|mince/.test(n)) return "protein";
  if (/rice|rijst|pasta|noodle|noedel|spaghetti|bread|brood|bagel|\boat|havermout|potato|aardappel|quinoa|couscous|tortilla|wrap|cracker|cereal|ontbijtgran/.test(n)) return "grain";
  if (/banana|banaan|apple|appel|berry|berries|\bbes|bosbes|blueberr|strawberr|aardbei|mango|orange|sinaasappel|peach|perzik|pear|peer|grape|druif|\bfruit/.test(n)) return "fruit";
  if (/broccoli|spinach|spinazie|pepper|paprika|onion|\bui\b|garlic|knoflook|tomato|tomaat|carrot|wortel|courgette|zucchini|cucumber|komkommer|lettuce|\bsla\b|avocado|mushroom|champignon|kale|boon|\bbean|\bpea\b|erwt|groente|\bveg/.test(n)) return "veg";
  if (/yog|yoghurt|yogurt|quark|kwark|skyr|cheese|kaas|cottage|milk|melk|cream|room|butter|boter/.test(n)) return "dairy";
  if (/\bnut|noot|noten|peanut|pinda|almond|amandel|cashew|walnoot|seed|zaad|zaden|\bchia\b|lijnzaad/.test(n)) return "nuts";
  if (/oil|olie|sauce|saus|soy|soja|pesto|honey|honing|syrup|stroop|vinegar|azijn|mayo|mustard|mosterd|dressing|spice|kruid|salt|zout|pepper/.test(n)) return "sauce";
  return "other";
}
export function genSteps(items, lang) {
  const nl = lang !== "en";
  const norm = (items || []).map((i) => ({ name: i.name || i.n || "", g: Math.round(parseFloat(i.g != null ? i.g : i.grams) || 0), cat: classifyIngr(i.name || i.n || "") })).filter((i) => i.name);
  if (!norm.length) return "";
  const lbl = (i) => (i.g ? i.g + "g " : "") + i.name;
  const of = (cat) => norm.filter((i) => i.cat === cat).map(lbl);
  const join = (arr) => arr.join(nl ? " en " : " and ");
  const prot = of("protein"), grain = of("grain"), veg = of("veg"), fruit = of("fruit"), dairy = of("dairy"), nuts = of("nuts"), sauce = of("sauce"), other = of("other");
  const steps = [];
  const cooking = prot.length > 0;
  const breakfasty = dairy.length > 0 && !cooking && (fruit.length || nuts.length || grain.length);
  if (breakfasty) {
    steps.push(nl ? `Doe ${join(dairy)} in een kom.` : `Add ${join(dairy)} to a bowl.`);
    if (grain.length) steps.push(nl ? `Roer ${join(grain)} erdoor.` : `Stir in ${join(grain)}.`);
    if (fruit.length || nuts.length) steps.push(nl ? `Top met ${join([...fruit, ...nuts])}.` : `Top with ${join([...fruit, ...nuts])}.`);
    if (sauce.length) steps.push(nl ? `Maak af met ${join(sauce)} en serveer.` : `Finish with ${join(sauce)} and serve.`);
    else steps.push(nl ? `Serveer direct.` : `Serve right away.`);
  } else {
    if (grain.length) steps.push(nl ? `Kook ${join(grain)} volgens de verpakking en houd warm.` : `Cook ${join(grain)} per the package and keep warm.`);
    if (prot.length) steps.push(nl ? `Kruid ${join(prot)} en bak of gril gaar.` : `Season ${join(prot)} and pan-fry or grill until done.`);
    if (veg.length) steps.push(nl ? `Snijd ${join(veg)} en bak kort aan of stoom beetgaar.` : `Chop ${join(veg)} and sauté briefly or steam until tender.`);
    if (dairy.length) steps.push(nl ? `Roer ${join(dairy)} erdoor voor romigheid.` : `Stir in ${join(dairy)} for creaminess.`);
    if (fruit.length) steps.push(nl ? `Voeg ${join(fruit)} op het laatst toe.` : `Add ${join(fruit)} at the end.`);
    if (nuts.length) steps.push(nl ? `Strooi ${join(nuts)} erover.` : `Scatter ${join(nuts)} on top.`);
    if (other.length) steps.push(nl ? `Voeg ${join(other)} toe.` : `Add ${join(other)}.`);
    steps.push(nl ? `Breng op smaak met ${sauce.length ? join(sauce) + ", " : ""}zout en peper, en serveer alles samen.` : `Season with ${sauce.length ? join(sauce) + ", " : ""}salt and pepper, and serve together.`);
  }
  return steps.map((s, i) => (i + 1) + ". " + s).join("\n");
}
