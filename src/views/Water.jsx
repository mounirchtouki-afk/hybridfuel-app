import React, { useState, useEffect } from "react";
import { INK, INK2, EMBER, EMBER_SOFT, PAPER, MUTED, LINE, disp, num, card, label, input, sectionTitle, load, save, todayISO, jsDayToIdx, mlShow, vUnit, kgShow, kgStore, bUnit, FLOZ_ML } from "../shared.js";
import { supabase } from "../supabaseClient.js";

const T = {
  title: { nl: "Water", en: "Water" },
  sub: { nl: "Je dagdoel op basis van je gewicht, met een extra op trainingsdagen.", en: "Your daily goal based on bodyweight, with a bump on training days." },
  goal: { nl: "Dagdoel", en: "Daily goal" },
  left: { nl: "nog te gaan", en: "to go" },
  done: { nl: "Doel gehaald", en: "Goal reached" },
  add: { nl: "Snel toevoegen", en: "Quick add" },
  glass: { nl: "Glas", en: "Glass" },
  bottle: { nl: "Fles", en: "Bottle" },
  big: { nl: "Bidon", en: "Big" },
  undo: { nl: "Terug", en: "Undo" },
  reset: { nl: "Reset", en: "Reset" },
  training: { nl: "Trainingsdag vandaag", en: "Training day today" },
  weightQ: { nl: "Vul je gewicht in voor je waterdoel.", en: "Enter your weight for your water goal." },
  weightKg: { nl: "Gewicht (kg)", en: "Weight (kg)" },
  basedOn: { nl: "op basis van", en: "based on" },
  trainBonus: { nl: "+ trainingsdag", en: "+ training day" },
};

const ML_PER_KG = 35;
const TRAIN_BONUS = 500;
const GLASS = 250, BOTTLE = 500, BIG = 750;

function Ring({ pct }) {
  const R = 78, C = 2 * Math.PI * R;
  const off = C * (1 - Math.min(1, pct));
  return (
    <svg viewBox="0 0 180 180" style={{ width: 180, height: 180, display: "block" }}>
      <circle cx="90" cy="90" r={R} fill="none" stroke={LINE} strokeWidth="12" />
      <circle cx="90" cy="90" r={R} fill="none" stroke={EMBER} strokeWidth="12" strokeLinecap="round"
        strokeDasharray={C} strokeDashoffset={off} transform="rotate(-90 90 90)" style={{ transition: "stroke-dashoffset .45s ease" }} />
    </svg>
  );
}

