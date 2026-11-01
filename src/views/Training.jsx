import React, { useState, useEffect, useRef } from "react";
import { INK, INK2, EMBER, EMBER_SOFT, PAPER, MUTED, LINE, SAGE, TRACK, SHADOW, disp, num, load, save, todayISO, fmtDate, label, sectionTitle, WD, jsDayToIdx } from "../shared.js";

// SVG-iconen per medaille-categorie (ipv emoji). col = stroke-kleur.
function medalIcon(key, col) {
  const p = { strokeWidth: 1.9, strokeLinecap: "round", strokeLinejoin: "round", fill: "none", stroke: col };
  const paths = {
    dist: <path d="M13 2L3 14h7l-1 8 10-12h-7z" {...p} />,
    sessions: <g {...p}><path d="M6.5 6.5l11 11M4 9l-1.5 1.5a1.5 1.5 0 000 2L4 14M20 9l1.5 1.5a1.5 1.5 0 010 2L20 14M7 4l1.5 1.5M17 20l-1.5-1.5" /></g>,
    kcal: <path d="M12 3c1 3-1 4-1 6a2 2 0 004 0c0-1-.5-2-.5-2 2 1 3.5 3 3.5 6a6 6 0 01-12 0c0-4 4-6 6-10z" {...p} />,
    streak: <g {...p}><rect x="3" y="4.5" width="18" height="16.5" rx="2" /><path d="M3 9.5h18M8 2.5v4M16 2.5v4" /></g>,
  };
  return <svg width="22" height="22" viewBox="0 0 24 24">{paths[key] || paths.dist}</svg>;
}
import BrandCalendar from "./BrandCalendar.jsx";
import { EXERCISES, WORKOUT_CATS, INTENSITY, kcalFor, exerciseByName } from "../workouts.js";
import { Dropdown } from "../ui.jsx";
import { MEDALS, TIER_NAMES, TIER_COLORS, aggregate, medalState } from "../achievements.js";

const T = {
  title: { nl: "Training", en: "Training" },
  sub: { nl: "Log je sessies en plan je trainingsweek.", en: "Log your sessions and plan your training week." },
  tabToday: { nl: "Vandaag", en: "Today" },
  tabWeek: { nl: "Weekschema", en: "Week plan" },
  todayBurn: { nl: "Verbrand vandaag (schatting)", en: "Burned today (estimate)" },
  totalTime: { nl: "Totale tijd", en: "Total time" },
  sessions: { nl: "sessies", en: "sessions" },
  add: { nl: "+ Sessie toevoegen", en: "+ Add session" },
  pickExercise: { nl: "Kies een oefening", en: "Pick an exercise" },
  searchPh: { nl: "Zoek een oefening…", en: "Search an exercise…" },
  own: { nl: "+ Eigen oefening", en: "+ Custom exercise" },
  ownName: { nl: "Naam van de oefening", en: "Exercise name" },
  pickCat: { nl: "Categorie", en: "Category" },
  intensity: { nl: "Intensiteit", en: "Intensity" },
  addCustom: { nl: "Oefening toevoegen", en: "Add exercise" },
  change: { nl: "Wissel", en: "Change" },
  back: { nl: "‹ Terug", en: "‹ Back" },
  minutes: { nl: "Minuten", en: "Minutes" },
  timer: { nl: "Timer", en: "Timer" },
  start: { nl: "Start", en: "Start" },
  stop: { nl: "Stop", en: "Stop" },
  estBurn: { nl: "Geschatte verbranding", en: "Estimated burn" },
  save: { nl: "Toevoegen", en: "Add" },
  cancel: { nl: "Annuleren", en: "Cancel" },
  today: { nl: "Vandaag getraind", en: "Trained today" },
  planned: { nl: "Gepland vandaag", en: "Planned today" },
  logIt: { nl: "✓ Log", en: "✓ Log" },
  markAll: { nl: "Hele training afvinken", en: "Mark whole training done" },
  trainDone: { nl: "Training voltooid ✓", en: "Training complete ✓" },
  undoAll: { nl: "Ongedaan maken", en: "Undo" },
  empty: { nl: "Nog geen training vandaag. Voeg je eerste sessie toe.", en: "No training yet today. Add your first session." },
  min: { nl: "min", en: "min" },
  disclaimer: { nl: "Verbranding is een schatting (op basis van intensiteit, gewicht en tijd) en wordt niet van je voedingsdoelen afgetrokken.", en: "Burn is an estimate (based on intensity, bodyweight and time) and is not subtracted from your nutrition targets." },
  weekHint: { nl: "Plan per dag je sessies. Je kunt de hele week of een dag naar een andere datum verplaatsen of kopiëren.", en: "Plan your sessions per day. Move or copy the whole week or a single day to another date." },
  move: { nl: "Verplaats / kopieer", en: "Move / copy" },
  addPlan: { nl: "+ Sessie", en: "+ Session" },
  rest: { nl: "Rustdag", en: "Rest day" },
  moveTitle: { nl: "Verplaats of kopieer", en: "Move or copy" },
  moveWeekScope: { nl: "Hele week", en: "Whole week" },
  actCopy: { nl: "Kopiëren", en: "Copy" },
  actMove: { nl: "Verplaatsen", en: "Move" },
  tgtNextWeek: { nl: "Volgende week", en: "Next week" },
  tgtPickWeek: { nl: "Kies een week (datum)", en: "Pick a week (date)" },
  tgtPickDate: { nl: "Specifieke datum", en: "Specific date" },
  moveDo: { nl: "Zet op kalender", en: "Place on calendar" },
  movePlaced: { nl: "Gezet ✓", en: "Placed ✓" },
  moveHint: { nl: "Je trainingsschema verschijnt op die datum(s). Verplaatsen wist de bronweek.", en: "Your training plan appears on those date(s). Move clears the source week." },
  toDate: { nl: "tot datum", en: "to date" },
  sets: { nl: "Sets", en: "Sets" },
  reps: { nl: "Herhalingen", en: "Reps" },
  dist: { nl: "Afstand (m)", en: "Distance (m)" },
  optional: { nl: "optioneel", en: "optional" },
  howTitle: { nl: "Zo werkt het", en: "How it works" },
  demoSoon: { nl: "Videodemo volgt", en: "Video demo coming" },
  tabPrest: { nl: "Prestaties", en: "Achievements" },
  startSession: { nl: "▶ Start training", en: "▶ Start session" },
  sessionOf: { nl: "voltooid", en: "done" },
  nextExercise: { nl: "Oefening afvinken · volgende ›", en: "Mark done · next ›" },
  finishSession: { nl: "Hele training afronden", en: "Finish whole session" },
  nowBusy: { nl: "nu bezig", en: "in progress" },
  sessionDone: { nl: "Training voltooid", en: "Session complete" },
  sessionDoneSub: { nl: "Sterk gedaan. Dit telt mee in je weekreview en prestaties.", en: "Well done. This counts toward your week review and achievements." },
  exercisesN: { nl: "Oefeningen", en: "Exercises" },
  minutesN: { nl: "Minuten", en: "Minutes" },
  backToday: { nl: "Terug naar vandaag", en: "Back to today" },
  prestIntro: { nl: "Alles wat je tot nu toe hebt neergezet. Blijf trainen, verdien je medailles.", en: "Everything you've put down so far. Keep training, earn your medals." },
  totalLbl: { nl: "Totaal", en: "Total" },
  medalsLbl: { nl: "Medailles", en: "Medals" },
  distRun: { nl: "Afstand", en: "Distance" },
  burnedLbl: { nl: "Verbrand", en: "Burned" },
  doneLbl: { nl: "Voltooid", en: "Completed" },
  timeLbl: { nl: "Trainingstijd", en: "Training time" },
  locked: { nl: "Op slot", en: "Locked" },
  maxed: { nl: "Max niveau ✓", en: "Max level ✓" },
  toNext: { nl: "tot", en: "to" },
  noSessions: { nl: "Nog geen voltooide trainingen. Rond je eerste sessie af en je ziet hier je score groeien.", en: "No completed sessions yet. Finish your first session and watch your score grow here." },
};

