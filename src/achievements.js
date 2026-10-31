// Prestaties & medailles. Pure logica: telt sessie-records (hf_sessions) op tot
// levensloop-stats en bepaalt per categorie het behaalde niveau + voortgang.
// Een sessie-record: { id, date:"YYYY-MM-DD", name, exercises, min, kcal, km, ts }

export const TIER_NAMES = {
  nl: ["Brons", "Zilver", "Goud", "Platina", "Diamant"],
  en: ["Bronze", "Silver", "Gold", "Platinum", "Diamond"],
};
export const TIER_COLORS = ["#C77B3B", "#B9C2CC", "#E8B84B", "#6FD3E0", "#B58CF0"];

// Medaille-categorieën met drempels. Pas hier de niveaus aan.
export const MEDALS = [
  { key: "dist",    icon: "⚡", nl: "Afstand",    en: "Distance",  unitNl: "km",      unitEn: "km",       tiers: [25, 100, 250, 500, 1000] },
  { key: "sessions",icon: "🏋", nl: "Sessies",    en: "Sessions",  unitNl: "sessies", unitEn: "sessions", tiers: [10, 50, 150, 365] },
  { key: "kcal",    icon: "🔥", nl: "Calorieën",  en: "Calories",  unitNl: "kcal",    unitEn: "kcal",     tiers: [5000, 25000, 100000, 250000] },
  { key: "streak",  icon: "📅", nl: "Reeks",      en: "Streak",    unitNl: "weken",   unitEn: "weeks",    tiers: [2, 4, 12, 26] },
];

// ISO-weeknummer (voor de reeks-berekening).
function isoWeekKey(iso) {
  const d = new Date(iso + "T12:00:00");
  const day = (d.getDay() + 6) % 7;
  d.setDate(d.getDate() - day + 3); // donderdag van deze week
  const firstThu = new Date(d.getFullYear(), 0, 4);
  const firstDay = (firstThu.getDay() + 6) % 7;
  firstThu.setDate(firstThu.getDate() - firstDay + 3);
  const week = 1 + Math.round((d - firstThu) / (7 * 24 * 3600 * 1000));
  return d.getFullYear() + "-W" + String(week).padStart(2, "0");
}

// Langste aaneengesloten reeks van weken met minstens één sessie, eindigend bij de laatste week.
function weekStreak(sessions) {
  if (!sessions.length) return 0;
  const weeks = new Set(sessions.map((s) => isoWeekKey(s.date)));
  // bouw opeenvolgende weeksleutels terug vanaf de meest recente
  const sorted = [...weeks].sort();
  let best = 0, run = 0, prev = null;
  for (const w of sorted) {
    if (prev === null) { run = 1; }
    else {
      // verschil in weken: reconstruct via date of thursday
      const a = weekToDate(prev), b = weekToDate(w);
      const diff = Math.round((b - a) / (7 * 24 * 3600 * 1000));
      run = diff === 1 ? run + 1 : 1;
    }
    best = Math.max(best, run); prev = w;
  }
  return best;
}
function weekToDate(key) {
  const [y, w] = key.split("-W").map(Number);
  const firstThu = new Date(y, 0, 4);
  const firstDay = (firstThu.getDay() + 6) % 7;
  firstThu.setDate(firstThu.getDate() - firstDay + 3);
  return new Date(firstThu.getTime() + (w - 1) * 7 * 24 * 3600 * 1000);
}

export function aggregate(sessions) {
  const list = Array.isArray(sessions) ? sessions : [];
  const totals = {
    km: Math.round(list.reduce((a, s) => a + (Number(s.km) || 0), 0) * 10) / 10,
    kcal: Math.round(list.reduce((a, s) => a + (Number(s.kcal) || 0), 0)),
    sessions: list.length,
    minutes: Math.round(list.reduce((a, s) => a + (Number(s.min) || 0), 0)),
  };
  totals.streak = weekStreak(list);
  return totals;
}

// Waarde per medaille-categorie uit de totals.
function valueFor(key, totals) {
  if (key === "dist") return totals.km;
  if (key === "sessions") return totals.sessions;
  if (key === "kcal") return totals.kcal;
  if (key === "streak") return totals.streak;
  return 0;
}

// Behaald niveau (index, -1 = nog niks) + voortgang naar volgend niveau.
export function medalState(medal, totals) {
  const v = valueFor(medal.key, totals);
  let level = -1;
  for (let i = 0; i < medal.tiers.length; i++) if (v >= medal.tiers[i]) level = i;
  const nextTarget = level + 1 < medal.tiers.length ? medal.tiers[level + 1] : null;
  const prevTarget = level >= 0 ? medal.tiers[level] : 0;
  const maxed = nextTarget === null;
  const progress = maxed ? 1 : Math.max(0, Math.min(1, (v - prevTarget) / (nextTarget - prevTarget)));
  return { value: v, level, nextTarget, prevTarget, maxed, progress };
}
