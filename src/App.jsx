import React, { useState } from "react";

// Deze versie roept GEEN Claude meer aan vanuit de browser.
// Alles loopt via /api/plan (de backend). De API-key zit daar, niet hier.

const INK = "#17130E", INK2 = "#231C15", EMBER = "#FF5A1F", EMBER_SOFT = "#FF7A47",
  PAPER = "#F7F2E9", MUTED = "#9A8F7E", LINE = "#34291F", SAGE = "#7FA35C";

const ACTIVITY = [
  { id: "light", label: "Light (1–2 sessions/wk)" },
  { id: "moderate", label: "Moderate (3–4/wk)" },
  { id: "high", label: "High (5–6/wk)" },
  { id: "athlete", label: "Athlete (2x/day)" },
];
const GOALS = [{ id: "cut", label: "Lose fat" }, { id: "maintain", label: "Maintain" }, { id: "gain", label: "Build muscle" }];
const DIETS = ["No restriction", "High-protein", "Vegetarian", "Vegan", "Pescatarian"];
const CUISINES = ["Mediterranean", "Asian", "Italian", "Mexican", "Middle Eastern", "Dutch"];
const PROTEINS = ["Chicken", "Beef", "Fish", "Eggs", "Tofu", "Quark/Skyr", "Beans"];
const VARIETY = [{ id: 1, label: "Same daily" }, { id: 2, label: "2 days" }, { id: 3, label: "3 days" }, { id: 7, label: "All diff." }];
const WD = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];
const SHOP_ORDER = ["Produce", "Protein", "Dairy", "Grains & Carbs", "Pantry", "Other"];
const fonts = `@import url('https://fonts.googleapis.com/css2?family=Oswald:wght@400;500;600;700&family=Inter:wght@400;500;600&display=swap');`;

const num = (v, d = 0) => { const n = parseFloat(v); return isNaN(n) ? d : n; };

function categorize(name) {
  const n = (name || "").toLowerCase();
  if (/chicken|beef|turkey|pork|steak|mince|egg|tofu|tempeh|salmon|tuna|fish|shrimp|prawn|cod|lentil|bean|chickpea|ham|bacon/.test(n)) return "Protein";
  if (/milk|yog|yoghurt|yogurt|quark|skyr|cheese|cottage|cream|butter|whey/.test(n)) return "Dairy";
  if (/rice|pasta|bread|oat|potato|quinoa|couscous|noodle|tortilla|wrap|flour|cereal|bulgur|cracker/.test(n)) return "Grains & Carbs";
  if (/oil|sauce|spice|salt|pepper|honey|vinegar|stock|broth|seed|nut|peanut|almond|cashew|tahini|syrup|powder|jam|herb/.test(n)) return "Pantry";
  if (/apple|banana|berry|berries|spinach|broccoli|pepper|onion|garlic|tomato|carrot|courgette|zucchini|cucumber|lettuce|avocado|lemon|lime|mushroom|kale|veg|fruit|leek|cabbage|sprout|pea|orange|mango|grape/.test(n)) return "Produce";
  return "Other";
}

// Roept de backend aan voor één groep dagen.
async function fetchChunk(payload) {
  const res = await fetch("/api/plan", {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify(payload),
  });
  const data = await res.json().catch(() => ({}));
  if (!res.ok) throw new Error(data.error || ("Fout " + res.status));
  return data; // { targets, plan }
}

