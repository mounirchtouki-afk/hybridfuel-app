// Genereert ingrediënten + 1000+ gerechten met doorgerekende macro's -> SQL-seed.
// Combinaties zijn bewust realistisch (per eetmoment compatibele slots), geen willekeur.
import { writeFileSync } from "node:fs";

// ---- Ingrediënten: macro's per 100 g/ml (slug, nl, en, kcal, p, c, f, cat) ----
const ING = [
  // eiwit
  ["chicken_breast","Kipfilet (gegrild)","Grilled chicken breast",165,31,0,3.6,"vlees"],
  ["turkey_breast","Kalkoenfilet","Turkey breast",135,29,0,1,"vlees"],
  ["lean_beef_5","Rundergehakt 5%","Lean beef mince 5%",137,21,0,5,"vlees"],
  ["beef_steak","Biefstuk","Beef steak",187,27,0,8,"vlees"],
  ["pork_tenderloin","Varkenshaas","Pork tenderloin",143,26,0,4,"vlees"],
  ["salmon","Zalmfilet","Salmon fillet",208,20,0,13,"vis"],
  ["cod","Kabeljauw","Cod",82,18,0,0.7,"vis"],
  ["tuna_water","Tonijn in water","Tuna in water",116,26,0,1,"vis"],
  ["shrimp","Garnalen","Shrimp",99,24,0.2,0.3,"vis"],
  ["tofu","Tofu","Tofu",144,15,2,9,"vega"],
  ["tempeh","Tempeh","Tempeh",192,20,8,11,"vega"],
  ["egg","Ei","Egg",143,13,1,10,"zuivel"],
  ["egg_white","Eiwit (los)","Egg white",52,11,0.7,0.2,"zuivel"],
  ["skyr","Skyr","Skyr",63,11,4,0.2,"zuivel"],
  ["quark_low","Magere kwark","Low-fat quark",57,10,4,0.2,"zuivel"],
  ["greek_yoghurt","Griekse yoghurt 2%","Greek yoghurt 2%",73,9,4,2,"zuivel"],
  ["low_yoghurt","Magere yoghurt","Low-fat yoghurt",42,4,6,0.1,"zuivel"],
  ["cottage","Hüttenkäse","Cottage cheese",98,11,3,5,"zuivel"],
  ["whey","Whey-eiwit","Whey protein",370,80,8,6,"supplement"],
  ["skim_milk","Magere melk","Skimmed milk",35,3.4,5,0.1,"zuivel"],
  ["feta","Feta","Feta",264,14,4,21,"zuivel"],
  ["mozzarella_light","Mozzarella light","Light mozzarella",162,18,1,10,"zuivel"],
  ["parmesan","Parmezaan","Parmesan",392,36,3,25,"zuivel"],
  // koolhydraten
  ["rice_dry","Witte rijst (droog)","White rice (dry)",360,7,79,1,"granen"],
  ["basmati_dry","Basmatirijst (droog)","Basmati rice (dry)",356,8,78,1,"granen"],
  ["pasta_dry","Volkoren pasta (droog)","Wholewheat pasta (dry)",348,14,67,2.5,"granen"],
  ["noodles_dry","Volkoren noedels (droog)","Wholewheat noodles (dry)",353,13,68,2,"granen"],
  ["quinoa_dry","Quinoa (droog)","Quinoa (dry)",368,14,64,6,"granen"],
  ["couscous_dry","Volkoren couscous (droog)","Wholewheat couscous (dry)",358,12,72,2,"granen"],
  ["oats","Havermout","Oats",379,13,60,7,"granen"],
  ["bread_whole","Volkoren brood","Wholegrain bread",247,9,41,3.4,"granen"],
  ["wrap_whole","Volkoren wrap","Wholegrain wrap",297,9,49,6,"granen"],
  ["potato","Aardappel","Potato",77,2,17,0.1,"groente"],
  ["sweet_potato","Zoete aardappel","Sweet potato",86,1.6,20,0.1,"groente"],
  ["rice_cakes","Rijstwafels","Rice cakes",387,8,82,3,"granen"],
  // groente
  ["broccoli","Broccoli","Broccoli",34,2.8,7,0.4,"groente"],
  ["green_beans","Sperziebonen","Green beans",31,1.8,7,0.1,"groente"],
  ["spinach","Spinazie","Spinach",23,2.9,3.6,0.4,"groente"],
  ["asparagus","Asperges","Asparagus",20,2.2,3.9,0.1,"groente"],
  ["zucchini","Courgette","Zucchini",17,1.2,3.1,0.3,"groente"],
  ["bell_pepper","Paprika","Bell pepper",31,1,6,0.3,"groente"],
  ["cucumber","Komkommer","Cucumber",15,0.7,3.6,0.1,"groente"],
  ["tomato","Tomaat","Tomato",18,0.9,3.9,0.2,"groente"],
  ["mixed_veg","Wokgroente","Stir-fry veg",40,2,6,0.5,"groente"],
  ["romaine","Romaine sla","Romaine lettuce",17,1.2,3.3,0.3,"groente"],
  ["carrot","Wortel","Carrot",41,0.9,10,0.2,"groente"],
  ["mushroom","Champignons","Mushrooms",22,3.1,3.3,0.3,"groente"],
  // fruit
  ["banana","Banaan","Banana",89,1.1,23,0.3,"fruit"],
  ["blueberries","Blauwe bessen","Blueberries",57,0.7,14,0.3,"fruit"],
  ["strawberries","Aardbeien","Strawberries",32,0.7,8,0.3,"fruit"],
  ["apple","Appel","Apple",52,0.3,14,0.2,"fruit"],
  ["mango","Mango","Mango",60,0.8,15,0.4,"fruit"],
  // vet/extra
  ["olive_oil","Olijfolie","Olive oil",884,0,0,100,"vet"],
  ["peanut_butter","Pindakaas","Peanut butter",588,25,20,50,"vet"],
  ["almonds","Amandelen","Almonds",579,21,22,50,"noten"],
  ["walnuts","Walnoten","Walnuts",654,15,14,65,"noten"],
  ["avocado","Avocado","Avocado",160,2,9,15,"vet"],
  ["tomato_sauce","Tomatensaus","Tomato sauce",35,1.5,6,0.3,"saus"],
  ["teriyaki","Teriyakisaus","Teriyaki sauce",89,3,16,0.1,"saus"],
  ["curry_sauce","Currysaus (light)","Curry sauce (light)",70,1.5,7,4,"saus"],
  ["pesto","Pesto","Pesto",420,4,6,43,"saus"],
  ["honey","Honing","Honey",304,0.3,82,0,"saus"],
  ["hummus","Hummus","Hummus",177,8,14,10,"saus"],
  // extra eiwit
  ["chicken_thigh","Kipdij","Chicken thigh",177,24,0,9,"vlees"],
  ["white_fish","Witvis (tilapia)","White fish (tilapia)",96,20,0,2,"vis"],
  ["meatballs_lean","Magere gehaktballen","Lean meatballs",172,19,4,9,"vlees"],
  ["seitan","Seitan","Seitan",143,25,4,2,"vega"],
  ["edamame","Edamame","Edamame",121,12,9,5,"vega"],
  ["chickpeas","Kikkererwten","Chickpeas",164,9,27,3,"peulvrucht"],
  ["black_beans","Zwarte bonen","Black beans",132,9,24,0.5,"peulvrucht"],
  ["lentils","Linzen (gekookt)","Lentils (cooked)",116,9,20,0.4,"peulvrucht"],
  // extra koolhydraat
  ["bulgur_dry","Bulgur (droog)","Bulgur (dry)",342,12,76,1.3,"granen"],
  ["pita","Volkoren pita","Wholegrain pita",275,9,55,2,"granen"],
  ["granola","Granola","Granola",471,10,64,18,"granen"],
  ["muesli","Muesli","Muesli",367,9,66,6,"granen"],
  // extra groente
  ["peas","Doperwten","Peas",81,5,14,0.4,"groente"],
  ["cauliflower","Bloemkool","Cauliflower",25,1.9,5,0.3,"groente"],
  ["kale","Boerenkool","Kale",49,4.3,9,0.9,"groente"],
  ["bok_choy","Paksoi","Bok choy",13,1.5,2.2,0.2,"groente"],
  ["green_salad","Gemengde salade","Mixed salad",20,1.4,3.5,0.3,"groente"],
  // extra fruit / snack
  ["raspberries","Frambozen","Raspberries",52,1.2,12,0.7,"fruit"],
  ["kiwi","Kiwi","Kiwi",61,1.1,15,0.5,"fruit"],
  ["orange","Sinaasappel","Orange",47,0.9,12,0.1,"fruit"],
  ["pineapple","Ananas","Pineapple",50,0.5,13,0.1,"fruit"],
  ["chia","Chiazaad","Chia seeds",486,17,42,31,"noten"],
  ["pumpkin_seeds","Pompoenpitten","Pumpkin seeds",559,30,11,49,"noten"],
  ["protein_bar","Proteïnereep","Protein bar",355,33,30,9,"supplement"],
  ["dark_choc","Pure chocolade 85%","Dark chocolate 85%",592,10,20,52,"snack"],
  ["avocado2","Avocado","Avocado",160,2,9,15,"vet"],
];
const IMAP = Object.fromEntries(ING.map((r) => [r[0], { kcal: r[3], p: r[4], c: r[5], f: r[6], nl: r[1], en: r[2], cat: r[7] }]));

