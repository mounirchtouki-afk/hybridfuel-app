// HybridFuelCo — vaste receptenbibliotheek (kok-gemaakt, doorgerekend).
// Deze recepten gebruikt de app als bouwstenen: elk heeft ingrediënten met grammen
// en bekende macro's, zodat we ze netjes naar de dagdoelen van de klant kunnen
// SCHALEN i.p.v. uit het niets te genereren.
//
// Vorm per recept:
//   id, type (breakfast|lunch|dinner|snack), name{nl,en}, goal{nl,en},
//   ing: [{nl, en, g}]   -> ingrediënten met gewicht in gram (ml ~ g voor vloeistof)
//   macros: { kcal, p, c, fiber, f }   -> voor de gegeven gewichten
//
// De macro's zijn schattingen op de genoemde gewichten; merk en bereiding kunnen
// afwijken. Geen medisch advies.

export const RECIPES = [
  {
    id: 1, type: "breakfast",
    name: { nl: "Hartige Havermout met Ei", en: "Savoury Oats with Egg" },
    goal: { nl: "Fibermaxxing / Herstel", en: "Fibermaxxing / Recovery" },
    ing: [
      { nl: "Havermout", en: "Oats", g: 50 },
      { nl: "Vetarme bouillon", en: "Low-fat stock", g: 150 },
      { nl: "Verse spinazie", en: "Fresh spinach", g: 100 },
      { nl: "Ei (gepocheerd)", en: "Egg (poached)", g: 50 },
      { nl: "Pompoenpitten", en: "Pumpkin seeds", g: 15 },
    ],
    macros: { kcal: 420, p: 22, c: 42, fiber: 9, f: 16 },
  },
  {
    id: 2, type: "dinner",
    name: { nl: "Vegan Linzen-Kikkererwten Curry", en: "Vegan Lentil-Chickpea Curry" },
    goal: { nl: "Plantaardig / Spieropbouw", en: "Plant-based / Muscle gain" },
    ing: [
      { nl: "Linzen (uit blik)", en: "Lentils (tinned)", g: 100 },
      { nl: "Kikkererwten (uit blik)", en: "Chickpeas (tinned)", g: 100 },
      { nl: "Tomatenblokjes", en: "Chopped tomatoes", g: 150 },
      { nl: "Lichte kokosmelk", en: "Light coconut milk", g: 50 },
      { nl: "Boerenkool", en: "Kale", g: 30 },
      { nl: "Currykruiden (kurkuma, komijn)", en: "Curry spices (turmeric, cumin)", g: 5 },
    ],
    macros: { kcal: 510, p: 26, c: 58, fiber: 14, f: 15 },
  },
  {
    id: 3, type: "breakfast",
    name: { nl: "Matcha Protein Overnight Oats", en: "Matcha Protein Overnight Oats" },
    goal: { nl: "Focus / Pre-workout", en: "Focus / Pre-workout" },
    ing: [
      { nl: "Havermout", en: "Oats", g: 45 },
      { nl: "Vegan vanille-eiwitpoeder", en: "Vegan vanilla protein powder", g: 30 },
      { nl: "Matchapoeder", en: "Matcha powder", g: 2 },
      { nl: "Chiazaad", en: "Chia seeds", g: 10 },
      { nl: "Amandelmelk", en: "Almond milk", g: 150 },
    ],
    macros: { kcal: 460, p: 32, c: 48, fiber: 8, f: 12 },
  },
  {
    id: 4, type: "dinner",
    name: { nl: "Zalm & Quinoa Clean Bowl", en: "Salmon & Quinoa Clean Bowl" },
    goal: { nl: "Clean label / Omega-3", en: "Clean label / Omega-3" },
    ing: [
      { nl: "Quinoa (droog)", en: "Quinoa (dry)", g: 60 },
      { nl: "Zalmfilet", en: "Salmon fillet", g: 125 },
      { nl: "Broccoli (gestoomd)", en: "Broccoli (steamed)", g: 100 },
      { nl: "Edamameboontjes", en: "Edamame", g: 50 },
      { nl: "Olijfolie + citroensap", en: "Olive oil + lemon juice", g: 10 },
    ],
    macros: { kcal: 580, p: 38, c: 45, fiber: 7, f: 22 },
  },
  {
    id: 5, type: "dinner",
    name: { nl: "Tempeh & Broccoli Stir-Fry", en: "Tempeh & Broccoli Stir-Fry" },
    goal: { nl: "Plantaardig / Darmflora", en: "Plant-based / Gut health" },
    ing: [
      { nl: "Tempeh", en: "Tempeh", g: 120 },
      { nl: "Broccoliroosjes", en: "Broccoli florets", g: 150 },
      { nl: "Paprika", en: "Bell pepper", g: 75 },
      { nl: "Zilvervliesrijst (droog)", en: "Brown rice (dry)", g: 50 },
      { nl: "Tamari, gember, knoflook", en: "Tamari, ginger, garlic", g: 15 },
    ],
    macros: { kcal: 490, p: 28, c: 35, fiber: 10, f: 21 },
  },
  {
    id: 6, type: "snack",
    name: { nl: "Ashwagandha Herstel Shake", en: "Ashwagandha Recovery Shake" },
    goal: { nl: "Adaptogenen / Rust", en: "Adaptogens / Calm" },
    ing: [
      { nl: "Bevroren banaan", en: "Frozen banana", g: 120 },
      { nl: "Eiwitpoeder", en: "Protein powder", g: 30 },
      { nl: "Amandelmelk", en: "Almond milk", g: 250 },
      { nl: "Amandelpasta", en: "Almond butter", g: 10 },
      { nl: "Ashwagandhapoeder", en: "Ashwagandha powder", g: 3 },
    ],
    macros: { kcal: 340, p: 26, c: 28, fiber: 6, f: 8 },
  },
  {
    id: 7, type: "breakfast",
    name: { nl: "Hüttenkäse & Avocado Toast", en: "Cottage Cheese & Avocado Toast" },
    goal: { nl: "Snel eiwit / Gezonde vetten", en: "Quick protein / Healthy fats" },
    ing: [
      { nl: "Volkoren-/zuurdesembrood", en: "Wholegrain/sourdough bread", g: 70 },
      { nl: "Hüttenkäse (cottage cheese)", en: "Cottage cheese", g: 100 },
      { nl: "Avocado", en: "Avocado", g: 75 },
      { nl: "Chilivlokken, peper, zout", en: "Chilli flakes, pepper, salt", g: 2 },
    ],
    macros: { kcal: 390, p: 24, c: 30, fiber: 8, f: 17 },
  },
  {
    id: 8, type: "dinner",
    name: { nl: "Kip & Zoete Aardappel Traybake", en: "Chicken & Sweet Potato Traybake" },
    goal: { nl: "Clean label / Duursport", en: "Clean label / Endurance" },
    ing: [
      { nl: "Kipfilet", en: "Chicken breast", g: 150 },
      { nl: "Zoete aardappel", en: "Sweet potato", g: 200 },
      { nl: "Aspergepunten", en: "Asparagus tips", g: 100 },
      { nl: "Olijfolie", en: "Olive oil", g: 12 },
      { nl: "Paprikapoeder, zout, rozemarijn", en: "Paprika, salt, rosemary", g: 3 },
    ],
    macros: { kcal: 540, p: 42, c: 52, fiber: 8, f: 12 },
  },
  {
    id: 9, type: "snack",
    name: { nl: "Chiapudding met Blauwe Bessen", en: "Chia Pudding with Blueberries" },
    goal: { nl: "Fibermaxxing / Antioxidanten", en: "Fibermaxxing / Antioxidants" },
    ing: [
      { nl: "Chiazaad", en: "Chia seeds", g: 25 },
      { nl: "Lupinemeel of eiwitpoeder", en: "Lupin flour or protein powder", g: 15 },
      { nl: "Plantaardige melk", en: "Plant milk", g: 150 },
      { nl: "Blauwe bessen", en: "Blueberries", g: 75 },
      { nl: "Kaneel", en: "Cinnamon", g: 1 },
    ],
    macros: { kcal: 310, p: 15, c: 22, fiber: 11, f: 14 },
  },
  {
    id: 10, type: "breakfast",
    name: { nl: "Eiwitrijke Proteïne Pannenkoeken", en: "High-Protein Pancakes" },
    goal: { nl: "Spierherstel / Klassieker", en: "Muscle recovery / Classic" },
    ing: [
      { nl: "Havermeel", en: "Oat flour", g: 40 },
      { nl: "Whey- of erwteneiwit", en: "Whey or pea protein", g: 30 },
      { nl: "Ei", en: "Egg", g: 50 },
      { nl: "Magere melk", en: "Skimmed milk", g: 100 },
    ],
    macros: { kcal: 430, p: 35, c: 38, fiber: 5, f: 9 },
  },
];

