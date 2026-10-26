import React, { useState } from "react";
import { INK, INK2, EMBER, EMBER_SOFT, PAPER, MUTED, LINE, SAGE, disp, num, input, label, sectionTitle, load, save, jsDayToIdx } from "../shared.js";

const T = {
  title: { nl: "Race Protocol", en: "Race Protocol" },
  sub: { nl: "Jouw tank-plan voor Hyrox — van carb-laden tot de finish, op jouw gewicht en starttijd.", en: "Your fueling plan for Hyrox — from carb-loading to the finish, built on your weight and start time." },
  setup: { nl: "Jouw race", en: "Your race" },
  date: { nl: "Racedatum", en: "Race date" },
  time: { nl: "Starttijd", en: "Start time" },
  weight: { nl: "Gewicht (kg)", en: "Weight (kg)" },
  goal: { nl: "Doel", en: "Goal" },
  gFinish: { nl: "Finishen", en: "Finish" },
  gPr: { nl: "PR verbeteren", en: "Beat PR" },
  gCompete: { nl: "Wedstrijd", en: "Compete" },
  sweat: { nl: "Zweet", en: "Sweat" },
  sNormal: { nl: "Normaal", en: "Normal" },
  sHeavy: { nl: "Veel", en: "Heavy" },
  needDate: { nl: "Vul je racedatum en gewicht in — dan rekent de app je protocol uit.", en: "Enter your race date and weight — the app builds your protocol." },
  countdown: { nl: "nog", en: "in" },
  days: { nl: "dagen", en: "days" },
  dayTomorrow: { nl: "morgen", en: "tomorrow" },
  dayToday: { nl: "vandaag", en: "today" },
  loadTitle: { nl: "Carb-laden", en: "Carb-loading" },
  raceDayTitle: { nl: "Racedag", en: "Race day" },
  hydraTitle: { nl: "Hydratatie", en: "Hydration" },
  recTitle: { nl: "Herstel", en: "Recovery" },
  disclaimer: { nl: "Algemene sportvoedingsrichtlijn, geen medisch advies. Test alles in training — nooit iets nieuws op racedag. Heb je een aandoening of gebruik je medicatie? Overleg met een (sport)arts of diëtist.", en: "General sports-nutrition guidance, not medical advice. Test everything in training — never try anything new on race day. Have a condition or take medication? Check with a (sports) physician or dietitian." },
  perDay: { nl: "per dag", en: "per day" },
  gCarb: { nl: "g koolhydraten", en: "g carbs" },
  start: { nl: "START", en: "START" },
  linkTitle: { nl: "Koppel aan je dagboek", en: "Link to your diary" },
  linkBtn: { nl: "Koppel carb-laden aan mijn dagboek", en: "Link carb-load to my diary" },
  linkNote: { nl: "Zet T-2, T-1 (carb-laaddagen) en de racedag in je Dagboek. De laatste 2 dagen zijn de échte load — eerder in de week taper je en eet je normaal.", en: "Adds T-2, T-1 (carb-load days) and race day to your Diary. The last 2 days are the real load — earlier in the week you taper and eat normally." },
  linkDone: { nl: "Gekoppeld aan je dagboek ✓ — T-2, T-1 en de racedag staan erin.", en: "Linked to your diary ✓ — T-2, T-1 and race day are in." },
  unlinkBtn: { nl: "Ontkoppelen", en: "Unlink" },
  linkNoPlan: { nl: "Maak eerst je weekplan aan om te kunnen koppelen.", en: "Create your week plan first to link." },
  loadDayLbl: { nl: "CARB-LAAD", en: "CARB-LOAD" },
  raceDayLbl: { nl: "RACEDAG", en: "RACE DAY" },
};

