import React, { useState, useEffect, useRef } from "react";
import { INK, INK2, EMBER, EMBER_SOFT, PAPER, MUTED, LINE, SAGE, load, save, genSteps, todayISO, macroLetters, wUnit, bUnit, gShow, gStore, kgShow, kgStore, cmToFtIn, ftInToCm, applyOrgTheme } from "./shared.js";
import Today from "./views/Today.jsx";
import Dashboard from "./views/Dashboard.jsx";
import RecipeBuilder from "./views/RecipeBuilder.jsx";
import Tracker from "./views/Tracker.jsx";
import Water from "./views/Water.jsx";
import Products from "./views/Products.jsx";
import Recipes from "./views/Recipes.jsx";
import RaceProtocol from "./views/RaceProtocol.jsx";
import Training from "./views/Training.jsx";
import { RECIPES, snackOptions } from "./recipes.js";
import Reminders, { checkReminders } from "./views/Reminders.jsx";
import Auth from "./views/Auth.jsx";
import Join from "./views/Join.jsx";
import CoachDash from "./views/CoachDash.jsx";
import GymAgendaMember from "./views/GymAgendaMember.jsx";
import GymClasses from "./views/GymClasses.jsx";
import { supabase } from "./supabaseClient.js";
import { initCloudSync, pullAll } from "./cloudsync.js";
import { Dropdown, MultiDropdown } from "./ui.jsx";

// ===== Dev-modus demo-plan (alleen voor review op preview/localhost) =====
const DEMO_TARGETS = { kcal: 2400, protein: 180, carbs: 240, fat: 70, bmi: 24.1, train: { kcal: 2600 }, rest: { kcal: 2200 } };
function demoWeek(lang, nSnack = 0, snackLikes = []) {
  const names = lang === "nl" ? ["Ma", "Di", "Wo", "Do", "Vr", "Za", "Zo"] : ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];
  const SNK = lang === "nl" ? "TUSSENDOORTJE" : "SNACK";
  const L = lang === "nl" ? "nl" : "en";
  // Kies uit de tussendoortjes-database (banaan vooraan als default). Per dag
  // andere opties zodat de week niet elke dag "banaan" is.
  const pool = snackOptions(snackLikes).map((s) => ({ t: SNK, n: s[L], kcal: s.kcal, p: s.p, c: s.c, f: s.f, ing: s.ing.map((g) => ({ n: g[L], g: g.g })) }));
  const nS = Math.max(0, Math.min(3, nSnack));
  const pickSnacks = (dayIdx) => Array.from({ length: nS }, (_, i) => { const src = pool[(dayIdx + i * 3) % pool.length]; return { ...src, ing: src.ing.map((g) => ({ ...g })) }; });
  const train = [
    { t: lang === "nl" ? "ONTBIJT" : "BREAKFAST", n: lang === "nl" ? "Skyr met havermout & bessen" : "Skyr with oats & berries", kcal: 520, p: 42, c: 60, f: 12, ing: [{ n: "skyr", g: 250 }, { n: lang === "nl" ? "havermout" : "oats", g: 60 }, { n: lang === "nl" ? "blauwe bessen" : "blueberries", g: 80 }] },
    { t: "LUNCH", n: lang === "nl" ? "Kipfilet, rijst & broccoli" : "Chicken, rice & broccoli", kcal: 680, p: 55, c: 80, f: 14, ing: [{ n: lang === "nl" ? "kipfilet" : "chicken breast", g: 180 }, { n: lang === "nl" ? "rijst" : "rice", g: 90 }, { n: "broccoli", g: 150 }] },
    { t: lang === "nl" ? "DINER" : "DINNER", n: lang === "nl" ? "Zalm met aardappel & spinazie" : "Salmon with potato & spinach", kcal: 700, p: 48, c: 55, f: 28, ing: [{ n: lang === "nl" ? "zalm" : "salmon", g: 170 }, { n: lang === "nl" ? "aardappel" : "potato", g: 300 }, { n: lang === "nl" ? "spinazie" : "spinach", g: 100 }] },
  ];
  const rest = [
    { t: lang === "nl" ? "ONTBIJT" : "BREAKFAST", n: lang === "nl" ? "Omelet met volkorenbrood" : "Omelet with wholegrain bread", kcal: 450, p: 32, c: 38, f: 18, ing: [{ n: lang === "nl" ? "eieren" : "eggs", g: 150 }, { n: lang === "nl" ? "volkorenbrood" : "wholegrain bread", g: 80 }] },
    { t: "LUNCH", n: lang === "nl" ? "Kwark met noten & appel" : "Quark with nuts & apple", kcal: 420, p: 34, c: 32, f: 16, ing: [{ n: lang === "nl" ? "magere kwark" : "low-fat quark", g: 300 }, { n: lang === "nl" ? "walnoten" : "walnuts", g: 20 }, { n: lang === "nl" ? "appel" : "apple", g: 150 }] },
    { t: lang === "nl" ? "DINER" : "DINNER", n: lang === "nl" ? "Rundergehakt met quinoa" : "Beef mince with quinoa", kcal: 620, p: 46, c: 52, f: 22, ing: [{ n: lang === "nl" ? "rundergehakt 5%" : "beef mince 5%", g: 150 }, { n: "quinoa", g: 80 }, { n: lang === "nl" ? "courgette" : "zucchini", g: 150 }] },
  ];
  const withSnacks = (base, dayIdx) => {
    const [bf, lu, di] = base.map((m) => ({ ...m, ing: m.ing.map((g) => ({ ...g })) }));
    const snk = pickSnacks(dayIdx);
    const order = [bf]; if (snk[0]) order.push(snk[0]);
    order.push(lu); if (snk[1]) order.push(snk[1]);
    order.push(di); if (snk[2]) order.push(snk[2]);
    return order;
  };
  return { days: names.map((d, i) => { const tr = i % 2 === 0; return { d, train: tr, m: withSnacks(tr ? train : rest, i) }; }) };
}

// Roept GEEN Claude aan vanuit de browser, alles via /api/plan (key zit op de server).
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
const VARIETY = [
  { id: "varied", nl: "Veel variatie", en: "Lots of variety" },
  { id: "mix", nl: "Beetje van beide", en: "A bit of both" },
  { id: "fixed", nl: "Vaste patronen", en: "Fixed patterns" },
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
const SNACKS = [
  { id: "fruit", nl: "Fruit", en: "Fruit" },
  { id: "nuts", nl: "Noten", en: "Nuts" },
  { id: "yoghurt", nl: "(Griekse) yoghurt", en: "(Greek) yoghurt" },
  { id: "quark", nl: "Kwark/Skyr", en: "Quark/Skyr" },
  { id: "bar", nl: "Eiwitreep", en: "Protein bar" },
  { id: "ricecake", nl: "Rijstwafels", en: "Rice cakes" },
  { id: "shake", nl: "Shake", en: "Shake" },
  { id: "veg", nl: "Groente/dips", en: "Veg/dips" },
];

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
  sexLbl: { nl: "Geslacht", en: "Sex" },
  pickMulti: { nl: "Kies (meerdere mogelijk)…", en: "Choose (multiple)…" },
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
  variety: { nl: "Afwisseling in maaltijden", en: "Meal variety" },
  varietyHint: { nl: "Wil je elke dag andere maaltijden, of juist je vaste patroon (bijv. elke ochtend hetzelfde ontbijt)? Bij vaste patronen herhalen we je maaltijden en passen we alleen de porties aan.", en: "Do you want different meals each day, or your fixed routine (e.g. the same breakfast every morning)? With fixed patterns we repeat your meals and only adjust the portions." },
  snacksLbl: { nl: "Tussendoortjes per dag", en: "Snacks per day" },
  snacksHint: { nl: "Verdeelt de dag beter, je krijgt 3 hoofdmaaltijden + dit aantal tussendoortjes.", en: "Spreads the day better, you get 3 main meals + this many snacks." },
  snackLikesLbl: { nl: "Wat voor tussendoortjes?", en: "What kind of snacks?" },
  trainingDays: { nl: "Trainingsdagen", en: "Training days" },
  trainingDaysHint: { nl: "Welke dagen train je? Die dagen krijgen meer calorieën (koolhydraten), rustdagen minder, je weekgemiddelde blijft op je doel.", en: "Which days do you train? Those days get more calories (carbs), rest days fewer, your weekly average stays on your goal." },
  build: { nl: "Maak mijn plan", en: "Build my plan" },
  building: { nl: "Bezig…", en: "Building…" },
  emptyTitle: { nl: "Fuel the work.", en: "Fuel the work." },
  emptyBody: { nl: "Vul je gegevens in. Je krijgt gratis je persoonlijke macro's en trainings/rust-verdeling. Het volledige maaltijdplan ontgrendel je daarna.", en: "Enter your stats. You'll get your personal macros and training/rest split for free. Unlock the full meal plan after that." },
  dailyTargets: { nl: "Dagdoelen (weekgemiddelde)", en: "Daily targets (weekly average)" },
  maintenance: { nl: "Onderhoud", en: "Maintenance" },
  statsHint: { nl: "Vul naar waarheid in. Hierop baseren we je macro's en je BMI.", en: "Enter accurately. Your macros and BMI are based on these." },
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
  safeCut: { nl: "Mik op 0,5–1% van je gewicht per week afvallen. Gaat het sneller? Eet iets meer, snelheid kost spier en herstel.", en: "Aim to lose 0.5–1% of bodyweight per week. Going faster? Eat a bit more, speed costs muscle and recovery." },
  safeMaintain: { nl: "Onderhoud = binnen ±0,5% per week blijven, beide kanten op.", en: "Maintenance = stay within ±0.5% per week, either way." },
  safeGain: { nl: "Opbouwen: 0,25–0,5% per week. Sneller aankomen is vooral vet, geen kracht.", en: "Building: 0.25–0.5% per week. Faster gain is mostly fat, not strength." },
  lowBmiTitle: { nl: "Belangrijk", en: "Important" },
  lowBmiWarn: { nl: "Op basis van je lengte en gewicht zit je al in een laag bereik (BMI onder 18,5). Verder afvallen raden we af, je doel staat daarom op onderhoud. Twijfel je? Overleg met een arts of diëtist.", en: "Based on your height and weight you're already in a low range (BMI under 18.5). We don't recommend losing more, your target is set to maintenance. In doubt? Talk to a doctor or dietitian." },
  flooredWarn: { nl: "Dit is de laagste inname die we voor jouw lichaam nog veilig vinden (minimaal 1.200 kcal voor vrouwen / 1.500 voor mannen, en nooit onder je ruststofwisseling). Lager eten werkt averechts, het remt vetverlies, kost energie en spiermassa. Bij een medische aandoening of een verleden met een eetstoornis: overleg eerst met een professional.", en: "This is the lowest intake we'd safely suggest for your body (at least 1,200 kcal for women / 1,500 for men, and never below your resting metabolism). Eating less backfires, it stalls fat loss, drains energy and costs muscle. With a medical condition or any history of disordered eating, check with a professional first." },
  tabPlan: { nl: "Plan", en: "Plan" },
  tabShop: { nl: "Boodschappen", en: "Shopping list" },
  editPlan: { nl: "Aanpassen", en: "Edit" },
  editDone: { nl: "Opslaan", en: "Save" },
  savedFlash: { nl: "Opgeslagen", en: "Saved" },
  toDashboard: { nl: "Naar dashboard", en: "To dashboard" },
  logoutTitle: { nl: "Weet je zeker dat je wilt uitloggen?", en: "Are you sure you want to log out?" },
  logoutYes: { nl: "Ja, uitloggen", en: "Yes, log out" },
  logoutNo: { nl: "Nee, blijf", en: "No, stay" },
  addMeal: { nl: "+ Maaltijd", en: "+ Meal" },
  addIngr: { nl: "+ Ingrediënt", en: "+ Ingredient" },
  addProd: { nl: "+ Uit producten", en: "+ From products" },
  addRecipe: { nl: "+ Uit recepten", en: "+ From recipes" },
  copyDay: { nl: "Kopieer dag", en: "Copy day" },
  copyMeal: { nl: "Kopieer", en: "Copy" },
  toDate: { nl: "tot datum", en: "to date" },
  movePlan: { nl: "Verplaats / kopieer", en: "Move / copy" },
  moveTitle: { nl: "Verplaats of kopieer", en: "Move or copy" },
  moveWeekScope: { nl: "Hele week", en: "Whole week" },
  moveDayScope: { nl: "Dag", en: "Day" },
  actCopy: { nl: "Kopiëren", en: "Copy" },
  actMove: { nl: "Verplaatsen", en: "Move" },
  tgtNextWeek: { nl: "Volgende week", en: "Next week" },
  tgtPickWeek: { nl: "Kies een week (datum)", en: "Pick a week (date)" },
  tgtPickDate: { nl: "Specifieke datum", en: "Specific date" },
  moveDo: { nl: "Zet op kalender", en: "Place on calendar" },
  moveHint: { nl: "Je plan verschijnt op die datum(s) in je Dagboek en gaat vóór je vaste weekschema. Verplaatsen wist de bron.", en: "Your plan appears on those date(s) in your Diary, overriding your default week. Move clears the source." },
  moveWeekTo: { nl: "Zet de hele week vanaf deze maandag:", en: "Place the whole week from this Monday:" },
  movePlaced: { nl: "Gezet ✓", en: "Placed ✓" },
  movePlannedLbl: { nl: "Op de kalender gezet", en: "Placed on calendar" },
  moveClear: { nl: "Wissen", en: "Clear" },
  saveAsRecipe: { nl: "Bewaar als recept", en: "Save as recipe" },
  editVals: { nl: "Waarden bewerken", en: "Edit values" },
  applyVals: { nl: "Toepassen", en: "Apply" },
  ingValsHint: { nl: "Voedingswaarde per 100 g voor dit ingrediënt. Pas eiwit, koolhydraten of vet aan; de maaltijd herberekent.", en: "Nutrition per 100 g for this ingredient. Adjust protein, carbs or fat; the meal recalculates." },
  toProduct: { nl: "Bewaar in producten", en: "Save to products" },
  linkedTag: { nl: "gekoppeld", en: "linked" },
  per100Hint: { nl: "Voedingswaarde per 100 g. Dit ingrediënt komt in je producten en blijft gekoppeld, pas je het daar aan, dan verandert het hier mee.", en: "Nutrition per 100 g. This ingredient goes to your products and stays linked, change it there and it updates here." },
  ingName: { nl: "Naam", en: "Name" },
  cancelShort: { nl: "Annuleer", en: "Cancel" },
  savedAsRecipe: { nl: "Opgeslagen ✓", en: "Saved ✓" },
  copyToTitle: { nl: "Kopieer naar…", en: "Copy to…" },
  copyDayToLbl: { nl: "Kopieer de hele dag (alle maaltijden) naar:", en: "Copy the whole day (all meals) to:" },
  copyMealToLbl: { nl: "Kopieer deze maaltijd naar:", en: "Copy this meal to:" },
  pickRecipe: { nl: "Kies een recept", en: "Pick a recipe" },
  noRecipes: { nl: "Nog geen eigen recepten. Maak er een aan onder Recepten.", en: "No recipes yet. Create one under Recipes." },
  searchRecipePh: { nl: "Zoek een recept…", en: "Search a recipe…" },
  mineRecipes: { nl: "Mijn recepten", en: "My recipes" },
  addTitle: { nl: "Toevoegen", en: "Add" },
  addFromDb: { nl: "Uit recepten", en: "From recipes" },
  addFromDbSub: { nl: "Mijn recepten + de bibliotheek · schaalbaar", en: "My recipes + the library · scalable" },
  addEmpty: { nl: "Lege maaltijd", en: "Empty meal" },
  addEmptySub: { nl: "Zelf ingrediënten toevoegen", en: "Add ingredients yourself" },
  addFromProd: { nl: "Uit mijn producten", en: "From my products" },
  addFromProdSub: { nl: "Gescande / eigen producten", en: "Scanned / own products" },
  fromDb: { nl: "recept", en: "recipe" },
  libHeader: { nl: "Receptenbibliotheek", en: "Recipe library" },
  mealOpts: { nl: "Opties", en: "Options" },
  removeMealTxt: { nl: "Verwijderen", en: "Remove" },
  buildOwn: { nl: "Of: zelf samenstellen", en: "Or: build your own" },
  ownPlanHint: { nl: "Leeg weekschema, vul elke dag zelf met de +.", en: "Empty week, fill each day yourself with the +." },
  cancel: { nl: "Annuleren", en: "Cancel" },
  system: { nl: "van ons", en: "from us" },
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
  emailedPlan: { nl: "📧 Ook naar je mail (betaaladres) gestuurd, je kunt 'm hieronder ook downloaden.", en: "📧 Also sent to your email, you can download it below too." },
  emailingPlan: { nl: "📧 Je plan wordt naar je mail gestuurd…", en: "📧 Sending your plan to your email…" },
  freeSample: { nl: "Gratis voorbeelddag", en: "Free sample day" },
  lockTitle: { nl: "Je persoonlijke weekplan", en: "Your personal week plan" },
  lockSub: { nl: "Je cijfers staan hierboven. Dit is het plan dat de app voor jóu bouwt: exacte grammen per maaltijd, afgestemd op je trainings- en rustdagen, en opnieuw te plannen als je week verandert. De gratis gids, het weekplan en de Excel-tracker heb je al.", en: "Your numbers are above. This is the plan the app builds for you: exact weights per meal, tuned to your training and rest days, re-planned whenever your week changes. The free guide, week plan and Excel tracker are already yours." },
  lb1: { nl: "Jouw weekplan in de app, automatisch op je doel", en: "Your week plan in the app, auto-built on your goal" },
  lb2: { nl: "Exacte grammen per maaltijd + 100+ recepten", en: "Exact weights per meal + 100+ recipes" },
  lb3: { nl: "Dagelijks tracken, slim herplannen en Hyrox-raceprotocol", en: "Daily tracking, smart re-plan and Hyrox race protocol" },
  lockFoot: { nl: "Direct toegang na betaling. Eenmalig — geen abonnement.", en: "Instant access after payment. One-time — no subscription." },
  subscribeCta: { nl: "Krijg de volledige app · vanaf €9,95", en: "Get the full app · from €9.95" },
  subYearUpsell: { nl: "Of pak 1 jaar — 2 maanden gratis →", en: "Or get 1 year — 2 months free →" },
  subOk: { nl: "Betaling gelukt! Ben je al ingelogd, dan staat je plan klaar. Zo niet: check je mail voor je inlog-link.", en: "Payment complete! If you're logged in, your plan is ready. If not, check your email for your login link." },
  subCancel: { nl: "Afrekenen geannuleerd.", en: "Checkout canceled." },
  subErr: { nl: "Afrekenen is even niet beschikbaar. Probeer het later opnieuw.", en: "Checkout is temporarily unavailable. Please try again later." },
  lockedTitle: { nl: "Zit in Basis", en: "Part of Basic" },
  lockedSub: { nl: "Deze functie zit in de betaalde toegang. Ontgrendel de volledige app.", en: "This feature is part of paid access. Unlock the full app." },
  lockedPro: { nl: "Zit in Pro", en: "Part of Pro" },
  lockedProSub: { nl: "Eigen producten en barcode-scan zitten in Pro.", en: "Own products and barcode scan are in Pro." },
  unlockBtn: { nl: "Bekijk toegang", en: "See access options" },
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
  navToday: { nl: "Dagboek", en: "Diary" },
  navTracker: { nl: "Tracker", en: "Tracker" },
  navWater: { nl: "Water", en: "Water" },
  navProducts: { nl: "Producten", en: "Products" },
  navRecipes: { nl: "Recepten", en: "Recipes" },
  navRace: { nl: "Race", en: "Race" },
  navDash: { nl: "Home", en: "Home" },
  navMore: { nl: "Meer", en: "More" },
  install: { nl: "Installeer de app", en: "Install the app" },
  installHint: { nl: "Zet HybridFuelCo op je beginscherm, sneller, met herinneringen.", en: "Add HybridFuelCo to your home screen, faster, with reminders." },
  installBtn: { nl: "Installeren", en: "Install" },
  installHelpTitle: { nl: "Zet de app op je telefoon", en: "Add the app to your phone" },
  installIosT: { nl: "iPhone (Safari)", en: "iPhone (Safari)" },
  installIos1: { nl: "Tik onderin op het deel-icoon (vierkantje met pijl omhoog).", en: "Tap the Share icon at the bottom (square with an up arrow)." },
  installIos2: { nl: "Kies “Zet op beginscherm”.", en: "Choose “Add to Home Screen”." },
  installIos3: { nl: "Tik op “Voeg toe”, de app staat nu tussen je andere apps.", en: "Tap “Add”, the app now sits with your other apps." },
  installAndroidT: { nl: "Android (Chrome)", en: "Android (Chrome)" },
  installAndroid1: { nl: "Tik rechtsboven op het menu (⋮).", en: "Tap the menu (⋮) at the top right." },
  installAndroid2: { nl: "Kies “App installeren” of “Toevoegen aan startscherm”.", en: "Choose “Install app” or “Add to home screen”." },
  installAndroid3: { nl: "Bevestig, de app staat nu tussen je andere apps.", en: "Confirm, the app now sits with your other apps." },
  installClose: { nl: "Begrepen", en: "Got it" },
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
  if (name === "producten") return <svg width="23" height="23" viewBox="0 0 24 24"><path d="M21 8l-9-5-9 5 9 5 9-5z" {...p} /><path d="M3 8v8l9 5 9-5V8M12 13v8" {...p} /></svg>;
  if (name === "recipes") return <svg width="23" height="23" viewBox="0 0 24 24"><path d="M4 4v6a3 3 0 006 0V4M7 4v16" {...p} /><path d="M17 4c-1.5 0-2.5 2-2.5 5s1 4 2.5 4 2.5-1 2.5-4-1-5-2.5-5zM17 13v7" {...p} /></svg>;
  if (name === "race") return <svg width="23" height="23" viewBox="0 0 24 24"><circle cx="12" cy="13" r="8" {...p} /><path d="M12 13V8.5M12 3.5V2M9.5 2h5" {...p} /></svg>;
  if (name === "dashboard") return <svg width="23" height="23" viewBox="0 0 24 24"><rect x="3" y="3" width="7" height="9" rx="1.5" {...p} /><rect x="14" y="3" width="7" height="5" rx="1.5" {...p} /><rect x="14" y="12" width="7" height="9" rx="1.5" {...p} /><rect x="3" y="16" width="7" height="5" rx="1.5" {...p} /></svg>;
  if (name === "more") return <svg width="23" height="23" viewBox="0 0 24 24"><circle cx="5" cy="12" r="1.6" fill={c} stroke="none" /><circle cx="12" cy="12" r="1.6" fill={c} stroke="none" /><circle cx="19" cy="12" r="1.6" fill={c} stroke="none" /></svg>;
  return null;
};

