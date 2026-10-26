import React, { useState, useEffect } from "react";
import { INK, INK2, EMBER, EMBER_SOFT, PAPER, MUTED, LINE, SAGE, disp, num, card, label, sectionTitle, primaryBtn, WD, jsDayToIdx, load, save, todayISO, fmtDate } from "../shared.js";
import { supabase } from "../supabaseClient.js";
import Products from "./Products.jsx";

const T = {
  title: { nl: "Dagboek", en: "Diary" },
  none: { nl: "Nog geen plan", en: "No plan yet" },
  noneBody: { nl: "Maak eerst je weekplan aan. Daarna zie je hier per dag je maaltijden en vink je ze af — en je kunt alles loggen wat je extra eet.", en: "Build your week plan first. Then you'll see your meals per day and check them off here — and log anything extra you eat." },
  goPlan: { nl: "Naar plan", en: "Go to plan" },
  train: { nl: "Trainingsdag", en: "Training day" },
  rest: { nl: "Rustdag", en: "Rest day" },
  eaten: { nl: "gehad", en: "had" },
  of: { nl: "van", en: "of" },
  done: { nl: "Alles gehad voor deze dag", en: "All done for this day" },
  tapHint: { nl: "Tik een maaltijd aan als je 'm hebt gehad.", en: "Tap a meal when you've had it." },
  today: { nl: "Vandaag", en: "Today" },
  planned: { nl: "Uit je plan", en: "From your plan" },
  extra: { nl: "Extra gelogd", en: "Extra logged" },
  addItem: { nl: "+ Iets toevoegen (scan / product)", en: "+ Add something (scan / product)" },
  noExtra: { nl: "Snel iets anders gegeten? Scan het of kies een product en zet het in deze dag.", en: "Ate something else? Scan it or pick a product and add it to this day." },
  g: { nl: "g", en: "g" },
  yourDay: { nl: "Je dag", en: "Your day" },
  onpoint: { nl: "on point", en: "on point" },
  under: { nl: "te laag", en: "under" },
  over: { nl: "te veel", en: "over" },
  kcalLbl: { nl: "Calorieën", en: "Calories" },
  protLbl: { nl: "Eiwit", en: "Protein" },
  carbLbl: { nl: "Koolhydraten", en: "Carbs" },
  fatLbl: { nl: "Vet", en: "Fat" },
  waterLbl: { nl: "Water", en: "Water" },
  hpTitle: { nl: "Leven gebeurt", en: "Life happens" },
  hpBtn: { nl: "Herbalanceer de rest van mijn dag", en: "Rebalance the rest of my day" },
  hpNote: { nl: "De app schaalt je nog niet-afgevinkte maaltijden zodat je dag alsnog op je doel landt.", en: "The app scales your unchecked meals so your day still lands on target." },
  hpDone: { nl: "Dag aangepast ✓ — resterende maaltijden geschaald.", en: "Day adjusted ✓ — remaining meals scaled." },
  hpUndo: { nl: "Ongedaan maken", en: "Undo" },
  hpNoRoom: { nl: "Geen maaltijden meer open om te schalen. Pak het morgen terug.", en: "No meals left to scale. Pick it up tomorrow." },
};

function Ring({ pct }) {
  const R = 26, C = 2 * Math.PI * R;
  const off = C * (1 - Math.max(0, Math.min(1, pct)));
  return (
    <svg width="64" height="64" viewBox="0 0 64 64">
      <circle cx="32" cy="32" r={R} fill="none" stroke={LINE} strokeWidth="6" />
      <circle cx="32" cy="32" r={R} fill="none" stroke={EMBER} strokeWidth="6" strokeLinecap="round" strokeDasharray={C} strokeDashoffset={off} transform="rotate(-90 32 32)" />
      <text x="32" y="36" textAnchor="middle" fill={PAPER} fontSize="14" fontFamily="Oswald" fontWeight="600">{Math.round(pct * 100)}%</text>
    </svg>
  );
}

