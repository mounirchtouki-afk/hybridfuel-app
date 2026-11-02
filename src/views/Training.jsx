import React, { useState, useEffect, useRef } from "react";
import { createPortal } from "react-dom";
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

// Alle gelogde trainingen (hf_workouts_<datum>) als records voor de prestaties.
// Dit is de echte bron van wat de gebruiker heeft gedaan, niet alleen runner-sessies.
function gatherWorkoutRecords() {
  const out = [];
  try {
    for (let i = 0; i < localStorage.length; i++) {
      const k = localStorage.key(i);
      if (k && k.indexOf("hf_workouts_") === 0) {
        const date = k.slice(12);
        let arr = [];
        try { arr = JSON.parse(localStorage.getItem(k) || "[]"); } catch (e) {}
        if (Array.isArray(arr)) arr.forEach((w) => out.push({ date, kcal: Number(w.kcal) || 0, min: Number(w.min) || 0, km: (Number(w.dist) || 0) / 1000 }));
      }
    }
  } catch (e) {}
  return out;
}
import BrandCalendar from "./BrandCalendar.jsx";
import { EXERCISES, WORKOUT_CATS, INTENSITY, kcalFor, exerciseByName, HYROX_RACE } from "../workouts.js";
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
  timeN: { nl: "Tijd", en: "Time" },
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
  logVideo: { nl: "Video", en: "Video" },
  logWatch: { nl: "Bekijk oefening", en: "Watch exercise" },
  logWatchSub: { nl: "Zo doe je 'm goed", en: "Do it right" },
  logFilm: { nl: "Film je set", en: "Film your set" },
  logFilmSub: { nl: "Eigen opname", en: "Your recording" },
  logSets: { nl: "Sets · gewicht", en: "Sets · weight" },
  logNote: { nl: "Notitie", en: "Note" },
  logLast: { nl: "Vorige keer", en: "Last time" },
  logNoteHint: { nl: "Typ je notitie of tik de microfoon voor spraak-naar-tekst.", en: "Type your note or tap the mic for speech-to-text." },
  logNotePh: { nl: "Hoe voelde het? Zwaarder/lichter volgende keer?", en: "How did it feel? Heavier/lighter next time?" },
  logSave: { nl: "Opslaan", en: "Save" },
  logRecorded: { nl: "Opname bewaard", en: "Recording saved" },
  logRemoveClip: { nl: "Verwijder", en: "Remove" },
  logListening: { nl: "Luisteren…", en: "Listening…" },
  logOpen: { nl: "tik om te loggen", en: "tap to log" },
  delete: { nl: "Verwijder", en: "Delete" },
};

