import React, { useState, useEffect } from "react";
import { INK, INK2, EMBER, EMBER_SOFT, PAPER, MUTED, LINE, SAGE, disp, num, card, label, input, sectionTitle, primaryBtn, WD, jsDayToIdx, load, save, todayISO, fmtDate, macroLetters, gShow, gStore, wUnit, mlShow, vUnit } from "../shared.js";
import { supabase } from "../supabaseClient.js";
import Products from "./Products.jsx";
import { RECIPES } from "../recipes.js";
import { weekDatesFrom, planReductions, baseDayFor, dayTotal, upcomingSaturday, Rn } from "../weekbalance.js";

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
  addItem: { nl: "+ Iets toevoegen", en: "+ Add something" },
  noExtra: { nl: "Snel iets anders gegeten? Kies een recept, zoek een product of scan het en zet het in deze dag.", en: "Ate something else? Pick a recipe, search a product or scan it and add it to this day." },
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
  spreadBtn: { nl: "Verdeel over de week", en: "Spread across the week" },
  spreadNote: { nl: "We verdelen het verschil licht over de komende dagen van je week — binnen gezonde grenzen, geen crashdagen.", en: "We spread the difference lightly across the coming days of your week — within healthy limits, no crash days." },
  spreadUndo: { nl: "Ongedaan maken", en: "Undo" },
  feastOpen: { nl: "+ Uit-eten-dag plannen", en: "+ Plan an eating-out day" },
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

