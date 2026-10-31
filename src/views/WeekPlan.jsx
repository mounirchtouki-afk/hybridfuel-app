import React, { useState } from "react";
import { INK2, EMBER, EMBER_SOFT, PAPER, MUTED, LINE, SAGE, disp, num, WD, jsDayToIdx, load, macroLetters } from "../shared.js";

// Weekplan-overzicht + maandweergave. Toont per dag de maaltijden (uit het plan)
// én de geplande training (uit hf_trainplan). Niks betaald — puur een overzicht van
// wat er al is. Maand = het vaste weekschema herhaald, train-dagen uitgelicht.
export default function WeekPlan({ lang, week, onOpenDay }) {
  const t = (nl, en) => (lang === "nl" ? nl : en);
  const [mode, setMode] = useState("week"); // 'week' | 'month'
  const [open, setOpen] = useState(0); // welke dag-kaart is uitgeklapt
  const [monOffset, setMonOffset] = useState(0); // 0 = deze maand
  const ML = macroLetters(lang);

  const days = week && week.days && week.days.length ? week.days : null;
  const trainPlan = load("hf_trainplan", null);
  const trItems = (idx) => (trainPlan && Array.isArray(trainPlan.days) && trainPlan.days[idx] ? (trainPlan.days[idx].items || []) : []);
  const todayIdx = jsDayToIdx(new Date().getDay());

  if (!days) {
    return (
      <div style={{ padding: "18px 16px", color: PAPER }}>
        <div style={{ ...disp, fontWeight: 700, fontSize: 20 }}>{t("Weekplan", "Week plan")}</div>
        <div style={{ ...card(), marginTop: 14, fontSize: 13.5, color: MUTED, lineHeight: 1.6 }}>
          {t("Maak eerst je weekplan aan. Daarna zie je hier je week en maand in één oogopslag.",
             "Build your week plan first. Then you'll see your week and month at a glance here.")}
        </div>
      </div>
    );
  }

  const seg = (id, lbl) => (
    <div onClick={() => setMode(id)} className="hf-tap"
      style={{ flex: 1, textAlign: "center", padding: "9px 0", borderRadius: 8, ...disp, fontWeight: 700, fontSize: 13, letterSpacing: 0.4, color: mode === id ? "#fff" : MUTED, background: mode === id ? EMBER : "transparent" }}>
      {lbl}
    </div>
  );

  return (
    <div style={{ padding: "16px 16px 6px", color: PAPER }}>
      <div style={{ display: "flex", gap: 6, background: INK2, border: `1px solid ${LINE}`, borderRadius: 12, padding: 4, marginBottom: 16 }}>
        {seg("week", t("Week", "Week"))}
        {seg("month", t("Maand", "Month"))}
      </div>

      {mode === "week" ? (
        <WeekList days={days} trItems={trItems} open={open} setOpen={setOpen} todayIdx={todayIdx} lang={lang} ML={ML} t={t} />
      ) : (
        <MonthGrid days={days} trItems={trItems} monOffset={monOffset} setMonOffset={setMonOffset} lang={lang} t={t}
          onPickWeekday={(idx) => { setOpen(idx); setMode("week"); }} />
      )}
    </div>
  );
}

const card = () => ({ background: INK2, border: `1px solid ${LINE}`, borderRadius: 14, padding: 16 });

function dayKcal(d) { return d && d.m ? Math.round(d.m.reduce((a, m) => a + num(m.kcal), 0)) : 0; }
function daySum(d, k) { return d && d.m ? Math.round(d.m.reduce((a, m) => a + num(m[k]), 0)) : 0; }

