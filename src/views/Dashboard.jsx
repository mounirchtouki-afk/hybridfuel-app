import React, { useState, useEffect } from "react";
import { INK, INK2, EMBER, EMBER_SOFT, PAPER, MUTED, LINE, SAGE, disp, num, sectionTitle, load, save, todayISO, WD, jsDayToIdx } from "../shared.js";
import { supabase } from "../supabaseClient.js";

const T = {
  morning: { nl: "Goedemorgen", en: "Good morning" },
  afternoon: { nl: "Goedemiddag", en: "Good afternoon" },
  evening: { nl: "Goedenavond", en: "Good evening" },
  athlete: { nl: "atleet", en: "athlete" },
  sub: { nl: "Je dag in één oogopslag.", en: "Your day at a glance." },
  today: { nl: "Vandaag", en: "Today" },
  calories: { nl: "Calorieën", en: "Calories" },
  mealsDone: { nl: "maaltijden afgevinkt", en: "meals checked" },
  water: { nl: "Water", en: "Water" },
  weight: { nl: "Gewicht", en: "Weight" },
  noWeight: { nl: "Nog niet gewogen", en: "Not logged yet" },
  race: { nl: "Hyrox", en: "Hyrox" },
  raceIn: { nl: "nog", en: "in" },
  days: { nl: "dagen", en: "days" },
  dayTomorrow: { nl: "morgen", en: "tomorrow" },
  dayToday: { nl: "vandaag", en: "today" },
  menu: { nl: "Vandaag op het menu", en: "Today's menu" },
  extraLogged: { nl: "Extra gelogd", en: "Logged extra" },
  extra: { nl: "Extra", en: "Extra" },
  noPlan: { nl: "Nog geen plan — maak je weekplan aan.", en: "No plan yet — build your week plan." },
  train: { nl: "Training", en: "Training" },
  rest: { nl: "Rust", en: "Rest" },
  customize: { nl: "Aanpassen", en: "Customize" },
  doneTxt: { nl: "Klaar", en: "Done" },
  custHint: { nl: "Kies wat je op je dashboard ziet.", en: "Choose what you see on your dashboard." },
  planRace: { nl: "Plan je Hyrox", en: "Plan your Hyrox" },
  planRaceSub: { nl: "Stel je Race Protocol in voor race-dag.", en: "Set up your Race Protocol for race day." },
};

function Ring({ pct, size = 58 }) {
  const R = size / 2 - 5, C = 2 * Math.PI * R, off = C * (1 - Math.max(0, Math.min(1, pct)));
  return (
    <svg width={size} height={size} viewBox={`0 0 ${size} ${size}`}>
      <circle cx={size / 2} cy={size / 2} r={R} fill="none" stroke="rgba(255,255,255,0.18)" strokeWidth="5" />
      <circle cx={size / 2} cy={size / 2} r={R} fill="none" stroke={PAPER} strokeWidth="5" strokeLinecap="round" strokeDasharray={C} strokeDashoffset={off} transform={`rotate(-90 ${size / 2} ${size / 2})`} />
      <text x={size / 2} y={size / 2 + 4} textAnchor="middle" fill={PAPER} fontSize="13" fontFamily="Oswald" fontWeight="600">{Math.round(pct * 100)}%</text>
    </svg>
  );
}