// Schaal een recept lineair naar een doel-calorie-aantal.
// Geeft een nieuw object terug met geschaalde grammen en macro's (afgerond).
export function scaleRecipe(recipe, targetKcal) {
  const base = recipe.macros.kcal || 1;
  const factor = Math.max(0.4, Math.min(2.2, (targetKcal || base) / base)); // begrens 40%–220%
  return {
    ...recipe,
    factor: Math.round(factor * 100) / 100,
    ing: recipe.ing.map((x) => ({ ...x, g: Math.round(x.g * factor) })),
    macros: {
      kcal: Math.round(recipe.macros.kcal * factor),
      p: Math.round(recipe.macros.p * factor),
      c: Math.round(recipe.macros.c * factor),
      fiber: Math.round((recipe.macros.fiber || 0) * factor),
      f: Math.round(recipe.macros.f * factor),
    },
  };
}

// Zet een (geschaald) recept om naar de meal-vorm die de app-UI gebruikt:
//   { t, n, kcal, p, c, f, ing:[{n,g}] }
const MEAL_T = {
  nl: { breakfast: "Ontbijt", lunch: "Lunch", dinner: "Diner", snack: "Snack" },
  en: { breakfast: "Breakfast", lunch: "Lunch", dinner: "Dinner", snack: "Snack" },
};
export function recipeToMeal(recipe, lang) {
  const L = lang === "nl" ? "nl" : "en";
  return {
    t: (MEAL_T[L] && MEAL_T[L][recipe.type]) || MEAL_T[L].snack,
    n: recipe.name[L],
    kcal: recipe.macros.kcal,
    p: recipe.macros.p,
    c: recipe.macros.c,
    f: recipe.macros.f,
    ing: recipe.ing.map((x) => ({ n: x[L], g: x.g })),
  };
}