export default function Today({ lang, week, onGoPlan, session, plus, units, onRebalance }) {
  const t = (k) => (T[k] ? T[k][lang] : k);
  const ml = macroLetters(lang);
  const cloud = !!(session && supabase);
  const [d, setD] = useState(todayISO());
  const [eaten, setEaten] = useState({});
  const [extras, setExtras] = useState([]);
  const [showAdd, setShowAdd] = useState(false);
  const [waterMl, setWaterMl] = useState(0);
  const [weightKg, setWeightKg] = useState(0);
  const [undo, setUndo] = useState(null);
  const [spillUndo, setSpillUndo] = useState(null);
  const [showFeast, setShowFeast] = useState(false);
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
  function addFromRecipe(r) {
    const name = typeof r.name === "string" ? r.name : (r.name[lang] || r.name.en);
    const m = r.macros || {};
    const rec = { item: name, kcal: Math.round(num(m.kcal)), p: Math.round(num(m.p)), c: Math.round(num(m.c)), f: Math.round(num(m.f)) };
    if (cloud) {
      supabase.from("food_logs").insert({ user_id: session.user.id, date: d, item: rec.item, grams: null, kcal: rec.kcal, p: rec.p, c: rec.c, f: rec.f, source: "recipe" }).select("id,item,grams,kcal,p,c,f").single()
        .then(({ data }) => { if (data) setExtras((e) => [...e, { ...data }]); }, () => {});
    } else {
      persistExtras([...extras, { id: "l" + Date.now(), grams: null, ...rec }]);
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
  const spillDates = isToday ? weekDatesFrom(d).filter((x) => x > d) : [];
  const canSpread = !!(plus && day && isToday && Math.abs(projDiff) >= 60 && spillDates.length > 0);
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
  function doSpread() {
    if (!canSpread) return;
    const { ops, applied } = planReductions(spillDates, week, projDiff);
    if (!ops.length) return;
    const snap = ops.map((o) => ({ iso: o.iso, prev: load("hf_dayover_" + o.iso, null) }));
    ops.forEach((o) => save("hf_dayover_" + o.iso, { ...o.scaled, _spill: true }));
    setSpillUndo({ snap, applied, target: projDiff, days: ops.length });
  }
  function undoSpread() {
    if (!spillUndo) return;
    spillUndo.snap.forEach((s) => { if (s.prev) save("hf_dayover_" + s.iso, s.prev); else { try { localStorage.removeItem("hf_dayover_" + s.iso); } catch (e) {} } });
    setSpillUndo(null);
  }

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
      {plus && day && <div onClick={() => setShowFeast(true)} style={{ cursor: "pointer", textAlign: "center", border: `1px dashed ${LINE}`, borderRadius: 12, padding: "11px 14px", color: EMBER, ...disp, fontWeight: 700, fontSize: 12.5, letterSpacing: 0.3 }}>{t("feastOpen")}</div>}

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
              {units === "imperial" ? block(t("waterLbl"), mlShow(waterMl, units), mlShow(waterGoal, units), " fl oz") : block(t("waterLbl"), waterMl, waterGoal, " ml")}
              {block(t("protLbl"), cons("p"), sumPlan("p"), "g")}
              {block(t("carbLbl"), cons("c"), sumPlan("c"), "g")}
              {block(t("fatLbl"), cons("f"), sumPlan("f"), "g")}
            </div>
            <div style={{ fontSize: 11.5, color: allDone ? "#4ADE80" : MUTED, marginTop: 10 }}>{allDone ? t("done") : t("tapHint")}</div>
          </div>

          {/* "Leven gebeurt"-herplanner (Plus) — vandaag of over de week */}
          {plus && day && (undo || spillUndo || canRebalance || canSpread) && (
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
              ) : spillUndo ? (
                <>
                  <div style={{ fontSize: 12.5, color: PAPER, lineHeight: 1.5, marginBottom: 12 }}>
                    {Math.abs(spillUndo.applied) < Math.abs(spillUndo.target) - 30
                      ? (lang === "nl"
                        ? `We verdeelden ~${Math.abs(spillUndo.applied)} van ${Math.abs(spillUndo.target)} kcal over ${spillUndo.days} ${spillUndo.days === 1 ? "dag" : "dagen"} — de rest laten we gaan. Eén ${spillUndo.target > 0 ? "zware" : "lichte"} dag hoort erbij.`
                        : `We spread ~${Math.abs(spillUndo.applied)} of ${Math.abs(spillUndo.target)} kcal over ${spillUndo.days} ${spillUndo.days === 1 ? "day" : "days"} — the rest we let go. One ${spillUndo.target > 0 ? "heavy" : "light"} day is fine.`)
                      : (lang === "nl"
                        ? `Over je week verdeeld ✓ — ${spillUndo.days} ${spillUndo.days === 1 ? "dag" : "dagen"} licht aangepast.`
                        : `Spread across your week ✓ — ${spillUndo.days} ${spillUndo.days === 1 ? "day" : "days"} lightly adjusted.`)}
                  </div>
                  <button onClick={undoSpread} style={{ background: "transparent", color: EMBER, border: `1px solid ${EMBER}`, borderRadius: 9, padding: "9px 16px", ...disp, fontWeight: 700, fontSize: 12.5, letterSpacing: 0.5, cursor: "pointer" }}>{t("spreadUndo")}</button>
                </>
              ) : (
                <>
                  <div style={{ fontSize: 12.5, color: PAPER, lineHeight: 1.5, marginBottom: 4 }}>
                    {lang === "nl"
                      ? `Zoals je dag nu loopt, kom je ~${Math.abs(projDiff)} kcal ${projDiff > 0 ? "bóven" : "ónder"} je doel uit.`
                      : `As your day is going, you'll end ~${Math.abs(projDiff)} kcal ${projDiff > 0 ? "over" : "under"} target.`}
                  </div>
                  <div style={{ fontSize: 11, color: MUTED, lineHeight: 1.5, marginBottom: 12 }}>{canRebalance ? t("hpNote") : t("spreadNote")}</div>
                  <div style={{ display: "flex", flexWrap: "wrap", gap: 8 }}>
                    {canRebalance && <button onClick={doRebalance} style={{ background: EMBER, color: PAPER, border: "none", borderRadius: 9, padding: "11px 18px", ...disp, fontWeight: 700, fontSize: 13, letterSpacing: 0.5, cursor: "pointer" }}>{t("hpBtn")}</button>}
                    {canSpread && <button onClick={doSpread} style={{ background: canRebalance ? "transparent" : EMBER, color: canRebalance ? EMBER : PAPER, border: canRebalance ? `1px solid ${EMBER}` : "none", borderRadius: 9, padding: "11px 18px", ...disp, fontWeight: 700, fontSize: 13, letterSpacing: 0.5, cursor: "pointer" }}>{t("spreadBtn")}</button>}
                  </div>
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
                          {m.ing.map((ing, ii) => <span key={ii}><span style={{ color: on ? MUTED : PAPER }}>{gShow(ing.g, units)}{wUnit(units)}</span> {ing.n}{ii < m.ing.length - 1 ? " · " : ""}</span>)}
                        </div>
                      )}
                    </div>
                    <div style={{ fontSize: 11, color: MUTED, textAlign: "right", whiteSpace: "nowrap" }}><span style={{ color: PAPER, fontWeight: 600 }}>{m.kcal}</span> kcal<br />{m.p}{ml.p}/{m.c}{ml.c}/{m.f}{ml.f}</div>
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
                    <div style={{ fontSize: 11, color: MUTED, marginTop: 1 }}>{x.kcal} kcal · {x.p}{ml.p}/{x.c}{ml.c}/{x.f}{ml.f}</div>
                  </div>
                  {x.per100 && <><input value={gShow(x.grams, units)} onChange={(e) => setGrams(x.id, gStore(e.target.value, units))} inputMode="numeric" style={{ width: 54, textAlign: "right", background: INK, border: `1px solid ${LINE}`, color: PAPER, padding: "6px 7px", borderRadius: 7, fontSize: 12.5, outline: "none" }} /><span style={{ fontSize: 11, color: MUTED }}>{wUnit(units)}</span></>}
                  <div onClick={() => delExtra(x.id)} style={{ cursor: "pointer", color: MUTED, fontSize: 16, padding: "0 2px" }}>×</div>
                </div>
              ))}
            </div>
            <button onClick={() => setShowAdd(true)} style={{ ...primaryBtn, background: "transparent", color: EMBER, border: `1px solid ${EMBER}` }}>{t("addItem")}</button>
          </div>
        </>
      )}

      {showAdd && <AddExtra lang={lang} session={session} onClose={() => setShowAdd(false)} onPickProduct={addFromProduct} onPickRecipe={addFromRecipe} />}
      {showFeast && <FeastPlanner lang={lang} week={week} baseIso={d} onClose={() => setShowFeast(false)} />}
    </div>
  );
}

