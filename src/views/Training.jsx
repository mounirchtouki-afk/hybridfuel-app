import React, { useState, useEffect, useRef } from "react";
import { INK, INK2, EMBER, EMBER_SOFT, PAPER, MUTED, LINE, SAGE, disp, num, load, save, todayISO, label, sectionTitle, WD, jsDayToIdx } from "../shared.js";
import { EXERCISES, WORKOUT_CATS, INTENSITY, kcalFor } from "../workouts.js";
import { Dropdown } from "../ui.jsx";

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
  toDate: { nl: "→ datum", en: "→ date" },
};

const isoAdd = (iso, n) => { const dt = new Date(iso + "T12:00:00"); dt.setDate(dt.getDate() + n); return dt.toISOString().slice(0, 10); };
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
  const d = todayISO();
  const kg = bodyKg(weight);
  const [tab, setTab] = useState("today");
  const [list, setList] = useState(() => load("hf_workouts_" + d, []));
  const [plan, setPlan] = useState(loadPlan);
  const [planAdd, setPlanAdd] = useState(null);
  const [move, setMove] = useState(null);

  // Vandaag loggen
  const [adding, setAdding] = useState(false);
  const [chosen, setChosen] = useState(null); // {name, met}
  const [mins, setMins] = useState("");
  const [kcalEdit, setKcalEdit] = useState(null);
  const [run, setRun] = useState(() => load("hf_workout_running", null));
  const [, tickState] = useState(0);
  const iv = useRef(null);

  useEffect(() => { setList(load("hf_workouts_" + d, [])); setPlan(loadPlan()); }, [d]);
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
  const tabBtn = (id, lbl) => <div onClick={() => setTab(id)} style={{ flex: 1, textAlign: "center", cursor: "pointer", padding: "9px 0", borderRadius: 8, background: tab === id ? EMBER : "transparent", color: PAPER, fontSize: 13.5, fontWeight: 700, ...disp, letterSpacing: 0.5 }}>{lbl}</div>;
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
            <div key={e.id} onClick={() => onPick({ name: e[lang], met: e.met })} style={{ display: "flex", justifyContent: "space-between", alignItems: "center", padding: "10px 14px 10px 24px", cursor: "pointer", borderTop: `1px solid ${LINE}` }}>
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
            <div onClick={() => { if (!nm.trim()) return; onPick({ name: nm.trim(), met: num(intens), cat }); }} style={{ cursor: "pointer", flex: 1, textAlign: "center", background: EMBER, color: PAPER, padding: "11px 0", borderRadius: 9, ...disp, fontWeight: 700, fontSize: 14 }}>{t("addCustom")}</div>
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
    const kc = ch ? kcalFor(ch.met, kg, num(mn)) : 0;
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
              <label style={label}>{t("minutes")}</label>
              <input value={mn} onChange={(e) => setMn(e.target.value.replace(/[^0-9]/g, ""))} inputMode="numeric" placeholder="20" style={{ ...sIn, marginBottom: 10 }} />
              <div style={{ fontSize: 12, color: MUTED, marginBottom: 14 }}>{t("estBurn")}: <span style={{ color: EMBER_SOFT, fontWeight: 700 }}>~{kc} kcal</span></div>
              <div style={{ display: "flex", gap: 10 }}>
                <div onClick={onClose} style={{ cursor: "pointer", padding: "11px 16px", borderRadius: 9, border: `1px solid ${LINE}`, color: MUTED, fontSize: 13, fontWeight: 700, ...disp }}>{t("cancel")}</div>
                <div onClick={() => { if (num(mn) <= 0) return; addToDay(di, { id: "p" + Date.now(), name: ch.name, met: ch.met, min: num(mn), kcal: kc }); onClose(); }} style={{ cursor: "pointer", flex: 1, textAlign: "center", background: EMBER, color: PAPER, padding: "11px 0", borderRadius: 9, ...disp, fontWeight: 700, fontSize: 14 }}>{t("save")}</div>
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
      </div>

      {tab === "today" && (
        <>
          <div style={{ background: `linear-gradient(135deg, ${EMBER}, #9f1239)`, borderRadius: 16, padding: "18px", marginBottom: 14, color: PAPER }}>
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

          {plannedToday.length > 0 && (
            <div style={{ marginBottom: 16 }}>
              <div style={{ ...label, marginBottom: 8 }}>{t("planned")}</div>
              <div style={{ display: "grid", gap: 8 }}>
                {plannedToday.map((x, i) => (
                  <div key={i} style={{ display: "flex", justifyContent: "space-between", alignItems: "center", background: INK2, border: `1px dashed ${SAGE}`, borderRadius: 12, padding: "11px 14px" }}>
                    <div><div style={{ fontSize: 14, fontWeight: 600, color: PAPER }}>{x.name}</div><div style={{ fontSize: 11, color: MUTED, marginTop: 2 }}>{x.min} {t("min")} · ~{x.kcal} kcal</div></div>
                    <div onClick={() => logPlanned(x)} style={{ cursor: "pointer", fontSize: 12, color: EMBER, fontWeight: 700, border: `1px solid ${EMBER}`, borderRadius: 8, padding: "6px 12px", ...disp }}>{t("logIt")}</div>
                  </div>
                ))}
              </div>
            </div>
          )}

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
                    {!run ? <div onClick={startTimer} style={{ cursor: "pointer", flex: 1, textAlign: "center", background: EMBER, color: PAPER, padding: "11px 0", borderRadius: 9, ...disp, fontWeight: 700 }}>▶ {t("start")}</div>
                      : <><div style={{ ...disp, fontSize: 26, fontWeight: 700, color: EMBER_SOFT, minWidth: 92 }}>{mmss(Date.now() - run.start)}</div><div onClick={stopTimer} style={{ cursor: "pointer", flex: 1, textAlign: "center", background: INK, border: `1px solid ${EMBER}`, color: EMBER, padding: "11px 0", borderRadius: 9, ...disp, fontWeight: 700 }}>■ {t("stop")}</div></>}
                  </div>
                  {!run && <div style={{ marginBottom: 12 }}><label style={label}>{t("minutes")}</label><input value={mins} onChange={(e) => { setMins(e.target.value.replace(/[^0-9]/g, "")); setKcalEdit(null); }} inputMode="numeric" placeholder="15" style={sIn} /></div>}
                  <div style={{ marginBottom: 14 }}>
                    <label style={label}>{t("estBurn")}</label>
                    <div style={{ display: "flex", alignItems: "center", gap: 8 }}><input value={showKcal} onChange={(e) => setKcalEdit(e.target.value.replace(/[^0-9]/g, ""))} inputMode="numeric" style={{ ...sIn, width: 110 }} /><span style={{ fontSize: 13, color: MUTED }}>kcal</span>{kcalEdit != null && <span onClick={() => setKcalEdit(null)} style={{ cursor: "pointer", fontSize: 11.5, color: EMBER, fontWeight: 600 }}>auto</span>}</div>
                  </div>
                  <div style={{ display: "flex", gap: 10 }}>
                    <div onClick={() => { resetPanel(); setAdding(false); }} style={{ cursor: "pointer", padding: "11px 16px", borderRadius: 9, border: `1px solid ${LINE}`, color: MUTED, fontSize: 13, fontWeight: 700, ...disp }}>{t("cancel")}</div>
                    <div onClick={addSession} style={{ cursor: "pointer", flex: 1, textAlign: "center", background: EMBER, color: PAPER, padding: "11px 0", borderRadius: 9, ...disp, fontWeight: 700, fontSize: 14 }}>{t("save")}</div>
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
                        <div><span style={{ fontSize: 13.5, color: PAPER, fontWeight: 500 }}>{x.name}</span> <span style={{ fontSize: 11, color: MUTED }}>· {x.min} {t("min")} · ~{x.kcal} kcal</span></div>
                        <div onClick={() => delFromDay(di, x.id)} style={{ cursor: "pointer", color: MUTED, fontSize: 15 }}>×</div>
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

      {planAdd !== null && <PlanAddModal di={planAdd} onClose={() => setPlanAdd(null)} />}
      {move && <MoveModal scope={move.scope} di={move.di} onClose={() => setMove(null)} />}
    </div>
  );
}
