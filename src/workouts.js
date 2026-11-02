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

// Per oefening een korte "zo werkt het"-uitleg (how) met coaching-cues. demo = optionele
// media-URL (GIF/video); null = nog geen beeld, dan toont de app alleen de tekst. De slot
// is klaar voor een latere licentie (bijv. ExerciseDB) zonder de UI te wijzigen.
// metric = wat je logisch invult: 'reps' (sets × herhalingen), 'dist' (meters) of 'time' (minuten).
export const EXERCISES = [
  // --- Hyrox-stations ---
  { id: "ski",      cat: "hyrox", met: 9.5,  metric: "dist", nl: "SkiErg",                 en: "SkiErg",
    how: { nl: "Sta rechtop, pak de handvatten hoog. Trek explosief naar beneden door je romp te buigen en armen mee te nemen, kom gecontroleerd terug. Kracht uit je core en lats, niet alleen armen.", en: "Stand tall, grip the handles high. Drive down explosively by hinging your torso and pulling the handles, return controlled. Power from core and lats, not just arms." }, demo: null },
  { id: "sledpush", cat: "hyrox", met: 14,   metric: "dist", nl: "Sled Push",             en: "Sled Push",
    how: { nl: "Lage houding, armen gestrekt, lichaam onder een hoek. Duw door je benen met korte, krachtige passen. Blijf laag en houd constante druk op de slee.", en: "Low stance, arms extended, body angled. Drive through your legs with short powerful steps. Stay low and keep constant pressure on the sled." }, demo: null },
  { id: "sledpull", cat: "hyrox", met: 12,   metric: "dist", nl: "Sled Pull",             en: "Sled Pull",
    how: { nl: "Zak door je heupen, trek het touw hand-over-hand naar je toe terwijl je achteruit loopt of laag blijft. Gebruik je rug en benen, span je core aan.", en: "Sink your hips, pull the rope hand-over-hand toward you while backing up or staying low. Use your back and legs, brace your core." }, demo: null },
  { id: "burpees",  cat: "hyrox", met: 10,   metric: "reps", nl: "Burpee Broad Jumps",    en: "Burpee Broad Jumps",
    how: { nl: "Zak naar de grond, borst raakt, kom omhoog en spring zo ver mogelijk naar voren. Land zacht door je knieën, meteen door naar de volgende.", en: "Drop to the floor, chest down, come up and jump forward as far as possible. Land soft through the knees, straight into the next rep." }, demo: null },
  { id: "row",      cat: "hyrox", met: 8.5,  metric: "dist", nl: "Roeien (RowErg)",       en: "Rowing (RowErg)",
    how: { nl: "Volgorde: eerst benen strekken, dan achteroverleunen, dan armen naar je toe. Terug in omgekeerde volgorde. ~70% van de kracht komt uit je benen.", en: "Sequence: legs first, then lean back, then arms in. Reverse order on the return. ~70% of the power comes from your legs." }, demo: null },
  { id: "carry",    cat: "hyrox", met: 8,    metric: "dist", nl: "Farmers Carry",         en: "Farmers Carry",
    how: { nl: "Pak het gewicht met rechte rug, schouders laag en naar achter, core strak. Loop in korte, stevige passen. Niet wiebelen, blijf rechtop.", en: "Pick up the weight with a flat back, shoulders down and back, core tight. Walk in short firm steps. No swaying, stay upright." }, demo: null },
  { id: "lunges",   cat: "hyrox", met: 9.5,  metric: "dist", nl: "Sandbag Lunges",        en: "Sandbag Lunges",
    how: { nl: "Zak met de sandbag op je schouders in een uitval tot je achterste knie de grond raakt. Druk omhoog door je voorste hiel en stap door.", en: "With the sandbag on your shoulders, lunge until your back knee touches the floor. Drive up through your front heel and step through." }, demo: null },
  { id: "wallballs",cat: "hyrox", met: 9,    metric: "reps", nl: "Wall Balls",            en: "Wall Balls",
    how: { nl: "Squat diep met de bal voor je borst, kom explosief omhoog en gooi de bal naar het doel. Vang 'm en zak meteen door in de volgende squat.", en: "Squat deep with the ball at your chest, drive up explosively and throw the ball to the target. Catch it and sink straight into the next squat." }, demo: null },
  { id: "hyroxsim", cat: "hyrox", met: 11,   metric: "time", nl: "Hyrox-simulatie (full)",en: "Hyrox simulation (full)",
    how: { nl: "De volledige race: 8× 1 km hardlopen afgewisseld met de 8 stations. Houd een vol tempo aan dat je kunt volhouden, oefen de overgangen.", en: "The full race: 8× 1 km runs alternated with the 8 stations. Hold a strong sustainable pace and practise the transitions." }, demo: null },

  // --- Hardlopen ---
  { id: "runeasy",  cat: "run", met: 8.3,  metric: "dist", nl: "Hardlopen rustig (8–9 km/u)",   en: "Running easy (8–9 km/h)",
    how: { nl: "Rustig tempo waarbij je nog kunt praten. Korte lichte passen, ontspannen schouders. Dit bouwt je basisuithouding.", en: "Easy pace where you can still talk. Short light steps, relaxed shoulders. This builds your aerobic base." }, demo: null },
  { id: "runtempo", cat: "run", met: 11,   metric: "dist", nl: "Hardlopen tempo (10–12 km/u)",  en: "Running tempo (10–12 km/h)",
    how: { nl: "Stevig, comfortabel-zwaar tempo dat je 20–40 min volhoudt. Praten lukt nog net in korte zinnen. Traint je raceritme.", en: "Firm, comfortably-hard pace you can hold for 20–40 min. You can still speak in short sentences. Trains your race rhythm." }, demo: null },
  { id: "runint",   cat: "run", met: 13,   metric: "dist", nl: "Intervallen / sprints",         en: "Intervals / sprints",
    how: { nl: "Afwisseling van hard en herstel, bijv. 400 m snel / 200 m rustig. Ga de harde stukken bijna maximaal, herstel actief wandelend of joggend.", en: "Alternating hard and recovery, e.g. 400 m fast / 200 m easy. Push the hard reps near-max, recover by walking or jogging." }, demo: null },

  // --- Cardio ---
  { id: "bike",     cat: "cardio", met: 7,   metric: "time", nl: "Fietsen (matig)",      en: "Cycling (moderate)",
    how: { nl: "Gelijkmatig tempo, lichte weerstand, trapfrequentie 80–90. Goede low-impact cardio voor herstel of basis.", en: "Steady pace, light resistance, cadence 80–90. Good low-impact cardio for recovery or base work." }, demo: null },
  { id: "assault",  cat: "cardio", met: 10,  metric: "time", nl: "Assault bike",         en: "Assault bike",
    how: { nl: "Armen en benen tegelijk. Kort en fel voor intervallen, of gelijkmatig voor duur. Houd je romp stabiel, duw en trek met de handvatten.", en: "Arms and legs together. Short and fierce for intervals, or steady for endurance. Keep your torso stable, push and pull the handles." }, demo: null },
  { id: "swim",     cat: "cardio", met: 8,   metric: "dist", nl: "Zwemmen",              en: "Swimming",
    how: { nl: "Gelijkmatige slag, adem ritmisch uit onder water. Low-impact, goed voor herstel en volledige conditie.", en: "Steady stroke, exhale rhythmically underwater. Low-impact, great for recovery and full-body conditioning." }, demo: null },
  { id: "jump",     cat: "cardio", met: 11,  metric: "time", nl: "Touwtjespringen",      en: "Jump rope",
    how: { nl: "Kleine sprongetjes op je voorvoeten, polsen draaien het touw, ellebogen laag bij je lichaam. Ontspannen en ritmisch.", en: "Small hops on the balls of your feet, wrists turn the rope, elbows low at your sides. Relaxed and rhythmic." }, demo: null },
  { id: "hiit",     cat: "cardio", met: 8,   metric: "time", nl: "HIIT / circuit",       en: "HIIT / circuit",
    how: { nl: "Korte blokken all-out werk met weinig rust, meerdere oefeningen na elkaar. Houd de techniek netjes ook als je moe wordt.", en: "Short all-out blocks with little rest, several exercises back to back. Keep your form clean even as you tire." }, demo: null },

  // --- Kracht ---
  { id: "strength", cat: "strength", met: 5,   metric: "reps", nl: "Krachttraining (algemeen)", en: "Strength (general)",
    how: { nl: "Gecontroleerde herhalingen, volledige beweging, span de spier aan op het zwaarste punt. Adem uit bij de inspanning.", en: "Controlled reps, full range of motion, squeeze the muscle at the hardest point. Exhale on the effort." }, demo: null },
  { id: "strheavy", cat: "strength", met: 6,   metric: "reps", nl: "Zwaar tillen (compound)",   en: "Heavy lifting (compound)",
    how: { nl: "Grote samengestelde oefeningen (squat, deadlift, press). Rechte rug, core strak, drijf door je hielen. Minder reps, meer gewicht, lange rust.", en: "Big compound lifts (squat, deadlift, press). Flat back, core braced, drive through your heels. Fewer reps, more weight, long rest." }, demo: null },
  { id: "kb",       cat: "strength", met: 8,   metric: "reps", nl: "Kettlebell",                en: "Kettlebell",
    how: { nl: "Kracht uit je heupen, niet je armen. Bij de swing: scherpe heupstoot, kettlebell zweeft, rug recht. Core strak gedurende.", en: "Power from your hips, not your arms. On the swing: sharp hip snap, bell floats, back straight. Core tight throughout." }, demo: null },
  { id: "core",     cat: "strength", met: 4,   metric: "reps", nl: "Core / buikspieren",        en: "Core / abs",
    how: { nl: "Rustige, gecontroleerde herhalingen, geen schokkerige bewegingen. Houd je onderrug neutraal en adem rustig door.", en: "Slow controlled reps, no jerking. Keep your lower back neutral and keep breathing steadily." }, demo: null },

  // --- Mobiliteit ---
  { id: "mobility", cat: "mobility", met: 2.8, metric: "time", nl: "Mobiliteit / rekken",  en: "Mobility / stretching",
    how: { nl: "Rustig in de rek zakken, 20–40 sec vasthouden, nooit forceren tot pijn. Adem uit terwijl je dieper gaat.", en: "Ease into the stretch, hold 20–40 sec, never force into pain. Exhale as you go deeper." }, demo: null },
  { id: "walk",     cat: "mobility", met: 4.3, metric: "dist", nl: "Stevig wandelen",      en: "Brisk walking",
    how: { nl: "Stevig doortappen, armen meebewegen, rechtop. Herstel-cardio die je frequentie en vetverbranding op gang houdt.", en: "Walk briskly, arms swinging, upright posture. Recovery cardio that keeps your frequency and fat-burn ticking." }, demo: null },
  { id: "yoga",     cat: "mobility", met: 3,   metric: "time", nl: "Yoga",                 en: "Yoga",
    how: { nl: "Vloeiende houdingen gekoppeld aan je ademhaling. Werkt aan mobiliteit, balans en herstel. Blijf binnen je comfortabele bereik.", en: "Flowing poses linked to your breath. Works on mobility, balance and recovery. Stay within your comfortable range." }, demo: null },
];