const isoAdd = (iso, n) => { const dt = new Date(iso + "T12:00:00"); dt.setDate(dt.getDate() + n); return dt.toISOString().slice(0, 10); };
// Korte set-/afstand-omschrijving van een geplande oefening (bv. "4 × 12" of "1000 m").
function setLabel(x) {
  if (!x) return "";
  if (x.sets && x.reps) return x.sets + " × " + x.reps;
  if (x.reps) return x.reps + " reps";
  if (x.dist) return (x.dist >= 1000 ? (x.dist / 1000) + " km" : x.dist + " m");
  return "";
}
const mondayISO = (iso) => { const dt = new Date(iso + "T12:00:00"); const wd = (dt.getDay() + 6) % 7; dt.setDate(dt.getDate() - wd); return dt.toISOString().slice(0, 10); };
const metWord = (lang, met) => { const i = [...INTENSITY].reverse().find((x) => met >= x.met) || INTENSITY[0]; return i[lang]; };

function bodyKg(weightProp) {
  const mw = num(load("hf_water_weight", ""));
  if (mw > 0) return mw;
  const ws = load("hf_weights", []);
  if (ws.length) { const s = [...ws].sort((a, b) => a.date.localeCompare(b.date)); const k = Number(s[s.length - 1].kg); if (k > 0) return k; }
  const w = num(weightProp);
  return w > 0 ? w : 80;
}
const emptyPlan = () => ({ days: Array.from({ length: 7 }, () => ({ items: [] })) });
function loadPlan() { const p = load("hf_trainplan", null); if (!p || !Array.isArray(p.days) || p.days.length !== 7) return emptyPlan(); return p; }