const LockIcon = ({ c, s = 24 }) => (
  <svg width={s} height={s} viewBox="0 0 24 24" fill="none" stroke={c} strokeWidth="1.9" strokeLinecap="round" strokeLinejoin="round" style={{ display: "block" }}><rect x="5" y="11" width="14" height="9" rx="2" /><path d="M8 11V8a4 4 0 0 1 8 0v3" /></svg>
);

function EditDayCard({ day, di, api }) {
const { T, ML, sIn, R, disp, mutDay, patchMeal, scaleMeal, patchIng, addIngr, removeIngr, removeMeal, addMealTo, saveMealAsRecipe, applyIngVals, saveIngProduct, setCopyPick, setMovePlan, setPickTarget, setShowProducts, setRecipePick, savedMsg, units, pro } = api;
  const [addOpen, setAddOpen] = useState(false);
  const [openMeal, setOpenMeal] = useState(null);
  const [dayMenu, setDayMenu] = useState(false);
  const [valMeal, setValMeal] = useState(null);
  const [ingForm, setIngForm] = useState(null);
  const tot = day.m.reduce((a, m) => ({ kcal: a.kcal + num(m.kcal), p: a.p + num(m.p), c: a.c + num(m.c), f: a.f + num(m.f) }), { kcal: 0, p: 0, c: 0, f: 0 });
  const Dots = () => (<svg width="18" height="18" viewBox="0 0 24 24" fill="currentColor"><circle cx="12" cy="5" r="1.7" /><circle cx="12" cy="12" r="1.7" /><circle cx="12" cy="19" r="1.7" /></svg>);
  const sqBtn = (on) => ({ cursor: "pointer", width: 30, height: 30, borderRadius: 7, border: `1px solid ${on ? EMBER : LINE}`, color: on ? EMBER : MUTED, display: "flex", alignItems: "center", justifyContent: "center", flexShrink: 0 });
  const miniAct = (icon, txt, onClick, danger) => (
    <div onClick={onClick} style={{ cursor: "pointer", display: "flex", alignItems: "center", gap: 9, padding: "9px 12px", borderTop: `1px solid ${LINE}` }}>
      <span style={{ color: danger ? MUTED : EMBER, display: "flex" }}>{icon}</span>
      <span style={{ fontSize: 12.5, color: danger ? MUTED : PAPER, fontWeight: 600 }}>{txt}</span>
    </div>
  );
  const addOpt = (icon, title, sub, onClick) => (
    <div onClick={onClick} style={{ cursor: "pointer", display: "flex", alignItems: "center", gap: 11, padding: "12px 14px", borderTop: `1px solid ${LINE}` }}>
      <span style={{ width: 30, height: 30, borderRadius: 8, background: INK2, border: `1px solid ${LINE}`, color: EMBER, display: "flex", alignItems: "center", justifyContent: "center", flexShrink: 0 }}>{icon}</span>
      <div style={{ minWidth: 0 }}><div style={{ fontSize: 14, fontWeight: 600, color: PAPER }}>{title}</div><div style={{ fontSize: 11, color: MUTED, marginTop: 1 }}>{sub}</div></div>
    </div>
  );
  const icRecipe = <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.9" strokeLinecap="round" strokeLinejoin="round"><path d="M4 5a2 2 0 012-2h13v16H6a2 2 0 00-2 2V5z" /><path d="M9 7h6M9 10h6" /></svg>;
  const icPlus = <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round"><path d="M12 5v14M5 12h14" /></svg>;
  const icBar = <svg width="16" height="16" viewBox="0 0 24 24" fill="currentColor"><rect x="3" y="6" width="1.6" height="12" /><rect x="6" y="6" width="1" height="12" /><rect x="8.4" y="6" width="2" height="12" /><rect x="12" y="6" width="1" height="12" /><rect x="14.6" y="6" width="1.6" height="12" /><rect x="17.6" y="6" width="1" height="12" /><rect x="20" y="6" width="1.4" height="12" /></svg>;
  const icCopy = <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.9" strokeLinecap="round" strokeLinejoin="round"><rect x="9" y="9" width="11" height="11" rx="2" /><path d="M5 15V5a2 2 0 012-2h10" /></svg>;
  const icSave = <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.9" strokeLinecap="round" strokeLinejoin="round"><path d="M19 21l-7-4-7 4V5a2 2 0 012-2h10a2 2 0 012 2z" /></svg>;
  const icTrash = <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.9" strokeLinecap="round" strokeLinejoin="round"><path d="M3 6h18M8 6V4h8v2M6 6l1 14h10l1-14" /></svg>;
  const icDate = <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.9" strokeLinecap="round" strokeLinejoin="round"><rect x="3" y="5" width="18" height="16" rx="2" /><path d="M3 9h18M8 3v4M16 3v4" /></svg>;
  const icEdit = <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.9" strokeLinecap="round" strokeLinejoin="round"><path d="M12 20h9" /><path d="M16.5 3.5a2.1 2.1 0 013 3L7 19l-4 1 1-4z" /></svg>;
  const miniIn = { background: INK, border: `1px solid ${LINE}`, color: PAPER, padding: "7px 6px", borderRadius: 7, fontSize: 12, outline: "none", width: "100%", textAlign: "center" };
  const seedPer100 = (m, ing) => {
    if (ing.per100) return { kcal: ing.per100.kcal || "", p: ing.per100.p || "", c: ing.per100.c || "", f: ing.per100.f || "" };
    const totG = (m.ing || []).reduce((a, x) => a + num(x.g), 0) || 1;
    const per = (v) => R(num(v) * 100 / totG);
    return { kcal: per(m.kcal), p: per(m.p), c: per(m.c), f: per(m.f) };
  };
  const valEditor = (mi, obj, onPatch) => (
    <div style={{ display: "grid", gridTemplateColumns: "1fr 1fr 1fr 1fr", gap: 6, marginBottom: 8 }}>
      {[["kcal", "kcal"], ["p", ML.P], ["c", ML.C], ["f", ML.F]].map(([k, lbl]) => (
        <div key={k}><input value={obj[k]} onChange={(e) => onPatch(k, e.target.value)} inputMode="numeric" placeholder={lbl} style={miniIn} /><div style={{ fontSize: 8.5, color: MUTED, textAlign: "center", marginTop: 2 }}>{lbl}</div></div>
      ))}
    </div>
  );
  return (
    <div style={{ background: INK2, border: `1px solid ${LINE}`, borderRadius: 12, overflow: "hidden" }}>
      <div style={{ display: "flex", justifyContent: "space-between", alignItems: "center", padding: "11px 14px", background: INK, borderBottom: `1px solid ${LINE}` }}>
        <div style={{ display: "flex", alignItems: "center", gap: 9 }}>
          <div style={{ ...disp, fontWeight: 600, fontSize: 15, letterSpacing: 1, textTransform: "uppercase" }}>{day.d}</div>
          <div onClick={() => mutDay(di, (d) => { d.train = !d.train; return d; })} style={{ cursor: "pointer", fontSize: 9.5, color: day.train ? EMBER : MUTED, border: `1px solid ${day.train ? EMBER : LINE}`, borderRadius: 5, padding: "2px 6px", letterSpacing: 1, fontWeight: 700 }}>{day.train ? T("trainTag") : T("restTag")}</div>
        </div>
        <div style={{ display: "flex", alignItems: "center", gap: 10 }}>
          <div style={{ fontSize: 11.5, color: MUTED }}><span style={{ color: PAPER, fontWeight: 600 }}>{tot.kcal}</span> kcal · {tot.p}{ML.p}/{tot.c}{ML.c}/{tot.f}{ML.f}</div>
          <div onClick={() => { setDayMenu(!dayMenu); setOpenMeal(null); setAddOpen(false); }} style={{ ...sqBtn(dayMenu), width: 28, height: 28 }}><Dots /></div>
        </div>
      </div>
      {dayMenu && (
        <div style={{ background: "#121212", borderBottom: `1px solid ${LINE}` }}>
          {miniAct(icCopy, T("copyDay"), () => { setDayMenu(false); setCopyPick({ kind: "day", di }); })}
          {miniAct(icDate, T("toDate"), () => { setDayMenu(false); setMovePlan({ scope: "day", di }); })}
        </div>
      )}
      <div style={{ padding: "4px 0" }}>
        {day.m.map((m, mi) => (
          <div key={mi} style={{ borderBottom: `1px solid ${LINE}` }}>
            <div style={{ padding: "11px 14px" }}>
              {m.src && <div style={{ display: "inline-block", fontSize: 8.5, color: PAPER, background: m.src === "product" ? SAGE : EMBER, borderRadius: 4, padding: "1px 6px", letterSpacing: 0.5, fontWeight: 700, ...disp, marginBottom: 6, textTransform: "uppercase" }}>{m.src === "product" ? "product" : T("fromDb")}</div>}
              <div style={{ display: "flex", gap: 8, alignItems: "center", marginBottom: 8 }}>
                <input value={m.n} onChange={(e) => patchMeal(di, mi, { n: e.target.value })} placeholder={T("mealNamePh")} style={{ ...sIn, flex: 1 }} />
                <div onClick={() => scaleMeal(di, mi, 0.9)} style={{ ...sqBtn(false), color: EMBER, fontSize: 18, fontWeight: 700 }}>−</div>
                <div onClick={() => scaleMeal(di, mi, 1.1)} style={{ ...sqBtn(false), color: EMBER, fontSize: 18, fontWeight: 700 }}>+</div>
                <div onClick={() => setOpenMeal(openMeal === mi ? null : mi)} style={sqBtn(openMeal === mi)}><Dots /></div>
              </div>
              {valMeal === mi && valEditor(mi, m, (k, v) => patchMeal(di, mi, { [k]: num(v) }))}
              {(m.ing || []).map((ing, ii) => {
                const openForm = () => { const s = seedPer100(m, ing); setIngForm({ mi, ii, name: ing.n || "", kcal: s.kcal, p: s.p, c: s.c, f: s.f }); };
                const isOpen = ingForm && ingForm.mi === mi && ingForm.ii === ii;
                return (
                <div key={ii} style={{ marginBottom: 6 }}>
                  <div style={{ display: "flex", gap: 6, alignItems: "center" }}>
                    <input value={ing.n} onChange={(e) => patchIng(di, mi, ii, { n: e.target.value })} placeholder={T("ingrNamePh")} style={{ ...sIn, flex: 1 }} />
                    <input value={gShow(ing.g, units)} onChange={(e) => patchIng(di, mi, ii, { g: gStore(e.target.value, units) })} inputMode="numeric" style={{ ...sIn, width: 54, textAlign: "right" }} />
                    <span style={{ fontSize: 11, color: MUTED }}>{wUnit(units)}</span>
                    {ing.pid && <span style={{ fontSize: 8, color: SAGE, border: `1px solid ${SAGE}`, borderRadius: 4, padding: "1px 4px", letterSpacing: 0.3, fontWeight: 700, ...disp, whiteSpace: "nowrap" }}>{T("linkedTag")}</span>}
                    <div onClick={() => isOpen ? setIngForm(null) : openForm()} title={T("editVals")} style={{ cursor: "pointer", color: isOpen ? EMBER : MUTED, display: "flex", padding: "0 1px" }}><svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.9" strokeLinecap="round" strokeLinejoin="round"><path d="M12 20h9" /><path d="M16.5 3.5a2.1 2.1 0 013 3L7 19l-4 1 1-4z" /></svg></div>
                    <div onClick={() => removeIngr(di, mi, ii)} style={{ cursor: "pointer", color: MUTED, fontSize: 15, padding: "0 2px" }}>×</div>
                  </div>
                  {isOpen && (
                    <div style={{ background: "#121212", border: `1px solid ${LINE}`, borderRadius: 10, padding: 10, marginTop: 6 }}>
                      <div style={{ fontSize: 10.5, color: MUTED, lineHeight: 1.5, marginBottom: 8 }}>{T("ingValsHint")}</div>
                      <input value={ingForm.name} onChange={(e) => setIngForm({ ...ingForm, name: e.target.value })} placeholder={T("ingName")} style={{ ...miniIn, textAlign: "left", marginBottom: 8 }} />
                      {valEditor(mi, ingForm, (k, v) => setIngForm({ ...ingForm, [k]: v }))}
                      <div style={{ display: "flex", gap: 8, flexWrap: "wrap" }}>
                        <div onClick={() => { applyIngVals(di, mi, ii, { kcal: ingForm.kcal, p: ingForm.p, c: ingForm.c, f: ingForm.f }, ingForm.name); setIngForm(null); }} style={{ flex: 1, minWidth: 90, textAlign: "center", cursor: "pointer", background: EMBER, color: PAPER, borderRadius: 8, padding: "9px 0", ...disp, fontWeight: 700, fontSize: 12.5, letterSpacing: 0.3 }}>{T("applyVals")}</div>
                        {pro && !ing.pid && <div onClick={() => { saveIngProduct(di, mi, ii, { kcal: ingForm.kcal, p: ingForm.p, c: ingForm.c, f: ingForm.f }, ingForm.name); setIngForm(null); }} style={{ cursor: "pointer", color: EMBER, border: `1px solid ${EMBER}`, borderRadius: 8, padding: "9px 12px", ...disp, fontWeight: 700, fontSize: 12, letterSpacing: 0.3 }}>{T("toProduct")}</div>}
                        <div onClick={() => setIngForm(null)} style={{ cursor: "pointer", color: MUTED, fontSize: 12, fontWeight: 600, padding: "9px 12px", border: `1px solid ${LINE}`, borderRadius: 8 }}>{T("cancelShort")}</div>
                      </div>
                    </div>
                  )}
                </div>
                );
              })}
              <div style={{ fontSize: 10.5, color: MUTED, marginTop: 6, textAlign: "right" }}>{m.kcal} kcal · {m.p}{ML.p}/{m.c}{ML.c}/{m.f}{ML.f}</div>
            </div>
            {openMeal === mi && (
              <div style={{ background: "#121212", borderTop: `1px solid ${LINE}` }}>
                {miniAct(icPlus, T("addIngr").replace("+ ", ""), () => addIngr(di, mi))}
                {miniAct(icEdit, T("editVals"), () => { setValMeal(valMeal === mi ? null : mi); setOpenMeal(null); })}
                {pro && miniAct(icBar, T("addProd").replace("+ ", ""), () => { setOpenMeal(null); setPickTarget({ di, mi }); setShowProducts(true); })}
                {miniAct(icCopy, T("copyMeal"), () => { setOpenMeal(null); setCopyPick({ kind: "meal", di, mi }); })}
                {miniAct(icSave, savedMsg === di + ":" + mi ? T("savedAsRecipe") : T("saveAsRecipe"), () => saveMealAsRecipe(di, mi))}
                {miniAct(icTrash, T("removeMealTxt"), () => { setOpenMeal(null); removeMeal(di, mi); }, true)}
              </div>
            )}
          </div>
        ))}
        {!addOpen ? (
          <div onClick={() => { setAddOpen(true); setOpenMeal(null); setDayMenu(false); }} style={{ cursor: "pointer", textAlign: "center", padding: "11px 0", color: EMBER, fontSize: 13, fontWeight: 700, ...disp, letterSpacing: 0.5 }}>+ {T("addTitle")}</div>
        ) : (
          <div style={{ background: "#121212" }}>
            {addOpt(icRecipe, T("addFromDb"), T("addFromDbSub"), () => { setAddOpen(false); setRecipePick(di); })}
            {addOpt(icPlus, T("addEmpty"), T("addEmptySub"), () => { setAddOpen(false); addMealTo(di); })}
            {pro && addOpt(icBar, T("addFromProd"), T("addFromProdSub"), () => { setAddOpen(false); setPickTarget({ di, mi: null }); setShowProducts(true); })}
            <div onClick={() => setAddOpen(false)} style={{ cursor: "pointer", textAlign: "center", padding: "10px 0", color: MUTED, fontSize: 12, fontWeight: 600, borderTop: `1px solid ${LINE}` }}>{T("cancel")}</div>
          </div>
        )}
      </div>
    </div>
  );
}

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
  const [snacks, setSnacks] = useState(2);
  const [snackLikes, setSnackLikes] = useState(["fruit"]);
  const [variety, setVariety] = useState("mix");

  const [targets, setTargets] = useState(null);
  const [week, setWeek] = useState(null);
  const [planEdit, setPlanEdit] = useState(false);
  const [showProducts, setShowProducts] = useState(false);
  const [pickTarget, setPickTarget] = useState(null);
  const [copyPick, setCopyPick] = useState(null);
  const [movePlan, setMovePlan] = useState(null); // {scope:"week"|"day", di}
  const [plannedDates, setPlannedDates] = useState(() => load("hf_planned", []));
  const [recipePick, setRecipePick] = useState(null);
  const [savedMsg, setSavedMsg] = useState(null);
  const [fab, setFab] = useState(false);
  const [showBuilder, setShowBuilder] = useState(false);
  const [fabScan, setFabScan] = useState(false);
  const [view, setView] = useState("plan");
  const [checked, setChecked] = useState({});
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState("");
  const [started, setStarted] = useState(false);
  const [subMsg, setSubMsg] = useState("");
  const [unlocked, setUnlocked] = useState(false);
  const [tier, setTier] = useState("week");
  const [email, setEmail] = useState("");
  const [leadStatus, setLeadStatus] = useState("idle");
  const [trackerBusy, setTrackerBusy] = useState(false);
  const [lockReason, setLockReason] = useState("");
  const [planEmail, setPlanEmail] = useState("");

  // App-navigatie + PWA
  const [tab, setTab] = useState("dashboard");
  const [showMore, setShowMore] = useState(false);
  const [showReminders, setShowReminders] = useState(false);
  const [session, setSession] = useState(null);
  const [syncVer, setSyncVer] = useState(0);
  const [showAuth, setShowAuth] = useState(false);
  const [authRecovery, setAuthRecovery] = useState(false);
  const [showLogout, setShowLogout] = useState(false);
  const [units, setUnits] = useState(() => load("hf_units", "metric"));
  const setUnitsSave = (u) => { setUnits(u); try { save("hf_units", u); } catch (e) {} };
  const [saveFlash, setSaveFlash] = useState(false);
  const [showInstallHelp, setShowInstallHelp] = useState(false);
  const [subTier, setSubTier] = useState("free");
  const [installEvt, setInstallEvt] = useState(null);
  const [installDismissed, setInstallDismissed] = useState(() => load("hf_install_dismissed", false));
  const [devMode, setDevMode] = useState(false);
  const [demoMode, setDemoMode] = useState(false);
  const [gymCtx, setGymCtx] = useState(null); // {role:'coach'|'member', org:{...}} als de gebruiker bij een sportschool hoort

  // Dev-modus: alles zichtbaar voor review. Alleen op preview/localhost, NOOIT op de live site.
  // Aanzetten: ?dev=1 in de URL. Uitzetten: ?dev=0.
  useEffect(() => {
    try {
      const h = location.hostname;
      if (!(h === "localhost" || h === "127.0.0.1" || h.endsWith(".vercel.app"))) { setDevMode(false); return; }
      const q = new URLSearchParams(location.search);
      if (q.get("dev") === "1") { try { localStorage.setItem("hf_dev", "1"); } catch (e) {} }
      if (q.get("dev") === "0") { try { localStorage.removeItem("hf_dev"); } catch (e) {} }
      const on = localStorage.getItem("hf_dev") === "1";
      setDevMode(on);
      if (on) {
        let saved = null; try { saved = JSON.parse(localStorage.getItem("hf_lastplan") || "null"); } catch (e) {}
        if (!(saved && saved.week && saved.week.days)) {
          const w = demoWeek(localStorage.getItem("hf_lang") === "nl" ? "nl" : "en");
          setWeek(w); setTargets(DEMO_TARGETS); setStarted(true);
        }
      }
    } catch (e) { setDevMode(false); }
  }, []);

  // Demo-modus: prospects bekijken de ECHTE app met een voorbeeld-atleet, maar
  // persoonlijke/opslaan-acties sturen naar de paywall. Werkt ook op de live app
  // via ?demo=1 (los van dev-modus). Uitzetten: ?demo=0, of zodra je inlogt.
  useEffect(() => {
    try {
      const q = new URLSearchParams(location.search);
      if (q.get("demo") === "0") { try { sessionStorage.removeItem("hf_demo"); } catch (e) {} setDemoMode(false); return; }
      if (q.get("demo") === "1") { try { sessionStorage.setItem("hf_demo", "1"); } catch (e) {} }
      const on = (() => { try { return sessionStorage.getItem("hf_demo") === "1"; } catch (e) { return false; } })();
      if (!on) return;
      setDemoMode(true);
      let saved = null; try { saved = JSON.parse(localStorage.getItem("hf_lastplan") || "null"); } catch (e) {}
      if (!(saved && saved.week && saved.week.days)) {
        const w = demoWeek((localStorage.getItem("hf_lang") === "nl") ? "nl" : "en");
        setWeek(w); setTargets(DEMO_TARGETS); setStarted(true);
      }
      setTab("dashboard");
    } catch (e) {}
  }, []);

  // Sportschool-context: hoort deze ingelogde gebruiker bij een org, en als wat (coach/lid)?
  useEffect(() => {
    let alive = true;
    (async () => {
      if (!supabase || !session || !session.user) { if (alive) setGymCtx(null); return; }
      try {
        const { data: meRows } = await supabase.from("org_members").select("org_id,role").eq("auth_user_id", session.user.id).limit(1);
        const me = meRows && meRows[0];
        if (!me) { if (alive) setGymCtx(null); return; }
        // Tier + lestoegang (guarded).
        let tier = "pro", classAccess = null;
        try {
          const { data: tr } = await supabase.from("org_members").select("member_tier,class_access").eq("auth_user_id", session.user.id).limit(1);
          if (tr && tr[0]) { tier = tr[0].member_tier || "pro"; classAccess = tr[0].class_access || null; }
        } catch (e) {}
        // Rol-rechten apart: lukt de select niet (kolommen bestaan nog niet vóór migratie),
        // dan is de rol ONBEKEND en behandelen we de coach als eigenaar (alle tabs) — nooit leeg.
        let isOwner = true, perms = null;
        try {
          const { data: rr, error: re } = await supabase.from("org_members").select("is_owner,perms").eq("auth_user_id", session.user.id).limit(1);
          if (!re && rr && rr[0]) { isOwner = !!rr[0].is_owner; perms = rr[0].perms || null; }
        } catch (e) {}
        let enabledModules = null;
        try {
          const { data: em } = await supabase.from("org_config").select("enabled_modules").eq("org_id", me.org_id).limit(1);
          if (em && em[0]) enabledModules = em[0].enabled_modules || null;
        } catch (e) {}
        const { data: orgRows } = await supabase.from("orgs").select("id,slug,name").eq("id", me.org_id).limit(1);
        const { data: cfgRows } = await supabase.from("org_config").select("brand_color,logo_url").eq("org_id", me.org_id).limit(1);
        const org = (orgRows && orgRows[0]) || {};
        const cfg = cfgRows && cfgRows[0];
        // Thema apart + guarded ophalen: de theme-kolom bestaat mogelijk nog niet (vóór migratie).
        let theme = null;
        try {
          const { data: tRows } = await supabase.from("org_config").select("theme").eq("org_id", me.org_id).limit(1);
          if (tRows && tRows[0]) theme = tRows[0].theme || null;
        } catch (e) {}
        const brand = (cfg && cfg.brand_color) || "#E11D48";
        if (!theme) theme = { template: "dark", accent: brand }; // fallback: accent op donker
        if (!theme.accent) theme.accent = brand;
        if (alive) setGymCtx({ role: me.role, tier, classAccess, isOwner, perms, org: { ...org, brand_color: brand, logo_url: (cfg && cfg.logo_url) || null, theme, enabled_modules: enabledModules } });
      } catch (e) { if (alive) setGymCtx(null); }
    })();
    return () => { alive = false; };
  }, [session]);

  // White-label thema toepassen: zodra we weten bij welke org de gebruiker hoort, zetten
  // we de org-huisstijl als CSS-variabelen op <html>. Geen org → defaults terug.
  useEffect(() => {
    applyOrgTheme(gymCtx && gymCtx.org ? gymCtx.org.theme : null);
    return () => {}; // reset gebeurt bij de volgende run (of hieronder bij unmount)
  }, [gymCtx]);
  useEffect(() => () => applyOrgTheme(null), []); // opruimen bij unmount

  // Opslag-bevestiging (toast met "Naar dashboard").
  const flashSaved = () => { setSaveFlash(true); setTimeout(() => setSaveFlash(false), 4500); };

  // Demo starten vanuit de app (bv. vanaf het paywall-blok): voorbeeld-atleet laden.
  function enterDemo() {
    try { sessionStorage.setItem("hf_demo", "1"); } catch (e) {}
    setDemoMode(true);
    const w = demoWeek(lang === "nl" ? "nl" : "en");
    setWeek(w); setTargets(DEMO_TARGETS); setStarted(true); setTab("dashboard");
    try { window.scrollTo(0, 0); } catch (e) {}
  }

  // --- Terug-knop (telefoon/PWA): altijd terug naar het dashboard, nooit de app
  // uit. Eerst open overlays sluiten, dan naar dashboard; al op het dashboard →
  // uitlog-bevestiging (ja/nee). We houden altijd één "trap"-state op de stack.
  const navRef = useRef({});
  const persistRef = useRef(() => {});
  const demoRef = useRef(false);
  const SITE_URL = "https://www.hybridfuelco.com/";
  useEffect(() => {
    // Buffer van sentinel-entries: bij een snelle dubbele terug-druk verwerkt de
    // browser meerdere pops vóór onze listener erbij kan → met één entry verliet
    // je de app zonder uitlog-check. Met een buffer die zichzelf aanvult kan dat niet.
    const BUF = 5;
    const cnt = { n: 0 };
    const push = () => { try { history.pushState({ hf: true }, ""); cnt.n++; } catch (e) {} };
    const topUp = () => { let g = 0; while (cnt.n < BUF && g++ < BUF + 3) push(); };
    topUp();
    const onPop = () => {
      cnt.n = Math.max(0, cnt.n - 1); // deze pop heeft er één verbruikt
      const nav = navRef.current || {};
      const s = nav;
      // Eén "terug"-stap afhandelen én de status meteen bijwerken, zodat een
      // volgende (snelle) terug-druk de juiste vervolgstap pakt.
      if (s.showLogout) { setShowLogout(false); nav.showLogout = false; }
      else if (s.fab) { setFab(false); nav.fab = false; }
      else if (s.showMore) { setShowMore(false); nav.showMore = false; }
      else if (s.movePlan) { setMovePlan(null); nav.movePlan = null; }
      else if (s.copyPick) { setCopyPick(null); nav.copyPick = null; }
      else if (s.recipePick != null) { setRecipePick(null); nav.recipePick = null; }
      else if (s.showBuilder) { setShowBuilder(false); nav.showBuilder = false; }
      else if (s.showProducts) { setShowProducts(false); setPickTarget(null); setFabScan(false); nav.showProducts = false; }
      else if (s.showReminders) { setShowReminders(false); nav.showReminders = false; }
      else if (s.showAuth) { setShowAuth(false); setAuthRecovery(false); nav.showAuth = false; }
      else if (s.planEdit) { try { persistRef.current(); } catch (e) {} setPlanEdit(false); flashSaved(); nav.planEdit = false; }
      else if (s.tab !== "dashboard") { setTab("dashboard"); nav.tab = "dashboard"; try { window.scrollTo(0, 0); } catch (e) {} }
      else if (demoRef.current) { try { window.location.href = SITE_URL; } catch (e) {} return; } // demo: terug = naar de website, geen uitlog-vraag
      else { setShowLogout(true); nav.showLogout = true; } // al op het dashboard → uitlog-check
      topUp(); // buffer weer aanvullen
    };
    window.addEventListener("popstate", onPop);
    return () => window.removeEventListener("popstate", onPop);
  }, []);

  function confirmLogout() { setShowLogout(false); try { if (supabase) supabase.auth.signOut(); } catch (e) {} setTab("dashboard"); }

  // Toegang per laag. Alleen een geldige (niet-verlopen) betaling geeft toegang.
  // De oude one-off 'unlocked'-vlag telt niet meer mee (anders bleef stale localStorage openstaan).
  // Gym-leden (ingelogd via code) krijgen automatisch volledige toegang: de sportschool
  // betaalt per seat, dus geen consumenten-paywall voor hen.
  const isGymMember = !!(gymCtx && gymCtx.role === "member");
  // Tier binnen de gym: basis = voeding/tracking + groepsrooster; pro = + persoonlijke PT-laag.
  const gymPro = isGymMember && (gymCtx.tier || "pro") === "pro";
  const hasBasis = devMode || isGymMember || subTier === "basis" || subTier === "pro";
  const hasPro = devMode || gymPro || subTier === "pro";
  const hasPlus = devMode || gymPro || subTier === "pro"; // Race Protocol, later evt. eigen Plus-laag
  // Demo telt alleen voor niet-ingelogde bezoekers; het geeft GEEN echte toegang
  // (opslaan/genereren blijft achter de paywall), het laat alleen de schermen zien.
  const inDemo = demoMode && !session;
  demoRef.current = inDemo; // zodat de terug-knop-logica (popstate) weet of we in demo zijn
  const canView = hasBasis || inDemo;      // basisschermen tonen in demo
  const canViewPlus = hasPlus || inDemo;   // raceprotocol tonen in demo
  const ML = macroLetters(lang);

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

    // 2-klik abonnement: terug van Stripe Checkout. Toon een nette melding.
    try {
      const sub = params && params.get("sub");
      if (sub === "success") setSubMsg("ok");
      else if (sub === "cancel") setSubMsg("cancel");
      else if (sub === "error" || sub === "unavailable") setSubMsg("err");
    } catch (e) {}

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
    try { sub = supabase.auth.onAuthStateChange((e, s) => { setSession(s || null); if (e === "PASSWORD_RECOVERY") { setAuthRecovery(true); setShowAuth(true); } }); } catch (e) {}
    return () => { try { sub.data.subscription.unsubscribe(); } catch (e) {} };
  }, []);

  // Abonnement-laag ophalen zodra er een sessie is.
  useEffect(() => {
    if (!supabase || !session) { setSubTier("free"); return; }
    supabase.from("subscriptions").select("tier,current_period_end").eq("user_id", session.user.id).single()
      .then(({ data }) => {
        // Eenmalige betaling: toegang geldt tot current_period_end. Zonder geldige,
        // niet-verlopen datum = geen toegang.
        const live = data && data.tier && data.tier !== "free" &&
          data.current_period_end && new Date(data.current_period_end).getTime() > Date.now();
        setSubTier(live ? data.tier : "free");
      }).catch(() => {});
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

  // Cloud-sync van kalender-afwijkingen, trainingslogs en weekschema (localStorage
  // → Supabase, volgt je over apparaten). Patcht localStorage en haalt bij login de
  // cloud-waarden op; daarna remounten Today/Training (via syncVer-key) om ze te tonen.
  useEffect(() => {
    initCloudSync(session);
    if (!session) return;
    let active = true;
    pullAll(session).then(() => { if (active) setSyncVer((v) => v + 1); });
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

  const isStandalone = (() => { try { return window.matchMedia("(display-mode: standalone)").matches || window.navigator.standalone === true; } catch (e) { return false; } })();
  const isIOS = (() => { try { return /iphone|ipad|ipod/i.test(navigator.userAgent); } catch (e) { return false; } })();
  async function doInstall() {
    if (installEvt) { try { installEvt.prompt(); await installEvt.userChoice; } catch (e) {} setInstallEvt(null); return; }
    setShowInstallHelp(true); // iOS / geen native prompt → toon stap-voor-stap
  }
  function dismissInstall() { setInstallDismissed(true); save("hf_install_dismissed", true); }

  const toggle = (val, list, setList) => setList(list.includes(val) ? list.filter((x) => x !== val) : [...list, val]);
  function labelsOf(ids, source) { return ids.map((id) => { const o = source.find((x) => x.id === id); return o ? o[lang] : id; }); }

  function common() {
    const dietObj = DIETS.find((d) => d.id === diet);
    return { sex, age, height, weight, activity, goal, diet: dietObj ? dietObj[lang] : diet, avoid, likes, cuisines: labelsOf(cuisines, CUISINES), proteins: labelsOf(proteins, PROTEINS), snacks, snackLikes, snackLikeLabels: labelsOf(snackLikes, SNACKS), variety, lang };
  }
  function currentIntake() { return { ...common(), trainingDays: [...trainingDays] }; }

  async function handleBuild() {
    if (inDemo) { setShowAuth(true); return; } // demo: 'jouw' plan is het betaalde moment
    setError(""); setStarted(true); setView("plan"); setChecked({}); setWeek(null); setLockReason(""); setPlanEmail("");
    const intake = currentIntake();
    try { localStorage.setItem("hf_intake", JSON.stringify(intake)); } catch (e) {}
    if (devMode) { // dev: demo-maaltijden, maar wél geschaald naar je echte berekende targets
      const tg = await computeFree(intake);
      const dw = demoWeek(lang, snacks, snackLikes);
      const days = (tg && tg.train && tg.rest)
        ? dw.days.map((d) => scaleDayTo(d, d.train ? tg.train.kcal : tg.rest.kcal))
        : dw.days;
      setWeek({ days });
      return;
    }
    if (hasBasis) await generatePaid(intake); else await computeFree(intake);
  }

  // Zelf een plan samenstellen: leeg weekschema dat de klant zelf vult via de +.
  async function buildOwnPlan() {
    if (inDemo) { setShowAuth(true); return; } // demo: zelf samenstellen is betaald
    setError(""); setStarted(true); setView("plan"); setChecked({}); setWeek(null); setLockReason(""); setPlanEmail("");
    const intake = currentIntake();
    try { localStorage.setItem("hf_intake", JSON.stringify(intake)); } catch (e) {}
    await computeFree(intake); // altijd de targets berekenen zodat je weet waar je naartoe werkt
    if (hasBasis) { // leeg schema + direct in bewerkmodus; zonder abo zie je de targets + de paywall
      const names = WD[lang];
      const days = names.map((d, i) => ({ d, train: trainingDays.includes(i), m: [] }));
      setWeek({ days });
      setPlanEdit(true);
    }
  }

  async function computeFree(intake) {
    setLoading(true); setTargets(null);
    try {
      const nTrain = (intake.trainingDays || []).length;
      const data = await fetchChunk({ ...intake, trainingCount: nTrain, paid: false });
      setTargets(data.targets);
      return data.targets;
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
      const authToken = (session && session.access_token) || "";
      const data = await fetchChunk({ ...intake, trainingCount: nTrain, request, paid: true, token, authToken });
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

  // Beveiligde download van de betaalde Hyrox-gids: het betaaltoken gaat naar
  // /api/guide, dat bij Stripe herchec't op bundel en een signed URL teruggeeft.
  function downloadGuide() {
    let tok = "";
    try { tok = localStorage.getItem("hf_token") || ""; } catch (e) {}
    if (!tok) { alert(lang === "en" ? "No access token found, re-open the app from your purchase confirmation." : "Geen toegangstoken gevonden, open de app opnieuw via je aankoopbevestiging."); return; }
    const u = "/api/guide?lang=" + encodeURIComponent(lang) + "&token=" + encodeURIComponent(tok);
    window.open(u, "_blank", "noopener");
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
  const flagBtn = (on) => ({ display: "flex", alignItems: "center", cursor: "pointer", padding: "4px 5px", borderRadius: 6, border: `1px solid ${on ? EMBER : LINE}`, background: on ? "rgba(225,29,72,0.14)" : "transparent", opacity: on ? 1 : 0.5, transition: "opacity .15s, border-color .15s" });
  const FlagNL = <svg width="18" height="12" viewBox="0 0 9 6" style={{ borderRadius: 2, display: "block" }}><rect width="9" height="6" fill="#fff" /><rect width="9" height="2" fill="#AE1C28" /><rect y="4" width="9" height="2" fill="#21468B" /></svg>;
  const FlagGB = <svg width="18" height="12" viewBox="0 0 60 30" style={{ borderRadius: 2, display: "block" }}><clipPath id="gbc"><rect width="60" height="30" /></clipPath><g clipPath="url(#gbc)"><rect width="60" height="30" fill="#012169" /><path d="M0,0 60,30 M60,0 0,30" stroke="#fff" strokeWidth="6" /><path d="M0,0 60,30 M60,0 0,30" stroke="#C8102E" strokeWidth="4" /><path d="M30,0 V30 M0,15 H60" stroke="#fff" strokeWidth="10" /><path d="M30,0 V30 M0,15 H60" stroke="#C8102E" strokeWidth="6" /></g></svg>;

  // ====== DAG-EDITOR (Pro) ======
  const R = (x) => Math.round(num(x));
  function applyWeek(nw) { setWeek(nw); try { localStorage.setItem("hf_lastplan", JSON.stringify({ targets, week: nw })); } catch (e) {} }
  function persistPlanCloud() { if (supabase && session && week && week.days) supabase.from("plans").insert({ user_id: session.user.id, targets, week, is_active: true }).then(() => {}, () => {}); }
  function rebalanceDay(di, newMeals, goal) {
    if (!week || !week.days) return;
    const nw = { ...week, days: week.days.map((dd, i) => i === di ? { ...dd, m: newMeals, goal: goal || dd.goal } : dd) };
    applyWeek(nw); persistPlanCloud();
  }
  // Snel een (gescand) product aan het Dagboek van vandaag loggen, via de + knop.
  function addTodayProduct(product) {
    const d = todayISO(), g = 100, p1 = product.per_100 || {};
    const calc = (k) => Math.round(num(p1[k]) * g / 100);
    const row = { item: product.name, grams: g, kcal: calc("kcal"), p: calc("p"), c: calc("c"), f: calc("f") };
    if (supabase && session) {
      supabase.from("food_logs").insert({ user_id: session.user.id, date: d, item: row.item, grams: g, kcal: row.kcal, p: row.p, c: row.c, f: row.f, source: "product" }).then(() => {}, () => {});
    } else {
      const key = "hf_food_" + d, cur = load(key, []); save(key, [...cur, { id: "l" + Date.now(), ...row }]);
    }
  }
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
      // Alleen bijstellen als het ingrediënt al gekoppeld was (per100). De EERSTE
      // keer per100 toekennen (bv. "bewaar in producten") laat het dagtotaal
      // ongemoeid: je legt alleen vast wat er al in de maaltijd zat.
      if (old && old.per100 && next && next.per100) {
        const a = ingMacros(old) || {}, b = ingMacros(next) || {};
        na.kcal = R(num(mm.kcal) + (b.kcal || 0) - (a.kcal || 0)); na.p = R(num(mm.p) + (b.p || 0) - (a.p || 0)); na.c = R(num(mm.c) + (b.c || 0) - (a.c || 0)); na.f = R(num(mm.f) + (b.f || 0) - (a.f || 0));
      }
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
        const ing = { n: product.name, g: 100, per100: product.per_100 || {}, pid: product.id || null };
        const a = ingMacros(ing) || {};
        return { ...mm, ing: [...(mm.ing || []), ing], kcal: R(num(mm.kcal) + (a.kcal || 0)), p: R(num(mm.p) + (a.p || 0)), c: R(num(mm.c) + (a.c || 0)), f: R(num(mm.f) + (a.f || 0)) };
      });
      return d;
    });
  }
  const removeMeal = (di, mi) => mutDay(di, (d) => { d.m = d.m.filter((_, j) => j !== mi); return d; });
  const addMealTo = (di) => mutDay(di, (d) => { d.m = [...d.m, { t: "EXTRA", n: "", kcal: 0, p: 0, c: 0, f: 0, ing: [] }]; return d; });
  // Voeg een product toe als een NIEUWE maaltijd (dag-niveau "Uit producten").
  function addProductAsMeal(di, product) {
    const ing = { n: product.name, g: 100, per100: product.per_100 || {}, pid: product.id || null };
    const a = ingMacros(ing) || {};
    const meal = { t: (lang === "nl" ? "PRODUCT" : "PRODUCT"), n: product.name, kcal: R(a.kcal || 0), p: R(a.p || 0), c: R(a.c || 0), f: R(a.f || 0), ing: [ing], src: "product" };
    mutDay(di, (d) => { d.m = [...d.m, meal]; return d; });
  }
  function toggleEdit() { if (planEdit) { persistPlanCloud(); flashSaved(); } setPlanEdit(!planEdit); }
  // Refs voor de terug-knop up-to-date houden (de popstate-listener leest hieruit).
  navRef.current = { tab, showMore, showReminders, showAuth, showBuilder, showProducts, movePlan, copyPick, recipePick, fab, planEdit, showLogout };
  persistRef.current = persistPlanCloud;
  function copyDayTo(fromDi, toDi) {
    if (!week || fromDi === toDi) return;
    const meals = week.days[fromDi].m.map((mm) => ({ ...mm, ing: (mm.ing || []).map((g) => ({ ...g })) }));
    applyWeek({ ...week, days: week.days.map((d, i) => i === toDi ? { ...d, m: meals } : d) });
  }
  function copyMealTo(fromDi, mi, toDi) {
    if (!week) return;
    const meal = week.days[fromDi].m[mi];
    const copy = { ...meal, ing: (meal.ing || []).map((g) => ({ ...g })) };
    applyWeek({ ...week, days: week.days.map((d, i) => i === toDi ? { ...d, m: [...d.m, copy] } : d) });
  }
  function addRecipeToDay(di, meal) { mutDay(di, (d) => { d.m = [...d.m, meal]; return d; }); }

  // --- Kalender: plan (dag of hele week) op een datum zetten ---------------
  // Schrijft date-overrides (hf_dayover_<ISO>) die het Dagboek al mét voorrang toont.
  function isoAdd(iso, n) { const dt = new Date(iso + "T12:00:00"); dt.setDate(dt.getDate() + n); return dt.toISOString().slice(0, 10); }
  function mondayISO(iso) { const dt = new Date(iso + "T12:00:00"); const wd = (dt.getDay() + 6) % 7; dt.setDate(dt.getDate() - wd); return dt.toISOString().slice(0, 10); }
  function dayToOverride(day) {
    const m = day.m.map((mm) => ({ ...mm, ing: (mm.ing || []).map((g) => ({ ...g })) }));
    const goal = m.reduce((a, x) => ({ kcal: a.kcal + num(x.kcal), p: a.p + num(x.p), c: a.c + num(x.c), f: a.f + num(x.f) }), { kcal: 0, p: 0, c: 0, f: 0 });
    return { d: day.d, train: !!day.train, race: "", m, goal };
  }
  function recordPlanned(isos, remove) {
    setPlannedDates((prev) => {
      let next = prev.filter((x) => !isos.includes(x));
      if (!remove) next = [...next, ...isos];
      next = Array.from(new Set(next)).sort();
      save("hf_planned", next);
      return next;
    });
  }
  function stampDayOnDate(di, iso, move) {
    if (!week || !week.days[di]) return;
    try { save("hf_dayover_" + iso, dayToOverride(week.days[di])); } catch (e) {}
    if (move) { // bron is het weekschema zelf (herhaalt), niets te wissen; alleen doel gezet
    }
    recordPlanned([iso], false);
  }
  function stampWeekFrom(startMonday, move) {
    if (!week) return;
    const isos = [];
    week.days.forEach((day, i) => { const iso = isoAdd(startMonday, i); try { save("hf_dayover_" + iso, dayToOverride(day)); } catch (e) {} isos.push(iso); });
    if (move) { // verplaatsen: wis de overrides van de huidige (bron)week
      const srcMon = mondayISO(todayISO());
      for (let i = 0; i < 7; i++) { const s = isoAdd(srcMon, i); if (!isos.includes(s)) { try { localStorage.removeItem("hf_dayover_" + s); } catch (e) {} } }
      recordPlanned(Array.from({ length: 7 }, (_, i) => isoAdd(srcMon, i)), true);
    }
    recordPlanned(isos, false);
  }
  function clearPlanned(iso) { try { localStorage.removeItem("hf_dayover_" + iso); } catch (e) {} recordPlanned([iso], true); }
  async function saveMealAsRecipe(di, mi) {
    const m = week && week.days[di] && week.days[di].m[mi];
    if (!m) return;
    const ingredients = (m.ing || []).map((g) => { const mm = ingMacros(g) || {}; return { name: g.n, grams: num(g.g), kcal: mm.kcal || 0, p: mm.p || 0, c: mm.c || 0, f: mm.f || 0 }; });
    const rec = { name: m.n || "Recept", type: "dinner", ingredients, macros: { kcal: num(m.kcal), p: num(m.p), c: num(m.c), f: num(m.f) }, image_url: null, steps: genSteps((m.ing || []).map((g) => ({ name: g.n, g: g.g })), lang) || null };
    try {
      if (supabase && session) await supabase.from("recipes").insert({ user_id: session.user.id, ...rec, is_system: false });
      else { const all = load("hf_recipes", []); save("hf_recipes", [...all, { id: "l" + Date.now(), ...rec }]); }
      setSavedMsg(di + ":" + mi); setTimeout(() => setSavedMsg(null), 1800);
    } catch (e) {}
  }
  // Pas de voedingswaarde (per 100 g) van één ingrediënt aan en herbereken de
  // maaltijd. Had het ingrediënt nog geen per-100-waarde, dan nemen we zijn
  // huidige aandeel in de maaltijd (naar rato van gewicht) als startpunt, zodat
  // de wijziging die je typt zichtbaar het dagtotaal beweegt, zonder te crashen.
  function applyIngVals(di, mi, ii, per100, name, pid) {
    mutDay(di, (d) => {
      d.m = d.m.map((mm, j) => {
        if (j !== mi) return mm;
        const ing = mm.ing || [], old = ing[ii];
        if (!old) return mm;
        const np = { kcal: R(num(per100.kcal)), p: R(num(per100.p)), c: R(num(per100.c)), f: R(num(per100.f)) };
        let oldC;
        if (old.per100) oldC = ingMacros(old) || { kcal: 0, p: 0, c: 0, f: 0 };
        else { const totG = (mm.ing || []).reduce((a, x) => a + num(x.g), 0) || 1; const sh = num(old.g) / totG; oldC = { kcal: R(num(mm.kcal) * sh), p: R(num(mm.p) * sh), c: R(num(mm.c) * sh), f: R(num(mm.f) * sh) }; }
        const nextIng = { ...old, per100: np, n: name != null ? name : old.n };
        if (pid !== undefined) nextIng.pid = pid;
        const newC = ingMacros(nextIng) || { kcal: 0, p: 0, c: 0, f: 0 };
        return { ...mm, ing: ing.map((x, k) => k === ii ? nextIng : x), kcal: R(num(mm.kcal) + (newC.kcal || 0) - (oldC.kcal || 0)), p: R(num(mm.p) + (newC.p || 0) - (oldC.p || 0)), c: R(num(mm.c) + (newC.c || 0) - (oldC.c || 0)), f: R(num(mm.f) + (newC.f || 0) - (oldC.f || 0)) };
      });
      return d;
    });
  }
  // Bewaar één ingrediënt als product (op verzoek), pas de waarden toe én koppel (pid).
  async function saveIngProduct(di, mi, ii, per100, name) {
    const nm = (name || "").trim() || "Product";
    const p100 = { kcal: R(num(per100.kcal)), p: R(num(per100.p)), c: R(num(per100.c)), f: R(num(per100.f)) };
    let newId = "l" + Date.now();
    try {
      if (supabase && session) {
        const { data } = await supabase.from("products").insert({ user_id: session.user.id, name: nm, brand: null, barcode: null, per_100: p100, category: null, unit: "g" }).select("id").single();
        if (data && data.id) newId = data.id;
      } else {
        const all = load("hf_products", []);
        save("hf_products", [...all, { id: newId, name: nm, brand: null, barcode: null, per_100: p100, category: null }]);
      }
    } catch (e) {}
    applyIngVals(di, mi, ii, p100, nm, newId);
  }
  // Een product is aangepast → werk alle gekoppelde ingrediënten in het
  // weekschema én in de datum-afwijkingen bij (waarden gaan automatisch mee).
  function propagateProduct(product) {
    if (!product || product.id == null) return;
    const pid = product.id, np = product.per_100 || {}, nm = product.name;
    const fixMeals = (meals) => meals.map((mm) => {
      if (!(mm.ing || []).some((g) => g.pid === pid)) return mm;
      const ing = (mm.ing || []).map((g) => (g.pid === pid ? { ...g, n: nm != null ? nm : g.n, per100: np } : g));
      let dk = 0, dp = 0, dc = 0, df = 0;
      (mm.ing || []).forEach((g, k) => { if (g.pid !== pid) return; const a = ingMacros(g) || {}, b = ingMacros(ing[k]) || {}; dk += (b.kcal || 0) - (a.kcal || 0); dp += (b.p || 0) - (a.p || 0); dc += (b.c || 0) - (a.c || 0); df += (b.f || 0) - (a.f || 0); });
      return { ...mm, ing, kcal: R(num(mm.kcal) + dk), p: R(num(mm.p) + dp), c: R(num(mm.c) + dc), f: R(num(mm.f) + df) };
    });
    if (week) applyWeek({ ...week, days: week.days.map((d) => ({ ...d, m: fixMeals(d.m.map((mm) => ({ ...mm, ing: (mm.ing || []).map((g) => ({ ...g })) }))) })) });
    try {
      for (let i = 0; i < localStorage.length; i++) {
        const key = localStorage.key(i);
        if (!key || key.indexOf("hf_dayover_") !== 0) continue;
        const ov = load(key, null); if (!ov || !ov.m) continue;
        save(key, { ...ov, m: fixMeals(ov.m.map((mm) => ({ ...mm, ing: (mm.ing || []).map((g) => ({ ...g })) }))) });
      }
    } catch (e) {}
  }
  function RecipePicker({ di, onClose }) {
    const [mine, setMine] = useState(() => (supabase && session ? [] : load("hf_recipes", [])));
    const [q, setQ] = useState("");
    const [open, setOpen] = useState("breakfast");
    useEffect(() => {
      let a = true;
      if (supabase && session) supabase.from("recipes").select("id,name,type,ingredients,macros,image_url").eq("user_id", session.user.id).order("created_at", { ascending: false }).then(({ data }) => { if (a && data) setMine(data); });
      return () => { a = false; };
    }, []);
    const RT = { breakfast: { nl: "Ontbijt", en: "Breakfast" }, lunch: { nl: "Lunch", en: "Lunch" }, dinner: { nl: "Diner", en: "Dinner" }, snack: { nl: "Tussendoortje", en: "Snack" } };
    const toMealUser = (r) => ({ t: (RT[r.type] ? RT[r.type][lang] : "Maaltijd").toUpperCase(), n: r.name, kcal: num(r.macros && r.macros.kcal), p: num(r.macros && r.macros.p), c: num(r.macros && r.macros.c), f: num(r.macros && r.macros.f), ing: (r.ingredients || []).map((x) => ({ n: x.name, g: num(x.grams) })), src: "db" });
    const toMealSys = (r) => ({ t: (RT[r.type] ? RT[r.type][lang] : "Maaltijd").toUpperCase(), n: r.name[lang], kcal: num(r.macros.kcal), p: num(r.macros.p), c: num(r.macros.c), f: num(r.macros.f), ing: (r.ing || []).map((x) => ({ n: x[lang], g: num(x.g) })), src: "db" });
    const pick = (meal) => { addRecipeToDay(di, meal); onClose(); };
    const ql = q.trim().toLowerCase();
    const cats = ["breakfast", "lunch", "dinner", "snack"];
    const Thumb = ({ src, letter }) => (
      <div style={{ position: "relative", width: 42, height: 42, borderRadius: 8, overflow: "hidden", flexShrink: 0, background: `linear-gradient(135deg, ${INK2}, ${INK})` }}>
        <div style={{ position: "absolute", inset: 0, display: "flex", alignItems: "center", justifyContent: "center", color: LINE, ...disp, fontSize: 18 }}>{(letter || "?").slice(0, 1).toUpperCase()}</div>
        {src && <img src={src} onError={(e) => { e.currentTarget.style.display = "none"; }} style={{ position: "absolute", inset: 0, width: "100%", height: "100%", objectFit: "cover" }} />}
      </div>
    );
    const RecRow = ({ src, title, sub, onClk }) => (
      <div onClick={onClk} style={{ cursor: "pointer", display: "flex", alignItems: "center", gap: 11, padding: "9px 12px", borderTop: `1px solid ${LINE}` }}>
        <Thumb src={src} letter={title} />
        <div style={{ minWidth: 0, flex: 1 }}><div style={{ fontSize: 13.5, fontWeight: 600, color: PAPER, whiteSpace: "nowrap", overflow: "hidden", textOverflow: "ellipsis" }}>{title}</div><div style={{ fontSize: 10.5, color: MUTED, marginTop: 1 }}>{sub}</div></div>
        <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke={EMBER} strokeWidth="2.2" strokeLinecap="round"><path d="M12 5v14M5 12h14" /></svg>
      </div>
    );
    const mineF = mine.filter((r) => !ql || (r.name || "").toLowerCase().includes(ql));
    return (
      <div onClick={onClose} style={{ position: "fixed", inset: 0, background: "rgba(0,0,0,0.72)", backdropFilter: "blur(6px)", WebkitBackdropFilter: "blur(6px)", zIndex: 70, display: "flex", alignItems: "center", justifyContent: "center", padding: 16 }}>
        <div onClick={(e) => e.stopPropagation()} className="hf-modal" style={{ background: INK, border: `1px solid ${LINE}`, borderRadius: 18, width: "100%", maxWidth: 400, maxHeight: "88vh", overflowY: "auto", padding: 20, backgroundImage: "radial-gradient(130% 70% at 92% -10%, rgba(225,29,72,0.12), transparent 58%)" }}>
          <div style={{ display: "flex", justifyContent: "space-between", alignItems: "center", marginBottom: 12 }}>
            <div style={{ ...disp, fontWeight: 700, fontSize: 16 }}>{T("pickRecipe")}</div>
            <div onClick={onClose} style={{ cursor: "pointer", color: MUTED, fontSize: 17, width: 30, height: 30, display: "flex", alignItems: "center", justifyContent: "center", borderRadius: 9, border: `1px solid ${LINE}` }}>×</div>
          </div>
          <input value={q} onChange={(e) => setQ(e.target.value)} placeholder={T("searchRecipePh")} style={{ ...sIn, width: "100%", padding: "10px 12px", fontSize: 13.5, marginBottom: 12 }} />
          <div style={{ border: `1px solid ${LINE}`, borderRadius: 12, overflow: "hidden" }}>
            {mineF.length > 0 && (
              <div style={{ borderBottom: `1px solid ${LINE}` }}>
                <div onClick={() => setOpen(open === "mine" ? "" : "mine")} style={{ display: "flex", justifyContent: "space-between", alignItems: "center", padding: "12px 14px", cursor: "pointer" }}>
                  <span style={{ ...disp, fontWeight: 700, fontSize: 12, letterSpacing: 1, textTransform: "uppercase", color: open === "mine" || ql ? EMBER : PAPER }}>{T("mineRecipes")}</span>
                  <span style={{ display: "flex", gap: 10, alignItems: "center" }}><span style={{ fontSize: 11, color: MUTED }}>{mineF.length}</span><span style={{ fontSize: 11, color: EMBER, transform: open === "mine" || ql ? "rotate(90deg)" : "none" }}>›</span></span>
                </div>
                {(open === "mine" || ql) && mineF.map((r) => <RecRow key={"u" + r.id} src={r.image_url || null} title={r.name} sub={(num(r.macros && r.macros.kcal)) + " kcal"} onClk={() => pick(toMealUser(r))} />)}
              </div>
            )}
            {!ql && <div style={{ padding: "9px 14px", borderBottom: `1px solid ${LINE}`, background: INK2, fontSize: 9.5, letterSpacing: 1, textTransform: "uppercase", color: MUTED, fontWeight: 700 }}>{T("libHeader")}</div>}
            {cats.map((c) => {
              const items = RECIPES.filter((r) => r.type === c && (!ql || r.name[lang].toLowerCase().includes(ql)));
              if (ql && items.length === 0) return null;
              const isOpen = ql ? true : open === c;
              return (
                <div key={c} style={{ borderBottom: `1px solid ${LINE}` }}>
                  <div onClick={() => !ql && setOpen(isOpen ? "" : c)} style={{ display: "flex", justifyContent: "space-between", alignItems: "center", padding: "12px 14px", cursor: "pointer" }}>
                    <span style={{ ...disp, fontWeight: 700, fontSize: 12, letterSpacing: 1, textTransform: "uppercase", color: isOpen ? EMBER : PAPER, opacity: isOpen ? 1 : 0.85 }}>{RT[c][lang]}</span>
                    <span style={{ display: "flex", gap: 10, alignItems: "center" }}><span style={{ fontSize: 11, color: MUTED }}>{items.length}</span><span style={{ fontSize: 11, color: isOpen ? EMBER : MUTED, transform: isOpen ? "rotate(90deg)" : "none" }}>›</span></span>
                  </div>
                  {isOpen && items.map((r) => <RecRow key={"s" + r.id} src={r.image_url || ("/recipes/" + r.id + ".jpg")} title={r.name[lang]} sub={r.macros.kcal + " kcal"} onClk={() => pick(toMealSys(r))} />)}
                </div>
              );
            })}
          </div>
        </div>
      </div>
    );
  }

  const sIn = { background: INK, border: `1px solid ${LINE}`, color: PAPER, padding: "6px 8px", fontFamily: "Inter, sans-serif", fontSize: 12.5, borderRadius: 7, outline: "none", boxSizing: "border-box" };

  function MovePlan({ scope, di, onClose }) {
    const [act, setAct] = useState("copy");
    const [tgt, setTgt] = useState(scope === "week" ? "next" : "date");
    const [date, setDate] = useState(scope === "week" ? isoAdd(mondayISO(todayISO()), 7) : isoAdd(todayISO(), 1));
    const [done, setDone] = useState(false);
    const scopeLbl = scope === "week" ? T("moveWeekScope") : (week && week.days[di] ? week.days[di].d : T("moveDayScope"));
    const dIn = { ...sIn, padding: "9px 10px", fontSize: 13, width: "100%", colorScheme: "dark" };
    const seg = (on) => ({ flex: 1, textAlign: "center", cursor: "pointer", padding: "9px 0", borderRadius: 8, border: `1px solid ${on ? EMBER : LINE}`, background: on ? EMBER : "transparent", color: on ? PAPER : MUTED, fontSize: 13, fontWeight: 700, ...disp, letterSpacing: 0.5 });
    const radio = (on) => ({ display: "flex", alignItems: "center", gap: 9, cursor: "pointer", padding: "10px 12px", borderRadius: 10, border: `1px solid ${on ? EMBER : LINE}`, background: on ? "rgba(225,29,72,0.08)" : INK2 });
    const dot = (on) => ({ width: 16, height: 16, borderRadius: "50%", border: `2px solid ${on ? EMBER : MUTED}`, background: on ? EMBER : "transparent", flexShrink: 0 });
    function place() {
      if (scope === "week") { const startMon = tgt === "next" ? isoAdd(mondayISO(todayISO()), 7) : mondayISO(date); stampWeekFrom(startMon, act === "move"); }
      else { stampDayOnDate(di, date, act === "move"); }
      setDone(true); setTimeout(() => onClose(), 950);
    }
    return (
      <div onClick={onClose} style={{ position: "fixed", inset: 0, background: "rgba(0,0,0,0.72)", backdropFilter: "blur(6px)", WebkitBackdropFilter: "blur(6px)", zIndex: 72, display: "flex", alignItems: "center", justifyContent: "center", padding: 16 }}>
        <div onClick={(e) => e.stopPropagation()} className="hf-modal" style={{ background: INK, border: `1px solid ${LINE}`, borderRadius: 18, width: "100%", maxWidth: 400, maxHeight: "88vh", overflowY: "auto", padding: 20, backgroundImage: "radial-gradient(130% 70% at 92% -10%, rgba(225,29,72,0.12), transparent 58%)" }}>
          <div style={{ display: "flex", justifyContent: "space-between", alignItems: "center", marginBottom: 6 }}>
            <div style={{ ...disp, fontWeight: 700, fontSize: 16 }}>{T("moveTitle")}</div>
            <div onClick={onClose} style={{ cursor: "pointer", color: MUTED, fontSize: 17, width: 30, height: 30, display: "flex", alignItems: "center", justifyContent: "center", borderRadius: 9, border: `1px solid ${LINE}` }}>×</div>
          </div>
          <div style={{ fontSize: 11.5, color: MUTED, marginBottom: 14 }}>{scope === "week" ? T("moveWeekScope") : T("moveDayScope")}: <span style={{ color: PAPER, fontWeight: 600 }}>{scopeLbl}</span></div>

          <div style={{ display: "flex", gap: 8, marginBottom: 14 }}>
            <div onClick={() => setAct("copy")} style={seg(act === "copy")}>{T("actCopy")}</div>
            <div onClick={() => setAct("move")} style={seg(act === "move")}>{T("actMove")}</div>
          </div>

          {scope === "week" ? (
            <div style={{ display: "grid", gap: 8, marginBottom: 14 }}>
              <div onClick={() => setTgt("next")} style={radio(tgt === "next")}><div style={dot(tgt === "next")} /><div style={{ fontSize: 13.5, color: PAPER, fontWeight: 600 }}>{T("tgtNextWeek")}</div></div>
              <div onClick={() => setTgt("pick")} style={radio(tgt === "pick")}><div style={dot(tgt === "pick")} /><div style={{ fontSize: 13.5, color: PAPER, fontWeight: 600 }}>{T("tgtPickWeek")}</div></div>
              {tgt === "pick" && (<div><div style={{ fontSize: 11, color: MUTED, marginBottom: 6 }}>{T("moveWeekTo")}</div><input type="date" value={date} onChange={(e) => setDate(e.target.value)} style={dIn} /></div>)}
            </div>
          ) : (
            <div style={{ marginBottom: 14 }}>
              <div style={{ fontSize: 11, color: MUTED, marginBottom: 6 }}>{T("tgtPickDate")}</div>
              <input type="date" value={date} onChange={(e) => setDate(e.target.value)} style={dIn} />
            </div>
          )}

          <div onClick={done ? undefined : place} style={{ cursor: done ? "default" : "pointer", textAlign: "center", background: done ? SAGE : EMBER, color: PAPER, padding: "12px 0", borderRadius: 10, ...disp, fontWeight: 700, fontSize: 15, letterSpacing: 0.5 }}>{done ? T("movePlaced") : T("moveDo")}</div>
          <div style={{ fontSize: 11, color: MUTED, marginTop: 10, lineHeight: 1.5 }}>{T("moveHint")}</div>

          {plannedDates.length > 0 && (
            <div style={{ marginTop: 16, borderTop: `1px solid ${LINE}`, paddingTop: 14 }}>
              <div style={{ ...label, marginBottom: 8 }}>{T("movePlannedLbl")}</div>
              <div style={{ display: "grid", gap: 6 }}>
                {plannedDates.map((iso) => (
                  <div key={iso} style={{ display: "flex", justifyContent: "space-between", alignItems: "center", background: INK2, border: `1px solid ${LINE}`, borderRadius: 9, padding: "8px 12px" }}>
                    <div style={{ fontSize: 12.5, color: PAPER }}>{new Date(iso + "T12:00:00").toLocaleDateString(lang === "nl" ? "nl-NL" : "en-GB", { weekday: "short", day: "numeric", month: "short" })}</div>
                    <div onClick={() => clearPlanned(iso)} style={{ cursor: "pointer", fontSize: 11.5, color: MUTED, fontWeight: 600 }}>{T("moveClear")}</div>
                  </div>
                ))}
              </div>
            </div>
          )}
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
          <div style={{ fontSize: 11.5, color: MUTED }}><span style={{ color: PAPER, fontWeight: 600 }}>{tot.kcal}</span> kcal · {tot.p}{ML.p}/{tot.c}{ML.c}/{tot.f}{ML.f}</div>
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
                      {m.ing.map((ing, ii) => <span key={ii}><span style={{ color: PAPER }}>{gShow(ing.g, units)}{wUnit(units)}</span> {ing.n}{ii < m.ing.length - 1 ? " · " : ""}</span>)}
                    </div>
                  )}
                </div>
                <div style={{ fontSize: 11, color: MUTED, textAlign: "right", whiteSpace: "nowrap" }}><span style={{ color: PAPER, fontWeight: 600 }}>{m.kcal}</span> kcal<br />{m.p}{ML.p}/{m.c}{ML.c}/{m.f}{ML.f}</div>
              </div>
            </div>
          ))}
        </div>
      </div>
    );
  }

  function Locked({ pro }) {
    return (
      <div style={{ display: "grid", gap: 16 }}>
        <div style={{ border: `1px solid ${EMBER}`, borderRadius: 14, padding: 24, background: "linear-gradient(180deg, rgba(225,29,72,0.09), transparent 60%)", textAlign: "center" }}>
          <div style={{ marginBottom: 12, display: "flex", justifyContent: "center" }}><LockIcon c={EMBER} s={34} /></div>
          <div style={{ ...disp, fontSize: 19, fontWeight: 700, marginBottom: 6 }}>{pro ? T("lockedPro") : T("lockedTitle")}</div>
          <div style={{ fontSize: 12.5, color: MUTED, lineHeight: 1.5, marginBottom: 18, maxWidth: 300, margin: "0 auto 18px" }}>{pro ? T("lockedProSub") : T("lockedSub")}</div>
          <button onClick={() => setShowAuth(true)} style={{ background: EMBER, color: PAPER, border: "none", padding: "13px 26px", borderRadius: 10, ...disp, fontWeight: 700, fontSize: 14.5, letterSpacing: 0.8, textTransform: "uppercase", cursor: "pointer" }}>{T("unlockBtn")}</button>
        </div>
      </div>
    );
  }

  const lowBmi = !!(targets && targets.lowBmi);
  const floored = !!(targets && targets.floored);
  const safeText = lowBmi ? T("lowBmiWarn") : floored ? T("flooredWarn") : goal === "cut" ? T("safeCut") : goal === "gain" ? T("safeGain") : T("safeMaintain");
  const hasCycle = targets && targets.trainingCount > 0 && targets.trainingCount < 7 && targets.train && targets.rest;

  const OVERFLOW = ["today", "tracker", "water", "producten", "race", "training"]; // zitten onder "Meer"
  const go = (x) => { setShowMore(false); setTab(x); try { window.scrollTo(0, 0); } catch (e) {} };
  const fabAct = (label, icon, onClick) => (
    <div onClick={onClick} style={{ display: "flex", alignItems: "center", gap: 10, cursor: "pointer" }}>
      <span style={{ background: INK2, border: `1px solid ${LINE}`, color: PAPER, fontSize: 12.5, fontWeight: 600, padding: "7px 12px", borderRadius: 9, whiteSpace: "nowrap", boxShadow: "0 4px 14px rgba(0,0,0,.45)" }}>{label}</span>
      <div style={{ width: 46, height: 46, borderRadius: "50%", background: INK2, border: `1px solid ${EMBER}`, display: "flex", alignItems: "center", justifyContent: "center", boxShadow: "0 4px 14px rgba(0,0,0,.45)", flexShrink: 0 }}>{icon}</div>
    </div>
  );
  const navCell = (id, key, onClick, active) => (
    <div key={id} onClick={onClick} style={{ flex: 1, display: "flex", flexDirection: "column", alignItems: "center", gap: 3, padding: "8px 0 7px", cursor: "pointer" }}>
      <Icon name={id} on={active} />
      <div style={{ fontSize: 10, fontWeight: 600, color: active ? EMBER : MUTED, letterSpacing: 0.2 }}>{T(key)}</div>
    </div>
  );
  const moreTile = (icon, label, onClick) => (
    <div onClick={onClick} style={{ cursor: "pointer", display: "flex", alignItems: "center", gap: 11, background: INK2, border: `1px solid ${LINE}`, borderRadius: 12, padding: "13px 13px" }}>
      <div style={{ width: 34, height: 34, borderRadius: 9, background: "rgba(225,29,72,0.12)", display: "flex", alignItems: "center", justifyContent: "center", flexShrink: 0 }}>{icon}</div>
      <div style={{ fontSize: 13, fontWeight: 600, color: PAPER }}>{label}</div>
    </div>
  );
  const mIcon = (name) => <Icon name={name} on={true} />;

  // Sportschool-routes: join-scherm (code-login) en coach-dashboard gaan vóór de gewone app.
  const joinSlug = (() => { try { const m = location.pathname.match(/^\/join\/([a-z0-9-]+)/i); return m ? m[1].toLowerCase() : null; } catch (e) { return null; } })();
  if (joinSlug && !session) return <Join slug={joinSlug} lang={lang} />;
  if (session && gymCtx && gymCtx.role === "coach") return <CoachDash session={session} org={gymCtx.org} isOwner={gymCtx.isOwner} perms={gymCtx.perms} lang={lang} onLogout={confirmLogout} />;

  return (
    <div style={{ minHeight: "100vh", background: isGymMember ? INK : "linear-gradient(180deg, #1b0a11 0%, #140a0e 48%, #0e090b 100%)", position: "relative", color: PAPER, fontFamily: "Inter, sans-serif", paddingBottom: `calc(${76 + consentH}px + env(safe-area-inset-bottom))` }}>
      <style dangerouslySetInnerHTML={{ __html: fonts + `*{box-sizing:border-box;scrollbar-width:none;-ms-overflow-style:none} *::-webkit-scrollbar{display:none;width:0;height:0} html,body{overflow-x:hidden;background:var(--hf-ink)} select option{background:${INK2};color:${PAPER}} @keyframes pulse{0%,100%{opacity:.4}50%{opacity:1}} .dot{animation:pulse 1s infinite} input[type=date],input[type=time]{color-scheme:${isGymMember ? "light dark" : "dark"}} .hf-glow{position:fixed;inset:0;pointer-events:none;z-index:-1;background:radial-gradient(125% 75% at 50% -2%,rgba(225,29,72,0.20),transparent 58%),radial-gradient(95% 55% at 100% 106%,rgba(225,29,72,0.10),transparent 62%);animation:drift 20s ease-in-out infinite alternate} @keyframes drift{from{transform:translate(0,0)}to{transform:translate(-30px,24px)}} .hf-modal{scrollbar-width:none;-ms-overflow-style:none} .hf-modal::-webkit-scrollbar{display:none;width:0;height:0}` }} />
      {!isGymMember && <div className="hf-glow" aria-hidden="true" />}
      {subMsg && (
        <div onClick={() => setSubMsg("")} style={{ position: "fixed", top: 0, left: 0, right: 0, zIndex: 120, background: subMsg === "ok" ? EMBER : INK2, color: PAPER, padding: "12px 16px", paddingTop: "calc(12px + env(safe-area-inset-top))", textAlign: "center", fontSize: 13.5, lineHeight: 1.5, cursor: "pointer", boxShadow: "0 4px 18px rgba(0,0,0,.4)" }}>
          {subMsg === "ok" ? T("subOk") : subMsg === "cancel" ? T("subCancel") : T("subErr")}
          <span style={{ opacity: 0.7, marginLeft: 8, fontWeight: 700 }}>✕</span>
        </div>
      )}

      {/* HEADER */}
      <div style={{ borderBottom: `1px solid ${LINE}`, padding: "12px 14px", display: "flex", alignItems: "center", gap: 8, position: "sticky", top: 0, background: isGymMember ? INK2 : `radial-gradient(130% 320% at 94% 0%, rgba(225,29,72,0.18), #19090f 58%), #150a0e`, zIndex: 20 }}>
        {isGymMember && gymCtx.org.logo_url ? (
          <img src={gymCtx.org.logo_url} alt={gymCtx.org.name || ""} style={{ height: 30, maxWidth: 140, objectFit: "contain", flexShrink: 0 }} />
        ) : isGymMember ? (
          <div style={{ width: 30, height: 30, borderRadius: 8, background: gymCtx.org.brand_color || EMBER, display: "flex", alignItems: "center", justifyContent: "center", ...disp, fontWeight: 700, color: "#fff", fontSize: 18, flexShrink: 0 }}>{(gymCtx.org.name || "?").trim().charAt(0).toUpperCase()}</div>
        ) : (
          <div onClick={() => { if (inDemo) { try { window.location.href = SITE_URL; } catch (e) {} } }} title={inDemo ? (lang === "nl" ? "Terug naar website" : "Back to website") : undefined} style={{ width: 30, height: 30, borderRadius: 8, background: EMBER, display: "flex", alignItems: "center", justifyContent: "center", ...disp, fontWeight: 700, color: INK, fontSize: 18, flexShrink: 0, cursor: inDemo ? "pointer" : "default" }}>H</div>
        )}
        <div style={{ flex: 1, minWidth: 0 }}>
          <div style={{ ...disp, fontWeight: 700, fontSize: 17.5, letterSpacing: 0.4, lineHeight: 1.05, whiteSpace: "nowrap", overflow: "hidden", textOverflow: "ellipsis" }}>
            {isGymMember
              ? <span style={{ color: gymCtx.org.brand_color || EMBER }}>{gymCtx.org.name || ""}</span>
              : <span>HYBRIDFUEL<span style={{ color: EMBER }}>CO</span></span>}
          </div>
          <div style={{ display: "flex", alignItems: "center", gap: 6, marginTop: 3, minWidth: 0 }}>
            {devMode && <span style={{ flexShrink: 0, fontSize: 8, fontWeight: 700, letterSpacing: 1, color: INK, background: EMBER, borderRadius: 4, padding: "1px 4px", ...disp }}>DEV</span>}
            <span style={{ fontSize: 9.5, color: MUTED, letterSpacing: 1, textTransform: "uppercase", whiteSpace: "nowrap", overflow: "hidden", textOverflow: "ellipsis" }}>{isGymMember ? "Powered by HybridFuel" : T("tagline")}</span>
          </div>
        </div>
        <div onClick={() => setShowReminders(true)} title="Reminders" style={{ cursor: "pointer", width: 32, height: 32, borderRadius: "50%", border: `1px solid ${LINE}`, background: "transparent", display: "flex", alignItems: "center", justifyContent: "center", flexShrink: 0 }}>
          <svg width="17" height="17" viewBox="0 0 24 24" fill="none" stroke={MUTED} strokeWidth="1.9" strokeLinecap="round" strokeLinejoin="round"><path d="M18 8a6 6 0 10-12 0c0 7-3 9-3 9h18s-3-2-3-9M13.7 21a2 2 0 01-3.4 0" /></svg>
        </div>
        <div onClick={() => setShowAuth(true)} title={session ? "Account" : (lang === "nl" ? "Inloggen" : "Log in")} style={{ cursor: "pointer", width: 32, height: 32, borderRadius: "50%", border: `1px solid ${session ? LINE : EMBER}`, background: session ? "transparent" : "rgba(225,29,72,0.14)", display: "flex", alignItems: "center", justifyContent: "center", flexShrink: 0 }}>
          <svg width="17" height="17" viewBox="0 0 24 24" fill="none" stroke={session ? PAPER : EMBER} strokeWidth="1.9" strokeLinecap="round" strokeLinejoin="round"><circle cx="12" cy="8" r="4" /><path d="M4 21c0-4 4-6.5 8-6.5s8 2.5 8 6.5" /></svg>
        </div>
        <div style={{ display: "flex", gap: 4, flexShrink: 0 }}>
          <div onClick={() => setLang("nl")} style={flagBtn(lang === "nl")} title="Nederlands">{FlagNL}</div>
          <div onClick={() => setLang("en")} style={flagBtn(lang === "en")} title="English">{FlagGB}</div>
        </div>
      </div>

      {/* DEMO-BALK: zichtbaar in demo-modus; stuurt naar het ontgrendel-scherm */}
      {inDemo && (
        <div style={{ background: EMBER, color: PAPER, padding: "9px 14px", display: "flex", alignItems: "center", gap: 10, position: "relative", zIndex: 1, flexWrap: "wrap" }}>
          <span style={{ fontSize: 11, fontWeight: 700, ...disp, letterSpacing: 1, background: "rgba(255,255,255,0.18)", borderRadius: 4, padding: "2px 7px" }}>{lang === "nl" ? "VOORBEELD" : "PREVIEW"}</span>
          <span style={{ flex: 1, minWidth: 110, fontSize: 12.5, lineHeight: 1.4 }}>{lang === "nl" ? "Je bekijkt een voorbeeld. Ontgrendel de app voor je eigen plan." : "You're viewing a sample. Unlock the app for your own plan."}</span>
          <a href={SITE_URL} style={{ color: PAPER, fontSize: 12.5, fontWeight: 700, ...disp, letterSpacing: 0.3, textDecoration: "none", whiteSpace: "nowrap", opacity: 0.92 }}>{lang === "nl" ? "← Website" : "← Website"}</a>
          <div onClick={() => setShowAuth(true)} style={{ cursor: "pointer", background: PAPER, color: EMBER, padding: "7px 15px", borderRadius: 8, fontSize: 12.5, fontWeight: 700, ...disp, letterSpacing: 0.3, whiteSpace: "nowrap" }}>{lang === "nl" ? "Ontgrendel" : "Unlock"}</div>
        </div>
      )}

      {/* INSTALL-BANNER, voor iedereen die de app nog niet geïnstalleerd heeft (ook iPhone) */}
      {!isStandalone && !installDismissed && !inDemo && (
        <div style={{ background: "rgba(225,29,72,0.1)", borderBottom: `1px solid ${LINE}`, padding: "10px 16px", display: "flex", alignItems: "center", gap: 12, position: "relative", zIndex: 1 }}>
          <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke={EMBER} strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" style={{ flexShrink: 0 }}><path d="M12 3v12M8 11l4 4 4-4" /><path d="M4 17v2a2 2 0 002 2h12a2 2 0 002-2v-2" /></svg>
          <div style={{ flex: 1, minWidth: 0 }}>
            <div style={{ fontSize: 13, fontWeight: 600 }}>{T("install")}</div>
            <div style={{ fontSize: 11, color: MUTED, marginTop: 1 }}>{T("installHint")}</div>
          </div>
          <button onClick={doInstall} style={{ background: EMBER, color: PAPER, border: "none", padding: "8px 14px", borderRadius: 8, ...disp, fontWeight: 700, fontSize: 12.5, letterSpacing: 0.5, cursor: "pointer", whiteSpace: "nowrap" }}>{T("installBtn")}</button>
          <div onClick={dismissInstall} style={{ cursor: "pointer", color: MUTED, fontSize: 20, lineHeight: 1, padding: "0 2px" }}>×</div>
        </div>
      )}
      {showInstallHelp && (
        <div onClick={() => setShowInstallHelp(false)} style={{ position: "fixed", inset: 0, background: "rgba(0,0,0,0.72)", backdropFilter: "blur(6px)", WebkitBackdropFilter: "blur(6px)", zIndex: 90, display: "flex", alignItems: "center", justifyContent: "center", padding: 18 }}>
          <div onClick={(e) => e.stopPropagation()} style={{ background: INK, border: `1px solid ${LINE}`, borderRadius: 18, width: "100%", maxWidth: 380, padding: 22, maxHeight: "86vh", overflowY: "auto" }} className="hf-modal">
            <div style={{ ...disp, fontWeight: 700, fontSize: 18, marginBottom: 16 }}>{T("installHelpTitle")}</div>
            {[[T("installIosT"), [T("installIos1"), T("installIos2"), T("installIos3")]], [T("installAndroidT"), [T("installAndroid1"), T("installAndroid2"), T("installAndroid3")]]].map(([head, steps], bi) => (
              <div key={bi} style={{ marginBottom: 16 }}>
                <div style={{ fontSize: 11, letterSpacing: 1, textTransform: "uppercase", color: EMBER, fontWeight: 700, marginBottom: 8 }}>{head}</div>
                <div style={{ display: "grid", gap: 8 }}>
                  {steps.map((s, i) => (
                    <div key={i} style={{ display: "flex", gap: 10, alignItems: "flex-start" }}>
                      <div style={{ flexShrink: 0, width: 20, height: 20, borderRadius: "50%", background: INK2, border: `1px solid ${LINE}`, color: EMBER, fontSize: 11, fontWeight: 800, display: "flex", alignItems: "center", justifyContent: "center", ...disp }}>{i + 1}</div>
                      <div style={{ fontSize: 13, color: PAPER, lineHeight: 1.5 }}>{s}</div>
                    </div>
                  ))}
                </div>
              </div>
            ))}
            <div onClick={() => setShowInstallHelp(false)} style={{ cursor: "pointer", textAlign: "center", background: EMBER, color: PAPER, padding: "12px 0", borderRadius: 10, ...disp, fontWeight: 700, fontSize: 15, marginTop: 4 }}>{T("installClose")}</div>
          </div>
        </div>
      )}

      <div style={{ maxWidth: 680, margin: "0 auto", padding: 16, position: "relative", zIndex: 1 }}>

        {tab === "dashboard" && gymPro && <GymAgendaMember lang={lang} color={gymCtx.org.brand_color} />}
        {tab === "dashboard" && isGymMember && <GymClasses lang={lang} color={gymCtx.org.brand_color} classAccess={gymCtx.classAccess} />}
        {tab === "dashboard" && <Dashboard lang={lang} session={session} week={week} targets={targets} units={units} onGo={(x) => { setTab(x); try { window.scrollTo(0, 0); } catch (e) {} }} />}

        {/* ====== PLAN TAB ====== */}
        {tab === "plan" && (
          <div style={{ display: "grid", gap: 18 }}>
            <div style={{ background: INK2, border: `1px solid ${LINE}`, borderRadius: 14, padding: 18 }}>
              <div style={{ ...disp, fontSize: 15, fontWeight: 600, textTransform: "uppercase", letterSpacing: 1.5, marginBottom: 6, color: EMBER }}>{T("yourStats")}</div>
              <div style={{ fontSize: 11, color: MUTED, lineHeight: 1.5, marginBottom: 14 }}>{T("statsHint")}</div>

              <div style={{ marginBottom: 14 }}>
                <label style={label}>{T("sexLbl")}</label>
                <Dropdown value={sex} onChange={setSex} options={[{ id: "male", label: T("man") }, { id: "female", label: T("woman") }]} />
              </div>
              <div style={{ display: "grid", gridTemplateColumns: "1fr 1fr 1fr", gap: 10, marginBottom: 14 }}>
                <div><label style={label}>{T("age")}</label><input style={input} value={age} onChange={(e) => setAge(e.target.value)} inputMode="numeric" /></div>
                <div><label style={label}>{T("height")} ({units === "imperial" ? "ft/in" : "cm"})</label>{units === "imperial"
                  ? (() => { const fi = cmToFtIn(height); return (<div style={{ display: "flex", gap: 4 }}><input style={{ ...input, textAlign: "center", padding: "11px 4px" }} value={fi.ft} onChange={(e) => setHeight(String(ftInToCm(e.target.value, fi.in)))} inputMode="numeric" /><input style={{ ...input, textAlign: "center", padding: "11px 4px" }} value={fi.in} onChange={(e) => setHeight(String(ftInToCm(fi.ft, e.target.value)))} inputMode="numeric" /></div>); })()
                  : <input style={input} value={height} onChange={(e) => setHeight(e.target.value)} inputMode="numeric" />}</div>
                <div><label style={label}>{T("weight")} ({bUnit(units)})</label><input style={input} value={kgShow(weight, units)} onChange={(e) => setWeight(String(kgStore(e.target.value, units)))} inputMode="numeric" /></div>
              </div>
              <div style={{ marginBottom: 14 }}>
                <label style={label}>{T("trainingLoad")}</label>
                <Dropdown value={activity} onChange={setActivity} options={ACTIVITY.map((a) => ({ id: a.id, label: a[lang] }))} />
              </div>
              <div style={{ marginBottom: 14 }}>
                <label style={label}>{T("goal")}</label>
                <Dropdown value={goal} onChange={setGoal} options={GOALS.map((g) => ({ id: g.id, label: g[lang] }))} />
              </div>
              <div style={{ marginBottom: 14 }}>
                <label style={label}>{T("diet")}</label>
                <Dropdown value={diet} onChange={setDiet} options={DIETS.map((d) => ({ id: d.id, label: d[lang] }))} />
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
                <MultiDropdown values={proteins} onChange={setProteins} options={PROTEINS.map((p) => ({ id: p.id, label: p[lang] }))} placeholder={T("pickMulti")} />
              </div>
              <div style={{ marginBottom: 16 }}>
                <label style={label}>{T("cuisine")}</label>
                <MultiDropdown values={cuisines} onChange={setCuisines} options={CUISINES.map((c) => ({ id: c.id, label: c[lang] }))} placeholder={T("pickMulti")} />
              </div>

              <div style={{ marginBottom: 18 }}>
                <label style={label}>{T("variety")}</label>
                <Dropdown value={variety} onChange={setVariety} options={VARIETY.map((v) => ({ id: v.id, label: v[lang] }))} />
                <div style={{ fontSize: 11, color: MUTED, lineHeight: 1.5, marginTop: 8 }}>{T("varietyHint")}</div>
              </div>

              <div style={{ height: 1, background: LINE, margin: "2px 0 16px" }} />
              <div style={{ marginBottom: 18 }}>
                <label style={label}>{T("trainingDays")}</label>
                <div style={{ display: "flex", gap: 5, marginBottom: 8 }}>
                  {WD[lang].map((d, i) => <div key={i} onClick={() => toggle(i, trainingDays, setTrainingDays)} style={dayChip(trainingDays.includes(i))}>{d}</div>)}
                </div>
                <div style={{ fontSize: 11, color: MUTED, lineHeight: 1.5 }}>{T("trainingDaysHint")}</div>
              </div>

              <div style={{ marginBottom: snacks > 0 ? 14 : 18 }}>
                <label style={label}>{T("snacksLbl")}</label>
                <Dropdown value={snacks} onChange={setSnacks} options={[0, 1, 2, 3].map((n) => ({ id: n, label: String(n) }))} />
                <div style={{ fontSize: 11, color: MUTED, lineHeight: 1.5, marginTop: 8 }}>{T("snacksHint")}</div>
              </div>
              {snacks > 0 && (
                <div style={{ marginBottom: 18 }}>
                  <label style={label}>{T("snackLikesLbl")}</label>
                  <MultiDropdown values={snackLikes} onChange={setSnackLikes} options={SNACKS.map((s) => ({ id: s.id, label: s[lang] }))} placeholder={T("pickMulti")} />
                </div>
              )}

              <button onClick={handleBuild} disabled={loading} style={{ width: "100%", background: EMBER, color: PAPER, border: "none", padding: "14px 0", borderRadius: 10, ...disp, fontWeight: 700, fontSize: 16, letterSpacing: 1, textTransform: "uppercase", cursor: loading ? "default" : "pointer", opacity: loading ? 0.7 : 1 }}>
                {loading ? T("building") : T("build")}
              </button>
              <div onClick={() => { if (!loading) buildOwnPlan(); }} style={{ cursor: loading ? "default" : "pointer", textAlign: "center", marginTop: 10, color: EMBER, fontSize: 13, fontWeight: 700, ...disp, letterSpacing: 0.3 }}>{T("buildOwn")}</div>
              <div style={{ fontSize: 10.5, color: MUTED, textAlign: "center", marginTop: 4, lineHeight: 1.4 }}>{T("ownPlanHint")}</div>
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
                      <div style={(lowBmi || floored) ? { marginTop: 12, border: `1px solid ${EMBER}`, background: "rgba(225,29,72,0.14)", borderRadius: 10, padding: "10px 12px" } : { marginTop: 12, borderLeft: `2px solid ${EMBER}`, padding: "2px 0 2px 12px" }}>
                        <span style={{ fontSize: 11, fontWeight: 700, color: PAPER, textTransform: "uppercase", letterSpacing: 0.5 }}>{(lowBmi || floored) ? "⚠ " + T("lowBmiTitle") : T("safeTitle")}. </span>
                        <span style={{ fontSize: 11.5, color: (lowBmi || floored) ? PAPER : MUTED, lineHeight: 1.5 }}>{safeText}</span>
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

                  {week && !loading && canView && (
                    <>
                      {hasBasis && (
                      <div style={{ background: INK2, border: `1px solid ${LINE}`, borderRadius: 14, padding: 16, marginBottom: 16 }}>
                        <div style={{ ...label, marginBottom: 10 }}>{T("dlTitle")}</div>
                        {planEmail === "sent" && <div style={{ fontSize: 12, color: SAGE, marginBottom: 10, lineHeight: 1.5 }}>{T("emailedPlan")}</div>}
                        {planEmail === "sending" && <div style={{ fontSize: 12, color: MUTED, marginBottom: 10, lineHeight: 1.5 }}>{T("emailingPlan")}</div>}
                        <div style={{ display: "flex", flexWrap: "wrap", gap: 10 }}>
                          <div onClick={downloadTracker} style={{ cursor: trackerBusy ? "default" : "pointer", opacity: trackerBusy ? 0.7 : 1, padding: "10px 16px", borderRadius: 8, border: "none", background: EMBER, color: PAPER, fontSize: 13, fontWeight: 700, ...disp, letterSpacing: 0.3 }}>{trackerBusy ? T("dlPreparing") : T("dlTracker")}</div>
                        </div>
                        <div style={{ fontSize: 11.5, color: MUTED, marginTop: 10, lineHeight: 1.5 }}>{T("dlHint")}</div>
                      </div>
                      )}
                      <div style={{ marginBottom: 14, display: "flex", justifyContent: "space-between", alignItems: "center", gap: 10, flexWrap: "wrap" }}>
                        <div style={{ display: "inline-flex", gap: 4, background: INK2, border: `1px solid ${LINE}`, borderRadius: 10, padding: 4 }}>
                          {[["plan", T("tabPlan")], ["shop", T("tabShop")]].map(([id, lbl]) => (
                            <div key={id} onClick={() => setView(id)} style={{ padding: "8px 16px", borderRadius: 7, background: view === id ? EMBER : "transparent", color: PAPER, fontSize: 13, fontWeight: 700, ...disp, letterSpacing: 0.5, cursor: "pointer" }}>{lbl}</div>
                          ))}
                        </div>
                        {view === "plan" && (hasBasis ? (
                          <div style={{ display: "flex", gap: 8, flexWrap: "wrap" }}>
                            {planEdit && <div onClick={() => setMovePlan({ scope: "week" })} style={{ cursor: "pointer", padding: "8px 14px", borderRadius: 8, border: `1px solid ${LINE}`, color: EMBER, fontSize: 13, fontWeight: 700, ...disp, letterSpacing: 0.5 }}>{T("movePlan")}</div>}
                            {planEdit && hasPro && <div onClick={() => setShowProducts(true)} style={{ cursor: "pointer", padding: "8px 14px", borderRadius: 8, border: `1px solid ${LINE}`, color: EMBER, fontSize: 13, fontWeight: 700, ...disp, letterSpacing: 0.5 }}>{T("myProducts")}</div>}
                            <div onClick={toggleEdit} style={{ cursor: "pointer", padding: "8px 16px", borderRadius: 8, border: `1px solid ${planEdit ? EMBER : LINE}`, background: planEdit ? EMBER : "transparent", color: planEdit ? PAPER : EMBER, fontSize: 13, fontWeight: 700, ...disp, letterSpacing: 0.5 }}>{planEdit ? T("editDone") : T("editPlan")}</div>
                          </div>
                        ) : (
                          <div onClick={() => setShowAuth(true)} style={{ cursor: "pointer", padding: "8px 14px", borderRadius: 8, border: `1px solid ${LINE}`, color: MUTED, fontSize: 13, fontWeight: 700, ...disp, letterSpacing: 0.5, display: "inline-flex", alignItems: "center", gap: 7 }}><LockIcon c={MUTED} s={15} />{T("editPlan")}</div>
                        ))}
                      </div>

                      {view === "plan" && planEdit && <div style={{ fontSize: 11.5, color: MUTED, marginBottom: 12, lineHeight: 1.5 }}>{T("editHint")}</div>}
                      {view === "plan" && (<div style={{ display: "grid", gap: 12 }}>{week.days.map((day, di) => planEdit ? <EditDayCard key={di} day={day} di={di} api={{ T, ML, sIn, R, disp, mutDay, patchMeal, scaleMeal, patchIng, addIngr, removeIngr, removeMeal, addMealTo, saveMealAsRecipe, applyIngVals, saveIngProduct, setCopyPick, setMovePlan, setPickTarget, setShowProducts, setRecipePick, savedMsg, units, pro: hasPro }} /> : <DayCard key={di} day={day} />)}</div>)}
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

                  {targets && !loading && !error && !hasBasis && (
                    <div style={{ border: `1px solid ${EMBER}`, borderRadius: 14, padding: 20, background: "linear-gradient(180deg, rgba(225,29,72,0.13), transparent 62%)", boxShadow: "0 12px 44px rgba(225,29,72,0.14)" }}>
                      <div style={{ ...disp, fontSize: 21, fontWeight: 700, letterSpacing: 0.3, marginBottom: 6 }}>{lockReason === "no_credits" ? T("creditsOutTitle") : T("lockTitle")}</div>
                      <div style={{ fontSize: 12.5, color: MUTED, marginBottom: 16, lineHeight: 1.5 }}>{lockReason === "no_credits" ? T("creditsOutSub") : T("lockSub")}</div>
                      <div style={{ display: "grid", gap: 9, marginBottom: 18 }}>
                        {[T("lb1"), T("lb2"), T("lb3")].map((t, i) => (
                          <div key={i} style={{ display: "flex", gap: 9, alignItems: "flex-start", fontSize: 13.5 }}><span style={{ color: EMBER, fontWeight: 800 }}>✓</span><span>{t}</span></div>
                        ))}
                      </div>
                      <div onClick={() => setShowAuth(true)} style={{ cursor: "pointer", textAlign: "center", background: EMBER, color: PAPER, padding: "16px 0", borderRadius: 11, ...disp, fontWeight: 700, fontSize: 17, letterSpacing: 0.6, textTransform: "uppercase", boxShadow: "0 6px 22px rgba(225,29,72,0.38)" }}>{T("subscribeCta")}</div>
                      <div onClick={() => setShowAuth(true)} style={{ cursor: "pointer", textAlign: "center", color: EMBER_SOFT, marginTop: 11, fontSize: 13, fontWeight: 700, ...disp, letterSpacing: 0.3 }}>{T("subYearUpsell")}</div>
                      <div style={{ fontSize: 11, color: MUTED, marginTop: 11, textAlign: "center" }}>{T("lockFoot")}</div>
                      {!inDemo && (
                        <div onClick={enterDemo} style={{ cursor: "pointer", textAlign: "center", color: MUTED, marginTop: 13, fontSize: 12.5, fontWeight: 600, textDecoration: "underline" }}>{lang === "nl" ? "Of bekijk eerst de app" : "Or take a look inside first"}</div>
                      )}
                    </div>
                  )}

                  {targets && !loading && !error && !hasBasis && (
                    <div style={{ marginTop: 16, border: `1px solid ${EMBER}`, borderRadius: 14, padding: 18, background: "linear-gradient(180deg, rgba(225,29,72,0.06), transparent 72%)" }}>
                      {leadStatus === "ok" ? (
                        <div>
                          <div style={{ ...disp, fontSize: 17, fontWeight: 700, marginBottom: 4 }}>{T("leadOkTitle")}</div>
                          <div style={{ fontSize: 12.5, color: MUTED, lineHeight: 1.5 }}>{T("leadOkBody")}</div>
                        </div>
                      ) : (
                        <div>
                          <div style={{ ...disp, fontSize: 17, fontWeight: 700, marginBottom: 4 }}>{T("leadTitle")}</div>
                          <div style={{ fontSize: 12.5, color: MUTED, marginBottom: 12, lineHeight: 1.5 }}>{T("leadSub")}</div>
                          <input style={{ ...input, marginBottom: 9 }} type="email" value={email} onChange={(ev) => { setEmail(ev.target.value); if (leadStatus !== "idle") setLeadStatus("idle"); }} placeholder={T("leadPh")} />
                          <button onClick={subscribe} disabled={leadStatus === "sending"} style={{ width: "100%", background: EMBER, color: PAPER, border: "none", padding: "13px 0", borderRadius: 9, ...disp, fontWeight: 700, fontSize: 14.5, letterSpacing: 0.5, textTransform: "uppercase", cursor: leadStatus === "sending" ? "default" : "pointer" }}>
                            {leadStatus === "sending" ? T("leadSending") : T("leadBtn")}
                          </button>
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
        {tab === "today" && (canView ? <Today key={"today" + syncVer} lang={lang} week={week} session={session} plus={hasPlus} demo={inDemo} onUnlock={() => setShowAuth(true)} units={units} onRebalance={rebalanceDay} onGoPlan={() => setTab("plan")} /> : <Locked />)}
        {tab === "tracker" && (hasBasis ? <Tracker lang={lang} height={height} session={session} units={units} /> : <Locked />)}
        {tab === "water" && (hasBasis ? <Water lang={lang} session={session} week={week} units={units} /> : <Locked />)}
        {tab === "producten" && (hasPro ? <Products embedded lang={lang} session={session} onProductChange={propagateProduct} /> : <Locked pro />)}
        {tab === "recipes" && <Recipes lang={lang} session={session} units={units} />}
        {tab === "race" && (canViewPlus ? <RaceProtocol lang={lang} weight={weight} session={session} week={week} /> : <Locked pro />)}
        {tab === "training" && (hasBasis ? <Training key={"training" + syncVer} lang={lang} weight={weight} session={session} /> : <Locked />)}
      </div>

      {/* QUICK-ADD + (centraal, verhoogd) */}
      {fab && <div onClick={() => setFab(false)} style={{ position: "fixed", inset: 0, zIndex: 44, background: "rgba(0,0,0,0.6)", backdropFilter: "blur(9px)", WebkitBackdropFilter: "blur(9px)" }} />}
      {fab && (
        <div style={{ position: "fixed", left: 0, right: 0, bottom: "calc(env(safe-area-inset-bottom) + 100px)", zIndex: 46, display: "flex", flexDirection: "column", alignItems: "center", gap: 12 }}>
          {fabAct(lang === "nl" ? "Training loggen" : "Log training", <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke={EMBER} strokeWidth="1.9" strokeLinecap="round" strokeLinejoin="round"><path d="M6.5 6.5l11 11M4 9l-1.5 1.5a1.5 1.5 0 000 2L4 14M20 9l1.5 1.5a1.5 1.5 0 010 2L20 14M7 4l1.5 1.5M17 20l-1.5-1.5" /></svg>, () => { setFab(false); if (!hasBasis) { setShowAuth(true); return; } go("training"); })}
          {fabAct(lang === "nl" ? "Recept maken" : "Create recipe", <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke={EMBER} strokeWidth="1.9" strokeLinecap="round" strokeLinejoin="round"><path d="M4 4v6a3 3 0 006 0V4M7 4v16" /><path d="M17 4c-1.5 0-2.5 2-2.5 5s1 4 2.5 4 2.5-1 2.5-4-1-5-2.5-5zM17 13v7" /></svg>, () => { setFab(false); setShowBuilder(true); })}
          {fabAct(lang === "nl" ? "Gewicht loggen" : "Log weight", <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke={EMBER} strokeWidth="1.9" strokeLinecap="round" strokeLinejoin="round"><path d="M4 18l5-6 4 3 6-8" /><path d="M4 21h16" /></svg>, () => { setFab(false); if (!hasBasis) { setShowAuth(true); return; } go("tracker"); })}
          {fabAct(lang === "nl" ? "Water toevoegen" : "Add water", <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke={EMBER} strokeWidth="1.9" strokeLinecap="round" strokeLinejoin="round"><path d="M12 3c3.5 4.2 6 7.3 6 10.3A6 6 0 016 13.3C6 10.3 8.5 7.2 12 3z" /></svg>, () => { setFab(false); if (!hasBasis) { setShowAuth(true); return; } go("water"); })}
          {fabAct(lang === "nl" ? "Scan / log eten" : "Scan / log food", <svg width="20" height="20" viewBox="0 0 24 24" fill={EMBER} aria-hidden="true"><rect x="3" y="5" width="1.7" height="14" /><rect x="6" y="5" width="1" height="14" /><rect x="8.5" y="5" width="2" height="14" /><rect x="12" y="5" width="1" height="14" /><rect x="14.6" y="5" width="1.7" height="14" /><rect x="17.6" y="5" width="1" height="14" /><rect x="20" y="5" width="1.4" height="14" /></svg>, () => { setFab(false); if (!hasPro) { setShowAuth(true); return; } setFabScan(true); setShowProducts(true); })}
        </div>
      )}
      <div onClick={() => setFab(!fab)} title="+" style={{ position: "fixed", left: "50%", bottom: "calc(env(safe-area-inset-bottom) + 28px)", zIndex: 47, width: 58, height: 58, borderRadius: "50%", background: EMBER, display: "flex", alignItems: "center", justifyContent: "center", boxShadow: "0 6px 20px rgba(225,29,72,0.5)", cursor: "pointer", transition: "transform .2s", transform: `translateX(-50%) ${fab ? "rotate(45deg)" : ""}`, border: `3px solid ${INK}` }}>
        <svg width="27" height="27" viewBox="0 0 24 24" fill="none" stroke={PAPER} strokeWidth="2.4" strokeLinecap="round"><path d="M12 5v14M5 12h14" /></svg>
      </div>

      {/* BOTTOM NAV, 2 links, +, 2 rechts */}
      <div style={{ position: "fixed", left: 0, right: 0, bottom: 0, background: INK, borderTop: `1px solid ${LINE}`, display: "flex", zIndex: 45, paddingBottom: "env(safe-area-inset-bottom)" }}>
        {navCell("dashboard", "navDash", () => go("dashboard"), tab === "dashboard")}
        {navCell("plan", "navPlan", () => go("plan"), tab === "plan")}
        <div style={{ flex: 1 }} />
        {navCell("recipes", "navRecipes", () => go("recipes"), tab === "recipes")}
        {navCell("more", "navMore", () => setShowMore(true), showMore || OVERFLOW.includes(tab))}
      </div>

      {/* MEER-menu */}
      {showMore && (
        <div onClick={() => setShowMore(false)} style={{ position: "fixed", inset: 0, background: "rgba(0,0,0,0.6)", backdropFilter: "blur(4px)", WebkitBackdropFilter: "blur(4px)", zIndex: 50, display: "flex", alignItems: "flex-end" }}>
          <div onClick={(e) => e.stopPropagation()} style={{ width: "100%", background: INK, borderTop: `1px solid ${LINE}`, borderRadius: "20px 20px 0 0", padding: "16px 16px calc(20px + env(safe-area-inset-bottom))", backgroundImage: "radial-gradient(130% 60% at 90% 0%, rgba(225,29,72,0.1), transparent 60%)" }}>
            <div style={{ width: 40, height: 4, background: LINE, borderRadius: 2, margin: "0 auto 14px" }} />
            <div style={{ ...disp, fontSize: 12.5, fontWeight: 700, letterSpacing: 1, textTransform: "uppercase", color: EMBER, marginBottom: 12 }}>{T("navMore")}</div>
            <div style={{ display: "grid", gridTemplateColumns: "1fr 1fr", gap: 10 }}>
              {moreTile(mIcon("today"), T("navToday"), () => go("today"))}
              {moreTile(mIcon("tracker"), T("navTracker"), () => go("tracker"))}
              {moreTile(mIcon("water"), T("navWater"), () => go("water"))}
              {moreTile(mIcon("producten"), T("navProducts"), () => go("producten"))}
              {moreTile(mIcon("race"), T("navRace"), () => go("race"))}
              {moreTile(<svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke={EMBER} strokeWidth="1.9" strokeLinecap="round" strokeLinejoin="round"><path d="M6.5 6.5l11 11M4 9l-1.5 1.5a1.5 1.5 0 000 2L4 14M20 9l1.5 1.5a1.5 1.5 0 010 2L20 14M7 4l1.5 1.5M17 20l-1.5-1.5" /></svg>, lang === "nl" ? "Training" : "Training", () => go("training"))}
              {moreTile(<svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke={EMBER} strokeWidth="1.9" strokeLinecap="round" strokeLinejoin="round"><circle cx="12" cy="8" r="4" /><path d="M4 21c0-4 4-6.5 8-6.5s8 2.5 8 6.5" /></svg>, lang === "nl" ? "Account" : "Account", () => { setShowMore(false); setShowAuth(true); })}
              {moreTile(<svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke={EMBER} strokeWidth="1.9" strokeLinecap="round" strokeLinejoin="round"><path d="M18 8a6 6 0 10-12 0c0 7-3 9-3 9h18s-3-2-3-9M13.7 21a2 2 0 01-3.4 0" /></svg>, lang === "nl" ? "Herinneringen" : "Reminders", () => { setShowMore(false); setShowReminders(true); })}
            </div>
            <div style={{ marginTop: 16, borderTop: `1px solid ${LINE}`, paddingTop: 14 }}>
              <div style={{ fontSize: 10.5, letterSpacing: 1, textTransform: "uppercase", color: MUTED, fontWeight: 700, marginBottom: 8 }}>{lang === "nl" ? "Eenheden" : "Units"}</div>
              <div style={{ display: "flex", gap: 6, background: INK2, border: `1px solid ${LINE}`, borderRadius: 10, padding: 4 }}>
                {[["metric", lang === "nl" ? "Metrisch · g / kg" : "Metric · g / kg"], ["imperial", lang === "nl" ? "Imperiaal · oz / lb" : "Imperial · oz / lb"]].map(([u, lbl]) => (
                  <div key={u} onClick={() => setUnitsSave(u)} style={{ flex: 1, textAlign: "center", cursor: "pointer", ...disp, fontWeight: 700, fontSize: 12.5, letterSpacing: 0.3, padding: "10px 0", borderRadius: 7, background: units === u ? EMBER : "transparent", color: units === u ? PAPER : MUTED }}>{lbl}</div>
                ))}
              </div>
              <div style={{ fontSize: 10.5, color: MUTED, marginTop: 7, lineHeight: 1.5 }}>{lang === "nl" ? "Geldt voor gewichten in de hele app, altijd aanpasbaar." : "Applies to weights across the app, change it anytime."}</div>
            </div>
          </div>
        </div>
      )}

      {showReminders && <Reminders lang={lang} onClose={() => setShowReminders(false)} />}
      {showAuth && <Auth lang={lang} session={session} tier={subTier} recovery={authRecovery} gym={isGymMember ? gymCtx.org : null} onClose={() => { setShowAuth(false); setAuthRecovery(false); }} />}
      {showProducts && <Products lang={lang} session={session} autoScan={fabScan} onClose={() => { setShowProducts(false); setPickTarget(null); setFabScan(false); }} onPick={pickTarget ? (prod) => { if (pickTarget.mi == null) addProductAsMeal(pickTarget.di, prod); else addProductIng(pickTarget.di, pickTarget.mi, prod); setShowProducts(false); setPickTarget(null); } : fabScan ? (prod) => { addTodayProduct(prod); setShowProducts(false); setFabScan(false); } : null} />}
      {showBuilder && <RecipeBuilder lang={lang} session={session} units={units} onClose={() => setShowBuilder(false)} onSaved={() => flashSaved()} />}

      {copyPick && (
        <div onClick={() => setCopyPick(null)} style={{ position: "fixed", inset: 0, background: "rgba(0,0,0,0.72)", backdropFilter: "blur(6px)", WebkitBackdropFilter: "blur(6px)", zIndex: 70, display: "flex", alignItems: "center", justifyContent: "center", padding: 16 }}>
          <div onClick={(e) => e.stopPropagation()} style={{ background: INK, border: `1px solid ${LINE}`, borderRadius: 18, width: "100%", maxWidth: 340, padding: 20, backgroundImage: "radial-gradient(130% 70% at 92% -10%, rgba(225,29,72,0.12), transparent 58%)" }}>
            <div style={{ ...disp, fontWeight: 700, fontSize: 16, marginBottom: 4 }}>{T("copyToTitle")}</div>
            <div style={{ fontSize: 12, color: MUTED, marginBottom: 14, lineHeight: 1.4 }}>{copyPick.kind === "day" ? T("copyDayToLbl") : T("copyMealToLbl")}</div>
            <div style={{ display: "grid", gap: 8 }}>
              {week && week.days.map((d, i) => i === copyPick.di ? null : (
                <div key={i} onClick={() => { if (copyPick.kind === "day") copyDayTo(copyPick.di, i); else copyMealTo(copyPick.di, copyPick.mi, i); setCopyPick(null); }} style={{ cursor: "pointer", padding: "11px 14px", borderRadius: 10, border: `1px solid ${LINE}`, background: INK2, ...disp, fontWeight: 600, fontSize: 14, letterSpacing: 0.5, textTransform: "uppercase" }}>{d.d}</div>
              ))}
            </div>
          </div>
        </div>
      )}
      {recipePick !== null && <RecipePicker di={recipePick} onClose={() => setRecipePick(null)} />}
      {movePlan && <MovePlan scope={movePlan.scope} di={movePlan.di} onClose={() => setMovePlan(null)} />}

      {/* Opgeslagen-bevestiging met "Naar dashboard" */}
      {saveFlash && (
        <div style={{ position: "fixed", left: "50%", transform: "translateX(-50%)", bottom: "calc(env(safe-area-inset-bottom) + 96px)", zIndex: 80, display: "flex", alignItems: "center", gap: 12, background: INK2, border: `1px solid ${SAGE}`, borderRadius: 12, padding: "11px 14px", boxShadow: "0 10px 30px rgba(0,0,0,0.5)", maxWidth: "92vw" }}>
          <span style={{ color: SAGE, fontSize: 16, fontWeight: 800 }}>✓</span>
          <span style={{ fontSize: 13.5, color: PAPER, fontWeight: 600 }}>{T("savedFlash")}</span>
          <div onClick={() => { setSaveFlash(false); setPlanEdit(false); setTab("dashboard"); try { window.scrollTo(0, 0); } catch (e) {} }} style={{ cursor: "pointer", marginLeft: 4, background: EMBER, color: PAPER, borderRadius: 8, padding: "7px 12px", fontSize: 12.5, fontWeight: 700, ...disp, letterSpacing: 0.3, whiteSpace: "nowrap" }}>{T("toDashboard")} →</div>
          <div onClick={() => setSaveFlash(false)} style={{ cursor: "pointer", color: MUTED, fontSize: 15, padding: "0 2px" }}>×</div>
        </div>
      )}

      {/* Uitlog-bevestiging (vanaf dashboard met de terug-knop) */}
      {showLogout && (
        <div onClick={() => setShowLogout(false)} style={{ position: "fixed", inset: 0, background: "rgba(0,0,0,0.72)", backdropFilter: "blur(6px)", WebkitBackdropFilter: "blur(6px)", zIndex: 90, display: "flex", alignItems: "center", justifyContent: "center", padding: 20 }}>
          <div onClick={(e) => e.stopPropagation()} style={{ background: INK, border: `1px solid ${LINE}`, borderRadius: 18, width: "100%", maxWidth: 360, padding: 22, textAlign: "center", backgroundImage: "radial-gradient(130% 70% at 50% -10%, rgba(225,29,72,0.14), transparent 60%)" }}>
            <div style={{ ...disp, fontWeight: 700, fontSize: 18, marginBottom: 18, lineHeight: 1.3 }}>{T("logoutTitle")}</div>
            <div style={{ display: "flex", flexDirection: "column", gap: 10 }}>
              <div onClick={confirmLogout} style={{ cursor: "pointer", background: EMBER, color: PAPER, padding: "13px 0", borderRadius: 10, ...disp, fontWeight: 700, fontSize: 15, letterSpacing: 0.5 }}>{T("logoutYes")}</div>
              <div onClick={() => setShowLogout(false)} style={{ cursor: "pointer", border: `1px solid ${LINE}`, color: PAPER, padding: "13px 0", borderRadius: 10, ...disp, fontWeight: 700, fontSize: 15, letterSpacing: 0.5 }}>{T("logoutNo")}</div>
            </div>
          </div>
        </div>
      )}
    </div>
  );
}