function FeastPlanner({ lang, week, baseIso, onClose }) {
  const today = todayISO();
  const [date, setDate] = useState(() => upcomingSaturday(today));
  const [preset, setPreset] = useState(700);
  const [result, setResult] = useState(null);

  const L = {
    title: lang === "nl" ? "Uit-eten-dag plannen" : "Plan an eating-out day",
    intro: lang === "nl" ? "Weet je dat je ergens uit eet? Kies de dag en een ruwe schatting. We trimmen de andere dagen van die week een beetje, zodat je weekgemiddelde klopt — binnen gezonde grenzen." : "Know you're eating out? Pick the day and a rough estimate. We'll trim the other days of that week a little, so your weekly average holds — within healthy limits.",
    dateL: lang === "nl" ? "Welke dag?" : "Which day?",
    howL: lang === "nl" ? "Hoeveel extra, ongeveer?" : "Roughly how much extra?",
    estimate: lang === "nl" ? "Het is een schatting — op de dag zelf log je gewoon wat je echt at." : "It's an estimate — on the day you just log what you really ate.",
    go: lang === "nl" ? "Inplannen" : "Plan it",
    undo: lang === "nl" ? "Ongedaan maken" : "Undo",
    close: lang === "nl" ? "Klaar" : "Done",
    err: lang === "nl" ? "Maak eerst je weekplan aan." : "Build your week plan first.",
  };
  const presets = [[400, lang === "nl" ? "Licht" : "Light"], [700, lang === "nl" ? "Normaal" : "Normal"], [1200, lang === "nl" ? "Stevig" : "Big"]];

  function apply() {
    const feastIso = date;
    const base = baseDayFor(feastIso, week);
    if (!base) { setResult({ err: true }); return; }
    const surplus = preset;
    const trimDates = weekDatesFrom(feastIso).filter((x) => x !== feastIso && x > today);
    const { ops, applied } = planReductions(trimDates, week, surplus);
    const snap = [{ iso: feastIso, prev: load("hf_dayover_" + feastIso, null) }, ...ops.map((o) => ({ iso: o.iso, prev: load("hf_dayover_" + o.iso, null) }))];
    const T = dayTotal(base);
    const gb = base.goal || { kcal: T, p: base.m.reduce((a, m) => a + num(m.p), 0), c: base.m.reduce((a, m) => a + num(m.c), 0), f: base.m.reduce((a, m) => a + num(m.f), 0) };
    const feastDay = { ...base, goal: { kcal: Rn(num(gb.kcal) + surplus), p: Rn(num(gb.p)), c: Rn(num(gb.c) + surplus / 4), f: Rn(num(gb.f)) }, _feast: true };
    save("hf_dayover_" + feastIso, feastDay);
    ops.forEach((o) => save("hf_dayover_" + o.iso, { ...o.scaled, _feast: true }));
    setResult({ surplus, applied, days: ops.length, snap });
  }
  function undo() {
    if (!result || !result.snap) return;
    result.snap.forEach((s) => { if (s.prev) save("hf_dayover_" + s.iso, s.prev); else { try { localStorage.removeItem("hf_dayover_" + s.iso); } catch (e) {} } });
    setResult(null);
  }

  const chip = (on) => ({ flex: 1, textAlign: "center", cursor: "pointer", ...disp, fontWeight: 700, fontSize: 13, padding: "11px 0", borderRadius: 9, border: `1px solid ${on ? EMBER : LINE}`, background: on ? "rgba(225,29,72,0.14)" : "transparent", color: on ? EMBER : MUTED });

  return (
    <div onClick={onClose} style={{ position: "fixed", inset: 0, background: "rgba(0,0,0,0.72)", backdropFilter: "blur(6px)", WebkitBackdropFilter: "blur(6px)", zIndex: 65, display: "flex", alignItems: "center", justifyContent: "center", padding: 16 }}>
      <div onClick={(e) => e.stopPropagation()} style={{ position: "relative", background: INK, border: `1px solid ${LINE}`, borderRadius: 20, width: "100%", maxWidth: 420, maxHeight: "90vh", overflowY: "auto", padding: 22, boxShadow: "0 24px 70px rgba(0,0,0,.65)", backgroundImage: "radial-gradient(130% 70% at 92% -10%, rgba(225,29,72,0.13), transparent 58%)" }}>
        <div style={{ display: "flex", justifyContent: "space-between", alignItems: "center", marginBottom: 14 }}>
          <div style={sectionTitle}>{L.title}</div>
          <div onClick={onClose} style={{ cursor: "pointer", color: MUTED, fontSize: 17, width: 30, height: 30, display: "flex", alignItems: "center", justifyContent: "center", borderRadius: 9, border: `1px solid ${LINE}` }}>×</div>
        </div>
        {result ? (
          <>
            <div style={{ fontSize: 13.5, color: PAPER, lineHeight: 1.6, marginBottom: 16 }}>
              {result.err ? L.err
                : (Math.abs(result.applied) < result.surplus - 40
                  ? (lang === "nl"
                    ? `+${result.surplus} kcal ingepland. We konden ~${Math.abs(result.applied)} kcal over de week verdelen — de rest laten we gaan. Eén dag uit eten hoort erbij.`
                    : `+${result.surplus} kcal planned. We could spread ~${Math.abs(result.applied)} kcal over the week — the rest we let go. One day out is fine.`)
                  : (lang === "nl"
                    ? `+${result.surplus} kcal ingepland. ${result.days} ${result.days === 1 ? "dag" : "dagen"} deze week licht getrimd; je weekgemiddelde blijft op doel.`
                    : `+${result.surplus} kcal planned. ${result.days} ${result.days === 1 ? "day" : "days"} this week lightly trimmed; your weekly average holds.`))}
            </div>
            <div style={{ display: "flex", gap: 8 }}>
              {!result.err && <button onClick={undo} style={{ background: "transparent", color: EMBER, border: `1px solid ${EMBER}`, borderRadius: 9, padding: "11px 16px", ...disp, fontWeight: 700, fontSize: 13, cursor: "pointer" }}>{L.undo}</button>}
              <button onClick={onClose} style={{ ...primaryBtn, flex: 1 }}>{L.close}</button>
            </div>
          </>
        ) : (
          <>
            <div style={{ fontSize: 12.5, color: MUTED, lineHeight: 1.6, marginBottom: 16 }}>{L.intro}</div>
            <div style={{ marginBottom: 14 }}>
              <label style={label}>{L.dateL}</label>
              <input type="date" value={date} min={today} onChange={(e) => setDate(e.target.value)} style={{ ...input, appearance: "auto", WebkitAppearance: "auto" }} />
            </div>
            <label style={label}>{L.howL}</label>
            <div style={{ display: "flex", gap: 8, marginTop: 6, marginBottom: 6 }}>
              {presets.map(([v, lbl]) => <div key={v} onClick={() => setPreset(v)} style={chip(preset === v)}>{lbl}<div style={{ fontSize: 10, fontWeight: 500, opacity: 0.8 }}>+{v}</div></div>)}
            </div>
            <div style={{ fontSize: 11, color: MUTED, lineHeight: 1.5, marginBottom: 16 }}>{L.estimate}</div>
            <button onClick={apply} style={{ ...primaryBtn, width: "100%" }}>{L.go}</button>
          </>
        )}
      </div>
    </div>
  );
}