export default function Dashboard({ lang, session, week, targets, onGo }) {
  const t = (k) => (T[k] ? T[k][lang] : k);
  const cloud = !!(session && supabase);
  const d = todayISO();
  const [eaten, setEaten] = useState(() => load("hf_eaten_" + d, {}));
  const [extras, setExtras] = useState([]);
  const [waterMl, setWaterMl] = useState(0);
  const [weightKg, setWeightKg] = useState(0);
  const [race] = useState(() => load("hf_race", {}));
  const [prefs, setPrefs] = useState(() => load("hf_dash", null) || { water: true, weight: true, race: true, menu: true });
  const [cust, setCust] = useState(false);
  const setPref = (k, v) => { const n = { ...prefs, [k]: v }; setPrefs(n); save("hf_dash", n); };

  useEffect(() => {
    let active = true;
    setEaten(load("hf_eaten_" + d, {}));
    const mw = num(load("hf_water_weight", ""));
    if (mw > 0) setWeightKg(mw);
    if (cloud) {
      supabase.from("food_logs").select("id,item,kcal,p,c,f").eq("user_id", session.user.id).eq("date", d).then(({ data }) => { if (active && data) setExtras(data); }, () => {});
      supabase.from("water_logs").select("ml").eq("user_id", session.user.id).eq("date", d).then(({ data }) => { if (active) setWaterMl((data && data[0] && data[0].ml) || 0); }, () => {});
      if (mw <= 0) supabase.from("weights").select("kg").eq("user_id", session.user.id).order("date", { ascending: false }).limit(1).then(({ data }) => { if (active && data && data[0]) setWeightKg(Number(data[0].kg)); }, () => {});
    } else {
      setExtras(load("hf_food_" + d, []));
      setWaterMl((load("hf_water", {})[d]) || 0);
      if (mw <= 0) { const ws = load("hf_weights", []); if (ws.length) { const s = [...ws].sort((a, b) => a.date.localeCompare(b.date)); setWeightKg(Number(s[s.length - 1].kg)); } }
    }
    return () => { active = false; };
  }, [session]);

  const hr = new Date().getHours();
  const greet = hr < 12 ? t("morning") : hr < 18 ? t("afternoon") : t("evening");
  const savedName = ((session && session.user && session.user.user_metadata && session.user.user_metadata.display_name) || load("hf_name", "") || "").trim();
  const name = savedName || (session && session.user && session.user.email ? session.user.email.split("@")[0] : t("athlete"));

  const idx = jsDayToIdx(new Date(d + "T12:00:00").getDay());
  const day = week && week.days && week.days.length ? (week.days[idx] || week.days[0]) : null;
  const goalKcal = day ? day.m.reduce((a, m) => a + num(m.kcal), 0) : (targets && targets.kcal) || 0;
  const eatenPlanned = day ? day.m.reduce((a, m, i) => a + (eaten[i] ? num(m.kcal) : 0), 0) : 0;
  const consumed = eatenPlanned + extras.reduce((a, x) => a + num(x.kcal), 0);
  const pct = goalKcal ? consumed / goalKcal : 0;
  const nMeals = day ? day.m.length : 0;
  const nDone = day ? day.m.filter((_, i) => eaten[i]).length : 0;
  const waterGoal = weightKg > 0 ? Math.round((35 * weightKg + (day && day.train ? 500 : 0)) / 50) * 50 : 0;

  // Race-aftelling
  let cd = null;
  if (race && race.date) { const today = new Date(); today.setHours(0, 0, 0, 0); const rd = new Date(race.date + "T12:00:00"); rd.setHours(0, 0, 0, 0); cd = Math.round((rd - today) / 86400000); }

  const smallCard = (label, value, sub, onClick, accent) => (
    <div onClick={onClick} style={{ flex: 1, background: INK2, border: `1px solid ${LINE}`, borderRadius: 14, padding: "13px 14px", cursor: onClick ? "pointer" : "default" }}>
      <div style={{ fontSize: 10, letterSpacing: 1, textTransform: "uppercase", color: MUTED, fontWeight: 600 }}>{label}</div>
      <div style={{ ...disp, fontSize: 21, fontWeight: 700, color: accent || PAPER, marginTop: 4, lineHeight: 1 }}>{value}</div>
      {sub && <div style={{ fontSize: 10.5, color: MUTED, marginTop: 3 }}>{sub}</div>}
    </div>
  );
  const Toggle = ({ on, onClick }) => (
    <div onClick={onClick} style={{ width: 42, height: 24, borderRadius: 12, background: on ? EMBER : LINE, position: "relative", cursor: "pointer", flexShrink: 0, transition: "background .15s" }}>
      <div style={{ position: "absolute", top: 2, left: on ? 20 : 2, width: 20, height: 20, borderRadius: "50%", background: PAPER, transition: "left .15s" }} />
    </div>
  );
  const custRow = (k, label) => (
    <div style={{ display: "flex", justifyContent: "space-between", alignItems: "center", padding: "9px 0", borderBottom: `1px solid ${LINE}` }}>
      <span style={{ fontSize: 13, color: PAPER, fontWeight: 600 }}>{label}</span>
      <Toggle on={!!prefs[k]} onClick={() => setPref(k, !prefs[k])} />
    </div>
  );

  return (
    <div style={{ display: "grid", gap: 16 }}>
      {/* Greeting */}
      <div style={{ display: "flex", justifyContent: "space-between", alignItems: "flex-start", gap: 12 }}>
        <div style={{ minWidth: 0 }}>
          <div style={{ ...disp, fontSize: 24, fontWeight: 700, letterSpacing: -0.3 }}>{greet}, <span style={{ color: EMBER, textTransform: "capitalize" }}>{name}</span></div>
          <div style={{ fontSize: 12.5, color: MUTED, marginTop: 3 }}>{t("sub")}</div>
        </div>
        <div onClick={() => setCust(!cust)} style={{ cursor: "pointer", flexShrink: 0, display: "flex", alignItems: "center", gap: 5, border: `1px solid ${cust ? EMBER : LINE}`, color: cust ? EMBER : MUTED, borderRadius: 8, padding: "6px 10px", fontSize: 11.5, fontWeight: 600, marginTop: 4 }}>
          <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><circle cx="12" cy="12" r="3" /><path d="M19.4 15a1.65 1.65 0 00.33 1.82l.06.06a2 2 0 11-2.83 2.83l-.06-.06a1.65 1.65 0 00-1.82-.33 1.65 1.65 0 00-1 1.51V21a2 2 0 11-4 0v-.09A1.65 1.65 0 009 19.4a1.65 1.65 0 00-1.82.33l-.06.06a2 2 0 11-2.83-2.83l.06-.06a1.65 1.65 0 00.33-1.82 1.65 1.65 0 00-1.51-1H3a2 2 0 110-4h.09A1.65 1.65 0 004.6 9a1.65 1.65 0 00-.33-1.82l-.06-.06a2 2 0 112.83-2.83l.06.06a1.65 1.65 0 001.82.33H9a1.65 1.65 0 001-1.51V3a2 2 0 114 0v.09a1.65 1.65 0 001 1.51 1.65 1.65 0 001.82-.33l.06-.06a2 2 0 112.83 2.83l-.06.06a1.65 1.65 0 00-.33 1.82V9a1.65 1.65 0 001.51 1H21a2 2 0 110 4h-.09a1.65 1.65 0 00-1.51 1z" /></svg>
          {cust ? t("doneTxt") : t("customize")}
        </div>
      </div>

      {/* Aanpas-paneel */}
      {cust && (
        <div style={{ background: INK2, border: `1px solid ${EMBER}`, borderRadius: 14, padding: "6px 14px 10px" }}>
          <div style={{ fontSize: 11.5, color: MUTED, lineHeight: 1.4, margin: "10px 0 2px" }}>{t("custHint")}</div>
          {custRow("water", t("water"))}
          {custRow("weight", t("weight"))}
          {custRow("race", t("race") + " (Race Protocol)")}
          <div style={{ display: "flex", justifyContent: "space-between", alignItems: "center", padding: "9px 0" }}>
            <span style={{ fontSize: 13, color: PAPER, fontWeight: 600 }}>{t("menu")}</span>
            <Toggle on={!!prefs.menu} onClick={() => setPref("menu", !prefs.menu)} />
          </div>
        </div>
      )}

      {/* Vandaag — grote kaart */}
      <div onClick={() => onGo("today")} style={{ cursor: "pointer", borderRadius: 18, padding: 18, background: `linear-gradient(135deg, ${EMBER} 0%, #9f1239 100%)`, position: "relative", overflow: "hidden" }}>
        <div style={{ display: "flex", justifyContent: "space-between", alignItems: "center" }}>
          <div>
            <div style={{ fontSize: 11, letterSpacing: 1.5, textTransform: "uppercase", color: "rgba(255,255,255,0.85)", fontWeight: 700 }}>{t("today")}</div>
            <div style={{ ...disp, fontSize: 30, fontWeight: 700, color: PAPER, lineHeight: 1.1, marginTop: 4 }}>{Math.round(consumed)}<span style={{ fontSize: 15, color: "rgba(255,255,255,0.8)", fontWeight: 500 }}> / {Math.round(goalKcal)} kcal</span></div>
            <div style={{ fontSize: 11.5, color: "rgba(255,255,255,0.9)", marginTop: 6 }}>{day ? `${nDone}/${nMeals} ${t("mealsDone")}` : t("noPlan")}</div>
          </div>
          <Ring pct={pct} size={64} />
        </div>
      </div>

      {/* Water + Gewicht */}
      {(prefs.water || prefs.weight) && (
        <div style={{ display: "flex", gap: 12 }}>
          {prefs.water && smallCard(t("water"), waterGoal ? `${Math.round(waterMl / 100) / 10}L` : "—", waterGoal ? `/ ${Math.round(waterGoal / 100) / 10}L` : "", () => onGo("water"), EMBER_SOFT)}
          {prefs.weight && smallCard(t("weight"), weightKg > 0 ? `${weightKg} kg` : "—", weightKg > 0 ? "" : t("noWeight"), () => onGo("tracker"))}
        </div>
      )}

      {/* Race-aftelling of uitnodiging */}
      {prefs.race && (cd !== null ? (
        <div onClick={() => onGo("race")} style={{ cursor: "pointer", display: "flex", justifyContent: "space-between", alignItems: "center", background: INK2, border: `1px solid ${EMBER}`, borderRadius: 14, padding: "14px 16px", backgroundImage: "radial-gradient(120% 90% at 100% 0%, rgba(225,29,72,0.16), transparent 60%)" }}>
          <div style={{ display: "flex", alignItems: "center", gap: 10 }}>
            <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke={EMBER} strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><circle cx="12" cy="13" r="8" /><path d="M12 13V8.5M12 3.5V2M9.5 2h5" /></svg>
            <div><div style={{ ...disp, fontWeight: 700, fontSize: 15 }}>{t("race")}</div><div style={{ fontSize: 10.5, color: MUTED }}>Race Protocol</div></div>
          </div>
          <div style={{ textAlign: "right" }}>
            <div style={{ ...disp, fontSize: 24, fontWeight: 700, color: EMBER, lineHeight: 1 }}>{cd <= 0 ? "0" : cd}</div>
            <div style={{ fontSize: 9.5, color: MUTED, letterSpacing: 1, textTransform: "uppercase" }}>{cd === 1 ? t("dayTomorrow") : cd <= 0 ? t("dayToday") : t("days")}</div>
          </div>
        </div>
      ) : (
        <div onClick={() => onGo("race")} style={{ cursor: "pointer", display: "flex", justifyContent: "space-between", alignItems: "center", background: INK2, border: `1px dashed ${LINE}`, borderRadius: 14, padding: "14px 16px" }}>
          <div style={{ display: "flex", alignItems: "center", gap: 10, minWidth: 0 }}>
            <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke={EMBER} strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><circle cx="12" cy="13" r="8" /><path d="M12 13V8.5M12 3.5V2M9.5 2h5" /></svg>
            <div style={{ minWidth: 0 }}><div style={{ ...disp, fontWeight: 700, fontSize: 14.5 }}>{t("planRace")}</div><div style={{ fontSize: 10.5, color: MUTED, marginTop: 1 }}>{t("planRaceSub")}</div></div>
          </div>
          <div style={{ color: EMBER, fontSize: 22, fontWeight: 300, flexShrink: 0, paddingLeft: 8 }}>›</div>
        </div>
      ))}

      {/* Vandaag op het menu + extra gelogd */}
      {prefs.menu && ((day && day.m.length > 0) || extras.length > 0) && (
        <div>
          <div style={{ display: "flex", justifyContent: "space-between", alignItems: "center", marginBottom: 10 }}>
            <div style={{ ...disp, fontSize: 11.5, fontWeight: 700, letterSpacing: 1, textTransform: "uppercase", color: EMBER }}>{t("menu")}</div>
            {day && <div style={{ fontSize: 9.5, color: day.train ? EMBER : MUTED, border: `1px solid ${day.train ? EMBER : LINE}`, borderRadius: 5, padding: "2px 7px", letterSpacing: 1, fontWeight: 700 }}>{day.train ? t("train") : t("rest")}</div>}
          </div>
          <div style={{ display: "grid", gap: 8 }}>
            {day && day.m.map((m, i) => (
              <div key={i} onClick={() => onGo("today")} style={{ cursor: "pointer", display: "flex", justifyContent: "space-between", alignItems: "center", background: INK2, border: `1px solid ${eaten[i] ? EMBER : LINE}`, borderRadius: 12, padding: "11px 14px", opacity: eaten[i] ? 0.7 : 1 }}>
                <div style={{ minWidth: 0 }}>
                  <div style={{ fontSize: 9.5, color: EMBER, letterSpacing: 1, textTransform: "uppercase", fontWeight: 600 }}>{m.t}</div>
                  <div style={{ fontSize: 13.5, fontWeight: 500, color: PAPER, textDecoration: eaten[i] ? "line-through" : "none" }}>{m.n}</div>
                </div>
                <div style={{ fontSize: 11.5, color: MUTED, whiteSpace: "nowrap", paddingLeft: 10 }}><span style={{ color: PAPER, fontWeight: 600 }}>{m.kcal}</span> kcal</div>
              </div>
            ))}
            {extras.map((x, i) => (
              <div key={"x" + (x.id || i)} onClick={() => onGo("today")} style={{ cursor: "pointer", display: "flex", justifyContent: "space-between", alignItems: "center", background: INK2, border: `1px dashed ${SAGE}`, borderRadius: 12, padding: "11px 14px" }}>
                <div style={{ minWidth: 0 }}>
                  <div style={{ fontSize: 9.5, color: SAGE, letterSpacing: 1, textTransform: "uppercase", fontWeight: 600 }}>{t("extra")}</div>
                  <div style={{ fontSize: 13.5, fontWeight: 500, color: PAPER }}>{x.item || x.name || t("extraLogged")}</div>
                </div>
                <div style={{ fontSize: 11.5, color: MUTED, whiteSpace: "nowrap", paddingLeft: 10 }}><span style={{ color: PAPER, fontWeight: 600 }}>{num(x.kcal)}</span> kcal</div>
              </div>
            ))}
          </div>
        </div>
      )}
      {!day && (
        <div onClick={() => onGo("plan")} style={{ cursor: "pointer", border: `1px dashed ${LINE}`, borderRadius: 14, padding: "22px", textAlign: "center", fontSize: 13, color: MUTED }}>{t("noPlan")}</div>
      )}
    </div>
  );
}
