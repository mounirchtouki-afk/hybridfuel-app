// Hyrox-gerichte oefeningen-database met MET-waarden (metabolisch equivalent).
// Verbranding = MET × lichaamsgewicht(kg) × duur(uur). Dit is een SCHATTING:
// MET-waarden voor functionele/explosieve bewegingen hebben een ruime foutmarge,
// dus de app toont dit als indicatie, niet als harde meting, en koppelt het niet
// automatisch aan de eetdoelen.
//
// Categorieën: hyrox (de 8 stations), run (hardlopen), cardio, strength, mobility.

export const WORKOUT_CATS = {
  hyrox:    { nl: "Hyrox-stations", en: "Hyrox stations" },
  run:      { nl: "Hardlopen",      en: "Running" },
  cardio:   { nl: "Cardio",         en: "Cardio" },
  strength: { nl: "Kracht",         en: "Strength" },
  mobility: { nl: "Mobiliteit",     en: "Mobility" },
};

export const EXERCISES = [
  // --- Hyrox-stations ---
  { id: "ski",      cat: "hyrox", met: 9.5,  nl: "SkiErg",                 en: "SkiErg" },
  { id: "sledpush", cat: "hyrox", met: 14,   nl: "Sled Push",             en: "Sled Push" },
  { id: "sledpull", cat: "hyrox", met: 12,   nl: "Sled Pull",             en: "Sled Pull" },
  { id: "burpees",  cat: "hyrox", met: 10,   nl: "Burpee Broad Jumps",    en: "Burpee Broad Jumps" },
  { id: "row",      cat: "hyrox", met: 8.5,  nl: "Roeien (RowErg)",       en: "Rowing (RowErg)" },
  { id: "carry",    cat: "hyrox", met: 8,    nl: "Farmers Carry",         en: "Farmers Carry" },
  { id: "lunges",   cat: "hyrox", met: 9.5,  nl: "Sandbag Lunges",        en: "Sandbag Lunges" },
  { id: "wallballs",cat: "hyrox", met: 9,    nl: "Wall Balls",            en: "Wall Balls" },
  { id: "hyroxsim", cat: "hyrox", met: 11,   nl: "Hyrox-simulatie (full)",en: "Hyrox simulation (full)" },

  // --- Hardlopen ---
  { id: "runeasy",  cat: "run", met: 8.3,  nl: "Hardlopen rustig (8–9 km/u)",   en: "Running easy (8–9 km/h)" },
  { id: "runtempo", cat: "run", met: 11,   nl: "Hardlopen tempo (10–12 km/u)",  en: "Running tempo (10–12 km/h)" },
  { id: "runint",   cat: "run", met: 13,   nl: "Intervallen / sprints",         en: "Intervals / sprints" },

  // --- Cardio ---
  { id: "bike",     cat: "cardio", met: 7,   nl: "Fietsen (matig)",      en: "Cycling (moderate)" },
  { id: "assault",  cat: "cardio", met: 10,  nl: "Assault bike",         en: "Assault bike" },
  { id: "swim",     cat: "cardio", met: 8,   nl: "Zwemmen",              en: "Swimming" },
  { id: "jump",     cat: "cardio", met: 11,  nl: "Touwtjespringen",      en: "Jump rope" },
  { id: "hiit",     cat: "cardio", met: 8,   nl: "HIIT / circuit",       en: "HIIT / circuit" },

  // --- Kracht ---
  { id: "strength", cat: "strength", met: 5,   nl: "Krachttraining (algemeen)", en: "Strength (general)" },
  { id: "strheavy", cat: "strength", met: 6,   nl: "Zwaar tillen (compound)",   en: "Heavy lifting (compound)" },
  { id: "kb",       cat: "strength", met: 8,   nl: "Kettlebell",                en: "Kettlebell" },
  { id: "core",     cat: "strength", met: 4,   nl: "Core / buikspieren",        en: "Core / abs" },

  // --- Mobiliteit ---
  { id: "mobility", cat: "mobility", met: 2.8, nl: "Mobiliteit / rekken",  en: "Mobility / stretching" },
  { id: "walk",     cat: "mobility", met: 4.3, nl: "Stevig wandelen",      en: "Brisk walking" },
  { id: "yoga",     cat: "mobility", met: 3,   nl: "Yoga",                 en: "Yoga" },
];

// Intensiteit-presets voor een handmatige oefening zonder bekende MET.
export const INTENSITY = [
  { id: "light",  met: 4,  nl: "Licht",  en: "Light" },
  { id: "mod",    met: 7,  nl: "Matig",  en: "Moderate" },
  { id: "hard",   met: 10, nl: "Zwaar",  en: "Hard" },
  { id: "max",    met: 13, nl: "Max",    en: "All-out" },
];

// Geschatte kcal: MET × kg × uur. Afgerond op 5.
export function kcalFor(met, kg, min) {
  const m = parseFloat(met) || 0, w = parseFloat(kg) || 0, t = parseFloat(min) || 0;
  if (!m || !w || !t) return 0;
  return Math.round((m * w * (t / 60)) / 5) * 5;
}