function AddExtra({ lang, session, onClose, onPickProduct, onPickRecipe }) {
  const cloud = !!(session && supabase);
  const ml = macroLetters(lang);
  const [tab, setTab] = useState("recipe");
  const [mine, setMine] = useState(() => (cloud ? [] : load("hf_recipes", [])));
  const [q, setQ] = useState("");

  useEffect(() => {
    let active = true;
    if (cloud) {
      supabase.from("recipes").select("id,name,type,macros").eq("user_id", session.user.id).order("created_at", { ascending: false })
        .then(({ data }) => { if (active && data) setMine(data); }, () => {});
    }
    return () => { active = false; };
  }, [session]);

  const L = {
    title: lang === "nl" ? "Toevoegen aan deze dag" : "Add to this day",
    tabRec: lang === "nl" ? "Recepten" : "Recipes",
    tabProd: lang === "nl" ? "Producten" : "Products",
    search: lang === "nl" ? "Zoek in recepten…" : "Search recipes…",
    mine: lang === "nl" ? "Mijn recepten" : "My recipes",
    lib: lang === "nl" ? "Receptenbibliotheek" : "Recipe library",
    none: lang === "nl" ? "Geen recept gevonden." : "No recipe found.",
    pick: lang === "nl" ? "Kies" : "Pick",
  };

  const rname = (r) => (typeof r.name === "string" ? r.name : (r.name[lang] || r.name.en));
  const needle = q.trim().toLowerCase();
  const match = (r) => !needle || rname(r).toLowerCase().includes(needle);
  const mineF = mine.filter(match);
  const libF = RECIPES.filter(match);

  const row = (r, key) => {
    const m = r.macros || {};
    return (
      <div key={key} style={{ display: "flex", alignItems: "center", gap: 10, padding: "10px 0", borderBottom: `1px solid ${LINE}` }}>
        <div style={{ flex: 1, minWidth: 0 }}>
          <div style={{ fontSize: 13.5, fontWeight: 600, color: PAPER }}>{rname(r)}</div>
          <div style={{ fontSize: 11, color: MUTED, marginTop: 1 }}>{Math.round(num(m.kcal))} kcal · {Math.round(num(m.p))}{ml.p}/{Math.round(num(m.c))}{ml.c}/{Math.round(num(m.f))}{ml.f}</div>
        </div>
        <div onClick={() => onPickRecipe(r)} style={{ cursor: "pointer", fontSize: 12, fontWeight: 700, color: EMBER, border: `1px solid ${EMBER}`, borderRadius: 7, padding: "5px 11px", ...disp, letterSpacing: 0.3 }}>{L.pick}</div>
      </div>
    );
  };

  const recipeTab = (
    <>
      <input value={q} onChange={(e) => setQ(e.target.value)} placeholder={L.search} style={{ ...input, marginBottom: 14 }} />
      {mineF.length > 0 && (
        <div style={{ marginBottom: 14 }}>
          <div style={{ ...disp, fontSize: 11.5, fontWeight: 700, letterSpacing: 1, textTransform: "uppercase", color: EMBER, marginBottom: 6 }}>{L.mine}</div>
          {mineF.map((r, i) => row(r, "m" + (r.id || i)))}
        </div>
      )}
      <div>
        <div style={{ ...disp, fontSize: 11.5, fontWeight: 700, letterSpacing: 1, textTransform: "uppercase", color: MUTED, marginBottom: 6 }}>{L.lib}</div>
        {libF.length ? libF.map((r, i) => row(r, "l" + (r.id || i))) : <div style={{ fontSize: 12.5, color: MUTED }}>{L.none}</div>}
      </div>
    </>
  );

  return (
    <div onClick={onClose} style={{ position: "fixed", inset: 0, background: "rgba(0,0,0,0.72)", backdropFilter: "blur(6px)", WebkitBackdropFilter: "blur(6px)", zIndex: 65, display: "flex", alignItems: "center", justifyContent: "center", padding: 16 }}>
      <div onClick={(e) => e.stopPropagation()} style={{ position: "relative", background: INK, border: `1px solid ${LINE}`, borderRadius: 20, width: "100%", maxWidth: 440, maxHeight: "90vh", overflowY: "auto", padding: 22, boxShadow: "0 24px 70px rgba(0,0,0,.65)", backgroundImage: "radial-gradient(130% 70% at 92% -10%, rgba(225,29,72,0.13), transparent 58%)" }}>
        <div style={{ display: "flex", justifyContent: "space-between", alignItems: "center", marginBottom: 14 }}>
          <div style={sectionTitle}>{L.title}</div>
          <div onClick={onClose} style={{ cursor: "pointer", color: MUTED, fontSize: 17, width: 30, height: 30, display: "flex", alignItems: "center", justifyContent: "center", borderRadius: 9, border: `1px solid ${LINE}` }}>×</div>
        </div>
        <div style={{ display: "flex", gap: 6, background: INK2, border: `1px solid ${LINE}`, borderRadius: 10, padding: 4, marginBottom: 16 }}>
          {[["recipe", L.tabRec], ["product", L.tabProd]].map(([k, lbl]) => (
            <div key={k} onClick={() => setTab(k)} style={{ flex: 1, textAlign: "center", cursor: "pointer", ...disp, fontWeight: 700, fontSize: 13, letterSpacing: 0.3, padding: "9px 0", borderRadius: 7, background: tab === k ? EMBER : "transparent", color: tab === k ? PAPER : MUTED }}>{lbl}</div>
          ))}
        </div>
        {tab === "recipe" ? recipeTab : <Products lang={lang} session={session} embedded onPick={onPickProduct} />}
      </div>
    </div>
  );
}