// Tweetalige bereidingswijze + techniek, op basis van de naam (familie) + ingrediënt-categorieën.
function stepsFor(nameNl, items) {
  const R = items.map((it) => ({ ...IMAP[it.slug], slug: it.slug, g: it.g })).filter((x) => x.nl);
  const nlw = (x) => (x ? x.nl.toLowerCase() : "");
  const enw = (x) => (x ? x.en.toLowerCase() : "");
  const prot = R.find((x) => ["vlees", "vis", "vega", "peulvrucht"].includes(x.cat) || x.slug === "egg");
  const dairy = R.find((x) => x.cat === "zuivel" && !["egg", "egg_white", "feta", "parmesan", "mozzarella_light", "whey"].includes(x.slug));
  const carb = R.find((x) => x.cat === "granen" || ["potato", "sweet_potato"].includes(x.slug));
  const veg = R.filter((x) => x.cat === "groente" && !["potato", "sweet_potato"].includes(x.slug));
  const fruit = R.find((x) => x.cat === "fruit");
  const sauce = R.find((x) => x.cat === "saus");
  const fat = R.find((x) => ["olive_oil", "butter"].includes(x.slug));
  const feta = R.find((x) => x.slug === "feta");
  const vegNl = veg.map(nlw).join(" en ") || "wat groente";
  const vegEn = veg.map(enw).join(" and ") || "some veg";
  const n = nameNl.toLowerCase();
  const S = []; // {nl, en}
  const P = (nl, en) => S.push({ nl, en });
  let technique = "pan";
  if (/smoothie|shake/.test(n)) { technique = "blender"; P("Doe alle ingrediënten in de blender.", "Add everything to the blender."); P("Mix glad en schenk in een glas.", "Blend smooth and pour into a glass."); }
  else if (/pannenkoek/.test(n)) { P("Blend de havermout, het ei en de whey tot een glad beslag.", "Blend the oats, egg and whey into a smooth batter."); P("Bak er kleine pannenkoeken van in een licht ingevette pan.", "Cook small pancakes in a lightly greased pan."); P(fruit ? `Top met ${nlw(fruit)}.` : "Serveer direct.", fruit ? `Top with ${enw(fruit)}.` : "Serve right away."); }
  else if (/omelet/.test(n)) { P("Klop de eieren los met peper en zout.", "Whisk the eggs with salt and pepper."); P(`Bak ${vegNl} kort in de pan, giet de eieren erover en laat stollen.`, `Sauté the ${vegEn} briefly, pour in the eggs and let set.`); P(feta ? "Verkruimel de feta erover." : "Vouw dubbel en serveer.", feta ? "Crumble the feta on top." : "Fold over and serve."); }
  else if (/roerei/.test(n)) { P("Klop de eieren los.", "Whisk the eggs."); P(`Roerbak ze met ${vegNl} tot ze net gestold zijn.`, `Scramble with the ${vegEn} until just set.`); P(carb ? `Serveer met ${nlw(carb)}.` : "Serveer direct.", carb ? `Serve with the ${enw(carb)}.` : "Serve right away."); }
  else if (/overnight oats/.test(n)) { technique = "assembly"; P("Meng de havermout, melk en chia in een pot.", "Mix the oats, milk and chia in a jar."); P("Laat minimaal een nacht in de koelkast opstijven.", "Chill overnight to set."); P(fruit ? `Top de volgende ochtend met ${nlw(fruit)}.` : "Roer los en serveer.", fruit ? `Top with ${enw(fruit)} in the morning.` : "Stir and serve."); }
  else if (/muesli|granola/.test(n)) { technique = "assembly"; P(`Doe de ${dairy ? nlw(dairy) : "yoghurt"} in een kom.`, `Spoon the ${dairy ? enw(dairy) : "yoghurt"} into a bowl.`); P(`Schep de ${carb ? nlw(carb) : "muesli"} erover.`, `Add the ${carb ? enw(carb) : "muesli"} on top.`); P(fruit ? `Top met ${nlw(fruit)}.` : "Serveer direct.", fruit ? `Top with ${enw(fruit)}.` : "Serve."); }
  else if (/toast|brood|sandwich/.test(n)) { technique = "assembly"; P("Rooster of snijd het brood.", "Toast or slice the bread."); P(`Beleg met ${prot ? nlw(prot) : "je topping"}${veg.length ? " en " + vegNl : ""}.`, `Top with ${prot ? enw(prot) : "your topping"}${veg.length ? " and " + vegEn : ""}.`); P("Breng op smaak met peper en zout.", "Season with salt and pepper."); }
  else if (/wrap/.test(n)) { technique = "assembly"; P("Warm de wrap kort op.", "Warm the wrap briefly."); P(`Beleg met ${prot ? nlw(prot) : "vulling"}, ${vegNl}${dairy ? " en " + nlw(dairy) : ""}.`, `Fill with ${prot ? enw(prot) : "filling"}, ${vegEn}${dairy ? " and " + enw(dairy) : ""}.`); P("Rol strak op en snijd doormidden.", "Roll up tightly and halve."); }
  else if (/salade|caesar/.test(n)) { technique = "assembly"; P(`Meng de sla met ${vegNl}.`, `Toss the lettuce with the ${vegEn}.`); P(`Voeg ${prot ? nlw(prot) : "eiwit"} toe.`, `Add the ${prot ? enw(prot) : "protein"}.`); P(fat ? `Besprenkel met ${nlw(fat)} en breng op smaak.` : "Breng op smaak met peper en zout.", fat ? `Drizzle with ${enw(fat)} and season.` : "Season with salt and pepper."); }
  else if (/soep/.test(n)) { technique = "soup"; P("Fruit de groente kort aan.", "Sweat the vegetables briefly."); P("Voeg bouillon (en eventueel eiwit) toe en laat garen.", "Add stock (and protein if using) and simmer."); P("Pureer naar wens en serveer met het brood.", "Blend if you like and serve with the bread."); }
  else if (/poké|poke|buddha|burrito|bowl/.test(n)) { technique = "assembly"; P(carb ? `Kook de ${nlw(carb)} en laat afkoelen.` : "Maak de basis klaar.", carb ? `Cook the ${enw(carb)} and let it cool.` : "Prepare the base."); P(`Verdeel alles in een kom: ${prot ? nlw(prot) : "eiwit"}, ${vegNl}.`, `Arrange in a bowl: ${prot ? enw(prot) : "protein"}, ${vegEn}.`); P(sauce ? `Werk af met ${nlw(sauce)}.` : "Werk af naar smaak.", sauce ? `Finish with ${enw(sauce)}.` : "Finish to taste."); }
  else if (/kwark|skyr|hüttenkäse|yoghurt/.test(n) && !carb && (fruit || veg.length)) { technique = "assembly"; const top = fruit || veg[0]; P(`Doe de ${dairy ? nlw(dairy) : "kwark"} in een kom.`, `Spoon the ${dairy ? enw(dairy) : "quark"} into a bowl.`); P(fruit ? `Meng of top met ${nlw(top)}.` : `Serveer met ${nlw(top)}.`, fruit ? `Mix or top with ${enw(top)}.` : `Serve with ${enw(top)}.`); }
  else if (/kwark|skyr|yoghurt/.test(n) && carb) { technique = "assembly"; P(`Doe de ${dairy ? nlw(dairy) : "kwark"} in een kom.`, `Spoon the ${dairy ? enw(dairy) : "quark"} into a bowl.`); P(`Roer de ${nlw(carb)} erdoor.`, `Stir in the ${enw(carb)}.`); P(fruit ? `Top met ${nlw(fruit)}.` : "Serveer direct.", fruit ? `Top with ${enw(fruit)}.` : "Serve."); }
  else if (/rijstwafels/.test(n)) { technique = "assembly"; const top = R.find((x) => x.slug !== "rice_cakes"); P(top ? `Beleg de rijstwafels met ${nlw(top)}.` : "Serveer de rijstwafels.", top ? `Top the rice cakes with ${enw(top)}.` : "Serve the rice cakes."); }
  else if (/appel met|peer met|banaan met/.test(n)) { technique = "assembly"; const top = R.find((x) => x.cat !== "fruit"); P(`Snijd ${fruit ? nlw(fruit) : "het fruit"} in partjes.`, `Slice the ${fruit ? enw(fruit) : "fruit"}.`); P(top ? `Serveer met ${nlw(top)} om in te dippen.` : "Serveer direct.", top ? `Serve with ${enw(top)} to dip.` : "Serve."); }
  else if (/noten|amandelen|walnoten|pompoenpitten/.test(n)) { technique = "assembly"; P("Weeg de portie af.", "Weigh out the portion."); P("Serveer als snack tussendoor.", "Enjoy as a snack."); }
  else if (/reep/.test(n)) { technique = "assembly"; P("Pak de proteïnereep als snack onderweg.", "Grab the protein bar as an on-the-go snack."); }
  else if (/edamame/.test(n)) { P("Kook of stoom de edamame 4–5 min.", "Boil or steam the edamame 4–5 min."); P("Bestrooi met een snuf zeezout.", "Sprinkle with a pinch of sea salt."); }
  else if (/gekookte eieren/.test(n)) { P("Kook de eieren 8–9 min.", "Boil the eggs 8–9 min."); P("Pel en bestrooi met peper en zout.", "Peel and season with salt and pepper."); }
  else if (/chocolade/.test(n)) { technique = "assembly"; P("Combineer de pure chocolade met de noten als snack.", "Pair the dark chocolate with the nuts as a snack."); }
  else {
    // standaard warme maaltijd: eiwit + koolhydraat + groente
    if (carb) P(`Kook de ${nlw(carb)} volgens de verpakking.`, `Cook the ${enw(carb)} per the package.`);
    if (prot) { const isFish = prot.cat === "vis"; P(isFish ? `Bak of pocheer de ${nlw(prot)} kort tot net gaar; kruid met peper en zout.` : `Bak de ${nlw(prot)} in een pan${fat ? " met " + nlw(fat) : ""} rondom gaar; kruid met peper en zout.`, isFish ? `Sear or poach the ${enw(prot)} until just done; season with salt and pepper.` : `Pan-fry the ${enw(prot)}${fat ? " in " + enw(fat) : ""} until done; season with salt and pepper.`); }
    if (veg.length) P(`Stoom of wok ${vegNl} beetgaar.`, `Steam or stir-fry the ${vegEn} until tender-crisp.`);
    if (sauce) P(`Roer de ${nlw(sauce)} erdoor of serveer ernaast.`, `Stir in the ${enw(sauce)} or serve on the side.`);
    P("Verdeel over het bord en werk af.", "Plate up and finish.");
  }
  return {
    nl: S.map((s, i) => `${i + 1}. ${s.nl}`).join("\n"),
    en: S.map((s, i) => `${i + 1}. ${s.en}`).join("\n"),
    technique,
  };
}