export default function Today({ lang, week, onGoPlan, session, plus, onRebalance }) {
  const t = (k) => (T[k] ? T[k][lang] : k);
  const cloud = !!(session && supabase);
  const [d, setD] = useState(todayISO());
  const [eaten, setEaten] = useState({});
  const [extras, setExtras] = useState([]);
  const [showAdd, setShowAdd] = useState(false);
  const [waterMl, setWaterMl] = useState(0);
  const [weightKg, setWeightKg] = useState(0);
  const [undo, setUndo] = useState(null);
  const [over, setOver] = useState(null);

  useEffect(() => {
    setEaten(load("hf_eaten_" + d, {}));
    setUndo(null);
    setOver(load("hf_dayover_" + d, null));
    let active = true;
    // Handmatig gewicht uit de Water-tab wint (zelfde logica als Water).
    const mw = num(load("hf_water_weight", ""));
    if (mw > 0) setWeightKg(mw);
    if (cloud) {
      supabase.from("food_logs").select("id,item,grams,kcal,p,c,f").eq("user_id", session.user.id).eq("date", d).order("created_at")
        .then(({ data }) => { if (active && data) setExtras(data.map((r) => ({ ...r }))); }, () => {});
      supabase.from("water_logs").select("ml").eq("user_id", session.user.id).eq("date", d)
        .then(({ data }) => { if (active) setWaterMl((data && data[0] && data[0].ml) || 0); }, () => {});
      if (mw <= 0) supabase.from("weights").select("kg").eq("user_id", session.user.id).order("date", { ascending: false }).limit(1)
        .then(({ data }) => { if (active && data && data[0]) setWeightKg(Number(data[0].kg)); }, () => {});
    } else {
      setExtras(load("hf_food_" + d, []));
      setWaterMl((load("hf_water", {})[d]) || 0);
      if (mw <= 0) { const ws = load("hf_weights", []); if (ws.length) { const s = [...ws].sort((a, b) => a.date.localeCompare(b.date)); setWeightKg(Number(s[s.length - 1].kg)); } }
    }
    return () => { active = false; };
  }, [d, session]);

  // Datum-shift tijdzone-veilig: middag pakken + lokaal formatteren (geen toISOString/UTC).
  const shiftDay = (n) => {
    const dt = new Date(d + "T12:00:00");
    dt.setDate(dt.getDate() + n);
    setD(dt.getFullYear() + "-" + String(dt.getMonth() + 1).padStart(2, "0") + "-" + String(dt.getDate()).padStart(2, "0"));
  };
  const isToday = d === todayISO();
  const idx = jsDayToIdx(new Date(d + "T12:00:00").getDay());
  const tmpl = week && week.days && week.days.length ? (week.days[idx] || week.days[0]) : null;
  const day = over || tmpl;

  function toggle(i) { const next = { ...eaten, [i]: !eaten[i] }; setEaten(next); save("hf_eaten_" + d, next); }

  function persistExtras(next) { setExtras(next); if (!cloud) save("hf_food_" + d, next); }
  function addFromProduct(product) {
    const g = 100, p1 = product.per_100 || {};
    const calc = (k) => Math.round(num(p1[k]) * g / 100);
    const row = { item: product.name, grams: g, kcal: calc("kcal"), p: calc("p"), c: calc("c"), f: calc("f"), per100: p1 };
    if (cloud) {
      supabase.from("food_logs").insert({ user_id: session.user.id, date: d, item: row.item, grams: g, kcal: row.kcal, p: row.p, c: row.c, f: row.f, source: "product" }).select("id,item,grams,kcal,p,c,f").single()
        .then(({ data }) => { if (data) setExtras((e) => [...e, { ...data, per100: p1 }]); }, () => {});
    } else {
      persistExtras([...extras, { id: "l" + Date.now(), ...row }]);
    }
    setShowAdd(false);
  }
  function setGrams(id, g) {
    persistExtras(extras.map((x) => {
      if (x.id !== id) return x;
      const p1 = x.per100; if (!p1) return { ...x, grams: g };
      const calc = (k) => Math.round(num(p1[k]) * num(g) / 100);
      const row = { ...x, grams: g, kcal: calc("kcal"), p: calc("p"), c: calc("c"), f: calc("f") };
      if (cloud) supabase.from("food_logs").update({ grams: num(g), kcal: row.kcal, p: row.p, c: row.c, f: row.f }).eq("id", id).then(() => {}, () => {});
      return row;
    }));
  }
  function delExtra(id) { const next = extras.filter((x) => x.id !== id); setExtras(next); if (cloud) supabase.from("food_logs").delete().eq("id", id).then(() => {}, () => {}); else save("hf_food_" + d, next); }

  const plannedTotal = day ? day.m.reduce((a, m) => a + num(m.kcal), 0) : 0;
  const eatenPlanned = day ? day.m.reduce((a, m, i) => a + (eaten[i] ? num(m.kcal) : 0), 0) : 0;
  const extrasKcal = extras.reduce((a, x) => a + num(x.kcal), 0);
  const consumed = eatenPlanned + extrasKcal;
  const goal = plannedTotal;
  const pct = goal ? consumed / goal : 0;
  const allDone = day && day.m.length > 0 && day.m.every((_, i) => eaten[i]);
  const wd = WD[lang === "nl" ? "nl" : "en"][idx];

  // Macro-doel = dagplan-totaal; gegeten = afgevinkte maaltijden + extra's.
  const sumPlan = (k) => (day ? day.m.reduce((a, m) => a + num(m[k]), 0) : 0);
  const sumEatenPlan = (k) => (day ? day.m.reduce((a, m, i) => a + (eaten[i] ? num(m[k]) : 0), 0) : 0);
  const sumExtra = (k) => extras.reduce((a, x) => a + num(x[k]), 0);
  const cons = (k) => sumEatenPlan(k) + sumExtra(k);
  const waterGoal = weightKg > 0 ? Math.round((35 * weightKg + (day && day.train ? 500 : 0)) / 50) * 50 : 0;

  // ===== "Leven gebeurt"-herplanner =====
  const R = (x) => Math.round(num(x));
  const remIdx = day ? day.m.map((m, i) => i).filter((i) => !eaten[i]) : [];
  const remKcal = remIdx.reduce((a, i) => a + num(day.m[i].kcal), 0);
  const goalKcal = (day && day.goal && day.goal.kcal) || plannedTotal;
  const projDiff = day ? Math.round((consumed + remKcal) - goalKcal) : 0; // >0 = koers boven doel
  const canRebalance = !!(plus && day && onRebalance && remIdx.length > 0 && Math.abs(projDiff) >= 60);
  function doRebalance() {
    if (!day || !onRebalance || remKcal <= 0) return;
    let f = (goalKcal - consumed) / remKcal;
    f = Math.max(0.35, Math.min(1.4, f));
    const snapGoal = (day.goal) || { kcal: plannedTotal, p: sumPlan("p"), c: sumPlan("c"), f: sumPlan("f") };
    const newMeals = day.m.map((m, i) => eaten[i] ? m : { ...m, kcal: R(num(m.kcal) * f), p: R(num(m.p) * f), c: R(num(m.c) * f), f: R(num(m.f) * f), ing: (m.ing || []).map((g) => ({ ...g, g: R(num(g.g) * f) })) });
    setUndo({ meals: day.m, goal: day.goal || null });
    applyDayMeals(newMeals, snapGoal);
  }
  function applyDayMeals(newMeals, goal) {
    if (over) { const nd = { ...over, m: newMeals, goal: goal || over.goal }; save("hf_dayover_" + d, nd); setOver(nd); }
    else if (onRebalance) onRebalance(idx, newMeals, goal);
  }
  function doUndo() { if (!undo) return; applyDayMeals(undo.meals, undo.goal); setUndo(null); }

  function statusOf(c, target) {
    if (!target) return { label: "—", color: MUTED };
    const r = c / target;
    if (r < 0.9) return { label: t("under"), color: EMBER_SOFT };
    if (r > 1.1) return { label: t("over"), color: EMBER };
    return { label: t("onpoint"), color: "#4ADE80" };
  }
  const block = (lbl, c, target, unit) => {
    const s = statusOf(c, target);
    return (
      <div style={{ background: INK2, border: `1px solid ${LINE}`, borderLeft: `3px solid ${s.color}`, borderRadius: 10, padding: "11px 13px" }}>
        <div style={{ fontSize: 9.5, letterSpacing: 1, textTransform: "uppercase", color: MUTED, fontWeight: 600 }}>{lbl}</div>
        <div style={{ ...disp, fontSize: 18, fontWeight: 600, marginTop: 2, color: PAPER }}>{Math.round(c)}<span style={{ fontSize: 11.5, color: MUTED, fontWeight: 500 }}> / {Math.round(target)}{unit}</span></div>
        <div style={{ fontSize: 10, color: s.color, fontWeight: 700, marginTop: 1 }}>{s.label}</div>
      </div>
    );
  };

  const dateNav = (
    <div style={{ display: "flex", alignItems: "center", justifyContent: "space-between", gap: 8 }}>
      <div onClick={() => shiftDay(-1)} style={{ cursor: "pointer", width: 34, height: 34, borderRadius: 9, border: `1px solid ${LINE}`, display: "flex", alignItems: "center", justifyContent: "center", color: PAPER, fontSize: 18 }}>‹</div>
      <div style={{ textAlign: "center" }}>
        <div style={{ ...disp, fontSize: 15, fontWeight: 600, letterSpacing: 0.5 }}>{isToday ? t("today") : wd} · {fmtDate(d, lang)}</div>
      </div>
      <div onClick={() => shiftDay(1)} style={{ cursor: "pointer", width: 34, height: 34, borderRadius: 9, border: `1px solid ${LINE}`, display: "flex", alignItems: "center", justifyContent: "center", color: PAPER, fontSize: 18 }}>›</div>
    </div>
  );

  return (
    <div style={{ display: "grid", gap: 16 }}>
      <div style={sectionTitle}>{t("title")}</div>
      <div style={card}>{dateNav}</div>

      {!day ? (
        <div style={{ border: `1px dashed ${LINE}`, borderRadius: 14, padding: "32px 22px", textAlign: "center" }}>
          <div style={{ ...disp, fontSize: 19, fontWeight: 600, color: PAPER, marginBottom: 8 }}>{t("none")}</div>
          <div style={{ fontSize: 13, color: MUTED, lineHeight: 1.6, marginBottom: 18 }}>{t("noneBody")}</div>
          <button onClick={onGoPlan} style={{ ...primaryBtn, width: "auto", padding: "12px 26px" }}>{t("goPlan")}</button>
        </div>
      ) : (
        <>
          <div>
            <div style={{ display: "flex", justifyContent: "space-between", alignItems: "center", marginBottom: 10 }}>
              <div style={label}>{t("yourDay")}</div>
              <div style={{ display: "flex", alignItems: "center", gap: 8 }}>
                <Ring pct={pct} />
                {day.race && <div style={{ fontSize: 9.5, color: PAPER, background: EMBER, borderRadius: 5, padding: "2px 7px", letterSpacing: 1, fontWeight: 700, ...disp }}>{day.race}</div>}
                <div style={{ fontSize: 9.5, color: day.train ? EMBER : MUTED, border: `1px solid ${day.train ? EMBER : LINE}`, borderRadius: 5, padding: "2px 6px", letterSpacing: 1, fontWeight: 700 }}>{day.train ? t("train") : t("rest")}</div>
              </div>
            </div>
            {block(t("kcalLbl"), consumed, goal, "")}
            <div style={{ display: "grid", gridTemplateColumns: "1fr 1fr", gap: 8, marginTop: 8 }}>
              {block(t("waterLbl"), waterMl, waterGoal, " ml")}
              {block(t("protLbl"), cons("p"), sumPlan("p"), "g")}
              {block(t("carbLbl"), cons("c"), sumPlan("c"), "g")}
              {block(t("fatLbl"), cons("f"), sumPlan("f"), "g")}
            </div>
            <div style={{ fontSize: 11.5, color: allDone ? "#4ADE80" : MUTED, marginTop: 10 }}>{allDone ? t("done") : t("tapHint")}</div>
          </div>

          {/* "Leven gebeurt"-herplanner (Plus) */}
          {plus && day && (undo || canRebalance) && (
            <div style={{ border: `1px solid ${EMBER}`, borderRadius: 14, padding: 15, backgroundImage: "radial-gradient(120% 90% at 100% 0%, rgba(225,29,72,0.14), transparent 62%)" }}>
              <div style={{ display: "flex", alignItems: "center", gap: 8, marginBottom: 7 }}>
                <svg width="17" height="17" viewBox="0 0 24 24" fill="none" stroke={EMBER} strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><path d="M3 12a9 9 0 1 0 2.6-6.4M3 4v4h4" /></svg>
                <div style={{ ...disp, fontSize: 13.5, fontWeight: 700, letterSpacing: 0.5, textTransform: "uppercase", color: EMBER }}>{t("hpTitle")}</div>
              </div>
              {undo ? (
                <>
                  <div style={{ fontSize: 12.5, color: PAPER, lineHeight: 1.5, marginBottom: 12 }}>{t("hpDone")}</div>
                  <button onClick={doUndo} style={{ background: "transparent", color: EMBER, border: `1px solid ${EMBER}`, borderRadius: 9, padding: "9px 16px", ...disp, fontWeight: 700, fontSize: 12.5, letterSpacing: 0.5, cursor: "pointer" }}>{t("hpUndo")}</button>
                </>
              ) : (
                <>
                  <div style={{ fontSize: 12.5, color: PAPER, lineHeight: 1.5, marginBottom: 4 }}>
                    {lang === "nl"
                      ? `Zoals je dag nu loopt, kom je ~${Math.abs(projDiff)} kcal ${projDiff > 0 ? "bóven" : "ónder"} je doel uit.`
                      : `As your day is going, you'll end ~${Math.abs(projDiff)} kcal ${projDiff > 0 ? "over" : "under"} target.`}
                  </div>
                  <div style={{ fontSize: 11, color: MUTED, lineHeight: 1.5, marginBottom: 12 }}>{t("hpNote")}</div>
                  <button onClick={doRebalance} style={{ background: EMBER, color: PAPER, border: "none", borderRadius: 9, padding: "11px 18px", ...disp, fontWeight: 700, fontSize: 13, letterSpacing: 0.5, cursor: "pointer" }}>{t("hpBtn")}</button>
                </>
              )}
            </div>
          )}

          <div>
            <div style={{ ...label, marginBottom: 10 }}>{t("planned")}</div>
            <div style={{ display: "grid", gap: 10 }}>
              {day.m.map((m, i) => {
                const on = !!eaten[i];
                return (
                  <div key={i} onClick={() => toggle(i)} style={{ background: INK2, border: `1px solid ${on ? EMBER : LINE}`, borderRadius: 12, padding: "12px 14px", cursor: "pointer", display: "flex", gap: 12, alignItems: "flex-start", opacity: on ? 0.72 : 1 }}>
                    <div style={{ width: 22, height: 22, borderRadius: 7, border: `2px solid ${on ? EMBER : MUTED}`, background: on ? EMBER : "transparent", display: "flex", alignItems: "center", justifyContent: "center", flexShrink: 0, color: PAPER, fontSize: 13, fontWeight: 800, marginTop: 1 }}>{on ? "✓" : ""}</div>
                    <div style={{ flex: 1 }}>
                      <div style={{ fontSize: 9.5, color: EMBER, letterSpacing: 1, textTransform: "uppercase", fontWeight: 600, marginBottom: 2 }}>{m.t}</div>
                      <div style={{ fontSize: 14, fontWeight: 500, textDecoration: on ? "line-through" : "none" }}>{m.n}</div>
                      {m.ing && m.ing.length > 0 && (
                        <div style={{ fontSize: 11.5, color: MUTED, marginTop: 3, lineHeight: 1.5 }}>
                          {m.ing.map((ing, ii) => <span key={ii}><span style={{ color: on ? MUTED : PAPER }}>{Math.round(num(ing.g))}g</span> {ing.n}{ii < m.ing.length - 1 ? " · " : ""}</span>)}
                        </div>
                      )}
                    </div>
                    <div style={{ fontSize: 11, color: MUTED, textAlign: "right", whiteSpace: "nowrap" }}><span style={{ color: PAPER, fontWeight: 600 }}>{m.kcal}</span> kcal<br />{m.p}p/{m.c}c/{m.f}f</div>
                  </div>
                );
              })}
            </div>
          </div>

          <div>
            <div style={{ ...label, marginBottom: 10 }}>{t("extra")}</div>
            {!extras.length && <div style={{ fontSize: 12, color: MUTED, lineHeight: 1.6, marginBottom: 12 }}>{t("noExtra")}</div>}
            <div style={{ display: "grid", gap: 8, marginBottom: 12 }}>
              {extras.map((x) => (
                <div key={x.id} style={{ background: INK2, border: `1px solid ${LINE}`, borderRadius: 12, padding: "10px 12px", display: "flex", gap: 10, alignItems: "center" }}>
                  <div style={{ flex: 1, minWidth: 0 }}>
                    <div style={{ fontSize: 13.5, fontWeight: 600, color: PAPER }}>{x.item}</div>
                    <div style={{ fontSize: 11, color: MUTED, marginTop: 1 }}>{x.kcal} kcal · {x.p}p/{x.c}c/{x.f}f</div>
                  </div>
                  {x.per100 && <><input value={x.grams} onChange={(e) => setGrams(x.id, e.target.value)} inputMode="numeric" style={{ width: 52, textAlign: "right", background: INK, border: `1px solid ${LINE}`, color: PAPER, padding: "6px 7px", borderRadius: 7, fontSize: 12.5, outline: "none" }} /><span style={{ fontSize: 11, color: MUTED }}>{t("g")}</span></>}
                  <div onClick={() => delExtra(x.id)} style={{ cursor: "pointer", color: MUTED, fontSize: 16, padding: "0 2px" }}>×</div>
                </div>
              ))}
            </div>
            <button onClick={() => setShowAdd(true)} style={{ ...primaryBtn, background: "transparent", color: EMBER, border: `1px solid ${EMBER}` }}>{t("addItem")}</button>
          </div>
        </>
      )}

      {showAdd && <Products lang={lang} session={session} onClose={() => setShowAdd(false)} onPick={addFromProduct} />}
    </div>
  );
}