// Kleine IndexedDB-opslag voor eigen set-opnames (video-blobs; te groot voor localStorage).
function idbVideo(action, key, blob) {
  return new Promise((res) => {
    try {
      const r = indexedDB.open("hf_media", 1);
      r.onupgradeneeded = () => { try { r.result.createObjectStore("v"); } catch (e) {} };
      r.onsuccess = () => {
        try {
          const db = r.result;
          const tx = db.transaction("v", action === "get" ? "readonly" : "readwrite");
          const st = tx.objectStore("v");
          let rq;
          if (action === "get") rq = st.get(key);
          else if (action === "put") rq = st.put(blob, key);
          else rq = st.delete(key);
          rq.onsuccess = () => res(action === "get" ? rq.result : true);
          rq.onerror = () => res(null);
        } catch (e) { res(null); }
      };
      r.onerror = () => res(null);
    } catch (e) { res(null); }
  });
}

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
  const [planEdit, setPlanEdit] = useState(null); // geplande regel bewerken {di, item}
  const [templates, setTemplates] = useState(() => load("hf_templates", [])); // eigen opgeslagen trainingen
  const [tplBuild, setTplBuild] = useState(null); // trainingbouwer open: {} = nieuw, {tpl} = bewerken
  const [move, setMove] = useState(null);
  const [runner, setRunner] = useState(false);   // sessie-runner open
  const [logEx, setLogEx] = useState(null);       // oefening-logboek {item}
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
  function logPlanned(it) { persistLog([...list, { id: "w" + Date.now(), name: it.name, met: it.met, min: it.min, kcal: it.kcal, dist: it.dist || null, ts: Date.now() }]); }

  // --- Afvinken van geplande sessies (los of de hele training in één tik) ---
  const planKey = (i) => d + ":" + i;
  function setCheckedSave(next) { setChecked(next); save("hf_trainchecked_" + d, next); }
  function togglePlanned(i, it) {
    if (checked.includes(i)) {
      persistLog(list.filter((x) => x.planKey !== planKey(i)));
      setCheckedSave(checked.filter((c) => c !== i));
    } else {
      persistLog([...list, { id: "w" + Date.now() + "_" + i, name: it.name, met: it.met, min: it.min, kcal: it.kcal, dist: it.dist || null, ts: Date.now(), planKey: planKey(i) }]);
      setCheckedSave([...checked, i]);
    }
  }
  function markDonePlanned(i, it) {
    if (checked.includes(i)) return; // al afgevinkt -> niets doen (niet uitvinken)
    persistLog([...list, { id: "w" + Date.now() + "_" + i, name: it.name, met: it.met, min: it.min, kcal: it.kcal, dist: it.dist || null, ts: Date.now(), planKey: planKey(i) }]);
    setCheckedSave([...checked, i]);
  }
  function markAllPlanned(items) {
    const adds = items.map((it, i) => ({ it, i })).filter(({ i }) => !checked.includes(i))
      .map(({ it, i }) => ({ id: "w" + Date.now() + "_" + i, name: it.name, met: it.met, min: it.min, kcal: it.kcal, dist: it.dist || null, ts: Date.now(), planKey: planKey(i) }));
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
  function finishSession(items, meta) {
    const tot = sessionTotals(items);
    const sec = (meta && meta.time) || 0;
    const rec = { id: "s" + Date.now(), date: d, name: null, ...tot, sec, ts: Date.now() };
    const next = [...sessions.filter((s) => s.date !== d || s.id !== rec.id), rec];
    // één sessie per keer-afronden; dubbele afronding op dezelfde dag vervangt de laatste
    const cleaned = next.filter((s) => !(s.date === d && s.id !== rec.id && s._auto));
    setSessions(cleaned); save("hf_sessions", cleaned);
    markAllPlanned(items);
    try { localStorage.removeItem("hf_sessclock_" + d); localStorage.removeItem("hf_sesssplits_" + d); } catch (e) {}
    setRunner(false);
    setSummary({ ...tot, name: null, sec, splits: (meta && meta.splits) || {}, items });
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
  // Hele Hyrox-wedstrijd (8 runs + 8 stations) in één keer aan een dag toevoegen.
  function addRaceToDay(di) {
    const rows = HYROX_RACE.map((r, k) => ({ id: "p" + Date.now() + "_" + k, name: r.name, met: r.met, min: r.min, kcal: kcalFor(r.met, kg, r.min), metric: r.metric, exId: r.exId, sets: null, reps: r.reps || null, dist: r.dist || null }));
    const days = plan.days.map((dd, i) => i === di ? { items: [...dd.items, ...rows] } : dd);
    persistPlan({ days });
  }
  function delFromDay(di, id) { const days = plan.days.map((dd, i) => i === di ? { items: dd.items.filter((x) => x.id !== id) } : dd); persistPlan({ days }); }
  function editItemInDay(di, id, patch) { const days = plan.days.map((dd, i) => i === di ? { items: dd.items.map((x) => x.id === id ? { ...x, ...patch, kcal: kcalFor(x.met, kg, num(patch.min != null ? patch.min : x.min)) } : x) } : dd); persistPlan({ days }); }
  // --- Mijn trainingen (opgeslagen templates) ---
  function persistTemplates(next) { setTemplates(next); save("hf_templates", next); }
  function saveTemplate(tpl) { const exists = templates.some((x) => x.id === tpl.id); persistTemplates(exists ? templates.map((x) => x.id === tpl.id ? tpl : x) : [...templates, tpl]); }
  function deleteTemplate(id) { persistTemplates(templates.filter((x) => x.id !== id)); }
  // Hele training (template) in één keer aan een dag toevoegen.
  function applyTemplateToDay(di, tpl) {
    const base = Date.now();
    const rows = (tpl.items || []).map((r, k) => ({ id: "p" + base + "_" + k, name: r.name, met: r.met, min: num(r.min) || 0, kcal: kcalFor(r.met, kg, num(r.min) || 0), metric: r.metric || "time", exId: r.exId || null, sets: r.sets || null, reps: r.reps || null, dist: r.dist || null }));
    const days = plan.days.map((dd, i) => i === di ? { items: [...dd.items, ...rows] } : dd);
    persistPlan({ days });
  }
  // Ingebouwde Hyrox-wedstrijd als template, plus de eigen trainingen.
  const BUILTIN_HYROX = { id: "builtin_hyrox", builtin: true, name: lang === "nl" ? "Hyrox-simulatie (full)" : "Hyrox simulation (full)", items: HYROX_RACE };
  const allTemplates = [BUILTIN_HYROX, ...templates];
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
    const seg = (on) => ({ flex: 1, textAlign: "center", cursor: "pointer", padding: "9px 0", borderRadius: 8, border: `1px solid ${on ? EMBER : LINE}`, background: on ? "rgba(var(--hf-ember-rgb),0.12)" : "transparent", color: on ? PAPER : MUTED, fontSize: 12.5, fontWeight: 700, ...disp });
    const radio = (on) => ({ display: "flex", alignItems: "center", gap: 9, cursor: "pointer", padding: "10px 12px", borderRadius: 10, border: `1px solid ${on ? EMBER : LINE}`, background: on ? "rgba(var(--hf-ember-rgb),0.08)" : INK2 });
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
    const [tab2, setTab2] = useState("tpl");
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
          {!ch ? (
            <div>
              <div style={{ display: "flex", gap: 4, background: INK2, border: `1px solid ${LINE}`, borderRadius: 10, padding: 4, marginBottom: 14 }}>
                <div onClick={() => setTab2("tpl")} style={{ cursor: "pointer", flex: 1, textAlign: "center", fontSize: 12, fontWeight: 700, ...disp, padding: "8px 0", borderRadius: 7, background: tab2 === "tpl" ? EMBER : "transparent", color: tab2 === "tpl" ? "#fff" : MUTED }}>{lang === "nl" ? "Mijn trainingen" : "My workouts"}</div>
                <div onClick={() => setTab2("ex")} style={{ cursor: "pointer", flex: 1, textAlign: "center", fontSize: 12, fontWeight: 700, ...disp, padding: "8px 0", borderRadius: 7, background: tab2 === "ex" ? EMBER : "transparent", color: tab2 === "ex" ? "#fff" : MUTED }}>{lang === "nl" ? "Losse oefening" : "Single exercise"}</div>
              </div>
              {tab2 === "ex" ? <ExAccordion onPick={setCh} /> : (
                <div>
                  {allTemplates.map((tpl) => (
                    <div key={tpl.id} style={{ display: "flex", alignItems: "center", gap: 11, background: INK2, border: `1px solid ${LINE}`, borderRadius: 12, padding: "11px 12px", marginBottom: 9 }}>
                      <div onClick={() => { applyTemplateToDay(di, tpl); onClose(); }} className="hf-tap" style={{ cursor: "pointer", display: "flex", alignItems: "center", gap: 11, flex: 1, minWidth: 0 }}>
                        <div style={{ width: 42, height: 42, borderRadius: 11, flexShrink: 0, display: "flex", alignItems: "center", justifyContent: "center", background: tpl.builtin ? EMBER : "rgba(var(--hf-ember-rgb),0.12)", color: tpl.builtin ? "#fff" : EMBER, ...disp, fontWeight: 700, fontSize: 15 }}>{tpl.builtin ? "H" : (tpl.name || "?").slice(0, 1).toUpperCase()}</div>
                        <div style={{ minWidth: 0 }}>
                          <div style={{ fontSize: 14, fontWeight: 600, color: PAPER, whiteSpace: "nowrap", overflow: "hidden", textOverflow: "ellipsis" }}>{tpl.name}</div>
                          <div style={{ fontSize: 11, color: MUTED, marginTop: 2 }}>{(tpl.items || []).length} {lang === "nl" ? "onderdelen" : "parts"}{tpl.builtin ? (lang === "nl" ? " · standaard" : " · default") : (lang === "nl" ? " · eigen" : " · custom")}</div>
                        </div>
                      </div>
                      {!tpl.builtin && (
                        <>
                          <div onClick={() => { onClose(); setTplBuild({ tpl }); }} style={{ cursor: "pointer", color: MUTED, fontSize: 15, flexShrink: 0, width: 26, textAlign: "center" }}>✎</div>
                          <div onClick={() => deleteTemplate(tpl.id)} style={{ cursor: "pointer", color: MUTED, fontSize: 17, flexShrink: 0, width: 24, textAlign: "center" }}>×</div>
                        </>
                      )}
                    </div>
                  ))}
                  <div onClick={() => { onClose(); setTplBuild({ di }); }} className="hf-tap" style={{ cursor: "pointer", textAlign: "center", padding: "11px 0", color: EMBER, fontSize: 12.5, fontWeight: 700, ...disp, letterSpacing: 0.5, border: `1px dashed ${EMBER}`, borderRadius: 11, marginTop: 2 }}>+ {lang === "nl" ? "Nieuwe training maken" : "New workout"}</div>
                </div>
              )}
            </div>
          ) : (
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
                <div onClick={() => { if (ch.exId === "hyroxsim") { addRaceToDay(di); onClose(); return; } if (num(mn) <= 0) return; addToDay(di, { id: "p" + Date.now(), name: ch.name, met: ch.met, min: num(mn), kcal: kc, metric, exId: ch.exId || null, sets: num(sets) || null, reps: num(reps) || null, dist: num(dist) || null }); onClose(); }} style={{ cursor: "pointer", flex: 1, textAlign: "center", background: EMBER, color: "#fff", padding: "11px 0", borderRadius: 9, ...disp, fontWeight: 700, fontSize: 14 }}>{ch.exId === "hyroxsim" ? (lang === "nl" ? "Hele Hyrox toevoegen" : "Add full Hyrox") : t("save")}</div>
              </div>
            </div>
          )}
        </div>
      </div>
    );
  }

  // Trainingbouwer: stel een eigen training samen en sla 'm op bij Mijn trainingen.
  function TemplateBuilder({ init, onClose }) {
    const editing = init && init.tpl ? init.tpl : null;
    const di = init && init.di != null ? init.di : null;
    const [name, setName] = useState(editing ? editing.name : "");
    const [bItems, setBItems] = useState(editing ? (editing.items || []).map((x, k) => ({ ...x, _k: "b" + k })) : []);
    const [picking, setPicking] = useState(false);
    const [ch, setCh] = useState(null);
    const [mn, setMn] = useState(""); const [sets, setSets] = useState(""); const [reps, setReps] = useState(""); const [dist, setDist] = useState("");
    const metric = ch ? (ch.metric || "time") : "time";
    function resetAdd() { setCh(null); setPicking(false); setMn(""); setSets(""); setReps(""); setDist(""); }
    function addEx() {
      if (!ch) return;
      if (ch.exId === "hyroxsim") {
        const base = Date.now();
        const hy = HYROX_RACE.map((r, k) => ({ _k: "b" + base + "_" + k, name: r.name, met: r.met, min: r.min, metric: r.metric, exId: r.exId, sets: null, reps: r.reps || null, dist: r.dist || null }));
        setBItems((prev) => [...prev, ...hy]); resetAdd(); return;
      }
      if (num(mn) <= 0) return;
      setBItems((prev) => [...prev, { _k: "b" + Date.now(), name: ch.name, met: ch.met, min: num(mn), metric, exId: ch.exId || null, sets: num(sets) || null, reps: num(reps) || null, dist: num(dist) || null }]);
      resetAdd();
    }
    function removeAt(k) { setBItems((prev) => prev.filter((x) => x._k !== k)); }
    function move(k, dir) { setBItems((prev) => { const idx = prev.findIndex((x) => x._k === k); const j = idx + dir; if (j < 0 || j >= prev.length) return prev; const nx = [...prev]; const [it] = nx.splice(idx, 1); nx.splice(j, 0, it); return nx; }); }
    function doSave() {
      if (!name.trim() || bItems.length === 0) return;
      const items = bItems.map(({ _k, ...rest }) => rest);
      const tpl = { id: editing ? editing.id : "t" + Date.now(), name: name.trim(), items };
      saveTemplate(tpl);
      if (!editing && di != null) applyTemplateToDay(di, tpl);
      onClose();
    }
    return (
      <div onClick={onClose} style={{ position: "fixed", inset: 0, background: "rgba(0,0,0,0.72)", backdropFilter: "blur(6px)", WebkitBackdropFilter: "blur(6px)", zIndex: 76, display: "flex", alignItems: "center", justifyContent: "center", padding: 16 }}>
        <div onClick={(e) => e.stopPropagation()} className="hf-modal" style={{ background: INK, border: `1px solid ${LINE}`, borderRadius: 18, width: "100%", maxWidth: 420, maxHeight: "90vh", overflowY: "auto", padding: 20 }}>
          <div style={{ display: "flex", justifyContent: "space-between", alignItems: "center", marginBottom: 14 }}>
            <div style={{ ...disp, fontWeight: 700, fontSize: 17 }}>{editing ? (lang === "nl" ? "Training bewerken" : "Edit workout") : (lang === "nl" ? "Nieuwe training" : "New workout")}</div>
            <div onClick={onClose} style={{ cursor: "pointer", color: MUTED, fontSize: 17, width: 30, height: 30, display: "flex", alignItems: "center", justifyContent: "center", borderRadius: 9, border: `1px solid ${LINE}` }}>×</div>
          </div>
          <label style={label}>{lang === "nl" ? "Naam" : "Name"}</label>
          <input value={name} onChange={(e) => setName(e.target.value)} placeholder={lang === "nl" ? "bijv. Mijn Hyrox light" : "e.g. My Hyrox light"} style={{ ...sIn, marginBottom: 12 }} />
          <label style={label}>{lang === "nl" ? "Oefeningen" : "Exercises"} · {bItems.length}</label>
          {bItems.length > 0 && (
            <div style={{ background: INK2, border: `1px solid ${LINE}`, borderRadius: 12, overflow: "hidden", marginBottom: 10 }}>
              {bItems.map((x, i) => (
                <div key={x._k} style={{ display: "flex", alignItems: "center", gap: 8, padding: "9px 11px", borderTop: i > 0 ? `1px solid ${LINE}` : "none" }}>
                  <div style={{ display: "flex", flexDirection: "column", flexShrink: 0 }}>
                    <div onClick={() => move(x._k, -1)} style={{ cursor: "pointer", color: i === 0 ? LINE : MUTED, fontSize: 11, lineHeight: 1 }}>▲</div>
                    <div onClick={() => move(x._k, 1)} style={{ cursor: "pointer", color: i === bItems.length - 1 ? LINE : MUTED, fontSize: 11, lineHeight: 1 }}>▼</div>
                  </div>
                  <div style={{ flex: 1, minWidth: 0 }}>
                    <div style={{ fontSize: 13, fontWeight: 600, color: PAPER, whiteSpace: "nowrap", overflow: "hidden", textOverflow: "ellipsis" }}>{x.name}</div>
                    <div style={{ fontSize: 10.5, color: MUTED, marginTop: 1 }}>{setLabel(x) ? setLabel(x) + " · " : ""}{x.min} {t("min")}</div>
                  </div>
                  <div onClick={() => removeAt(x._k)} style={{ cursor: "pointer", color: MUTED, fontSize: 16, flexShrink: 0 }}>×</div>
                </div>
              ))}
            </div>
          )}
          {ch ? (
            <div style={{ background: INK2, border: `1px solid ${LINE}`, borderRadius: 12, padding: 13, marginBottom: 10 }}>
              <div style={{ display: "flex", justifyContent: "space-between", alignItems: "center", marginBottom: 10 }}><div style={{ ...disp, fontSize: 14, fontWeight: 700 }}>{ch.name}</div><div onClick={resetAdd} style={{ cursor: "pointer", fontSize: 11.5, color: MUTED, fontWeight: 600 }}>{t("change")}</div></div>
              {ch.exId === "hyroxsim" ? (
                <div style={{ fontSize: 12, color: MUTED, marginBottom: 12, lineHeight: 1.5 }}>{lang === "nl" ? "Voegt de 16 Hyrox-onderdelen in één keer toe." : "Adds all 16 Hyrox parts at once."}</div>
              ) : (
                <>
                  {metric === "reps" && (
                    <div style={{ display: "flex", gap: 10, marginBottom: 10 }}>
                      <div style={{ flex: 1 }}><label style={label}>{t("sets")}</label><input value={sets} onChange={(e) => setSets(e.target.value.replace(/[^0-9]/g, ""))} inputMode="numeric" placeholder="4" style={sIn} /></div>
                      <div style={{ flex: 1 }}><label style={label}>{t("reps")}</label><input value={reps} onChange={(e) => setReps(e.target.value.replace(/[^0-9]/g, ""))} inputMode="numeric" placeholder="12" style={sIn} /></div>
                    </div>
                  )}
                  {metric === "dist" && (
                    <div style={{ marginBottom: 10 }}><label style={label}>{t("dist")}</label><input value={dist} onChange={(e) => setDist(e.target.value.replace(/[^0-9]/g, ""))} inputMode="numeric" placeholder="1000" style={sIn} /></div>
                  )}
                  <label style={label}>{t("minutes")}</label>
                  <input value={mn} onChange={(e) => setMn(e.target.value.replace(/[^0-9]/g, ""))} inputMode="numeric" placeholder="20" style={{ ...sIn, marginBottom: 12 }} />
                </>
              )}
              <div onClick={addEx} className="hf-tap" style={{ cursor: "pointer", textAlign: "center", background: EMBER, color: "#fff", padding: "11px 0", borderRadius: 9, ...disp, fontWeight: 700, fontSize: 14 }}>{lang === "nl" ? "Toevoegen aan training" : "Add to workout"}</div>
            </div>
          ) : picking ? (
            <div style={{ marginBottom: 10 }}><ExAccordion onPick={setCh} /><div onClick={() => setPicking(false)} style={{ cursor: "pointer", textAlign: "center", marginTop: 10, color: MUTED, fontSize: 12, fontWeight: 600 }}>{t("cancel")}</div></div>
          ) : (
            <div onClick={() => setPicking(true)} className="hf-tap" style={{ cursor: "pointer", textAlign: "center", padding: "11px 0", color: EMBER, fontSize: 12.5, fontWeight: 700, ...disp, letterSpacing: 0.5, border: `1px dashed ${EMBER}`, borderRadius: 11, marginBottom: 10 }}>+ {lang === "nl" ? "Oefening toevoegen" : "Add exercise"}</div>
          )}
          <div onClick={doSave} className="hf-tap" style={{ cursor: num(name.trim().length) > 0 && bItems.length > 0 ? "pointer" : "not-allowed", opacity: name.trim() && bItems.length > 0 ? 1 : 0.5, textAlign: "center", background: EMBER, color: "#fff", padding: "13px 0", borderRadius: 11, ...disp, fontWeight: 700, fontSize: 15, letterSpacing: 0.6, textTransform: "uppercase", marginTop: 4 }}>{lang === "nl" ? "Opslaan bij mijn trainingen" : "Save to my workouts"}</div>
        </div>
      </div>
    );
  }

  // Modal om een reeds-geplande regel aan te passen (meters/kg/reps/min).
  function PlanEditModal({ di, item, onClose }) {
    const metric = item.metric || "time";
    const [mn, setMn] = useState(String(item.min || ""));
    const [sets, setSets] = useState(item.sets ? String(item.sets) : "");
    const [reps, setReps] = useState(item.reps ? String(item.reps) : "");
    const [dist, setDist] = useState(item.dist ? String(item.dist) : "");
    const kc = kcalFor(item.met, kg, num(mn));
    return (
      <div onClick={onClose} style={{ position: "fixed", inset: 0, background: "rgba(0,0,0,0.72)", backdropFilter: "blur(6px)", WebkitBackdropFilter: "blur(6px)", zIndex: 74, display: "flex", alignItems: "center", justifyContent: "center", padding: 16 }}>
        <div onClick={(e) => e.stopPropagation()} className="hf-modal" style={{ background: INK, border: `1px solid ${LINE}`, borderRadius: 18, width: "100%", maxWidth: 400, maxHeight: "88vh", overflowY: "auto", padding: 20 }}>
          <div style={{ display: "flex", justifyContent: "space-between", alignItems: "center", marginBottom: 14 }}>
            <div style={{ ...disp, fontWeight: 700, fontSize: 16 }}>{item.name}</div>
            <div onClick={onClose} style={{ cursor: "pointer", color: MUTED, fontSize: 17, width: 30, height: 30, display: "flex", alignItems: "center", justifyContent: "center", borderRadius: 9, border: `1px solid ${LINE}` }}>×</div>
          </div>
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
            <div onClick={() => { delFromDay(di, item.id); onClose(); }} style={{ cursor: "pointer", padding: "11px 16px", borderRadius: 9, border: `1px solid ${LINE}`, color: EMBER_SOFT, fontSize: 13, fontWeight: 700, ...disp }}>{t("delete")}</div>
            <div onClick={() => { if (num(mn) <= 0) return; editItemInDay(di, item.id, { min: num(mn), sets: num(sets) || null, reps: num(reps) || null, dist: num(dist) || null }); onClose(); }} style={{ cursor: "pointer", flex: 1, textAlign: "center", background: EMBER, color: "#fff", padding: "11px 0", borderRadius: 9, ...disp, fontWeight: 700, fontSize: 14 }}>{t("save")}</div>
          </div>
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

          <div style={{ background: `linear-gradient(135deg, ${EMBER}, var(--hf-ember-deep))`, borderRadius: 16, padding: "18px", marginBottom: 14, color: "#fff" }}>
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
                      <div key={i} style={{ display: "flex", alignItems: "center", gap: 12, background: INK2, border: `1px ${on ? "solid " + GREEN : "dashed " + SAGE}`, borderRadius: 12, padding: "11px 14px" }}>
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
                        <div onClick={() => setPlanEdit({ di, item: x })} style={{ cursor: "pointer", flex: 1, minWidth: 0 }}><span style={{ fontSize: 13.5, color: PAPER, fontWeight: 500 }}>{x.name}</span> <span style={{ fontSize: 11, color: MUTED }}>· {setLabel(x) ? setLabel(x) + " · " : ""}{x.min} {t("min")} · ~{x.kcal} kcal</span></div>
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
      {planEdit && <PlanEditModal di={planEdit.di} item={planEdit.item} onClose={() => setPlanEdit(null)} />}
      {tplBuild && <TemplateBuilder init={tplBuild} onClose={() => setTplBuild(null)} />}
      {move && <MoveModal scope={move.scope} di={move.di} onClose={() => setMove(null)} />}
      {howEx && <HowModal lang={lang} ex={howEx} onClose={() => setHowEx(null)} />}
      {runner && <SessionRunner lang={lang} kg={kg} items={plannedToday} checked={checked} toggle={togglePlanned} exOf={exOf} onFinish={finishSession} onClose={() => setRunner(false)} dateKey={d} t={t} />}
      {summary && <SessionSummary lang={lang} data={summary} onClose={() => setSummary(null)} onUndo={undoLastSession} t={t} />}
    </div>
  );
}