function macros(items) {
  let kcal = 0, p = 0, c = 0, f = 0;
  for (const it of items) { const m = IMAP[it.slug]; const k = it.g / 100; kcal += m.kcal*k; p += m.p*k; c += m.c*k; f += m.f*k; }
  return { kcal: Math.round(kcal), p: Math.round(p), c: Math.round(c), f: Math.round(f) };
}
function goalsFor(mac) {
  const g = [];
  const pPct = (mac.p*4)/Math.max(1,mac.kcal);
  if (pPct >= 0.30 && mac.fat_ok !== false && mac.kcal <= 650) g.push("cut");
  if (mac.kcal >= 600) g.push("gain");
  g.push("maintain");
  return Array.from(new Set(g.length?g:["maintain"]));
}
function tagsFor(mac, extra=[]) {
  const t = [...extra];
  if ((mac.p*4)/Math.max(1,mac.kcal) >= 0.32) t.push("high_protein");
  return Array.from(new Set(t));
}

const dishes = [];
const used = new Set();
const slug = (s) => s.toLowerCase().normalize("NFD").replace(/[̀-ͯ]/g,"").replace(/[^a-z0-9]+/g,"_").replace(/^_|_$/g,"");
function add(name_nl, name_en, moments, items, { tags=[], prefs=[], veggie=false, vegan=false }={}) {
  const key = slug(name_en);
  if (used.has(key)) return; used.add(key);
  const mac = macros(items);
  const et = [...tags]; if (veggie) et.push("vegetarian"); if (vegan) et.push("vegan");
  const st = stepsFor(name_nl, items);
  dishes.push({ slug:key, name_nl, name_en, moments, goals: goalsFor(mac), items, tags: tagsFor(mac, et), prefs, steps: st.nl, steps_en: st.en, technique: st.technique, temp: null, mac });
}