// --- Tussendoortjes-database ---------------------------------------------
// Per snacktype (zelfde ids als de intake-chips) een lijst concrete opties met
// macro's voor een normale portie. De app/generator kiest HIERUIT — niet
// letterlijk "banaan/appel". Banaan staat vooraan als meest voor de hand
// liggende default wanneer er niets gekozen is of de lijst leeg zou zijn.
export const SNACK_DB = {
  fruit: [
    { nl: "Banaan", en: "Banana", kcal: 105, p: 1, c: 27, f: 0, ing: [{ nl: "banaan", en: "banana", g: 120 }] },
    { nl: "Appel", en: "Apple", kcal: 78, p: 0, c: 21, f: 0, ing: [{ nl: "appel", en: "apple", g: 150 }] },
    { nl: "Peer", en: "Pear", kcal: 91, p: 1, c: 24, f: 0, ing: [{ nl: "peer", en: "pear", g: 160 }] },
    { nl: "Sinaasappel", en: "Orange", kcal: 66, p: 1, c: 16, f: 0, ing: [{ nl: "sinaasappel", en: "orange", g: 140 }] },
    { nl: "Handje blauwe bessen", en: "Handful of blueberries", kcal: 57, p: 1, c: 14, f: 0, ing: [{ nl: "blauwe bessen", en: "blueberries", g: 100 }] },
    { nl: "Druiven", en: "Grapes", kcal: 69, p: 1, c: 18, f: 0, ing: [{ nl: "druiven", en: "grapes", g: 100 }] },
    { nl: "Mango", en: "Mango", kcal: 72, p: 1, c: 18, f: 0, ing: [{ nl: "mango", en: "mango", g: 120 }] },
    { nl: "2 kiwi's", en: "2 kiwis", kcal: 85, p: 2, c: 20, f: 1, ing: [{ nl: "kiwi", en: "kiwi", g: 140 }] },
  ],
  nuts: [
    { nl: "Handje amandelen", en: "Handful of almonds", kcal: 145, p: 5, c: 5, f: 13, ing: [{ nl: "amandelen", en: "almonds", g: 25 }] },
    { nl: "Handje walnoten", en: "Handful of walnuts", kcal: 164, p: 4, c: 3, f: 16, ing: [{ nl: "walnoten", en: "walnuts", g: 25 }] },
    { nl: "Handje cashewnoten", en: "Handful of cashews", kcal: 138, p: 5, c: 8, f: 11, ing: [{ nl: "cashewnoten", en: "cashews", g: 25 }] },
    { nl: "Gemengde noten", en: "Mixed nuts", kcal: 150, p: 5, c: 5, f: 13, ing: [{ nl: "gemengde noten", en: "mixed nuts", g: 25 }] },
  ],
  yoghurt: [
    { nl: "Griekse yoghurt", en: "Greek yoghurt", kcal: 150, p: 15, c: 10, f: 5, ing: [{ nl: "Griekse yoghurt", en: "Greek yoghurt", g: 200 }] },
    { nl: "Skyr", en: "Skyr", kcal: 130, p: 22, c: 8, f: 1, ing: [{ nl: "skyr", en: "skyr", g: 200 }] },
    { nl: "Yoghurt met bessen", en: "Yoghurt with berries", kcal: 165, p: 14, c: 18, f: 4, ing: [{ nl: "Griekse yoghurt", en: "Greek yoghurt", g: 170 }, { nl: "bessen", en: "berries", g: 60 }] },
  ],
  quark: [
    { nl: "Magere kwark", en: "Low-fat quark", kcal: 160, p: 32, c: 11, f: 0, ing: [{ nl: "magere kwark", en: "low-fat quark", g: 250 }] },
    { nl: "Kwark met fruit", en: "Quark with fruit", kcal: 200, p: 30, c: 20, f: 1, ing: [{ nl: "magere kwark", en: "low-fat quark", g: 250 }, { nl: "fruit", en: "fruit", g: 80 }] },
  ],
  bar: [
    { nl: "Eiwitreep", en: "Protein bar", kcal: 220, p: 20, c: 22, f: 7, ing: [{ nl: "eiwitreep", en: "protein bar", g: 60 }] },
    { nl: "Mueslireep", en: "Granola bar", kcal: 160, p: 3, c: 24, f: 6, ing: [{ nl: "mueslireep", en: "granola bar", g: 40 }] },
  ],
  ricecake: [
    { nl: "Rijstwafels + pindakaas", en: "Rice cakes + peanut butter", kcal: 170, p: 6, c: 18, f: 9, ing: [{ nl: "rijstwafels", en: "rice cakes", g: 20 }, { nl: "pindakaas", en: "peanut butter", g: 15 }] },
    { nl: "Rijstwafels + kwark", en: "Rice cakes + quark", kcal: 130, p: 12, c: 16, f: 1, ing: [{ nl: "rijstwafels", en: "rice cakes", g: 20 }, { nl: "magere kwark", en: "low-fat quark", g: 100 }] },
  ],
  shake: [
    { nl: "Proteïneshake", en: "Protein shake", kcal: 120, p: 24, c: 3, f: 2, ing: [{ nl: "whey-eiwit", en: "whey protein", g: 30 }] },
    { nl: "Shake met melk & banaan", en: "Shake with milk & banana", kcal: 260, p: 24, c: 32, f: 5, ing: [{ nl: "whey-eiwit", en: "whey protein", g: 30 }, { nl: "melk", en: "milk", g: 250 }, { nl: "banaan", en: "banana", g: 100 }] },
  ],
  veg: [
    { nl: "Worteltjes + hummus", en: "Carrots + hummus", kcal: 140, p: 4, c: 14, f: 8, ing: [{ nl: "worteltjes", en: "carrots", g: 100 }, { nl: "hummus", en: "hummus", g: 40 }] },
    { nl: "Komkommer + kwarkdip", en: "Cucumber + quark dip", kcal: 90, p: 10, c: 7, f: 2, ing: [{ nl: "komkommer", en: "cucumber", g: 150 }, { nl: "magere kwark", en: "low-fat quark", g: 80 }] },
  ],
};

// Vlakke kandidatenlijst voor de gekozen snacktypes (ids). Leeg/niets gekozen →
// fruit (met banaan vooraan) als meest voor de hand liggende default.
export function snackOptions(typeIds) {
  const ids = Array.isArray(typeIds) && typeIds.length ? typeIds.filter((k) => SNACK_DB[k]) : [];
  const pool = (ids.length ? ids : ["fruit"]).flatMap((k) => SNACK_DB[k] || []);
  return pool.length ? pool : SNACK_DB.fruit;
}