// "Zo werkt het"-popover met media-slot (klaar voor latere GIF/video).
function HowModal({ lang, ex, onClose }) {
  const how = ex.how ? ex.how[lang === "nl" ? "nl" : "en"] : "";
  const demoLbl = lang === "nl" ? "Videodemo volgt" : "Video demo coming";
  return createPortal(
    <div onClick={onClose} style={{ position: "fixed", inset: 0, background: "rgba(0,0,0,0.72)", backdropFilter: "blur(6px)", WebkitBackdropFilter: "blur(6px)", zIndex: 210, display: "flex", alignItems: "center", justifyContent: "center", padding: 16 }}>
      <div onClick={(e) => e.stopPropagation()} style={{ background: INK, border: `1px solid ${EMBER_SOFT}`, borderRadius: 18, width: "100%", maxWidth: 400, padding: 20 }}>
        <div style={{ display: "flex", justifyContent: "space-between", alignItems: "center", marginBottom: 12 }}>
          <div style={{ ...disp, fontWeight: 700, fontSize: 17 }}>{ex[lang === "nl" ? "nl" : "en"]}</div>
          <div onClick={onClose} style={{ cursor: "pointer", color: MUTED, fontSize: 17, width: 30, height: 30, display: "flex", alignItems: "center", justifyContent: "center", borderRadius: 9, border: `1px solid ${LINE}` }}>×</div>
        </div>
        <div style={{ height: 130, borderRadius: 12, background: "linear-gradient(135deg,#3a3242,#1b1620)", border: `1px dashed ${LINE}`, display: "flex", flexDirection: "column", alignItems: "center", justifyContent: "center", gap: 8, marginBottom: 12 }}>
          {ex.demo
            ? <img src={ex.demo} alt="" style={{ maxWidth: "100%", maxHeight: "100%", borderRadius: 10 }} />
            : <><div style={{ width: 46, height: 46, borderRadius: "50%", background: "rgba(var(--hf-ember-rgb),0.15)", display: "flex", alignItems: "center", justifyContent: "center", color: EMBER_SOFT, fontSize: 20 }}>▶</div><div style={{ fontSize: 11, color: MUTED }}>{demoLbl}</div></>}
        </div>
        <div style={{ ...disp, fontSize: 12, fontWeight: 600, textTransform: "uppercase", letterSpacing: 1.5, color: EMBER, marginBottom: 7 }}>{lang === "nl" ? "Zo werkt het" : "How it works"}</div>
        <div style={{ fontSize: 13.5, color: PAPER, opacity: 0.92, lineHeight: 1.6 }}>{how}</div>
      </div>
    </div>,
    document.body
  );
}