// ---------- DINER & LUNCH warm: eiwit + koolhydraat + groente (+ saus/vet) ----------
const PROT = [
  ["chicken_breast","Kip","Chicken",160,["chickenrice","ricechicken"]],
  ["salmon","Zalm","Salmon",150,["salmonveg"]],
  ["beef_steak","Biefstuk","Steak",150,["steakpotato"]],
  ["lean_beef_5","Rundergehakt","Beef mince",130,["pastabol"]],
  ["cod","Kabeljauw","Cod",170,[]],
  ["turkey_breast","Kalkoen","Turkey",160,[]],
  ["pork_tenderloin","Varkenshaas","Pork",150,[]],
  ["shrimp","Garnalen","Shrimp",150,[]],
  ["tofu","Tofu","Tofu",150,[]],
  ["tempeh","Tempeh","Tempeh",130,[]],
  ["chicken_thigh","Kipdij","Chicken thigh",150,[]],
  ["white_fish","Witvis","White fish",170,[]],
  ["meatballs_lean","Gehaktballen","Meatballs",140,[]],
  ["seitan","Seitan","Seitan",130,[]],
];
const CARB = [
  ["rice_dry","rijst","rice",70,["chickenrice","ricechicken"]],
  ["sweet_potato","zoete aardappel","sweet potato",200,[]],
  ["potato","aardappel","potato",250,["steakpotato"]],
  ["pasta_dry","pasta","pasta",80,["pastabol"]],
  ["quinoa_dry","quinoa","quinoa",70,[]],
  ["noodles_dry","noedels","noodles",80,["woknoodles"]],
  ["couscous_dry","couscous","couscous",70,[]],
  ["bulgur_dry","bulgur","bulgur",70,[]],
  ["basmati_dry","basmatirijst","basmati rice",70,[]],
];
const VEG = [
  ["broccoli","broccoli","broccoli",120],
  ["green_beans","sperziebonen","green beans",120],
  ["spinach","spinazie","spinach",100],
  ["asparagus","asperges","asparagus",120],
  ["zucchini","courgette","zucchini",120],
  ["mixed_veg","wokgroente","stir-fry veg",150],
  ["mushroom","champignons","mushrooms",100],
  ["carrot","wortel","carrot",120],
  ["peas","doperwten","peas",100],
  ["cauliflower","bloemkool","cauliflower",120],
  ["kale","boerenkool","kale",100],
  ["bok_choy","paksoi","bok choy",120],
];
const isVegProt = (p)=>["tofu","tempeh"].includes(p);
for (const [ps,pnl,pen,pg,pprefs] of PROT) {
  for (const [cs,cnl,cen,cg,cprefs] of CARB) {
    for (const [vs,vnl,ven,vg] of VEG) {
      // beperk de explosie: alleen zinnige carb per eiwit + 3 groentes elk
      if ((ps==="salmon"||ps==="cod") && ["pasta_dry","noodles_dry"].includes(cs)) continue;
      const items = [{slug:ps,g:pg},{slug:cs,g:cg},{slug:vs,g:vg},{slug:"olive_oil",g:7}];
      const nameNl = `${pnl} met ${cnl} & ${vnl}`;
      const nameEn = `${pen} with ${cen} & ${ven}`;
      const prefs = Array.from(new Set([...pprefs,...cprefs]));
      add(nameNl,nameEn,["dinner","lunch"],items,{prefs,veggie:isVegProt(ps),vegan:isVegProt(ps)});
    }
  }
}