export default function Water({ lang, session, week, units }) {
  const t = (k) => (T[k] ? T[k][lang] : k);
  const vu = vUnit(units), bu = bUnit(units);
  const today = todayISO();
  const cloud = !!(session && supabase);

  // Trainingsdag van vandaag uit het plan afleiden (overschrijfbaar).
  const planTrain = (() => {
    try {
      const idx = jsDayToIdx(new Date().getDay());
      return !!(week && week.days && week.days[idx] && week.days[idx].train);
    } catch (e) { return false; }
  })();
  const [train, setTrain] = useState(planTrain);
  const [ml, setMl] = useState(() => (cloud ? 0 : (load("hf_water", {})[today] || 0)));
  const [kg, setKg] = useState(0);
  const [manualKg, setManualKg] = useState(() => load("hf_water_weight", ""));

  // Gewicht ophalen: cloud laatste weging, anders lokale wegingen, anders handmatig.
  useEffect(() => {
    let active = true;
    if (cloud) {
      supabase.from("weights").select("kg,date").eq("user_id", session.user.id).order("date", { ascending: false }).limit(1)
        .then(({ data }) => { if (active && data && data[0]) setKg(Number(data[0].kg)); });
      supabase.from("water_logs").select("ml").eq("user_id", session.user.id).eq("date", today)
        .then(({ data }) => { if (active && data && data[0]) setMl(data[0].ml || 0); });
    } else {
      const ws = load("hf_weights", []);
      if (ws.length) { const s = [...ws].sort((a, b) => a.date.localeCompare(b.date)); setKg(Number(s[s.length - 1].kg)); }
    }
    return () => { active = false; };
  }, [session]);

  const effKg = num(manualKg) > 0 ? num(manualKg) : kg;
  const goal = effKg > 0 ? Math.round((ML_PER_KG * effKg + (train ? TRAIN_BONUS : 0)) / 50) * 50 : 0;
  const pct = goal > 0 ? ml / goal : 0;
  const leftMl = Math.max(0, goal - ml);

  function persist(next) {
    setMl(next);
    if (cloud) { supabase.from("water_logs").upsert({ user_id: session.user.id, date: today, ml: next }, { onConflict: "user_id,date" }).then(() => {}, () => {}); }
    else { const all = load("hf_water", {}); all[today] = next; save("hf_water", all); }
  }
  const add = (d) => persist(Math.max(0, ml + d));
  const setKgManual = (v) => { setManualKg(v); save("hf_water_weight", v); };

  // Snelknoppen per eenheidssysteem: metrisch 250/500/750 ml, imperiaal 8/16/24 fl oz.
  const addMl = (a) => (units === "imperial" ? Math.round(a * FLOZ_ML) : a);
  const quick = units === "imperial"
    ? [[8, t("glass")], [16, t("bottle")], [24, t("big")]]
    : [[250, t("glass")], [500, t("bottle")], [750, t("big")]];
  const undoMl = addMl(quick[0][0]);

  const addBtn = (lbl, dispAmt) => (
    <div onClick={() => add(addMl(dispAmt))} style={{ flex: 1, background: INK, border: `1px solid ${LINE}`, borderRadius: 12, padding: "12px 6px", textAlign: "center", cursor: "pointer" }}>
      <div style={{ ...disp, fontSize: 18, fontWeight: 700, color: EMBER }}>+{dispAmt}</div>
      <div style={{ fontSize: 10.5, color: MUTED, fontWeight: 600, marginTop: 1 }}>{lbl}</div>
    </div>
  );

  return (
    <div style={{ display: "grid", gap: 16 }}>
      <div>
        <div style={sectionTitle}>{t("title")}</div>
        <div style={{ fontSize: 12, color: MUTED, marginTop: 5, lineHeight: 1.5 }}>{t("sub")}</div>
      </div>

      <div style={{ ...card, display: "flex", flexDirection: "column", alignItems: "center", paddingTop: 22, paddingBottom: 22 }}>
        <div style={{ position: "relative", width: 180, height: 180 }}>
          <Ring pct={pct} />
          <div style={{ position: "absolute", inset: 0, display: "flex", flexDirection: "column", alignItems: "center", justifyContent: "center" }}>
            <div style={{ ...disp, fontSize: 32, fontWeight: 700, color: PAPER, lineHeight: 1 }}>{mlShow(ml, units)}<span style={{ fontSize: 15, color: MUTED }}>/{goal > 0 ? mlShow(goal, units) + vu : "—"}</span></div>
            <div style={{ fontSize: 11.5, color: pct >= 1 ? EMBER_SOFT : MUTED, marginTop: 6, fontWeight: 600, textAlign: "center", padding: "0 20px" }}>
              {goal <= 0 ? t("weightQ") : (pct >= 1 ? t("done") : mlShow(leftMl, units) + " " + vu + " " + t("left"))}
            </div>
          </div>
        </div>
        {goal > 0 && (
          <div style={{ fontSize: 11, color: MUTED, marginTop: 14, textAlign: "center" }}>
            {t("goal")}: <span style={{ color: PAPER, fontWeight: 600 }}>{mlShow(goal, units)} {vu}</span> · {t("basedOn")} {kgShow(effKg, units)} {bu}{train ? " " + t("trainBonus") : ""}
          </div>
        )}
      </div>

      <div style={card}>
          <div style={{ ...label, marginBottom: 12 }}>{t("add")}</div>
          <div style={{ display: "flex", gap: 10, marginBottom: 12 }}>
            {quick.map(([a, l]) => <React.Fragment key={a}>{addBtn(l, a)}</React.Fragment>)}
          </div>
          <div style={{ display: "flex", gap: 10 }}>
            <div onClick={() => add(-undoMl)} style={{ flex: 1, textAlign: "center", padding: "9px 0", borderRadius: 8, border: `1px solid ${LINE}`, color: MUTED, fontSize: 12.5, fontWeight: 600, cursor: "pointer" }}>− {t("undo")}</div>
            <div onClick={() => persist(0)} style={{ flex: 1, textAlign: "center", padding: "9px 0", borderRadius: 8, border: `1px solid ${LINE}`, color: MUTED, fontSize: 12.5, fontWeight: 600, cursor: "pointer" }}>{t("reset")}</div>
          </div>
        </div>

      <div style={card}>
        <div style={{ display: "flex", alignItems: "center", justifyContent: "space-between", marginBottom: 14 }}>
          <span style={{ fontSize: 13, color: PAPER, fontWeight: 600 }}>{(lang === "nl" ? "Gewicht" : "Weight")} ({bu})</span>
          <div style={{ display: "flex", alignItems: "center", gap: 6 }}>
            <input value={manualKg !== "" ? kgShow(num(manualKg), units) : (kg > 0 ? kgShow(kg, units) : "")} onChange={(e) => setKgManual(String(kgStore(e.target.value, units)))} inputMode="decimal" placeholder={units === "imperial" ? "190" : "87"} style={{ width: 64, textAlign: "right", background: INK, border: `1px solid ${LINE}`, color: PAPER, padding: "7px 8px", borderRadius: 8, fontSize: 14, outline: "none" }} />
            <span style={{ fontSize: 12, color: MUTED }}>{bu}</span>
          </div>
        </div>
        <div style={{ height: 1, background: LINE, marginBottom: 14 }} />
        <div style={{ display: "flex", alignItems: "center", justifyContent: "space-between" }}>
          <span style={{ fontSize: 13, color: PAPER, fontWeight: 600 }}>{t("training")}</span>
          <div onClick={() => setTrain(!train)} style={{ width: 46, height: 26, borderRadius: 20, background: train ? EMBER : LINE, position: "relative", cursor: "pointer", transition: "background .2s" }}>
            <div style={{ position: "absolute", top: 3, left: train ? 23 : 3, width: 20, height: 20, borderRadius: "50%", background: PAPER, transition: "left .2s" }} />
          </div>
        </div>
      </div>
    </div>
  );
}
