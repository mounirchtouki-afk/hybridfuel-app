import React, { useState, useEffect } from "react";
import { INK, INK2, EMBER, EMBER_SOFT, PAPER, MUTED, LINE, SAGE, disp, num, card, label, input, sectionTitle, primaryBtn, load, save, todayISO, fmtDate, kgShow, kgStore, bUnit } from "../shared.js";
import { supabase } from "../supabaseClient.js";

const T = {
  title: { nl: "Voortgang", en: "Progress" },
  sub: { nl: "Log je gewicht en volg de trend.", en: "Log your weight and watch the trend." },
  current: { nl: "Huidig gewicht", en: "Current weight" },
  change: { nl: "Laatste verandering", en: "Last change" },
  bmiLbl: { nl: "BMI", en: "BMI" },
  logTitle: { nl: "Weging toevoegen", en: "Add weigh-in" },
  date: { nl: "Datum", en: "Date" },
  weightKg: { nl: "Gewicht (kg)", en: "Weight (kg)" },
  heightCm: { nl: "Lengte (cm)", en: "Height (cm)" },
  logBtn: { nl: "Loggen", en: "Log" },
  history: { nl: "Historie", en: "History" },
  empty: { nl: "Nog geen wegingen. Voeg je eerste toe — dan verschijnt je trend hier.", en: "No weigh-ins yet. Add your first — your trend shows up here." },
  trend: { nl: "Gewichtstrend", en: "Weight trend" },
  needHeight: { nl: "Vul je lengte in voor je BMI.", en: "Enter your height for your BMI." },
  cat: { under: { nl: "Ondergewicht", en: "Underweight" }, healthy: { nl: "Gezond", en: "Healthy" }, over: { nl: "Overgewicht", en: "Overweight" }, obese: { nl: "Obesitas", en: "Obese" } },
  pace: { nl: "Verantwoord tempo is ~0,5–1% van je gewicht per week. Sneller kost spier en herstel.", en: "A responsible pace is ~0.5–1% of bodyweight per week. Faster costs muscle and recovery." },
  kg: { nl: "kg", en: "kg" },
};

function Chart({ data }) {
  // data: [{date, kg}] oplopend op datum
  const W = 320, H = 150, P = 22;
  if (data.length < 2) return null;
  const xs = data.map((_, i) => i);
  const ys = data.map((d) => d.kg);
  const minY = Math.min(...ys), maxY = Math.max(...ys);
  const padY = Math.max(0.5, (maxY - minY) * 0.15);
  const lo = minY - padY, hi = maxY + padY;
  const X = (i) => P + (i / (data.length - 1)) * (W - 2 * P);
  const Y = (v) => H - P - ((v - lo) / (hi - lo || 1)) * (H - 2 * P);
  const pts = data.map((d, i) => `${X(i)},${Y(d.kg)}`).join(" ");
  const areaPts = `${X(0)},${H - P} ${pts} ${X(data.length - 1)},${H - P}`;
  return (
    <svg viewBox={`0 0 ${W} ${H}`} style={{ width: "100%", height: "auto", display: "block" }}>
      <defs>
        <linearGradient id="wg" x1="0" y1="0" x2="0" y2="1">
          <stop offset="0%" stopColor={EMBER} stopOpacity="0.25" />
          <stop offset="100%" stopColor={EMBER} stopOpacity="0" />
        </linearGradient>
      </defs>
      <line x1={P} y1={H - P} x2={W - P} y2={H - P} stroke={LINE} strokeWidth="1" />
      <polygon points={areaPts} fill="url(#wg)" />
      <polyline points={pts} fill="none" stroke={EMBER} strokeWidth="2.5" strokeLinejoin="round" strokeLinecap="round" />
      {data.map((d, i) => <circle key={i} cx={X(i)} cy={Y(d.kg)} r={i === data.length - 1 ? 4 : 2.5} fill={i === data.length - 1 ? PAPER : EMBER} />)}
      <text x={P} y={14} fill={MUTED} fontSize="9" fontFamily="Inter">{hi.toFixed(1)}</text>
      <text x={P} y={H - P + 14} fill={MUTED} fontSize="9" fontFamily="Inter">{lo.toFixed(1)}</text>
    </svg>
  );
}