// ---------- Saus-varianten op kip/garnaal + rijst/noedels ----------
for (const [ss,snl,sen,sg,sprefs] of [["teriyaki","teriyaki","teriyaki",35,[]],["curry_sauce","curry","curry",60,["curryrice"]],["tomato_sauce","tomaten","tomato",80,[]]]) {
  for (const [ps,pnl,pen,pg] of [["chicken_breast","Kip","Chicken",160],["shrimp","Garnalen","Shrimp",150],["tofu","Tofu","Tofu",150]]) {
    for (const [cs,cnl,cen,cg] of [["rice_dry","rijst","rice",70],["noodles_dry","noedels","noodles",80]]) {
      const items=[{slug:ps,g:pg},{slug:cs,g:cg},{slug:"mixed_veg",g:140},{slug:ss,g:sg}];
      add(`${pnl}-${snl} met ${cnl}`,`${pen} ${sen} with ${cen}`,["dinner","lunch"],items,{prefs:sprefs,veggie:ps==="tofu",vegan:ps==="tofu"});
    }
  }
}

// ---------- Pasta bolognese familie ----------
for (const [ps,pnl,pen] of [["lean_beef_5","Rundergehakt","Beef"],["turkey_breast","Kalkoen","Turkey"],["tofu","Tofu","Tofu"]]) {
  add(`Pasta bolognese (${pnl.toLowerCase()})`,`Bolognese pasta (${pen.toLowerCase()})`,["dinner","lunch"],
    [{slug:"pasta_dry",g:80},{slug:ps,g:120},{slug:"tomato_sauce",g:120},{slug:"mushroom",g:60}],{prefs:["pastabol"],veggie:ps==="tofu",vegan:ps==="tofu"});
}