function WeekList({ days, trItems, open, setOpen, todayIdx, lang, ML, t }) {
  const WDl = WD[lang === "nl" ? "nl" : "en"];
  const full = { nl: ["Maandag", "Dinsdag", "Woensdag", "Donderdag", "Vrijdag", "Zaterdag", "Zondag"], en: ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"] }[lang === "nl" ? "nl" : "en"];

  return (
    <div>
      <div style={{ ...disp, fontSize: 13, fontWeight: 600, textTransform: "uppercase", letterSpacing: 1.5, color: EMBER, margin: "2px 0 12px" }}>{t("Jouw weekplan", "Your week plan")}</div>
      {days.slice(0, 7).map((d, i) => {
        const isTrain = !!d.train;
        const items = trItems(i);
        const burn = items.reduce((a, x) => a + num(x.kcal), 0);
        const mins = items.reduce((a, x) => a + num(x.min), 0);
        const isOpen = open === i;
        return (
          <div key={i} style={{ background: INK2, border: `1px solid ${isTrain ? "rgba(225,29,72,0.42)" : LINE}`, borderRadius: 14, padding: "13px 14px", marginBottom: 10, boxShadow: i === todayIdx ? "0 0 0 1.5px rgba(225,29,72,0.55)" : "none" }}>
            <div onClick={() => setOpen(isOpen ? -1 : i)} className="hf-tap" style={{ display: "flex", alignItems: "center", justifyContent: "space-between", borderRadius: 8 }}>
              <div style={{ ...disp, fontWeight: 700, fontSize: 16, letterSpacing: 0.3 }}>
                {full[i]}{i === todayIdx && <span style={{ fontSize: 10.5, color: EMBER, marginLeft: 8, fontFamily: "Inter", fontWeight: 700, letterSpacing: 0.5 }}>{t("VANDAAG", "TODAY")}</span>}
              </div>
              <div style={{ display: "flex", alignItems: "center", gap: 8 }}>
                <span style={{ ...disp, fontWeight: 700, fontSize: 15 }}>{dayKcal(d).toLocaleString(lang === "nl" ? "nl-NL" : "en-US")} kcal</span>
                <span style={{ fontSize: 9.5, fontWeight: 700, letterSpacing: 1, borderRadius: 5, padding: "3px 7px", color: isTrain ? EMBER : MUTED, border: `1px solid ${isTrain ? EMBER : LINE}` }}>{isTrain ? t("TRAIN", "TRAIN") : t("RUST", "REST")}</span>
                <span style={{ fontSize: 13, color: MUTED, transform: isOpen ? "rotate(90deg)" : "none", transition: "transform .15s" }}>›</span>
              </div>
            </div>

            {isOpen && (
              <div style={{ marginTop: 11 }}>
                <div style={{ display: "flex", gap: 14, marginBottom: 12, fontSize: 11.5, color: SAGE }}>
                  <div><b style={{ color: PAPER, fontWeight: 600 }}>{daySum(d, "p")}</b>g {ML.p}</div>
                  <div><b style={{ color: PAPER, fontWeight: 600 }}>{daySum(d, "c")}</b>g {ML.c}</div>
                  <div><b style={{ color: PAPER, fontWeight: 600 }}>{daySum(d, "f")}</b>g {ML.f}</div>
                </div>

                {/* MAALTIJDEN */}
                <div style={{ fontSize: 10.5, letterSpacing: 1, textTransform: "uppercase", color: MUTED, fontWeight: 700, marginBottom: 7 }}>{t("Maaltijden", "Meals")}</div>
                <div style={{ display: "flex", flexDirection: "column", gap: 6, marginBottom: items.length ? 14 : 2 }}>
                  {d.m.map((m, mi) => (
                    <div key={mi} style={{ display: "flex", justifyContent: "space-between", fontSize: 12.5, color: MUTED }}>
                      <span><span style={{ display: "inline-block", width: 6, height: 6, borderRadius: "50%", background: EMBER, marginRight: 8, verticalAlign: "middle", opacity: 0.8 }} />{m.name || m.item || t("Maaltijd", "Meal")}</span>
                      <span style={{ color: SAGE }}>{Math.round(num(m.kcal))}</span>
                    </div>
                  ))}
                </div>

                {/* TRAINING */}
                <div style={{ fontSize: 10.5, letterSpacing: 1, textTransform: "uppercase", color: MUTED, fontWeight: 700, marginBottom: 7, display: "flex", justifyContent: "space-between" }}>
                  <span>{t("Training", "Training")}</span>
                  {items.length > 0 && <span style={{ color: EMBER_SOFT }}>{mins} {t("min", "min")} · ~{burn} kcal</span>}
                </div>
                {items.length > 0 ? (
                  <div style={{ display: "flex", flexDirection: "column", gap: 6 }}>
                    {items.map((x, xi) => (
                      <div key={xi} style={{ display: "flex", justifyContent: "space-between", fontSize: 12.5, color: PAPER }}>
                        <span><span style={{ display: "inline-block", width: 6, height: 6, borderRadius: 2, background: EMBER_SOFT, marginRight: 8, verticalAlign: "middle" }} />{x.name}</span>
                        <span style={{ color: MUTED }}>{x.min} {t("min", "min")} · ~{x.kcal}</span>
                      </div>
                    ))}
                  </div>
                ) : (
                  <div style={{ fontSize: 12, color: MUTED }}>{isTrain ? t("Trainingsdag — nog geen oefeningen ingepland. Voeg ze toe bij Training.", "Training day — no exercises planned yet. Add them under Training.") : t("Rustdag.", "Rest day.")}</div>
                )}
              </div>
            )}
          </div>
        );
      })}
      <div style={{ fontSize: 11, color: MUTED, margin: "8px 2px 0", lineHeight: 1.5, textAlign: "center" }}>
        {t("Tik een dag om maaltijden en training uit te klappen. Rode rand = vandaag.",
           "Tap a day to expand its meals and training. Red outline = today.")}
      </div>
    </div>
  );
}

function MonthGrid({ days, trItems, monOffset, setMonOffset, lang, t, onPickWeekday }) {
  const WDl = WD[lang === "nl" ? "nl" : "en"];
  const now = new Date();
  const first = new Date(now.getFullYear(), now.getMonth() + monOffset, 1);
  const y = first.getFullYear(), mo = first.getMonth();
  const monthName = first.toLocaleDateString(lang === "nl" ? "nl-NL" : "en-US", { month: "long", year: "numeric" });
  const daysInMonth = new Date(y, mo + 1, 0).getDate();
  const leadBlank = jsDayToIdx(first.getDay()); // hoeveel lege cellen voor dag 1 (ma-start)
  const todayKey = now.getFullYear() + "-" + now.getMonth() + "-" + now.getDate();

  const cells = [];
  for (let i = 0; i < leadBlank; i++) cells.push(null);
  for (let d = 1; d <= daysInMonth; d++) cells.push(d);
  while (cells.length % 7 !== 0) cells.push(null);

  return (
    <div>
      <div style={{ display: "flex", alignItems: "center", justifyContent: "space-between", marginBottom: 12 }}>
        <div onClick={() => setMonOffset(monOffset - 1)} className="hf-tap" style={{ width: 32, height: 32, borderRadius: 8, border: `1px solid ${LINE}`, display: "flex", alignItems: "center", justifyContent: "center", color: MUTED, fontSize: 16 }}>‹</div>
        <div style={{ ...disp, fontWeight: 700, fontSize: 18, textTransform: "capitalize" }}>{monthName}</div>
        <div onClick={() => setMonOffset(monOffset + 1)} className="hf-tap" style={{ width: 32, height: 32, borderRadius: 8, border: `1px solid ${LINE}`, display: "flex", alignItems: "center", justifyContent: "center", color: MUTED, fontSize: 16 }}>›</div>
      </div>

      <div style={{ display: "grid", gridTemplateColumns: "repeat(7,1fr)", gap: 5, marginBottom: 6 }}>
        {WDl.map((w) => <div key={w} style={{ textAlign: "center", fontSize: 10, fontWeight: 700, letterSpacing: 0.5, color: MUTED, textTransform: "uppercase", padding: "2px 0" }}>{w}</div>)}
      </div>

      <div style={{ display: "grid", gridTemplateColumns: "repeat(7,1fr)", gap: 5 }}>
        {cells.map((d, i) => {
          if (d == null) return <div key={i} style={{ aspectRatio: "1/1.12" }} />;
          const wdIdx = jsDayToIdx(new Date(y, mo, d).getDay());
          const day = days[wdIdx];
          const isTrain = !!(day && day.train);
          const kcal = dayKcal(day);
          const isToday = (y + "-" + mo + "-" + d) === todayKey;
          return (
            <div key={i} onClick={() => onPickWeekday(wdIdx)} className="hf-tap"
              style={{ aspectRatio: "1/1.12", borderRadius: 9, border: `1px solid ${isTrain ? "rgba(225,29,72,0.5)" : LINE}`, background: isTrain ? "linear-gradient(180deg,rgba(225,29,72,0.20),rgba(225,29,72,0.05))" : INK2, padding: "5px 4px 4px", display: "flex", flexDirection: "column", alignItems: "center", position: "relative", boxShadow: isToday ? "0 0 0 2px " + EMBER : "none" }}>
              {isTrain && <div style={{ width: 5, height: 5, borderRadius: "50%", background: EMBER, position: "absolute", top: 5, right: 5 }} />}
              <div style={{ ...disp, fontWeight: 700, fontSize: 13, color: PAPER }}>{d}</div>
              <div style={{ fontSize: 8.5, color: SAGE, marginTop: "auto", fontWeight: 600 }}>{kcal ? kcal : ""}</div>
            </div>
          );
        })}
      </div>

      <div style={{ display: "flex", gap: 16, marginTop: 14, fontSize: 11, color: MUTED }}>
        <span style={{ display: "flex", alignItems: "center", gap: 6 }}><span style={{ width: 12, height: 12, borderRadius: 4, background: "linear-gradient(180deg,rgba(225,29,72,0.6),rgba(225,29,72,0.2))", border: "1px solid rgba(225,29,72,0.5)" }} /> {t("Trainingsdag", "Training day")}</span>
        <span style={{ display: "flex", alignItems: "center", gap: 6 }}><span style={{ width: 12, height: 12, borderRadius: 4, background: INK2, border: `1px solid ${LINE}` }} /> {t("Rustdag", "Rest day")}</span>
      </div>
      <div style={{ fontSize: 11, color: MUTED, margin: "12px 2px 0", lineHeight: 1.5, textAlign: "center" }}>
        {t("Rode dagen zijn trainingsdagen (hoger kcal-doel). Tik een dag → dat dagplan. Rand = vandaag.",
           "Red days are training days (higher kcal target). Tap a day → that day's plan. Outline = today.")}
      </div>
    </div>
  );
}