export default function Tracker({ lang, height: appHeight, session, units }) {
  const t = (k) => (T[k] ? T[k][lang] : k);
  const bu = bUnit(units);
  const [weights, setWeights] = useState(() => load("hf_weights", []));
  const [height, setHeight] = useState(() => load("hf_height", appHeight ? String(appHeight) : ""));
  const [d, setD] = useState(todayISO());
  const [kg, setKg] = useState("");

  const cloud = !!(session && supabase);
  // Bij een sessie: wegingen uit Supabase laden (anders blijft 't lokaal).
  useEffect(() => {
    let active = true;
    if (cloud) {
      supabase.from("weights").select("date,kg").eq("user_id", session.user.id).order("date")
        .then(({ data }) => { if (active && data) setWeights(data.map((r) => ({ date: r.date, kg: Number(r.kg) }))); });
    }
    return () => { active = false; };
  }, [session]);

  const sorted = [...weights].sort((a, b) => a.date.localeCompare(b.date));
  const latest = sorted.length ? sorted[sorted.length - 1] : null;
  const prev = sorted.length > 1 ? sorted[sorted.length - 2] : null;
  const change = latest && prev ? Math.round((latest.kg - prev.kg) * 10) / 10 : null;
  const h = num(height);
  const bmi = latest && h > 0 ? Math.round((latest.kg / Math.pow(h / 100, 2)) * 10) / 10 : null;
  const bmiCat = bmi == null ? null : bmi < 18.5 ? T.cat.under[lang] : bmi < 25 ? T.cat.healthy[lang] : bmi < 30 ? T.cat.over[lang] : T.cat.obese[lang];
  const bmiColor = bmi == null ? MUTED : bmi < 18.5 ? EMBER_SOFT : bmi < 25 ? "#4ADE80" : bmi < 30 ? "#FACC15" : EMBER;

  function addLog() {
    const v = kgStore(num(kg), units);
    if (!(v > 0) || !d) return;
    const entry = { date: d, kg: Math.round(v * 10) / 10 };
    const next = [...weights.filter((w) => w.date !== d), entry];
    setWeights(next); setKg("");
    if (cloud) { supabase.from("weights").upsert({ user_id: session.user.id, date: entry.date, kg: entry.kg }, { onConflict: "user_id,date" }).then(() => {}, () => {}); }
    else { save("hf_weights", next); }
  }
  function del(date) {
    const next = weights.filter((w) => w.date !== date);
    setWeights(next);
    if (cloud) { supabase.from("weights").delete().eq("user_id", session.user.id).eq("date", date).then(() => {}, () => {}); }
    else { save("hf_weights", next); }
  }
  function setH(v) { setHeight(v); save("hf_height", v); }

  const stat = (lbl, val, sub, color) => (
    <div style={{ flex: 1, background: INK, borderRadius: 10, padding: "11px 13px", borderLeft: `3px solid ${color || EMBER}` }}>
      <div style={{ fontSize: 10, letterSpacing: 1, textTransform: "uppercase", color: MUTED, fontWeight: 600 }}>{lbl}</div>
      <div style={{ ...disp, fontSize: 22, fontWeight: 600, marginTop: 2, color: PAPER }}>{val}</div>
      {sub && <div style={{ fontSize: 10.5, color: MUTED, marginTop: 1 }}>{sub}</div>}
    </div>
  );

  return (
    <div style={{ display: "grid", gap: 16 }}>
      <div>
        <div style={sectionTitle}>{t("title")}</div>
        <div style={{ fontSize: 12, color: MUTED, marginTop: 5, lineHeight: 1.5 }}>{t("sub")}</div>
      </div>

      <div style={{ display: "flex", gap: 10 }}>
        {stat(t("current"), latest ? kgShow(latest.kg, units) + " " + bu : "—", latest ? fmtDate(latest.date, lang) : null, EMBER)}
        {stat(t("change"), change == null ? "—" : (change > 0 ? "+" : "") + kgShow(change, units) + " " + bu, null, change == null ? MUTED : change <= 0 ? "#4ADE80" : EMBER_SOFT)}
        {stat(t("bmiLbl"), bmi == null ? "—" : bmi, bmiCat, bmiColor)}
      </div>

      {sorted.length >= 2 && (
        <div style={card}>
          <div style={{ ...label, marginBottom: 10 }}>{t("trend")}</div>
          <Chart data={sorted} />
        </div>
      )}

      <div style={card}>
        <div style={{ ...label, marginBottom: 12 }}>{t("logTitle")}</div>
        <div style={{ display: "grid", gridTemplateColumns: "1.3fr 1fr", gap: 10, marginBottom: 10 }}>
          <div><label style={label}>{t("date")}</label><input type="date" style={input} value={d} max={todayISO()} onChange={(e) => setD(e.target.value)} /></div>
          <div><label style={label}>{(lang === "nl" ? "Gewicht" : "Weight")} ({bu})</label><input style={input} value={kg} onChange={(e) => setKg(e.target.value)} inputMode="decimal" placeholder={units === "imperial" ? "190" : "87.0"} /></div>
        </div>
        <div style={{ marginBottom: 12 }}>
          <label style={label}>{t("heightCm")}</label>
          <input style={input} value={height} onChange={(e) => setH(e.target.value)} inputMode="numeric" placeholder="190" />
          {!(h > 0) && <div style={{ fontSize: 11, color: MUTED, marginTop: 5 }}>{t("needHeight")}</div>}
        </div>
        <button onClick={addLog} style={primaryBtn}>{t("logBtn")}</button>
      </div>

      <div style={card}>
        <div style={{ ...label, marginBottom: sorted.length ? 10 : 0 }}>{t("history")}</div>
        {!sorted.length && <div style={{ fontSize: 12.5, color: MUTED, lineHeight: 1.6 }}>{t("empty")}</div>}
        {sorted.slice().reverse().map((w, i, arr) => {
          const idx = sorted.findIndex((x) => x.date === w.date);
          const p = idx > 0 ? sorted[idx - 1] : null;
          const dc = p ? Math.round((w.kg - p.kg) * 10) / 10 : null;
          return (
            <div key={w.date} style={{ display: "flex", alignItems: "center", gap: 10, padding: "10px 0", borderBottom: i < arr.length - 1 ? `1px solid ${LINE}` : "none" }}>
              <div style={{ width: 70, fontSize: 12, color: MUTED }}>{fmtDate(w.date, lang)}</div>
              <div style={{ flex: 1, ...disp, fontSize: 16, fontWeight: 600 }}>{kgShow(w.kg, units)}<span style={{ fontSize: 11, color: MUTED, marginLeft: 3 }}>{bu}</span></div>
              <div style={{ fontSize: 12, fontWeight: 600, color: dc == null ? MUTED : dc <= 0 ? "#4ADE80" : EMBER_SOFT, width: 54, textAlign: "right" }}>{dc == null ? "" : (dc > 0 ? "+" : "") + kgShow(dc, units)}</div>
              <div onClick={() => del(w.date)} style={{ cursor: "pointer", color: MUTED, fontSize: 16, padding: "0 4px", lineHeight: 1 }} title="×">×</div>
            </div>
          );
        })}
      </div>

      <div style={{ borderLeft: `2px solid ${EMBER}`, padding: "2px 0 2px 12px" }}>
        <span style={{ fontSize: 11.5, color: MUTED, lineHeight: 1.5 }}>{t("pace")}</span>
      </div>
    </div>
  );
}