// ---------- LUNCH koud: wraps / salades / brood ----------
for (const [ps,pnl,pen,pg] of [["chicken_breast","Kipfilet","Chicken",120],["tuna_water","Tonijn","Tuna",100],["egg","Ei","Egg",100],["feta","Feta","Feta",40],["shrimp","Garnalen","Shrimp",100],["tofu","Tofu","Tofu",120]]) {
  // wrap
  add(`${pnl}-wrap`,`${pen} wrap`,["lunch"],[{slug:ps,g:pg},{slug:"wrap_whole",g:60},{slug:"bell_pepper",g:60},{slug:"low_yoghurt",g:30}],{prefs:["chickenwrap"].filter(()=>ps==="chicken_breast"),veggie:["egg","feta","tofu"].includes(ps),vegan:ps==="tofu"});
  // salade
  add(`Salade met ${pnl.toLowerCase()}`,`${pen} salad`,["lunch"],[{slug:ps,g:pg},{slug:"romaine",g:80},{slug:"cucumber",g:70},{slug:"tomato",g:70},{slug:"olive_oil",g:8}],{prefs:(ps==="tuna_water"?["tunasalad"]:ps==="egg"?["saladegg"]:[]),veggie:["egg","feta","tofu"].includes(ps),vegan:ps==="tofu"});
  // volkoren brood
  add(`Volkoren brood met ${pnl.toLowerCase()}`,`Wholegrain sandwich with ${pen.toLowerCase()}`,["lunch"],[{slug:ps,g:pg},{slug:"bread_whole",g:80},{slug:"cucumber",g:50},{slug:"low_yoghurt",g:20}],{prefs:["sandwich"],veggie:["egg","feta","tofu"].includes(ps),vegan:ps==="tofu"});
}

// ---------- ONTBIJT ----------
const BERRY=[["blueberries","blauwe bessen","blueberries"],["strawberries","aardbeien","strawberries"],["banana","banaan","banana"],["mango","mango","mango"],["apple","appel","apple"]];
for (const base of [["skyr","Skyr","Skyr"],["quark_low","Kwark","Quark"],["greek_yoghurt","Griekse yoghurt","Greek yoghurt"]]) {
  for (const [bs,bnl,ben] of BERRY) {
    add(`${base[1]} met havermout & ${bnl}`,`${base[2]} with oats & ${ben}`,["breakfast","snack"],
      [{slug:base[0],g:200},{slug:"oats",g:50},{slug:bs,g:60}],{prefs:["gyoghurt","quarkfruit"],veggie:true});
  }
}
// havermout-bowls
for (const [bs,bnl,ben] of BERRY) {
  add(`Havermout met ${bnl} & whey`,`Oats with ${ben} & whey`,["breakfast"],[{slug:"oats",g:60},{slug:"skim_milk",g:200},{slug:"whey",g:25},{slug:bs,g:60}],{prefs:["oats"],veggie:true});
}
// eiwit-pannenkoek varianten
for (const [bs,bnl,ben] of [["banana","banaan","banana"],["blueberries","blauwe bessen","blueberries"]]) {
  add(`Proteïne-pannenkoek met ${bnl}`,`Protein pancake with ${ben}`,["breakfast"],[{slug:"oats",g:60},{slug:"egg",g:50},{slug:"whey",g:30},{slug:bs,g:60}],{prefs:["protpancake"],veggie:true});
}
// omeletten
for (const [vs,vnl,ven] of [["spinach","spinazie","spinach"],["mushroom","champignons","mushrooms"],["bell_pepper","paprika","bell pepper"],["tomato","tomaat","tomato"]]) {
  add(`Omelet met ${vnl} & feta`,`Omelette with ${ven} & feta`,["breakfast"],[{slug:"egg",g:150},{slug:vs,g:60},{slug:"feta",g:30},{slug:"olive_oil",g:5}],{prefs:["omelet","eggs"],veggie:true});
  add(`Roerei met ${vnl}`,`Scrambled eggs with ${ven}`,["breakfast"],[{slug:"egg",g:150},{slug:vs,g:70},{slug:"bread_whole",g:40}],{prefs:["eggs"],veggie:true});
}
// cottage/skyr op brood
add("Volkoren brood met hüttenkäse","Wholegrain bread with cottage cheese",["breakfast"],[{slug:"bread_whole",g:80},{slug:"cottage",g:100},{slug:"tomato",g:50}],{prefs:["wholebread"],veggie:true});

// ---------- SNACKS ----------
add("Eiwitshake met banaan","Protein shake with banana",["snack"],[{slug:"whey",g:30},{slug:"banana",g:80},{slug:"skim_milk",g:200}],{prefs:["shake"],veggie:true});
add("Eiwitshake met aardbei","Protein shake with strawberry",["snack"],[{slug:"whey",g:30},{slug:"strawberries",g:100},{slug:"skim_milk",g:200}],{prefs:["shake"],veggie:true});
for (const [bs,bnl,ben] of BERRY) add(`Kwark met ${bnl}`,`Quark with ${ben}`,["snack"],[{slug:"quark_low",g:150},{slug:bs,g:60}],{prefs:["quark"],veggie:true});
add("Skyr met honing","Skyr with honey",["snack"],[{slug:"skyr",g:150},{slug:"honey",g:15}],{prefs:["quark"],veggie:true});
add("Handje amandelen","Handful of almonds",["snack"],[{slug:"almonds",g:30}],{prefs:["nuts"],veggie:true,vegan:true});
add("Handje walnoten","Handful of walnuts",["snack"],[{slug:"walnuts",g:30}],{prefs:["nuts"],veggie:true,vegan:true});
add("Rijstwafels met pindakaas","Rice cakes with peanut butter",["snack"],[{slug:"rice_cakes",g:20},{slug:"peanut_butter",g:20}],{prefs:["ricecakepb"],veggie:true,vegan:true});
add("Rijstwafels met hummus","Rice cakes with hummus",["snack"],[{slug:"rice_cakes",g:20},{slug:"hummus",g:40}],{prefs:["ricecakepb"],veggie:true,vegan:true});
add("Appel met pindakaas","Apple with peanut butter",["snack"],[{slug:"apple",g:150},{slug:"peanut_butter",g:20}],{prefs:["fruit"],veggie:true,vegan:true});
add("Hüttenkäse met komkommer","Cottage cheese with cucumber",["snack"],[{slug:"cottage",g:150},{slug:"cucumber",g:80}],{prefs:["quark"],veggie:true});

