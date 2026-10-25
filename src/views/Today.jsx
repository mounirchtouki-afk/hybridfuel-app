import React, { useState } from "react";
import { INK, INK2, EMBER, EMBER_SOFT, PAPER, MUTED, LINE, SAGE, disp, num, card, label, sectionTitle, primaryBtn, WD, jsDayToIdx, load, save, todayISO } from "../shared.js";

const T = {
  title: { nl: "Vandaag", en: "Today" },
  none: { nl: "Nog geen plan", en: "No plan yet" },
  noneBody: { nl: "Maak eerst je weekplan aan. Daarna zie je hier elke dag je maaltijden en vink je ze af.", en: "Build your week plan first. Then you'll see your meals here each day and check them off." },
  goPlan: { nl: "Naar plan", en: "Go to plan" },
  train: { nl: "Trainingsdag", en: "Training day" },
  rest: { nl: "Rustdag", en: "Rest day" },
  eaten: { nl: "gegeten", en: "eaten" },
  of: { nl: "van", en: "of" },
  done: { nl: "Alles gehad voor vandaag ✓", en: "All done for today ✓" },
  tapHint: { nl: "Tik een maaltijd aan als je 'm hebt gehad.", en: "Tap a meal when you've had it." },
};

function Ring({ pct }) {
  const R = 26, C = 2 * Math.PI * R;
  const off = C * (1 - Math.max(0, Math.min(1, pct)));
  return (
    <svg width="64" height="64" viewBox="0 0 64 64">
      <circle cx="32" cy="32" r={R} fill="none" stroke={LINE} strokeWidth="6" />
      <circle cx="32" cy="32" r={R} fill="none" stroke={EMBER} strokeWidth="6" strokeLinecap="round" strokeDasharray={C} strokeDashoffset={off} transform="rotate(-90 32 32)" />
      <text x="32" y="36" textAnchor="middle" fill={PAPER} fontSize="15" fontFamily="Oswald" fontWeight="600">{Math.round(pct * 100)}%</text>
    </svg>
  );
}

export default function Today({ lang, week, onGoPlan }) {
  const t = (k) => (T[k] ? T[k][lang] : k);
  const dateKey = "hf_eaten_" + todayISO();
  const [eaten, setEaten] = useState(() => load(dateKey, {}));

  if (!week || !week.days || !week.days.length) {
    return (
      <div style={{ display: "grid", gap: 16 }}>
        <div style={sectionTitle}>{t("title")}</div>
        <div style={{ border: `1px dashed ${LINE}`, borderRadius: 14, padding: "40px 22px", textAlign: "center" }}>
          <div style={{ ...disp, fontSize: 20, fontWeight: 600, color: PAPER, marginBottom: 8 }}>{t("none")}</div>
          <div style={{ fontSize: 13, color: MUTED, lineHeight: 1.6, marginBottom: 18 }}>{t("noneBody")}</div>
          <button onClick={onGoPlan} style={{ ...primaryBtn, width: "auto", padding: "12px 26px" }}>{t("goPlan")}</button>
        </div>
      </div>
    );
  }

  const idx = jsDayToIdx(new Date().getDay());
  const day = week.days[idx] || week.days[0];
  const total = day.m.reduce((a, m) => a + num(m.kcal), 0);
  const eatenKcal = day.m.reduce((a, m, i) => a + (eaten[i] ? num(m.kcal) : 0), 0);
  const pct = total ? eatenKcal / total : 0;
  const allDone = day.m.length > 0 && day.m.every((_, i) => eaten[i]);

  function toggle(i) {
    const next = { ...eaten, [i]: !eaten[i] };
    setEaten(next); save(dateKey, next);
  }

  const wd = WD[lang === "nl" ? "nl" : "en"][idx];

  return (
    <div style={{ display: "grid", gap: 16 }}>
      <div style={{ ...card, display: "flex", alignItems: "center", gap: 16 }}>
        <Ring pct={pct} />
        <div style={{ flex: 1 }}>
          <div style={{ display: "flex", alignItems: "center", gap: 8, marginBottom: 4 }}>
            <div style={{ ...disp, fontSize: 18, fontWeight: 600, letterSpacing: 0.5 }}>{t("title")} · {wd}</div>
            <div style={{ fontSize: 9.5, color: day.train ? EMBER : MUTED, border: `1px solid ${day.train ? EMBER : LINE}`, borderRadius: 5, padding: "2px 6px", letterSpacing: 1, fontWeight: 700 }}>{day.train ? t("train") : t("rest")}</div>
          </div>
          <div style={{ fontSize: 13, color: MUTED }}>
            <span style={{ color: PAPER, ...disp, fontSize: 17, fontWeight: 600 }}>{eatenKcal}</span> {t("of")} {total} kcal {t("eaten")}
          </div>
          <div style={{ fontSize: 11.5, color: allDone ? "#4ADE80" : MUTED, marginTop: 4 }}>{allDone ? t("done") : t("tapHint")}</div>
        </div>
      </div>

      <div style={{ display: "grid", gap: 10 }}>
        {day.m.map((m, i) => {
          const on = !!eaten[i];
          return (
            <div key={i} onClick={() => toggle(i)} style={{ background: INK2, border: `1px solid ${on ? EMBER : LINE}`, borderRadius: 12, padding: "12px 14px", cursor: "pointer", display: "flex", gap: 12, alignItems: "flex-start", opacity: on ? 0.72 : 1 }}>
              <div style={{ width: 22, height: 22, borderRadius: 7, border: `2px solid ${on ? EMBER : MUTED}`, background: on ? EMBER : "transparent", display: "flex", alignItems: "center", justifyContent: "center", flexShrink: 0, color: INK, fontSize: 13, fontWeight: 800, marginTop: 1 }}>{on ? "✓" : ""}</div>
              <div style={{ flex: 1 }}>
                <div style={{ fontSize: 9.5, color: EMBER, letterSpacing: 1, textTransform: "uppercase", fontWeight: 600, marginBottom: 2 }}>{m.t}</div>
                <div style={{ fontSize: 14, fontWeight: 500, textDecoration: on ? "line-through" : "none" }}>{m.n}</div>
                {m.ing && m.ing.length > 0 && (
                  <div style={{ fontSize: 11.5, color: MUTED, marginTop: 3, lineHeight: 1.5 }}>
                    {m.ing.map((ing, ii) => <span key={ii}><span style={{ color: on ? MUTED : PAPER }}>{Math.round(num(ing.g))}g</span> {ing.n}{ii < m.ing.length - 1 ? " · " : ""}</span>)}
                  </div>
                )}
              </div>
              <div style={{ fontSize: 11, color: MUTED, textAlign: "right", whiteSpace: "nowrap" }}><span style={{ color: PAPER, fontWeight: 600 }}>{m.kcal}</span> kcal<br />{m.p}p/{m.c}c/{m.f}f</div>
            </div>
          );
        })}
      </div>
    </div>
  );
}
