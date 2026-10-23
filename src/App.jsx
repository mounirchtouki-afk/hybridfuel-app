import React, { useState } from "react";

// Roept GEEN Claude aan vanuit de browser — alles via /api/plan (key zit op de server).
// Tweetalig: NL/EN via een vlagschakelaar. De gekozen taal gaat mee naar de backend.

// Huisstijl gelijk aan de website: zwart / wit / één rood accent.
const INK = "#0A0A0A", INK2 = "#161616", EMBER = "#E8321E", EMBER_SOFT = "#FF4B37",
  PAPER = "#F4F4F4", MUTED = "#8C8C8C", LINE = "#242424", SAGE = "#B5B5B5";

// id = vaste waarde (nooit vertalen, backend rekent erop) · nl/en = wat je ziet
const ACTIVITY = [
  { id: "light", nl: "Licht (1–2 sessies/wk)", en: "Light (1–2 sessions/wk)" },
  { id: "moderate", nl: "Gemiddeld (3–4/wk)", en: "Moderate (3–4/wk)" },
  { id: "high", nl: "Hoog (5–6/wk)", en: "High (5–6/wk)" },
  { id: "athlete", nl: "Atleet (2x/dag)", en: "Athlete (2x/day)" },
];
const GOALS = [
  { id: "cut", nl: "Afvallen", en: "Lose fat" },
  { id: "maintain", nl: "Onderhouden", en: "Maintain" },
  { id: "gain", nl: "Spier opbouwen", en: "Build muscle" },
];
const DIETS = [
  { id: "none", nl: "Geen beperking", en: "No restriction" },
  { id: "highprotein", nl: "Eiwitrijk", en: "High-protein" },
  { id: "vegetarian", nl: "Vegetarisch", en: "Vegetarian" },
  { id: "vegan", nl: "Veganistisch", en: "Vegan" },
  { id: "pescatarian", nl: "Pescotarisch", en: "Pescatarian" },
];
const CUISINES = [
  { id: "mediterranean", nl: "Mediterraans", en: "Mediterranean" },
  { id: "asian", nl: "Aziatisch", en: "Asian" },
  { id: "italian", nl: "Italiaans", en: "Italian" },
  { id: "mexican", nl: "Mexicaans", en: "Mexican" },
  { id: "middleeastern", nl: "Midden-Oosters", en: "Middle Eastern" },
  { id: "dutch", nl: "Nederlands", en: "Dutch" },
];
const PROTEINS = [
  { id: "chicken", nl: "Kip", en: "Chicken" },
  { id: "beef", nl: "Rund", en: "Beef" },
  { id: "fish", nl: "Vis", en: "Fish" },
  { id: "eggs", nl: "Eieren", en: "Eggs" },
  { id: "tofu", nl: "Tofu", en: "Tofu" },
  { id: "quark", nl: "Kwark/Skyr", en: "Quark/Skyr" },
  { id: "beans", nl: "Bonen", en: "Beans" },
];
const VARIETY = [
  { id: 1, nl: "Elke dag gelijk", en: "Same daily" },
  { id: 2, nl: "2 dagen", en: "2 days" },
  { id: 3, nl: "3 dagen", en: "3 days" },
  { id: 7, nl: "Alles anders", en: "All diff." },
];
const WD = { nl: ["Ma", "Di", "Wo", "Do", "Vr", "Za", "Zo"], en: ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"] };

// Boodschappencategorieën per taal (zelfde volgorde = zelfde index)
const SHOP_CATS = [
  { nl: "Groente & Fruit", en: "Produce" },
  { nl: "Vlees & Vis", en: "Protein" },
  { nl: "Zuivel", en: "Dairy" },
  { nl: "Granen & Koolhydraten", en: "Grains & Carbs" },
  { nl: "Voorraadkast", en: "Pantry" },
  { nl: "Overig", en: "Other" },
];

// Alle losse UI-teksten
const TXT = {
  tagline: { nl: "Persoonlijke voedingsschema's", en: "Personalized fuel plans" },
  yourStats: { nl: "Jouw gegevens", en: "Your stats" },
  man: { nl: "Man", en: "Male" },
  woman: { nl: "Vrouw", en: "Female" },
  age: { nl: "Leeftijd", en: "Age" },
  height: { nl: "Lengte", en: "Height" },
  weight: { nl: "Gewicht", en: "Weight" },
  trainingLoad: { nl: "Trainingsbelasting", en: "Training load" },
  goal: { nl: "Doel", en: "Goal" },
  diet: { nl: "Dieet", en: "Diet" },
  avoid: { nl: "Vermijden / allergieën", en: "Avoid / allergies" },
  avoidPh: { nl: "bijv. pinda's, schaaldieren", en: "e.g. peanuts, shellfish" },
  whatYouLove: { nl: "Wat je lekker vindt", en: "What you love" },
  favFoods: { nl: "Favoriete gerechten", en: "Favourite foods" },
  favPh: { nl: "bijv. kip, rijst, kwark", en: "e.g. chicken, rice, quark" },
  goToProteins: { nl: "Vaste eiwitbronnen", en: "Go-to proteins" },
  cuisine: { nl: "Keukenstijl", en: "Cuisine vibe" },
  howVaried: { nl: "Hoeveel variatie? (verschillende dagen)", en: "How varied? (different days)" },
  build: { nl: "Maak mijn plan", en: "Build my plan" },
  building: { nl: "Bezig…", en: "Building…" },
  emptyTitle: { nl: "Fuel the work.", en: "Fuel the work." },
  emptyBody: { nl: "Vul je gegevens in. We berekenen je macro's en bouwen een plan met gewichten.", en: "Enter your stats. We calculate your macros and build a plan with weights." },
  dailyTargets: { nl: "Dagdoelen", en: "Daily targets" },
  maintenance: { nl: "Onderhoud", en: "Maintenance" },
  below: { nl: "onder", en: "below" },
  above: { nl: "boven", en: "above" },
  protein: { nl: "Eiwit", en: "Protein" },
  carbs: { nl: "Koolhydr.", en: "Carbs" },
  fat: { nl: "Vet", en: "Fat" },
  tabPlan: { nl: "Plan", en: "Plan" },
  tabShop: { nl: "Boodschappen", en: "Shopping list" },
  cooking: { nl: "JE PLAN WORDT KLAARGEMAAKT…", en: "COOKING UP YOUR PLAN…" },
  retry: { nl: "OPNIEUW", en: "RETRY" },
  shopHint: { nl: "Totalen voor de week, opgeteld uit je gewichten. Tik om af te vinken.", en: "Weekly totals, summed from your weights. Tap to check off." },
  noDays: { nl: "Geen dagen ontvangen", en: "No days received" },
  unknownErr: { nl: "Onbekende fout", en: "Unknown error" },
  footer: { nl: "Schattingen, geen medisch advies. Drink voldoende water en raadpleeg een professional bij twijfel.", en: "Estimates, not medical advice. Drink enough water and consult a professional if in doubt." },
  download: { nl: "⬇ Download als Excel", en: "⬇ Download as Excel" },
  downloadHint: { nl: "Open 'm in Google Sheets om in Drive bij te houden en af te strepen.", en: "Open it in Google Sheets to track and tick off in Drive." },
  // Kolomkoppen in het Excel-bestand
  xDay: { nl: "Dag", en: "Day" },
  xMeal: { nl: "Maaltijd", en: "Meal" },
  xDish: { nl: "Gerecht", en: "Dish" },
  xIng: { nl: "Ingrediënten", en: "Ingredients" },
  xEaten: { nl: "Gegeten?", en: "Eaten?" },
  xNotes: { nl: "Notities", en: "Notes" },
  xItem: { nl: "Product", en: "Item" },
  xQty: { nl: "Hoeveelheid", en: "Quantity" },
  xGot: { nl: "In huis?", en: "Got it?" },
  xSheetPlan: { nl: "Weekplan", en: "Week plan" },
  xSheetShop: { nl: "Boodschappen", en: "Shopping" },
};

const fonts = `@import url('https://fonts.googleapis.com/css2?family=Oswald:wght@400;500;600;700&family=Inter:wght@400;500;600&display=swap');`;
const num = (v, d = 0) => { const n = parseFloat(v); return isNaN(n) ? d : n; };

// Boodschappen-categorie bepalen (herkent NL én EN ingrediëntnamen). Geeft de index terug.
function categoryIndex(name) {
  const n = (name || "").toLowerCase();
  if (/chicken|beef|turkey|pork|steak|mince|egg|tofu|tempeh|salmon|tuna|fish|shrimp|prawn|cod|lentil|bean|chickpea|ham|bacon|kip|rund|gehakt|biefstuk|ei|eieren|zalm|tonijn|vis|garnaal|garnalen|kabeljauw|linz|boon|bonen|kikkererwt|worst|kalkoen/.test(n)) return 1;
  if (/milk|yog|yoghurt|yogurt|quark|skyr|cheese|cottage|cream|butter|whey|melk|kwark|kaas|room|boter|hüttenkäse|huttenkase/.test(n)) return 2;
  if (/rice|pasta|bread|oat|potato|quinoa|couscous|noodle|tortilla|wrap|flour|cereal|bulgur|cracker|rijst|brood|havermout|aardappel|noedel|meel|ontbijtgran|cous/.test(n)) return 3;
  if (/oil|sauce|spice|salt|pepper|honey|vinegar|stock|broth|seed|nut|peanut|almond|cashew|tahini|syrup|powder|jam|herb|olie|saus|kruid|zout|peper|honing|azijn|bouillon|zaden|noot|noten|pinda|amandel|stroop|poeder|specerij/.test(n)) return 4;
  if (/apple|banana|berry|berries|spinach|broccoli|pepper|onion|garlic|tomato|carrot|courgette|zucchini|cucumber|lettuce|avocado|lemon|lime|mushroom|kale|veg|fruit|leek|cabbage|sprout|pea|orange|mango|grape|appel|banaan|bes|bessen|spinazie|paprika|ui|knoflook|tomaat|wortel|komkommer|sla|citroen|limoen|champignon|boerenkool|groente|prei|kool|erwt|sinaasappel|druif|peer|spruit/.test(n)) return 0;
  return 5;
}

async function fetchChunk(payload) {
  const res = await fetch("/api/plan", {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify(payload),
  });
  const data = await res.json().catch(() => ({}));
  if (!res.ok) throw new Error(data.error || ("Fout " + res.status));
  return data;
}

export default function App() {
  const [lang, setLang] = useState("nl");
  const T = (k) => TXT[k][lang];

  const [sex, setSex] = useState("male");
  const [age, setAge] = useState("43");
  const [height, setHeight] = useState("190");
  const [weight, setWeight] = useState("87");
  const [activity, setActivity] = useState("moderate");
  const [goal, setGoal] = useState("maintain");
  const [diet, setDiet] = useState("highprotein");
  const [avoid, setAvoid] = useState("");
  const [likes, setLikes] = useState("");
  const [cuisines, setCuisines] = useState([]);
  const [proteins, setProteins] = useState([]);
  const [variety, setVariety] = useState(3);

  const [targets, setTargets] = useState(null);
  const [week, setWeek] = useState(null);
  const [view, setView] = useState("plan");
  const [checked, setChecked] = useState({});
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState("");
  const [started, setStarted] = useState(false);

  const toggle = (val, list, setList) =>
    setList(list.includes(val) ? list.filter((x) => x !== val) : [...list, val]);

  // Zet gekozen ids om naar leesbare namen in de gekozen taal voor de backend-prompt.
  function labelsOf(ids, source) {
    return ids.map((id) => { const o = source.find((x) => x.id === id); return o ? o[lang] : id; });
  }

  function common() {
    const dietObj = DIETS.find((d) => d.id === diet);
    return {
      sex, age, height, weight, activity, goal,
      diet: dietObj ? dietObj[lang] : diet,
      avoid, likes,
      cuisines: labelsOf(cuisines, CUISINES),
      proteins: labelsOf(proteins, PROTEINS),
      lang, weekIndex: 0,
    };
  }

  async function handleBuild() {
    setError(""); setStarted(true); setView("plan"); setChecked({});
    setLoading(true); setWeek(null); setTargets(null);
    try {
      const count = variety;
      const lab = Array.from({ length: count }, (_, i) => "D" + (i + 1));
      const chunks = [];
      for (let i = 0; i < lab.length; i += 2) chunks.push(lab.slice(i, i + 2));
      let unique = [], tgt = null;
      for (const ch of chunks) {
        const data = await fetchChunk({ ...common(), labels: ch });
        tgt = data.targets;
        unique = unique.concat((data.plan && data.plan.days) || []);
      }
      if (!unique.length) throw new Error(T("noDays"));
      const wd = WD[lang];
      const days = wd.map((d, i) => {
        const u = unique[i % unique.length];
        return { d, set: String.fromCharCode(65 + (i % unique.length)), m: u.m };
      });
      setTargets(tgt);
      setWeek({ days, sets: unique.length });
    } catch (e) {
      setError(e && e.message ? e.message : T("unknownErr"));
    } finally {
      setLoading(false);
    }
  }

  function shoppingFor(wk) {
    const agg = {};
    wk.days.forEach((day) => day.m.forEach((meal) => (meal.ing || []).forEach((ing) => {
      const key = (ing.n || "").trim();
      if (!key) return;
      if (!agg[key]) agg[key] = { g: 0, ci: categoryIndex(key) };
      agg[key].g += num(ing.g);
    })));
    const byCat = {};
    Object.entries(agg).forEach(([name, v]) => { (byCat[v.ci] = byCat[v.ci] || []).push({ name, g: Math.round(v.g) }); });
    return SHOP_CATS.map((c, i) => ({ n: c[lang], items: byCat[i] })).filter((c) => c.items)
      .map((c) => ({ n: c.n, items: c.items.sort((a, b) => b.g - a.g) }));
  }

  // Exporteert het plan naar een .xlsx met afstreep- en notitiekolommen.
  function exportExcel() {
    const XLSX = window.XLSX;
    if (!XLSX || !week) return;

    // Tabblad 1: Weekplan
    const planRows = [[T("xDay"), T("xMeal"), T("xDish"), T("xIng"), T("xEaten"), T("xNotes")]];
    week.days.forEach((day) => {
      day.m.forEach((m, i) => {
        const ing = (m.ing || []).map((x) => Math.round(num(x.g)) + "g " + x.n).join(", ");
        planRows.push([i === 0 ? day.d : "", m.t, m.n, ing, "", ""]);
      });
      planRows.push(["", "", "", "", "", ""]); // lege regel tussen dagen
    });
    const ws1 = XLSX.utils.aoa_to_sheet(planRows);
    ws1["!cols"] = [{ wch: 6 }, { wch: 10 }, { wch: 26 }, { wch: 40 }, { wch: 9 }, { wch: 24 }];

    // Tabblad 2: Boodschappen
    const shopRows = [[T("xItem"), T("xQty"), T("xGot")]];
    shoppingFor(week).forEach((cat) => {
      shopRows.push([cat.n.toUpperCase(), "", ""]);
      cat.items.forEach((it) => shopRows.push([it.name, it.g >= 1000 ? (it.g / 1000).toFixed(1) + " kg" : it.g + " g", ""]));
      shopRows.push(["", "", ""]);
    });
    const ws2 = XLSX.utils.aoa_to_sheet(shopRows);
    ws2["!cols"] = [{ wch: 28 }, { wch: 14 }, { wch: 9 }];

    const wb = XLSX.utils.book_new();
    XLSX.utils.book_append_sheet(wb, ws1, T("xSheetPlan"));
    XLSX.utils.book_append_sheet(wb, ws2, T("xSheetShop"));
    XLSX.writeFile(wb, "HybridFuelCo-" + (lang === "nl" ? "Weekplan" : "Mealplan") + ".xlsx");
  }

  const label = { fontFamily: "Inter, sans-serif", fontSize: 11, letterSpacing: 1, textTransform: "uppercase", color: MUTED, marginBottom: 6, display: "block", fontWeight: 600 };
  const input = { width: "100%", background: INK, border: `1px solid ${LINE}`, color: PAPER, padding: "11px 12px", fontFamily: "Inter, sans-serif", fontSize: 14, borderRadius: 8, outline: "none", boxSizing: "border-box" };
  const disp = { fontFamily: "Oswald, sans-serif" };
  const chipS = (on) => ({ padding: "7px 12px", borderRadius: 20, border: `1px solid ${on ? EMBER : LINE}`, background: on ? "rgba(255,90,31,0.14)" : "transparent", fontSize: 12.5, fontWeight: 600, cursor: "pointer" });
  const segS = (on) => ({ flex: 1, textAlign: "center", padding: "9px 4px", borderRadius: 8, border: `1px solid ${on ? EMBER : LINE}`, background: on ? "rgba(255,90,31,0.12)" : "transparent", fontSize: 12, fontWeight: 600, cursor: "pointer" });
  const flagBtn = (on) => ({ fontSize: 20, lineHeight: 1, cursor: "pointer", padding: "4px 6px", borderRadius: 7, border: `1px solid ${on ? EMBER : LINE}`, background: on ? "rgba(255,90,31,0.14)" : "transparent", opacity: on ? 1 : 0.55 });

  return (
    <div style={{ minHeight: "100vh", background: INK, color: PAPER, fontFamily: "Inter, sans-serif" }}>
      <style dangerouslySetInnerHTML={{ __html: fonts + `*{box-sizing:border-box} select option{background:${INK2};color:${PAPER}} @keyframes pulse{0%,100%{opacity:.4}50%{opacity:1}} .dot{animation:pulse 1s infinite}` }} />

      <div style={{ borderBottom: `1px solid ${LINE}`, padding: "16px 18px", display: "flex", alignItems: "center", gap: 12 }}>
        <div style={{ width: 34, height: 34, borderRadius: 8, background: EMBER, display: "flex", alignItems: "center", justifyContent: "center", ...disp, fontWeight: 700, color: INK, fontSize: 20 }}>H</div>
        <div style={{ flex: 1 }}>
          <div style={{ ...disp, fontWeight: 700, fontSize: 21, letterSpacing: 0.5, lineHeight: 1 }}>HYBRIDFUEL<span style={{ color: EMBER }}>CO</span></div>
          <div style={{ fontSize: 10.5, color: MUTED, letterSpacing: 1, textTransform: "uppercase", marginTop: 3 }}>{T("tagline")}</div>
        </div>
        <div style={{ display: "flex", gap: 6 }}>
          <div onClick={() => setLang("nl")} style={flagBtn(lang === "nl")} title="Nederlands">🇳🇱</div>
          <div onClick={() => setLang("en")} style={flagBtn(lang === "en")} title="English">🇬🇧</div>
        </div>
      </div>

      <div style={{ maxWidth: 1080, margin: "0 auto", padding: 16, display: "grid", gridTemplateColumns: "minmax(0,1fr)", gap: 18 }}>
        <div style={{ background: INK2, border: `1px solid ${LINE}`, borderRadius: 14, padding: 18 }}>
          <div style={{ ...disp, fontSize: 15, fontWeight: 600, textTransform: "uppercase", letterSpacing: 1.5, marginBottom: 16, color: EMBER }}>{T("yourStats")}</div>

          <div style={{ display: "flex", gap: 10, marginBottom: 14 }}>
            {[["male", T("man")], ["female", T("woman")]].map(([id, lbl]) => (
              <div key={id} onClick={() => setSex(id)} style={{ ...segS(sex === id), padding: "10px 0" }}>{lbl}</div>
            ))}
          </div>
          <div style={{ display: "grid", gridTemplateColumns: "1fr 1fr 1fr", gap: 10, marginBottom: 14 }}>
            <div><label style={label}>{T("age")}</label><input style={input} value={age} onChange={(e) => setAge(e.target.value)} inputMode="numeric" /></div>
            <div><label style={label}>{T("height")}</label><input style={input} value={height} onChange={(e) => setHeight(e.target.value)} inputMode="numeric" /></div>
            <div><label style={label}>{T("weight")}</label><input style={input} value={weight} onChange={(e) => setWeight(e.target.value)} inputMode="numeric" /></div>
          </div>
          <div style={{ marginBottom: 14 }}>
            <label style={label}>{T("trainingLoad")}</label>
            <select style={input} value={activity} onChange={(e) => setActivity(e.target.value)}>
              {ACTIVITY.map((a) => <option key={a.id} value={a.id}>{a[lang]}</option>)}
            </select>
          </div>
          <div style={{ marginBottom: 14 }}>
            <label style={label}>{T("goal")}</label>
            <div style={{ display: "flex", gap: 8 }}>
              {GOALS.map((g) => <div key={g.id} onClick={() => setGoal(g.id)} style={segS(goal === g.id)}>{g[lang]}</div>)}
            </div>
          </div>
          <div style={{ marginBottom: 14 }}>
            <label style={label}>{T("diet")}</label>
            <select style={input} value={diet} onChange={(e) => setDiet(e.target.value)}>
              {DIETS.map((d) => <option key={d.id} value={d.id}>{d[lang]}</option>)}
            </select>
          </div>
          <div style={{ marginBottom: 16 }}>
            <label style={label}>{T("avoid")}</label>
            <input style={input} value={avoid} onChange={(e) => setAvoid(e.target.value)} placeholder={T("avoidPh")} />
          </div>

          <div style={{ height: 1, background: LINE, margin: "2px 0 16px" }} />
          <div style={{ ...disp, fontSize: 15, fontWeight: 600, textTransform: "uppercase", letterSpacing: 1.5, marginBottom: 14, color: EMBER }}>{T("whatYouLove")}</div>
          <div style={{ marginBottom: 14 }}>
            <label style={label}>{T("favFoods")}</label>
            <input style={input} value={likes} onChange={(e) => setLikes(e.target.value)} placeholder={T("favPh")} />
          </div>
          <div style={{ marginBottom: 14 }}>
            <label style={label}>{T("goToProteins")}</label>
            <div style={{ display: "flex", flexWrap: "wrap", gap: 7 }}>
              {PROTEINS.map((p) => <div key={p.id} onClick={() => toggle(p.id, proteins, setProteins)} style={chipS(proteins.includes(p.id))}>{p[lang]}</div>)}
            </div>
          </div>
          <div style={{ marginBottom: 16 }}>
            <label style={label}>{T("cuisine")}</label>
            <div style={{ display: "flex", flexWrap: "wrap", gap: 7 }}>
              {CUISINES.map((c) => <div key={c.id} onClick={() => toggle(c.id, cuisines, setCuisines)} style={chipS(cuisines.includes(c.id))}>{c[lang]}</div>)}
            </div>
          </div>

          <div style={{ height: 1, background: LINE, margin: "2px 0 16px" }} />
          <div style={{ marginBottom: 18 }}>
            <label style={label}>{T("howVaried")}</label>
            <div style={{ display: "flex", gap: 6 }}>
              {VARIETY.map((v) => <div key={v.id} onClick={() => setVariety(v.id)} style={{ ...segS(variety === v.id), fontSize: 11.5, padding: "9px 2px" }}>{v[lang]}</div>)}
            </div>
          </div>

          <button onClick={handleBuild} disabled={loading} style={{ width: "100%", background: EMBER, color: INK, border: "none", padding: "14px 0", borderRadius: 10, ...disp, fontWeight: 700, fontSize: 16, letterSpacing: 1, textTransform: "uppercase", cursor: loading ? "default" : "pointer", opacity: loading ? 0.7 : 1 }}>
            {loading ? T("building") : T("build")}
          </button>
        </div>

        <div>
          {!started && (
            <div style={{ border: `1px dashed ${LINE}`, borderRadius: 14, padding: "48px 24px", textAlign: "center", color: MUTED }}>
              <div style={{ ...disp, fontSize: 24, fontWeight: 600, color: PAPER, marginBottom: 8 }}>{T("emptyTitle")}</div>
              <div style={{ fontSize: 13.5, lineHeight: 1.6 }}>{T("emptyBody")}</div>
            </div>
          )}

          {started && (
            <>
              {targets && (
                <div style={{ background: INK2, border: `1px solid ${LINE}`, borderRadius: 14, padding: 16, marginBottom: 16 }}>
                  <div style={{ display: "flex", justifyContent: "space-between", alignItems: "baseline", marginBottom: 12 }}>
                    <div style={{ ...label, marginBottom: 0 }}>{T("dailyTargets")}</div>
                    <div style={{ ...disp, fontSize: 28, fontWeight: 700 }}>{targets.kcal}<span style={{ fontSize: 12, color: MUTED, fontWeight: 400, marginLeft: 5 }}>kcal</span></div>
                  </div>
                  {targets.maintenance != null && (
                    <div style={{ fontSize: 12, color: MUTED, marginBottom: 12 }}>
                      {T("maintenance")} ≈ <span style={{ color: PAPER }}>{targets.maintenance} kcal</span>{targets.kcal !== targets.maintenance && <> · {targets.kcal < targets.maintenance ? (targets.maintenance - targets.kcal) + " " + T("below") : (targets.kcal - targets.maintenance) + " " + T("above")}</>}
                    </div>
                  )}
                  <div style={{ display: "grid", gridTemplateColumns: "1fr 1fr 1fr", gap: 8 }}>
                    {[[T("protein"), targets.protein, EMBER], [T("carbs"), targets.carbs, EMBER_SOFT], [T("fat"), targets.fat, SAGE]].map(([n, v, c]) => (
                      <div key={n} style={{ background: INK, borderRadius: 10, padding: "10px 12px", borderLeft: `3px solid ${c}` }}>
                        <div style={{ fontSize: 10, letterSpacing: 1, textTransform: "uppercase", color: MUTED, fontWeight: 600 }}>{n}</div>
                        <div style={{ ...disp, fontSize: 20, fontWeight: 600 }}>{v}<span style={{ fontSize: 10, color: MUTED, marginLeft: 3 }}>g</span></div>
                      </div>
                    ))}
                  </div>
                </div>
              )}

              {week && !loading && (
                <>
                  <div style={{ display: "flex", justifyContent: "space-between", alignItems: "center", gap: 10, marginBottom: 8, flexWrap: "wrap" }}>
                    <div style={{ display: "inline-flex", gap: 4, background: INK2, border: `1px solid ${LINE}`, borderRadius: 10, padding: 4 }}>
                      {[["plan", T("tabPlan")], ["shop", T("tabShop")]].map(([id, lbl]) => (
                        <div key={id} onClick={() => setView(id)} style={{ padding: "8px 16px", borderRadius: 7, background: view === id ? EMBER : "transparent", color: view === id ? INK : PAPER, fontSize: 13, fontWeight: 700, ...disp, letterSpacing: 0.5, cursor: "pointer" }}>{lbl}</div>
                      ))}
                    </div>
                    <div onClick={exportExcel} style={{ padding: "9px 16px", borderRadius: 8, border: `1px solid ${EMBER}`, color: EMBER, fontSize: 13, fontWeight: 700, ...disp, letterSpacing: 0.5, cursor: "pointer" }}>{T("download")}</div>
                  </div>
                  <div style={{ fontSize: 11.5, color: MUTED, marginBottom: 14, lineHeight: 1.5 }}>{T("downloadHint")}</div>
                </>
              )}

              {loading && <div style={{ textAlign: "center", padding: "40px 0", color: EMBER, ...disp, fontSize: 17, letterSpacing: 1 }}><span className="dot">{T("cooking")}</span></div>}

              {error && !loading && (
                <div style={{ background: "rgba(255,90,31,0.1)", border: `1px solid ${EMBER}`, borderRadius: 12, padding: 16, textAlign: "center" }}>
                  <div style={{ marginBottom: 12, color: PAPER, fontSize: 13, wordBreak: "break-word" }}>{error}</div>
                  <button onClick={handleBuild} style={{ background: EMBER, color: INK, border: "none", padding: "9px 22px", borderRadius: 8, fontWeight: 700, cursor: "pointer", ...disp, letterSpacing: 1 }}>{T("retry")}</button>
                </div>
              )}

              {!loading && !error && view === "plan" && week && (
                <div style={{ display: "grid", gap: 12 }}>
                  {week.days.map((day, di) => {
                    const tot = day.m.reduce((a, m) => ({ kcal: a.kcal + num(m.kcal), p: a.p + num(m.p), c: a.c + num(m.c), f: a.f + num(m.f) }), { kcal: 0, p: 0, c: 0, f: 0 });
                    return (
                      <div key={di} style={{ background: INK2, border: `1px solid ${LINE}`, borderRadius: 12, overflow: "hidden" }}>
                        <div style={{ display: "flex", justifyContent: "space-between", alignItems: "center", padding: "11px 14px", background: INK, borderBottom: `1px solid ${LINE}` }}>
                          <div style={{ display: "flex", alignItems: "center", gap: 9 }}>
                            <div style={{ ...disp, fontWeight: 600, fontSize: 15, letterSpacing: 1, textTransform: "uppercase" }}>{day.d}</div>
                            {week.sets > 1 && <div style={{ fontSize: 9.5, color: EMBER, border: `1px solid ${LINE}`, borderRadius: 5, padding: "2px 6px", letterSpacing: 1, fontWeight: 700 }}>SET {day.set}</div>}
                          </div>
                          <div style={{ fontSize: 11.5, color: MUTED }}><span style={{ color: PAPER, fontWeight: 600 }}>{tot.kcal}</span> kcal · {tot.p}p/{tot.c}c/{tot.f}f</div>
                        </div>
                        <div>
                          {day.m.map((m, mi) => (
                            <div key={mi} style={{ padding: "10px 14px", borderBottom: mi < day.m.length - 1 ? `1px solid ${LINE}` : "none" }}>
                              <div style={{ display: "flex", justifyContent: "space-between", alignItems: "flex-start" }}>
                                <div style={{ flex: 1, paddingRight: 10 }}>
                                  <div style={{ fontSize: 9.5, color: EMBER, letterSpacing: 1, textTransform: "uppercase", fontWeight: 600, marginBottom: 2 }}>{m.t}</div>
                                  <div style={{ fontSize: 13.5, fontWeight: 500 }}>{m.n}</div>
                                  {m.ing && m.ing.length > 0 && (
                                    <div style={{ fontSize: 11.5, color: MUTED, marginTop: 3, lineHeight: 1.5 }}>
                                      {m.ing.map((ing, ii) => <span key={ii}><span style={{ color: PAPER }}>{Math.round(num(ing.g))}g</span> {ing.n}{ii < m.ing.length - 1 ? " · " : ""}</span>)}
                                    </div>
                                  )}
                                </div>
                                <div style={{ fontSize: 11, color: MUTED, textAlign: "right", whiteSpace: "nowrap" }}><span style={{ color: PAPER, fontWeight: 600 }}>{m.kcal}</span> kcal<br />{m.p}p/{m.c}c/{m.f}f</div>
                              </div>
                            </div>
                          ))}
                        </div>
                      </div>
                    );
                  })}
                </div>
              )}

              {!loading && view === "shop" && week && (
                <div style={{ display: "grid", gap: 12 }}>
                  <div style={{ fontSize: 12, color: MUTED }}>{T("shopHint")}</div>
                  {shoppingFor(week).map((cat, ci) => (
                    <div key={ci} style={{ background: INK2, border: `1px solid ${LINE}`, borderRadius: 12, overflow: "hidden" }}>
                      <div style={{ padding: "10px 14px", background: INK, borderBottom: `1px solid ${LINE}`, ...disp, fontWeight: 600, fontSize: 13.5, letterSpacing: 1, textTransform: "uppercase", color: EMBER }}>{cat.n}</div>
                      {cat.items.map((item, ii) => {
                        const key = cat.n + ":" + item.name, on = checked[key];
                        return (
                          <div key={ii} onClick={() => setChecked((p) => ({ ...p, [key]: !p[key] }))} style={{ display: "flex", alignItems: "center", gap: 11, padding: "10px 14px", borderBottom: ii < cat.items.length - 1 ? `1px solid ${LINE}` : "none", cursor: "pointer" }}>
                            <div style={{ width: 19, height: 19, borderRadius: 6, border: `2px solid ${on ? EMBER : MUTED}`, background: on ? EMBER : "transparent", display: "flex", alignItems: "center", justifyContent: "center", flexShrink: 0, color: INK, fontSize: 12, fontWeight: 800 }}>{on ? "✓" : ""}</div>
                            <div style={{ flex: 1, fontSize: 13.5, color: on ? MUTED : PAPER, textDecoration: on ? "line-through" : "none" }}>{item.name}</div>
                            <div style={{ fontSize: 12.5, color: on ? MUTED : EMBER, fontWeight: 600, ...disp }}>{item.g >= 1000 ? (item.g / 1000).toFixed(1) + " kg" : item.g + " g"}</div>
                          </div>
                        );
                      })}
                    </div>
                  ))}
                </div>
              )}
            </>
          )}
        </div>
      </div>

      <div style={{ textAlign: "center", padding: "8px 20px 28px", color: MUTED, fontSize: 10.5, lineHeight: 1.6 }}>{T("footer")}</div>
    </div>
  );
}