// ---------- BOWLS (lunch/diner) ----------
const BOWLFRUITVEG=[["cucumber","komkommer","cucumber"],["carrot","wortel","carrot"],["edamame","edamame","edamame"]];
for (const [ps,pnl,pen,pg] of [["salmon","Zalm","Salmon",120],["tuna_water","Tonijn","Tuna",100],["chicken_breast","Kip","Chicken",120],["tofu","Tofu","Tofu",120],["shrimp","Garnalen","Shrimp",110]]) {
  for (const [vs,vnl,ven] of BOWLFRUITVEG) {
    add(`Poké bowl met ${pnl.toLowerCase()} & ${vnl}`,`Poké bowl with ${pen.toLowerCase()} & ${ven}`,["lunch","dinner"],
      [{slug:ps,g:pg},{slug:"rice_dry",g:65},{slug:vs,g:80},{slug:"edamame",g:50},{slug:"teriyaki",g:20}],{prefs:["poke"],veggie:["tofu"].includes(ps),vegan:["tofu"].includes(ps)});
  }
}
for (const [ps,pnl,pen,pg] of [["chicken_breast","kip","chicken",120],["chickpeas","kikkererwten","chickpeas",120],["black_beans","zwarte bonen","black beans",120],["seitan","seitan","seitan",110]]) {
  add(`Buddha bowl met ${pnl}`,`Buddha bowl with ${pen}`,["lunch","dinner"],
    [{slug:ps.length?ps:"chickpeas",g:pg},{slug:"quinoa_dry",g:65},{slug:"green_salad",g:80},{slug:"bell_pepper",g:60},{slug:"hummus",g:40}],{prefs:[],veggie:["chickpeas","black_beans","seitan"].includes(ps),vegan:["chickpeas","black_beans","seitan"].includes(ps)});
  add(`Burrito bowl met ${pnl}`,`Burrito bowl with ${pen}`,["lunch","dinner"],
    [{slug:ps,g:pg},{slug:"rice_dry",g:65},{slug:"black_beans",g:60},{slug:"tomato",g:60},{slug:"avocado",g:40}],{prefs:[],veggie:["chickpeas","black_beans","seitan"].includes(ps),vegan:["chickpeas","black_beans","seitan"].includes(ps)});
}

// ---------- SMOOTHIES / OVERNIGHT OATS / MUESLI (ontbijt) ----------
const FR=[["banana","banaan","banana"],["blueberries","blauwe bessen","blueberries"],["strawberries","aardbeien","strawberries"],["mango","mango","mango"],["raspberries","frambozen","raspberries"],["kiwi","kiwi","kiwi"],["pineapple","ananas","pineapple"]];
for (const [fs,fnl,fen] of FR) {
  add(`Smoothie met ${fnl} & whey`,`Smoothie with ${fen} & whey`,["breakfast","snack"],[{slug:"skim_milk",g:250},{slug:fs,g:100},{slug:"whey",g:25},{slug:"oats",g:30}],{prefs:["smoothie"],veggie:true});
  add(`Overnight oats met ${fnl}`,`Overnight oats with ${fen}`,["breakfast"],[{slug:"oats",g:60},{slug:"skim_milk",g:180},{slug:"chia",g:12},{slug:fs,g:70}],{prefs:["oats"],veggie:true});
  add(`Muesli met yoghurt & ${fnl}`,`Muesli with yoghurt & ${fen}`,["breakfast"],[{slug:"muesli",g:55},{slug:"greek_yoghurt",g:150},{slug:fs,g:60}],{prefs:[],veggie:true});
  add(`Granola met skyr & ${fnl}`,`Granola with skyr & ${fen}`,["breakfast","snack"],[{slug:"granola",g:45},{slug:"skyr",g:150},{slug:fs,g:60}],{prefs:[],veggie:true});
}
// toast-varianten
add("Volkoren toast met avocado & ei","Wholegrain toast with avocado & egg",["breakfast"],[{slug:"bread_whole",g:70},{slug:"avocado",g:60},{slug:"egg",g:100}],{prefs:["wholebread"],veggie:true});
add("Volkoren toast met pindakaas & banaan","Wholegrain toast with peanut butter & banana",["breakfast"],[{slug:"bread_whole",g:70},{slug:"peanut_butter",g:20},{slug:"banana",g:80}],{prefs:["wholebread"],veggie:true,vegan:true});
add("Volkoren toast met hummus & ei","Wholegrain toast with hummus & egg",["breakfast"],[{slug:"bread_whole",g:70},{slug:"hummus",g:40},{slug:"egg",g:100}],{prefs:["wholebread"],veggie:true});
add("Volkoren toast met kwark & aardbei","Wholegrain toast with quark & strawberry",["breakfast"],[{slug:"bread_whole",g:70},{slug:"quark_low",g:80},{slug:"strawberries",g:60}],{prefs:["wholebread"],veggie:true});

