import React, { useState, useEffect, useRef } from "react";
import { INK, INK2, EMBER, EMBER_SOFT, PAPER, MUTED, LINE, SAGE, disp, num, load, save, todayISO, label, sectionTitle } from "../shared.js";
import { EXERCISES, WORKOUT_CATS, INTENSITY, kcalFor } from "../workouts.js";

const T = {
  title: { nl: "Training", en: "Training" },
  sub: { nl: "Log je sessies — zie je trainingsdag en een schatting van je verbranding.", en: "Log your sessions — see your training day and an estimate of your burn." },
  todayBurn: { nl: "Verbrand vandaag (schatting)", en: "Burned today (estimate)" },
  totalTime: { nl: "Totale tijd", en: "Total time" },
  sessions: { nl: "sessies", en: "sessions" },
  add: { nl: "+ Sessie toevoegen", en: "+ Add session" },
  pickExercise: { nl: "Kies een oefening", en: "Pick an exercise" },
  own: { nl: "+ Eigen oefening", en: "+ Custom exercise" },
  ownName: { nl: "Naam van de oefening", en: "Exercise name" },
  intensity: { nl: "Intensiteit", en: "Intensity" },
  minutes: { nl: "Minuten", en: "Minutes" },
  timer: { nl: "Timer", en: "Timer" },
  start: { nl: "Start", en: "Start" },
  stop: { nl: "Stop", en: "Stop" },
  running: { nl: "Bezig…", en: "Running…" },
  estBurn: { nl: "Geschatte verbranding", en: "Estimated burn" },
  save: { nl: "Toevoegen", en: "Add" },
  cancel: { nl: "Annuleren", en: "Cancel" },
  today: { nl: "Vandaag getraind", en: "Trained today" },
  empty: { nl: "Nog geen training vandaag. Voeg je eerste sessie toe.", en: "No training yet today. Add your first session." },
  min: { nl: "min", en: "min" },
  disclaimer: { nl: "Verbranding is een schatting (op basis van intensiteit, gewicht en tijd) en wordt niet van je voedingsdoelen afgetrokken.", en: "Burn is an estimate (based on intensity, bodyweight and time) and is not subtracted from your nutrition targets." },
  back: { nl: "← Terug", en: "← Back" },
};

function bodyKg(weightProp) {
  const mw = num(load("hf_water_weight", ""));
  if (mw > 0) return mw;
  const ws = load("hf_weights", []);
  if (ws.length) { const s = [...ws].sort((a, b) => a.date.localeCompare(b.date)); const k = Number(s[s.length - 1].kg); if (k > 0) return k; }
  const w = num(weightProp);
  return w > 0 ? w : 80;
}