export default function Training({ lang, session, weight }) {
  const t = (k) => (T[k] ? T[k][lang] : k);
  const [d, setD] = useState(todayISO());
  const [calOpen, setCalOpen] = useState(false);
  const shiftDay = (n) => { const dt = new Date(d + "T12:00:00"); dt.setDate(dt.getDate() + n); setD(dt.getFullYear() + "-" + String(dt.getMonth() + 1).padStart(2, "0") + "-" + String(dt.getDate()).padStart(2, "0")); };
  const isToday = d === todayISO();
  const kg = bodyKg(weight);
  const [tab, setTab] = useState("today");
  const [list, setList] = useState(() => load("hf_workouts_" + d, []));
  const [checked, setChecked] = useState(() => load("hf_trainchecked_" + d, []));
  const [plan, setPlan] = useState(loadPlan);
  const [planAdd, setPlanAdd] = useState(null);
  const [move, setMove] = useState(null);
  const [runner, setRunner] = useState(false);   // sessie-runner open
  const [howEx, setHowEx] = useState(null);       // "zo werkt het"-popover (exercise-obj)
  const [summary, setSummary] = useState(null);    // voltooi-samenvatting {name,exercises,min,kcal,km}
  const [sessions, setSessions] = useState(() => load("hf_sessions", []));

  // Vandaag loggen
  const [adding, setAdding] = useState(false);
  const [chosen, setChosen] = useState(null); // {name, met}
  const [mins, setMins] = useState("");
  const [kcalEdit, setKcalEdit] = useState(null);
  const [run, setRun] = useState(() => load("hf_workout_running", null));
  const [, tickState] = useState(0);
  const iv = useRef(null);

  useEffect(() => { setList(load("hf_workouts_" + d, [])); setChecked(load("hf_trainchecked_" + d, [])); setPlan(loadPlan()); }, [d]);
  useEffect(() => {
    if (run) { iv.current = setInterval(() => tickState((x) => x + 1), 1000); if (!adding) setAdding(true); }
    return () => { if (iv.current) clearInterval(iv.current); };
  }, [run]);

  const todayIdx = jsDayToIdx(new Date(d + "T12:00:00").getDay());
  const plannedToday = (load("hf_trainover_" + d, null) || plan.days[todayIdx] || { items: [] }).items || [];

  const effMin = run ? Math.max(0, (Date.now() - run.start) / 60000) : num(mins);
  const autoKcal = chosen ? kcalFor(chosen.met, kg, effMin) : 0;
  const showKcal = kcalEdit != null ? kcalEdit : autoKcal;

  function startTimer() { const r = { start: Date.now() }; setRun(r); save("hf_workout_running", r); }
  function stopTimer() { if (!run) return; const m = Math.max(1, Math.round((Date.now() - run.start) / 60000)); setMins(String(m)); setRun(null); try { localStorage.removeItem("hf_workout_running"); } catch (e) {} if (iv.current) clearInterval(iv.current); }
  function resetPanel() { setChosen(null); setMins(""); setKcalEdit(null); }
  function persistLog(next) { setList(next); save("hf_workouts_" + d, next); }
  function addSession() {
    const m = run ? Math.max(1, Math.round((Date.now() - run.start) / 60000)) : num(mins);
    if (!chosen || m <= 0) return;
    const kcal = kcalEdit != null ? num(kcalEdit) : kcalFor(chosen.met, kg, m);
    persistLog([...list, { id: "w" + Date.now(), name: chosen.name, met: chosen.met, min: m, kcal, ts: Date.now() }]);
    if (run) { setRun(null); try { localStorage.removeItem("hf_workout_running"); } catch (e) {} if (iv.current) clearInterval(iv.current); }
    resetPanel(); setAdding(false);
  }
  function delLog(id) { persistLog(list.filter((x) => x.id !== id)); }
  function logPlanned(it) { persistLog([...list, { id: "w" + Date.now(), name: it.name, met: it.met, min: it.min, kcal: it.kcal, ts: Date.now() }]); }

  // --- Afvinken van geplande sessies (los of de hele training in één tik) ---
  const planKey = (i) => d + ":" + i;
  function setCheckedSave(next) { setChecked(next); save("hf_trainchecked_" + d, next); }
  function togglePlanned(i, it) {
    if (checked.includes(i)) {
      persistLog(list.filter((x) => x.planKey !== planKey(i)));
      setCheckedSave(checked.filter((c) => c !== i));
    } else {
      persistLog([...list, { id: "w" + Date.now() + "_" + i, name: it.name, met: it.met, min: it.min, kcal: it.kcal, ts: Date.now(), planKey: planKey(i) }]);
      setCheckedSave([...checked, i]);
    }
  }
  function markAllPlanned(items) {
    const adds = items.map((it, i) => ({ it, i })).filter(({ i }) => !checked.includes(i))
      .map(({ it, i }) => ({ id: "w" + Date.now() + "_" + i, name: it.name, met: it.met, min: it.min, kcal: it.kcal, ts: Date.now(), planKey: planKey(i) }));
    if (adds.length) persistLog([...list, ...adds]);
    setCheckedSave(items.map((_, i) => i));
  }
  function undoAllPlanned(items) {
    const keys = items.map((_, i) => planKey(i));
    persistLog(list.filter((x) => !keys.includes(x.planKey)));
    setCheckedSave([]);
  }

  // --- Sessie afronden: schrijf één record met totalen (voedt prestaties + weekreview) ---
  function sessionTotals(items) {
    const km = Math.round(items.reduce((a, x) => a + (num(x.dist) || 0), 0) / 100) / 10; // m -> km, 0,1
    const kcal = Math.round(items.reduce((a, x) => a + num(x.kcal), 0));
    const min = items.reduce((a, x) => a + num(x.min), 0);
    return { exercises: items.length, min, kcal, km };
  }
  function finishSession(items) {
    const tot = sessionTotals(items);
    const rec = { id: "s" + Date.now(), date: d, name: null, ...tot, ts: Date.now() };
    const next = [...sessions.filter((s) => s.date !== d || s.id !== rec.id), rec];
    // één sessie per keer-afronden; dubbele afronding op dezelfde dag vervangt de laatste
    const cleaned = next.filter((s) => !(s.date === d && s.id !== rec.id && s._auto));
    setSessions(cleaned); save("hf_sessions", cleaned);
    markAllPlanned(items);
    setRunner(false);
    setSummary({ ...tot, name: null });
  }
  function undoLastSession() {
    const today = [...sessions].filter((s) => s.date === d).sort((a, b) => b.ts - a.ts)[0];
    if (today) { const next = sessions.filter((s) => s.id !== today.id); setSessions(next); save("hf_sessions", next); }
    undoAllPlanned(plannedToday);
    setSummary(null);
  }

  // Oefening-object (met 'how'/'demo') bij een gepland item opzoeken.
  const exOf = (x) => (x && x.exId ? EXERCISES.find((e) => e.id === x.exId) : null) || exerciseByName(x && x.name);

  function persistPlan(next) { setPlan(next); save("hf_trainplan", next); }
  function addToDay(di, row) { const days = plan.days.map((dd, i) => i === di ? { items: [...dd.items, row] } : dd); persistPlan({ days }); }
  function delFromDay(di, id) { const days = plan.days.map((dd, i) => i === di ? { items: dd.items.filter((x) => x.id !== id) } : dd); persistPlan({ days }); }
  function stampWeek(startMon, isMove) {
    plan.days.forEach((dd, i) => { try { save("hf_trainover_" + isoAdd(startMon, i), { items: dd.items.map((x) => ({ ...x })) }); } catch (e) {} });
    if (isMove) { const srcMon = mondayISO(d); for (let i = 0; i < 7; i++) { const s = isoAdd(srcMon, i); if (mondayISO(s) !== startMon) { try { localStorage.removeItem("hf_trainover_" + s); } catch (e) {} } } }
  }
  function stampDay(di, iso) { try { save("hf_trainover_" + iso, { items: plan.days[di].items.map((x) => ({ ...x })) }); } catch (e) {} }

  const totKcal = list.reduce((a, x) => a + num(x.kcal), 0);
  const totMin = list.reduce((a, x) => a + num(x.min), 0);
  const mmss = (ms) => { const s = Math.floor(ms / 1000); return String(Math.floor(s / 60)).padStart(2, "0") + ":" + String(s % 60).padStart(2, "0"); };
  const sIn = { width: "100%", background: INK, border: `1px solid ${LINE}`, color: PAPER, padding: "11px 12px", fontFamily: "Inter, sans-serif", fontSize: 14, borderRadius: 8, outline: "none", boxSizing: "border-box" };
  const tabBtn = (id, lbl) => <div onClick={() => setTab(id)} style={{ flex: 1, textAlign: "center", cursor: "pointer", padding: "9px 0", borderRadius: 8, background: tab === id ? EMBER : "transparent", color: tab === id ? "#fff" : PAPER, fontSize: 13.5, fontWeight: 700, ...disp, letterSpacing: 0.5 }}>{lbl}</div>;
  const catOpts = Object.keys(WORKOUT_CATS).map((c) => ({ id: c, label: WORKOUT_CATS[c][lang] }));
  const intOpts = INTENSITY.map((i) => ({ id: i.met, label: i[lang] }));

  // --- Uitklap-menu (accordion) voor oefeningen: zoekbalk + categorieën + eigen oefening (met categorie) ---
  function ExAccordion({ onPick }) {
    const [q, setQ] = useState("");
    const [open, setOpen] = useState("hyrox");
    const [cust, setCust] = useState(false);
    const [nm, setNm] = useState("");
    const [cat, setCat] = useState("hyrox");
    const [intens, setIntens] = useState(7);
    const ql = q.trim().toLowerCase();
    const cats = Object.keys(WORKOUT_CATS);
    const match = (e) => e[lang].toLowerCase().includes(ql);
    const catRow = (c) => {
      const items = EXERCISES.filter((e) => e.cat === c && (!ql || match(e)));
      if (ql && items.length === 0) return null;
      const isOpen = ql ? true : open === c;
      return (
        <div key={c} style={{ borderBottom: `1px solid ${LINE}` }}>
          <div onClick={() => !ql && setOpen(isOpen ? "" : c)} style={{ display: "flex", justifyContent: "space-between", alignItems: "center", padding: "12px 14px", cursor: "pointer" }}>
            <span style={{ ...disp, fontWeight: 700, fontSize: 12, letterSpacing: 1, textTransform: "uppercase", color: isOpen ? EMBER : PAPER, opacity: isOpen ? 1 : 0.85 }}>{WORKOUT_CATS[c][lang]}</span>
            <span style={{ display: "flex", alignItems: "center", gap: 10 }}><span style={{ fontSize: 11, color: MUTED }}>{items.length}</span><span style={{ fontSize: 11, color: isOpen ? EMBER : MUTED, transform: isOpen ? "rotate(90deg)" : "none", transition: "transform .15s" }}>›</span></span>
          </div>
          {isOpen && items.map((e) => (
            <div key={e.id} onClick={() => onPick({ name: e[lang], met: e.met, metric: e.metric, exId: e.id })} style={{ display: "flex", justifyContent: "space-between", alignItems: "center", padding: "10px 14px 10px 24px", cursor: "pointer", borderTop: `1px solid ${LINE}` }}>
              <span style={{ fontSize: 14, color: PAPER }}>{e[lang]}</span>
              <span style={{ fontSize: 10, color: MUTED, border: `1px solid ${LINE}`, borderRadius: 5, padding: "2px 7px" }}>{metWord(lang, e.met)}</span>
            </div>
          ))}
        </div>
      );
    };
    if (cust) {
      return (
        <div>
          <label style={label}>{t("ownName")}</label>
          <input value={nm} onChange={(e) => setNm(e.target.value)} placeholder={t("ownName")} style={{ ...sIn, marginBottom: 12 }} />
          <label style={label}>{t("pickCat")}</label>
          <div style={{ marginBottom: 12 }}><Dropdown value={cat} onChange={setCat} options={catOpts} /></div>
          <label style={label}>{t("intensity")}</label>
          <div style={{ marginBottom: 14 }}><Dropdown value={intens} onChange={setIntens} options={intOpts} /></div>
          <div style={{ display: "flex", gap: 10 }}>
            <div onClick={() => setCust(false)} style={{ cursor: "pointer", padding: "11px 16px", borderRadius: 9, border: `1px solid ${LINE}`, color: MUTED, fontSize: 13, fontWeight: 700, ...disp }}>{t("back")}</div>
            <div onClick={() => { if (!nm.trim()) return; onPick({ name: nm.trim(), met: num(intens), cat, metric: "reps" }); }} style={{ cursor: "pointer", flex: 1, textAlign: "center", background: EMBER, color: "#fff", padding: "11px 0", borderRadius: 9, ...disp, fontWeight: 700, fontSize: 14 }}>{t("addCustom")}</div>
          </div>
        </div>
      );
    }
    return (
      <div>
        <div style={{ marginBottom: 10 }}>
          <input value={q} onChange={(e) => setQ(e.target.value)} placeholder={t("searchPh")} style={sIn} />
        </div>
        <div style={{ border: `1px solid ${LINE}`, borderRadius: 12, overflow: "hidden" }}>
          {cats.map((c) => catRow(c))}
          <div onClick={() => setCust(true)} style={{ padding: "12px 14px", color: EMBER, fontSize: 13, fontWeight: 700, ...disp, cursor: "pointer" }}>{t("own")}</div>
        </div>
      </div>
    );
  }

  function MoveModal({ scope, di, onClose }) {
    const [act, setAct] = useState("copy");
    const [tgt, setTgt] = useState(scope === "week" ? "next" : "date");
    const [date, setDate] = useState(scope === "week" ? isoAdd(mondayISO(d), 7) : isoAdd(d, 1));
    const [done, setDone] = useState(false);
    const dIn = { ...sIn, colorScheme: "dark" };
    const seg = (on) => ({ flex: 1, textAlign: "center", cursor: "pointer", padding: "9px 0", borderRadius: 8, border: `1px solid ${on ? EMBER : LINE}`, background: on ? "rgba(225,29,72,0.12)" : "transparent", color: on ? PAPER : MUTED, fontSize: 12.5, fontWeight: 700, ...disp });
    const radio = (on) => ({ display: "flex", alignItems: "center", gap: 9, cursor: "pointer", padding: "10px 12px", borderRadius: 10, border: `1px solid ${on ? EMBER : LINE}`, background: on ? "rgba(225,29,72,0.08)" : INK2 });
    const dot = (on) => ({ width: 16, height: 16, borderRadius: "50%", border: `2px solid ${on ? EMBER : MUTED}`, background: on ? EMBER : "transparent", flexShrink: 0 });
    const place = () => { if (scope === "week") { stampWeek(tgt === "next" ? isoAdd(mondayISO(d), 7) : mondayISO(date), act === "move"); } else { stampDay(di, date); } setDone(true); setTimeout(onClose, 900); };
    return (
      <div onClick={onClose} style={{ position: "fixed", inset: 0, background: "rgba(0,0,0,0.72)", backdropFilter: "blur(6px)", WebkitBackdropFilter: "blur(6px)", zIndex: 74, display: "flex", alignItems: "center", justifyContent: "center", padding: 16 }}>
        <div onClick={(e) => e.stopPropagation()} style={{ background: INK, border: `1px solid ${LINE}`, borderRadius: 18, width: "100%", maxWidth: 400, padding: 20 }}>
          <div style={{ display: "flex", justifyContent: "space-between", alignItems: "center", marginBottom: 12 }}>
            <div style={{ ...disp, fontWeight: 700, fontSize: 16 }}>{t("moveTitle")}</div>
            <div onClick={onClose} style={{ cursor: "pointer", color: MUTED, fontSize: 17, width: 30, height: 30, display: "flex", alignItems: "center", justifyContent: "center", borderRadius: 9, border: `1px solid ${LINE}` }}>×</div>
          </div>
          <div style={{ fontSize: 11.5, color: MUTED, marginBottom: 14 }}>{scope === "week" ? t("moveWeekScope") : WD[lang === "nl" ? "nl" : "en"][di]}</div>
          <div style={{ display: "flex", gap: 8, marginBottom: 14 }}>
            <div onClick={() => setAct("copy")} style={seg(act === "copy")}>{t("actCopy")}</div>
            <div onClick={() => setAct("move")} style={seg(act === "move")}>{t("actMove")}</div>
          </div>
          {scope === "week" ? (
            <div style={{ display: "grid", gap: 8, marginBottom: 14 }}>
              <div onClick={() => setTgt("next")} style={radio(tgt === "next")}><div style={dot(tgt === "next")} /><div style={{ fontSize: 13.5, color: PAPER, fontWeight: 600 }}>{t("tgtNextWeek")}</div></div>
              <div onClick={() => setTgt("pick")} style={radio(tgt === "pick")}><div style={dot(tgt === "pick")} /><div style={{ fontSize: 13.5, color: PAPER, fontWeight: 600 }}>{t("tgtPickWeek")}</div></div>
              {tgt === "pick" && <input type="date" value={date} onChange={(e) => setDate(e.target.value)} style={dIn} />}
            </div>
          ) : (
            <div style={{ marginBottom: 14 }}>
              <label style={label}>{t("tgtPickDate")}</label>
              <input type="date" value={date} onChange={(e) => setDate(e.target.value)} style={dIn} />
            </div>
          )}
          <div onClick={done ? undefined : place} style={{ cursor: done ? "default" : "pointer", textAlign: "center", background: done ? SAGE : EMBER, color: PAPER, padding: "12px 0", borderRadius: 10, ...disp, fontWeight: 700, fontSize: 15 }}>{done ? t("movePlaced") : t("moveDo")}</div>
          <div style={{ fontSize: 11, color: MUTED, marginTop: 10, lineHeight: 1.5 }}>{t("moveHint")}</div>
        </div>
      </div>
    );
  }

  // Modal voor een geplande sessie in het weekschema: oefening kiezen + minuten
  function PlanAddModal({ di, onClose }) {
    const [ch, setCh] = useState(null);
    const [mn, setMn] = useState("");
    const [sets, setSets] = useState("");
    const [reps, setReps] = useState("");
    const [dist, setDist] = useState("");
    const kc = ch ? kcalFor(ch.met, kg, num(mn)) : 0;
    const metric = ch ? (ch.metric || "time") : "time";
    return (
      <div onClick={onClose} style={{ position: "fixed", inset: 0, background: "rgba(0,0,0,0.72)", backdropFilter: "blur(6px)", WebkitBackdropFilter: "blur(6px)", zIndex: 74, display: "flex", alignItems: "center", justifyContent: "center", padding: 16 }}>
        <div onClick={(e) => e.stopPropagation()} className="hf-modal" style={{ background: INK, border: `1px solid ${LINE}`, borderRadius: 18, width: "100%", maxWidth: 400, maxHeight: "88vh", overflowY: "auto", padding: 20 }}>
          <div style={{ display: "flex", justifyContent: "space-between", alignItems: "center", marginBottom: 14 }}>
            <div style={{ ...disp, fontWeight: 700, fontSize: 16 }}>{ch ? ch.name : t("pickExercise")} · {WD[lang === "nl" ? "nl" : "en"][di]}</div>
            <div onClick={onClose} style={{ cursor: "pointer", color: MUTED, fontSize: 17, width: 30, height: 30, display: "flex", alignItems: "center", justifyContent: "center", borderRadius: 9, border: `1px solid ${LINE}` }}>×</div>
          </div>
          {!ch ? <ExAccordion onPick={setCh} /> : (
            <div>
              <div onClick={() => setCh(null)} style={{ cursor: "pointer", fontSize: 11.5, color: MUTED, fontWeight: 600, marginBottom: 12 }}>‹ {t("change")}</div>
              {metric === "reps" && (
                <div style={{ display: "flex", gap: 10, marginBottom: 10 }}>
                  <div style={{ flex: 1 }}><label style={label}>{t("sets")} <span style={{ color: MUTED, fontWeight: 400, textTransform: "none", letterSpacing: 0 }}>· {t("optional")}</span></label><input value={sets} onChange={(e) => setSets(e.target.value.replace(/[^0-9]/g, ""))} inputMode="numeric" placeholder="4" style={sIn} /></div>
                  <div style={{ flex: 1 }}><label style={label}>{t("reps")}</label><input value={reps} onChange={(e) => setReps(e.target.value.replace(/[^0-9]/g, ""))} inputMode="numeric" placeholder="12" style={sIn} /></div>
                </div>
              )}
              {metric === "dist" && (
                <div style={{ marginBottom: 10 }}><label style={label}>{t("dist")} <span style={{ color: MUTED, fontWeight: 400, textTransform: "none", letterSpacing: 0 }}>· {t("optional")}</span></label><input value={dist} onChange={(e) => setDist(e.target.value.replace(/[^0-9]/g, ""))} inputMode="numeric" placeholder="1000" style={sIn} /></div>
              )}
              <label style={label}>{t("minutes")}</label>
              <input value={mn} onChange={(e) => setMn(e.target.value.replace(/[^0-9]/g, ""))} inputMode="numeric" placeholder="20" style={{ ...sIn, marginBottom: 10 }} />
              <div style={{ fontSize: 12, color: MUTED, marginBottom: 14 }}>{t("estBurn")}: <span style={{ color: EMBER_SOFT, fontWeight: 700 }}>~{kc} kcal</span></div>
              <div style={{ display: "flex", gap: 10 }}>
                <div onClick={onClose} style={{ cursor: "pointer", padding: "11px 16px", borderRadius: 9, border: `1px solid ${LINE}`, color: MUTED, fontSize: 13, fontWeight: 700, ...disp }}>{t("cancel")}</div>
                <div onClick={() => { if (num(mn) <= 0) return; addToDay(di, { id: "p" + Date.now(), name: ch.name, met: ch.met, min: num(mn), kcal: kc, metric, exId: ch.exId || null, sets: num(sets) || null, reps: num(reps) || null, dist: num(dist) || null }); onClose(); }} style={{ cursor: "pointer", flex: 1, textAlign: "center", background: EMBER, color: "#fff", padding: "11px 0", borderRadius: 9, ...disp, fontWeight: 700, fontSize: 14 }}>{t("save")}</div>
              </div>
            </div>
          )}
        </div>
      </div>
    );
  }

  return (
    <div style={{ maxWidth: 560, margin: "0 auto", padding: "4px 0 10px" }}>
      <div style={{ ...sectionTitle, marginBottom: 4 }}>{t("title")}</div>
      <div style={{ fontSize: 12.5, color: MUTED, marginBottom: 14, lineHeight: 1.5 }}>{t("sub")}</div>

      <div style={{ display: "flex", gap: 4, background: INK2, border: `1px solid ${LINE}`, borderRadius: 10, padding: 4, marginBottom: 16 }}>
        {tabBtn("today", t("tabToday"))}
        {tabBtn("week", t("tabWeek"))}
        {tabBtn("prestaties", t("tabPrest"))}
      </div>

      {tab === "today" && (
        <>
          <div style={{ background: INK2, border: `1px solid ${LINE}`, borderRadius: 14, padding: 10, marginBottom: 14 }}>
            <div style={{ display: "flex", alignItems: "center", justifyContent: "space-between", gap: 8 }}>
              <div onClick={() => shiftDay(-1)} className="hf-tap" style={{ cursor: "pointer", width: 34, height: 34, borderRadius: 9, border: `1px solid ${LINE}`, display: "flex", alignItems: "center", justifyContent: "center", color: PAPER, fontSize: 18 }}>‹</div>
              <div onClick={() => setCalOpen(true)} style={{ textAlign: "center", cursor: "pointer", display: "flex", alignItems: "center", gap: 6 }}>
                <div style={{ ...disp, fontSize: 15, fontWeight: 600, letterSpacing: 0.5 }}>{isToday ? t("tabToday") : WD[lang === "nl" ? "nl" : "en"][todayIdx]} · {fmtDate(d, lang)}</div>
                <svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke={EMBER} strokeWidth="2.4" strokeLinecap="round" strokeLinejoin="round"><path d="M6 9l6 6 6-6" /></svg>
              </div>
              <div onClick={() => shiftDay(1)} className="hf-tap" style={{ cursor: "pointer", width: 34, height: 34, borderRadius: 9, border: `1px solid ${LINE}`, display: "flex", alignItems: "center", justifyContent: "center", color: PAPER, fontSize: 18 }}>›</div>
            </div>
          </div>
          {calOpen && <BrandCalendar value={d} lang={lang} onPick={(v) => { if (v) setD(v); }} onClose={() => setCalOpen(false)} />}

          <div style={{ background: `linear-gradient(135deg, ${EMBER}, #9f1239)`, borderRadius: 16, padding: "18px", marginBottom: 14, color: "#fff" }}>
            <div style={{ display: "flex", justifyContent: "space-between", alignItems: "flex-start" }}>
              <div>
                <div style={{ fontSize: 10.5, letterSpacing: 1, textTransform: "uppercase", fontWeight: 700, opacity: 0.85 }}>{t("todayBurn")}</div>
                <div style={{ ...disp, fontSize: 40, fontWeight: 700, lineHeight: 1, marginTop: 4 }}>~{totKcal}<span style={{ fontSize: 15, opacity: 0.8, marginLeft: 6 }}>kcal</span></div>
              </div>
              <div style={{ textAlign: "right" }}>
                <div style={{ fontSize: 10.5, letterSpacing: 1, textTransform: "uppercase", fontWeight: 700, opacity: 0.85 }}>{t("totalTime")}</div>
                <div style={{ ...disp, fontSize: 24, fontWeight: 700, marginTop: 4 }}>{totMin}<span style={{ fontSize: 13, opacity: 0.8, marginLeft: 3 }}>{t("min")}</span></div>
                <div style={{ fontSize: 11, opacity: 0.8, marginTop: 2 }}>{list.length} {t("sessions")}</div>
              </div>
            </div>
          </div>

          {plannedToday.length > 0 && (() => {
            const allDone = plannedToday.every((_, i) => checked.includes(i));
            const GREEN = "#58C27D";
            return (
              <div style={{ marginBottom: 16 }}>
                <div style={{ display: "flex", justifyContent: "space-between", alignItems: "center", marginBottom: 8 }}>
                  <div style={{ ...label, marginBottom: 0 }}>{t("planned")}</div>
                  {allDone
                    ? <div onClick={() => undoAllPlanned(plannedToday)} className="hf-tap" style={{ cursor: "pointer", fontSize: 11.5, color: MUTED, fontWeight: 600, ...disp }}>{t("undoAll")}</div>
                    : <div onClick={() => markAllPlanned(plannedToday)} className="hf-tap" style={{ cursor: "pointer", fontSize: 12, color: EMBER, fontWeight: 700, border: `1px solid ${EMBER}`, borderRadius: 8, padding: "6px 12px", ...disp }}>{t("markAll")}</div>}
                </div>
                {!allDone && (
                  <div onClick={() => setRunner(true)} className="hf-tap" style={{ cursor: "pointer", textAlign: "center", background: EMBER, color: "#fff", padding: "13px 0", borderRadius: 12, ...disp, fontWeight: 700, fontSize: 15, letterSpacing: 0.8, textTransform: "uppercase", marginBottom: 10 }}>{t("startSession")}</div>
                )}
                {allDone && (
                  <div style={{ display: "flex", alignItems: "center", gap: 8, background: "rgba(88,194,125,0.12)", border: `1px solid ${GREEN}`, borderRadius: 10, padding: "9px 12px", marginBottom: 8, color: GREEN, ...disp, fontWeight: 700, fontSize: 13.5 }}>
                    <span style={{ fontSize: 15 }}>✓</span>{t("trainDone")}
                  </div>
                )}
                <div style={{ display: "grid", gap: 8 }}>
                  {plannedToday.map((x, i) => {
                    const on = checked.includes(i);
                    return (
                      <div key={i} onClick={() => togglePlanned(i, x)} className="hf-tap" style={{ cursor: "pointer", display: "flex", alignItems: "center", gap: 12, background: INK2, border: `1px ${on ? "solid " + GREEN : "dashed " + SAGE}`, borderRadius: 12, padding: "11px 14px" }}>
                        <div style={{ width: 24, height: 24, flexShrink: 0, borderRadius: "50%", border: `2px solid ${on ? GREEN : MUTED}`, background: on ? GREEN : "transparent", display: "flex", alignItems: "center", justifyContent: "center", color: "#0A0A0A", fontSize: 14, fontWeight: 800 }}>{on ? "✓" : ""}</div>
                        <div style={{ flex: 1 }}>
                          <div style={{ fontSize: 14, fontWeight: 600, color: on ? MUTED : PAPER, textDecoration: on ? "line-through" : "none" }}>{x.name}</div>
                          <div style={{ fontSize: 11, color: MUTED, marginTop: 2 }}>{setLabel(x) ? setLabel(x) + " · " : ""}{x.min} {t("min")} · ~{x.kcal} kcal</div>
                        </div>
                        {exOf(x) && exOf(x).how && <div onClick={(e) => { e.stopPropagation(); setHowEx(exOf(x)); }} style={{ cursor: "pointer", color: EMBER_SOFT, fontSize: 18, width: 28, textAlign: "center", flexShrink: 0 }}>ⓘ</div>}
                      </div>
                    );
                  })}
                </div>
              </div>
            );
          })()}

          {!adding && <div onClick={() => setAdding(true)} style={{ cursor: "pointer", textAlign: "center", background: INK2, border: `1px solid ${EMBER}`, color: EMBER, padding: "13px 0", borderRadius: 12, ...disp, fontWeight: 700, fontSize: 15, marginBottom: 16 }}>{t("add")}</div>}

          {adding && (
            <div style={{ background: INK2, border: `1px solid ${LINE}`, borderRadius: 14, padding: 16, marginBottom: 16 }}>
              {!chosen ? (
                <>
                  <div style={{ ...label, marginBottom: 8 }}>{t("pickExercise")}</div>
                  <ExAccordion onPick={setChosen} />
                  <div onClick={() => { resetPanel(); setAdding(false); }} style={{ cursor: "pointer", textAlign: "center", marginTop: 12, color: MUTED, fontSize: 12.5, fontWeight: 600 }}>{t("cancel")}</div>
                </>
              ) : (
                <div>
                  <div style={{ display: "flex", justifyContent: "space-between", alignItems: "center", marginBottom: 12 }}><div style={{ ...disp, fontSize: 16, fontWeight: 700 }}>{chosen.name}</div><div onClick={resetPanel} style={{ cursor: "pointer", fontSize: 11.5, color: MUTED, fontWeight: 600 }}>{t("change")}</div></div>
                  <label style={label}>{t("timer")}</label>
                  <div style={{ display: "flex", gap: 10, alignItems: "center", marginBottom: 12 }}>
                    {!run ? <div onClick={startTimer} style={{ cursor: "pointer", flex: 1, textAlign: "center", background: EMBER, color: "#fff", padding: "11px 0", borderRadius: 9, ...disp, fontWeight: 700 }}>▶ {t("start")}</div>
                      : <><div style={{ ...disp, fontSize: 26, fontWeight: 700, color: EMBER_SOFT, minWidth: 92 }}>{mmss(Date.now() - run.start)}</div><div onClick={stopTimer} style={{ cursor: "pointer", flex: 1, textAlign: "center", background: INK, border: `1px solid ${EMBER}`, color: EMBER, padding: "11px 0", borderRadius: 9, ...disp, fontWeight: 700 }}>■ {t("stop")}</div></>}
                  </div>
                  {!run && <div style={{ marginBottom: 12 }}><label style={label}>{t("minutes")}</label><input value={mins} onChange={(e) => { setMins(e.target.value.replace(/[^0-9]/g, "")); setKcalEdit(null); }} inputMode="numeric" placeholder="15" style={sIn} /></div>}
                  <div style={{ marginBottom: 14 }}>
                    <label style={label}>{t("estBurn")}</label>
                    <div style={{ display: "flex", alignItems: "center", gap: 8 }}><input value={showKcal} onChange={(e) => setKcalEdit(e.target.value.replace(/[^0-9]/g, ""))} inputMode="numeric" style={{ ...sIn, width: 110 }} /><span style={{ fontSize: 13, color: MUTED }}>kcal</span>{kcalEdit != null && <span onClick={() => setKcalEdit(null)} style={{ cursor: "pointer", fontSize: 11.5, color: EMBER, fontWeight: 600 }}>auto</span>}</div>
                  </div>
                  <div style={{ display: "flex", gap: 10 }}>
                    <div onClick={() => { resetPanel(); setAdding(false); }} style={{ cursor: "pointer", padding: "11px 16px", borderRadius: 9, border: `1px solid ${LINE}`, color: MUTED, fontSize: 13, fontWeight: 700, ...disp }}>{t("cancel")}</div>
                    <div onClick={addSession} style={{ cursor: "pointer", flex: 1, textAlign: "center", background: EMBER, color: "#fff", padding: "11px 0", borderRadius: 9, ...disp, fontWeight: 700, fontSize: 14 }}>{t("save")}</div>
                  </div>
                </div>
              )}
            </div>
          )}

          <div style={{ ...label, marginBottom: 8 }}>{t("today")}</div>
          {list.length === 0 ? (
            <div style={{ border: `1px dashed ${LINE}`, borderRadius: 12, padding: "22px", textAlign: "center", fontSize: 13, color: MUTED }}>{t("empty")}</div>
          ) : (
            <div style={{ display: "grid", gap: 8 }}>
              {list.map((x) => (
                <div key={x.id} style={{ display: "flex", justifyContent: "space-between", alignItems: "center", background: INK2, border: `1px solid ${LINE}`, borderRadius: 12, padding: "11px 14px" }}>
                  <div><div style={{ fontSize: 14, fontWeight: 600, color: PAPER }}>{x.name}</div><div style={{ fontSize: 11, color: MUTED, marginTop: 2 }}>{x.min} {t("min")}</div></div>
                  <div style={{ display: "flex", alignItems: "center", gap: 12 }}><div style={{ fontSize: 13, color: PAPER }}><span style={{ ...disp, fontWeight: 700, color: EMBER_SOFT }}>~{x.kcal}</span> kcal</div><div onClick={() => delLog(x.id)} style={{ cursor: "pointer", color: MUTED, fontSize: 16, width: 26, height: 26, display: "flex", alignItems: "center", justifyContent: "center", borderRadius: 7, border: `1px solid ${LINE}` }}>×</div></div>
                </div>
              ))}
            </div>
          )}
          <div style={{ fontSize: 11, color: MUTED, marginTop: 14, lineHeight: 1.5, borderLeft: `2px solid ${LINE}`, paddingLeft: 10 }}>{t("disclaimer")}</div>
        </>
      )}

      {tab === "week" && (
        <>
          <div style={{ fontSize: 12, color: MUTED, marginBottom: 12, lineHeight: 1.5 }}>{t("weekHint")}</div>
          <div onClick={() => setMove({ scope: "week" })} style={{ cursor: "pointer", textAlign: "center", background: INK2, border: `1px solid ${EMBER}`, color: EMBER, padding: "11px 0", borderRadius: 10, ...disp, fontWeight: 700, fontSize: 14, marginBottom: 14 }}>{t("move")}</div>
          <div style={{ display: "grid", gap: 10 }}>
            {plan.days.map((dd, di) => {
              const burn = dd.items.reduce((a, x) => a + num(x.kcal), 0);
              const mn = dd.items.reduce((a, x) => a + num(x.min), 0);
              return (
                <div key={di} style={{ background: INK2, border: `1px solid ${LINE}`, borderRadius: 12, overflow: "hidden" }}>
                  <div style={{ display: "flex", justifyContent: "space-between", alignItems: "center", padding: "10px 14px", background: INK, borderBottom: `1px solid ${LINE}` }}>
                    <div style={{ display: "flex", alignItems: "center", gap: 10 }}>
                      <div style={{ ...disp, fontWeight: 700, fontSize: 15, letterSpacing: 1, textTransform: "uppercase" }}>{WD[lang === "nl" ? "nl" : "en"][di]}</div>
                      <div onClick={() => setMove({ scope: "day", di })} style={{ cursor: "pointer", fontSize: 9.5, color: MUTED, border: `1px solid ${LINE}`, borderRadius: 5, padding: "2px 6px", fontWeight: 600 }}>{t("toDate")}</div>
                    </div>
                    <div style={{ fontSize: 11.5, color: MUTED }}>{dd.items.length > 0 ? <>{mn} {t("min")} · <span style={{ color: EMBER_SOFT, fontWeight: 700 }}>~{burn}</span> kcal</> : t("rest")}</div>
                  </div>
                  <div style={{ padding: "4px 0" }}>
                    {dd.items.map((x) => (
                      <div key={x.id} style={{ display: "flex", justifyContent: "space-between", alignItems: "center", padding: "9px 14px", borderBottom: `1px solid ${LINE}` }}>
                        <div><span style={{ fontSize: 13.5, color: PAPER, fontWeight: 500 }}>{x.name}</span> <span style={{ fontSize: 11, color: MUTED }}>· {setLabel(x) ? setLabel(x) + " · " : ""}{x.min} {t("min")} · ~{x.kcal} kcal</span></div>
                        <div style={{ display: "flex", alignItems: "center", gap: 12 }}>
                          {exOf(x) && exOf(x).how && <div onClick={() => setHowEx(exOf(x))} style={{ cursor: "pointer", color: EMBER_SOFT, fontSize: 17 }}>ⓘ</div>}
                          <div onClick={() => delFromDay(di, x.id)} style={{ cursor: "pointer", color: MUTED, fontSize: 15 }}>×</div>
                        </div>
                      </div>
                    ))}
                    <div onClick={() => setPlanAdd(di)} style={{ cursor: "pointer", textAlign: "center", padding: "9px 0", color: EMBER, fontSize: 12.5, fontWeight: 700, ...disp, letterSpacing: 0.5 }}>{t("addPlan")}</div>
                  </div>
                </div>
              );
            })}
          </div>
          <div style={{ fontSize: 11, color: MUTED, marginTop: 14, lineHeight: 1.5, borderLeft: `2px solid ${LINE}`, paddingLeft: 10 }}>{t("disclaimer")}</div>
        </>
      )}

      {tab === "prestaties" && <Prestaties lang={lang} sessions={sessions} />}

      {planAdd !== null && <PlanAddModal di={planAdd} onClose={() => setPlanAdd(null)} />}
      {move && <MoveModal scope={move.scope} di={move.di} onClose={() => setMove(null)} />}
      {howEx && <HowModal lang={lang} ex={howEx} onClose={() => setHowEx(null)} />}
      {runner && <SessionRunner lang={lang} kg={kg} items={plannedToday} checked={checked} toggle={togglePlanned} onHow={setHowEx} exOf={exOf} onFinish={finishSession} onClose={() => setRunner(false)} T={T} t={t} />}
      {summary && <SessionSummary lang={lang} data={summary} onClose={() => setSummary(null)} onUndo={undoLastSession} t={t} />}
    </div>
  );
}

