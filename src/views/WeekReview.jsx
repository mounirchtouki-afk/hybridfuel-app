import React, { useState } from "react";
import { INK, INK2, EMBER, PAPER, MUTED, LINE, disp, card, primaryBtn, sectionTitle, load, todayISO } from "../shared.js";
import { supabase } from "../supabaseClient.js";
import { apiUrl } from "../apiBase";

// Weekreview (coaching-engine op logging). Verzamelt gepland-vs-werkelijk van de
// afgelopen 7 dagen en laat de AI — binnen onze huisnormen — een korte review en
// 2-3 kleine acties voor komende week voorstellen. De mens keurt goed.
export default function WeekReview({ lang, session }) {
  const t = (nl, en) => (lang === "nl" ? nl : en);
  const [busy, setBusy] = useState(false);
  const [err, setErr] = useState("");
  const [review, setReview] = useState(null);
  const cloud = !!(session && supabase);

  // Laatste 7 kalenderdagen, oudste eerst.
  function lastDates(n) {
    const out = [];
    const base = new Date();
    for (let i = n - 1; i >= 0; i--) {
      const d = new Date(base);
      d.setDate(base.getDate() - i);
      out.push(d.getFullYear() + "-" + String(d.getMonth() + 1).padStart(2, "0") + "-" + String(d.getDate()).padStart(2, "0"));
    }
    return out;
  }

  async function gather() {
    const dates = lastDates(7);
    const start = dates[0], end = dates[dates.length - 1];

    // Doelen (uit actief plan).
    let targets = null;
    const lp = load("hf_lastplan", null);
    if (lp && lp.targets) targets = lp.targets;
    if (!targets && cloud) {
      try {
        const { data } = await supabase.from("plans").select("targets").eq("user_id", session.user.id).order("created_at", { ascending: false }).limit(1);
        if (data && data[0] && data[0].targets) targets = data[0].targets;
      } catch (e) {}
    }

    // Werkelijk gegeten: kcal per dag + aantal dagen met logging.
    let kcalByDay = {};
    let daysLogged = 0;
    if (cloud) {
      try {
        const { data } = await supabase.from("food_logs").select("date,kcal").eq("user_id", session.user.id).gte("date", start).lte("date", end);
        (data || []).forEach((r) => { kcalByDay[r.date] = (kcalByDay[r.date] || 0) + Number(r.kcal || 0); });
      } catch (e) {}
    } else {
      dates.forEach((d) => {
        const rows = load("hf_food_" + d, []);
        if (Array.isArray(rows) && rows.length) kcalByDay[d] = rows.reduce((s, r) => s + Number(r.kcal || 0), 0);
      });
    }
    daysLogged = Object.keys(kcalByDay).length;
    const kcalVals = Object.values(kcalByDay).filter((v) => v > 0);
    const avgKcal = kcalVals.length ? Math.round(kcalVals.reduce((a, b) => a + b, 0) / kcalVals.length) : 0;

    // Trainingen: gepland (hf_trainplan) vs gedaan (hf_workouts_<date>).
    let trainingPlanned = 0, trainingDone = 0;
    const tp = load("hf_trainplan", null);
    if (tp && Array.isArray(tp.days)) tp.days.forEach((day) => { if (day && Array.isArray(day.items)) trainingPlanned += day.items.length ? 1 : 0; });
    dates.forEach((d) => { const w = load("hf_workouts_" + d, []); if (Array.isArray(w) && w.length) trainingDone += 1; });

    // Gewicht: begin- en eindwaarde in het venster.
    let weightStart = null, weightEnd = null;
    if (cloud) {
      try {
        const { data } = await supabase.from("weights").select("date,kg").eq("user_id", session.user.id).gte("date", start).lte("date", end).order("date");
        if (data && data.length) { weightStart = Number(data[0].kg); weightEnd = Number(data[data.length - 1].kg); }
      } catch (e) {}
    } else {
      const ws = load("hf_weights", []);
      const win = (ws || []).filter((w) => w.date >= start && w.date <= end).sort((a, b) => a.date.localeCompare(b.date));
      if (win.length) { weightStart = Number(win[0].kg); weightEnd = Number(win[win.length - 1].kg); }
    }

    return {
      window: { start, end, days: 7 },
      targets: targets ? { kcal: targets.kcal, protein: targets.protein, carbs: targets.carbs, fat: targets.fat, train: targets.train, rest: targets.rest } : null,
      avgKcalEaten: avgKcal,
      daysLogged,
      trainingPlanned,
      trainingDone,
      weightStart,
      weightEnd,
      lang,
    };
  }

  async function run() {
    setBusy(true); setErr(""); setReview(null);
    try {
      if (!session) { setErr(t("Log in om je weekreview te maken.", "Log in to run your week review.")); setBusy(false); return; }
      const summary = await gather();
      const r = await fetch(apiUrl("/api/plan"), {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ mode: "weekreview", authToken: session.access_token, lang, review: summary }),
      });
      const d = await r.json().catch(() => ({}));
      if (!r.ok || !d || !d.review) {
        setErr((d && d.error) || t("Kon de review niet maken. Probeer het zo opnieuw.", "Couldn't build the review. Try again shortly."));
        setBusy(false); return;
      }
      setReview(d.review);
    } catch (e) {
      setErr(t("Er ging iets mis. Probeer het opnieuw.", "Something went wrong. Please try again."));
    }
    setBusy(false);
  }

  const attention = review && review.tone === "attention";

  return (
    <div style={{ padding: "18px 16px", color: PAPER }}>
      <div style={{ ...disp, fontWeight: 700, fontSize: 20, letterSpacing: 0.3 }}>{t("Weekreview", "Week review")}</div>
      <div style={{ fontSize: 13, color: MUTED, marginTop: 4, marginBottom: 18, lineHeight: 1.5 }}>
        {t("Op basis van je logging van de afgelopen 7 dagen. De AI blijft bij onze normen en stelt alleen kleine aanpassingen voor — jij beslist.",
           "Based on your logging from the past 7 days. The AI stays within our method and only suggests small tweaks — you decide.")}
      </div>

      {!review && (
        <button onClick={run} disabled={busy} style={{ ...primaryBtn, opacity: busy ? 0.7 : 1, cursor: busy ? "default" : "pointer" }} className="hf-tap">
          {busy ? t("Bezig met reviewen…", "Reviewing…") : t("Maak mijn weekreview", "Build my week review")}
        </button>
      )}

      {err && (
        <div style={{ ...card, marginTop: 14, fontSize: 13.5, color: MUTED, lineHeight: 1.6 }}>{err}</div>
      )}

      {review && (
        <div style={{ display: "flex", flexDirection: "column", gap: 14 }}>
          <div style={{ ...card, borderColor: attention ? "rgba(225,29,72,0.5)" : LINE }}>
            <div style={{ display: "flex", alignItems: "center", gap: 8, marginBottom: 8 }}>
              <span style={{ display: "inline-block", width: 9, height: 9, borderRadius: "50%", background: attention ? EMBER : "#58C27D" }} />
              <span style={{ ...disp, fontWeight: 700, fontSize: 17, lineHeight: 1.25 }}>{review.headline}</span>
            </div>
            <div style={{ fontSize: 14, color: PAPER, opacity: 0.92, lineHeight: 1.6 }}>{review.summary}</div>
          </div>

          {Array.isArray(review.actions) && review.actions.length > 0 && (
            <div style={{ ...card }}>
              <div style={{ ...sectionTitle, marginBottom: 10 }}>{t("Acties voor komende week", "Actions for next week")}</div>
              <div style={{ display: "flex", flexDirection: "column", gap: 9 }}>
                {review.actions.slice(0, 3).map((a, i) => (
                  <div key={i} style={{ display: "flex", gap: 10, alignItems: "flex-start", fontSize: 14, lineHeight: 1.5 }}>
                    <span style={{ ...disp, color: EMBER, fontWeight: 700, minWidth: 16 }}>{i + 1}</span>
                    <span>{a}</span>
                  </div>
                ))}
              </div>
            </div>
          )}

          <div style={{ fontSize: 11.5, color: MUTED, lineHeight: 1.5 }}>
            {t("Je kerndoelen (kcal/macro's) veranderen niet — dit zijn alleen suggesties voor de indeling van komende week.",
               "Your core targets (kcal/macros) don't change — these are just suggestions for how to lay out next week.")}
          </div>

          <button onClick={run} disabled={busy} className="hf-tap"
            style={{ background: "transparent", color: EMBER, border: `1px solid ${EMBER}`, padding: "11px 0", borderRadius: 10, ...disp, fontWeight: 700, fontSize: 13, letterSpacing: 0.6, textTransform: "uppercase", cursor: busy ? "default" : "pointer", opacity: busy ? 0.7 : 1 }}>
            {busy ? t("Bezig…", "Working…") : t("Opnieuw reviewen", "Review again")}
          </button>
        </div>
      )}
    </div>
  );
}