export default function Training({ lang, session, weight }) {
  const t = (k) => (T[k] ? T[k][lang] : k);
  const d = todayISO();
  const kg = bodyKg(weight);
  const [list, setList] = useState(() => load("hf_workouts_" + d, []));
  const [adding, setAdding] = useState(false);

  // Add-panel state
  const [sel, setSel] = useState(null);         // gekozen DB-oefening
  const [custom, setCustom] = useState(false);  // eigen oefening
  const [cName, setCName] = useState("");
  const [cMet, setCMet] = useState(7);
  const [mins, setMins] = useState("");
  const [kcalEdit, setKcalEdit] = useState(null); // handmatig overschreven kcal
  const [run, setRun] = useState(() => load("hf_workout_running", null)); // {start}
  const [, tick] = useState(0);
  const iv = useRef(null);

  useEffect(() => { setList(load("hf_workouts_" + d, [])); }, [d]);

  // Live timer
  useEffect(() => {
    if (run) { iv.current = setInterval(() => tick((x) => x + 1), 1000); if (!adding) setAdding(true); }
    return () => { if (iv.current) clearInterval(iv.current); };
  }, [run]);

  const curMet = custom ? num(cMet) : (sel ? sel.met : 0);
  const curName = custom ? (cName.trim() || t("own").replace("+ ", "")) : (sel ? sel[lang] : "");
  const elapsedMin = run ? Math.max(0, (Date.now() - run.start) / 60000) : 0;
  const effMin = run ? elapsedMin : num(mins);
  const autoKcal = kcalFor(curMet, kg, effMin);
  const showKcal = kcalEdit != null ? kcalEdit : autoKcal;

  function startTimer() { const r = { start: Date.now() }; setRun(r); save("hf_workout_running", r); }
  function stopTimer() {
    if (!run) return;
    const m = Math.max(1, Math.round((Date.now() - run.start) / 60000));
    setMins(String(m)); setRun(null); try { localStorage.removeItem("hf_workout_running"); } catch (e) {}
    if (iv.current) clearInterval(iv.current);
  }
  function resetPanel() { setSel(null); setCustom(false); setCName(""); setCMet(7); setMins(""); setKcalEdit(null); }
  function persist(next) { setList(next); save("hf_workouts_" + d, next); }
  function addSession() {
    const m = run ? Math.max(1, Math.round((Date.now() - run.start) / 60000)) : num(mins);
    if (!curName || m <= 0) return;
    const kcal = kcalEdit != null ? num(kcalEdit) : kcalFor(curMet, kg, m);
    const row = { id: "w" + Date.now(), name: curName, met: curMet, min: m, kcal, ts: Date.now() };
    persist([...list, row]);
    if (run) { setRun(null); try { localStorage.removeItem("hf_workout_running"); } catch (e) {} if (iv.current) clearInterval(iv.current); }
    resetPanel(); setAdding(false);
  }
  function del(id) { persist(list.filter((x) => x.id !== id)); }

  const totKcal = list.reduce((a, x) => a + num(x.kcal), 0);
  const totMin = list.reduce((a, x) => a + num(x.min), 0);
  const mmss = (ms) => { const s = Math.floor(ms / 1000); return String(Math.floor(s / 60)).padStart(2, "0") + ":" + String(s % 60).padStart(2, "0"); };

  const groups = Object.keys(WORKOUT_CATS).map((c) => ({ cat: c, items: EXERCISES.filter((e) => e.cat === c) }));
  const sIn = { width: "100%", background: INK, border: `1px solid ${LINE}`, color: PAPER, padding: "11px 12px", fontFamily: "Inter, sans-serif", fontSize: 14, borderRadius: 8, outline: "none", boxSizing: "border-box" };
  const seg = (on) => ({ flex: 1, textAlign: "center", cursor: "pointer", padding: "9px 4px", borderRadius: 8, border: `1px solid ${on ? EMBER : LINE}`, background: on ? "rgba(225,29,72,0.12)" : "transparent", color: on ? PAPER : MUTED, fontSize: 12.5, fontWeight: 700, ...disp, letterSpacing: 0.3 });

  return (
    <div style={{ maxWidth: 560, margin: "0 auto", padding: "4px 0 10px" }}>
      <div style={{ ...sectionTitle, marginBottom: 4 }}>{t("title")}</div>
      <div style={{ fontSize: 12.5, color: MUTED, marginBottom: 16, lineHeight: 1.5 }}>{t("sub")}</div>

      {/* Dagtotaal */}
      <div style={{ background: `linear-gradient(135deg, ${EMBER}, #9f1239)`, borderRadius: 16, padding: "18px 18px", marginBottom: 14, color: PAPER }}>
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

      {!adding && (
        <div onClick={() => setAdding(true)} style={{ cursor: "pointer", textAlign: "center", background: INK2, border: `1px solid ${EMBER}`, color: EMBER, padding: "13px 0", borderRadius: 12, ...disp, fontWeight: 700, fontSize: 15, letterSpacing: 0.5, marginBottom: 16 }}>{t("add")}</div>
      )}

      {/* Add-panel */}
      {adding && (
        <div style={{ background: INK2, border: `1px solid ${LINE}`, borderRadius: 14, padding: 16, marginBottom: 16 }}>
          {/* Oefening kiezen */}
          {!sel && !custom && (
            <div>
              <div style={{ ...label, marginBottom: 8 }}>{t("pickExercise")}</div>
              <div style={{ display: "grid", gap: 12, maxHeight: 280, overflowY: "auto" }} className="hf-modal">
                {groups.map((g) => (
                  <div key={g.cat}>
                    <div style={{ fontSize: 10, letterSpacing: 1, textTransform: "uppercase", color: EMBER, fontWeight: 700, marginBottom: 6 }}>{WORKOUT_CATS[g.cat][lang]}</div>
                    <div style={{ display: "flex", flexWrap: "wrap", gap: 6 }}>
                      {g.items.map((e) => (
                        <div key={e.id} onClick={() => setSel(e)} style={{ cursor: "pointer", padding: "7px 11px", borderRadius: 9, border: `1px solid ${LINE}`, background: INK, fontSize: 12.5, color: PAPER, fontWeight: 500 }}>{e[lang]}</div>
                      ))}
                    </div>
                  </div>
                ))}
              </div>
              <div onClick={() => setCustom(true)} style={{ cursor: "pointer", marginTop: 12, color: EMBER, fontSize: 13, fontWeight: 700, ...disp, letterSpacing: 0.3 }}>{t("own")}</div>
            </div>
          )}

          {/* Eigen oefening */}
          {custom && (
            <div style={{ marginBottom: 12 }}>
              <label style={label}>{t("ownName")}</label>
              <input value={cName} onChange={(e) => setCName(e.target.value)} placeholder={t("ownName")} style={{ ...sIn, marginBottom: 10 }} />
              <label style={label}>{t("intensity")}</label>
              <div style={{ display: "flex", gap: 7 }}>
                {INTENSITY.map((i) => <div key={i.id} onClick={() => setCMet(i.met)} style={seg(num(cMet) === i.met)}>{i[lang]}</div>)}
              </div>
            </div>
          )}

          {/* Geselecteerde oefening + tijd */}
          {(sel || custom) && (
            <div>
              {sel && (
                <div style={{ display: "flex", justifyContent: "space-between", alignItems: "center", marginBottom: 12 }}>
                  <div style={{ ...disp, fontSize: 16, fontWeight: 700, color: PAPER }}>{sel[lang]}</div>
                  <div onClick={() => resetPanel()} style={{ cursor: "pointer", fontSize: 11.5, color: MUTED, fontWeight: 600 }}>{t("pickExercise")}</div>
                </div>
              )}

              {/* Timer */}
              <label style={label}>{t("timer")}</label>
              <div style={{ display: "flex", gap: 10, alignItems: "center", marginBottom: 12 }}>
                {!run ? (
                  <div onClick={startTimer} style={{ cursor: "pointer", flex: 1, textAlign: "center", background: EMBER, color: PAPER, padding: "11px 0", borderRadius: 9, ...disp, fontWeight: 700, letterSpacing: 0.5 }}>▶ {t("start")}</div>
                ) : (
                  <>
                    <div style={{ ...disp, fontSize: 26, fontWeight: 700, color: EMBER_SOFT, minWidth: 92 }}>{mmss(Date.now() - run.start)}</div>
                    <div onClick={stopTimer} style={{ cursor: "pointer", flex: 1, textAlign: "center", background: INK, border: `1px solid ${EMBER}`, color: EMBER, padding: "11px 0", borderRadius: 9, ...disp, fontWeight: 700, letterSpacing: 0.5 }}>■ {t("stop")}</div>
                  </>
                )}
              </div>

              {/* Of handmatig minuten */}
              {!run && (
                <div style={{ marginBottom: 12 }}>
                  <label style={label}>{t("minutes")}</label>
                  <input value={mins} onChange={(e) => { setMins(e.target.value.replace(/[^0-9]/g, "")); setKcalEdit(null); }} inputMode="numeric" placeholder="15" style={sIn} />
                </div>
              )}

              {/* Geschatte kcal (bewerkbaar) */}
              <div style={{ marginBottom: 14 }}>
                <label style={label}>{t("estBurn")}</label>
                <div style={{ display: "flex", alignItems: "center", gap: 8 }}>
                  <input value={showKcal} onChange={(e) => setKcalEdit(e.target.value.replace(/[^0-9]/g, ""))} inputMode="numeric" style={{ ...sIn, width: 110 }} />
                  <span style={{ fontSize: 13, color: MUTED }}>kcal</span>
                  {kcalEdit != null && <span onClick={() => setKcalEdit(null)} style={{ cursor: "pointer", fontSize: 11.5, color: EMBER, fontWeight: 600 }}>auto</span>}
                </div>
              </div>

              <div style={{ display: "flex", gap: 10 }}>
                <div onClick={() => { resetPanel(); setAdding(false); }} style={{ cursor: "pointer", padding: "11px 16px", borderRadius: 9, border: `1px solid ${LINE}`, color: MUTED, fontSize: 13, fontWeight: 700, ...disp, letterSpacing: 0.3 }}>{t("cancel")}</div>
                <div onClick={addSession} style={{ cursor: "pointer", flex: 1, textAlign: "center", background: EMBER, color: PAPER, padding: "11px 0", borderRadius: 9, ...disp, fontWeight: 700, fontSize: 14, letterSpacing: 0.5 }}>{t("save")}</div>
              </div>
            </div>
          )}
        </div>
      )}

      {/* Sessies vandaag */}
      <div style={{ ...label, marginBottom: 8 }}>{t("today")}</div>
      {list.length === 0 ? (
        <div style={{ border: `1px dashed ${LINE}`, borderRadius: 12, padding: "22px", textAlign: "center", fontSize: 13, color: MUTED }}>{t("empty")}</div>
      ) : (
        <div style={{ display: "grid", gap: 8 }}>
          {list.map((x) => (
            <div key={x.id} style={{ display: "flex", justifyContent: "space-between", alignItems: "center", background: INK2, border: `1px solid ${LINE}`, borderRadius: 12, padding: "11px 14px" }}>
              <div style={{ minWidth: 0 }}>
                <div style={{ fontSize: 14, fontWeight: 600, color: PAPER }}>{x.name}</div>
                <div style={{ fontSize: 11, color: MUTED, marginTop: 2 }}>{x.min} {t("min")}</div>
              </div>
              <div style={{ display: "flex", alignItems: "center", gap: 12 }}>
                <div style={{ fontSize: 13, color: PAPER, whiteSpace: "nowrap" }}><span style={{ ...disp, fontWeight: 700, color: EMBER_SOFT }}>~{x.kcal}</span> kcal</div>
                <div onClick={() => del(x.id)} style={{ cursor: "pointer", color: MUTED, fontSize: 16, width: 26, height: 26, display: "flex", alignItems: "center", justifyContent: "center", borderRadius: 7, border: `1px solid ${LINE}` }}>×</div>
              </div>
            </div>
          ))}
        </div>
      )}

      <div style={{ fontSize: 11, color: MUTED, marginTop: 14, lineHeight: 1.5, borderLeft: `2px solid ${LINE}`, paddingLeft: 10 }}>{t("disclaimer")}</div>
    </div>
  );
}