// "Zo werkt het"-popover met media-slot (klaar voor latere GIF/video).
function HowModal({ lang, ex, onClose }) {
  const how = ex.how ? ex.how[lang === "nl" ? "nl" : "en"] : "";
  const demoLbl = lang === "nl" ? "Videodemo volgt" : "Video demo coming";
  return (
    <div onClick={onClose} style={{ position: "fixed", inset: 0, background: "rgba(0,0,0,0.72)", backdropFilter: "blur(6px)", WebkitBackdropFilter: "blur(6px)", zIndex: 76, display: "flex", alignItems: "center", justifyContent: "center", padding: 16 }}>
      <div onClick={(e) => e.stopPropagation()} style={{ background: INK, border: `1px solid ${EMBER_SOFT}`, borderRadius: 18, width: "100%", maxWidth: 400, padding: 20 }}>
        <div style={{ display: "flex", justifyContent: "space-between", alignItems: "center", marginBottom: 12 }}>
          <div style={{ ...disp, fontWeight: 700, fontSize: 17 }}>{ex[lang === "nl" ? "nl" : "en"]}</div>
          <div onClick={onClose} style={{ cursor: "pointer", color: MUTED, fontSize: 17, width: 30, height: 30, display: "flex", alignItems: "center", justifyContent: "center", borderRadius: 9, border: `1px solid ${LINE}` }}>×</div>
        </div>
        <div style={{ height: 130, borderRadius: 12, background: "linear-gradient(135deg,#3a3242,#1b1620)", border: `1px dashed ${LINE}`, display: "flex", flexDirection: "column", alignItems: "center", justifyContent: "center", gap: 8, marginBottom: 12 }}>
          {ex.demo
            ? <img src={ex.demo} alt="" style={{ maxWidth: "100%", maxHeight: "100%", borderRadius: 10 }} />
            : <><div style={{ width: 46, height: 46, borderRadius: "50%", background: "rgba(225,29,72,0.15)", display: "flex", alignItems: "center", justifyContent: "center", color: EMBER_SOFT, fontSize: 20 }}>▶</div><div style={{ fontSize: 11, color: MUTED }}>{demoLbl}</div></>}
        </div>
        <div style={{ ...disp, fontSize: 12, fontWeight: 600, textTransform: "uppercase", letterSpacing: 1.5, color: EMBER, marginBottom: 7 }}>{lang === "nl" ? "Zo werkt het" : "How it works"}</div>
        <div style={{ fontSize: 13.5, color: PAPER, opacity: 0.92, lineHeight: 1.6 }}>{how}</div>
      </div>
    </div>
  );
}

