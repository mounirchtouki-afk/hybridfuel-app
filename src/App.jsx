import React, { useState, useEffect } from "react";
import { INK, INK2, EMBER, EMBER_SOFT, PAPER, MUTED, LINE, SAGE, load, save } from "./shared.js";
import Today from "./views/Today.jsx";
import Tracker from "./views/Tracker.jsx";
import Water from "./views/Water.jsx";
import Products from "./views/Products.jsx";
import Recipes from "./views/Recipes.jsx";
import Reminders, { checkReminders } from "./views/Reminders.jsx";
import Auth from "./views/Auth.jsx";
import { supabase } from "./supabaseClient.js";

// Roept GEEN Claude aan vanuit de browser — alles via /api/plan (key zit op de server).
// Tweetalig: NL/EN via een vlagschakelaar. De gekozen taal gaat mee naar de backend.

// >>> Stripe-betaallinks <<<
const STRIPE_WEEK_LINK = "https://buy.stripe.com/fZu4gBdvz1oQgru0Sd1wY00";
const STRIPE_BUNDLE_LINK = "https://buy.stripe.com/7sYbJ3gHL2sU7UY30l1wY01";

const ACTIVITY = [
  { id: "light", nl: "Licht (1–2 sessies/wk)", en: "Light (1–2 sessions/wk)" },
  { id: "moderate", nl: "Gemiddeld (3–4/wk)", en: "Moderate (3–4/wk)" },
  { id: "high", nl: "Hoog (5–6/wk)", en: "High (5–6/wk)" },
  { id: "athlete", nl: "Atleet (2x/dag)", en: "Athlete (2x/day)" },
];
const GOALS = [
  { id: "cut", nl: "Afvallen", en: "Lose fat" },
  { id: "maintain", nl: "Onderhouden", en: "Maintain" },
  { id: "gain", nl: "Spier opbouwen", en: "Build muscle" },
];
const DIETS = [
  { id: "none", nl: "Geen beperking", en: "No restriction" },
  { id: "highprotein", nl: "Eiwitrijk", en: "High-protein" },
  { id: "vegetarian", nl: "Vegetarisch", en: "Vegetarian" },
  { id: "vegan", nl: "Veganistisch", en: "Vegan" },
  { id: "pescatarian", nl: "Pescotarisch", en: "Pescatarian" },
];
const CUISINES = [
  { id: "mediterranean", nl: "Mediterraans", en: "Mediterranean" },
  { id: "asian", nl: "Aziatisch", en: "Asian" },
  { id: "italian", nl: "Italiaans", en: "Italian" },
  { id: "mexican", nl: "Mexicaans", en: "Mexican" },
  { id: "middleeastern", nl: "Midden-Oosters", en: "Middle Eastern" },
  { id: "dutch", nl: "Nederlands", en: "Dutch" },
];
const PROTEINS = [
  { id: "chicken", nl: "Kip", en: "Chicken" },
  { id: "beef", nl: "Rund", en: "Beef" },
  { id: "fish", nl: "Vis", en: "Fish" },
  { id: "eggs", nl: "Eieren", en: "Eggs" },
  { id: "tofu", nl: "Tofu", en: "Tofu" },
  { id: "quark", nl: "Kwark/Skyr", en: "Quark/Skyr" },
  { id: "beans", nl: "Bonen", en: "Beans" },
];
const WD = { nl: ["Ma", "Di", "Wo", "Do", "Vr", "Za", "Zo"], en: ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"] };

const SHOP_CATS = [
  { nl: "Groente & Fruit", en: "Produce" },
  { nl: "Vlees & Vis", en: "Protein" },
  { nl: "Zuivel", en: "Dairy" },
  { nl: "Granen & Koolhydraten", en: "Grains & Carbs" },
  { nl: "Voorraadkast", en: "Pantry" },
  { nl: "Overig", en: "Other" },
];

const TXT = {
  tagline: { nl: "Persoonlijke voedingsschema's", en: "Personalized fuel plans" },
  yourStats: { nl: "Jouw gegevens", en: "Your stats" },
  man: { nl: "Man", en: "Male" },
  woman: { nl: "Vrouw", en: "Female" },
  age: { nl: "Leeftijd", en: "Age" },
  height: { nl: "Lengte", en: "Height" },
  weight: { nl: "Gewicht", en: "Weight" },
  trainingLoad: { nl: "Trainingsbelasting", en: "Training load" },
  goal: { nl: "Doel", en: "Goal" },
  diet: { nl: "Dieet", en: "Diet" },
  avoid: { nl: "Vermijden / allergieën", en: "Avoid / allergies" },
  avoidPh: { nl: "bijv. pinda's, schaaldieren", en: "e.g. peanuts, shellfish" },
  whatYouLove: { nl: "Wat je lekker vindt", en: "What you love" },
  favFoods: { nl: "Favoriete gerechten", en: "Favourite foods" },
  favPh: { nl: "bijv. kip, rijst, kwark", en: "e.g. chicken, rice, quark" },
  goToProteins: { nl: "Vaste eiwitbronnen", en: "Go-to proteins" },
  cuisine: { nl: "Keukenstijl", en: "Cuisine vibe" },
  trainingDays: { nl: "Trainingsdagen", en: "Training days" },
  trainingDaysHint: { nl: "Welke dagen train je? Die dagen krijgen meer calorieën (koolhydraten), rustdagen minder — je weekgemiddelde blijft op je doel.", en: "Which days do you train? Those days get more calories (carbs), rest days fewer — your weekly average stays on your goal." },
  build: { nl: "Maak mijn plan", en: "Build my plan" },
  building: { nl: "Bezig…", en: "Building…" },
  emptyTitle: { nl: "Fuel the work.", en: "Fuel the work." },
  emptyBody: { nl: "Vul je gegevens in. Je krijgt gratis je persoonlijke macro's en trainings/rust-verdeling. Het volledige maaltijdplan ontgrendel je daarna.", en: "Enter your stats. You'll get your personal macros and training/rest split for free. Unlock the full meal plan after that." },
  dailyTargets: { nl: "Dagdoelen (weekgemiddelde)", en: "Daily targets (weekly average)" },
  maintenance: { nl: "Onderhoud", en: "Maintenance" },
  statsHint: { nl: "Vul naar waarheid in — lengte in cm, gewicht in kg. Hierop baseren we je macro's en je BMI.", en: "Enter accurately — height in cm, weight in kg. Your macros and BMI are based on these." },
  bmiNote: { nl: "BMI = gewicht ÷ lengte². Ruwe maat (spiermassa telt niet mee); we gebruiken 'm alleen als ondergrens tegen onverantwoord afvallen.", en: "BMI = weight ÷ height². A rough measure (muscle isn't counted); we only use it as a floor against unsafe fat loss." },
  below: { nl: "onder", en: "below" },
  above: { nl: "boven", en: "above" },
  protein: { nl: "Eiwit", en: "Protein" },
  carbs: { nl: "Koolhydr.", en: "Carbs" },
  fat: { nl: "Vet", en: "Fat" },
  cycleTrain: { nl: "Trainingsdagen", en: "Training days" },
  cycleRest: { nl: "Rustdagen", en: "Rest days" },
  trainTag: { nl: "Training", en: "Training" },
  restTag: { nl: "Rust", en: "Rest" },
  safeTitle: { nl: "Verantwoord tempo", en: "Responsible pace" },
  safeCut: { nl: "Mik op 0,5–1% van je gewicht per week afvallen. Gaat het sneller? Eet iets meer — snelheid kost spier en herstel.", en: "Aim to lose 0.5–1% of bodyweight per week. Going faster? Eat a bit more — speed costs muscle and recovery." },
  safeMaintain: { nl: "Onderhoud = binnen ±0,5% per week blijven, beide kanten op.", en: "Maintenance = stay within ±0.5% per week, either way." },
  safeGain: { nl: "Opbouwen: 0,25–0,5% per week. Sneller aankomen is vooral vet, geen kracht.", en: "Building: 0.25–0.5% per week. Faster gain is mostly fat, not strength." },
  lowBmiTitle: { nl: "Belangrijk", en: "Important" },
  lowBmiWarn: { nl: "Op basis van je lengte en gewicht zit je al in een laag bereik (BMI onder 18,5). Verder afvallen raden we af — je doel staat daarom op onderhoud. Twijfel je? Overleg met een arts of diëtist.", en: "Based on your height and weight you're already in a low range (BMI under 18.5). We don't recommend losing more — your target is set to maintenance. In doubt? Talk to a doctor or dietitian." },
  tabPlan: { nl: "Plan", en: "Plan" },
  tabShop: { nl: "Boodschappen", en: "Shopping list" },
  editPlan: { nl: "Aanpassen", en: "Edit" },
  editDone: { nl: "Klaar", en: "Done" },
  addMeal: { nl: "+ Maaltijd", en: "+ Meal" },
  addIngr: { nl: "+ Ingrediënt", en: "+ Ingredient" },
  addProd: { nl: "+ Uit producten", en: "+ From products" },
  myProducts: { nl: "Producten", en: "Products" },
  mealNamePh: { nl: "Naam maaltijd", en: "Meal name" },
  ingrNamePh: { nl: "Ingrediënt", en: "Ingredient" },
  editHint: { nl: "Pas porties, ingrediënten en maaltijden aan. −/+ schaalt de hele maaltijd (gewichten én macro's).", en: "Adjust portions, ingredients and meals. −/+ scales the whole meal (weights and macros)." },
  cooking: { nl: "JE PLAN WORDT KLAARGEMAAKT…", en: "COOKING UP YOUR PLAN…" },
  retry: { nl: "OPNIEUW", en: "RETRY" },
  shopHint: { nl: "Totalen voor de week, opgeteld uit je gewichten. Tik om af te vinken.", en: "Weekly totals, summed from your weights. Tap to check off." },
  noDays: { nl: "Geen dagen ontvangen", en: "No days received" },
  unknownErr: { nl: "Onbekende fout", en: "Unknown error" },
  footer: { nl: "Schattingen, geen medisch advies. Drink voldoende water en raadpleeg een professional bij twijfel.", en: "Estimates, not medical advice. Drink enough water and consult a professional if in doubt." },
  dlTitle: { nl: "Jouw downloads", en: "Your downloads" },
  dlTracker: { nl: "⬇ Download jouw tracker (Excel)", en: "⬇ Download your tracker (Excel)" },
  dlPreparing: { nl: "Tracker wordt gemaakt…", en: "Building your tracker…" },
  dlGuide: { nl: "⬇ Hyrox-voedingsgids (PDF)", en: "⬇ Hyrox nutrition guide (PDF)" },
  dlHint: { nl: "Eén Excel met alles: dashboard, grafiek, jouw weekplan, boodschappenlijst en recepten. Open 'm ook in Google Sheets om bij te houden.", en: "One Excel with everything: dashboard, chart, your week plan, shopping list and recipes. Open it in Google Sheets too to track and tick off." },
  emailedPlan: { nl: "📧 Ook naar je mail (betaaladres) gestuurd — je kunt 'm hieronder ook downloaden.", en: "📧 Also sent to your email — you can download it below too." },
  emailingPlan: { nl: "📧 Je plan wordt naar je mail gestuurd…", en: "📧 Sending your plan to your email…" },
  freeSample: { nl: "Gratis voorbeelddag", en: "Free sample day" },
  lockTitle: { nl: "Je persoonlijke weekplan", en: "Your personal week plan" },
  lockSub: { nl: "Je cijfers staan hierboven. Ontgrendel je volledige 7-daagse maaltijdplan met exacte gewichten, afgestemd op je trainingsdagen.", en: "Your numbers are above. Unlock your full 7-day meal plan with exact weights, tuned to your training days." },
  lb1: { nl: "7-daags maaltijdplan met exacte gewichten", en: "7-day meal plan with exact weights" },
  lb2: { nl: "Volledige boodschappenlijst", en: "Full shopping list" },
  lb3: { nl: "Excel + Google Sheets tracker", en: "Excel + Google Sheets tracker" },
  lbBundle: { nl: "+ Hyrox-voedingsgids (bundel)", en: "+ Hyrox nutrition guide (bundle)" },
  unlockWeek: { nl: "Ontgrendel de week — €14,95", en: "Unlock the week — €14.95" },
  unlockBundle: { nl: "Week + Hyrox-gids — €17,95", en: "Week + Hyrox guide — €17.95" },
  lockFoot: { nl: "Direct beschikbaar na betaling.", en: "Available instantly after payment." },
  creditsOutTitle: { nl: "Je plannen zijn op", en: "You've used your plans" },
  creditsOutSub: { nl: "Je hebt je gegenereerde plannen gebruikt. Ontgrendel een nieuwe week om verder te gaan.", en: "You've used your generated plans. Unlock another week to continue." },
  leadTitle: { nl: "Nog niet klaar om te kopen?", en: "Not ready to buy yet?" },
  leadSub: { nl: "Pak de gratis starter: 5 Hyrox-voedingsregels die 90% van de fouten oplossen. Direct in je inbox.", en: "Grab the free starter: 5 Hyrox fueling rules that fix 90% of mistakes. Straight to your inbox." },
  leadPh: { nl: "jouw@email.com", en: "your@email.com" },
  leadBtn: { nl: "Stuur mij de gratis gids", en: "Send me the free guide" },
  leadSending: { nl: "Versturen…", en: "Sending…" },
  leadOkTitle: { nl: "Check je inbox ✓", en: "Check your inbox ✓" },
  leadOkBody: { nl: "We hebben de gratis Hyrox-starter naar je mail gestuurd. Kijk ook even in je spam.", en: "We've emailed you the free Hyrox starter. Check your spam folder too." },
  leadErr: { nl: "Er ging iets mis. Probeer het opnieuw.", en: "Something went wrong. Please try again." },
  leadBad: { nl: "Vul een geldig e-mailadres in.", en: "Enter a valid email address." },
  xDay: { nl: "Dag", en: "Day" },
  xType: { nl: "Type", en: "Type" },
  xMeal: { nl: "Maaltijd", en: "Meal" },
  xDish: { nl: "Gerecht", en: "Dish" },
  xIng: { nl: "Ingrediënten", en: "Ingredients" },
  xEaten: { nl: "Gegeten?", en: "Eaten?" },
  xNotes: { nl: "Notities", en: "Notes" },
  xItem: { nl: "Product", en: "Item" },
  xQty: { nl: "Hoeveelheid", en: "Quantity" },
  xGot: { nl: "In huis?", en: "Got it?" },
  xSheetPlan: { nl: "Weekplan", en: "Week plan" },
  xSheetShop: { nl: "Boodschappen", en: "Shopping" },
  // App-navigatie + PWA
  navPlan: { nl: "Plan", en: "Plan" },
  navToday: { nl: "Vandaag", en: "Today" },
  navTracker: { nl: "Tracker", en: "Tracker" },
  navWater: { nl: "Water", en: "Water" },
  navRecipes: { nl: "Recepten", en: "Recipes" },
  install: { nl: "Installeer de app", en: "Install the app" },
  installHint: { nl: "Zet HybridFuelCo op je beginscherm — sneller, met herinneringen.", en: "Add HybridFuelCo to your home screen — faster, with reminders." },
  installBtn: { nl: "Installeren", en: "Install" },
};

const fonts = `@import url('https://fonts.googleapis.com/css2?family=Oswald:wght@400;500;600;700&family=Inter:wght@400;500;600&display=swap');`;
const num = (v, d = 0) => { const n = parseFloat(v); return isNaN(n) ? d : n; };

function scaleDayTo(tmpl, targetKcal) {
  if (!tmpl || !tmpl.m || !tmpl.m.length || !targetKcal) return tmpl;
  const actual = tmpl.m.reduce((a, m) => a + num(m.kcal), 0);
  if (!actual) return tmpl;
  const f = targetKcal / actual;
  if (Math.abs(f - 1) < 0.04) return tmpl;
  return {
    ...tmpl,
    m: tmpl.m.map((m) => ({
      ...m,
      kcal: Math.round(num(m.kcal) * f), p: Math.round(num(m.p) * f),
      c: Math.round(num(m.c) * f), f: Math.round(num(m.f) * f),
      ing: (m.ing || []).map((x) => ({ ...x, g: Math.round(num(x.g) * f) })),
    })),
  };
}

function categoryIndex(name) {
  const n = (name || "").toLowerCase();
  if (/chicken|beef|turkey|pork|steak|mince|egg|tofu|tempeh|salmon|tuna|fish|shrimp|prawn|cod|lentil|bean|chickpea|ham|bacon|kip|rund|gehakt|biefstuk|ei|eieren|zalm|tonijn|vis|garnaal|garnalen|kabeljauw|linz|boon|bonen|kikkererwt|worst|kalkoen/.test(n)) return 1;
  if (/milk|yog|yoghurt|yogurt|quark|skyr|cheese|cottage|cream|butter|whey|melk|kwark|kaas|room|boter|hüttenkäse|huttenkase/.test(n)) return 2;
  if (/rice|pasta|bread|oat|potato|quinoa|couscous|noodle|tortilla|wrap|flour|cereal|bulgur|cracker|rijst|brood|havermout|aardappel|noedel|meel|ontbijtgran|cous/.test(n)) return 3;
  if (/oil|sauce|spice|salt|pepper|honey|vinegar|stock|broth|seed|nut|peanut|almond|cashew|tahini|syrup|powder|jam|herb|olie|saus|kruid|zout|peper|honing|azijn|bouillon|zaden|noot|noten|pinda|amandel|stroop|poeder|specerij/.test(n)) return 4;
  if (/apple|banana|berry|berries|spinach|broccoli|pepper|onion|garlic|tomato|carrot|courgette|zucchini|cucumber|lettuce|avocado|lemon|lime|mushroom|kale|veg|fruit|leek|cabbage|sprout|pea|orange|mango|grape|appel|banaan|bes|bessen|spinazie|paprika|ui|knoflook|tomaat|wortel|komkommer|sla|citroen|limoen|champignon|boerenkool|groente|prei|kool|erwt|sinaasappel|druif|peer|spruit/.test(n)) return 0;
  return 5;
}

async function fetchChunk(payload) {
  const res = await fetch("/api/plan", { method: "POST", headers: { "Content-Type": "application/json" }, body: JSON.stringify(payload) });
  const data = await res.json().catch(() => ({}));
  if (!res.ok) throw new Error(data.error || ("Fout " + res.status));
  return data;
}

// Onderbalk-iconen (lijn-stijl)
const Icon = ({ name, on }) => {
  const c = on ? EMBER : MUTED;
  const p = { fill: "none", stroke: c, strokeWidth: 1.9, strokeLinecap: "round", strokeLinejoin: "round" };
  if (name === "plan") return <svg width="23" height="23" viewBox="0 0 24 24"><rect x="5" y="3" width="14" height="18" rx="2" {...p} /><path d="M9 3.5h6v2.5H9z" {...p} /><path d="M8.5 10h7M8.5 14h7M8.5 18h4" {...p} /></svg>;
  if (name === "today") return <svg width="23" height="23" viewBox="0 0 24 24"><rect x="4" y="5" width="16" height="16" rx="2" {...p} /><path d="M4 9h16M8 3v4M16 3v4" {...p} /><path d="M9 14l2 2 4-4" {...p} /></svg>;
  if (name === "tracker") return <svg width="23" height="23" viewBox="0 0 24 24"><path d="M4 18l5-6 4 3 6-8" {...p} /><path d="M4 21h16" {...p} /></svg>;
  if (name === "water") return <svg width="23" height="23" viewBox="0 0 24 24"><path d="M12 3c3.5 4.2 6 7.3 6 10.3A6 6 0 016 13.3C6 10.3 8.5 7.2 12 3z" {...p} /></svg>;
  if (name === "recipes") return <svg width="23" height="23" viewBox="0 0 24 24"><path d="M4 4v6a3 3 0 006 0V4M7 4v16" {...p} /><path d="M17 4c-1.5 0-2.5 2-2.5 5s1 4 2.5 4 2.5-1 2.5-4-1-5-2.5-5zM17 13v7" {...p} /></svg>;
  return null;
};

export default function App() {
  const [lang, setLangState] = useState("en");
  const T = (k) => TXT[k][lang];
  const setLang = (l) => { setLangState(l); try { localStorage.setItem("hf_lang", l); } catch (e) {} };

  const [sex, setSex] = useState("male");
  const [age, setAge] = useState("43");
  const [height, setHeight] = useState("190");
  const [weight, setWeight] = useState("87");
  const [activity, setActivity] = useState("moderate");
  const [goal, setGoal] = useState("maintain");
  const [diet, setDiet] = useState("highprotein");
  const [avoid, setAvoid] = useState("");
  const [likes, setLikes] = useState("");
  const [cuisines, setCuisines] = useState([]);
  const [proteins, setProteins] = useState([]);
  const [trainingDays, setTrainingDays] = useState([0, 2, 4]);

  const [targets, setTargets] = useState(null);
  const [week, setWeek] = useState(null);
  const [planEdit, setPlanEdit] = useState(false);
  const [showProducts, setShowProducts] = useState(false);
  const [pickTarget, setPickTarget] = useState(null);
  const [view, setView] = useState("plan");
  const [checked, setChecked] = useState({});
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState("");
  const [started, setStarted] = useState(false);
  const [unlocked, setUnlocked] = useState(false);
  const [tier, setTier] = useState("week");
  const [email, setEmail] = useState("");
  const [leadStatus, setLeadStatus] = useState("idle");
  const [trackerBusy, setTrackerBusy] = useState(false);
  const [lockReason, setLockReason] = useState("");
  const [planEmail, setPlanEmail] = useState("");

  // App-navigatie + PWA
  const [tab, setTab] = useState("plan");
  const [showReminders, setShowReminders] = useState(false);
  const [session, setSession] = useState(null);
  const [showAuth, setShowAuth] = useState(false);
  const [subTier, setSubTier] = useState("free");
  const [installEvt, setInstallEvt] = useState(null);
  const [installDismissed, setInstallDismissed] = useState(() => load("hf_install_dismissed", false));

  useEffect(() => {
    try { const l = localStorage.getItem("hf_lang"); if (l === "nl" || l === "en") setLangState(l); } catch (e) {}

    function showOrGenerate() {
      let saved = null, intake = null;
      try { saved = JSON.parse(localStorage.getItem("hf_lastplan") || "null"); } catch (e) {}
      try { intake = JSON.parse(localStorage.getItem("hf_intake") || "null"); } catch (e) {}
      if (saved && saved.week && saved.week.days) { setTargets(saved.targets); setWeek(saved.week); setStarted(true); }
      else if (intake) { setStarted(true); generatePaid(intake); }
    }

    let params = null;
    try { params = new URLSearchParams(window.location.search); } catch (e) {}
    const sid = params && params.get("session_id");

    if (sid) {
      fetch("/api/verify?session_id=" + encodeURIComponent(sid))
        .then((r) => r.json())
        .then((j) => {
          if (j && j.ok && j.token) {
            const t = j.tier === "bundle" ? "bundle" : "week";
            try { localStorage.setItem("hf_token", j.token); localStorage.setItem("hf_unlocked", "1"); localStorage.setItem("hf_tier", t); } catch (e) {}
            try { if (window.hfTrackPurchase) window.hfTrackPurchase(t === "bundle" ? 17.95 : 14.95, "EUR"); } catch (e) {}
            setTier(t); setUnlocked(true); showOrGenerate();
          }
        })
        .catch(() => {});
      return;
    }

    let u = false;
    try { if (localStorage.getItem("hf_unlocked") === "1") u = true; } catch (e) {}
    if (params && params.get("paid") === "1") u = true;
    if (u) {
      setUnlocked(true);
      try { const t = localStorage.getItem("hf_tier"); if (t === "bundle" || t === "week") setTier(t); } catch (e) {}
    }
    // Opgeslagen plan laden voor de Vandaag-tab (zonder het startscherm van Plan te overschrijven).
    const saved = load("hf_lastplan", null);
    if (saved && saved.week && saved.week.days) { setWeek(saved.week); if (saved.targets) setTargets(saved.targets); }
  }, []);

  // PWA install-prompt opvangen
  useEffect(() => {
    const onBip = (e) => { e.preventDefault(); setInstallEvt(e); };
    const onInstalled = () => { setInstallEvt(null); };
    window.addEventListener("beforeinstallprompt", onBip);
    window.addEventListener("appinstalled", onInstalled);
    return () => { window.removeEventListener("beforeinstallprompt", onBip); window.removeEventListener("appinstalled", onInstalled); };
  }, []);

  // Supabase-sessie (login) volgen.
  useEffect(() => {
    if (!supabase) return;
    supabase.auth.getSession().then(({ data }) => setSession((data && data.session) || null)).catch(() => {});
    let sub;
    try { sub = supabase.auth.onAuthStateChange((_e, s) => setSession(s || null)); } catch (e) {}
    return () => { try { sub.data.subscription.unsubscribe(); } catch (e) {} };
  }, []);

  // Abonnement-laag ophalen zodra er een sessie is.
  useEffect(() => {
    if (!supabase || !session) { setSubTier("free"); return; }
    supabase.from("subscriptions").select("tier").eq("user_id", session.user.id).single()
      .then(({ data }) => { if (data && data.tier) setSubTier(data.tier); }).catch(() => {});
  }, [session]);

  // Laatste plan uit de cloud laden zodra er een sessie is (volgt je over apparaten).
  useEffect(() => {
    if (!supabase || !session) return;
    let active = true;
    supabase.from("plans").select("targets,week").eq("user_id", session.user.id).order("created_at", { ascending: false }).limit(1)
      .then(({ data }) => {
        if (!active || !data || !data.length) return;
        const p = data[0];
        if (p.week && p.week.days) { setWeek(p.week); if (p.targets) setTargets(p.targets); }
      }).catch(() => {});
    return () => { active = false; };
  }, [session]);

  // Herinneringen best-effort checken (bij openen, elke minuut, bij terugkeren)
  useEffect(() => {
    checkReminders(lang);
    const iv = setInterval(() => checkReminders(lang), 60000);
    const onVis = () => { if (!document.hidden) checkReminders(lang); };
    document.addEventListener("visibilitychange", onVis);
    return () => { clearInterval(iv); document.removeEventListener("visibilitychange", onVis); };
  }, [lang]);

  // Cookie-banner (consent.js) detecteren en de onderbalk er netjes bovenop zetten.
  const [consentH, setConsentH] = useState(0);
  useEffect(() => {
    const measure = () => {
      let h = 0;
      try {
        document.querySelectorAll("body > *").forEach((el) => {
          if (el.id === "root") return;
          const s = getComputedStyle(el);
          if (s.position !== "fixed" || s.display === "none" || s.visibility === "hidden") return;
          const r = el.getBoundingClientRect();
          if (r.height > 0 && r.height < window.innerHeight * 0.5 && r.width > window.innerWidth * 0.55 && r.bottom >= window.innerHeight - 3) {
            h = Math.max(h, Math.round(r.height));
          }
        });
      } catch (e) {}
      setConsentH(h);
    };
    measure();
    const iv = setInterval(measure, 700);
    window.addEventListener("resize", measure);
    return () => { clearInterval(iv); window.removeEventListener("resize", measure); };
  }, []);

  async function doInstall() { if (!installEvt) return; try { installEvt.prompt(); await installEvt.userChoice; } catch (e) {} setInstallEvt(null); }
  function dismissInstall() { setInstallDismissed(true); save("hf_install_dismissed", true); }

  const toggle = (val, list, setList) => setList(list.includes(val) ? list.filter((x) => x !== val) : [...list, val]);
  function labelsOf(ids, source) { return ids.map((id) => { const o = source.find((x) => x.id === id); return o ? o[lang] : id; }); }

  function common() {
    const dietObj = DIETS.find((d) => d.id === diet);
    return { sex, age, height, weight, activity, goal, diet: dietObj ? dietObj[lang] : diet, avoid, likes, cuisines: labelsOf(cuisines, CUISINES), proteins: labelsOf(proteins, PROTEINS), lang };
  }
  function currentIntake() { return { ...common(), trainingDays: [...trainingDays] }; }

  async function handleBuild() {
    setError(""); setStarted(true); setView("plan"); setChecked({}); setWeek(null); setLockReason(""); setPlanEmail("");
    const intake = currentIntake();
    try { localStorage.setItem("hf_intake", JSON.stringify(intake)); } catch (e) {}
    if (unlocked) await generatePaid(intake); else await computeFree(intake);
  }

  async function computeFree(intake) {
    setLoading(true); setTargets(null);
    try {
      const nTrain = (intake.trainingDays || []).length;
      const data = await fetchChunk({ ...intake, trainingCount: nTrain, paid: false });
      setTargets(data.targets);
    } catch (e) { setError(e && e.message ? e.message : T("unknownErr")); } finally { setLoading(false); }
  }

  async function subscribe() {
    const e = (email || "").trim();
    if (!/^[^@\s]+@[^@\s]+\.[^@\s]+$/.test(e)) { setLeadStatus("bad"); return; }
    setLeadStatus("sending");
    try {
      const res = await fetch("/api/subscribe", { method: "POST", headers: { "Content-Type": "application/json" }, body: JSON.stringify({ email: e, lang }) });
      if (!res.ok) throw new Error("fail");
      setLeadStatus("ok");
    } catch (_) { setLeadStatus("err"); }
  }

  async function generatePaid(intake) {
    setLoading(true); setError("");
    try {
      const nTrain = (intake.trainingDays || []).length;
      const request = (nTrain === 0 || nTrain === 7) ? [{ label: "D1", level: "base" }] : [{ label: "TR", level: "train" }, { label: "RS", level: "rest" }];
      const token = (() => { try { return localStorage.getItem("hf_token") || ""; } catch (e) { return ""; } })();
      const data = await fetchChunk({ ...intake, trainingCount: nTrain, request, paid: true, token });
      setTargets(data.targets);
      if (data.locked || !data.plan) {
        setUnlocked(false); setWeek(null); setLockReason(data.reason || "");
        try { localStorage.removeItem("hf_unlocked"); } catch (e) {}
        return;
      }
      const got = (data.plan && data.plan.days) || [];
      if (!got.length) throw new Error(T("noDays"));
      const byLevel = {};
      request.forEach((r, idx) => { byLevel[r.level] = got.find((x) => x && x.d === r.label) || got[idx] || got[0]; });
      const tg = data.targets || {};
      const sTrain = scaleDayTo(byLevel["train"], tg.train && tg.train.kcal);
      const sRest = scaleDayTo(byLevel["rest"], tg.rest && tg.rest.kcal);
      const sBase = scaleDayTo(byLevel["base"], tg.kcal);
      const td = intake.trainingDays || [];
      const wd = WD[intake.lang === "nl" ? "nl" : "en"];
      const days = wd.map((d, i) => {
        const isTrain = nTrain === 7 ? true : nTrain === 0 ? false : td.includes(i);
        const tmpl = (nTrain === 0 || nTrain === 7) ? sBase : (isTrain ? sTrain : sRest);
        return { d, train: isTrain, m: (tmpl && tmpl.m) || [] };
      });
      setWeek({ days });
      try { localStorage.setItem("hf_lastplan", JSON.stringify({ targets: data.targets, week: { days } })); } catch (e) {}
      if (supabase && session) {
        supabase.from("plans").insert({ user_id: session.user.id, targets: data.targets, week: { days }, is_active: true }).then(() => {}, () => {});
      }
      emailPlan({ days });
    } catch (e) { setError(e && e.message ? e.message : T("unknownErr")); } finally { setLoading(false); }
  }

  function shoppingFor(wk) {
    const agg = {};
    wk.days.forEach((day) => day.m.forEach((meal) => (meal.ing || []).forEach((ing) => {
      const key = (ing.n || "").trim();
      if (!key) return;
      if (!agg[key]) agg[key] = { g: 0, ci: categoryIndex(key) };
      agg[key].g += num(ing.g);
    })));
    const byCat = {};
    Object.entries(agg).forEach(([name, v]) => { (byCat[v.ci] = byCat[v.ci] || []).push({ name, g: Math.round(v.g) }); });
    return SHOP_CATS.map((c, i) => ({ n: c[lang], items: byCat[i] })).filter((c) => c.items).map((c) => ({ n: c.n, items: c.items.sort((a, b) => b.g - a.g) }));
  }

  function exportExcel() {
    const XLSX = window.XLSX;
    if (!XLSX || !week) return;
    const planRows = [[T("xDay"), T("xType"), T("xMeal"), T("xDish"), T("xIng"), T("xEaten"), T("xNotes")]];
    week.days.forEach((day) => {
      const typ = day.train ? T("trainTag") : T("restTag");
      day.m.forEach((m, i) => {
        const ing = (m.ing || []).map((x) => Math.round(num(x.g)) + "g " + x.n).join(", ");
        planRows.push([i === 0 ? day.d : "", i === 0 ? typ : "", m.t, m.n, ing, "", ""]);
      });
      planRows.push(["", "", "", "", "", "", ""]);
    });
    const ws1 = XLSX.utils.aoa_to_sheet(planRows);
    ws1["!cols"] = [{ wch: 6 }, { wch: 9 }, { wch: 10 }, { wch: 26 }, { wch: 40 }, { wch: 9 }, { wch: 22 }];
    const shopRows = [[T("xItem"), T("xQty"), T("xGot")]];
    shoppingFor(week).forEach((cat) => {
      shopRows.push([cat.n.toUpperCase(), "", ""]);
      cat.items.forEach((it) => shopRows.push([it.name, it.g >= 1000 ? (it.g / 1000).toFixed(1) + " kg" : it.g + " g", ""]));
      shopRows.push(["", "", ""]);
    });
    const ws2 = XLSX.utils.aoa_to_sheet(shopRows);
    ws2["!cols"] = [{ wch: 28 }, { wch: 14 }, { wch: 9 }];
    const wb = XLSX.utils.book_new();
    XLSX.utils.book_append_sheet(wb, ws1, T("xSheetPlan"));
    XLSX.utils.book_append_sheet(wb, ws2, T("xSheetShop"));
    XLSX.writeFile(wb, "HybridFuelCo_MealPlan.xlsx");
  }

  async function downloadTracker() {
    if (!week || trackerBusy) return;
    setTrackerBusy(true);
    try {
      const res = await fetch("/api/tracker", { method: "POST", headers: { "Content-Type": "application/json" }, body: JSON.stringify({ week, shopping: shoppingFor(week), lang }) });
      if (!res.ok) throw new Error("fail");
      const blob = await res.blob();
      const url = URL.createObjectURL(blob);
      const a = document.createElement("a");
      a.href = url; a.download = "HybridFuelCo_MealPlan.xlsx";
      document.body.appendChild(a); a.click(); a.remove();
      setTimeout(() => { try { URL.revokeObjectURL(url); } catch (e) {} }, 2000);
    } catch (e) { exportExcel(); } finally { setTrackerBusy(false); }
  }

  async function emailPlan(wk) {
    if (!wk || !wk.days) return;
    try {
      const token = (() => { try { return localStorage.getItem("hf_token") || ""; } catch (e) { return ""; } })();
      setPlanEmail("sending");
      const res = await fetch("/api/email-plan", { method: "POST", headers: { "Content-Type": "application/json" }, body: JSON.stringify({ lang, week: wk, shopping: shoppingFor(wk), token }) });
      const j = await res.json().catch(() => ({}));
      setPlanEmail(j && j.emailed ? "sent" : "");
    } catch (e) { setPlanEmail(""); }
  }

  const label = { fontFamily: "Inter, sans-serif", fontSize: 11, letterSpacing: 1, textTransform: "uppercase", color: MUTED, marginBottom: 6, display: "block", fontWeight: 600 };
  const input = { width: "100%", background: INK, border: `1px solid ${LINE}`, color: PAPER, padding: "11px 12px", fontFamily: "Inter, sans-serif", fontSize: 14, borderRadius: 8, outline: "none", boxSizing: "border-box" };
  const disp = { fontFamily: "Oswald, sans-serif" };
  const chipS = (on) => ({ padding: "7px 12px", borderRadius: 20, border: `1px solid ${on ? EMBER : LINE}`, background: on ? "rgba(225,29,72,0.14)" : "transparent", fontSize: 12.5, fontWeight: 600, cursor: "pointer" });
  const segS = (on) => ({ flex: 1, textAlign: "center", padding: "9px 4px", borderRadius: 8, border: `1px solid ${on ? EMBER : LINE}`, background: on ? "rgba(225,29,72,0.12)" : "transparent", fontSize: 12, fontWeight: 600, cursor: "pointer" });
  const dayChip = (on) => ({ flex: 1, textAlign: "center", padding: "9px 2px", borderRadius: 8, border: `1px solid ${on ? EMBER : LINE}`, background: on ? "rgba(225,29,72,0.16)" : "transparent", color: on ? PAPER : MUTED, fontSize: 12, fontWeight: 700, cursor: "pointer", ...disp, letterSpacing: 0.5 });
  const flagBtn = (on) => ({ display: "flex", alignItems: "center", cursor: "pointer", padding: "5px 7px", borderRadius: 7, border: `1px solid ${on ? EMBER : LINE}`, background: on ? "rgba(225,29,72,0.14)" : "transparent", opacity: on ? 1 : 0.5, transition: "opacity .15s, border-color .15s" });
  const FlagNL = <svg width="22" height="15" viewBox="0 0 9 6" style={{ borderRadius: 2, display: "block" }}><rect width="9" height="6" fill="#fff" /><rect width="9" height="2" fill="#AE1C28" /><rect y="4" width="9" height="2" fill="#21468B" /></svg>;
  const FlagGB = <svg width="22" height="15" viewBox="0 0 60 30" style={{ borderRadius: 2, display: "block" }}><clipPath id="gbc"><rect width="60" height="30" /></clipPath><g clipPath="url(#gbc)"><rect width="60" height="30" fill="#012169" /><path d="M0,0 60,30 M60,0 0,30" stroke="#fff" strokeWidth="6" /><path d="M0,0 60,30 M60,0 0,30" stroke="#C8102E" strokeWidth="4" /><path d="M30,0 V30 M0,15 H60" stroke="#fff" strokeWidth="10" /><path d="M30,0 V30 M0,15 H60" stroke="#C8102E" strokeWidth="6" /></g></svg>;

  // ====== DAG-EDITOR (Pro) ======
  const R = (x) => Math.round(num(x));
  function applyWeek(nw) { setWeek(nw); try { localStorage.setItem("hf_lastplan", JSON.stringify({ targets, week: nw })); } catch (e) {} }
  function persistPlanCloud() { if (supabase && session && week && week.days) supabase.from("plans").insert({ user_id: session.user.id, targets, week, is_active: true }).then(() => {}, () => {}); }
  function mutDay(di, fn) {
    if (!week) return;
    const nw = { ...week, days: week.days.map((d, i) => i === di ? fn({ ...d, m: d.m.map((mm) => ({ ...mm, ing: (mm.ing || []).map((g) => ({ ...g })) })) }) : d) };
    applyWeek(nw);
  }
  const patchMeal = (di, mi, patch) => mutDay(di, (d) => { d.m = d.m.map((mm, j) => j === mi ? { ...mm, ...patch } : mm); return d; });
  const scaleMeal = (di, mi, fac) => mutDay(di, (d) => { d.m = d.m.map((mm, j) => j === mi ? { ...mm, kcal: R(num(mm.kcal) * fac), p: R(num(mm.p) * fac), c: R(num(mm.c) * fac), f: R(num(mm.f) * fac), ing: (mm.ing || []).map((g) => ({ ...g, g: R(num(g.g) * fac) })) } : mm); return d; });
  const ingMacros = (ing) => { const p = ing && ing.per100; if (!p) return null; const fac = num(ing.g) / 100; return { kcal: R(num(p.kcal) * fac), p: R(num(p.p) * fac), c: R(num(p.c) * fac), f: R(num(p.f) * fac) }; };
  const patchIng = (di, mi, ii, patch) => mutDay(di, (d) => {
    d.m = d.m.map((mm, j) => {
      if (j !== mi) return mm;
      const ing = mm.ing || [], old = ing[ii], next = { ...old, ...patch };
      const na = { ...mm, ing: ing.map((g, k) => k === ii ? next : g) };
      if (old && old.per100 && ("g" in patch)) { const a = ingMacros(old) || {}, b = ingMacros(next) || {}; na.kcal = R(num(mm.kcal) + (b.kcal || 0) - (a.kcal || 0)); na.p = R(num(mm.p) + (b.p || 0) - (a.p || 0)); na.c = R(num(mm.c) + (b.c || 0) - (a.c || 0)); na.f = R(num(mm.f) + (b.f || 0) - (a.f || 0)); }
      return na;
    });
    return d;
  });
  const addIngr = (di, mi) => mutDay(di, (d) => { d.m = d.m.map((mm, j) => j === mi ? { ...mm, ing: [...(mm.ing || []), { n: "", g: 0 }] } : mm); return d; });
  const removeIngr = (di, mi, ii) => mutDay(di, (d) => {
    d.m = d.m.map((mm, j) => {
      if (j !== mi) return mm;
      const ing = mm.ing || [], old = ing[ii];
      const na = { ...mm, ing: ing.filter((_, k) => k !== ii) };
      if (old && old.per100) { const a = ingMacros(old) || {}; na.kcal = R(num(mm.kcal) - (a.kcal || 0)); na.p = R(num(mm.p) - (a.p || 0)); na.c = R(num(mm.c) - (a.c || 0)); na.f = R(num(mm.f) - (a.f || 0)); }
      return na;
    });
    return d;
  });
  function addProductIng(di, mi, product) {
    mutDay(di, (d) => {
      d.m = d.m.map((mm, j) => {
        if (j !== mi) return mm;
        const ing = { n: product.name, g: 100, per100: product.per_100 || {} };
        const a = ingMacros(ing) || {};
        return { ...mm, ing: [...(mm.ing || []), ing], kcal: R(num(mm.kcal) + (a.kcal || 0)), p: R(num(mm.p) + (a.p || 0)), c: R(num(mm.c) + (a.c || 0)), f: R(num(mm.f) + (a.f || 0)) };
      });
      return d;
    });
  }
  const removeMeal = (di, mi) => mutDay(di, (d) => { d.m = d.m.filter((_, j) => j !== mi); return d; });
  const addMealTo = (di) => mutDay(di, (d) => { d.m = [...d.m, { t: "EXTRA", n: "", kcal: 0, p: 0, c: 0, f: 0, ing: [] }]; return d; });
  function toggleEdit() { if (planEdit) persistPlanCloud(); setPlanEdit(!planEdit); }

  const sIn = { background: INK, border: `1px solid ${LINE}`, color: PAPER, padding: "6px 8px", fontFamily: "Inter, sans-serif", fontSize: 12.5, borderRadius: 7, outline: "none", boxSizing: "border-box" };

  function EditDayCard({ day, di }) {
    const tot = day.m.reduce((a, m) => ({ kcal: a.kcal + num(m.kcal), p: a.p + num(m.p), c: a.c + num(m.c), f: a.f + num(m.f) }), { kcal: 0, p: 0, c: 0, f: 0 });
    return (
      <div style={{ background: INK2, border: `1px solid ${LINE}`, borderRadius: 12, overflow: "hidden" }}>
        <div style={{ display: "flex", justifyContent: "space-between", alignItems: "center", padding: "11px 14px", background: INK, borderBottom: `1px solid ${LINE}` }}>
          <div style={{ display: "flex", alignItems: "center", gap: 9 }}>
            <div style={{ ...disp, fontWeight: 600, fontSize: 15, letterSpacing: 1, textTransform: "uppercase" }}>{day.d}</div>
            <div onClick={() => mutDay(di, (d) => { d.train = !d.train; return d; })} style={{ cursor: "pointer", fontSize: 9.5, color: day.train ? EMBER : MUTED, border: `1px solid ${day.train ? EMBER : LINE}`, borderRadius: 5, padding: "2px 6px", letterSpacing: 1, fontWeight: 700 }}>{day.train ? T("trainTag") : T("restTag")}</div>
          </div>
          <div style={{ fontSize: 11.5, color: MUTED }}><span style={{ color: PAPER, fontWeight: 600 }}>{tot.kcal}</span> kcal · {tot.p}p/{tot.c}c/{tot.f}f</div>
        </div>
        <div style={{ padding: "4px 0" }}>
          {day.m.map((m, mi) => (
            <div key={mi} style={{ padding: "11px 14px", borderBottom: `1px solid ${LINE}` }}>
              <div style={{ display: "flex", gap: 8, alignItems: "center", marginBottom: 8 }}>
                <input value={m.n} onChange={(e) => patchMeal(di, mi, { n: e.target.value })} placeholder={T("mealNamePh")} style={{ ...sIn, flex: 1 }} />
                <div onClick={() => scaleMeal(di, mi, 0.9)} style={{ cursor: "pointer", width: 30, height: 30, borderRadius: 7, border: `1px solid ${LINE}`, color: EMBER, display: "flex", alignItems: "center", justifyContent: "center", fontSize: 18, fontWeight: 700, flexShrink: 0 }}>−</div>
                <div onClick={() => scaleMeal(di, mi, 1.1)} style={{ cursor: "pointer", width: 30, height: 30, borderRadius: 7, border: `1px solid ${LINE}`, color: EMBER, display: "flex", alignItems: "center", justifyContent: "center", fontSize: 18, fontWeight: 700, flexShrink: 0 }}>+</div>
                <div onClick={() => removeMeal(di, mi)} style={{ cursor: "pointer", width: 30, height: 30, borderRadius: 7, border: `1px solid ${LINE}`, color: MUTED, display: "flex", alignItems: "center", justifyContent: "center", fontSize: 16, flexShrink: 0 }}>×</div>
              </div>
              {(m.ing || []).map((ing, ii) => (
                <div key={ii} style={{ display: "flex", gap: 6, alignItems: "center", marginBottom: 6 }}>
                  <input value={ing.n} onChange={(e) => patchIng(di, mi, ii, { n: e.target.value })} placeholder={T("ingrNamePh")} style={{ ...sIn, flex: 1 }} />
                  <input value={ing.g} onChange={(e) => patchIng(di, mi, ii, { g: num(e.target.value) })} inputMode="numeric" style={{ ...sIn, width: 58, textAlign: "right" }} />
                  <span style={{ fontSize: 11, color: MUTED }}>g</span>
                  <div onClick={() => removeIngr(di, mi, ii)} style={{ cursor: "pointer", color: MUTED, fontSize: 15, padding: "0 2px" }}>×</div>
                </div>
              ))}
              <div style={{ display: "flex", justifyContent: "space-between", alignItems: "center", marginTop: 6, gap: 10, flexWrap: "wrap" }}>
                <div style={{ display: "flex", gap: 14 }}>
                  <div onClick={() => addIngr(di, mi)} style={{ cursor: "pointer", fontSize: 11.5, color: EMBER, fontWeight: 600 }}>{T("addIngr")}</div>
                  <div onClick={() => { setPickTarget({ di, mi }); setShowProducts(true); }} style={{ cursor: "pointer", fontSize: 11.5, color: EMBER, fontWeight: 600 }}>{T("addProd")}</div>
                </div>
                <div style={{ fontSize: 10.5, color: MUTED }}>{m.kcal} kcal · {m.p}p/{m.c}c/{m.f}f</div>
              </div>
            </div>
          ))}
          <div onClick={() => addMealTo(di)} style={{ cursor: "pointer", textAlign: "center", padding: "10px 0", color: EMBER, fontSize: 12.5, fontWeight: 700, ...disp, letterSpacing: 0.5 }}>{T("addMeal")}</div>
        </div>
      </div>
    );
  }

  function DayCard({ day, sample }) {
    const tot = day.m.reduce((a, m) => ({ kcal: a.kcal + num(m.kcal), p: a.p + num(m.p), c: a.c + num(m.c), f: a.f + num(m.f) }), { kcal: 0, p: 0, c: 0, f: 0 });
    return (
      <div style={{ background: INK2, border: `1px solid ${LINE}`, borderRadius: 12, overflow: "hidden" }}>
        <div style={{ display: "flex", justifyContent: "space-between", alignItems: "center", padding: "11px 14px", background: INK, borderBottom: `1px solid ${LINE}` }}>
          <div style={{ display: "flex", alignItems: "center", gap: 9, flexWrap: "wrap" }}>
            <div style={{ ...disp, fontWeight: 600, fontSize: 15, letterSpacing: 1, textTransform: "uppercase" }}>{day.d}</div>
            <div style={{ fontSize: 9.5, color: day.train ? EMBER : MUTED, border: `1px solid ${day.train ? EMBER : LINE}`, borderRadius: 5, padding: "2px 6px", letterSpacing: 1, fontWeight: 700 }}>{day.train ? T("trainTag") : T("restTag")}</div>
            {sample && <div style={{ fontSize: 9.5, color: PAPER, background: EMBER, borderRadius: 5, padding: "2px 7px", letterSpacing: 0.5, fontWeight: 700, ...disp }}>{T("freeSample")}</div>}
          </div>
          <div style={{ fontSize: 11.5, color: MUTED }}><span style={{ color: PAPER, fontWeight: 600 }}>{tot.kcal}</span> kcal · {tot.p}p/{tot.c}c/{tot.f}f</div>
        </div>
        <div>
          {day.m.map((m, mi) => (
            <div key={mi} style={{ padding: "10px 14px", borderBottom: mi < day.m.length - 1 ? `1px solid ${LINE}` : "none" }}>
              <div style={{ display: "flex", justifyContent: "space-between", alignItems: "flex-start" }}>
                <div style={{ flex: 1, paddingRight: 10 }}>
                  <div style={{ fontSize: 9.5, color: EMBER, letterSpacing: 1, textTransform: "uppercase", fontWeight: 600, marginBottom: 2 }}>{m.t}</div>
                  <div style={{ fontSize: 13.5, fontWeight: 500 }}>{m.n}</div>
                  {m.ing && m.ing.length > 0 && (
                    <div style={{ fontSize: 11.5, color: MUTED, marginTop: 3, lineHeight: 1.5 }}>
                      {m.ing.map((ing, ii) => <span key={ii}><span style={{ color: PAPER }}>{Math.round(num(ing.g))}g</span> {ing.n}{ii < m.ing.length - 1 ? " · " : ""}</span>)}
                    </div>
                  )}
                </div>
                <div style={{ fontSize: 11, color: MUTED, textAlign: "right", whiteSpace: "nowrap" }}><span style={{ color: PAPER, fontWeight: 600 }}>{m.kcal}</span> kcal<br />{m.p}p/{m.c}c/{m.f}f</div>
              </div>
            </div>
          ))}
        </div>
      </div>
    );
  }

  const lowBmi = !!(targets && targets.lowBmi);
  const safeText = lowBmi ? T("lowBmiWarn") : goal === "cut" ? T("safeCut") : goal === "gain" ? T("safeGain") : T("safeMaintain");
  const hasCycle = targets && targets.trainingCount > 0 && targets.trainingCount < 7 && targets.train && targets.rest;

  const NAV = [["plan", "navPlan"], ["today", "navToday"], ["tracker", "navTracker"], ["water", "navWater"], ["recipes", "navRecipes"]];

  return (
    <div style={{ minHeight: "100vh", background: `radial-gradient(135% 95% at 90% -8%, rgba(225,29,72,0.22) 0%, rgba(150,30,18,0.07) 36%, ${INK} 66%), ${INK}`, backgroundAttachment: "fixed", backgroundRepeat: "no-repeat", color: PAPER, fontFamily: "Inter, sans-serif", paddingBottom: 76 + consentH }}>
      <style dangerouslySetInnerHTML={{ __html: fonts + `*{box-sizing:border-box} select option{background:${INK2};color:${PAPER}} @keyframes pulse{0%,100%{opacity:.4}50%{opacity:1}} .dot{animation:pulse 1s infinite} input[type=date],input[type=time]{color-scheme:dark}` }} />

      {/* HEADER */}
      <div style={{ borderBottom: `1px solid ${LINE}`, padding: "14px 16px", display: "flex", alignItems: "center", gap: 12, position: "sticky", top: 0, background: `radial-gradient(130% 320% at 94% 0%, rgba(225,29,72,0.16), ${INK} 58%), ${INK}`, zIndex: 20 }}>
        <div style={{ width: 32, height: 32, borderRadius: 8, background: EMBER, display: "flex", alignItems: "center", justifyContent: "center", ...disp, fontWeight: 700, color: INK, fontSize: 19 }}>H</div>
        <div style={{ flex: 1, minWidth: 0 }}>
          <div style={{ ...disp, fontWeight: 700, fontSize: 19, letterSpacing: 0.5, lineHeight: 1 }}>HYBRIDFUEL<span style={{ color: EMBER }}>CO</span></div>
          <div style={{ fontSize: 10, color: MUTED, letterSpacing: 1, textTransform: "uppercase", marginTop: 3 }}>{T("tagline")}</div>
        </div>
        <div onClick={() => setShowAuth(true)} title="Account" style={{ cursor: "pointer", padding: 6, display: "flex", alignItems: "center" }}>
          <svg width="21" height="21" viewBox="0 0 24 24" fill="none" stroke={session ? EMBER : MUTED} strokeWidth="1.9" strokeLinecap="round" strokeLinejoin="round"><circle cx="12" cy="8" r="4" /><path d="M4 21c0-4 4-6.5 8-6.5s8 2.5 8 6.5" /></svg>
        </div>
        <div onClick={() => setShowReminders(true)} title="Reminders" style={{ cursor: "pointer", padding: 6, display: "flex", alignItems: "center" }}>
          <svg width="21" height="21" viewBox="0 0 24 24" fill="none" stroke={MUTED} strokeWidth="1.9" strokeLinecap="round" strokeLinejoin="round"><path d="M18 8a6 6 0 10-12 0c0 7-3 9-3 9h18s-3-2-3-9M13.7 21a2 2 0 01-3.4 0" /></svg>
        </div>
        <div style={{ display: "flex", gap: 6 }}>
          <div onClick={() => setLang("nl")} style={flagBtn(lang === "nl")} title="Nederlands">{FlagNL}</div>
          <div onClick={() => setLang("en")} style={flagBtn(lang === "en")} title="English">{FlagGB}</div>
        </div>
      </div>

      {/* INSTALL-BANNER */}
      {installEvt && !installDismissed && (
        <div style={{ background: "rgba(225,29,72,0.1)", borderBottom: `1px solid ${LINE}`, padding: "10px 16px", display: "flex", alignItems: "center", gap: 12 }}>
          <div style={{ flex: 1 }}>
            <div style={{ fontSize: 13, fontWeight: 600 }}>{T("install")}</div>
            <div style={{ fontSize: 11, color: MUTED, marginTop: 1 }}>{T("installHint")}</div>
          </div>
          <button onClick={doInstall} style={{ background: EMBER, color: PAPER, border: "none", padding: "8px 14px", borderRadius: 8, ...disp, fontWeight: 700, fontSize: 12.5, letterSpacing: 0.5, cursor: "pointer", whiteSpace: "nowrap" }}>{T("installBtn")}</button>
          <div onClick={dismissInstall} style={{ cursor: "pointer", color: MUTED, fontSize: 20, lineHeight: 1, padding: "0 2px" }}>×</div>
        </div>
      )}

      <div style={{ maxWidth: 680, margin: "0 auto", padding: 16 }}>

        {/* ====== PLAN TAB ====== */}
        {tab === "plan" && (
          <div style={{ display: "grid", gap: 18 }}>
            <div style={{ background: INK2, border: `1px solid ${LINE}`, borderRadius: 14, padding: 18 }}>
              <div style={{ ...disp, fontSize: 15, fontWeight: 600, textTransform: "uppercase", letterSpacing: 1.5, marginBottom: 6, color: EMBER }}>{T("yourStats")}</div>
              <div style={{ fontSize: 11, color: MUTED, lineHeight: 1.5, marginBottom: 14 }}>{T("statsHint")}</div>

              <div style={{ display: "flex", gap: 10, marginBottom: 14 }}>
                {[["male", T("man")], ["female", T("woman")]].map(([id, lbl]) => (
                  <div key={id} onClick={() => setSex(id)} style={{ ...segS(sex === id), padding: "10px 0" }}>{lbl}</div>
                ))}
              </div>
              <div style={{ display: "grid", gridTemplateColumns: "1fr 1fr 1fr", gap: 10, marginBottom: 14 }}>
                <div><label style={label}>{T("age")}</label><input style={input} value={age} onChange={(e) => setAge(e.target.value)} inputMode="numeric" /></div>
                <div><label style={label}>{T("height")}</label><input style={input} value={height} onChange={(e) => setHeight(e.target.value)} inputMode="numeric" /></div>
                <div><label style={label}>{T("weight")}</label><input style={input} value={weight} onChange={(e) => setWeight(e.target.value)} inputMode="numeric" /></div>
              </div>
              <div style={{ marginBottom: 14 }}>
                <label style={label}>{T("trainingLoad")}</label>
                <select style={input} value={activity} onChange={(e) => setActivity(e.target.value)}>
                  {ACTIVITY.map((a) => <option key={a.id} value={a.id}>{a[lang]}</option>)}
                </select>
              </div>
              <div style={{ marginBottom: 14 }}>
                <label style={label}>{T("goal")}</label>
                <div style={{ display: "flex", gap: 8 }}>
                  {GOALS.map((g) => <div key={g.id} onClick={() => setGoal(g.id)} style={segS(goal === g.id)}>{g[lang]}</div>)}
                </div>
              </div>
              <div style={{ marginBottom: 14 }}>
                <label style={label}>{T("diet")}</label>
                <select style={input} value={diet} onChange={(e) => setDiet(e.target.value)}>
                  {DIETS.map((d) => <option key={d.id} value={d.id}>{d[lang]}</option>)}
                </select>
              </div>
              <div style={{ marginBottom: 16 }}>
                <label style={label}>{T("avoid")}</label>
                <input style={input} value={avoid} onChange={(e) => setAvoid(e.target.value)} placeholder={T("avoidPh")} />
              </div>

              <div style={{ height: 1, background: LINE, margin: "2px 0 16px" }} />
              <div style={{ ...disp, fontSize: 15, fontWeight: 600, textTransform: "uppercase", letterSpacing: 1.5, marginBottom: 14, color: EMBER }}>{T("whatYouLove")}</div>
              <div style={{ marginBottom: 14 }}>
                <label style={label}>{T("favFoods")}</label>
                <input style={input} value={likes} onChange={(e) => setLikes(e.target.value)} placeholder={T("favPh")} />
              </div>
              <div style={{ marginBottom: 14 }}>
                <label style={label}>{T("goToProteins")}</label>
                <div style={{ display: "flex", flexWrap: "wrap", gap: 7 }}>
                  {PROTEINS.map((p) => <div key={p.id} onClick={() => toggle(p.id, proteins, setProteins)} style={chipS(proteins.includes(p.id))}>{p[lang]}</div>)}
                </div>
              </div>
              <div style={{ marginBottom: 16 }}>
                <label style={label}>{T("cuisine")}</label>
                <div style={{ display: "flex", flexWrap: "wrap", gap: 7 }}>
                  {CUISINES.map((c) => <div key={c.id} onClick={() => toggle(c.id, cuisines, setCuisines)} style={chipS(cuisines.includes(c.id))}>{c[lang]}</div>)}
                </div>
              </div>

              <div style={{ height: 1, background: LINE, margin: "2px 0 16px" }} />
              <div style={{ marginBottom: 18 }}>
                <label style={label}>{T("trainingDays")}</label>
                <div style={{ display: "flex", gap: 5, marginBottom: 8 }}>
                  {WD[lang].map((d, i) => <div key={i} onClick={() => toggle(i, trainingDays, setTrainingDays)} style={dayChip(trainingDays.includes(i))}>{d}</div>)}
                </div>
                <div style={{ fontSize: 11, color: MUTED, lineHeight: 1.5 }}>{T("trainingDaysHint")}</div>
              </div>

              <button onClick={handleBuild} disabled={loading} style={{ width: "100%", background: EMBER, color: PAPER, border: "none", padding: "14px 0", borderRadius: 10, ...disp, fontWeight: 700, fontSize: 16, letterSpacing: 1, textTransform: "uppercase", cursor: loading ? "default" : "pointer", opacity: loading ? 0.7 : 1 }}>
                {loading ? T("building") : T("build")}
              </button>
            </div>

            <div>
              {!started && (
                <div style={{ border: `1px dashed ${LINE}`, borderRadius: 14, padding: "48px 24px", textAlign: "center", color: MUTED }}>
                  <div style={{ ...disp, fontSize: 24, fontWeight: 600, color: PAPER, marginBottom: 8 }}>{T("emptyTitle")}</div>
                  <div style={{ fontSize: 13.5, lineHeight: 1.6 }}>{T("emptyBody")}</div>
                </div>
              )}

              {started && (
                <>
                  {targets && (
                    <div style={{ background: INK2, border: `1px solid ${LINE}`, borderRadius: 14, padding: 16, marginBottom: 16 }}>
                      <div style={{ display: "flex", justifyContent: "space-between", alignItems: "baseline", marginBottom: 12 }}>
                        <div style={{ ...label, marginBottom: 0 }}>{T("dailyTargets")}</div>
                        <div style={{ ...disp, fontSize: 28, fontWeight: 700 }}>{targets.kcal}<span style={{ fontSize: 12, color: MUTED, fontWeight: 400, marginLeft: 5 }}>kcal</span></div>
                      </div>
                      {targets.maintenance != null && (
                        <div style={{ fontSize: 12, color: MUTED, marginBottom: 12 }}>
                          {T("maintenance")} ≈ <span style={{ color: PAPER }}>{targets.maintenance} kcal</span>{targets.kcal !== targets.maintenance && <> · {targets.kcal < targets.maintenance ? (targets.maintenance - targets.kcal) + " " + T("below") : (targets.kcal - targets.maintenance) + " " + T("above")}</>}{targets.bmi != null && <> · BMI <span style={{ color: PAPER }}>{targets.bmi}</span></>}
                        </div>
                      )}
                      {targets.bmi != null && (<div style={{ fontSize: 11, color: MUTED, marginBottom: 12, lineHeight: 1.5 }}>{T("bmiNote")}</div>)}
                      <div style={{ display: "grid", gridTemplateColumns: "1fr 1fr 1fr", gap: 8 }}>
                        {[[T("protein"), targets.protein, EMBER], [T("carbs"), targets.carbs, EMBER_SOFT], [T("fat"), targets.fat, SAGE]].map(([n, v, c]) => (
                          <div key={n} style={{ background: INK, borderRadius: 10, padding: "10px 12px", borderLeft: `3px solid ${c}` }}>
                            <div style={{ fontSize: 10, letterSpacing: 1, textTransform: "uppercase", color: MUTED, fontWeight: 600 }}>{n}</div>
                            <div style={{ ...disp, fontSize: 20, fontWeight: 600 }}>{v}<span style={{ fontSize: 10, color: MUTED, marginLeft: 3 }}>g</span></div>
                          </div>
                        ))}
                      </div>
                      {hasCycle && (
                        <div style={{ display: "flex", gap: 8, marginTop: 12 }}>
                          <div style={{ flex: 1, background: INK, borderRadius: 10, padding: "9px 12px", borderLeft: `3px solid ${EMBER}` }}>
                            <div style={{ fontSize: 10, letterSpacing: 1, textTransform: "uppercase", color: MUTED, fontWeight: 600 }}>{T("cycleTrain")}</div>
                            <div style={{ ...disp, fontSize: 18, fontWeight: 600 }}>{targets.train.kcal}<span style={{ fontSize: 10, color: MUTED, marginLeft: 3 }}>kcal · {targets.train.carbs}g {T("carbs").toLowerCase()}</span></div>
                          </div>
                          <div style={{ flex: 1, background: INK, borderRadius: 10, padding: "9px 12px", borderLeft: `3px solid ${SAGE}` }}>
                            <div style={{ fontSize: 10, letterSpacing: 1, textTransform: "uppercase", color: MUTED, fontWeight: 600 }}>{T("cycleRest")}</div>
                            <div style={{ ...disp, fontSize: 18, fontWeight: 600 }}>{targets.rest.kcal}<span style={{ fontSize: 10, color: MUTED, marginLeft: 3 }}>kcal · {targets.rest.carbs}g {T("carbs").toLowerCase()}</span></div>
                          </div>
                        </div>
                      )}
                      <div style={lowBmi ? { marginTop: 12, border: `1px solid ${EMBER}`, background: "rgba(225,29,72,0.14)", borderRadius: 10, padding: "10px 12px" } : { marginTop: 12, borderLeft: `2px solid ${EMBER}`, padding: "2px 0 2px 12px" }}>
                        <span style={{ fontSize: 11, fontWeight: 700, color: PAPER, textTransform: "uppercase", letterSpacing: 0.5 }}>{lowBmi ? "⚠ " + T("lowBmiTitle") : T("safeTitle")}. </span>
                        <span style={{ fontSize: 11.5, color: lowBmi ? PAPER : MUTED, lineHeight: 1.5 }}>{safeText}</span>
                      </div>
                    </div>
                  )}

                  {loading && <div style={{ textAlign: "center", padding: "40px 0", color: EMBER, ...disp, fontSize: 17, letterSpacing: 1 }}><span className="dot">{T("cooking")}</span></div>}

                  {error && !loading && (
                    <div style={{ background: "rgba(225,29,72,0.1)", border: `1px solid ${EMBER}`, borderRadius: 12, padding: 16, textAlign: "center" }}>
                      <div style={{ marginBottom: 12, color: PAPER, fontSize: 13, wordBreak: "break-word" }}>{error}</div>
                      <button onClick={handleBuild} style={{ background: EMBER, color: PAPER, border: "none", padding: "9px 22px", borderRadius: 8, fontWeight: 700, cursor: "pointer", ...disp, letterSpacing: 1 }}>{T("retry")}</button>
                    </div>
                  )}

                  {week && !loading && unlocked && (
                    <>
                      <div style={{ background: INK2, border: `1px solid ${LINE}`, borderRadius: 14, padding: 16, marginBottom: 16 }}>
                        <div style={{ ...label, marginBottom: 10 }}>{T("dlTitle")}</div>
                        {planEmail === "sent" && <div style={{ fontSize: 12, color: SAGE, marginBottom: 10, lineHeight: 1.5 }}>{T("emailedPlan")}</div>}
                        {planEmail === "sending" && <div style={{ fontSize: 12, color: MUTED, marginBottom: 10, lineHeight: 1.5 }}>{T("emailingPlan")}</div>}
                        <div style={{ display: "flex", flexWrap: "wrap", gap: 10 }}>
                          <div onClick={downloadTracker} style={{ cursor: trackerBusy ? "default" : "pointer", opacity: trackerBusy ? 0.7 : 1, padding: "10px 16px", borderRadius: 8, border: "none", background: EMBER, color: PAPER, fontSize: 13, fontWeight: 700, ...disp, letterSpacing: 0.3 }}>{trackerBusy ? T("dlPreparing") : T("dlTracker")}</div>
                          {tier === "bundle" && <a href={`https://www.hybridfuelco.com/hyrox-guide-${lang}.pdf`} target="_blank" rel="noopener" style={{ textDecoration: "none", padding: "10px 16px", borderRadius: 8, border: `1px solid ${EMBER}`, color: EMBER, fontSize: 13, fontWeight: 700, ...disp, letterSpacing: 0.3 }}>{T("dlGuide")}</a>}
                        </div>
                        <div style={{ fontSize: 11.5, color: MUTED, marginTop: 10, lineHeight: 1.5 }}>{T("dlHint")}</div>
                      </div>
                      <div style={{ marginBottom: 14, display: "flex", justifyContent: "space-between", alignItems: "center", gap: 10, flexWrap: "wrap" }}>
                        <div style={{ display: "inline-flex", gap: 4, background: INK2, border: `1px solid ${LINE}`, borderRadius: 10, padding: 4 }}>
                          {[["plan", T("tabPlan")], ["shop", T("tabShop")]].map(([id, lbl]) => (
                            <div key={id} onClick={() => setView(id)} style={{ padding: "8px 16px", borderRadius: 7, background: view === id ? EMBER : "transparent", color: PAPER, fontSize: 13, fontWeight: 700, ...disp, letterSpacing: 0.5, cursor: "pointer" }}>{lbl}</div>
                          ))}
                        </div>
                        {view === "plan" && (
                          <div style={{ display: "flex", gap: 8 }}>
                            {planEdit && <div onClick={() => setShowProducts(true)} style={{ cursor: "pointer", padding: "8px 14px", borderRadius: 8, border: `1px solid ${LINE}`, color: EMBER, fontSize: 13, fontWeight: 700, ...disp, letterSpacing: 0.5 }}>{T("myProducts")}</div>}
                            <div onClick={toggleEdit} style={{ cursor: "pointer", padding: "8px 16px", borderRadius: 8, border: `1px solid ${planEdit ? EMBER : LINE}`, background: planEdit ? EMBER : "transparent", color: planEdit ? PAPER : EMBER, fontSize: 13, fontWeight: 700, ...disp, letterSpacing: 0.5 }}>{planEdit ? T("editDone") : T("editPlan")}</div>
                          </div>
                        )}
                      </div>

                      {view === "plan" && planEdit && <div style={{ fontSize: 11.5, color: MUTED, marginBottom: 12, lineHeight: 1.5 }}>{T("editHint")}</div>}
                      {view === "plan" && (<div style={{ display: "grid", gap: 12 }}>{week.days.map((day, di) => planEdit ? <EditDayCard key={di} day={day} di={di} /> : <DayCard key={di} day={day} />)}</div>)}
                      {view === "shop" && (
                        <div style={{ display: "grid", gap: 12 }}>
                          <div style={{ fontSize: 12, color: MUTED }}>{T("shopHint")}</div>
                          {shoppingFor(week).map((cat, ci) => (
                            <div key={ci} style={{ background: INK2, border: `1px solid ${LINE}`, borderRadius: 12, overflow: "hidden" }}>
                              <div style={{ padding: "10px 14px", background: INK, borderBottom: `1px solid ${LINE}`, ...disp, fontWeight: 600, fontSize: 13.5, letterSpacing: 1, textTransform: "uppercase", color: EMBER }}>{cat.n}</div>
                              {cat.items.map((item, ii) => {
                                const key = cat.n + ":" + item.name, on = checked[key];
                                return (
                                  <div key={ii} onClick={() => setChecked((p) => ({ ...p, [key]: !p[key] }))} style={{ display: "flex", alignItems: "center", gap: 11, padding: "10px 14px", borderBottom: ii < cat.items.length - 1 ? `1px solid ${LINE}` : "none", cursor: "pointer" }}>
                                    <div style={{ width: 19, height: 19, borderRadius: 6, border: `2px solid ${on ? EMBER : MUTED}`, background: on ? EMBER : "transparent", display: "flex", alignItems: "center", justifyContent: "center", flexShrink: 0, color: INK, fontSize: 12, fontWeight: 800 }}>{on ? "✓" : ""}</div>
                                    <div style={{ flex: 1, fontSize: 13.5, color: on ? MUTED : PAPER, textDecoration: on ? "line-through" : "none" }}>{item.name}</div>
                                    <div style={{ fontSize: 12.5, color: on ? MUTED : EMBER, fontWeight: 600, ...disp }}>{item.g >= 1000 ? (item.g / 1000).toFixed(1) + " kg" : item.g + " g"}</div>
                                  </div>
                                );
                              })}
                            </div>
                          ))}
                        </div>
                      )}
                    </>
                  )}

                  {targets && !loading && !error && !unlocked && (
                    <div style={{ border: `1px solid ${EMBER}`, borderRadius: 14, padding: 20, background: "linear-gradient(180deg, rgba(225,29,72,0.09), transparent 60%)" }}>
                      <div style={{ ...disp, fontSize: 20, fontWeight: 700, letterSpacing: 0.3, marginBottom: 6 }}>{lockReason === "no_credits" ? T("creditsOutTitle") : T("lockTitle")}</div>
                      <div style={{ fontSize: 12.5, color: MUTED, marginBottom: 16, lineHeight: 1.5 }}>{lockReason === "no_credits" ? T("creditsOutSub") : T("lockSub")}</div>
                      <div style={{ display: "grid", gap: 9, marginBottom: 18 }}>
                        {[T("lb1"), T("lb2"), T("lb3")].map((t, i) => (
                          <div key={i} style={{ display: "flex", gap: 9, alignItems: "flex-start", fontSize: 13.5 }}><span style={{ color: EMBER, fontWeight: 800 }}>✓</span><span>{t}</span></div>
                        ))}
                        <div style={{ display: "flex", gap: 9, alignItems: "flex-start", fontSize: 13.5, color: MUTED }}><span style={{ color: EMBER_SOFT, fontWeight: 800 }}>+</span><span>{T("lbBundle")}</span></div>
                      </div>
                      <a href={STRIPE_WEEK_LINK} style={{ display: "block", textAlign: "center", background: EMBER, color: PAPER, textDecoration: "none", padding: "14px 0", borderRadius: 10, ...disp, fontWeight: 700, fontSize: 15.5, letterSpacing: 0.5, marginBottom: 9 }}>{T("unlockWeek")}</a>
                      <a href={STRIPE_BUNDLE_LINK} style={{ display: "block", textAlign: "center", background: "transparent", color: PAPER, textDecoration: "none", padding: "12px 0", borderRadius: 10, border: `1px solid ${LINE}`, ...disp, fontWeight: 700, fontSize: 14, letterSpacing: 0.5 }}>{T("unlockBundle")}</a>
                      <div style={{ fontSize: 11, color: MUTED, marginTop: 12, textAlign: "center" }}>{T("lockFoot")}</div>
                    </div>
                  )}

                  {targets && !loading && !error && !unlocked && (
                    <div style={{ marginTop: 16, border: `1px solid ${LINE}`, borderRadius: 14, padding: 18, background: INK2 }}>
                      {leadStatus === "ok" ? (
                        <div>
                          <div style={{ ...disp, fontSize: 16, fontWeight: 700, marginBottom: 4 }}>{T("leadOkTitle")}</div>
                          <div style={{ fontSize: 12.5, color: MUTED, lineHeight: 1.5 }}>{T("leadOkBody")}</div>
                        </div>
                      ) : (
                        <div>
                          <div style={{ ...disp, fontSize: 16, fontWeight: 700, marginBottom: 4 }}>{T("leadTitle")}</div>
                          <div style={{ fontSize: 12.5, color: MUTED, marginBottom: 12, lineHeight: 1.5 }}>{T("leadSub")}</div>
                          <div style={{ display: "flex", gap: 8, flexWrap: "wrap" }}>
                            <input style={{ ...input, flex: 1, minWidth: 180 }} type="email" value={email} onChange={(ev) => { setEmail(ev.target.value); if (leadStatus !== "idle") setLeadStatus("idle"); }} placeholder={T("leadPh")} />
                            <button onClick={subscribe} disabled={leadStatus === "sending"} style={{ background: "transparent", color: EMBER, border: `1px solid ${EMBER}`, padding: "11px 18px", borderRadius: 8, ...disp, fontWeight: 700, fontSize: 13, letterSpacing: 0.3, cursor: leadStatus === "sending" ? "default" : "pointer", whiteSpace: "nowrap" }}>
                              {leadStatus === "sending" ? T("leadSending") : T("leadBtn")}
                            </button>
                          </div>
                          {leadStatus === "bad" && <div style={{ fontSize: 11.5, color: EMBER_SOFT, marginTop: 8 }}>{T("leadBad")}</div>}
                          {leadStatus === "err" && <div style={{ fontSize: 11.5, color: EMBER_SOFT, marginTop: 8 }}>{T("leadErr")}</div>}
                        </div>
                      )}
                    </div>
                  )}
                </>
              )}
            </div>

            <div style={{ textAlign: "center", padding: "6px 8px 4px", color: MUTED, fontSize: 10.5, lineHeight: 1.6 }}>{T("footer")}</div>
          </div>
        )}

        {/* ====== OTHER TABS ====== */}
        {tab === "today" && <Today lang={lang} week={week} onGoPlan={() => setTab("plan")} />}
        {tab === "tracker" && <Tracker lang={lang} height={height} session={session} />}
        {tab === "water" && <Water lang={lang} session={session} week={week} />}
        {tab === "recipes" && <Recipes lang={lang} />}
      </div>

      {/* BOTTOM NAV */}
      <div style={{ position: "fixed", left: 0, right: 0, bottom: consentH, background: INK, borderTop: `1px solid ${LINE}`, display: "flex", zIndex: 30, paddingBottom: "env(safe-area-inset-bottom)", transition: "bottom .2s" }}>
        {NAV.map(([id, key]) => {
          const on = tab === id;
          return (
            <div key={id} onClick={() => { setTab(id); try { window.scrollTo(0, 0); } catch (e) {} }} style={{ flex: 1, display: "flex", flexDirection: "column", alignItems: "center", gap: 3, padding: "9px 0 8px", cursor: "pointer" }}>
              <Icon name={id} on={on} />
              <div style={{ fontSize: 10.5, fontWeight: 600, color: on ? EMBER : MUTED, letterSpacing: 0.3 }}>{T(key)}</div>
            </div>
          );
        })}
      </div>

      {showReminders && <Reminders lang={lang} onClose={() => setShowReminders(false)} />}
      {showAuth && <Auth lang={lang} session={session} tier={subTier} onClose={() => setShowAuth(false)} />}
      {showProducts && <Products lang={lang} session={session} onClose={() => { setShowProducts(false); setPickTarget(null); }} onPick={pickTarget ? (prod) => { addProductIng(pickTarget.di, pickTarget.mi, prod); setShowProducts(false); setPickTarget(null); } : null} />}
    </div>
  );
}