// Oefening-logboek: gewicht per set + afvinken, notitie (typen/spraak), eigen set-opname.
// Slaat lokaal op per dag + oefening; de laatste waarde komt terug als "vorige keer".
function ExerciseLog({ lang, item, dateKey, ex, onHow, onClose, onDone, t }) {
  const GREEN = "#58C27D";
  const exId = item.exId || item.name || "ex";
  const logKey = "hf_exlog_" + dateKey + "_" + exId;
  const lastKey = "hf_exlast_" + exId;
  const vidKey = logKey + "_vid";
  // Eenheid volgt het type: kracht = kg, afstand = m, tijd = min.
  const metric = item.metric || (ex && ex.metric) || "reps";
  const unit = metric === "dist" ? "m" : metric === "time" ? "min" : "kg";
  const step = metric === "dist" ? 50 : metric === "time" ? 1 : 2.5;
  const defVal = metric === "dist" ? (num(item.dist) || "") : metric === "time" ? (num(item.min) || "") : "";
  const nSets = Math.max(1, Math.min(10, num(item.sets) || (metric === "reps" ? 3 : 1)));
  const reps = metric === "reps" ? (num(item.reps) || null) : null;
  const lastW = num(load(lastKey, 0));
  const saved = load(logKey, null);
  const [sets, setSets] = useState(() => Array.from({ length: nSets }, (_, i) => {
    const s = saved && saved.sets && saved.sets[i];
    return { w: s && s.w != null ? s.w : (lastW || defVal || ""), done: !!(s && s.done) };
  }));
  const [note, setNote] = useState((saved && saved.note) || "");
  const [vidUrl, setVidUrl] = useState(null);
  const [listening, setListening] = useState(false);
  const fileRef = useRef(null);
  const recRef = useRef(null);
  const noteRef = useRef(null);

  useEffect(() => {
    let url;
    idbVideo("get", vidKey).then((blob) => { if (blob) { url = URL.createObjectURL(blob); setVidUrl(url); } });
    return () => { if (url) URL.revokeObjectURL(url); if (recRef.current) { try { recRef.current.stop(); } catch (e) {} } };
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);

  const fmtW = (v) => (v === "" || v == null ? "–" : String(v).replace(".", lang === "nl" ? "," : "."));
  const stepW = (i, dv) => setSets((prev) => prev.map((s, j) => j === i ? { ...s, w: Math.max(0, Math.round(((num(s.w) || 0) + dv) * 10) / 10) } : s));
  const setVal = (i, v) => setSets((prev) => prev.map((s, j) => j === i ? { ...s, w: v } : s));
  const toggleSet = (i) => setSets((prev) => prev.map((s, j) => j === i ? { ...s, done: !s.done } : s));

  const allDone = sets.length > 0 && sets.every((s) => s.done);
  const prevAll = useRef(allDone);
  const mountedRef = useRef(false);
  // Live opslaan: sets + notitie bij elke wijziging — niets gaat verloren als de sheet sluit.
  useEffect(() => {
    save(logKey, { sets: sets.map((s) => ({ w: num(s.w) || null, done: !!s.done })), note: note.trim() });
    const top = Math.max(0, ...sets.map((s) => num(s.w) || 0));
    if (top > 0) save(lastKey, top);
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [sets, note]);
  // Laatste set afgevinkt -> oefening klaar + sheet sluit vanzelf (alleen bij verse voltooiing).
  useEffect(() => {
    if (!mountedRef.current) { mountedRef.current = true; prevAll.current = allDone; return; }
    if (allDone && !prevAll.current) { prevAll.current = true; if (onDone) onDone(); onClose(); }
    else { prevAll.current = allDone; }
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [allDone]);

  function onFilm(e) {
    const f = e.target.files && e.target.files[0];
    if (!f) return;
    idbVideo("put", vidKey, f).then(() => { const u = URL.createObjectURL(f); setVidUrl(u); });
  }
  function removeClip() { idbVideo("del", vidKey).then(() => { if (vidUrl) URL.revokeObjectURL(vidUrl); setVidUrl(null); }); }

  function mic() {
    const SR = window.SpeechRecognition || window.webkitSpeechRecognition;
    if (!SR) { if (noteRef.current) noteRef.current.focus(); return; } // val terug op toetsenbord-mic
    if (listening) { try { recRef.current && recRef.current.stop(); } catch (e) {} setListening(false); return; }
    try {
      const r = new SR(); r.lang = lang === "nl" ? "nl-NL" : "en-US"; r.interimResults = false;
      r.onresult = (ev) => { const txt = Array.from(ev.results).map((x) => x[0].transcript).join(" "); setNote((n) => (n ? n + " " : "") + txt); };
      r.onend = () => setListening(false); r.onerror = () => setListening(false);
      recRef.current = r; setListening(true); r.start();
    } catch (e) { setListening(false); }
  }

  function doSave() {
    save(logKey, { sets: sets.map((s) => ({ w: num(s.w) || null, done: !!s.done })), note: note.trim() });
    const top = Math.max(0, ...sets.map((s) => num(s.w) || 0));
    if (top > 0) save(lastKey, top);
    onClose();
  }

  const field = { background: INK, border: `1px solid ${LINE}`, borderRadius: 12 };
  return createPortal(
    <div onClick={onClose} style={{ position: "fixed", inset: 0, background: "rgba(0,0,0,0.6)", backdropFilter: "blur(5px)", WebkitBackdropFilter: "blur(5px)", zIndex: 200, display: "flex", alignItems: "flex-end", justifyContent: "center" }}>
      <div onClick={(e) => e.stopPropagation()} className="hf-modal" style={{ width: "100%", maxWidth: 480, background: INK2, borderRadius: "22px 22px 0 0", padding: "16px 16px calc(20px + env(safe-area-inset-bottom))", maxHeight: "94vh", overflowY: "auto", boxShadow: "0 -10px 40px rgba(0,0,0,0.4)" }}>
        <div style={{ width: 40, height: 4, borderRadius: 2, background: LINE, margin: "0 auto 14px" }} />
        <div style={{ display: "flex", alignItems: "center", justifyContent: "space-between", marginBottom: 3 }}>
          <div style={{ ...disp, fontWeight: 700, fontSize: 21 }}>{item.name}</div>
          <div style={{ display: "flex", alignItems: "center", gap: 8 }}>
            {ex && ex.how && <div onClick={() => onHow(ex)} style={{ cursor: "pointer", color: EMBER, fontSize: 19 }}>ⓘ</div>}
            <div onClick={onClose} style={{ cursor: "pointer", color: MUTED, fontSize: 16, width: 30, height: 30, display: "flex", alignItems: "center", justifyContent: "center", borderRadius: 9, border: `1px solid ${LINE}` }}>×</div>
          </div>
        </div>
        <div style={{ fontSize: 12, color: MUTED, marginBottom: 12 }}>{setLabel(item) ? setLabel(item) + " · " : ""}~{item.kcal} kcal</div>
        {lastW > 0 && (
          <div style={{ display: "inline-flex", alignItems: "center", gap: 7, background: "rgba(var(--hf-ember-rgb),0.10)", border: "1px solid rgba(var(--hf-ember-rgb),0.28)", color: EMBER, borderRadius: 10, padding: "8px 12px", fontSize: 12, fontWeight: 600, marginBottom: 16 }}>↗ {t("logLast")} {fmtW(lastW)} {unit}</div>
        )}

        {/* VIDEO */}
        <div style={{ fontSize: 10, letterSpacing: 1.1, textTransform: "uppercase", color: MUTED, fontWeight: 700, marginBottom: 9 }}>{t("logVideo")}</div>
        <div style={{ display: "flex", gap: 10, marginBottom: 16 }}>
          <div onClick={() => ex && ex.how && onHow(ex)} className="hf-tap" style={{ ...field, flex: 1, display: "flex", alignItems: "center", gap: 9, padding: "11px 12px", cursor: "pointer" }}>
            <span style={{ width: 30, height: 30, borderRadius: "50%", background: "rgba(var(--hf-ember-rgb),0.12)", display: "flex", alignItems: "center", justifyContent: "center", color: EMBER, fontSize: 13 }}>▶</span>
            <div><div style={{ fontSize: 13, fontWeight: 600 }}>{t("logWatch")}</div><div style={{ fontSize: 10.5, color: MUTED }}>{t("logWatchSub")}</div></div>
          </div>
          <div onClick={() => fileRef.current && fileRef.current.click()} className="hf-tap" style={{ ...field, flex: 1, display: "flex", alignItems: "center", gap: 9, padding: "11px 12px", cursor: "pointer" }}>
            <span style={{ width: 30, height: 30, borderRadius: "50%", background: EMBER, display: "flex", alignItems: "center", justifyContent: "center" }}>
              <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="#fff" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><path d="M15 10l5-3v10l-5-3z" /><rect x="2" y="6" width="13" height="12" rx="2" /></svg>
            </span>
            <div><div style={{ fontSize: 13, fontWeight: 600 }}>{t("logFilm")}</div><div style={{ fontSize: 10.5, color: MUTED }}>{t("logFilmSub")}</div></div>
          </div>
          <input ref={fileRef} type="file" accept="video/*" capture="environment" onChange={onFilm} style={{ display: "none" }} />
        </div>
        {vidUrl && (
          <div style={{ marginBottom: 16 }}>
            <video src={vidUrl} controls playsInline style={{ width: "100%", borderRadius: 12, maxHeight: 220, background: "#000" }} />
            <div onClick={removeClip} style={{ cursor: "pointer", textAlign: "center", marginTop: 7, fontSize: 12, color: MUTED, fontWeight: 600 }}>{t("logRemoveClip")}</div>
          </div>
        )}

        {/* SETS */}
        <div style={{ fontSize: 10, letterSpacing: 1.1, textTransform: "uppercase", color: MUTED, fontWeight: 700, marginBottom: 9 }}>{lang === "nl" ? "Sets · " : "Sets · "}{unit === "kg" ? (lang === "nl" ? "gewicht" : "weight") : unit === "m" ? (lang === "nl" ? "afstand" : "distance") : (lang === "nl" ? "tijd" : "time")}</div>
        <div style={{ display: "flex", flexDirection: "column", gap: 8, marginBottom: 16 }}>
          {sets.map((s, i) => (
            <div key={i} style={{ ...field, display: "flex", alignItems: "center", gap: 10, padding: "9px 11px" }}>
              <div style={{ ...disp, fontWeight: 700, fontSize: 13, width: 44 }}>{"Set " + (i + 1)}</div>
              {reps && <div style={{ fontSize: 12, color: MUTED, width: 56 }}><b style={{ color: PAPER, ...disp, fontSize: 15 }}>{reps}</b> reps</div>}
              <div style={{ display: "flex", alignItems: "center", marginLeft: "auto", border: `1px solid ${LINE}`, borderRadius: 10, overflow: "hidden", background: INK2 }}>
                <div onClick={() => stepW(i, -step)} className="hf-tap" style={{ width: 34, height: 34, display: "flex", alignItems: "center", justifyContent: "center", fontSize: 20, color: EMBER, fontWeight: 700, cursor: "pointer" }}>−</div>
                <input value={s.w} onChange={(e) => setVal(i, e.target.value.replace(/[^0-9.,]/g, "").replace(",", "."))} inputMode="decimal" placeholder="–" style={{ width: 52, textAlign: "center", background: "transparent", border: "none", color: PAPER, ...disp, fontWeight: 700, fontSize: 15, outline: "none", padding: 0 }} />
                <span style={{ fontSize: 11, color: MUTED, fontWeight: 500, paddingRight: 6 }}>{unit}</span>
                <div onClick={() => stepW(i, step)} className="hf-tap" style={{ width: 34, height: 34, display: "flex", alignItems: "center", justifyContent: "center", fontSize: 20, color: EMBER, fontWeight: 700, cursor: "pointer" }}>+</div>
              </div>
              <div onClick={() => toggleSet(i)} className="hf-tap" style={{ cursor: "pointer", width: 26, height: 26, flexShrink: 0, borderRadius: "50%", border: `2px solid ${s.done ? GREEN : MUTED}`, background: s.done ? GREEN : "transparent", display: "flex", alignItems: "center", justifyContent: "center", color: "#fff", fontWeight: 800, fontSize: 13 }}>{s.done ? "✓" : ""}</div>
            </div>
          ))}
        </div>

        {/* NOTITIE */}
        <div style={{ fontSize: 10, letterSpacing: 1.1, textTransform: "uppercase", color: MUTED, fontWeight: 700, marginBottom: 9 }}>{t("logNote")}</div>
        <div style={{ position: "relative" }}>
          <textarea ref={noteRef} value={note} onChange={(e) => setNote(e.target.value)} placeholder={t("logNotePh")} style={{ ...field, width: "100%", minHeight: 88, padding: "12px 52px 12px 12px", color: PAPER, fontFamily: "Inter, sans-serif", fontSize: 13.5, lineHeight: 1.5, outline: "none", resize: "vertical", boxSizing: "border-box" }} />
          <div onClick={mic} style={{ position: "absolute", right: 10, bottom: 10, width: 40, height: 40, borderRadius: "50%", background: listening ? "var(--hf-ember-deep)" : EMBER, display: "flex", alignItems: "center", justifyContent: "center", cursor: "pointer", boxShadow: "0 6px 16px rgba(var(--hf-ember-rgb),0.35)" }}>
            <svg width="19" height="19" viewBox="0 0 24 24" fill="none" stroke="#fff" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><rect x="9" y="3" width="6" height="11" rx="3" /><path d="M5 11a7 7 0 0014 0M12 18v3" /></svg>
          </div>
        </div>
        <div style={{ fontSize: 11, color: MUTED, marginTop: 7 }}>{listening ? t("logListening") : t("logNoteHint")}</div>

        <div onClick={doSave} className="hf-tap" style={{ marginTop: 16, background: EMBER, color: "#fff", textAlign: "center", padding: "14px 0", borderRadius: 12, ...disp, fontWeight: 700, fontSize: 15, letterSpacing: 0.6, textTransform: "uppercase", cursor: "pointer" }}>{t("logSave")}</div>
      </div>
    </div>,
    document.body
  );
}

// Seconden -> klok (m:ss of u:mm:ss).
function fmtClock(sec) {
  sec = Math.max(0, Math.floor(sec));
  const h = Math.floor(sec / 3600), m = Math.floor((sec % 3600) / 60), s = sec % 60;
  const p = (n) => String(n).padStart(2, "0");
  return h > 0 ? h + ":" + p(m) + ":" + p(s) : m + ":" + p(s);
}

// Inline log-body in de sessie: uitleg + video + sets + notitie, alles op z'n plek (geen 2e scherm).
function SessionExLog({ lang, kg, item, dateKey, ex, t }) {
  const exId = item.exId || item.name || "ex";
  const logKey = "hf_exlog_" + dateKey + "_" + exId;
  const lastKey = "hf_exlast_" + exId;
  const vidKey = logKey + "_vid";
  const metric = item.metric || (ex && ex.metric) || "reps";
  const unit = metric === "dist" ? "m" : metric === "time" ? "min" : "kg";
  const step = metric === "dist" ? 50 : metric === "time" ? 1 : 2.5;
  const defVal = metric === "dist" ? (num(item.dist) || "") : metric === "time" ? (num(item.min) || "") : "";
  const nSets = Math.max(1, Math.min(10, num(item.sets) || (metric === "reps" ? 3 : 1)));
  const reps = metric === "reps" ? (num(item.reps) || null) : null;
  const lastW = num(load(lastKey, 0));
  const saved = load(logKey, null);
  const [sets, setSets] = useState(() => Array.from({ length: nSets }, (_, i) => {
    const s = saved && saved.sets && saved.sets[i];
    return { w: s && s.w != null ? s.w : (lastW || defVal || "") };
  }));
  const [note, setNote] = useState((saved && saved.note) || "");
  const [vidUrl, setVidUrl] = useState(null);
  const [listening, setListening] = useState(false);
  const fileRef = useRef(null), recRef = useRef(null), noteRef = useRef(null), baseRef = useRef("");
  const how = ex && ex.how ? ex.how[lang === "nl" ? "nl" : "en"] : "";
  const demo = ex && ex.demo ? ex.demo : null;

  useEffect(() => {
    let url;
    idbVideo("get", vidKey).then((blob) => { if (blob) { url = URL.createObjectURL(blob); setVidUrl(url); } });
    return () => {
      if (url) URL.revokeObjectURL(url);
      if (recRef.current) { try { recRef.current.stop(); } catch (e) {} }
      try { if (window.Capacitor && window.Capacitor.isNativePlatform && window.Capacitor.isNativePlatform()) import("@capacitor-community/speech-recognition").then(({ SpeechRecognition }) => { SpeechRecognition.stop().catch(() => {}); SpeechRecognition.removeAllListeners().catch(() => {}); }).catch(() => {}); } catch (e) {}
    };
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);
  // Live opslaan.
  useEffect(() => {
    save(logKey, { sets: sets.map((s) => ({ w: num(s.w) || null })), note: note.trim() });
    const top = Math.max(0, ...sets.map((s) => num(s.w) || 0));
    if (top > 0) save(lastKey, top);
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [sets, note]);

  const fmtW = (v) => (v === "" || v == null ? "–" : String(v).replace(".", lang === "nl" ? "," : "."));
  const stepW = (i, dv) => setSets((prev) => prev.map((s, j) => j === i ? { w: Math.max(0, Math.round(((num(s.w) || 0) + dv) * 10) / 10) } : s));
  const setVal = (i, v) => setSets((prev) => prev.map((s, j) => j === i ? { w: v } : s));
  function onFilm(e) { const f = e.target.files && e.target.files[0]; if (!f) return; idbVideo("put", vidKey, f).then(() => { const u = URL.createObjectURL(f); setVidUrl(u); }); }
  function removeClip() { idbVideo("del", vidKey).then(() => { if (vidUrl) URL.revokeObjectURL(vidUrl); setVidUrl(null); }); }
  async function micNativeStart() {
    const { SpeechRecognition } = await import("@capacitor-community/speech-recognition");
    try { await SpeechRecognition.requestPermissions(); } catch (e) {}
    try { await SpeechRecognition.removeAllListeners(); } catch (e) {}
    baseRef.current = note;
    await SpeechRecognition.addListener("partialResults", (data) => {
      const m = data && data.matches && data.matches[0];
      if (m != null) setNote((baseRef.current ? baseRef.current + " " : "") + m);
    });
    await SpeechRecognition.start({ language: lang === "nl" ? "nl-NL" : "en-US", partialResults: true, popup: false });
    setListening(true);
  }
  async function micNativeStop() {
    try { const { SpeechRecognition } = await import("@capacitor-community/speech-recognition"); await SpeechRecognition.stop(); await SpeechRecognition.removeAllListeners(); } catch (e) {}
    setListening(false);
  }
  function mic() {
    const native = !!(window.Capacitor && window.Capacitor.isNativePlatform && window.Capacitor.isNativePlatform());
    if (native) {
      if (listening) micNativeStop();
      else micNativeStart().catch(() => { setListening(false); if (noteRef.current) noteRef.current.focus(); });
      return;
    }
    const SR = window.SpeechRecognition || window.webkitSpeechRecognition;
    if (!SR) { if (noteRef.current) noteRef.current.focus(); return; }
    if (listening) { try { recRef.current && recRef.current.stop(); } catch (e) {} setListening(false); return; }
    try {
      const r = new SR(); r.lang = lang === "nl" ? "nl-NL" : "en-US"; r.interimResults = false;
      r.onresult = (ev) => { const txt = Array.from(ev.results).map((x) => x[0].transcript).join(" "); setNote((n) => (n ? n + " " : "") + txt); };
      r.onend = () => setListening(false); r.onerror = () => setListening(false);
      recRef.current = r; setListening(true); r.start();
    } catch (e) { setListening(false); }
  }

  const field = { background: INK, border: `1px solid ${LINE}`, borderRadius: 11 };
  const lbl = { fontSize: 9.5, letterSpacing: 1, textTransform: "uppercase", color: MUTED, fontWeight: 700, margin: "14px 0 8px" };
  return (
    <div style={{ padding: "4px 2px 2px" }}>
      {lastW > 0 && (
        <div style={{ display: "inline-flex", alignItems: "center", gap: 7, background: "rgba(var(--hf-ember-rgb),0.10)", border: "1px solid rgba(var(--hf-ember-rgb),0.28)", color: EMBER, borderRadius: 10, padding: "7px 11px", fontSize: 11.5, fontWeight: 600 }}>↗ {t("logLast")} {fmtW(lastW)} {unit}</div>
      )}
      {how && <><div style={lbl}>{lang === "nl" ? "Zo werkt het" : "How it works"}</div><div style={{ fontSize: 13, color: PAPER, opacity: 0.9, lineHeight: 1.55 }}>{how}</div></>}
      {demo && <video src={demo} controls playsInline style={{ width: "100%", borderRadius: 11, maxHeight: 200, background: "#000", marginTop: 10 }} />}

      <div style={lbl}>{lang === "nl" ? "Je eigen opname" : "Your recording"}</div>
      <div onClick={() => fileRef.current && fileRef.current.click()} className="hf-tap" style={{ ...field, display: "flex", alignItems: "center", gap: 9, padding: "10px 12px", cursor: "pointer" }}>
        <span style={{ width: 30, height: 30, borderRadius: "50%", background: EMBER, display: "flex", alignItems: "center", justifyContent: "center", flexShrink: 0 }}>
          <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="#fff" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><path d="M15 10l5-3v10l-5-3z" /><rect x="2" y="6" width="13" height="12" rx="2" /></svg>
        </span>
        <div><div style={{ fontSize: 13, fontWeight: 600, color: PAPER }}>{t("logFilm")}</div><div style={{ fontSize: 10.5, color: MUTED }}>{t("logFilmSub")}</div></div>
      </div>
      <input ref={fileRef} type="file" accept="video/*" capture="environment" onChange={onFilm} style={{ display: "none" }} />
      {vidUrl && (
        <div style={{ marginTop: 10 }}>
          <video src={vidUrl} controls playsInline style={{ width: "100%", borderRadius: 11, maxHeight: 200, background: "#000" }} />
          <div onClick={removeClip} style={{ cursor: "pointer", textAlign: "center", marginTop: 6, fontSize: 12, color: MUTED, fontWeight: 600 }}>{t("logRemoveClip")}</div>
        </div>
      )}

      <div style={lbl}>{lang === "nl" ? "Sets · " : "Sets · "}{unit === "kg" ? (lang === "nl" ? "gewicht" : "weight") : unit === "m" ? (lang === "nl" ? "afstand" : "distance") : (lang === "nl" ? "tijd" : "time")}</div>
      <div style={{ display: "flex", flexDirection: "column", gap: 7 }}>
        {sets.map((s, i) => (
          <div key={i} style={{ ...field, display: "flex", alignItems: "center", gap: 10, padding: "8px 11px" }}>
            <div style={{ ...disp, fontWeight: 700, fontSize: 13, width: 44 }}>{"Set " + (i + 1)}</div>
            {reps && <div style={{ fontSize: 12, color: MUTED, width: 56 }}><b style={{ color: PAPER, ...disp, fontSize: 15 }}>{reps}</b> reps</div>}
            <div style={{ display: "flex", alignItems: "center", marginLeft: "auto", border: `1px solid ${LINE}`, borderRadius: 10, overflow: "hidden", background: INK2 }}>
              <div onClick={() => stepW(i, -step)} className="hf-tap" style={{ width: 34, height: 34, display: "flex", alignItems: "center", justifyContent: "center", fontSize: 20, color: EMBER, fontWeight: 700, cursor: "pointer" }}>−</div>
              <input value={s.w} onChange={(e) => setVal(i, e.target.value.replace(/[^0-9.,]/g, "").replace(",", "."))} inputMode="decimal" placeholder="–" style={{ width: 52, textAlign: "center", background: "transparent", border: "none", color: PAPER, ...disp, fontWeight: 700, fontSize: 15, outline: "none", padding: 0 }} />
              <span style={{ fontSize: 11, color: MUTED, fontWeight: 500, paddingRight: 6 }}>{unit}</span>
              <div onClick={() => stepW(i, step)} className="hf-tap" style={{ width: 34, height: 34, display: "flex", alignItems: "center", justifyContent: "center", fontSize: 20, color: EMBER, fontWeight: 700, cursor: "pointer" }}>+</div>
            </div>
          </div>
        ))}
      </div>

      <div style={lbl}>{t("logNote")}</div>
      <div style={{ position: "relative" }}>
        <textarea ref={noteRef} value={note} onChange={(e) => setNote(e.target.value)} placeholder={t("logNotePh")} style={{ ...field, width: "100%", minHeight: 72, padding: "11px 50px 11px 12px", color: PAPER, fontFamily: "Inter, sans-serif", fontSize: 13.5, lineHeight: 1.5, outline: "none", resize: "vertical", boxSizing: "border-box" }} />
        <div onClick={mic} style={{ position: "absolute", right: 9, bottom: 9, width: 38, height: 38, borderRadius: "50%", background: listening ? "var(--hf-ember-deep)" : EMBER, display: "flex", alignItems: "center", justifyContent: "center", cursor: "pointer", boxShadow: "0 6px 16px rgba(var(--hf-ember-rgb),0.35)" }}>
          <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#fff" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><rect x="9" y="3" width="6" height="11" rx="3" /><path d="M5 11a7 7 0 0014 0M12 18v3" /></svg>
        </div>
      </div>
      <div style={{ fontSize: 11, color: MUTED, marginTop: 6 }}>{listening ? t("logListening") : t("logNoteHint")}</div>
    </div>
  );
}

// Begeleide sessie: lopende klok, inline uitklap per oefening, afvinken=1 tik, splittijden, streefduur/auto-door.
function SessionRunner({ lang, kg, items, checked, toggle, exOf, onFinish, onClose, dateKey, t }) {
  const GREEN = "#58C27D";
  const total = items.length;
  const doneCount = items.filter((_, i) => checked.includes(i)).length;
  const pct = total ? Math.round((doneCount / total) * 100) : 0;
  const curIdx = items.findIndex((_, i) => !checked.includes(i));

  // Lopende klok (per dag, overleeft heropenen).
  const clockKey = "hf_sessclock_" + dateKey;
  const clockRef = useRef(null);
  if (!clockRef.current) { const saved = load(clockKey, null); clockRef.current = saved && saved.start ? saved : { start: Date.now(), acc: 0, running: true }; }
  const [nowTick, setNowTick] = useState(Date.now());
  useEffect(() => { if (!load(clockKey, null)) save(clockKey, clockRef.current); const iv = setInterval(() => setNowTick(Date.now()), 1000); return () => clearInterval(iv); }, []);
  const c = clockRef.current;
  const elapsed = Math.floor(c.acc + (c.running ? (nowTick - c.start) / 1000 : 0));
  function togglePause() { const cc = clockRef.current; if (cc.running) { cc.acc += (Date.now() - cc.start) / 1000; cc.running = false; } else { cc.start = Date.now(); cc.running = true; } save(clockKey, cc); setNowTick(Date.now()); }

  // Splittijden (cumulatieve elapsed op moment van afvinken), per index.
  const [splits, setSplits] = useState(() => load("hf_sesssplits_" + dateKey, {}));
  const segStart = Object.values(splits).reduce((a, v) => Math.max(a, v || 0), 0);
  const segElapsed = Math.max(0, elapsed - segStart);

  // Streefduur / auto-door.
  const [cfg, setCfg] = useState(() => load("hf_timercfg", { mode: "off", auto: false }));
  function saveCfg(next) { setCfg(next); save("hf_timercfg", next); }
  const curItem = curIdx >= 0 ? items[curIdx] : null;
  const curTarget = curItem ? num(curItem.min) * 60 : 0;
  const remaining = cfg.mode === "per" && curTarget > 0 ? Math.max(0, curTarget - segElapsed) : 0;
  const sessTarget = items.reduce((a, x) => a + num(x.min), 0) * 60;

  const [openIdx, setOpenIdx] = useState(curIdx >= 0 ? curIdx : 0);
  const autoRef = useRef(-1);

  function complete(i) {
    const isOn = checked.includes(i);
    toggle(i, items[i]);
    const next = { ...splits };
    if (!isOn) next[i] = elapsed; else delete next[i];
    setSplits(next); save("hf_sesssplits_" + dateKey, next);
    if (!isOn) { const ni = items.findIndex((_, k) => k > i && !checked.includes(k)); setOpenIdx(ni >= 0 ? ni : -1); }
  }
  // Auto-door: bij per-oefening streefduur op 0 vanzelf naar de volgende.
  useEffect(() => {
    if (cfg.mode === "per" && cfg.auto && curIdx >= 0 && curTarget > 0 && segElapsed >= curTarget && autoRef.current !== curIdx) {
      autoRef.current = curIdx; complete(curIdx);
    }
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [elapsed]);

  const seg = (lblTxt, val, active) => (
    <div onClick={() => saveCfg({ ...cfg, mode: val })} style={{ cursor: "pointer", flex: 1, textAlign: "center", fontSize: 11.5, fontWeight: 700, ...disp, padding: "6px 0", borderRadius: 7, background: active ? EMBER : "transparent", color: active ? "#fff" : MUTED }}>{lblTxt}</div>
  );

  return createPortal(
    <div style={{ position: "fixed", inset: 0, background: "linear-gradient(180deg,#2c121b 0%,#200e15 48%,#180b10 100%)", zIndex: 999, overflowY: "auto" }}>
      <div style={{ maxWidth: 480, margin: "0 auto", padding: "calc(16px + env(safe-area-inset-top)) 16px calc(20px + env(safe-area-inset-bottom))" }}>
        <div style={{ display: "flex", justifyContent: "flex-end", marginBottom: 6 }}>
          <div onClick={onClose} style={{ cursor: "pointer", color: MUTED, fontSize: 18, width: 34, height: 34, display: "flex", alignItems: "center", justifyContent: "center", borderRadius: 9, border: `1px solid ${LINE}` }}>×</div>
        </div>
        {/* HEADER met lopende klok */}
        <div style={{ background: `linear-gradient(135deg, ${EMBER}, var(--hf-ember-deep))`, borderRadius: 16, padding: "15px 16px 16px", marginBottom: 12, color: "#fff" }}>
          <div style={{ display: "flex", justifyContent: "space-between", alignItems: "flex-start" }}>
            <div>
              <div style={{ ...disp, fontWeight: 700, fontSize: 32, letterSpacing: 1, lineHeight: 1 }}>{fmtClock(elapsed)}</div>
              <div style={{ fontSize: 10, opacity: 0.9, marginTop: 4, textTransform: "uppercase", letterSpacing: 1 }}>{c.running ? (lang === "nl" ? "Totale tijd loopt" : "Total time running") : (lang === "nl" ? "Gepauzeerd" : "Paused")}{cfg.mode === "session" ? " · " + (lang === "nl" ? "doel " : "goal ") + fmtClock(sessTarget) : ""}</div>
            </div>
            <div style={{ textAlign: "right" }}>
              <div style={{ ...disp, fontWeight: 700, fontSize: 24 }}>{doneCount}/{total}</div>
              <div onClick={togglePause} className="hf-tap" style={{ cursor: "pointer", marginTop: 6, display: "inline-flex", alignItems: "center", gap: 5, background: "rgba(255,255,255,0.16)", border: "1px solid rgba(255,255,255,0.3)", borderRadius: 8, padding: "5px 10px", fontSize: 12, fontWeight: 700, ...disp }}>{c.running ? "⏸ " + (lang === "nl" ? "Pauze" : "Pause") : "▶ " + (lang === "nl" ? "Verder" : "Resume")}</div>
            </div>
          </div>
          <div style={{ height: 6, borderRadius: 4, background: "rgba(255,255,255,0.22)", overflow: "hidden", marginTop: 12 }}><div style={{ height: "100%", width: pct + "%", background: "#fff", borderRadius: 4, transition: "width .25s" }} /></div>
        </div>

        {/* STREEFDUUR + AUTO-DOOR */}
        <div style={{ background: INK2, border: `1px solid ${LINE}`, borderRadius: 12, padding: "9px 11px", marginBottom: 14 }}>
          <div style={{ display: "flex", alignItems: "center", gap: 10 }}>
            <div style={{ fontSize: 10, letterSpacing: 0.6, textTransform: "uppercase", color: MUTED, fontWeight: 700, flexShrink: 0 }}>{lang === "nl" ? "Streefduur" : "Target"}</div>
            <div style={{ display: "flex", flex: 1, background: INK, borderRadius: 8, padding: 3 }}>
              {seg(lang === "nl" ? "Uit" : "Off", "off", cfg.mode === "off")}
              {seg(lang === "nl" ? "Per oef." : "Per ex.", "per", cfg.mode === "per")}
              {seg(lang === "nl" ? "Sessie" : "Session", "session", cfg.mode === "session")}
            </div>
          </div>
          {cfg.mode === "per" && (
            <div onClick={() => saveCfg({ ...cfg, auto: !cfg.auto })} className="hf-tap" style={{ cursor: "pointer", display: "flex", alignItems: "center", gap: 10, marginTop: 10 }}>
              <div style={{ width: 40, height: 23, borderRadius: 12, background: cfg.auto ? EMBER : "#3a2a2e", position: "relative", flexShrink: 0, transition: "background .15s" }}><div style={{ position: "absolute", top: 2, left: cfg.auto ? 19 : 2, width: 19, height: 19, borderRadius: "50%", background: "#fff", transition: "left .15s" }} /></div>
              <div><div style={{ fontSize: 12.5, fontWeight: 600, color: PAPER }}>{lang === "nl" ? "Auto door" : "Auto advance"}</div><div style={{ fontSize: 10.5, color: MUTED }}>{lang === "nl" ? "Volgende als de tijd op is" : "Next when time is up"}</div></div>
            </div>
          )}
        </div>

        {/* OEFENINGEN met inline uitklap */}
        <div style={{ display: "grid", gap: 9, marginBottom: 14 }}>
          {items.map((x, i) => {
            const on = checked.includes(i);
            const cur = i === curIdx;
            const open = openIdx === i;
            const ex = exOf(x);
            const splitSorted = Object.entries(splits).map(([k, v]) => ({ k: Number(k), v })).sort((a, b) => a.v - b.v);
            const myRank = splitSorted.findIndex((e) => e.k === i);
            const mySplit = myRank >= 0 ? splits[i] - (myRank > 0 ? splitSorted[myRank - 1].v : 0) : 0;
            return (
              <div key={i} style={{ background: INK2, borderRadius: 14, border: `1px ${on ? "solid " + GREEN : cur ? "solid " + EMBER : "dashed " + SAGE}`, boxShadow: cur && !on ? "0 0 22px rgba(var(--hf-ember-rgb),0.18)" : "none", overflow: "hidden" }}>
                <div style={{ display: "flex", alignItems: "center", gap: 12, padding: 12 }}>
                  <div onClick={() => complete(i)} className="hf-tap" style={{ cursor: "pointer", width: 28, height: 28, flexShrink: 0, borderRadius: "50%", border: `2px solid ${on ? GREEN : cur ? EMBER : MUTED}`, background: on ? GREEN : "transparent", display: "flex", alignItems: "center", justifyContent: "center", color: on ? "#0A0A0A" : EMBER, fontSize: 14, fontWeight: 800 }}>{on ? "✓" : cur ? "▶" : ""}</div>
                  <div onClick={() => setOpenIdx(open ? -1 : i)} className="hf-tap" style={{ flex: 1, minWidth: 0, cursor: "pointer", borderRadius: 10, padding: "2px 4px", margin: "-2px -4px" }}>
                    <div style={{ fontSize: 14.5, fontWeight: 600, color: on ? MUTED : PAPER, textDecoration: on ? "line-through" : "none" }}>{x.name}</div>
                    <div style={{ fontSize: 11.5, color: MUTED, marginTop: 3 }}>
                      {setLabel(x) ? setLabel(x) + " · " : ""}{x.min} {t("min")} · ~{x.kcal} kcal
                      {cur && !on && cfg.mode === "per" && curTarget > 0 && <span style={{ color: EMBER_SOFT, fontWeight: 700 }}> · {lang === "nl" ? "nog" : "left"} {fmtClock(remaining)}</span>}
                    </div>
                  </div>
                  {on && mySplit > 0 ? <div style={{ ...disp, fontWeight: 700, fontSize: 14, color: GREEN, flexShrink: 0 }}>{fmtClock(mySplit)}</div>
                    : <div onClick={() => setOpenIdx(open ? -1 : i)} style={{ cursor: "pointer", color: EMBER_SOFT, fontSize: 17, width: 26, textAlign: "center", flexShrink: 0, transform: open ? "rotate(180deg)" : "none", transition: "transform .15s" }}>{ex && ex.how ? "ⓘ" : "⌄"}</div>}
                </div>
                {open && <div style={{ padding: "0 12px 12px", borderTop: `1px solid ${LINE}` }}><SessionExLog lang={lang} kg={kg} item={x} dateKey={dateKey} ex={ex} t={t} /></div>}
              </div>
            );
          })}
        </div>

        <div onClick={() => onFinish(items, { time: elapsed, splits })} className="hf-tap" style={{ cursor: "pointer", textAlign: "center", background: "transparent", border: `1px solid ${EMBER}`, color: EMBER, padding: "14px 0", borderRadius: 12, ...disp, fontWeight: 700, fontSize: 15, letterSpacing: 0.8, textTransform: "uppercase" }}>{t("finishSession")}</div>
      </div>
    </div>,
    document.body
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
  return createPortal(
    <div style={{ position: "fixed", inset: 0, background: "linear-gradient(180deg,#2c121b 0%,#200e15 48%,#180b10 100%)", zIndex: 1000, overflowY: "auto" }}>
      <div style={{ maxWidth: 440, margin: "0 auto", padding: "calc(40px + env(safe-area-inset-top)) 20px 40px", textAlign: "center" }}>
        <div style={{ width: 84, height: 84, borderRadius: "50%", background: "rgba(88,194,125,0.14)", border: "2px solid #58C27D", display: "flex", alignItems: "center", justifyContent: "center", margin: "14px auto 16px", fontSize: 40 }}>🏆</div>
        <div style={{ ...disp, fontWeight: 700, fontSize: 24 }}>{t("sessionDone")}</div>
        <div style={{ fontSize: 13, color: MUTED, margin: "6px 0 20px", lineHeight: 1.5 }}>{t("sessionDoneSub")}</div>
        <div style={{ display: "grid", gridTemplateColumns: data.km > 0 ? "1fr 1fr 1fr 1fr" : "1fr 1fr 1fr", gap: 10, marginBottom: 16 }}>
          {data.sec > 0 && stat(fmtClock(data.sec), t("timeN"))}
          {!(data.sec > 0) && stat(data.exercises, t("exercisesN"))}
          {stat("~" + data.kcal, "kcal")}
          {data.km > 0 ? stat(data.km, "km") : stat(data.min, t("minutesN"))}
          {data.sec > 0 && (data.km > 0 ? stat(data.km, "km") : stat(data.exercises, t("exercisesN")))}
        </div>
        {(() => {
          const sp = data.splits || {}; const its = data.items || [];
          const rows = Object.entries(sp).map(([k, v]) => ({ k: Number(k), v })).sort((a, b) => a.v - b.v);
          if (rows.length === 0) return null;
          return (
            <div style={{ textAlign: "left", marginBottom: 20 }}>
              <div style={{ fontSize: 10, letterSpacing: 1, textTransform: "uppercase", color: MUTED, fontWeight: 700, marginBottom: 8 }}>{lang === "nl" ? "Splittijden" : "Splits"}</div>
              <div style={{ background: INK2, border: `1px solid ${LINE}`, borderRadius: 12, overflow: "hidden" }}>
                {rows.map((r, idx) => {
                  const delta = r.v - (idx > 0 ? rows[idx - 1].v : 0);
                  const it = its[r.k];
                  return (
                    <div key={r.k} style={{ display: "flex", alignItems: "center", gap: 10, padding: "9px 13px", borderTop: idx > 0 ? `1px solid ${LINE}` : "none" }}>
                      <div style={{ ...disp, fontWeight: 700, fontSize: 11, color: MUTED, width: 18 }}>{idx + 1}</div>
                      <div style={{ flex: 1, minWidth: 0, fontSize: 12.5, color: PAPER, fontWeight: 500, whiteSpace: "nowrap", overflow: "hidden", textOverflow: "ellipsis" }}>{it ? it.name : "—"}</div>
                      <div style={{ ...disp, fontWeight: 700, fontSize: 14, color: PAPER }}>{fmtClock(delta)}</div>
                    </div>
                  );
                })}
              </div>
            </div>
          );
        })()}
        <div onClick={onClose} className="hf-tap" style={{ cursor: "pointer", textAlign: "center", background: EMBER, color: "#fff", padding: "15px 0", borderRadius: 12, ...disp, fontWeight: 700, fontSize: 16, letterSpacing: 0.8, textTransform: "uppercase" }}>{t("backToday")}</div>
        <div onClick={onUndo} className="hf-tap" style={{ cursor: "pointer", textAlign: "center", background: "transparent", border: `1px solid ${LINE}`, color: MUTED, padding: "13px 0", borderRadius: 12, ...disp, fontWeight: 700, fontSize: 14, marginTop: 9 }}>{t("undoAll")}</div>
      </div>
    </div>,
    document.body
  );
}

// Prestaties-tab: levensloop-stats + medailles met niveaus.
function Prestaties({ lang, sessions }) {
  const t = (nl, en) => (lang === "nl" ? nl : en);
  // Bron: alle gelogde trainingen (kcal/min/sessies/reeks). Km uit sessie-records
  // (die hebben afstand; losse logs nog niet), bij elkaar opgeteld.
  const wrecs = gatherWorkoutRecords();
  const wtot = aggregate(wrecs);
  const sessKm = (Array.isArray(sessions) ? sessions : []).reduce((a, s) => a + (Number(s.km) || 0), 0);
  const hasAny = wrecs.length > 0 || (Array.isArray(sessions) && sessions.length > 0);
  const totals = { ...wtot, km: Math.round((wtot.km + sessKm) * 10) / 10 };
  const TN = TIER_NAMES[lang === "nl" ? "nl" : "en"];
  const nf = (n) => n.toLocaleString(lang === "nl" ? "nl-NL" : "en-US");
  const statTile = (v, unit, l) => (
    <div style={{ background: INK2, border: `1px solid ${LINE}`, borderLeft: `3px solid ${EMBER}`, borderRadius: 14, padding: 14, boxShadow: SHADOW }}>
      <div style={{ ...disp, fontWeight: 700, fontSize: 26, color: PAPER, lineHeight: 1 }}>{v}<span style={{ fontSize: 13, color: MUTED, marginLeft: 4 }}>{unit}</span></div>
      <div style={{ fontSize: 10.5, letterSpacing: 0.5, textTransform: "uppercase", color: MUTED, marginTop: 6, fontWeight: 600 }}>{l}</div>
    </div>
  );
  if (!hasAny) {
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
        const col = earned ? EMBER : MUTED; // binnen de huiskleuren: behaald = rood, op slot = grijs
        const unit = lang === "nl" ? m.unitNl : m.unitEn;
        return (
          <div key={m.key} style={{ background: INK2, border: `1px solid ${LINE}`, borderRadius: 14, padding: "13px 14px", marginBottom: 10, display: "flex", gap: 13, alignItems: "center", boxShadow: SHADOW }}>
            <div style={{ width: 46, height: 46, borderRadius: "50%", flexShrink: 0, display: "flex", alignItems: "center", justifyContent: "center", border: `1.5px solid ${LINE}`, background: TRACK }}>
              {medalIcon(m.key, MUTED)}
            </div>
            <div style={{ flex: 1, minWidth: 0 }}>
              <div style={{ display: "flex", justifyContent: "space-between", alignItems: "center" }}>
                <span style={{ ...disp, fontWeight: 700, fontSize: 15 }}>{lang === "nl" ? m.nl : m.en}</span>
                <span style={{ fontSize: 10, fontWeight: 700, letterSpacing: 0.5, textTransform: "uppercase", padding: "3px 8px", borderRadius: 5, background: earned ? "rgba(var(--hf-ember-rgb),0.12)" : "transparent", border: earned ? "none" : `1px solid ${LINE}`, color: earned ? EMBER : MUTED }}>{earned ? TN[st.level] : (lang === "nl" ? "Op slot" : "Locked")}</span>
              </div>
              <div style={{ height: 6, borderRadius: 4, background: TRACK, overflow: "hidden", margin: "8px 0 5px" }}><div style={{ height: "100%", width: Math.max(3, Math.round(st.progress * 100)) + "%", borderRadius: 4, background: EMBER }} /></div>
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