// Begeleide sessie: voortgangsbalk, huidige oefening uitgelicht, afvinken + afronden.
function SessionRunner({ lang, items, checked, toggle, onHow, exOf, onFinish, onClose, t }) {
  const GREEN = "#58C27D";
  const total = items.length;
  const done = items.filter((_, i) => checked.includes(i)).length;
  const pct = total ? Math.round((done / total) * 100) : 0;
  const curIdx = items.findIndex((_, i) => !checked.includes(i));
  const totMin = items.reduce((a, x) => a + num(x.min), 0);
  function nextStep() { if (curIdx >= 0) toggle(curIdx, items[curIdx]); }
  return (
    <div style={{ position: "fixed", inset: 0, background: "linear-gradient(180deg,#2c121b 0%,#200e15 48%,#180b10 100%)", zIndex: 78, overflowY: "auto" }}>
      <div style={{ maxWidth: 480, margin: "0 auto", padding: "calc(16px + env(safe-area-inset-top)) 16px calc(20px + env(safe-area-inset-bottom))" }}>
        <div style={{ display: "flex", justifyContent: "flex-end", marginBottom: 6 }}>
          <div onClick={onClose} style={{ cursor: "pointer", color: MUTED, fontSize: 18, width: 34, height: 34, display: "flex", alignItems: "center", justifyContent: "center", borderRadius: 9, border: `1px solid ${LINE}` }}>×</div>
        </div>
        <div style={{ background: `linear-gradient(135deg, ${EMBER}, #9f1239)`, borderRadius: 16, padding: "16px 16px 18px", marginBottom: 16, color: "#fff" }}>
          <div style={{ display: "flex", justifyContent: "space-between", alignItems: "flex-start", marginBottom: 12 }}>
            <div><div style={{ ...disp, fontWeight: 700, fontSize: 19 }}>{lang === "nl" ? "Training" : "Session"}</div><div style={{ fontSize: 11, opacity: 0.9, marginTop: 2 }}>{totMin} min</div></div>
            <div style={{ textAlign: "right" }}><div style={{ ...disp, fontWeight: 700, fontSize: 26 }}>{done}/{total}</div><div style={{ fontSize: 11, opacity: 0.9 }}>{t("sessionOf")}</div></div>
          </div>
          <div style={{ height: 7, borderRadius: 5, background: "rgba(255,255,255,0.22)", overflow: "hidden" }}><div style={{ height: "100%", width: pct + "%", background: "#fff", borderRadius: 5, transition: "width .25s" }} /></div>
        </div>
        <div style={{ display: "grid", gap: 9, marginBottom: 14 }}>
          {items.map((x, i) => {
            const on = checked.includes(i);
            const cur = i === curIdx;
            const ex = exOf(x);
            return (
              <div key={i} style={{ display: "flex", alignItems: "center", gap: 12, background: INK2, borderRadius: 14, padding: 12, border: `1px ${on ? "solid " + GREEN : cur ? "solid " + EMBER : "dashed " + SAGE}`, boxShadow: cur ? "0 0 22px rgba(225,29,72,0.22)" : "none" }}>
                <div onClick={() => toggle(i, x)} className="hf-tap" style={{ cursor: "pointer", width: 28, height: 28, flexShrink: 0, borderRadius: "50%", border: `2px solid ${on ? GREEN : cur ? EMBER : MUTED}`, background: on ? GREEN : "transparent", display: "flex", alignItems: "center", justifyContent: "center", color: on ? "#0A0A0A" : EMBER, fontSize: 14, fontWeight: 800 }}>{on ? "✓" : cur ? "▶" : ""}</div>
                <div style={{ flex: 1, minWidth: 0 }}>
                  <div style={{ fontSize: 14.5, fontWeight: 600, color: on ? MUTED : PAPER, textDecoration: on ? "line-through" : "none" }}>{x.name}</div>
                  <div style={{ fontSize: 11.5, color: MUTED, marginTop: 3 }}>{setLabel(x) ? setLabel(x) + " · " : ""}{x.min} {t("min")} · ~{x.kcal} kcal{cur ? " · " + t("nowBusy") : ""}</div>
                </div>
                {ex && ex.how && <div onClick={() => onHow(ex)} style={{ cursor: "pointer", color: EMBER_SOFT, fontSize: 18, width: 28, textAlign: "center", flexShrink: 0 }}>ⓘ</div>}
              </div>
            );
          })}
        </div>
        {curIdx >= 0 && <div onClick={nextStep} className="hf-tap" style={{ cursor: "pointer", textAlign: "center", background: EMBER, color: "#fff", padding: "15px 0", borderRadius: 12, ...disp, fontWeight: 700, fontSize: 16, letterSpacing: 0.8, textTransform: "uppercase" }}>{t("nextExercise")}</div>}
        <div onClick={() => onFinish(items)} className="hf-tap" style={{ cursor: "pointer", textAlign: "center", background: "transparent", border: `1px solid ${EMBER}`, color: EMBER, padding: "14px 0", borderRadius: 12, ...disp, fontWeight: 700, fontSize: 15, letterSpacing: 0.8, textTransform: "uppercase", marginTop: 9 }}>{t("finishSession")}</div>
      </div>
    </div>
  );
}