// ---------- SNACKS extra ----------
for (const [fs,fnl,fen] of FR) {
  add(`Skyr met ${fnl}`,`Skyr with ${fen}`,["snack"],[{slug:"skyr",g:150},{slug:fs,g:70}],{prefs:["quark"],veggie:true});
  add(`Hüttenkäse met ${fnl}`,`Cottage cheese with ${fen}`,["snack"],[{slug:"cottage",g:150},{slug:fs,g:70}],{prefs:["quark"],veggie:true});
}
add("Proteïnereep","Protein bar",["snack"],[{slug:"protein_bar",g:60}],{prefs:["bar"],veggie:true});
add("Edamame met zeezout","Edamame with sea salt",["snack"],[{slug:"edamame",g:150}],{prefs:[],veggie:true,vegan:true});
add("Pure chocolade met amandelen","Dark chocolate with almonds",["snack"],[{slug:"dark_choc",g:20},{slug:"almonds",g:20}],{prefs:["nuts"],veggie:true,vegan:true});
add("Pompoenpitten","Pumpkin seeds",["snack"],[{slug:"pumpkin_seeds",g:30}],{prefs:["nuts"],veggie:true,vegan:true});
add("Twee gekookte eieren","Two boiled eggs",["snack"],[{slug:"egg",g:120}],{prefs:[],veggie:true});
add("Geroosterde kikkererwten","Roasted chickpeas",["snack"],[{slug:"chickpeas",g:120}],{prefs:[],veggie:true,vegan:true});
add("Griekse yoghurt met granola","Greek yoghurt with granola",["snack"],[{slug:"greek_yoghurt",g:150},{slug:"granola",g:30}],{prefs:[],veggie:true});
add("Appel met amandelen","Apple with almonds",["snack"],[{slug:"apple",g:150},{slug:"almonds",g:20}],{prefs:["fruit"],veggie:true,vegan:true});

// ---------- SOEPEN (lunch) ----------
for (const [vs,vnl,ven] of [["tomato","tomaten","tomato"],["cauliflower","bloemkool","cauliflower"],["mushroom","champignon","mushroom"],["carrot","wortel","carrot"]]) {
  add(`${vnl[0].toUpperCase()+vnl.slice(1)}soep met kip`,`${ven[0].toUpperCase()+ven.slice(1)} soup with chicken`,["lunch"],[{slug:vs,g:250},{slug:"chicken_breast",g:100},{slug:"bread_whole",g:40},{slug:"olive_oil",g:5}],{prefs:["soup"]});
  add(`${vnl[0].toUpperCase()+vnl.slice(1)}soep met linzen`,`${ven[0].toUpperCase()+ven.slice(1)} soup with lentils`,["lunch"],[{slug:vs,g:250},{slug:"lentils",g:120},{slug:"bread_whole",g:40}],{prefs:["soup"],veggie:true,vegan:true});
}

// ---------- SQL ----------
const usedSlugs = new Set(); dishes.forEach(d=>d.items.forEach(it=>usedSlugs.add(it.slug)));
const esc = (s)=>s.replace(/'/g,"''");
let sql = "-- AUTO-GEGENEREERD: ingrediënten + gerechten (core). Draai NA dish-library.sql.\nbegin;\n";
sql += "insert into public.ingredients (slug,name_nl,name_en,kcal,protein,carbs,fat,category,source) values\n";
sql += ING.filter(r=>usedSlugs.has(r[0])).map(r=>`('${r[0]}','${esc(r[1])}','${esc(r[2])}',${r[3]},${r[4]},${r[5]},${r[6]},'${r[7]}','core')`).join(",\n");
sql += "\non conflict (slug) do nothing;\n\n";
sql += "insert into public.dishes (slug,name_nl,name_en,moments,goals,items,tags,prefs,steps,steps_en,technique,temp,source) values\n";
sql += dishes.map(d=>`('${d.slug}','${esc(d.name_nl)}','${esc(d.name_en)}',ARRAY[${d.moments.map(m=>`'${m}'`).join(",")}],ARRAY[${d.goals.map(g=>`'${g}'`).join(",")}],'${JSON.stringify(d.items.map(it=>({slug:it.slug,g:it.g})))}'::jsonb,ARRAY[${d.tags.map(t=>`'${t}'`).join(",")}]::text[],ARRAY[${d.prefs.map(p=>`'${p}'`).join(",")}]::text[],'${esc(d.steps)}','${esc(d.steps_en||"")}','${esc(d.technique||"")}',${d.temp?`'${esc(d.temp)}'`:"null"},'core')`).join(",\n");
sql += "\non conflict (slug) do update set name_nl=excluded.name_nl,name_en=excluded.name_en,moments=excluded.moments,goals=excluded.goals,items=excluded.items,tags=excluded.tags,prefs=excluded.prefs,steps=excluded.steps,steps_en=excluded.steps_en,technique=excluded.technique,temp=excluded.temp;\ncommit;\n";

writeFileSync(new URL("./seed.sql", import.meta.url), sql);

// rapport
const byMoment = {breakfast:0,lunch:0,dinner:0,snack:0};
dishes.forEach(d=>d.moments.forEach(m=>byMoment[m]++));
console.log("ingrediënten gebruikt:", usedSlugs.size, "/", ING.length);
console.log("gerechten totaal:", dishes.length);
console.log("per moment (overlap telt dubbel):", byMoment);
// sanity: een paar macro's
["tuna_salad","chicken_wrap","salmon_with_sweet_potato_green_beans","skyr_with_oats_blueberries"].forEach(()=>{});
const sample = dishes.slice(0,3).concat(dishes.filter(d=>d.prefs.includes("salmonveg")).slice(0,1));
sample.forEach(d=>console.log("  •",d.name_en,"→",d.mac.kcal+"kcal",d.mac.p+"p/"+d.mac.c+"c/"+d.mac.f+"f","["+d.moments.join(",")+"] goals:"+d.goals.join("/")));