const WD = { nl: ["zo", "ma", "di", "wo", "do", "vr", "za"], en: ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"] };

export default function RaceProtocol({ lang, weight, session, week }) {
  const t = (k) => (T[k] ? T[k][lang] : k);
  const saved = load("hf_race", {});
  const [linked, setLinked] = useState(() => load("hf_race_linked", []));
  const [date, setDate] = useState(saved.date || "");
  const [time, setTime] = useState(saved.time || "10:00");
  const [w, setW] = useState(saved.weight || String(num(weight) || 80));
  const [goal, setGoal] = useState(saved.goal || "finish");
  const [sweat, setSweat] = useState(saved.sweat || "normal");

  function persist(next) { save("hf_race", { date, time, weight: w, goal, sweat, ...next }); }

  const kg = Math.max(35, Math.min(200, num(w)));
  const ready = !!date && kg > 0;

  // Carb-laden: g/kg/dag naar doel
  const loadGkg = goal === "compete" ? 9 : goal === "pr" ? 8 : 6;
  const loadCarbs = Math.round(kg * loadGkg);
  // Ontbijt 3,5u vóór: ~2 g/kg carbs, vocht 6 ml/kg
  const bfastCarbs = Math.round(kg * 2);
  const preFluid = Math.round(kg * 6 / 50) * 50;
  // Tijdens-duur schatting (min) + during fueling
  const durMin = goal === "compete" ? 60 : goal === "pr" ? 75 : 90;
  const during = durMin > 60;
  // Hydratatie tijdens
  const perHrLow = sweat === "heavy" ? 600 : 400;
  const perHrHigh = sweat === "heavy" ? 800 : 600;
  const sodium = sweat === "heavy" ? "500–800 mg" : "300–600 mg";
  // Herstel
  const recCarbs = Math.round(kg * 1);
  const recProt = Math.round(kg * 0.3);

  // ===== Koppelen aan Dagboek (datum-specifieke dagen) =====
  const hasPlan = !!(week && week.days && week.days.length);
  function isoShift(baseISO, delta) { const dt = new Date(baseISO + "T12:00:00"); dt.setDate(dt.getDate() + delta); return dt.getFullYear() + "-" + String(dt.getMonth() + 1).padStart(2, "0") + "-" + String(dt.getDate()).padStart(2, "0"); }
  function tmplDay(iso) { if (!hasPlan) return null; const i = jsDayToIdx(new Date(iso + "T12:00:00").getDay()); return week.days[i] || week.days[0]; }
  function linkDiary() {
    if (!date || !hasPlan) return;
    const done = [];
    [2, 1].forEach((off) => {
      const iso = isoShift(date, -off);
      const base = tmplDay(iso);
      const baseMeals = base ? base.m.map((m) => ({ ...m, ing: (m.ing || []).map((g) => ({ ...g })) })) : [];
      const baseC = baseMeals.reduce((a, m) => a + num(m.c), 0);
      const addC = Math.max(0, loadCarbs - baseC);
      const extra = { t: t("loadDayLbl"), n: lang === "nl" ? "Extra koolhydraten (carb-laden)" : "Extra carbs (carb-load)", kcal: Math.round(addC * 4), p: 0, c: addC, f: 0, ing: [{ n: lang === "nl" ? "rijst / pasta / aardappel / fruit" : "rice / pasta / potato / fruit", g: addC }] };
      const meals = addC > 0 ? [...baseMeals, extra] : baseMeals;
      const sum = (k) => meals.reduce((a, m) => a + num(m[k]), 0);
      save("hf_dayover_" + iso, { d: base ? base.d : "", train: false, race: t("loadDayLbl"), m: meals, goal: { kcal: sum("kcal"), p: sum("p"), c: sum("c"), f: sum("f") } });
      done.push(iso);
    });
    const raceMeals = [
      { t: lang === "nl" ? "ONTBIJT" : "BREAKFAST", n: lang === "nl" ? "Race-ontbijt (3,5 u vóór)" : "Race breakfast (3.5h before)", kcal: Math.round(bfastCarbs * 4 + 80), p: 10, c: bfastCarbs, f: 3, ing: [{ n: lang === "nl" ? "havermout/bagel + banaan + honing" : "oats/bagel + banana + honey", g: bfastCarbs }] },
      { t: lang === "nl" ? "VLAK VOOR" : "PRE-RACE", n: lang === "nl" ? "Laatste tanken (1 u vóór)" : "Final top-up (1h before)", kcal: 120, p: 0, c: 30, f: 0, ing: [] },
      { t: "GEL", n: lang === "nl" ? "Gel + slokken (15 min vóór)" : "Gel + sips (15 min before)", kcal: 100, p: 0, c: 25, f: 0, ing: [] },
      { t: lang === "nl" ? "HERSTEL" : "RECOVERY", n: lang === "nl" ? "Herstelmaaltijd (binnen 2 u)" : "Recovery meal (within 2h)", kcal: Math.round(recCarbs * 4 + recProt * 4), p: recProt, c: recCarbs, f: 8, ing: [] },
    ];
    const rsum = (k) => raceMeals.reduce((a, m) => a + num(m[k]), 0);
    save("hf_dayover_" + date, { d: "", train: true, race: t("raceDayLbl"), m: raceMeals, goal: { kcal: rsum("kcal"), p: rsum("p"), c: rsum("c"), f: rsum("f") } });
    done.push(date);
    save("hf_race_linked", done); setLinked(done);
  }
  function unlinkDiary() { linked.forEach((iso) => { try { localStorage.removeItem("hf_dayover_" + iso); } catch (e) {} }); save("hf_race_linked", []); setLinked([]); }

  // Klok-tijden rond de start
  const startDt = (date && time) ? new Date(date + "T" + time + ":00") : null;
  function clock(offMin) {
    if (!startDt || isNaN(startDt.getTime())) return null;
    const d = new Date(startDt.getTime() + offMin * 60000);
    const hh = String(d.getHours()).padStart(2, "0"), mm = String(d.getMinutes()).padStart(2, "0");
    return hh + ":" + mm;
  }

  // Countdown
  let cd = null;
  if (date) {
    const today = new Date(); today.setHours(0, 0, 0, 0);
    const rd = new Date(date + "T12:00:00"); rd.setHours(0, 0, 0, 0);
    const diff = Math.round((rd - today) / 86400000);
    cd = diff;
  }
  const dateLbl = date ? (() => { const d = new Date(date + "T12:00:00"); return WD[lang][d.getDay()] + " " + d.getDate() + "/" + (d.getMonth() + 1); })() : "";

  const seg = (on) => ({ flex: 1, textAlign: "center", padding: "9px 0", borderRadius: 8, cursor: "pointer", fontSize: 12.5, fontWeight: 600, border: `1px solid ${on ? EMBER : LINE}`, background: on ? "rgba(225,29,72,0.14)" : "transparent", color: on ? PAPER : MUTED });

  const Step = ({ when, rel, title, body, detail, hero }) => (
    <div style={{ display: "flex", gap: 12, marginBottom: 2 }}>
      <div style={{ flexShrink: 0, width: 52, textAlign: "right", paddingTop: 1 }}>
        <div style={{ ...disp, fontSize: when ? 14 : 11, fontWeight: 700, color: hero ? EMBER : PAPER, lineHeight: 1.1 }}>{when || rel}</div>
        {when && rel && <div style={{ fontSize: 9, color: MUTED, marginTop: 2, lineHeight: 1.1 }}>{rel}</div>}
      </div>
      <div style={{ flexShrink: 0, display: "flex", flexDirection: "column", alignItems: "center" }}>
        <div style={{ width: 11, height: 11, borderRadius: "50%", border: `2px solid ${hero ? EMBER : LINE}`, background: hero ? EMBER : INK, marginTop: 3 }} />
        <div style={{ flex: 1, width: 2, background: LINE, marginTop: 2 }} />
      </div>
      <div style={{ flex: 1, minWidth: 0, paddingBottom: 16 }}>
        <div style={{ fontSize: 13.5, fontWeight: 700, color: hero ? EMBER : PAPER }}>{title}</div>
        <div style={{ fontSize: 12.5, color: PAPER, marginTop: 2 }}>{body}</div>
        {detail && <div style={{ fontSize: 11, color: MUTED, marginTop: 3, lineHeight: 1.5 }}>{detail}</div>}
      </div>
    </div>
  );

  const card = { background: INK2, border: `1px solid ${LINE}`, borderRadius: 14, padding: 16, marginBottom: 14 };
  const capTitle = { ...disp, fontSize: 11.5, fontWeight: 700, letterSpacing: 1, textTransform: "uppercase", color: EMBER, marginBottom: 10 };

  const duringBody = during
    ? (lang === "nl" ? `1 gel (~25–30 g) rond station 4–5 · slokjes elektrolytdrank` : `1 gel (~25–30 g) around station 4–5 · sips of electrolyte drink`)
    : (lang === "nl" ? `Kort genoeg om op je ontbijt te rijden · evt. mondspoeling met sportdrank` : `Short enough to run on breakfast · optional carb mouth-rinse`);
  const duringDetail = lang === "nl"
    ? `Geschatte duur ~${durMin} min. ${during ? "Boven ~60 min levert bijtanken (30–60 g carbs/uur) winst op." : "Onder ~60 min heb je tijdens de race nauwelijks extra carbs nodig."}`
    : `Estimated ~${durMin} min. ${during ? "Beyond ~60 min, 30–60 g carbs/hour pays off." : "Under ~60 min you barely need extra carbs during the race."}`;

  return (
    <div style={{ display: "grid", gap: 0 }}>
      <div style={sectionTitle}>{t("title")}</div>
      <div style={{ fontSize: 12, color: MUTED, marginTop: 6, marginBottom: 16, lineHeight: 1.5 }}>{t("sub")}</div>

      {/* Setup */}
      <div style={card}>
        <div style={capTitle}>{t("setup")}</div>
        <div style={{ display: "flex", gap: 10, marginBottom: 12 }}>
          <div style={{ flex: 1 }}>
            <label style={label}>{t("date")}</label>
            <input type="date" value={date} onChange={(e) => { setDate(e.target.value); persist({ date: e.target.value }); }} style={input} />
          </div>
          <div style={{ width: 110 }}>
            <label style={label}>{t("time")}</label>
            <input type="time" value={time} onChange={(e) => { setTime(e.target.value); persist({ time: e.target.value }); }} style={input} />
          </div>
          <div style={{ width: 86 }}>
            <label style={label}>{t("weight")}</label>
            <input value={w} onChange={(e) => { setW(e.target.value); persist({ weight: e.target.value }); }} inputMode="numeric" style={input} />
          </div>
        </div>
        <label style={label}>{t("goal")}</label>
        <div style={{ display: "flex", gap: 7, marginBottom: 12 }}>
          {[["finish", t("gFinish")], ["pr", t("gPr")], ["compete", t("gCompete")]].map(([id, lbl]) => (
            <div key={id} onClick={() => { setGoal(id); persist({ goal: id }); }} style={seg(goal === id)}>{lbl}</div>
          ))}
        </div>
        <label style={label}>{t("sweat")}</label>
        <div style={{ display: "flex", gap: 7 }}>
          {[["normal", t("sNormal")], ["heavy", t("sHeavy")]].map(([id, lbl]) => (
            <div key={id} onClick={() => { setSweat(id); persist({ sweat: id }); }} style={seg(sweat === id)}>{lbl}</div>
          ))}
        </div>
      </div>

      {!ready && <div style={{ fontSize: 12.5, color: MUTED, lineHeight: 1.6, padding: "2px 2px 8px" }}>{t("needDate")}</div>}

      {ready && (
        <>
          {/* Countdown */}
          <div style={{ ...card, display: "flex", alignItems: "center", justifyContent: "space-between", backgroundImage: "radial-gradient(120% 90% at 100% 0%, rgba(225,29,72,0.16), transparent 60%)" }}>
            <div>
              <div style={{ fontSize: 11, color: MUTED, letterSpacing: 1, textTransform: "uppercase" }}>{dateLbl}{startDt && time ? " · " + time : ""}</div>
              <div style={{ ...disp, fontSize: 22, fontWeight: 700, marginTop: 2 }}>HYROX</div>
            </div>
            <div style={{ textAlign: "right" }}>
              <div style={{ ...disp, fontSize: 30, fontWeight: 700, color: EMBER, lineHeight: 1 }}>{cd <= 0 ? "0" : cd}</div>
              <div style={{ fontSize: 10, color: MUTED, letterSpacing: 1, textTransform: "uppercase" }}>{cd === 1 ? t("dayTomorrow") : cd <= 0 ? t("dayToday") : t("days")}</div>
            </div>
          </div>

          {/* Carb-laden */}
          <div style={card}>
            <div style={capTitle}>{t("loadTitle")}</div>
            <Step rel="T-2" title={lang === "nl" ? "Twee dagen vóór" : "Two days before"} body={`${loadCarbs} ${t("gCarb")} ${t("perDay")} (${loadGkg} g/kg)`} detail={lang === "nl" ? "Rijst, pasta, aardappel, wit brood, fruit, sportdrank. Houd vet en vezels laag. Geen alcohol." : "Rice, pasta, potato, white bread, fruit, sports drink. Keep fat and fibre low. No alcohol."} />
            <Step rel="T-1" title={lang === "nl" ? "Dag vóór" : "Day before"} body={`${loadCarbs} ${t("gCarb")} ${t("perDay")}`} detail={lang === "nl" ? "Zelfde lijn. Avondmaaltijd: bekend en licht verteerbaar, niet te vet of vezelrijk. Vroeg naar bed." : "Same approach. Dinner: familiar and easy to digest, not too fatty or fibrous. Early night."} hero />
          </div>

          {/* Racedag timeline */}
          <div style={card}>
            <div style={capTitle}>{t("raceDayTitle")}</div>
            <Step when={clock(-210)} rel={lang === "nl" ? "3,5 u vóór" : "3.5h before"} title={lang === "nl" ? "Ontbijt" : "Breakfast"} body={`${bfastCarbs} g carbs · ${preFluid} ml vocht`} detail={lang === "nl" ? "Havermout + banaan + honing, witte bagel + jam, of pannenkoeken. Laag vet/vezel, bekende kost." : "Oats + banana + honey, white bagel + jam, or pancakes. Low fat/fibre, familiar food."} />
            <Step when={clock(-60)} rel={lang === "nl" ? "1 u vóór" : "1h before"} title={lang === "nl" ? "Laatste tanken" : "Final top-up"} body={lang === "nl" ? "~30 g carbs + 400–500 ml (elektrolyten)" : "~30 g carbs + 400–500 ml (electrolytes)"} detail={lang === "nl" ? "Sportdrank, of banaan/gel met water." : "Sports drink, or banana/gel with water."} />
            <Step when={clock(-15)} rel={lang === "nl" ? "15 min vóór" : "15 min before"} title={lang === "nl" ? "Topje (optioneel)" : "Top-up (optional)"} body={lang === "nl" ? "1 gel (~25 g) + paar slokken" : "1 gel (~25 g) + a few sips"} detail={lang === "nl" ? "Alleen als je maag dat gewend is uit training." : "Only if your gut is used to it from training."} />
            <Step when={clock(0)} rel={t("start")} title="Hyrox" body={duringBody} detail={duringDetail} hero />
            <div style={{ display: "flex", gap: 12 }}>
              <div style={{ flexShrink: 0, width: 52, textAlign: "right" }}><div style={{ ...disp, fontSize: 14, fontWeight: 700, color: PAPER }}>{clock(durMin + 30) || "+2u"}</div><div style={{ fontSize: 9, color: MUTED, marginTop: 2 }}>{lang === "nl" ? "na finish" : "post"}</div></div>
              <div style={{ flexShrink: 0, display: "flex", flexDirection: "column", alignItems: "center" }}><div style={{ width: 11, height: 11, borderRadius: "50%", border: `2px solid ${LINE}`, background: INK, marginTop: 3 }} /></div>
              <div style={{ flex: 1, minWidth: 0 }}>
                <div style={{ fontSize: 13.5, fontWeight: 700, color: PAPER }}>{t("recTitle")}</div>
                <div style={{ fontSize: 12.5, color: PAPER, marginTop: 2 }}>{recCarbs} g carbs + {recProt} g {lang === "nl" ? "eiwit" : "protein"}</div>
                <div style={{ fontSize: 11, color: MUTED, marginTop: 3, lineHeight: 1.5 }}>{lang === "nl" ? "Binnen ~2 u na de finish. Bijv. kip + rijst, of een shake + banaan. Blijf drinken." : "Within ~2h of finishing. E.g. chicken + rice, or a shake + banana. Keep drinking."}</div>
              </div>
            </div>
          </div>

          {/* Hydratatie */}
          <div style={card}>
            <div style={capTitle}>{t("hydraTitle")}</div>
            <div style={{ display: "grid", gap: 8, fontSize: 12.5, color: PAPER }}>
              <div style={{ display: "flex", justifyContent: "space-between" }}><span style={{ color: MUTED }}>{lang === "nl" ? "4 u vóór" : "4h before"}</span><span>{preFluid} ml</span></div>
              <div style={{ display: "flex", justifyContent: "space-between" }}><span style={{ color: MUTED }}>{lang === "nl" ? "Tijdens (per uur)" : "During (per hour)"}</span><span>{perHrLow}–{perHrHigh} ml</span></div>
              <div style={{ display: "flex", justifyContent: "space-between" }}><span style={{ color: MUTED }}>{lang === "nl" ? "Natrium (per uur)" : "Sodium (per hour)"}</span><span>{sodium}</span></div>
            </div>
            <div style={{ fontSize: 11, color: MUTED, marginTop: 10, lineHeight: 1.5 }}>{lang === "nl" ? "Drink op dorst, niet overmatig. Heldere-gele plas vóór de start = goed gehydrateerd." : "Drink to thirst, don't overdo it. Pale-yellow urine before the start = well hydrated."}</div>
          </div>

          {/* Koppel aan dagboek */}
          <div style={{ ...card, border: `1px solid ${EMBER}`, backgroundImage: "radial-gradient(120% 90% at 0% 0%, rgba(225,29,72,0.13), transparent 60%)" }}>
            <div style={capTitle}>{t("linkTitle")}</div>
            {!hasPlan ? (
              <div style={{ fontSize: 12, color: MUTED, lineHeight: 1.5 }}>{t("linkNoPlan")}</div>
            ) : linked.length ? (
              <>
                <div style={{ fontSize: 12.5, color: PAPER, lineHeight: 1.5, marginBottom: 12 }}>{t("linkDone")}</div>
                <button onClick={unlinkDiary} style={{ background: "transparent", color: EMBER, border: `1px solid ${EMBER}`, borderRadius: 9, padding: "9px 16px", ...disp, fontWeight: 700, fontSize: 12.5, letterSpacing: 0.5, cursor: "pointer" }}>{t("unlinkBtn")}</button>
              </>
            ) : (
              <>
                <div style={{ fontSize: 11.5, color: MUTED, lineHeight: 1.55, marginBottom: 12 }}>{t("linkNote")}</div>
                <button onClick={linkDiary} style={{ background: EMBER, color: PAPER, border: "none", borderRadius: 9, padding: "11px 18px", ...disp, fontWeight: 700, fontSize: 13, letterSpacing: 0.5, cursor: "pointer" }}>{t("linkBtn")}</button>
              </>
            )}
          </div>

          <div style={{ fontSize: 10.5, color: MUTED, lineHeight: 1.6, padding: "2px 2px 6px" }}>{t("disclaimer")}</div>
        </>
      )}
    </div>
  );
}