// Voltooi-samenvatting met statistiek.
function SessionSummary({ lang, data, onClose, onUndo, t }) {
  const stat = (v, l) => (
    <div style={{ background: INK2, border: `1px solid ${LINE}`, borderRadius: 14, padding: "14px 8px", textAlign: "center" }}>
      <div style={{ ...disp, fontWeight: 700, fontSize: 24, color: EMBER_SOFT }}>{v}</div>
      <div style={{ fontSize: 10, letterSpacing: 0.5, textTransform: "uppercase", color: MUTED, marginTop: 3, fontWeight: 600 }}>{l}</div>
    </div>
  );
  return (
    <div style={{ position: "fixed", inset: 0, background: "linear-gradient(180deg,#2c121b 0%,#200e15 48%,#180b10 100%)", zIndex: 80, overflowY: "auto" }}>
      <div style={{ maxWidth: 440, margin: "0 auto", padding: "calc(40px + env(safe-area-inset-top)) 20px 40px", textAlign: "center" }}>
        <div style={{ width: 84, height: 84, borderRadius: "50%", background: "rgba(88,194,125,0.14)", border: "2px solid #58C27D", display: "flex", alignItems: "center", justifyContent: "center", margin: "14px auto 16px", fontSize: 40 }}>🏆</div>
        <div style={{ ...disp, fontWeight: 700, fontSize: 24 }}>{t("sessionDone")}</div>
        <div style={{ fontSize: 13, color: MUTED, margin: "6px 0 20px", lineHeight: 1.5 }}>{t("sessionDoneSub")}</div>
        <div style={{ display: "grid", gridTemplateColumns: data.km > 0 ? "1fr 1fr 1fr 1fr" : "1fr 1fr 1fr", gap: 10, marginBottom: 20 }}>
          {stat(data.exercises, t("exercisesN"))}
          {stat(data.min, t("minutesN"))}
          {stat("~" + data.kcal, "kcal")}
          {data.km > 0 && stat(data.km, "km")}
        </div>
        <div onClick={onClose} className="hf-tap" style={{ cursor: "pointer", textAlign: "center", background: EMBER, color: "#fff", padding: "15px 0", borderRadius: 12, ...disp, fontWeight: 700, fontSize: 16, letterSpacing: 0.8, textTransform: "uppercase" }}>{t("backToday")}</div>
        <div onClick={onUndo} className="hf-tap" style={{ cursor: "pointer", textAlign: "center", background: "transparent", border: `1px solid ${LINE}`, color: MUTED, padding: "13px 0", borderRadius: 12, ...disp, fontWeight: 700, fontSize: 14, marginTop: 9 }}>{t("undoAll")}</div>
      </div>
    </div>
  );
}