export default function App() {
  const [sex, setSex] = useState("male");
  const [age, setAge] = useState("43");
  const [height, setHeight] = useState("190");
  const [weight, setWeight] = useState("87");
  const [activity, setActivity] = useState("moderate");
  const [goal, setGoal] = useState("maintain");
  const [diet, setDiet] = useState("High-protein");
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

  function common() {
    return { sex, age, height, weight, activity, goal, diet, avoid, likes, cuisines, proteins, weekIndex: 0 };
  }

  async function handleBuild() {
    setError(""); setStarted(true); setView("plan"); setChecked({});
    setLoading(true); setWeek(null); setTargets(null);
    try {
      const count = variety;
      const labels = Array.from({ length: count }, (_, i) => "D" + (i + 1));
      const chunks = [];
      for (let i = 0; i < labels.length; i += 2) chunks.push(labels.slice(i, i + 2));

      let unique = [], tgt = null;
      for (const ch of chunks) {
        const data = await fetchChunk({ ...common(), labels: ch });
        tgt = data.targets;
        unique = unique.concat((data.plan && data.plan.days) || []);
      }
      if (!unique.length) throw new Error("Geen dagen ontvangen");
      const days = WD.map((d, i) => {
        const u = unique[i % unique.length];
        return { d, set: String.fromCharCode(65 + (i % unique.length)), m: u.m };
      });
      setTargets(tgt);
      setWeek({ days, sets: unique.length });
    } catch (e) {
      setError(e && e.message ? e.message : "Onbekende fout");
    } finally {
      setLoading(false);
    }
  }

  function shoppingFor(wk) {
    const agg = {};
    wk.days.forEach((day) => day.m.forEach((meal) => (meal.ing || []).forEach((ing) => {
      const key = (ing.n || "").trim();
      if (!key) return;
      if (!agg[key]) agg[key] = { g: 0, cat: categorize(key) };
      agg[key].g += num(ing.g);
    })));
    const byCat = {};
    Object.entries(agg).forEach(([name, v]) => { (byCat[v.cat] = byCat[v.cat] || []).push({ name, g: Math.round(v.g) }); });
    return SHOP_ORDER.filter((c) => byCat[c]).map((c) => ({ n: c, i: byCat[c].sort((a, b) => b.g - a.g) }));
  }

  const label = { fontFamily: "Inter, sans-serif", fontSize: 11, letterSpacing: 1, textTransform: "uppercase", color: MUTED, marginBottom: 6, display: "block", fontWeight: 600 };
  const input = { width: "100%", background: INK, border: `1px solid ${LINE}`, color: PAPER, padding: "11px 12px", fontFamily: "Inter, sans-serif", fontSize: 14, borderRadius: 8, outline: "none", boxSizing: "border-box" };
  const disp = { fontFamily: "Oswald, sans-serif" };
  const chipS = (on) => ({ padding: "7px 12px", borderRadius: 20, border: `1px solid ${on ? EMBER : LINE}`, background: on ? "rgba(255,90,31,0.14)" : "transparent", fontSize: 12.5, fontWeight: 600, cursor: "pointer" });
  const segS = (on) => ({ flex: 1, textAlign: "center", padding: "9px 4px", borderRadius: 8, border: `1px solid ${on ? EMBER : LINE}`, background: on ? "rgba(255,90,31,0.12)" : "transparent", fontSize: 12, fontWeight: 600, cursor: "pointer" });

  return (
    <div style={{ minHeight: "100vh", background: INK, color: PAPER, fontFamily: "Inter, sans-serif" }}>
      <style dangerouslySetInnerHTML={{ __html: fonts + `*{box-sizing:border-box} select option{background:${INK2};color:${PAPER}} @keyframes pulse{0%,100%{opacity:.4}50%{opacity:1}} .dot{animation:pulse 1s infinite}` }} />

      <div style={{ borderBottom: `1px solid ${LINE}`, padding: "18px 20px", display: "flex", alignItems: "center", gap: 12 }}>
        <div style={{ width: 34, height: 34, borderRadius: 8, background: EMBER, display: "flex", alignItems: "center", justifyContent: "center", ...disp, fontWeight: 700, color: INK, fontSize: 20 }}>H</div>
        <div>
          <div style={{ ...disp, fontWeight: 700, fontSize: 21, letterSpacing: 0.5, lineHeight: 1 }}>HYBRIDFUEL<span style={{ color: EMBER }}>CO</span></div>
          <div style={{ fontSize: 10.5, color: MUTED, letterSpacing: 1, textTransform: "uppercase", marginTop: 3 }}>Personalized fuel plans</div>
        </div>
      </div>

      <div style={{ maxWidth: 1080, margin: "0 auto", padding: 16, display: "grid", gridTemplateColumns: "minmax(0,1fr)", gap: 18 }}>
        <div style={{ background: INK2, border: `1px solid ${LINE}`, borderRadius: 14, padding: 18 }}>
          <div style={{ ...disp, fontSize: 15, fontWeight: 600, textTransform: "uppercase", letterSpacing: 1.5, marginBottom: 16, color: EMBER }}>Your stats</div>

          <div style={{ display: "flex", gap: 10, marginBottom: 14 }}>
            {["male", "female"].map((s) => (
              <div key={s} onClick={() => setSex(s)} style={{ ...segS(sex === s), textTransform: "capitalize", padding: "10px 0" }}>{s}</div>
            ))}
          </div>
          <div style={{ display: "grid", gridTemplateColumns: "1fr 1fr 1fr", gap: 10, marginBottom: 14 }}>
            <div><label style={label}>Age</label><input style={input} value={age} onChange={(e) => setAge(e.target.value)} inputMode="numeric" /></div>
            <div><label style={label}>Height</label><input style={input} value={height} onChange={(e) => setHeight(e.target.value)} inputMode="numeric" /></div>
            <div><label style={label}>Weight</label><input style={input} value={weight} onChange={(e) => setWeight(e.target.value)} inputMode="numeric" /></div>
          </div>
          <div style={{ marginBottom: 14 }}>
            <label style={label}>Training load</label>
            <select style={input} value={activity} onChange={(e) => setActivity(e.target.value)}>
              {ACTIVITY.map((a) => <option key={a.id} value={a.id}>{a.label}</option>)}
            </select>
          </div>
          <div style={{ marginBottom: 14 }}>
            <label style={label}>Goal</label>
            <div style={{ display: "flex", gap: 8 }}>
              {GOALS.map((g) => <div key={g.id} onClick={() => setGoal(g.id)} style={segS(goal === g.id)}>{g.label}</div>)}
            </div>
          </div>
          <div style={{ marginBottom: 14 }}>
            <label style={label}>Diet</label>
            <select style={input} value={diet} onChange={(e) => setDiet(e.target.value)}>
              {DIETS.map((d) => <option key={d} value={d}>{d}</option>)}
            </select>
          </div>
          <div style={{ marginBottom: 16 }}>
            <label style={label}>Avoid / allergies</label>
            <input style={input} value={avoid} onChange={(e) => setAvoid(e.target.value)} placeholder="e.g. peanuts, shellfish" />
          </div>

          <div style={{ height: 1, background: LINE, margin: "2px 0 16px" }} />
          <div style={{ ...disp, fontSize: 15, fontWeight: 600, textTransform: "uppercase", letterSpacing: 1.5, marginBottom: 14, color: EMBER }}>What you love</div>
          <div style={{ marginBottom: 14 }}>
            <label style={label}>Favourite foods</label>
            <input style={input} value={likes} onChange={(e) => setLikes(e.target.value)} placeholder="e.g. chicken, rice, quark" />
          </div>
          <div style={{ marginBottom: 14 }}>
            <label style={label}>Go-to proteins</label>
            <div style={{ display: "flex", flexWrap: "wrap", gap: 7 }}>
              {PROTEINS.map((p) => <div key={p} onClick={() => toggle(p, proteins, setProteins)} style={chipS(proteins.includes(p))}>{p}</div>)}
            </div>
          </div>
          <div style={{ marginBottom: 16 }}>
            <label style={label}>Cuisine vibe</label>
            <div style={{ display: "flex", flexWrap: "wrap", gap: 7 }}>
              {CUISINES.map((c) => <div key={c} onClick={() => toggle(c, cuisines, setCuisines)} style={chipS(cuisines.includes(c))}>{c}</div>)}
            </div>
          </div>

          <div style={{ height: 1, background: LINE, margin: "2px 0 16px" }} />
          <div style={{ marginBottom: 18 }}>
            <label style={label}>How varied? (different days)</label>
            <div style={{ display: "flex", gap: 6 }}>
              {VARIETY.map((v) => <div key={v.id} onClick={() => setVariety(v.id)} style={{ ...segS(variety === v.id), fontSize: 11.5, padding: "9px 2px" }}>{v.label}</div>)}
            </div>
          </div>

          <button onClick={handleBuild} disabled={loading} style={{ width: "100%", background: EMBER, color: INK, border: "none", padding: "14px 0", borderRadius: 10, ...disp, fontWeight: 700, fontSize: 16, letterSpacing: 1, textTransform: "uppercase", cursor: loading ? "default" : "pointer", opacity: loading ? 0.7 : 1 }}>
            {loading ? "Building…" : "Build my plan"}
          </button>
        </div>

        <div>
          {!started && (
            <div style={{ border: `1px dashed ${LINE}`, borderRadius: 14, padding: "48px 24px", textAlign: "center", color: MUTED }}>
              <div style={{ ...disp, fontSize: 24, fontWeight: 600, color: PAPER, marginBottom: 8 }}>Fuel the work.</div>
              <div style={{ fontSize: 13.5, lineHeight: 1.6 }}>Vul je gegevens in. We berekenen je macro's en bouwen een plan met gewichten.</div>
            </div>
          )}

          {started && (
            <>
              {targets && (
                <div style={{ background: INK2, border: `1px solid ${LINE}`, borderRadius: 14, padding: 16, marginBottom: 16 }}>
                  <div style={{ display: "flex", justifyContent: "space-between", alignItems: "baseline", marginBottom: 12 }}>
                    <div style={{ ...label, marginBottom: 0 }}>Daily targets</div>
                    <div style={{ ...disp, fontSize: 28, fontWeight: 700 }}>{targets.kcal}<span style={{ fontSize: 12, color: MUTED, fontWeight: 400, marginLeft: 5 }}>kcal</span></div>
                  </div>
                  {targets.maintenance != null && (
                    <div style={{ fontSize: 12, color: MUTED, marginBottom: 12 }}>
                      Onderhoud ≈ <span style={{ color: PAPER }}>{targets.maintenance} kcal</span>{targets.kcal !== targets.maintenance && <> · doel zit {targets.kcal < targets.maintenance ? (targets.maintenance - targets.kcal) + " onder" : (targets.kcal - targets.maintenance) + " boven"}</>}
                    </div>
                  )}
                  <div style={{ display: "grid", gridTemplateColumns: "1fr 1fr 1fr", gap: 8 }}>
                    {[["Protein", targets.protein, EMBER], ["Carbs", targets.carbs, EMBER_SOFT], ["Fat", targets.fat, SAGE]].map(([n, v, c]) => (
                      <div key={n} style={{ background: INK, borderRadius: 10, padding: "10px 12px", borderLeft: `3px solid ${c}` }}>
                        <div style={{ fontSize: 10, letterSpacing: 1, textTransform: "uppercase", color: MUTED, fontWeight: 600 }}>{n}</div>
                        <div style={{ ...disp, fontSize: 20, fontWeight: 600 }}>{v}<span style={{ fontSize: 10, color: MUTED, marginLeft: 3 }}>g</span></div>
                      </div>
                    ))}
                  </div>
                </div>
              )}

              {week && !loading && (
                <div style={{ display: "inline-flex", gap: 4, marginBottom: 14, background: INK2, border: `1px solid ${LINE}`, borderRadius: 10, padding: 4 }}>
                  {[["plan", "Plan"], ["shop", "Shopping list"]].map(([id, lbl]) => (
                    <div key={id} onClick={() => setView(id)} style={{ padding: "8px 16px", borderRadius: 7, background: view === id ? EMBER : "transparent", color: view === id ? INK : PAPER, fontSize: 13, fontWeight: 700, ...disp, letterSpacing: 0.5, cursor: "pointer" }}>{lbl}</div>
                  ))}
                </div>
              )}

              {loading && <div style={{ textAlign: "center", padding: "40px 0", color: EMBER, ...disp, fontSize: 17, letterSpacing: 1 }}><span className="dot">COOKING UP YOUR PLAN…</span></div>}

              {error && !loading && (
                <div style={{ background: "rgba(255,90,31,0.1)", border: `1px solid ${EMBER}`, borderRadius: 12, padding: 16, textAlign: "center" }}>
                  <div style={{ marginBottom: 12, color: PAPER, fontSize: 13, wordBreak: "break-word" }}>{error}</div>
                  <button onClick={handleBuild} style={{ background: EMBER, color: INK, border: "none", padding: "9px 22px", borderRadius: 8, fontWeight: 700, cursor: "pointer", ...disp, letterSpacing: 1 }}>RETRY</button>
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
                  <div style={{ fontSize: 12, color: MUTED }}>Totalen voor de week, opgeteld uit je gewichten. Tik om af te vinken.</div>
                  {shoppingFor(week).map((cat, ci) => (
                    <div key={ci} style={{ background: INK2, border: `1px solid ${LINE}`, borderRadius: 12, overflow: "hidden" }}>
                      <div style={{ padding: "10px 14px", background: INK, borderBottom: `1px solid ${LINE}`, ...disp, fontWeight: 600, fontSize: 13.5, letterSpacing: 1, textTransform: "uppercase", color: EMBER }}>{cat.n}</div>
                      {cat.i.map((item, ii) => {
                        const key = cat.n + ":" + item.name, on = checked[key];
                        return (
                          <div key={ii} onClick={() => setChecked((p) => ({ ...p, [key]: !p[key] }))} style={{ display: "flex", alignItems: "center", gap: 11, padding: "10px 14px", borderBottom: ii < cat.i.length - 1 ? `1px solid ${LINE}` : "none", cursor: "pointer" }}>
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

      <div style={{ textAlign: "center", padding: "8px 20px 28px", color: MUTED, fontSize: 10.5, lineHeight: 1.6 }}>
        Schattingen, geen medisch advies. Drink voldoende water en raadpleeg een professional bij twijfel.
      </div>
    </div>
  );
}
