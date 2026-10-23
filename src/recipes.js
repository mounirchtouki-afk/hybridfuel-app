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