// Prestaties-tab: levensloop-stats + medailles met niveaus.
function Prestaties({ lang, sessions }) {
  const t = (nl, en) => (lang === "nl" ? nl : en);
  const totals = aggregate(sessions);
  const TN = TIER_NAMES[lang === "nl" ? "nl" : "en"];
  const nf = (n) => n.toLocaleString(lang === "nl" ? "nl-NL" : "en-US");
  const statTile = (v, unit, l) => (
    <div style={{ background: INK2, border: `1px solid ${LINE}`, borderLeft: `3px solid ${EMBER}`, borderRadius: 14, padding: 14, boxShadow: SHADOW }}>
      <div style={{ ...disp, fontWeight: 700, fontSize: 26, color: PAPER, lineHeight: 1 }}>{v}<span style={{ fontSize: 13, color: MUTED, marginLeft: 4 }}>{unit}</span></div>
      <div style={{ fontSize: 10.5, letterSpacing: 0.5, textTransform: "uppercase", color: MUTED, marginTop: 6, fontWeight: 600 }}>{l}</div>
    </div>
  );
  if (!sessions || sessions.length === 0) {
    return (
      <div>
        <div style={{ fontSize: 12.5, color: MUTED, marginBottom: 14, lineHeight: 1.5 }}>{t("Alles wat je tot nu toe hebt neergezet. Blijf trainen, verdien je medailles.", "Everything you've put down so far. Keep training, earn your medals.")}</div>
        <div style={{ background: INK2, border: `1px dashed ${LINE}`, borderRadius: 14, padding: 22, textAlign: "center", fontSize: 13, color: MUTED, lineHeight: 1.6 }}>
          {t("Nog geen voltooide trainingen. Rond je eerste sessie af en je ziet hier je score groeien.", "No completed sessions yet. Finish your first session and watch your score grow here.")}
        </div>
      </div>
    );
  }
  return (
    <div>
      <div style={{ fontSize: 12.5, color: MUTED, marginBottom: 16, lineHeight: 1.5 }}>{t("Alles wat je tot nu toe hebt neergezet. Blijf trainen, verdien je medailles.", "Everything you've put down so far. Keep training, earn your medals.")}</div>
      <div style={{ ...disp, fontSize: 13, fontWeight: 600, textTransform: "uppercase", letterSpacing: 1.5, color: EMBER, marginBottom: 11 }}>{t("Totaal", "Total")}</div>
      <div style={{ display: "grid", gridTemplateColumns: "1fr 1fr", gap: 10, marginBottom: 20 }}>
        {statTile(nf(totals.km), "km", t("Afstand", "Distance"))}
        {statTile(totals.kcal >= 1000 ? (Math.round(totals.kcal / 100) / 10) + "k" : nf(totals.kcal), "kcal", t("Verbrand", "Burned"))}
        {statTile(nf(totals.sessions), t("sessies", "sessions"), t("Voltooid", "Completed"))}
        {statTile(Math.round(totals.minutes / 60), "u", t("Trainingstijd", "Training time"))}
      </div>
      <div style={{ ...disp, fontSize: 13, fontWeight: 600, textTransform: "uppercase", letterSpacing: 1.5, color: EMBER, marginBottom: 11 }}>{t("Medailles", "Medals")}</div>
      {MEDALS.map((m) => {
        const st = medalState(m, totals);
        const earned = st.level >= 0;
        const col = earned ? TIER_COLORS[st.level] : MUTED;
        const unit = lang === "nl" ? m.unitNl : m.unitEn;
        return (
          <div key={m.key} style={{ background: INK2, border: `1px solid ${LINE}`, borderRadius: 14, padding: "13px 14px", marginBottom: 10, display: "flex", gap: 13, alignItems: "center", boxShadow: SHADOW }}>
            <div style={{ width: 46, height: 46, borderRadius: "50%", flexShrink: 0, display: "flex", alignItems: "center", justifyContent: "center", border: `2px solid ${earned ? col : LINE}`, background: earned ? col : TRACK }}>
              {medalIcon(m.key, earned ? "#fff" : MUTED)}
            </div>
            <div style={{ flex: 1, minWidth: 0 }}>
              <div style={{ display: "flex", justifyContent: "space-between", alignItems: "center" }}>
                <span style={{ ...disp, fontWeight: 700, fontSize: 15 }}>{lang === "nl" ? m.nl : m.en}</span>
                <span style={{ fontSize: 10, fontWeight: 700, letterSpacing: 0.5, textTransform: "uppercase", padding: "3px 8px", borderRadius: 5, background: earned ? col : "transparent", border: earned ? "none" : `1px solid ${LINE}`, color: earned ? "#fff" : MUTED }}>{earned ? TN[st.level] : (lang === "nl" ? "Op slot" : "Locked")}</span>
              </div>
              <div style={{ height: 6, borderRadius: 4, background: TRACK, overflow: "hidden", margin: "8px 0 5px" }}><div style={{ height: "100%", width: Math.max(earned ? 0 : 3, Math.round(st.progress * 100)) + "%", borderRadius: 4, background: earned ? col : EMBER }} /></div>
              <div style={{ fontSize: 11, color: MUTED }}>
                {st.maxed
                  ? (lang === "nl" ? "Max niveau ✓ — " : "Max level ✓ — ") + nf(st.value) + " " + unit
                  : <>{nf(st.value)} / {nf(st.nextTarget)} {unit} — {lang === "nl" ? "nog" : "still"} <b style={{ color: EMBER, fontWeight: 700 }}>{nf(Math.max(0, st.nextTarget - st.value))}</b> {lang === "nl" ? "tot " : "to "}{TN[Math.min(st.level + 1, TN.length - 1)]}</>}
              </div>
            </div>
          </div>
        );
      })}
      <div style={{ fontSize: 11, color: MUTED, marginTop: 8, lineHeight: 1.5, textAlign: "center" }}>
        {t("Elke voltooide training telt automatisch mee. Niveaus: brons → zilver → goud → platina → diamant.", "Every finished session counts automatically. Levels: bronze → silver → gold → platinum → diamond.")}
      </div>
    </div>
  );
}
