// Week-balans helpers: verschil van een dag netjes over de rest van de week
// verdelen, en een "feest-/uit-eten-dag" inplannen. Alles binnen veilige
// grenzen: kleine aanpassingen per dag, nooit een dag laten crashen.
import { num, load, jsDayToIdx } from "./shared.js";

export const Rn = (x) => Math.round(num(x));

export function isoOf(dt) {
  return dt.getFullYear() + "-" + String(dt.getMonth() + 1).padStart(2, "0") + "-" + String(dt.getDate()).padStart(2, "0");
}

// De 7 ISO-datums (ma–zo) van de week waar `iso` in valt.
export function weekDatesFrom(iso) {
  const d = new Date(iso + "T12:00:00");
  const monOff = (d.getDay() + 6) % 7; // 0 = maandag
  const mon = new Date(d); mon.setDate(d.getDate() - monOff);
  const out = [];
  for (let i = 0; i < 7; i++) { const x = new Date(mon); x.setDate(mon.getDate() + i); out.push(isoOf(x)); }
  return out;
}

// Eerstvolgende zaterdag vanaf `iso` (incl. vandaag als dat een zaterdag is).
export function upcomingSaturday(iso) {
  const d = new Date(iso + "T12:00:00");
  const add = (6 - d.getDay() + 7) % 7; // zaterdag = 6
  const s = new Date(d); s.setDate(d.getDate() + add);
  return isoOf(s);
}

// Het basis-dagobject voor een datum: de datum-afwijking als die bestaat,
// anders een kloon van het vaste weekschema-sjabloon voor die weekdag.
export function baseDayFor(iso, week) {
  const ov = load("hf_dayover_" + iso, null);
  if (ov && ov.m) return ov;
  if (!week || !week.days || !week.days.length) return null;
  const idx = jsDayToIdx(new Date(iso + "T12:00:00").getDay());
  const t = week.days[idx] || week.days[0];
  return t ? { ...t, m: (t.m || []).map((m) => ({ ...m, ing: (m.ing || []).map((g) => ({ ...g })) })) } : null;
}

export function dayTotal(day) {
  return day && day.m ? day.m.reduce((a, m) => a + num(m.kcal), 0) : 0;
}

// Schaal een dag naar een doel-totaal (begrensd op 0.6–1.4× zodat niets crasht).
// Geeft een nieuw dagobject + `_applied` (hoeveel kcal eraf ging, positief = minder).
export function scaleDayTo(day, targetTotal) {
  const cur = dayTotal(day);
  if (cur <= 0) return null;
  let f = targetTotal / cur;
  f = Math.max(0.6, Math.min(1.4, f));
  const meals = day.m.map((m) => ({ ...m, kcal: Rn(num(m.kcal) * f), p: Rn(num(m.p) * f), c: Rn(num(m.c) * f), f: Rn(num(m.f) * f), ing: (m.ing || []).map((g) => ({ ...g, g: Rn(num(g.g) * f) })) }));
  const gb = day.goal || { kcal: cur, p: day.m.reduce((a, m) => a + num(m.p), 0), c: day.m.reduce((a, m) => a + num(m.c), 0), f: day.m.reduce((a, m) => a + num(m.f), 0) };
  const goal = { kcal: Rn(num(gb.kcal) * f), p: Rn(num(gb.p) * f), c: Rn(num(gb.c) * f), f: Rn(num(gb.f) * f) };
  return { ...day, m: meals, goal, _applied: Rn(cur - cur * f) };
}

// Verdeel `totalRemove` kcal (positief = eraf halen; negatief = erbij) over de
// gegeven datums, met een plafond per dag (max 300 kcal of 15% van de dag).
// Geeft de concrete nieuwe dagen terug + hoeveel er in totaal is toegepast.
export function planReductions(dates, week, totalRemove, capAbs = 300, capFrac = 0.15) {
  if (!dates.length) return { ops: [], applied: 0 };
  const per = totalRemove / dates.length;
  let applied = 0;
  const ops = [];
  dates.forEach((iso) => {
    const base = baseDayFor(iso, week);
    if (!base) return;
    const T = dayTotal(base);
    if (T <= 0) return;
    const cap = Math.min(capAbs, capFrac * T);
    const remove = Math.max(-cap, Math.min(cap, per)); // begrensd per dag
    if (Math.abs(remove) < 1) return;
    const scaled = scaleDayTo(base, T - remove);
    if (!scaled) return;
    applied += scaled._applied;
    ops.push({ iso, scaled });
  });
  return { ops, applied: Rn(applied) };
}