// Zoek een oefening op naam (voor planner-items die alleen naam/met bewaren).
export function exerciseByName(name) {
  if (!name) return null;
  const n = String(name).toLowerCase();
  return EXERCISES.find((e) => e.nl.toLowerCase() === n || e.en.toLowerCase() === n) || null;
}

// De originele Hyrox-wedstrijd: 8× 1 km hardlopen afgewisseld met de 8 stations,
// met de officiële afstanden/reps en standaardgewichten (Open/Men; andere divisies
// kun je zelf aanpassen). Gewichten staan in de naam; de metric is de afstand/reps.
export const HYROX_RACE = [
  { name: "Run 1 km",                    exId: "runtempo", metric: "dist", dist: 1000, met: 11,  min: 5 },
  { name: "SkiErg 1000 m",               exId: "ski",      metric: "dist", dist: 1000, met: 9.5, min: 4 },
  { name: "Run 1 km",                    exId: "runtempo", metric: "dist", dist: 1000, met: 11,  min: 5 },
  { name: "Sled Push 50 m · 152 kg",     exId: "sledpush", metric: "dist", dist: 50,   met: 14,  min: 3 },
  { name: "Run 1 km",                    exId: "runtempo", metric: "dist", dist: 1000, met: 11,  min: 5 },
  { name: "Sled Pull 50 m · 103 kg",     exId: "sledpull", metric: "dist", dist: 50,   met: 12,  min: 3 },
  { name: "Run 1 km",                    exId: "runtempo", metric: "dist", dist: 1000, met: 11,  min: 5 },
  { name: "Burpee Broad Jumps 80 m",     exId: "burpees",  metric: "dist", dist: 80,   met: 10,  min: 4 },
  { name: "Run 1 km",                    exId: "runtempo", metric: "dist", dist: 1000, met: 11,  min: 5 },
  { name: "Rowing 1000 m",               exId: "row",      metric: "dist", dist: 1000, met: 8.5, min: 4 },
  { name: "Run 1 km",                    exId: "runtempo", metric: "dist", dist: 1000, met: 11,  min: 5 },
  { name: "Farmers Carry 200 m · 2×24 kg", exId: "carry",  metric: "dist", dist: 200,  met: 8,   min: 3 },
  { name: "Run 1 km",                    exId: "runtempo", metric: "dist", dist: 1000, met: 11,  min: 5 },
  { name: "Sandbag Lunges 100 m · 20 kg", exId: "lunges",  metric: "dist", dist: 100,  met: 9.5, min: 4 },
  { name: "Run 1 km",                    exId: "runtempo", metric: "dist", dist: 1000, met: 11,  min: 5 },
  { name: "Wall Balls 100 · 6 kg",       exId: "wallballs", metric: "reps", reps: 100,  met: 9,   min: 5 },
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
