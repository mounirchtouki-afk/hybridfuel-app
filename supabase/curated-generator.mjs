// ============================================================================
// GECUREERDE recepten-bibliotheek voor HybridFuel — handgeschreven, vetarm,
// sporter-geschikt. Elk gerecht is coherent (elk ingrediënt hoort erbij) met
// echte bereiding. Vervangt de oude combinatorische generator.
// Macro's worden server-side berekend uit de ingrediënten (view dish_macros).
// Draai dit NA dish-library.sql. De seed ruimt de oude core-set op.
// ============================================================================
import { writeFileSync } from "node:fs";

// ---------- INGREDIËNTEN (per 100 g/ml) ----------
const ING = [
  // eiwit — mager waar het kan
  ["chicken_breast","Kipfilet","Chicken breast",120,23,0,2.6,"vlees"],
  ["chicken_thigh","Kipdij","Chicken thigh",150,19,0,8,"vlees"],
  ["turkey_breast","Kalkoenfilet","Turkey breast",110,24,0,1.5,"vlees"],
  ["beef_lean","Mager rundvlees","Lean beef",150,21,0,7,"vlees"],
  ["beef_mince5","Rundergehakt 5%","Beef mince 5%",137,21,0,5,"vlees"],
  ["rosbief","Rosbief","Roast beef",120,22,0,3,"vlees"],
  ["cod","Kabeljauw","Cod",82,18,0,0.7,"vis"],
  ["white_fish","Witvis","White fish",85,18,0,1,"vis"],
  ["salmon","Zalm","Salmon",208,20,0,13,"vis"],
  ["smoked_salmon","Gerookte zalm","Smoked salmon",180,22,0,10,"vis"],
  ["tuna_can","Tonijn (uit blik)","Tuna (canned)",100,23,0,1,"vis"],
  ["shrimp","Garnalen","Shrimp",85,20,0,1,"vis"],
  ["egg","Ei","Egg",143,13,1,10,"ei"],
  ["egg_white","Eiwit","Egg white",52,11,0.7,0.2,"ei"],
  ["skyr","Skyr","Skyr",63,11,4,0.2,"zuivel"],
  ["quark_lowfat","Magere kwark","Low-fat quark",57,10,4,0.3,"zuivel"],
  ["cottage","Hüttenkäse","Cottage cheese",85,12,3,2,"zuivel"],
  ["greek_yoghurt","Magere Griekse yoghurt","Low-fat Greek yoghurt",59,10,4,0.4,"zuivel"],
  ["yoghurt_lowfat","Magere yoghurt","Low-fat yoghurt",42,4,6,0.1,"zuivel"],
  ["milk_semi","Halfvolle melk","Semi-skimmed milk",47,3.4,4.8,1.5,"zuivel"],
  ["feta_light","Feta (light)","Feta (light)",160,14,2,10,"zuivel"],
  ["whey","Whey-eiwitpoeder","Whey protein",380,78,8,6,"zuivel"],
  ["tofu","Tofu","Tofu",120,13,1,7,"vega"],
  ["tempeh","Tempeh","Tempeh",192,20,8,11,"vega"],
  ["edamame","Edamame","Edamame",121,12,9,5,"peulvrucht"],
  ["lentils","Linzen (gekookt)","Lentils (cooked)",116,9,20,0.4,"peulvrucht"],
  ["chickpeas","Kikkererwten (gekookt)","Chickpeas (cooked)",164,9,27,2.6,"peulvrucht"],
  ["kidney_beans","Kidneybonen","Kidney beans",127,9,22,0.5,"peulvrucht"],
  // zetmeel / granen
  ["oats","Havermout","Oats",371,13,59,7,"granen"],
  ["rice_dry","Rijst (droog)","Rice (dry)",360,7,78,1,"granen"],
  ["pasta_whole","Volkoren pasta (droog)","Whole-wheat pasta (dry)",350,13,63,2.5,"granen"],
  ["couscous","Couscous (droog)","Couscous (dry)",376,13,77,1.6,"granen"],
  ["quinoa","Quinoa (droog)","Quinoa (dry)",368,14,64,6,"granen"],
  ["bread_whole","Volkorenbrood","Wholegrain bread",247,9,41,3.5,"granen"],
  ["wrap_whole","Volkoren wrap","Wholegrain wrap",300,9,49,6,"granen"],
  ["crackers_whole","Volkoren crackers","Wholegrain crackers",380,11,66,8,"granen"],
  ["rice_cakes","Rijstwafels","Rice cakes",387,8,81,3,"granen"],
  ["potato","Aardappel","Potato",77,2,17,0.1,"granen"],
  ["sweet_potato","Zoete aardappel","Sweet potato",86,1.6,20,0.1,"granen"],
  // fruit
  ["banana","Banaan","Banana",89,1.1,23,0.3,"fruit"],
  ["apple","Appel","Apple",52,0.3,14,0.2,"fruit"],
  ["blueberries","Blauwe bessen","Blueberries",57,0.7,14,0.3,"fruit"],
  ["strawberry","Aardbeien","Strawberries",33,0.7,8,0.3,"fruit"],
  ["mixed_berries","Bosvruchten","Mixed berries",45,1,10,0.3,"fruit"],
  // groente
  ["broccoli","Broccoli","Broccoli",34,2.8,7,0.4,"groente"],
  ["green_beans","Sperziebonen","Green beans",31,1.8,7,0.2,"groente"],
  ["spinach","Spinazie","Spinach",23,2.9,3.6,0.4,"groente"],
  ["paprika","Paprika","Bell pepper",31,1,6,0.3,"groente"],
  ["cucumber","Komkommer","Cucumber",15,0.7,3.6,0.1,"groente"],
  ["tomato","Tomaat","Tomato",18,0.9,3.9,0.2,"groente"],
  ["cherry_tomato","Cherrytomaat","Cherry tomato",18,0.9,3.9,0.2,"groente"],
  ["zucchini","Courgette","Zucchini",17,1.2,3.1,0.3,"groente"],
  ["carrot","Wortel","Carrot",41,0.9,10,0.2,"groente"],
  ["lettuce","Sla","Lettuce",15,1.4,2.9,0.2,"groente"],
  ["sugarsnap","Sugarsnaps","Sugar snaps",42,2.8,7.5,0.2,"groente"],
  ["peas","Doperwten","Peas",81,5,14,0.4,"groente"],
  ["onion","Ui","Onion",40,1.1,9,0.1,"groente"],
  ["mushroom","Champignons","Mushrooms",22,3,3.3,0.3,"groente"],
  ["corn","Mais","Corn",86,3.2,19,1.2,"groente"],
  // vet / smaak / saus
  ["olive_oil","Olijfolie","Olive oil",884,0,0,100,"vet"],
  ["almonds","Amandelen","Almonds",579,21,22,49,"noten"],
  ["walnuts","Walnoten","Walnuts",654,15,14,65,"noten"],
  ["chia","Chiazaad","Chia seeds",486,17,42,31,"noten"],
  ["honey","Honing","Honey",304,0,82,0,"overig"],
  ["teriyaki","Teriyakisaus","Teriyaki sauce",89,3,15,0,"overig"],
  ["soy_sauce","Sojasaus","Soy sauce",60,6,6,0,"overig"],
  ["hummus_light","Hummus (light)","Hummus (light)",170,8,15,8,"overig"],
  ["mustard","Mosterd","Mustard",66,4,5,3,"overig"],
  ["satay_light","Satésaus (light)","Satay sauce (light)",150,7,10,9,"overig"],
  // blok 2
  ["flat_iron","Flat iron steak","Flat iron steak",160,22,0,8,"vlees"],
  ["avocado","Avocado","Avocado",160,2,9,15,"vet"],
  ["rice_yellow","Gele rijst (droog)","Yellow rice (dry)",360,7,78,1,"granen"],
  ["sourdough","Desembrood","Sourdough bread",250,9,48,1.5,"granen"],
  ["low_fat_cheese","Magere kaas","Low-fat cheese",240,27,0,14,"zuivel"],
  ["red_onion","Rode ui","Red onion",40,1.1,9,0.1,"groente"],
  ["celery","Selderij","Celery",16,0.7,3,0.2,"groente"],
  ["spring_onion","Bosui","Spring onion",32,1.8,7,0.2,"groente"],
  ["olives","Olijven","Olives",115,0.8,6,11,"vet"],
  ["ketjap_manis","Ketjap manis","Sweet soy sauce",250,2,60,0,"overig"],
  ["dark_choc70","Pure chocolade 70%","Dark chocolate 70%",600,8,46,42,"overig"],
  // blok 3
  ["chicken_mince","Kipgehakt","Chicken mince",143,17,0,8,"vlees"],
  ["ham_lean","Magere ham","Lean ham",110,21,1,2,"vlees"],
  ["brown_rice","Zilvervliesrijst (droog)","Brown rice (dry)",360,8,76,2.5,"granen"],
  ["noodles_whole","Volkoren noedels (droog)","Whole-wheat noodles (dry)",350,13,65,2,"granen"],
  ["rice_noodles","Rijstnoedels (droog)","Rice noodles (dry)",360,3,83,0.5,"granen"],
  ["bulgur","Bulgur (droog)","Bulgur (dry)",342,12,63,1.3,"granen"],
  ["pita_whole","Volkoren pita","Wholegrain pita",260,10,49,2.5,"granen"],
  ["black_beans","Zwarte bonen","Black beans",132,9,24,0.5,"peulvrucht"],
  ["cauliflower","Bloemkool","Cauliflower",25,1.9,5,0.3,"groente"],
  ["eggplant","Aubergine","Eggplant",25,1,6,0.2,"groente"],
  ["leek","Prei","Leek",31,1.5,6,0.3,"groente"],
  ["asparagus","Asperges","Asparagus",20,2.2,4,0.1,"groente"],
  ["rocket","Rucola","Rocket",25,2.6,3.7,0.7,"groente"],
  ["mango","Mango","Mango",60,0.8,15,0.4,"fruit"],
  ["raspberry","Frambozen","Raspberries",52,1.2,12,0.7,"fruit"],
  ["pear","Peer","Pear",57,0.4,15,0.1,"fruit"],
  ["orange","Sinaasappel","Orange",47,0.9,12,0.1,"fruit"],
  ["kiwi","Kiwi","Kiwi",61,1.1,15,0.5,"fruit"],
  ["dates","Dadels","Dates",282,2,75,0.4,"fruit"],
  ["coconut_light","Kokosmelk (light)","Coconut milk (light)",73,0.6,2,7,"overig"],
  ["curry_paste","Currypasta","Curry paste",110,2,10,6,"overig"],
  ["passata","Tomatenpassata","Tomato passata",35,1.5,6,0.3,"groente"],
  ["pesto","Pesto","Pesto",300,4,4,30,"vet"],
  ["mozzarella_light","Mozzarella (light)","Mozzarella (light)",170,20,2,9,"zuivel"],
  ["cashew","Cashewnoten","Cashews",553,18,30,44,"noten"],
  ["pumpkin_seeds","Pompoenpitten","Pumpkin seeds",559,30,11,49,"noten"],
  ["peanut_butter","Pindakaas","Peanut butter",588,25,20,50,"noten"],
  // blok 4
  ["turkey_mince","Kalkoengehakt","Turkey mince",150,18,0,8,"vlees"],
  ["seitan","Seitan","Seitan",120,21,4,2,"vega"],
  ["polenta","Polenta","Polenta",85,2,18,0.4,"granen"],
  ["butternut","Pompoen (butternut)","Butternut squash",45,1,12,0.1,"groente"],
  ["beetroot","Rode biet","Beetroot",43,1.6,10,0.2,"groente"],
  ["fennel","Venkel","Fennel",31,1.2,7,0.2,"groente"],
  ["brussels_sprouts","Spruitjes","Brussels sprouts",43,3.4,9,0.3,"groente"],
  ["bok_choy","Paksoi","Bok choy",13,1.5,2.2,0.2,"groente"],
  ["bean_sprouts","Taugé","Bean sprouts",23,3,4,0.1,"groente"],
  ["pineapple","Ananas","Pineapple",50,0.5,13,0.1,"fruit"],
  ["grapes","Druiven","Grapes",69,0.7,18,0.2,"fruit"],
  ["soy_yoghurt","Sojayoghurt","Soy yoghurt",50,4,5,2,"zuivel"],
  ["oat_milk","Havermelk","Oat milk",45,1,7,1.5,"overig"],
  ["harissa","Harissa","Harissa",70,3,10,2,"overig"],
  ["miso","Miso","Miso",199,12,26,6,"overig"],
  ["sesame","Sesamzaad","Sesame seeds",573,18,23,50,"noten"],
  // blok 5
  ["tuna_steak","Tonijnsteak","Tuna steak",130,28,0,1,"vis"],
  ["sea_bass","Zeebaars","Sea bass",100,20,0,2,"vis"],
  ["white_beans","Witte bonen","White beans",127,8,21,0.5,"peulvrucht"],
  ["radish","Radijs","Radish",16,0.7,3,0.1,"groente"],
  ["gochujang","Gochujang","Gochujang",165,4,34,2,"overig"],
  ["granola","Granola","Granola",450,8,64,14,"granen"],
];
const IMAP = {}; ING.forEach((r) => { IMAP[r[0]] = { nl: r[1], en: r[2], kcal: r[3], p: r[4], c: r[5], f: r[6], cat: r[7] }; });

const slugify = (s) => s.toLowerCase().normalize("NFD").replace(/[̀-ͯ]/g, "").replace(/[^a-z0-9]+/g, "_").replace(/^_|_$/g, "");
function macros(items) { let k = 0, p = 0, c = 0, f = 0; for (const it of items) { const m = IMAP[it.slug]; const q = it.g / 100; k += m.kcal * q; p += m.p * q; c += m.c * q; f += m.f * q; } return { kcal: Math.round(k), p: Math.round(p), c: Math.round(c), f: Math.round(f) }; }
function goalsFor(m) { const g = []; const ratio = (m.p * 4) / Math.max(1, m.kcal); if (ratio >= 0.30 && m.kcal <= 650) g.push("cut"); if (m.kcal >= 560) g.push("gain"); g.push("maintain"); return [...new Set(g)]; }

const dishes = [];
const used = new Set();
function add(nl, en, moments, items, o = {}) {
  const key = slugify(en); if (used.has(key)) throw new Error("dubbele slug: " + key); used.add(key);
  const m = macros(items);
  const ratio = (m.p * 4) / Math.max(1, m.kcal);
  const tags = ["sport"];
  if (ratio >= 0.30) tags.push("high_protein");
  if (o.veg || o.vegan) tags.push("vegetarian");
  if (o.vegan) tags.push("vegan");
  if (o.tech === "sousvide") tags.push("sousvide");
  const st = o.steps || { nl: [], en: [] };
  dishes.push({
    slug: key, nl, en, moments, goals: goalsFor(m), items,
    tags, prefs: o.prefs || [],
    steps: st.nl.map((s, i) => (i + 1) + ". " + s).join("\n"),
    steps_en: st.en.map((s, i) => (i + 1) + ". " + s).join("\n"),
    technique: o.tech || "pan", temp: o.temp || null, mac: m,
  });
}

// ========================= ONTBIJT =========================
add("Kwark-havermoutbowl met banaan & kaneel","Quark & oat bowl with banana & cinnamon",["breakfast"],
  [{slug:"quark_lowfat",g:250},{slug:"oats",g:50},{slug:"banana",g:100}],
  {veg:true,steps:{nl:["Roer de havermout door de kwark en laat 'm 10 min (of een nacht) wellen.","Schep in een kom.","Beleg met schijfjes banaan en een snuf kaneel."],en:["Stir the oats through the quark and let it soak 10 min (or overnight).","Spoon into a bowl.","Top with banana slices and a pinch of cinnamon."]}});

add("Skyr met havermout, aardbei & honing","Skyr with oats, strawberry & honey",["breakfast"],
  [{slug:"skyr",g:250},{slug:"oats",g:45},{slug:"strawberry",g:80},{slug:"honey",g:10}],
  {veg:true,steps:{nl:["Meng de skyr met de havermout.","Schep in een kom en top met de aardbeien.","Druppel de honing erover."],en:["Mix the skyr with the oats.","Spoon into a bowl and top with the strawberries.","Drizzle the honey over."]}});

add("Omelet met kipfilet, paprika & volkorenbrood","Omelette with chicken, pepper & wholegrain bread",["breakfast"],
  [{slug:"egg",g:100},{slug:"egg_white",g:90},{slug:"chicken_breast",g:60},{slug:"paprika",g:60},{slug:"bread_whole",g:60}],
  {steps:{nl:["Klop het ei met het eiwit los, breng op smaak met peper en zout.","Bak de in reepjes gesneden kipfilet en paprika kort in een antiaanbakpan.","Giet het ei erbij en laat de omelet op laag vuur stollen.","Serveer met het geroosterde volkorenbrood."],en:["Whisk the egg with the egg white, season with salt and pepper.","Briefly fry the sliced chicken and pepper in a non-stick pan.","Pour in the egg and let the omelette set on low heat.","Serve with the toasted wholegrain bread."]}});

add("Volkoren wrap met roerei, spinazie & tomaat","Wholegrain wrap with scrambled egg, spinach & tomato",["breakfast"],
  [{slug:"egg",g:100},{slug:"egg_white",g:60},{slug:"spinach",g:40},{slug:"tomato",g:60},{slug:"wrap_whole",g:60}],
  {veg:true,steps:{nl:["Klop het ei met het eiwit los.","Roerbak de spinazie kort tot die slinkt, giet het ei erbij en roer tot een zacht roerei.","Warm de wrap, beleg met het roerei en plakjes tomaat.","Rol strak op en snijd doormidden."],en:["Whisk the egg with the egg white.","Stir-fry the spinach until wilted, add the egg and stir to soft scrambled egg.","Warm the wrap, fill with the scrambled egg and tomato slices.","Roll up tightly and halve."]}});

add("Havermoutpap met melk, appel & kaneel","Oatmeal with milk, apple & cinnamon",["breakfast"],
  [{slug:"oats",g:70},{slug:"milk_semi",g:250},{slug:"apple",g:100},{slug:"whey",g:20}],
  {veg:true,steps:{nl:["Breng de havermout met de melk al roerend aan de kook en laat 3–4 min garen.","Haal van het vuur en roer de whey erdoor.","Top met blokjes appel en een snuf kaneel."],en:["Bring the oats and milk to a simmer, stirring, and cook 3–4 min.","Off the heat, stir in the whey.","Top with diced apple and a pinch of cinnamon."]}});

add("Proteïne-havermoutpannenkoekjes met kwark","Protein oat pancakes with quark",["breakfast"],
  [{slug:"oats",g:50},{slug:"egg",g:50},{slug:"egg_white",g:60},{slug:"banana",g:60},{slug:"quark_lowfat",g:100}],
  {veg:true,steps:{nl:["Pureer de havermout, het ei, eiwit en de banaan tot een glad beslag.","Bak er kleine pannenkoekjes van in een antiaanbakpan.","Serveer met een lepel magere kwark."],en:["Blend the oats, egg, egg white and banana into a smooth batter.","Cook small pancakes in a non-stick pan.","Serve with a spoon of low-fat quark."]}});

add("Overnight oats met skyr, chiazaad & bosvruchten","Overnight oats with skyr, chia & mixed berries",["breakfast"],
  [{slug:"oats",g:50},{slug:"skyr",g:150},{slug:"milk_semi",g:100},{slug:"chia",g:10},{slug:"mixed_berries",g:80}],
  {veg:true,steps:{nl:["Meng de havermout, skyr, melk en chiazaad in een pot.","Laat minimaal een nacht in de koelkast opstijven.","Roer de volgende ochtend los en top met de bosvruchten."],en:["Mix the oats, skyr, milk and chia in a jar.","Chill overnight to set.","Stir loose in the morning and top with the mixed berries."]}});

add("Volkoren boterham met hüttenkäse, kipfilet & komkommer","Wholegrain sandwich with cottage cheese, chicken & cucumber",["breakfast"],
  [{slug:"bread_whole",g:70},{slug:"cottage",g:80},{slug:"chicken_breast",g:60},{slug:"cucumber",g:50}],
  {steps:{nl:["Rooster het volkorenbrood licht.","Besmeer met de hüttenkäse.","Beleg met plakjes kipfilet en komkommer, peper erover."],en:["Lightly toast the wholegrain bread.","Spread with the cottage cheese.","Top with sliced chicken and cucumber, add pepper."]}});

add("Smoothiebowl met kwark, banaan & spinazie","Smoothie bowl with quark, banana & spinach",["breakfast"],
  [{slug:"quark_lowfat",g:200},{slug:"banana",g:100},{slug:"spinach",g:30},{slug:"oats",g:40},{slug:"milk_semi",g:80}],
  {veg:true,tech:"blender",steps:{nl:["Doe de kwark, banaan, spinazie, havermout en melk in de blender.","Mix tot een dikke smoothie.","Schep in een kom en top naar wens met wat extra havermout."],en:["Add the quark, banana, spinach, oats and milk to the blender.","Blend to a thick smoothie.","Spoon into a bowl and top with a little extra oats."]}});

add("Roerei met gerookte zalm & volkorenbrood","Scrambled egg with smoked salmon & wholegrain bread",["breakfast"],
  [{slug:"egg",g:100},{slug:"egg_white",g:60},{slug:"smoked_salmon",g:50},{slug:"bread_whole",g:70}],
  {steps:{nl:["Klop het ei met het eiwit los en roer tot een zacht roerei in een antiaanbakpan.","Rooster het volkorenbrood.","Serveer het roerei op het brood met de gerookte zalm en wat peper."],en:["Whisk the egg with the egg white and stir to soft scrambled egg in a non-stick pan.","Toast the wholegrain bread.","Serve the egg on the bread with the smoked salmon and some pepper."]}});

// ========================= LUNCH =========================
add("Tonijnsalade-wrap met yoghurt-mosterddressing","Tuna salad wrap with yoghurt-mustard dressing",["lunch"],
  [{slug:"tuna_can",g:120},{slug:"wrap_whole",g:60},{slug:"yoghurt_lowfat",g:40},{slug:"cucumber",g:60},{slug:"lettuce",g:30},{slug:"mustard",g:5}],
  {steps:{nl:["Meng de tonijn met de yoghurt, mosterd en een scheut citroen tot een smeuïge salade.","Beleg de wrap met sla en komkommer, schep de tonijnsalade erover.","Rol strak op en snijd schuin doormidden."],en:["Mix the tuna with the yoghurt, mustard and a splash of lemon into a creamy salad.","Fill the wrap with lettuce and cucumber, spoon the tuna salad over.","Roll up tightly and cut diagonally."]}});

add("Kip-teriyaki rijstbowl met edamame & broccoli","Chicken teriyaki rice bowl with edamame & broccoli",["lunch","dinner"],
  [{slug:"chicken_breast",g:150},{slug:"rice_dry",g:65},{slug:"edamame",g:60},{slug:"broccoli",g:120},{slug:"teriyaki",g:25}],
  {prefs:["chickenrice"],steps:{nl:["Kook de rijst gaar.","Bak de in blokjes gesneden kipfilet in een hete pan, voeg de teriyaki toe en laat glaceren.","Stoom de broccoli en edamame beetgaar.","Schik alles in een kom over de rijst."],en:["Cook the rice.","Sear the diced chicken in a hot pan, add the teriyaki and let it glaze.","Steam the broccoli and edamame until tender.","Arrange everything in a bowl over the rice."]}});

add("Volkoren pasta met kipfilet, cherrytomaat & basilicum","Wholegrain pasta with chicken, cherry tomato & basil",["lunch","dinner"],
  [{slug:"pasta_whole",g:75},{slug:"chicken_breast",g:150},{slug:"cherry_tomato",g:120},{slug:"olive_oil",g:6}],
  {steps:{nl:["Kook de volkoren pasta beetgaar.","Bak de in reepjes gesneden kipfilet in de olijfolie, voeg de gehalveerde cherrytomaten toe en laat kort meebakken.","Meng de pasta erdoor en werk af met verse basilicum, peper en zout."],en:["Cook the wholegrain pasta al dente.","Fry the sliced chicken in the olive oil, add the halved cherry tomatoes and cook briefly.","Toss the pasta through and finish with fresh basil, salt and pepper."]}});

add("Linzensalade met feta, komkommer & munt","Lentil salad with feta, cucumber & mint",["lunch"],
  [{slug:"lentils",g:180},{slug:"feta_light",g:40},{slug:"cucumber",g:80},{slug:"tomato",g:80},{slug:"olive_oil",g:5}],
  {veg:true,steps:{nl:["Meng de gekookte linzen met blokjes komkommer en tomaat.","Verkruimel de feta erover.","Maak aan met de olijfolie, citroen, verse munt, peper en zout."],en:["Mix the cooked lentils with diced cucumber and tomato.","Crumble the feta over.","Dress with the olive oil, lemon, fresh mint, salt and pepper."]}});

add("Couscoussalade met kikkererwten & kipfilet","Couscous salad with chickpeas & chicken",["lunch"],
  [{slug:"couscous",g:60},{slug:"chickpeas",g:100},{slug:"chicken_breast",g:120},{slug:"paprika",g:80},{slug:"olive_oil",g:5}],
  {steps:{nl:["Wel de couscous met heet water tot gaar, roer los met een vork.","Bak de kipfilet gaar en snijd in reepjes.","Meng de couscous met kikkererwten, blokjes paprika, de kip en de olijfolie; breng op smaak."],en:["Soak the couscous in hot water until done, fluff with a fork.","Cook the chicken and slice.","Mix the couscous with chickpeas, diced pepper, the chicken and the olive oil; season."]}});

add("Volkoren boterhammen met rosbief & mosterd","Wholegrain sandwiches with roast beef & mustard",["lunch"],
  [{slug:"bread_whole",g:90},{slug:"rosbief",g:80},{slug:"mustard",g:8},{slug:"lettuce",g:20},{slug:"tomato",g:40}],
  {steps:{nl:["Besmeer het volkorenbrood dun met mosterd.","Beleg met de rosbief, sla en plakjes tomaat.","Klap dicht en snijd doormidden."],en:["Spread the wholegrain bread thinly with mustard.","Top with the roast beef, lettuce and tomato slices.","Close and cut in half."]}});

add("Pokébowl met tonijn, rijst & edamame","Poké bowl with tuna, rice & edamame",["lunch","dinner"],
  [{slug:"tuna_can",g:120},{slug:"rice_dry",g:65},{slug:"edamame",g:70},{slug:"cucumber",g:60},{slug:"soy_sauce",g:10}],
  {steps:{nl:["Kook de rijst en laat iets afkoelen.","Verdeel de rijst in een kom.","Schik de tonijn, edamame en komkommer eromheen en besprenkel met sojasaus."],en:["Cook the rice and let it cool slightly.","Divide the rice into a bowl.","Arrange the tuna, edamame and cucumber around it and drizzle with soy sauce."]}});

add("Kipfilet-wrap met hummus, sla & wortel","Chicken wrap with hummus, lettuce & carrot",["lunch"],
  [{slug:"wrap_whole",g:60},{slug:"chicken_breast",g:120},{slug:"hummus_light",g:30},{slug:"lettuce",g:30},{slug:"carrot",g:50}],
  {prefs:["chickenwrap"],steps:{nl:["Besmeer de wrap met de hummus.","Beleg met gegrilde reepjes kipfilet, sla en geraspte wortel.","Rol strak op en snijd doormidden."],en:["Spread the wrap with the hummus.","Top with grilled chicken strips, lettuce and grated carrot.","Roll up tightly and halve."]}});

add("Gerookte-kipsalade met aardappel & sperziebonen","Smoked chicken salad with potato & green beans",["lunch","dinner"],
  [{slug:"chicken_breast",g:130},{slug:"potato",g:200},{slug:"green_beans",g:120},{slug:"yoghurt_lowfat",g:40},{slug:"mustard",g:5}],
  {steps:{nl:["Kook de aardappels gaar en laat afkoelen; stoom de sperziebonen beetgaar.","Roer een dressing van de yoghurt, mosterd, citroen, peper en zout.","Meng de aardappel, sperziebonen en gegrilde kip met de dressing."],en:["Boil the potatoes and let cool; steam the green beans until tender.","Stir a dressing from the yoghurt, mustard, lemon, salt and pepper.","Toss the potato, green beans and grilled chicken with the dressing."]}});

add("Groentesoep met kip & volkorenbrood","Vegetable soup with chicken & wholegrain bread",["lunch"],
  [{slug:"chicken_breast",g:100},{slug:"carrot",g:80},{slug:"zucchini",g:80},{slug:"onion",g:40},{slug:"bread_whole",g:60}],
  {tech:"soup",steps:{nl:["Fruit de ui, wortel en courgette kort aan in een soeppan.","Voeg bouillon en de in blokjes gesneden kipfilet toe en laat 12–15 min zachtjes garen.","Breng op smaak en serveer met het volkorenbrood."],en:["Sweat the onion, carrot and zucchini briefly in a soup pot.","Add stock and the diced chicken and simmer gently 12–15 min.","Season and serve with the wholegrain bread."]}});

add("Garnalen-roerbak met rijst & sugarsnaps","Shrimp stir-fry with rice & sugar snaps",["lunch","dinner"],
  [{slug:"shrimp",g:140},{slug:"rice_dry",g:65},{slug:"sugarsnap",g:120},{slug:"paprika",g:60},{slug:"soy_sauce",g:12}],
  {steps:{nl:["Kook de rijst gaar.","Roerbak de sugarsnaps en paprika kort in een hete wok.","Voeg de garnalen en sojasaus toe en bak tot de garnalen roze en gaar zijn.","Serveer over de rijst."],en:["Cook the rice.","Stir-fry the sugar snaps and pepper briefly in a hot wok.","Add the shrimp and soy sauce and cook until the shrimp are pink and done.","Serve over the rice."]}});

add("Omelet-wrap met groente","Omelette wrap with vegetables",["lunch","breakfast"],
  [{slug:"egg",g:100},{slug:"egg_white",g:90},{slug:"paprika",g:60},{slug:"spinach",g:40},{slug:"cottage",g:60}],
  {veg:true,steps:{nl:["Klop het ei met het eiwit los en bak er een dunne omelet van.","Beleg met de hüttenkäse, paprika en spinazie.","Rol de omelet op als een wrap en snijd doormidden."],en:["Whisk the egg with the egg white and cook a thin omelette.","Top with the cottage cheese, pepper and spinach.","Roll the omelette like a wrap and halve."]}});

// ========================= DINER =========================
add("Gestoomde kabeljauw met aardappel & sperziebonen","Steamed cod with potato & green beans",["dinner"],
  [{slug:"cod",g:160},{slug:"potato",g:250},{slug:"green_beans",g:150},{slug:"olive_oil",g:7}],
  {prefs:["codveg"],steps:{nl:["Kook de aardappels in 15–18 min gaar.","Stoom de sperziebonen 6–8 min beetgaar.","Bestrijk de kabeljauw met de olijfolie, peper en citroen; stoom of bak 'm 6–8 min tot de vis net schilfert.","Serveer met wat verse dille."],en:["Boil the potatoes until done, 15–18 min.","Steam the green beans 6–8 min until tender.","Brush the cod with the olive oil, pepper and lemon; steam or pan-fry 6–8 min until it just flakes.","Serve with some fresh dill."]}});

add("Kipfilet uit de oven met zoete aardappel & broccoli","Oven chicken with sweet potato & broccoli",["dinner"],
  [{slug:"chicken_breast",g:160},{slug:"sweet_potato",g:220},{slug:"broccoli",g:150},{slug:"olive_oil",g:7}],
  {prefs:["chickenrice"],tech:"oven",steps:{nl:["Verwarm de oven op 200°C. Snijd de zoete aardappel in parten, hussel met de helft van de olijfolie en rooster 25 min.","Bestrijk de kipfilet met de rest van de olie, peper en paprikapoeder en rooster de laatste 18 min mee.","Stoom de broccoli beetgaar en serveer alles samen."],en:["Preheat the oven to 200°C. Cut the sweet potato into wedges, toss with half the olive oil and roast 25 min.","Brush the chicken with the rest of the oil, pepper and paprika and roast for the final 18 min.","Steam the broccoli until tender and serve together."]}});

add("Magere runderwok met paprika, ui & rijst","Lean beef stir-fry with pepper, onion & rice",["dinner"],
  [{slug:"beef_lean",g:150},{slug:"rice_dry",g:65},{slug:"paprika",g:100},{slug:"onion",g:50},{slug:"soy_sauce",g:12}],
  {steps:{nl:["Kook de rijst gaar.","Snijd het rundvlees in reepjes en bak kort op hoog vuur aan; haal uit de pan.","Roerbak de paprika en ui, voeg het vlees en de sojasaus terug en bak nog 1 min.","Serveer over de rijst."],en:["Cook the rice.","Slice the beef and sear briefly on high heat; remove from the pan.","Stir-fry the pepper and onion, return the beef and soy sauce and cook 1 min more.","Serve over the rice."]}});

add("Zalmfilet uit de oven met aardappel & spinazie","Oven salmon with potato & spinach",["dinner"],
  [{slug:"salmon",g:140},{slug:"potato",g:220},{slug:"spinach",g:120},{slug:"olive_oil",g:5}],
  {prefs:["salmonveg"],tech:"oven",steps:{nl:["Verwarm de oven op 200°C en rooster de aardappelparten 25 min.","Leg de zalm de laatste 12 min mee in de oven, met peper en citroen.","Slink de spinazie kort in een pan met de olijfolie en serveer alles samen."],en:["Preheat the oven to 200°C and roast the potato wedges 25 min.","Add the salmon for the final 12 min, with pepper and lemon.","Wilt the spinach briefly in a pan with the olive oil and serve together."]}});

add("Kipsaté-bowl met rijst & komkommer","Chicken satay bowl with rice & cucumber",["dinner"],
  [{slug:"chicken_breast",g:150},{slug:"rice_dry",g:65},{slug:"satay_light",g:30},{slug:"cucumber",g:80}],
  {steps:{nl:["Kook de rijst gaar.","Rijg de in blokjes gesneden kipfilet en gril of bak 'm gaar.","Verwarm de satésaus en lepel over de kip.","Serveer met de rijst en frisse komkommer."],en:["Cook the rice.","Skewer the diced chicken and grill or pan-fry until done.","Warm the satay sauce and spoon over the chicken.","Serve with the rice and fresh cucumber."]}});

add("Witvis met quinoa, courgette & citroen","White fish with quinoa, zucchini & lemon",["dinner"],
  [{slug:"white_fish",g:160},{slug:"quinoa",g:60},{slug:"zucchini",g:150},{slug:"olive_oil",g:6}],
  {steps:{nl:["Kook de quinoa gaar in ruim water.","Bak de courgette in de olijfolie goudbruin.","Bak de witvis 3–4 min per kant tot gaar, met peper en citroen.","Serveer de vis op de quinoa met de courgette."],en:["Cook the quinoa in plenty of water.","Pan-fry the zucchini in the olive oil until golden.","Fry the white fish 3–4 min per side until done, with pepper and lemon.","Serve the fish on the quinoa with the zucchini."]}});

add("Kalkoenfilet met aardappelpuree & doperwten","Turkey breast with mashed potato & peas",["dinner"],
  [{slug:"turkey_breast",g:150},{slug:"potato",g:250},{slug:"milk_semi",g:50},{slug:"peas",g:120}],
  {steps:{nl:["Kook de aardappels gaar en stamp met een scheut halfvolle melk tot puree.","Bak de kalkoenfilet 4–5 min per kant tot gaar.","Verwarm de doperwten en serveer alles samen."],en:["Boil the potatoes and mash with a splash of semi-skimmed milk.","Pan-fry the turkey 4–5 min per side until done.","Warm the peas and serve together."]}});

add("Chili sin carne met kidneybonen & rijst","Chili sin carne with kidney beans & rice",["dinner"],
  [{slug:"kidney_beans",g:200},{slug:"corn",g:80},{slug:"tomato",g:150},{slug:"rice_dry",g:65},{slug:"onion",g:50}],
  {vegan:true,steps:{nl:["Kook de rijst gaar.","Fruit de ui, voeg tomaat, kidneybonen en mais toe met komijn, paprikapoeder en chili.","Laat 10–12 min pruttelen en serveer over de rijst."],en:["Cook the rice.","Sweat the onion, add tomato, kidney beans and corn with cumin, paprika and chili.","Simmer 10–12 min and serve over the rice."]}});

add("Tofu-roerbak met teriyaki, broccoli & rijst","Tofu stir-fry with teriyaki, broccoli & rice",["dinner"],
  [{slug:"tofu",g:180},{slug:"rice_dry",g:65},{slug:"broccoli",g:150},{slug:"teriyaki",g:25}],
  {vegan:true,steps:{nl:["Kook de rijst gaar.","Bak de tofublokjes rondom goudbruin en knapperig.","Voeg de broccoli en teriyaki toe en roerbak tot de broccoli beetgaar is.","Serveer over de rijst."],en:["Cook the rice.","Fry the tofu cubes until golden and crisp all over.","Add the broccoli and teriyaki and stir-fry until the broccoli is tender.","Serve over the rice."]}});

add("Biefstuk sous-vide 54°C met aardappel & gegrilde groente","Sous-vide steak 54°C with potato & grilled vegetables",["dinner"],
  [{slug:"beef_lean",g:150},{slug:"potato",g:220},{slug:"zucchini",g:100},{slug:"paprika",g:80},{slug:"olive_oil",g:6}],
  {tech:"sousvide",temp:"54°C",steps:{nl:["Vacumeer de biefstuk en gaar sous-vide op 54°C (1,5–4 u) voor medium-rare.","Kook de aardappels gaar; gril de courgette en paprika in een grillpan.","Dep de biefstuk droog en schroei 'm rondom kort dicht in een gloeiend hete pan.","Laat 2 min rusten, snijd aan en serveer met de groente."],en:["Vacuum-seal the steak and cook sous-vide at 54°C (1.5–4 h) for medium-rare.","Boil the potatoes; grill the zucchini and pepper in a griddle pan.","Pat the steak dry and sear it all over in a scorching-hot pan.","Rest 2 min, slice and serve with the vegetables."]}});

add("Kip sous-vide 63°C met zoete aardappel & broccoli","Sous-vide chicken 63°C with sweet potato & broccoli",["dinner"],
  [{slug:"chicken_breast",g:160},{slug:"sweet_potato",g:200},{slug:"broccoli",g:120},{slug:"olive_oil",g:6}],
  {tech:"sousvide",temp:"63°C",steps:{nl:["Vacumeer de kipfilet en gaar sous-vide op 63°C (1,5–4 u) voor een sappige, gare kip.","Rooster de zoete aardappel in de oven op 200°C in ca. 25 min.","Stoom de broccoli beetgaar.","Dep de kip droog en schroei 'm kort aan in een hete pan; serveer met de groente."],en:["Vacuum-seal the chicken and cook sous-vide at 63°C (1.5–4 h) for juicy, cooked-through chicken.","Roast the sweet potato in the oven at 200°C for about 25 min.","Steam the broccoli until tender.","Pat the chicken dry and sear briefly in a hot pan; serve with the vegetables."]}});

add("Spaghetti bolognese van mager rundergehakt","Spaghetti bolognese with lean beef mince",["dinner"],
  [{slug:"beef_mince5",g:150},{slug:"pasta_whole",g:75},{slug:"tomato",g:150},{slug:"onion",g:50},{slug:"olive_oil",g:5}],
  {steps:{nl:["Kook de volkoren spaghetti beetgaar.","Fruit de ui in de olijfolie, voeg het gehakt toe en rul het los.","Voeg de tomaat toe met Italiaanse kruiden en laat 10 min pruttelen.","Schep over de spaghetti."],en:["Cook the wholegrain spaghetti al dente.","Sweat the onion in the olive oil, add the mince and break it up.","Add the tomato with Italian herbs and simmer 10 min.","Spoon over the spaghetti."]}});

// ========================= TUSSENDOORTJE =========================
add("Magere kwark met blauwe bessen & amandelschaafsel","Low-fat quark with blueberries & flaked almonds",["snack"],
  [{slug:"quark_lowfat",g:150},{slug:"blueberries",g:60},{slug:"almonds",g:10}],
  {veg:true,tech:"assembly",steps:{nl:["Schep de kwark in een kom.","Top met de blauwe bessen en het amandelschaafsel."],en:["Spoon the quark into a bowl.","Top with the blueberries and flaked almonds."]}});

add("Skyr met honing & walnoten","Skyr with honey & walnuts",["snack"],
  [{slug:"skyr",g:150},{slug:"honey",g:10},{slug:"walnuts",g:12}],
  {veg:true,tech:"assembly",steps:{nl:["Schep de skyr in een kom.","Druppel de honing erover en strooi de grof gehakte walnoten erop."],en:["Spoon the skyr into a bowl.","Drizzle the honey over and scatter the roughly chopped walnuts on top."]}});

add("Rijstwafels met kipfilet & komkommer","Rice cakes with chicken & cucumber",["snack"],
  [{slug:"rice_cakes",g:26},{slug:"chicken_breast",g:60},{slug:"cucumber",g:40}],
  {tech:"assembly",steps:{nl:["Beleg de rijstwafels met plakjes kipfilet.","Leg er dunne plakjes komkommer op en maal er wat peper over."],en:["Top the rice cakes with sliced chicken.","Add thin cucumber slices and grind some pepper over."]}});

add("Proteïneshake met banaan","Protein shake with banana",["snack"],
  [{slug:"whey",g:30},{slug:"banana",g:80},{slug:"milk_semi",g:200}],
  {veg:true,tech:"blender",steps:{nl:["Doe de whey, banaan en melk in de blender.","Mix glad en schenk in een glas — ideaal na je training."],en:["Add the whey, banana and milk to the blender.","Blend smooth and pour into a glass — ideal after training."]}});

add("Appel met amandelen","Apple with almonds",["snack"],
  [{slug:"apple",g:150},{slug:"almonds",g:20}],
  {veg:true,vegan:true,tech:"assembly",steps:{nl:["Snijd de appel in partjes.","Eet met een handje amandelen als knapperige snack."],en:["Slice the apple into wedges.","Enjoy with a handful of almonds as a crunchy snack."]}});

add("Volkoren crackers met hüttenkäse & tomaat","Wholegrain crackers with cottage cheese & tomato",["snack"],
  [{slug:"crackers_whole",g:24},{slug:"cottage",g:80},{slug:"tomato",g:50}],
  {veg:true,tech:"assembly",steps:{nl:["Besmeer de crackers met de hüttenkäse.","Leg er plakjes tomaat op en maal er wat peper over."],en:["Spread the crackers with the cottage cheese.","Top with tomato slices and grind some pepper over."]}});

add("Edamame met zeezout","Edamame with sea salt",["snack"],
  [{slug:"edamame",g:150}],
  {veg:true,vegan:true,steps:{nl:["Kook of stoom de edamame 4–5 min.","Bestrooi met wat zeezout en knijp de boontjes uit de peul."],en:["Boil or steam the edamame 4–5 min.","Sprinkle with sea salt and squeeze the beans from the pods."]}});

add("Kwark met kaneel & banaan","Quark with cinnamon & banana",["snack"],
  [{slug:"quark_lowfat",g:150},{slug:"banana",g:70}],
  {veg:true,tech:"assembly",steps:{nl:["Schep de kwark in een kom.","Roer er een snuf kaneel door en top met schijfjes banaan."],en:["Spoon the quark into a bowl.","Stir in a pinch of cinnamon and top with banana slices."]}});

// ========================= BLOK 2 (recepten van Mounir) =========================
add("Zoete-aardappelpuree met flat iron, gepocheerd ei & avocado","Sweet potato mash with flat iron, poached egg & avocado",["dinner"],
  [{slug:"sweet_potato",g:220},{slug:"flat_iron",g:150},{slug:"egg",g:55},{slug:"avocado",g:40},{slug:"olive_oil",g:3}],
  {steps:{nl:["Kook de zoete aardappel gaar en stamp tot een gladde puree met peper en zout.","Bak de flat iron 2–3 min per kant tot medium-rare en laat even rusten.","Pocheer het ei 3 min in zacht kokend water met een scheut azijn.","Serveer de puree met de aangesneden flat iron, het gepocheerde ei en waaiertjes avocado."],en:["Boil the sweet potato and mash smooth with salt and pepper.","Sear the flat iron 2–3 min per side to medium-rare and rest briefly.","Poach the egg 3 min in gently simmering water with a splash of vinegar.","Serve the mash with the sliced flat iron, the poached egg and fanned avocado."]}});

add("Zalmfilet met gele rijst, groente & ketjap manis","Salmon with yellow rice, vegetables & sweet soy",["dinner"],
  [{slug:"salmon",g:140},{slug:"rice_yellow",g:65},{slug:"broccoli",g:100},{slug:"paprika",g:100},{slug:"ketjap_manis",g:15}],
  {steps:{nl:["Kook de rijst met een snuf kurkuma tot gele rijst.","Bak of stoom de zalm gaar, met peper en citroen.","Roerbak de broccoli en paprika beetgaar.","Serveer samen en lepel de ketjap manis over de zalm."],en:["Cook the rice with a pinch of turmeric for yellow rice.","Pan-fry or steam the salmon, with pepper and lemon.","Stir-fry the broccoli and pepper until tender.","Serve together and spoon the sweet soy over the salmon."]}});

add("Kwark met bosbessen, honing & pure chocolade","Quark with blueberries, honey & dark chocolate",["snack"],
  [{slug:"quark_lowfat",g:150},{slug:"blueberries",g:60},{slug:"honey",g:8},{slug:"dark_choc70",g:12}],
  {veg:true,tech:"assembly",steps:{nl:["Schep de kwark in een kom.","Top met de bosbessen en een druppel honing.","Hak de pure chocolade (70%) grof en strooi erover."],en:["Spoon the quark into a bowl.","Top with the blueberries and a drizzle of honey.","Roughly chop the 70% dark chocolate and scatter over."]}});

add("Mais-kipfilet met gele rijst, groente & teriyaki","Corn chicken with yellow rice, vegetables & teriyaki",["dinner","lunch"],
  [{slug:"chicken_breast",g:150},{slug:"rice_yellow",g:65},{slug:"corn",g:80},{slug:"broccoli",g:120},{slug:"teriyaki",g:25}],
  {steps:{nl:["Kook de rijst met een snuf kurkuma tot gele rijst.","Bak de kipfilet gaar, voeg de teriyaki toe en laat glaceren.","Warm de mais en stoom de broccoli beetgaar.","Schik alles over de rijst."],en:["Cook the rice with a pinch of turmeric for yellow rice.","Sear the chicken, add the teriyaki and let it glaze.","Warm the corn and steam the broccoli until tender.","Arrange everything over the rice."]}});

add("Couscous-stoofpotje met kipdij, kaneel & groente","Couscous stew with chicken thigh, cinnamon & vegetables",["dinner"],
  [{slug:"chicken_thigh",g:150},{slug:"couscous",g:60},{slug:"carrot",g:80},{slug:"zucchini",g:80},{slug:"onion",g:40}],
  {tech:"soup",steps:{nl:["Stoof de kipdij met de ui, wortel en courgette aan; voeg een snuf kaneel en kippenbouillon toe.","Laat 20–25 min zachtjes stoven tot kip en groente gaar zijn in een geurig vocht.","Doe de couscous in een kom, schep het hete stoofvocht erover tot net onder en dek af met folie.","Laat 5 min wellen, roer los met een vork en schep de stoof met kip en groente erover."],en:["Sweat the chicken thigh with the onion, carrot and zucchini; add a pinch of cinnamon and chicken stock.","Simmer gently 20–25 min until the chicken and vegetables are tender in a fragrant broth.","Put the couscous in a bowl, ladle the hot broth over to just below the surface and cover with foil.","Let it swell 5 min, fluff with a fork and spoon the stew with chicken and vegetables over."]}});

add("Couscoussalade met rode ui, feta, hummus & selderij","Couscous salad with red onion, feta, hummus & celery",["lunch"],
  [{slug:"couscous",g:60},{slug:"red_onion",g:30},{slug:"feta_light",g:40},{slug:"hummus_light",g:30},{slug:"celery",g:40},{slug:"tomato",g:80},{slug:"spring_onion",g:15}],
  {veg:true,steps:{nl:["Wel de couscous met heet water tot gaar, roer los met een vork en laat afkoelen.","Meng met fijngesneden rode ui, selderij en tomaat.","Roer de hummus erdoor, verkruimel de feta erover en werk af met bosui of bieslook."],en:["Soak the couscous in hot water until done, fluff with a fork and let cool.","Mix with finely chopped red onion, celery and tomato.","Stir the hummus through, crumble the feta over and finish with spring onion or chives."]}});

add("Koude pastasalade met tonijn, citroen & olijven","Cold pasta salad with tuna, lemon & olives",["lunch"],
  [{slug:"pasta_whole",g:70},{slug:"tuna_can",g:100},{slug:"red_onion",g:30},{slug:"olives",g:20},{slug:"tomato",g:100},{slug:"olive_oil",g:4}],
  {steps:{nl:["Kook de volkoren pasta beetgaar, spoel koud en laat uitlekken.","Meng met de tonijn, fijne rode ui, olijven en tomaat.","Maak aan met citroensap, een scheutje olijfolie, peper en zout."],en:["Cook the wholegrain pasta al dente, rinse cold and drain.","Mix with the tuna, finely chopped red onion, olives and tomato.","Dress with lemon juice, a drizzle of olive oil, salt and pepper."]}});

add("Desembrood met avocado, gepocheerd ei & tomatensalsa","Sourdough with avocado, poached egg & tomato salsa",["breakfast","lunch"],
  [{slug:"sourdough",g:80},{slug:"avocado",g:50},{slug:"egg",g:55},{slug:"tomato",g:60},{slug:"red_onion",g:20}],
  {veg:true,steps:{nl:["Rooster het desembrood.","Maak een snelle salsa van fijngesneden tomaat en rode ui met peper en zout.","Pocheer het ei 3 min in zacht kokend water met een scheut azijn.","Besmeer het brood met geprakte avocado, leg het ei erop en schep de salsa erover."],en:["Toast the sourdough.","Make a quick salsa of finely chopped tomato and red onion with salt and pepper.","Poach the egg 3 min in gently simmering water with a splash of vinegar.","Spread the bread with mashed avocado, place the egg on top and spoon the salsa over."]}});

add("Desembrood met tomaat, magere kaas & gekookt ei","Sourdough with tomato, low-fat cheese & boiled egg",["breakfast","lunch"],
  [{slug:"sourdough",g:80},{slug:"tomato",g:60},{slug:"low_fat_cheese",g:30},{slug:"egg",g:55},{slug:"lettuce",g:20}],
  {veg:true,steps:{nl:["Kook het ei 7–8 min hard, pel en snijd in plakjes.","Rooster het desembrood.","Beleg met sla, plakjes tomaat, magere kaas en het gesneden ei."],en:["Hard-boil the egg 7–8 min, peel and slice.","Toast the sourdough.","Top with lettuce, tomato slices, low-fat cheese and the sliced egg."]}});

add("Desembrood met hummus, feta & bosui","Sourdough with hummus, feta & spring onion",["breakfast","lunch"],
  [{slug:"sourdough",g:80},{slug:"hummus_light",g:30},{slug:"feta_light",g:30},{slug:"tomato",g:60},{slug:"spring_onion",g:15}],
  {veg:true,steps:{nl:["Rooster het desembrood en besmeer met de hummus.","Beleg met plakjes tomaat en verkruimelde feta.","Werk af met fijngesneden bosui of bieslook."],en:["Toast the sourdough and spread with the hummus.","Top with tomato slices and crumbled feta.","Finish with finely chopped spring onion or chives."]}});

// ========================= BLOK 3 (meer variatie) =========================
// --- ontbijt ---
add("Griekse yoghurt met havermout, mango & pompoenpitten","Greek yoghurt with oats, mango & pumpkin seeds",["breakfast"],
  [{slug:"greek_yoghurt",g:200},{slug:"oats",g:40},{slug:"mango",g:80},{slug:"pumpkin_seeds",g:10}],
  {veg:true,steps:{nl:["Meng de Griekse yoghurt met de havermout.","Schep in een kom en top met blokjes mango.","Strooi de pompoenpitten erover."],en:["Mix the Greek yoghurt with the oats.","Spoon into a bowl and top with diced mango.","Scatter the pumpkin seeds over."]}});

add("Volkoren pap met banaan, kaneel & walnoten","Wholegrain porridge with banana, cinnamon & walnuts",["breakfast"],
  [{slug:"oats",g:70},{slug:"milk_semi",g:250},{slug:"banana",g:80},{slug:"walnuts",g:10}],
  {veg:true,steps:{nl:["Breng de havermout met de melk al roerend aan de kook en gaar 3–4 min.","Roer er een snuf kaneel door.","Top met schijfjes banaan en grof gehakte walnoten."],en:["Bring the oats and milk to a simmer, stirring, and cook 3–4 min.","Stir in a pinch of cinnamon.","Top with banana slices and roughly chopped walnuts."]}});

add("Eiwitomelet met champignons, spinazie & tomaat","Egg-white omelette with mushrooms, spinach & tomato",["breakfast"],
  [{slug:"egg",g:50},{slug:"egg_white",g:120},{slug:"mushroom",g:80},{slug:"spinach",g:40},{slug:"tomato",g:60}],
  {veg:true,steps:{nl:["Klop het ei met het eiwit los.","Bak de champignons tot ze kleuren, voeg de spinazie en tomaat kort toe.","Giet het ei erbij en laat op laag vuur stollen tot een omelet."],en:["Whisk the egg with the egg whites.","Fry the mushrooms until coloured, add the spinach and tomato briefly.","Pour in the egg and let it set on low heat into an omelette."]}});

add("Volkorenboterham met pindakaas & banaan","Wholegrain bread with peanut butter & banana",["breakfast","snack"],
  [{slug:"bread_whole",g:70},{slug:"peanut_butter",g:20},{slug:"banana",g:80}],
  {veg:true,vegan:true,tech:"assembly",steps:{nl:["Rooster het volkorenbrood.","Besmeer dun met pindakaas.","Beleg met schijfjes banaan."],en:["Toast the wholegrain bread.","Spread thinly with peanut butter.","Top with banana slices."]}});

add("Kwark met framboos, kiwi & chiazaad","Quark with raspberry, kiwi & chia",["breakfast","snack"],
  [{slug:"quark_lowfat",g:200},{slug:"raspberry",g:60},{slug:"kiwi",g:60},{slug:"chia",g:10}],
  {veg:true,tech:"assembly",steps:{nl:["Schep de kwark in een kom.","Top met frambozen en schijfjes kiwi.","Strooi het chiazaad erover."],en:["Spoon the quark into a bowl.","Top with raspberries and kiwi slices.","Scatter the chia over."]}});

add("Shakshuka met ei, paprika & volkorenbrood","Shakshuka with egg, pepper & wholegrain bread",["breakfast","lunch"],
  [{slug:"egg",g:120},{slug:"passata",g:150},{slug:"paprika",g:100},{slug:"onion",g:40},{slug:"bread_whole",g:60}],
  {veg:true,tech:"pan",steps:{nl:["Fruit de ui en paprika zacht, voeg de passata toe met komijn en paprikapoeder.","Laat 8 min pruttelen, maak kuiltjes en breek de eieren erin.","Dek af en gaar tot het eiwit gestold is; serveer met het brood."],en:["Soften the onion and pepper, add the passata with cumin and paprika.","Simmer 8 min, make wells and crack the eggs in.","Cover and cook until the whites set; serve with the bread."]}});

add("Skyr-bowl met appel, kaneel & walnoten","Skyr bowl with apple, cinnamon & walnuts",["breakfast"],
  [{slug:"skyr",g:200},{slug:"apple",g:100},{slug:"oats",g:30},{slug:"walnuts",g:10}],
  {veg:true,steps:{nl:["Meng de skyr met de havermout.","Top met blokjes appel en een snuf kaneel.","Strooi grof gehakte walnoten erover."],en:["Mix the skyr with the oats.","Top with diced apple and a pinch of cinnamon.","Scatter roughly chopped walnuts over."]}});

add("Volkoren wrap met hüttenkäse, kalkoen & komkommer","Wholegrain wrap with cottage cheese, turkey & cucumber",["breakfast","lunch"],
  [{slug:"wrap_whole",g:60},{slug:"cottage",g:80},{slug:"turkey_breast",g:70},{slug:"cucumber",g:50}],
  {steps:{nl:["Besmeer de wrap met de hüttenkäse.","Beleg met plakjes kalkoenfilet en komkommer.","Rol strak op en snijd doormidden."],en:["Spread the wrap with the cottage cheese.","Top with turkey slices and cucumber.","Roll up tightly and halve."]}});

add("Proteïne-overnight oats met banaan & pindakaas","Protein overnight oats with banana & peanut butter",["breakfast"],
  [{slug:"oats",g:50},{slug:"skyr",g:150},{slug:"milk_semi",g:100},{slug:"banana",g:60},{slug:"peanut_butter",g:12}],
  {veg:true,tech:"assembly",steps:{nl:["Meng de havermout, skyr en melk in een pot en laat een nacht opstijven.","Roer de volgende ochtend los.","Top met schijfjes banaan en een lepel pindakaas."],en:["Mix the oats, skyr and milk in a jar and let set overnight.","Stir loose in the morning.","Top with banana slices and a spoon of peanut butter."]}});

add("Gerookte kip op volkorenbrood met ei & tomaat","Smoked chicken on wholegrain bread with egg & tomato",["breakfast","lunch"],
  [{slug:"bread_whole",g:80},{slug:"chicken_breast",g:60},{slug:"egg",g:55},{slug:"tomato",g:50},{slug:"lettuce",g:20}],
  {steps:{nl:["Kook het ei 7–8 min hard, pel en snijd in plakjes.","Rooster het volkorenbrood.","Beleg met sla, gerookte kip, plakjes tomaat en ei."],en:["Hard-boil the egg 7–8 min, peel and slice.","Toast the wholegrain bread.","Top with lettuce, smoked chicken, tomato slices and egg."]}});

// --- lunch ---
add("Kip-caesarsalade light met ei & volkoren croutons","Light chicken caesar salad with egg & wholegrain croutons",["lunch"],
  [{slug:"chicken_breast",g:130},{slug:"lettuce",g:80},{slug:"egg",g:55},{slug:"bread_whole",g:40},{slug:"greek_yoghurt",g:40}],
  {steps:{nl:["Gril de kipfilet gaar en snijd in reepjes; kook het ei en halveer.","Rooster blokjes volkorenbrood tot croutons.","Meng de sla met een dressing van yoghurt, mosterd, citroen en peper; schik kip, ei en croutons erop."],en:["Grill the chicken and slice; boil the egg and halve.","Toast diced wholegrain bread into croutons.","Toss the lettuce with a dressing of yoghurt, mustard, lemon and pepper; arrange chicken, egg and croutons on top."]}});

add("Niçoise-salade met tonijn, ei & sperziebonen","Niçoise salad with tuna, egg & green beans",["lunch"],
  [{slug:"tuna_can",g:100},{slug:"potato",g:150},{slug:"green_beans",g:100},{slug:"egg",g:55},{slug:"tomato",g:80},{slug:"olives",g:15}],
  {steps:{nl:["Kook de aardappels en sperziebonen beetgaar; kook het ei en halveer.","Schik de aardappel, sperziebonen, tomaat en olijven op een bord.","Verdeel de tonijn en het ei erover en besprenkel met citroen en peper."],en:["Boil the potatoes and green beans; boil the egg and halve.","Arrange the potato, green beans, tomato and olives on a plate.","Spread the tuna and egg over and drizzle with lemon and pepper."]}});

add("Bulgursalade met kikkererwten, feta & munt","Bulgur salad with chickpeas, feta & mint",["lunch"],
  [{slug:"bulgur",g:60},{slug:"chickpeas",g:100},{slug:"feta_light",g:40},{slug:"cucumber",g:80},{slug:"tomato",g:80}],
  {veg:true,steps:{nl:["Kook de bulgur gaar en laat afkoelen.","Meng met kikkererwten, blokjes komkommer en tomaat.","Verkruimel de feta erover en werk af met munt, citroen en peper."],en:["Cook the bulgur and let cool.","Mix with chickpeas, diced cucumber and tomato.","Crumble the feta over and finish with mint, lemon and pepper."]}});

add("Pita met kipshoarma, yoghurtsaus & salade","Pita with chicken shawarma, yoghurt sauce & salad",["lunch","dinner"],
  [{slug:"pita_whole",g:60},{slug:"chicken_breast",g:140},{slug:"yoghurt_lowfat",g:40},{slug:"lettuce",g:30},{slug:"tomato",g:60}],
  {steps:{nl:["Kruid de kipreepjes met shoarmakruiden en bak ze gaar.","Roer een saus van yoghurt, knoflook, citroen en peper.","Vul de warme pita met sla, tomaat, de kip en de yoghurtsaus."],en:["Season the chicken strips with shawarma spice and cook through.","Stir a sauce of yoghurt, garlic, lemon and pepper.","Fill the warm pita with lettuce, tomato, the chicken and the yoghurt sauce."]}});

add("Volkoren noedels met tofu, broccoli & soja","Whole-wheat noodles with tofu, broccoli & soy",["lunch","dinner"],
  [{slug:"noodles_whole",g:70},{slug:"tofu",g:160},{slug:"broccoli",g:120},{slug:"soy_sauce",g:12}],
  {vegan:true,steps:{nl:["Kook de volkoren noedels beetgaar.","Bak de tofublokjes goudbruin, voeg de broccoli toe en roerbak beetgaar.","Meng de noedels en sojasaus erdoor."],en:["Cook the whole-wheat noodles al dente.","Fry the tofu until golden, add the broccoli and stir-fry until tender.","Toss the noodles and soy sauce through."]}});

add("Mexicaanse bowl met zwarte bonen, mais & avocado","Mexican bowl with black beans, corn & avocado",["lunch","dinner"],
  [{slug:"black_beans",g:150},{slug:"rice_dry",g:60},{slug:"corn",g:80},{slug:"avocado",g:40},{slug:"tomato",g:80}],
  {vegan:true,steps:{nl:["Kook de rijst gaar.","Verwarm de zwarte bonen met komijn en paprikapoeder.","Schik rijst, bonen, mais, tomaat en avocado in een kom; knijp er limoen over."],en:["Cook the rice.","Warm the black beans with cumin and paprika.","Arrange rice, beans, corn, tomato and avocado in a bowl; squeeze lime over."]}});

add("Gerookte zalm op volkorenbrood met hüttenkäse","Smoked salmon on wholegrain bread with cottage cheese",["lunch","breakfast"],
  [{slug:"bread_whole",g:80},{slug:"smoked_salmon",g:60},{slug:"cottage",g:60},{slug:"red_onion",g:20},{slug:"cucumber",g:40}],
  {steps:{nl:["Rooster het volkorenbrood en besmeer met de hüttenkäse.","Beleg met de gerookte zalm.","Werk af met fijne rode ui, komkommer en peper."],en:["Toast the wholegrain bread and spread with the cottage cheese.","Top with the smoked salmon.","Finish with finely chopped red onion, cucumber and pepper."]}});

add("Thaise kipsalade met rijstnoedels & limoen","Thai chicken salad with rice noodles & lime",["lunch"],
  [{slug:"chicken_breast",g:130},{slug:"rice_noodles",g:55},{slug:"carrot",g:60},{slug:"cucumber",g:60},{slug:"soy_sauce",g:10}],
  {steps:{nl:["Week de rijstnoedels gaar en spoel koud.","Gril de kipfilet en snijd in reepjes.","Meng de noedels met julienne van wortel en komkommer, de kip, sojasaus, limoen en verse koriander."],en:["Soak the rice noodles until done and rinse cold.","Grill the chicken and slice.","Toss the noodles with julienned carrot and cucumber, the chicken, soy sauce, lime and fresh coriander."]}});

add("Linzensoep met wortel, prei & volkorenbrood","Lentil soup with carrot, leek & wholegrain bread",["lunch"],
  [{slug:"lentils",g:150},{slug:"carrot",g:80},{slug:"leek",g:60},{slug:"onion",g:40},{slug:"bread_whole",g:60}],
  {vegan:true,tech:"soup",steps:{nl:["Fruit de ui, wortel en prei kort aan.","Voeg de linzen en bouillon toe en laat 15–18 min garen.","Breng op smaak met komijn en peper; serveer met het brood."],en:["Sweat the onion, carrot and leek briefly.","Add the lentils and stock and simmer 15–18 min.","Season with cumin and pepper; serve with the bread."]}});

add("Omelet met magere ham, champignon & paprika","Omelette with lean ham, mushroom & pepper",["lunch","breakfast"],
  [{slug:"egg",g:100},{slug:"egg_white",g:60},{slug:"ham_lean",g:50},{slug:"mushroom",g:60},{slug:"paprika",g:60}],
  {steps:{nl:["Klop het ei met het eiwit los.","Bak de champignons en paprika kort, voeg de ham toe.","Giet het ei erbij en laat op laag vuur stollen."],en:["Whisk the egg with the egg white.","Fry the mushrooms and pepper briefly, add the ham.","Pour in the egg and set on low heat."]}});

add("Rosbief-bowl met zilvervliesrijst, rucola & tomaat","Roast beef bowl with brown rice, rocket & tomato",["lunch"],
  [{slug:"rosbief",g:90},{slug:"brown_rice",g:60},{slug:"rocket",g:40},{slug:"cherry_tomato",g:100},{slug:"olive_oil",g:5}],
  {steps:{nl:["Kook de zilvervliesrijst gaar en laat iets afkoelen.","Schik rijst, rucola en gehalveerde cherrytomaten in een kom.","Verdeel de rosbief erover en besprenkel met olijfolie, citroen en peper."],en:["Cook the brown rice and let cool slightly.","Arrange rice, rocket and halved cherry tomatoes in a bowl.","Spread the roast beef over and drizzle with olive oil, lemon and pepper."]}});

add("Garnalensalade met mango, avocado & little gem","Shrimp salad with mango, avocado & little gem",["lunch"],
  [{slug:"shrimp",g:120},{slug:"mango",g:80},{slug:"avocado",g:40},{slug:"lettuce",g:60},{slug:"cucumber",g:50}],
  {steps:{nl:["Bak de garnalen kort tot ze roze en gaar zijn.","Schik de sla met blokjes mango, avocado en komkommer.","Verdeel de garnalen erover en maak aan met limoen, peper en zout."],en:["Sear the shrimp until pink and done.","Arrange the lettuce with diced mango, avocado and cucumber.","Spread the shrimp over and dress with lime, salt and pepper."]}});

add("Caprese-boterham met mozzarella light, tomaat & basilicum","Caprese sandwich with light mozzarella, tomato & basil",["lunch"],
  [{slug:"bread_whole",g:80},{slug:"mozzarella_light",g:60},{slug:"tomato",g:80},{slug:"pesto",g:8}],
  {veg:true,steps:{nl:["Rooster het volkorenbrood en bestrijk dun met pesto.","Beleg met plakjes mozzarella en tomaat.","Werk af met verse basilicum en peper."],en:["Toast the wholegrain bread and spread thinly with pesto.","Top with mozzarella and tomato slices.","Finish with fresh basil and pepper."]}});

add("Couscous met geroosterde groente & kipfilet","Couscous with roasted vegetables & chicken",["lunch","dinner"],
  [{slug:"couscous",g:60},{slug:"chicken_breast",g:130},{slug:"eggplant",g:80},{slug:"paprika",g:80},{slug:"olive_oil",g:6}],
  {tech:"oven",steps:{nl:["Rooster de aubergine en paprika met de olijfolie 20 min op 200°C.","Wel de couscous met heet water tot gaar en roer los.","Bak de kipfilet gaar, snijd aan en meng met de couscous en geroosterde groente."],en:["Roast the eggplant and pepper with the olive oil 20 min at 200°C.","Soak the couscous in hot water until done and fluff.","Cook the chicken, slice and mix with the couscous and roasted vegetables."]}});

// --- diner ---
add("Kipcurry met kokosmelk light, paprika & rijst","Chicken curry with light coconut milk, pepper & rice",["dinner"],
  [{slug:"chicken_breast",g:150},{slug:"rice_dry",g:65},{slug:"coconut_light",g:80},{slug:"paprika",g:100},{slug:"curry_paste",g:20}],
  {steps:{nl:["Kook de rijst gaar.","Bak de currypasta kort aan, voeg de kip en paprika toe en bak mee.","Blus af met de kokosmelk en laat 8 min pruttelen; serveer over de rijst."],en:["Cook the rice.","Fry the curry paste briefly, add the chicken and pepper and cook.","Deglaze with the coconut milk and simmer 8 min; serve over the rice."]}});

add("Zalm-teriyaki met zilvervliesrijst & broccoli","Salmon teriyaki with brown rice & broccoli",["dinner"],
  [{slug:"salmon",g:140},{slug:"brown_rice",g:65},{slug:"broccoli",g:150},{slug:"teriyaki",g:25}],
  {steps:{nl:["Kook de zilvervliesrijst gaar.","Bak de zalm kort aan beide kanten en lak met de teriyaki.","Stoom de broccoli beetgaar en serveer over de rijst."],en:["Cook the brown rice.","Sear the salmon on both sides and glaze with the teriyaki.","Steam the broccoli until tender and serve over the rice."]}});

add("Witvis uit de oven met tomaat, courgette & aardappel","Oven white fish with tomato, zucchini & potato",["dinner"],
  [{slug:"white_fish",g:160},{slug:"potato",g:220},{slug:"zucchini",g:120},{slug:"cherry_tomato",g:100},{slug:"olive_oil",g:6}],
  {tech:"oven",steps:{nl:["Snijd de aardappel en courgette, hussel met olijfolie en rooster 20 min op 200°C.","Leg de witvis met cherrytomaten de laatste 12 min erbij.","Breng op smaak met citroen, peper en zout."],en:["Slice the potato and zucchini, toss with olive oil and roast 20 min at 200°C.","Add the white fish with cherry tomatoes for the final 12 min.","Season with lemon, salt and pepper."]}});

add("Kipgehakt-bolognese met volkoren pasta & courgette","Chicken mince bolognese with wholegrain pasta & zucchini",["dinner"],
  [{slug:"chicken_mince",g:150},{slug:"pasta_whole",g:75},{slug:"passata",g:150},{slug:"zucchini",g:100},{slug:"onion",g:40}],
  {steps:{nl:["Kook de volkoren pasta beetgaar.","Rul het kipgehakt met de ui, voeg de passata en blokjes courgette toe.","Laat 10 min pruttelen met Italiaanse kruiden en schep over de pasta."],en:["Cook the wholegrain pasta al dente.","Brown the chicken mince with the onion, add the passata and diced zucchini.","Simmer 10 min with Italian herbs and spoon over the pasta."]}});

add("Kip-fajita bowl met paprika, zwarte bonen & rijst","Chicken fajita bowl with pepper, black beans & rice",["dinner"],
  [{slug:"chicken_breast",g:150},{slug:"rice_dry",g:60},{slug:"paprika",g:100},{slug:"black_beans",g:100},{slug:"onion",g:40}],
  {steps:{nl:["Kook de rijst gaar.","Bak de kip met fajitakruiden, paprika en ui op hoog vuur.","Verwarm de zwarte bonen en schik alles over de rijst; werk af met limoen."],en:["Cook the rice.","Fry the chicken with fajita spice, pepper and onion on high heat.","Warm the black beans and arrange everything over the rice; finish with lime."]}});

add("Biefstuk met zoete-aardappelfriet & salade","Steak with sweet potato fries & salad",["dinner"],
  [{slug:"beef_lean",g:150},{slug:"sweet_potato",g:220},{slug:"lettuce",g:60},{slug:"tomato",g:80},{slug:"olive_oil",g:6}],
  {tech:"oven",steps:{nl:["Snijd de zoete aardappel in frieten, hussel met olijfolie en bak 25 min op 220°C.","Bak de biefstuk 2–3 min per kant en laat rusten.","Serveer met een frisse salade van sla en tomaat."],en:["Cut the sweet potato into fries, toss with olive oil and bake 25 min at 220°C.","Sear the steak 2–3 min per side and rest.","Serve with a fresh salad of lettuce and tomato."]}});

add("Zalm sous-vide 50°C met aardappel & asperges","Sous-vide salmon 50°C with potato & asparagus",["dinner"],
  [{slug:"salmon",g:140},{slug:"potato",g:220},{slug:"asparagus",g:120},{slug:"olive_oil",g:5}],
  {tech:"sousvide",temp:"50°C",steps:{nl:["Vacumeer de zalm met wat olijfolie en citroen en gaar sous-vide op 50°C (30–40 min).","Kook de aardappels gaar en stoom de asperges beetgaar.","Schroei de zalm eventueel kort op de velkant en serveer met de groente."],en:["Vacuum-seal the salmon with a little olive oil and lemon and cook sous-vide at 50°C (30–40 min).","Boil the potatoes and steam the asparagus until tender.","Optionally sear the salmon briefly skin-side and serve with the vegetables."]}});

add("Kalkoen-roerbak met cashew, paprika & rijst","Turkey stir-fry with cashew, pepper & rice",["dinner"],
  [{slug:"turkey_breast",g:150},{slug:"rice_dry",g:65},{slug:"paprika",g:100},{slug:"cashew",g:15},{slug:"soy_sauce",g:12}],
  {steps:{nl:["Kook de rijst gaar.","Roerbak de kalkoenreepjes op hoog vuur, voeg de paprika toe.","Blus af met sojasaus, roer de cashewnoten erdoor en serveer over de rijst."],en:["Cook the rice.","Stir-fry the turkey strips on high heat, add the pepper.","Deglaze with soy sauce, stir in the cashews and serve over the rice."]}});

add("Garnalencurry met kokosmelk light & rijst","Shrimp curry with light coconut milk & rice",["dinner"],
  [{slug:"shrimp",g:140},{slug:"rice_dry",g:65},{slug:"coconut_light",g:80},{slug:"paprika",g:80},{slug:"curry_paste",g:20}],
  {steps:{nl:["Kook de rijst gaar.","Bak de currypasta kort, voeg de paprika en kokosmelk toe en laat pruttelen.","Voeg de garnalen toe en gaar 3–4 min tot ze roze zijn; serveer over de rijst."],en:["Cook the rice.","Fry the curry paste briefly, add the pepper and coconut milk and simmer.","Add the shrimp and cook 3–4 min until pink; serve over the rice."]}});

add("Tofu-teriyaki met noedels & broccoli","Tofu teriyaki with noodles & broccoli",["dinner"],
  [{slug:"tofu",g:180},{slug:"noodles_whole",g:70},{slug:"broccoli",g:150},{slug:"teriyaki",g:25}],
  {vegan:true,steps:{nl:["Kook de volkoren noedels beetgaar.","Bak de tofublokjes goudbruin en knapperig.","Voeg de broccoli en teriyaki toe, roerbak beetgaar en meng de noedels erdoor."],en:["Cook the whole-wheat noodles al dente.","Fry the tofu until golden and crisp.","Add the broccoli and teriyaki, stir-fry until tender and toss the noodles through."]}});

add("Kip-souvlaki met bulgur, tzatziki & tomaat","Chicken souvlaki with bulgur, tzatziki & tomato",["dinner"],
  [{slug:"chicken_breast",g:150},{slug:"bulgur",g:60},{slug:"yoghurt_lowfat",g:60},{slug:"cucumber",g:60},{slug:"tomato",g:80}],
  {steps:{nl:["Kook de bulgur gaar.","Rijg de gekruide kip en gril gaar.","Rasp de komkommer en meng met de yoghurt en knoflook tot tzatziki; serveer met de bulgur en tomaat."],en:["Cook the bulgur.","Skewer the seasoned chicken and grill.","Grate the cucumber and mix with the yoghurt and garlic into tzatziki; serve with the bulgur and tomato."]}});

add("Linzen-dal met rijst & spinazie","Lentil dal with rice & spinach",["dinner"],
  [{slug:"lentils",g:180},{slug:"rice_dry",g:60},{slug:"spinach",g:80},{slug:"onion",g:40},{slug:"curry_paste",g:15}],
  {vegan:true,steps:{nl:["Kook de rijst gaar.","Fruit de ui met de currypasta, voeg de linzen en een scheut water toe en laat 10 min pruttelen.","Roer de spinazie erdoor tot geslonken en serveer over de rijst."],en:["Cook the rice.","Fry the onion with the curry paste, add the lentils and a splash of water and simmer 10 min.","Stir the spinach through until wilted and serve over the rice."]}});

add("Gevulde paprika met kipgehakt, rijst & tomaat","Stuffed pepper with chicken mince, rice & tomato",["dinner"],
  [{slug:"paprika",g:160},{slug:"chicken_mince",g:120},{slug:"rice_dry",g:50},{slug:"passata",g:100},{slug:"onion",g:40}],
  {tech:"oven",steps:{nl:["Kook de rijst gaar en rul het kipgehakt met de ui.","Meng de rijst, het gehakt en de passata met kruiden.","Vul de halve paprika's en bak 25 min op 200°C tot gaar."],en:["Cook the rice and brown the chicken mince with the onion.","Mix the rice, mince and passata with herbs.","Fill the pepper halves and bake 25 min at 200°C until done."]}});

add("Witvis met kerrie, bloemkool & rijst","White fish with curry, cauliflower & rice",["dinner"],
  [{slug:"white_fish",g:160},{slug:"rice_dry",g:65},{slug:"cauliflower",g:150},{slug:"coconut_light",g:60},{slug:"curry_paste",g:15}],
  {steps:{nl:["Kook de rijst gaar.","Bak de currypasta kort, voeg de kokosmelk en bloemkoolroosjes toe en gaar 8 min.","Leg de witvis erin en pocheer 5–6 min tot gaar; serveer met de rijst."],en:["Cook the rice.","Fry the curry paste briefly, add the coconut milk and cauliflower florets and cook 8 min.","Lay the white fish in and poach 5–6 min until done; serve with the rice."]}});

add("Rundergehakt-chili con carne met kidneybonen & rijst","Beef chili con carne with kidney beans & rice",["dinner"],
  [{slug:"beef_mince5",g:140},{slug:"kidney_beans",g:120},{slug:"passata",g:150},{slug:"corn",g:60},{slug:"rice_dry",g:60}],
  {steps:{nl:["Kook de rijst gaar.","Rul het gehakt, voeg de passata, kidneybonen en mais toe met komijn, paprikapoeder en chili.","Laat 12 min pruttelen en serveer over de rijst."],en:["Cook the rice.","Brown the mince, add the passata, kidney beans and corn with cumin, paprika and chili.","Simmer 12 min and serve over the rice."]}});

add("Kabeljauw met erwtenpuree & aardappel","Cod with pea mash & potato",["dinner"],
  [{slug:"cod",g:160},{slug:"potato",g:220},{slug:"peas",g:150},{slug:"olive_oil",g:5}],
  {steps:{nl:["Kook de aardappels gaar.","Kook de doperwten kort en pureer ze grof met wat peper en munt.","Bak de kabeljauw 3–4 min per kant tot gaar en serveer met de puree en aardappel."],en:["Boil the potatoes.","Cook the peas briefly and mash coarsely with pepper and mint.","Pan-fry the cod 3–4 min per side until done and serve with the mash and potato."]}});

add("Kipdij sous-vide 65°C met zoete aardappel & groente","Sous-vide chicken thigh 65°C with sweet potato & vegetables",["dinner"],
  [{slug:"chicken_thigh",g:150},{slug:"sweet_potato",g:200},{slug:"green_beans",g:120},{slug:"olive_oil",g:5}],
  {tech:"sousvide",temp:"65°C",steps:{nl:["Vacumeer de kipdij en gaar sous-vide op 65°C (1,5–4 u) tot mals en gaar.","Rooster de zoete aardappel in de oven op 200°C in ca. 25 min.","Stoom de sperziebonen beetgaar, schroei de kipdij kort aan en serveer samen."],en:["Vacuum-seal the chicken thigh and cook sous-vide at 65°C (1.5–4 h) until tender and done.","Roast the sweet potato in the oven at 200°C for about 25 min.","Steam the green beans, sear the thigh briefly and serve together."]}});

// --- snack ---
add("Volkoren crackers met magere kaas & komkommer","Wholegrain crackers with low-fat cheese & cucumber",["snack"],
  [{slug:"crackers_whole",g:24},{slug:"low_fat_cheese",g:30},{slug:"cucumber",g:40}],
  {veg:true,tech:"assembly",steps:{nl:["Beleg de crackers met plakjes magere kaas.","Leg er dunne plakjes komkommer op.","Maal er wat peper over."],en:["Top the crackers with slices of low-fat cheese.","Add thin cucumber slices.","Grind some pepper over."]}});

add("Proteïne-energieballen van dadel, havermout & pindakaas","Protein energy balls of date, oats & peanut butter",["snack"],
  [{slug:"dates",g:60},{slug:"oats",g:30},{slug:"peanut_butter",g:15},{slug:"whey",g:15}],
  {veg:true,tech:"blender",steps:{nl:["Pureer de dadels met de havermout, pindakaas en whey tot een kleverige massa.","Rol er balletjes van.","Laat 30 min opstijven in de koelkast."],en:["Blend the dates with the oats, peanut butter and whey into a sticky mass.","Roll into balls.","Chill 30 min to firm up."]}});

add("Kwark met mango & pompoenpitten","Quark with mango & pumpkin seeds",["snack"],
  [{slug:"quark_lowfat",g:150},{slug:"mango",g:70},{slug:"pumpkin_seeds",g:10}],
  {veg:true,tech:"assembly",steps:{nl:["Schep de kwark in een kom.","Top met blokjes mango.","Strooi de pompoenpitten erover."],en:["Spoon the quark into a bowl.","Top with diced mango.","Scatter the pumpkin seeds over."]}});

add("Hüttenkäse met komkommer & tomaat","Cottage cheese with cucumber & tomato",["snack"],
  [{slug:"cottage",g:150},{slug:"cucumber",g:60},{slug:"cherry_tomato",g:60}],
  {veg:true,tech:"assembly",steps:{nl:["Schep de hüttenkäse in een kom.","Meng er blokjes komkommer en gehalveerde cherrytomaat door.","Breng op smaak met peper en wat bieslook."],en:["Spoon the cottage cheese into a bowl.","Mix in diced cucumber and halved cherry tomato.","Season with pepper and some chives."]}});

add("Rijstwafels met pindakaas & banaan","Rice cakes with peanut butter & banana",["snack"],
  [{slug:"rice_cakes",g:26},{slug:"peanut_butter",g:15},{slug:"banana",g:60}],
  {veg:true,vegan:true,tech:"assembly",steps:{nl:["Besmeer de rijstwafels dun met pindakaas.","Beleg met schijfjes banaan."],en:["Spread the rice cakes thinly with peanut butter.","Top with banana slices."]}});

add("Appel met pindakaas","Apple with peanut butter",["snack"],
  [{slug:"apple",g:150},{slug:"peanut_butter",g:15}],
  {veg:true,vegan:true,tech:"assembly",steps:{nl:["Snijd de appel in partjes.","Dip ze in de pindakaas."],en:["Slice the apple into wedges.","Dip them in the peanut butter."]}});

add("Skyr met havermout & frambozen","Skyr with oats & raspberries",["snack"],
  [{slug:"skyr",g:150},{slug:"oats",g:25},{slug:"raspberry",g:60}],
  {veg:true,tech:"assembly",steps:{nl:["Meng de skyr met de havermout.","Top met de frambozen."],en:["Mix the skyr with the oats.","Top with the raspberries."]}});

add("Peer met walnoten & kaneel","Pear with walnuts & cinnamon",["snack"],
  [{slug:"pear",g:150},{slug:"walnuts",g:12},{slug:"quark_lowfat",g:80}],
  {veg:true,tech:"assembly",steps:{nl:["Snijd de peer in partjes.","Serveer met een lepel kwark, grof gehakte walnoten en een snuf kaneel."],en:["Slice the pear into wedges.","Serve with a spoon of quark, roughly chopped walnuts and a pinch of cinnamon."]}});

// ========================= BLOK 4 (wereldkeukens & meer) =========================
// --- ontbijt ---
add("Volkoren wrap met roerei, champignon & tomaat","Wholegrain wrap with scrambled egg, mushroom & tomato",["breakfast"],
  [{slug:"egg",g:100},{slug:"egg_white",g:60},{slug:"mushroom",g:60},{slug:"tomato",g:60},{slug:"wrap_whole",g:60}],
  {veg:true,steps:{nl:["Klop het ei met het eiwit los.","Bak de champignons tot ze kleuren, giet het ei erbij en roer tot een zacht roerei.","Warm de wrap, beleg met het roerei en plakjes tomaat en rol op."],en:["Whisk the egg with the egg white.","Fry the mushrooms until coloured, add the egg and stir to soft scrambled egg.","Warm the wrap, fill with the egg and tomato and roll up."]}});

add("Sojayoghurt met havermout, banaan & chiazaad","Soy yoghurt with oats, banana & chia",["breakfast"],
  [{slug:"soy_yoghurt",g:200},{slug:"oats",g:45},{slug:"banana",g:80},{slug:"chia",g:10}],
  {vegan:true,steps:{nl:["Meng de sojayoghurt met de havermout en het chiazaad.","Laat 10 min staan tot het indikt.","Top met schijfjes banaan."],en:["Mix the soy yoghurt with the oats and chia.","Let stand 10 min to thicken.","Top with banana slices."]}});

add("Volkorenbrood met hüttenkäse, aardbei & honing","Wholegrain bread with cottage cheese, strawberry & honey",["breakfast"],
  [{slug:"bread_whole",g:70},{slug:"cottage",g:80},{slug:"strawberry",g:60},{slug:"honey",g:8}],
  {veg:true,tech:"assembly",steps:{nl:["Rooster het volkorenbrood en besmeer met de hüttenkäse.","Beleg met plakjes aardbei.","Druppel de honing erover."],en:["Toast the wholegrain bread and spread with the cottage cheese.","Top with strawberry slices.","Drizzle the honey over."]}});

add("Omelet met gerookte zalm, spinazie & tomaat","Omelette with smoked salmon, spinach & tomato",["breakfast","lunch"],
  [{slug:"egg",g:100},{slug:"egg_white",g:60},{slug:"smoked_salmon",g:50},{slug:"spinach",g:40},{slug:"tomato",g:50}],
  {steps:{nl:["Klop het ei met het eiwit los en bak een omelet in een antiaanbakpan.","Beleg de ene helft met spinazie, tomaat en gerookte zalm.","Klap dicht en laat kort nagaren."],en:["Whisk the egg with the egg white and cook an omelette in a non-stick pan.","Top one half with spinach, tomato and smoked salmon.","Fold over and cook briefly."]}});

add("Kwark-smoothie met mango, sinaasappel & havermout","Quark smoothie with mango, orange & oats",["breakfast"],
  [{slug:"quark_lowfat",g:200},{slug:"mango",g:80},{slug:"orange",g:100},{slug:"oats",g:30}],
  {veg:true,tech:"blender",steps:{nl:["Doe de kwark, mango, het sinaasappelsap en de havermout in de blender.","Mix glad.","Schenk in een glas of kom."],en:["Add the quark, mango, orange juice and oats to the blender.","Blend smooth.","Pour into a glass or bowl."]}});

add("Havermout met havermelk, peer & walnoot","Oatmeal with oat milk, pear & walnut",["breakfast"],
  [{slug:"oats",g:70},{slug:"oat_milk",g:250},{slug:"pear",g:100},{slug:"walnuts",g:10}],
  {vegan:true,steps:{nl:["Breng de havermout met de havermelk al roerend aan de kook en gaar 3–4 min.","Roer er een snuf kaneel door.","Top met blokjes peer en grof gehakte walnoten."],en:["Bring the oats and oat milk to a simmer, stirring, and cook 3–4 min.","Stir in a pinch of cinnamon.","Top with diced pear and roughly chopped walnuts."]}});

add("Eiermuffins met groente & magere kaas","Egg muffins with vegetables & low-fat cheese",["breakfast","snack"],
  [{slug:"egg",g:150},{slug:"paprika",g:60},{slug:"spinach",g:40},{slug:"low_fat_cheese",g:30}],
  {veg:true,tech:"oven",steps:{nl:["Klop de eieren los met peper en zout.","Verdeel fijne paprika, spinazie en magere kaas over muffinvormpjes en giet het ei erbij.","Bak 18–20 min op 180°C tot gestold."],en:["Whisk the eggs with salt and pepper.","Divide finely chopped pepper, spinach and low-fat cheese over muffin cups and pour the egg in.","Bake 18–20 min at 180°C until set."]}});

add("Proteïnepannenkoek met blauwe bessen","Protein pancake with blueberries",["breakfast"],
  [{slug:"oats",g:50},{slug:"egg",g:50},{slug:"egg_white",g:60},{slug:"whey",g:15},{slug:"blueberries",g:60}],
  {veg:true,steps:{nl:["Pureer de havermout, het ei, eiwit en de whey tot een glad beslag.","Bak er pannenkoekjes van in een antiaanbakpan.","Top met blauwe bessen."],en:["Blend the oats, egg, egg white and whey into a smooth batter.","Cook pancakes in a non-stick pan.","Top with blueberries."]}});

add("Volkoren tosti met magere kaas, ham & tomaat","Wholegrain toastie with low-fat cheese, ham & tomato",["breakfast","lunch"],
  [{slug:"bread_whole",g:80},{slug:"low_fat_cheese",g:30},{slug:"ham_lean",g:40},{slug:"tomato",g:50}],
  {steps:{nl:["Beleg een snee volkorenbrood met magere kaas, ham en plakjes tomaat.","Leg de tweede snee erop.","Rooster in een tostiapparaat of koekenpan tot goudbruin."],en:["Top a slice of wholegrain bread with low-fat cheese, ham and tomato.","Place the second slice on top.","Toast in a sandwich press or pan until golden."]}});

add("Skyr met havermout, druiven & amandel","Skyr with oats, grapes & almonds",["breakfast","snack"],
  [{slug:"skyr",g:200},{slug:"oats",g:35},{slug:"grapes",g:80},{slug:"almonds",g:10}],
  {veg:true,steps:{nl:["Meng de skyr met de havermout.","Top met gehalveerde druiven.","Strooi grof gehakte amandelen erover."],en:["Mix the skyr with the oats.","Top with halved grapes.","Scatter roughly chopped almonds over."]}});

// --- lunch ---
add("Sushi-bowl met zalm, rijst, komkommer & edamame","Sushi bowl with salmon, rice, cucumber & edamame",["lunch","dinner"],
  [{slug:"salmon",g:120},{slug:"rice_dry",g:65},{slug:"cucumber",g:60},{slug:"edamame",g:60},{slug:"soy_sauce",g:10}],
  {steps:{nl:["Kook de rijst en breng op smaak met een scheut rijstazijn.","Snijd de zalm in blokjes (sushikwaliteit) of gaar 'm kort.","Schik rijst, zalm, komkommer en edamame in een kom; besprenkel met sojasaus en sesam."],en:["Cook the rice and season with a splash of rice vinegar.","Cube the salmon (sushi-grade) or sear it briefly.","Arrange rice, salmon, cucumber and edamame in a bowl; drizzle with soy sauce and sesame."]}});

add("Spaanse aardappel-tortilla met salade","Spanish potato tortilla with salad",["lunch"],
  [{slug:"egg",g:150},{slug:"potato",g:150},{slug:"onion",g:50},{slug:"lettuce",g:60},{slug:"olive_oil",g:6}],
  {veg:true,steps:{nl:["Bak dunne plakjes aardappel en ui zacht in de olijfolie.","Klop de eieren los, giet erbij en gaar de tortilla op laag vuur rondom.","Serveer met een frisse salade."],en:["Soften thin potato slices and onion in the olive oil.","Whisk the eggs, pour in and cook the tortilla through on low heat.","Serve with a fresh salad."]}});

add("Griekse salade met feta, olijven & volkoren pita","Greek salad with feta, olives & wholegrain pita",["lunch"],
  [{slug:"feta_light",g:50},{slug:"cucumber",g:100},{slug:"tomato",g:120},{slug:"red_onion",g:30},{slug:"olives",g:20},{slug:"pita_whole",g:60}],
  {veg:true,steps:{nl:["Snijd komkommer, tomaat en rode ui grof.","Meng met de olijven en blokjes feta.","Maak aan met citroen, oregano en peper; serveer met de warme pita."],en:["Roughly chop cucumber, tomato and red onion.","Mix with the olives and cubed feta.","Dress with lemon, oregano and pepper; serve with the warm pita."]}});

add("Quinoasalade met butternut, feta & rucola","Quinoa salad with butternut, feta & rocket",["lunch"],
  [{slug:"quinoa",g:60},{slug:"butternut",g:150},{slug:"feta_light",g:40},{slug:"rocket",g:40},{slug:"olive_oil",g:6}],
  {veg:true,tech:"oven",steps:{nl:["Rooster de butternut-blokjes met de olijfolie 25 min op 200°C.","Kook de quinoa gaar en laat afkoelen.","Meng met de rucola en butternut, verkruimel de feta erover."],en:["Roast the butternut cubes with the olive oil 25 min at 200°C.","Cook the quinoa and let cool.","Mix with the rocket and butternut, crumble the feta over."]}});

add("Tonijn-rijstsalade met mais, paprika & bosui","Tuna rice salad with corn, pepper & spring onion",["lunch"],
  [{slug:"tuna_can",g:100},{slug:"rice_dry",g:60},{slug:"corn",g:70},{slug:"paprika",g:70},{slug:"spring_onion",g:15}],
  {steps:{nl:["Kook de rijst en laat afkoelen.","Meng met de tonijn, mais, blokjes paprika en bosui.","Maak aan met citroen, peper en zout."],en:["Cook the rice and let cool.","Mix with the tuna, corn, diced pepper and spring onion.","Dress with lemon, salt and pepper."]}});

add("Volkoren noedelsalade met kip, taugé & limoen","Whole-wheat noodle salad with chicken, bean sprouts & lime",["lunch"],
  [{slug:"noodles_whole",g:60},{slug:"chicken_breast",g:130},{slug:"bean_sprouts",g:60},{slug:"carrot",g:50},{slug:"soy_sauce",g:10}],
  {steps:{nl:["Kook de noedels beetgaar en spoel koud.","Gril de kipfilet en snijd in reepjes.","Meng de noedels met taugé, julienne wortel, de kip, sojasaus en limoen."],en:["Cook the noodles al dente and rinse cold.","Grill the chicken and slice.","Toss the noodles with bean sprouts, julienned carrot, the chicken, soy sauce and lime."]}});

add("Linzensalade met gerookte kip, biet & feta","Lentil salad with smoked chicken, beetroot & feta",["lunch"],
  [{slug:"lentils",g:150},{slug:"chicken_breast",g:100},{slug:"beetroot",g:80},{slug:"feta_light",g:30},{slug:"rocket",g:30}],
  {steps:{nl:["Meng de gekookte linzen met blokjes rode biet en rucola.","Verdeel de gerookte kip erover.","Verkruimel de feta erover en maak aan met citroen en peper."],en:["Mix the cooked lentils with diced beetroot and rocket.","Spread the smoked chicken over.","Crumble the feta over and dress with lemon and pepper."]}});

add("Kikkererwtensalade met harissa, komkommer & munt","Chickpea salad with harissa, cucumber & mint",["lunch"],
  [{slug:"chickpeas",g:180},{slug:"cucumber",g:80},{slug:"tomato",g:80},{slug:"harissa",g:15},{slug:"olive_oil",g:5}],
  {vegan:true,steps:{nl:["Meng de kikkererwten met blokjes komkommer en tomaat.","Roer de harissa met de olijfolie en wat citroen tot een dressing.","Schep erdoor en werk af met verse munt."],en:["Mix the chickpeas with diced cucumber and tomato.","Stir the harissa with the olive oil and some lemon into a dressing.","Toss through and finish with fresh mint."]}});

add("Caprese-pastasalade met mozzarella light & tomaat","Caprese pasta salad with light mozzarella & tomato",["lunch"],
  [{slug:"pasta_whole",g:70},{slug:"mozzarella_light",g:60},{slug:"cherry_tomato",g:120},{slug:"rocket",g:30},{slug:"pesto",g:8}],
  {veg:true,steps:{nl:["Kook de volkoren pasta beetgaar en spoel koud.","Meng met gehalveerde cherrytomaten, blokjes mozzarella en rucola.","Roer de pesto erdoor en breng op smaak met peper."],en:["Cook the wholegrain pasta al dente and rinse cold.","Mix with halved cherry tomatoes, cubed mozzarella and rocket.","Stir the pesto through and season with pepper."]}});

add("Misosoep met tofu, taugé & noedels","Miso soup with tofu, bean sprouts & noodles",["lunch"],
  [{slug:"miso",g:20},{slug:"tofu",g:150},{slug:"noodles_whole",g:50},{slug:"bean_sprouts",g:60},{slug:"spring_onion",g:15}],
  {vegan:true,tech:"soup",steps:{nl:["Kook de noedels beetgaar.","Roer de miso los in heet (niet kokend) water.","Voeg de tofublokjes, taugé en noedels toe, verwarm zacht en werk af met bosui."],en:["Cook the noodles al dente.","Whisk the miso into hot (not boiling) water.","Add the tofu cubes, bean sprouts and noodles, warm gently and finish with spring onion."]}});

add("Kipfilet-bowl met zoete aardappel, spruitjes & mosterddressing","Chicken bowl with sweet potato, sprouts & mustard dressing",["lunch","dinner"],
  [{slug:"chicken_breast",g:130},{slug:"sweet_potato",g:180},{slug:"brussels_sprouts",g:120},{slug:"yoghurt_lowfat",g:40},{slug:"mustard",g:5}],
  {tech:"oven",steps:{nl:["Rooster de zoete aardappel en gehalveerde spruitjes 25 min op 200°C.","Gril de kipfilet gaar en snijd aan.","Roer een dressing van yoghurt, mosterd en citroen en schep over de bowl."],en:["Roast the sweet potato and halved sprouts 25 min at 200°C.","Grill the chicken and slice.","Stir a dressing of yoghurt, mustard and lemon and spoon over the bowl."]}});

// --- diner ---
add("Indiase kip-tikka met rijst & komkommer-yoghurt","Indian chicken tikka with rice & cucumber yoghurt",["dinner"],
  [{slug:"chicken_breast",g:150},{slug:"rice_dry",g:65},{slug:"yoghurt_lowfat",g:60},{slug:"cucumber",g:60},{slug:"curry_paste",g:20}],
  {steps:{nl:["Marineer de kipblokjes in de helft van de yoghurt met de currypasta en gril ze gaar.","Kook de rijst gaar.","Rasp de komkommer door de rest van de yoghurt tot een frisse saus; serveer met de rijst."],en:["Marinate the chicken cubes in half the yoghurt with the curry paste and grill until done.","Cook the rice.","Grate the cucumber into the rest of the yoghurt for a cooling sauce; serve with the rice."]}});

add("Zalm uit de oven met butternut & spruitjes","Oven salmon with butternut & sprouts",["dinner"],
  [{slug:"salmon",g:140},{slug:"butternut",g:200},{slug:"brussels_sprouts",g:120},{slug:"olive_oil",g:5}],
  {tech:"oven",steps:{nl:["Rooster de butternut en gehalveerde spruitjes met de olijfolie 25 min op 200°C.","Leg de zalm de laatste 12 min erbij, met peper en citroen.","Serveer samen."],en:["Roast the butternut and halved sprouts with the olive oil 25 min at 200°C.","Add the salmon for the final 12 min, with pepper and lemon.","Serve together."]}});

add("Kip-noedelwok met paksoi & taugé","Chicken noodle wok with bok choy & bean sprouts",["dinner"],
  [{slug:"chicken_breast",g:150},{slug:"noodles_whole",g:70},{slug:"bok_choy",g:120},{slug:"bean_sprouts",g:60},{slug:"soy_sauce",g:12}],
  {steps:{nl:["Kook de noedels beetgaar.","Roerbak de kipreepjes op hoog vuur, voeg paksoi en taugé toe.","Blus af met sojasaus en meng de noedels erdoor."],en:["Cook the noodles al dente.","Stir-fry the chicken strips on high heat, add bok choy and bean sprouts.","Deglaze with soy sauce and toss the noodles through."]}});

add("Spaghetti met garnalen, cherrytomaat & rucola","Spaghetti with shrimp, cherry tomato & rocket",["dinner"],
  [{slug:"pasta_whole",g:75},{slug:"shrimp",g:130},{slug:"cherry_tomato",g:120},{slug:"rocket",g:30},{slug:"olive_oil",g:6}],
  {steps:{nl:["Kook de volkoren spaghetti beetgaar.","Bak de garnalen met knoflook in de olijfolie, voeg de cherrytomaten toe.","Meng de pasta en rucola erdoor en breng op smaak met peper en citroen."],en:["Cook the wholegrain spaghetti al dente.","Fry the shrimp with garlic in the olive oil, add the cherry tomatoes.","Toss the pasta and rocket through and season with pepper and lemon."]}});

add("Gegrilde kip met polenta & gegrilde groente","Grilled chicken with polenta & grilled vegetables",["dinner"],
  [{slug:"chicken_breast",g:150},{slug:"polenta",g:200},{slug:"zucchini",g:100},{slug:"paprika",g:80},{slug:"olive_oil",g:6}],
  {steps:{nl:["Verwarm de polenta volgens de verpakking tot een zachte brij.","Gril de courgette en paprika in een grillpan.","Gril de kipfilet gaar, snijd aan en serveer op de polenta met de groente."],en:["Warm the polenta per the pack into a soft mash.","Griddle the zucchini and pepper.","Grill the chicken, slice and serve on the polenta with the vegetables."]}});

add("Marokkaanse kiptagine met couscous & butternut","Moroccan chicken tagine with couscous & butternut",["dinner"],
  [{slug:"chicken_thigh",g:150},{slug:"couscous",g:60},{slug:"butternut",g:150},{slug:"onion",g:40},{slug:"chickpeas",g:60}],
  {tech:"soup",steps:{nl:["Stoof de kipdij met ui, butternut en kikkererwten aan; voeg ras el hanout en bouillon toe.","Laat 25 min zachtjes stoven tot alles gaar is.","Wel de couscous in het hete stoofvocht onder folie en serveer met de tagine."],en:["Sweat the chicken thigh with onion, butternut and chickpeas; add ras el hanout and stock.","Simmer gently 25 min until tender.","Soak the couscous in the hot broth under foil and serve with the tagine."]}});

add("Witvis met venkel, aardappel & citroen","White fish with fennel, potato & lemon",["dinner"],
  [{slug:"white_fish",g:160},{slug:"potato",g:220},{slug:"fennel",g:120},{slug:"olive_oil",g:6}],
  {tech:"oven",steps:{nl:["Snijd de venkel en aardappel, hussel met olijfolie en rooster 22 min op 200°C.","Leg de witvis de laatste 12 min erbij, met citroen en peper.","Serveer met wat venkelgroen."],en:["Slice the fennel and potato, toss with olive oil and roast 22 min at 200°C.","Add the white fish for the final 12 min, with lemon and pepper.","Serve with some fennel fronds."]}});

add("Moussaka light met aubergine, rundergehakt & aardappel","Light moussaka with eggplant, beef mince & potato",["dinner"],
  [{slug:"beef_mince5",g:140},{slug:"eggplant",g:150},{slug:"potato",g:180},{slug:"passata",g:120},{slug:"onion",g:40}],
  {tech:"oven",steps:{nl:["Gril plakken aubergine en kook plakken aardappel voor.","Rul het gehakt met ui en passata en breng op smaak met kaneel en oregano.","Laag aardappel, aubergine en gehakt in een ovenschaal en bak 25 min op 200°C."],en:["Griddle eggplant slices and pre-cook potato slices.","Brown the mince with onion and passata and season with cinnamon and oregano.","Layer potato, eggplant and mince in a dish and bake 25 min at 200°C."]}});

add("Teriyaki-zalm met noedels & paksoi","Teriyaki salmon with noodles & bok choy",["dinner"],
  [{slug:"salmon",g:140},{slug:"noodles_whole",g:70},{slug:"bok_choy",g:120},{slug:"teriyaki",g:25}],
  {steps:{nl:["Kook de noedels beetgaar.","Bak de zalm kort en lak met de teriyaki.","Roerbak de paksoi beetgaar, meng de noedels erdoor en serveer met de zalm."],en:["Cook the noodles al dente.","Sear the salmon briefly and glaze with the teriyaki.","Stir-fry the bok choy, toss the noodles through and serve with the salmon."]}});

add("Kip-burrito bowl met zwarte bonen, rijst & salsa","Chicken burrito bowl with black beans, rice & salsa",["dinner"],
  [{slug:"chicken_breast",g:150},{slug:"rice_dry",g:60},{slug:"black_beans",g:100},{slug:"corn",g:60},{slug:"tomato",g:80}],
  {steps:{nl:["Kook de rijst gaar.","Bak de kip met komijn en paprikapoeder; verwarm de zwarte bonen en mais.","Maak een snelle salsa van tomaat, ui en limoen en schik alles over de rijst."],en:["Cook the rice.","Fry the chicken with cumin and paprika; warm the black beans and corn.","Make a quick salsa of tomato, onion and lime and arrange over the rice."]}});

add("Seitan-stroganoff met champignon & zilvervliesrijst","Seitan stroganoff with mushroom & brown rice",["dinner"],
  [{slug:"seitan",g:150},{slug:"brown_rice",g:65},{slug:"mushroom",g:120},{slug:"onion",g:40},{slug:"soy_yoghurt",g:60}],
  {vegan:true,steps:{nl:["Kook de zilvervliesrijst gaar.","Bak de seitanreepjes met ui en champignons bruin.","Roer de sojayoghurt erdoor met mosterd en paprikapoeder; serveer over de rijst."],en:["Cook the brown rice.","Fry the seitan strips with onion and mushrooms until browned.","Stir the soy yoghurt through with mustard and paprika; serve over the rice."]}});

add("Thaise rode curry met kip, paprika & rijst","Thai red curry with chicken, pepper & rice",["dinner"],
  [{slug:"chicken_breast",g:150},{slug:"rice_dry",g:65},{slug:"coconut_light",g:80},{slug:"paprika",g:100},{slug:"curry_paste",g:20}],
  {steps:{nl:["Kook de rijst gaar.","Bak de rode currypasta kort, voeg de kip en paprika toe.","Blus met kokosmelk, laat 8 min pruttelen en werk af met basilicum; serveer over de rijst."],en:["Cook the rice.","Fry the red curry paste briefly, add the chicken and pepper.","Add coconut milk, simmer 8 min and finish with basil; serve over the rice."]}});

add("Gevulde zoete aardappel met kipgehakt & groente","Stuffed sweet potato with chicken mince & vegetables",["dinner"],
  [{slug:"sweet_potato",g:250},{slug:"chicken_mince",g:120},{slug:"paprika",g:60},{slug:"corn",g:50},{slug:"onion",g:30}],
  {tech:"oven",steps:{nl:["Bak de zoete aardappel 45 min heel in de oven op 200°C tot zacht.","Rul het kipgehakt met ui, paprika en mais en breng op smaak.","Snijd de zoete aardappel open en vul met het gehaktmengsel."],en:["Bake the whole sweet potato 45 min at 200°C until soft.","Brown the chicken mince with onion, pepper and corn and season.","Split the sweet potato open and fill with the mince mixture."]}});

add("Biefstuk sous-vide 54°C met zoete aardappel & asperges","Sous-vide steak 54°C with sweet potato & asparagus",["dinner"],
  [{slug:"beef_lean",g:150},{slug:"sweet_potato",g:200},{slug:"asparagus",g:120},{slug:"olive_oil",g:5}],
  {tech:"sousvide",temp:"54°C",steps:{nl:["Vacumeer de biefstuk en gaar sous-vide op 54°C (1,5–4 u) voor medium-rare.","Rooster de zoete aardappel en stoom de asperges beetgaar.","Schroei de biefstuk kort rondom, laat 2 min rusten en snijd aan."],en:["Vacuum-seal the steak and cook sous-vide at 54°C (1.5–4 h) for medium-rare.","Roast the sweet potato and steam the asparagus.","Sear the steak all over, rest 2 min and slice."]}});

add("Kabeljauw in tomaten-venkelsaus met aardappel","Cod in tomato-fennel sauce with potato",["dinner"],
  [{slug:"cod",g:160},{slug:"potato",g:220},{slug:"fennel",g:100},{slug:"passata",g:120},{slug:"onion",g:40}],
  {steps:{nl:["Kook de aardappels gaar.","Stoof de venkel en ui zacht, voeg de passata toe en laat 8 min pruttelen.","Leg de kabeljauw in de saus en pocheer 6–8 min tot gaar; serveer met de aardappel."],en:["Boil the potatoes.","Soften the fennel and onion, add the passata and simmer 8 min.","Lay the cod in the sauce and poach 6–8 min until done; serve with the potato."]}});

add("Vegetarische chili met quinoa, zwarte bonen & mais","Vegetarian chili with quinoa, black beans & corn",["dinner"],
  [{slug:"quinoa",g:60},{slug:"black_beans",g:150},{slug:"corn",g:80},{slug:"passata",g:150},{slug:"paprika",g:80}],
  {vegan:true,steps:{nl:["Kook de quinoa gaar.","Stoof de paprika, voeg passata, zwarte bonen en mais toe met komijn en chili.","Laat 10 min pruttelen en serveer over de quinoa."],en:["Cook the quinoa.","Soften the pepper, add passata, black beans and corn with cumin and chili.","Simmer 10 min and serve over the quinoa."]}});

add("Kipdij-traybake met aardappel, paprika & ui","Chicken thigh traybake with potato, pepper & onion",["dinner"],
  [{slug:"chicken_thigh",g:150},{slug:"potato",g:220},{slug:"paprika",g:100},{slug:"onion",g:50},{slug:"olive_oil",g:6}],
  {tech:"oven",steps:{nl:["Snijd de aardappel, paprika en ui en hussel met de olijfolie en kruiden.","Leg de kipdij erbovenop in een ovenschaal.","Bak 30–35 min op 200°C tot alles gaar en goudbruin is."],en:["Cut the potato, pepper and onion and toss with the olive oil and herbs.","Place the chicken thigh on top in an oven dish.","Bake 30–35 min at 200°C until everything is done and golden."]}});

// --- snack ---
add("Griekse yoghurt met ananas & pompoenpitten","Greek yoghurt with pineapple & pumpkin seeds",["snack"],
  [{slug:"greek_yoghurt",g:150},{slug:"pineapple",g:70},{slug:"pumpkin_seeds",g:10}],
  {veg:true,tech:"assembly",steps:{nl:["Schep de Griekse yoghurt in een kom.","Top met blokjes ananas.","Strooi de pompoenpitten erover."],en:["Spoon the Greek yoghurt into a bowl.","Top with diced pineapple.","Scatter the pumpkin seeds over."]}});

add("Volkoren crackers met hummus & komkommer","Wholegrain crackers with hummus & cucumber",["snack"],
  [{slug:"crackers_whole",g:24},{slug:"hummus_light",g:40},{slug:"cucumber",g:50}],
  {veg:true,vegan:true,tech:"assembly",steps:{nl:["Besmeer de crackers met de hummus.","Beleg met dunne plakjes komkommer."],en:["Spread the crackers with the hummus.","Top with thin cucumber slices."]}});

add("Kwark met aardbei & amandel","Quark with strawberry & almonds",["snack"],
  [{slug:"quark_lowfat",g:150},{slug:"strawberry",g:70},{slug:"almonds",g:10}],
  {veg:true,tech:"assembly",steps:{nl:["Schep de kwark in een kom.","Top met plakjes aardbei en grof gehakte amandelen."],en:["Spoon the quark into a bowl.","Top with sliced strawberry and roughly chopped almonds."]}});

add("Edamame met sojasaus & sesam","Edamame with soy & sesame",["snack"],
  [{slug:"edamame",g:150},{slug:"soy_sauce",g:8},{slug:"sesame",g:5}],
  {veg:true,vegan:true,steps:{nl:["Kook of stoom de edamame 4–5 min.","Besprenkel met sojasaus en bestrooi met sesamzaad."],en:["Boil or steam the edamame 4–5 min.","Drizzle with soy sauce and sprinkle with sesame seeds."]}});

add("Druiven met magere kaas","Grapes with low-fat cheese",["snack"],
  [{slug:"grapes",g:120},{slug:"low_fat_cheese",g:40}],
  {veg:true,tech:"assembly",steps:{nl:["Snijd de magere kaas in blokjes.","Serveer met de druiven als frisse snack."],en:["Cut the low-fat cheese into cubes.","Serve with the grapes as a fresh snack."]}});

add("Rijstwafels met hüttenkäse & tomaat","Rice cakes with cottage cheese & tomato",["snack"],
  [{slug:"rice_cakes",g:26},{slug:"cottage",g:80},{slug:"cherry_tomato",g:50}],
  {veg:true,tech:"assembly",steps:{nl:["Besmeer de rijstwafels met de hüttenkäse.","Beleg met gehalveerde cherrytomaat en wat peper."],en:["Spread the rice cakes with the cottage cheese.","Top with halved cherry tomato and some pepper."]}});

add("Skyr met havermout, appel & kaneel","Skyr with oats, apple & cinnamon",["snack"],
  [{slug:"skyr",g:150},{slug:"oats",g:25},{slug:"apple",g:80}],
  {veg:true,tech:"assembly",steps:{nl:["Meng de skyr met de havermout.","Top met blokjes appel en een snuf kaneel."],en:["Mix the skyr with the oats.","Top with diced apple and a pinch of cinnamon."]}});

// ========================= BLOK 5 (top recepten, meer variatie) =========================
// --- ontbijt ---
add("Franse kruidenomelet met magere kaas","French herb omelette with low-fat cheese",["breakfast"],
  [{slug:"egg",g:120},{slug:"egg_white",g:60},{slug:"low_fat_cheese",g:30}],
  {veg:true,steps:{nl:["Klop het ei met het eiwit los en voeg fijngehakte bieslook en peterselie toe.","Giet in een hete antiaanbakpan met wat spray en roer de eerste seconden.","Strooi de magere kaas erover, vouw de omelet dubbel en serveer romig van binnen."],en:["Whisk the egg with the egg white and add chopped chives and parsley.","Pour into a hot non-stick pan and stir the first few seconds.","Scatter the low-fat cheese over, fold the omelette and serve creamy inside."]}});

add("Volkorenbrood met avocado, ei & chilivlokken","Wholegrain toast with avocado, egg & chili flakes",["breakfast","lunch"],
  [{slug:"bread_whole",g:80},{slug:"avocado",g:50},{slug:"egg",g:55},{slug:"tomato",g:40}],
  {veg:true,steps:{nl:["Rooster het volkorenbrood.","Prak de avocado met citroen, peper en zout en verdeel over het brood.","Leg een gebakken of gepocheerd ei erop en werk af met tomaat en chilivlokken."],en:["Toast the wholegrain bread.","Mash the avocado with lemon, salt and pepper and spread on the toast.","Top with a fried or poached egg and finish with tomato and chili flakes."]}});

add("Chiapudding met kwark & mango","Chia pudding with quark & mango",["breakfast"],
  [{slug:"chia",g:20},{slug:"milk_semi",g:150},{slug:"quark_lowfat",g:100},{slug:"mango",g:80}],
  {veg:true,tech:"assembly",steps:{nl:["Meng het chiazaad met de melk en laat minimaal een nacht opstijven tot pudding.","Roer de kwark erdoor voor extra eiwit.","Top met blokjes mango."],en:["Mix the chia with the milk and let set overnight into a pudding.","Stir the quark through for extra protein.","Top with diced mango."]}});

add("Breakfast burrito met ei, bonen & salsa","Breakfast burrito with egg, beans & salsa",["breakfast","lunch"],
  [{slug:"wrap_whole",g:60},{slug:"egg",g:100},{slug:"black_beans",g:80},{slug:"tomato",g:60},{slug:"paprika",g:40}],
  {veg:true,steps:{nl:["Roer een zacht roerei van de eieren.","Verwarm de zwarte bonen met komijn; maak een snelle salsa van tomaat, paprika en limoen.","Vul de wrap met het roerei, de bonen en salsa en rol strak op."],en:["Make a soft scrambled egg.","Warm the black beans with cumin; make a quick salsa of tomato, pepper and lime.","Fill the wrap with the egg, beans and salsa and roll up tightly."]}});

add("Volkoren proteïnewafels met kwark & bosbes","Wholegrain protein waffles with quark & blueberry",["breakfast"],
  [{slug:"oats",g:50},{slug:"egg",g:50},{slug:"egg_white",g:60},{slug:"whey",g:15},{slug:"quark_lowfat",g:80},{slug:"blueberries",g:60}],
  {veg:true,steps:{nl:["Pureer de havermout, het ei, eiwit en de whey tot een glad beslag.","Bak in een wafelijzer goudbruin en knapperig.","Serveer met een lepel kwark en blauwe bessen."],en:["Blend the oats, egg, egg white and whey into a smooth batter.","Cook in a waffle iron until golden and crisp.","Serve with a spoon of quark and blueberries."]}});

add("Spinazie-feta omelet","Spinach-feta omelette",["breakfast","lunch"],
  [{slug:"egg",g:100},{slug:"egg_white",g:60},{slug:"spinach",g:60},{slug:"feta_light",g:30}],
  {veg:true,steps:{nl:["Slink de spinazie kort in een antiaanbakpan.","Klop het ei met het eiwit los, giet erbij en laat op laag vuur stollen.","Verkruimel de feta erover en vouw de omelet dubbel."],en:["Wilt the spinach briefly in a non-stick pan.","Whisk the egg with the egg white, pour in and set on low heat.","Crumble the feta over and fold the omelette."]}});

add("Groene smoothie met spinazie, banaan, mango & eiwit","Green smoothie with spinach, banana, mango & protein",["breakfast","snack"],
  [{slug:"spinach",g:40},{slug:"banana",g:100},{slug:"mango",g:80},{slug:"whey",g:25},{slug:"milk_semi",g:150}],
  {veg:true,tech:"blender",steps:{nl:["Doe de spinazie, banaan, mango, whey en melk in de blender.","Mix glad.","Schenk in een glas of kom."],en:["Add the spinach, banana, mango, whey and milk to the blender.","Blend smooth.","Pour into a glass or bowl."]}});

add("Volkorenbrood met hüttenkäse, komkommer & radijs","Wholegrain bread with cottage cheese, cucumber & radish",["breakfast","lunch"],
  [{slug:"bread_whole",g:80},{slug:"cottage",g:80},{slug:"cucumber",g:40},{slug:"radish",g:30}],
  {veg:true,tech:"assembly",steps:{nl:["Rooster het volkorenbrood en besmeer met de hüttenkäse.","Beleg met dunne plakjes komkommer en radijs.","Werk af met bieslook en peper."],en:["Toast the wholegrain bread and spread with the cottage cheese.","Top with thin slices of cucumber and radish.","Finish with chives and pepper."]}});

// --- lunch ---
add("Vietnamese bun-bowl met kip & rijstnoedels","Vietnamese bun bowl with chicken & rice noodles",["lunch","dinner"],
  [{slug:"chicken_breast",g:140},{slug:"rice_noodles",g:55},{slug:"carrot",g:60},{slug:"cucumber",g:60},{slug:"bean_sprouts",g:50}],
  {steps:{nl:["Week de rijstnoedels gaar en spoel koud.","Gril de gemarineerde kip en snijd in reepjes.","Schik de noedels met julienne wortel, komkommer en taugé; leg de kip erop en werk af met verse munt, koriander en een limoendressing."],en:["Soak the rice noodles and rinse cold.","Grill the marinated chicken and slice.","Arrange the noodles with julienned carrot, cucumber and bean sprouts; top with the chicken and finish with mint, coriander and a lime dressing."]}});

add("Koreaanse bibimbap met rund, rijst, groente & ei","Korean bibimbap with beef, rice, vegetables & egg",["lunch","dinner"],
  [{slug:"beef_lean",g:120},{slug:"rice_dry",g:65},{slug:"spinach",g:60},{slug:"carrot",g:50},{slug:"egg",g:55},{slug:"gochujang",g:20}],
  {steps:{nl:["Kook de rijst gaar.","Bak het rundvlees kort op hoog vuur; blancheer de spinazie en wortel apart.","Schik alles in een kom over de rijst, leg een gebakken ei erop en serveer met de gochujang."],en:["Cook the rice.","Sear the beef briefly on high heat; blanch the spinach and carrot separately.","Arrange everything in a bowl over the rice, top with a fried egg and serve with the gochujang."]}});

add("Libanese tabouleh met bulgur, peterselie & kikkererwt","Lebanese tabbouleh with bulgur, parsley & chickpeas",["lunch"],
  [{slug:"bulgur",g:50},{slug:"chickpeas",g:120},{slug:"tomato",g:100},{slug:"cucumber",g:60},{slug:"olive_oil",g:6}],
  {vegan:true,steps:{nl:["Wel de bulgur gaar en laat afkoelen.","Hak veel verse peterselie en munt fijn en meng met de bulgur, tomaat, komkommer en kikkererwten.","Maak aan met citroen, olijfolie, peper en zout."],en:["Soak the bulgur and let cool.","Finely chop plenty of fresh parsley and mint and mix with the bulgur, tomato, cucumber and chickpeas.","Dress with lemon, olive oil, salt and pepper."]}});

add("Turkse linzensoep met volkorenbrood","Turkish lentil soup with wholegrain bread",["lunch"],
  [{slug:"lentils",g:150},{slug:"carrot",g:80},{slug:"onion",g:50},{slug:"potato",g:80},{slug:"bread_whole",g:60}],
  {vegan:true,tech:"soup",steps:{nl:["Fruit de ui, wortel en aardappel kort aan met komijn en paprikapoeder.","Voeg de linzen en bouillon toe en laat 20 min garen.","Pureer glad, breng op smaak met citroen en serveer met het brood."],en:["Sweat the onion, carrot and potato with cumin and paprika.","Add the lentils and stock and simmer 20 min.","Blend smooth, season with lemon and serve with the bread."]}});

add("Poké met tofu, edamame & mango","Poké with tofu, edamame & mango",["lunch","dinner"],
  [{slug:"tofu",g:160},{slug:"rice_dry",g:65},{slug:"edamame",g:60},{slug:"mango",g:70},{slug:"soy_sauce",g:10}],
  {vegan:true,steps:{nl:["Kook de rijst en laat iets afkoelen.","Marineer de tofublokjes in sojasaus en bak ze goudbruin.","Schik rijst, tofu, edamame en mango in een kom en besprenkel met sesam en limoen."],en:["Cook the rice and let cool slightly.","Marinate the tofu cubes in soy sauce and fry until golden.","Arrange rice, tofu, edamame and mango in a bowl and drizzle with sesame and lime."]}});

add("Kip-clubsandwich op volkorenbrood met ei & tomaat","Chicken club on wholegrain bread with egg & tomato",["lunch"],
  [{slug:"bread_whole",g:90},{slug:"chicken_breast",g:100},{slug:"egg",g:55},{slug:"tomato",g:50},{slug:"lettuce",g:20}],
  {steps:{nl:["Gril de kipfilet en snijd in plakjes; kook het ei en snijd in plakjes.","Rooster het volkorenbrood.","Stapel met sla, kip, ei en tomaat en een lik mosterd-yoghurt; snijd in driehoeken."],en:["Grill the chicken and slice; boil the egg and slice.","Toast the wholegrain bread.","Stack with lettuce, chicken, egg and tomato and a dab of mustard-yoghurt; cut into triangles."]}});

add("Witte bonensalade met tonijn, rode ui & peterselie","White bean salad with tuna, red onion & parsley",["lunch"],
  [{slug:"white_beans",g:150},{slug:"tuna_can",g:100},{slug:"red_onion",g:30},{slug:"tomato",g:80},{slug:"olive_oil",g:5}],
  {steps:{nl:["Meng de witte bonen met de uitgelekte tonijn.","Voeg fijne rode ui, tomaat en veel peterselie toe.","Maak aan met citroen, olijfolie, peper en zout."],en:["Mix the white beans with the drained tuna.","Add finely chopped red onion, tomato and plenty of parsley.","Dress with lemon, olive oil, salt and pepper."]}});

add("Geroosterde-groentewrap met hummus & feta","Roasted vegetable wrap with hummus & feta",["lunch"],
  [{slug:"wrap_whole",g:60},{slug:"eggplant",g:80},{slug:"paprika",g:80},{slug:"hummus_light",g:30},{slug:"feta_light",g:30}],
  {veg:true,tech:"oven",steps:{nl:["Rooster de aubergine en paprika 20 min op 200°C.","Besmeer de wrap met hummus.","Beleg met de geroosterde groente en verkruimelde feta en rol strak op."],en:["Roast the eggplant and pepper 20 min at 200°C.","Spread the wrap with hummus.","Top with the roasted vegetables and crumbled feta and roll up tightly."]}});

add("Rijstsalade met zalm, edamame & avocado","Rice salad with salmon, edamame & avocado",["lunch","dinner"],
  [{slug:"salmon",g:120},{slug:"rice_dry",g:60},{slug:"edamame",g:60},{slug:"avocado",g:40},{slug:"cucumber",g:50}],
  {steps:{nl:["Kook de rijst en laat afkoelen.","Gaar de zalm kort en pluk in stukken.","Meng de rijst met edamame, komkommer en avocado, leg de zalm erop en besprenkel met sojasaus en limoen."],en:["Cook the rice and let cool.","Cook the salmon briefly and flake.","Mix the rice with edamame, cucumber and avocado, top with the salmon and drizzle with soy sauce and lime."]}});

add("Aziatische kippensoep met noedels & paksoi","Asian chicken soup with noodles & bok choy",["lunch"],
  [{slug:"chicken_breast",g:120},{slug:"noodles_whole",g:55},{slug:"bok_choy",g:100},{slug:"carrot",g:50},{slug:"soy_sauce",g:10}],
  {tech:"soup",steps:{nl:["Trek een heldere bouillon met gember en knoflook.","Gaar de kipreepjes, noedels, paksoi en wortel kort in de bouillon.","Breng op smaak met sojasaus en werk af met bosui."],en:["Make a clear broth with ginger and garlic.","Cook the chicken strips, noodles, bok choy and carrot briefly in the broth.","Season with soy sauce and finish with spring onion."]}});

add("Quinoa-tabouleh met feta & munt","Quinoa tabbouleh with feta & mint",["lunch"],
  [{slug:"quinoa",g:60},{slug:"tomato",g:100},{slug:"cucumber",g:60},{slug:"feta_light",g:40},{slug:"olive_oil",g:6}],
  {veg:true,steps:{nl:["Kook de quinoa gaar en laat afkoelen.","Meng met blokjes tomaat, komkommer en veel verse munt en peterselie.","Verkruimel de feta erover en maak aan met citroen en olijfolie."],en:["Cook the quinoa and let cool.","Mix with diced tomato, cucumber and plenty of fresh mint and parsley.","Crumble the feta over and dress with lemon and olive oil."]}});

add("Wrap met kalkoen, hummus & rucola","Wrap with turkey, hummus & rocket",["lunch"],
  [{slug:"wrap_whole",g:60},{slug:"turkey_breast",g:120},{slug:"hummus_light",g:30},{slug:"rocket",g:30},{slug:"tomato",g:50}],
  {steps:{nl:["Besmeer de wrap met de hummus.","Beleg met plakjes kalkoenfilet, rucola en tomaat.","Rol strak op en snijd doormidden."],en:["Spread the wrap with the hummus.","Top with turkey slices, rocket and tomato.","Roll up tightly and halve."]}});

// --- diner ---
add("Champignonrisotto light met kipfilet","Light mushroom risotto with chicken",["dinner"],
  [{slug:"chicken_breast",g:140},{slug:"rice_dry",g:70},{slug:"mushroom",g:120},{slug:"onion",g:40},{slug:"low_fat_cheese",g:20}],
  {steps:{nl:["Fruit de ui, voeg de rijst toe en blus beetje bij beetje af met warme bouillon tot romig gaar.","Bak de champignons apart en roer ze er met de gegrilde kip doorheen.","Werk af met wat magere kaas en peterselie."],en:["Sweat the onion, add the rice and ladle in warm stock bit by bit until creamy.","Fry the mushrooms separately and stir them through with the grilled chicken.","Finish with a little low-fat cheese and parsley."]}});

add("Tonijnsteak met sojaglaze, rijst & bok choy","Tuna steak with soy glaze, rice & bok choy",["dinner"],
  [{slug:"tuna_steak",g:150},{slug:"rice_dry",g:65},{slug:"bok_choy",g:120},{slug:"soy_sauce",g:12},{slug:"sesame",g:5}],
  {steps:{nl:["Kook de rijst gaar.","Schroei de tonijnsteak 1 min per kant (rosé van binnen) en lak met sojasaus.","Roerbak de paksoi beetgaar; serveer de tonijn aangesneden met sesam."],en:["Cook the rice.","Sear the tuna steak 1 min per side (pink inside) and glaze with soy sauce.","Stir-fry the bok choy; serve the sliced tuna with sesame."]}});

add("Kipshoarmabowl met rijst, salade & knoflooksaus","Chicken shawarma bowl with rice, salad & garlic sauce",["dinner"],
  [{slug:"chicken_breast",g:150},{slug:"rice_dry",g:65},{slug:"tomato",g:60},{slug:"cucumber",g:60},{slug:"yoghurt_lowfat",g:50}],
  {steps:{nl:["Kook de rijst gaar.","Kruid de kipreepjes met shoarmakruiden en bak ze gaar.","Roer een knoflooksaus van yoghurt en citroen; schik rijst, kip en frisse salade en lepel de saus erover."],en:["Cook the rice.","Season the chicken strips with shawarma spice and cook.","Stir a garlic sauce from yoghurt and lemon; arrange rice, chicken and fresh salad and spoon the sauce over."]}});

add("Ovenschotel met kip, zoete aardappel & broccoli","Oven bake with chicken, sweet potato & broccoli",["dinner"],
  [{slug:"chicken_breast",g:150},{slug:"sweet_potato",g:200},{slug:"broccoli",g:150},{slug:"low_fat_cheese",g:25},{slug:"olive_oil",g:5}],
  {tech:"oven",steps:{nl:["Kook de zoete aardappel en broccoli kort voor.","Leg met de kip in een ovenschaal, besprenkel met olijfolie en kruiden.","Bestrooi met magere kaas en bak 20 min op 200°C tot goudbruin."],en:["Pre-cook the sweet potato and broccoli briefly.","Layer with the chicken in a dish, drizzle with olive oil and herbs.","Scatter with low-fat cheese and bake 20 min at 200°C until golden."]}});

add("Vietnamese caramel-kip met rijst","Vietnamese caramel chicken with rice",["dinner"],
  [{slug:"chicken_thigh",g:150},{slug:"rice_dry",g:65},{slug:"soy_sauce",g:12},{slug:"honey",g:10},{slug:"spring_onion",g:15}],
  {steps:{nl:["Kook de rijst gaar.","Karamelliseer de honing kort, voeg de kipdij, sojasaus en wat water toe en laat inkoken tot glazig.","Werk af met bosui en serveer over de rijst."],en:["Cook the rice.","Caramelise the honey briefly, add the chicken thigh, soy sauce and a little water and reduce until glossy.","Finish with spring onion and serve over the rice."]}});

add("Gegrilde tonijnsteak met witte bonen & tomaat","Grilled tuna steak with white beans & tomato",["dinner"],
  [{slug:"tuna_steak",g:150},{slug:"white_beans",g:150},{slug:"cherry_tomato",g:100},{slug:"rocket",g:30},{slug:"olive_oil",g:6}],
  {steps:{nl:["Gril de tonijnsteak 1 min per kant tot rosé.","Verwarm de witte bonen met knoflook en halveer de cherrytomaten.","Schik met rucola, besprenkel met olijfolie en citroen en leg de aangesneden tonijn erop."],en:["Grill the tuna steak 1 min per side to pink.","Warm the white beans with garlic and halve the cherry tomatoes.","Arrange with rocket, drizzle with olive oil and lemon and lay the sliced tuna on top."]}});

add("Kalkoen-chili met bonen & rijst","Turkey chili with beans & rice",["dinner"],
  [{slug:"turkey_mince",g:140},{slug:"kidney_beans",g:120},{slug:"passata",g:150},{slug:"corn",g:60},{slug:"rice_dry",g:60}],
  {steps:{nl:["Kook de rijst gaar.","Rul het kalkoengehakt, voeg passata, kidneybonen en mais toe met komijn en chili.","Laat 12 min pruttelen en serveer over de rijst."],en:["Cook the rice.","Brown the turkey mince, add passata, kidney beans and corn with cumin and chili.","Simmer 12 min and serve over the rice."]}});

add("Zalm en papillote met courgette & tomaat","Salmon en papillote with zucchini & tomato",["dinner"],
  [{slug:"salmon",g:140},{slug:"potato",g:200},{slug:"zucchini",g:100},{slug:"cherry_tomato",g:80}],
  {tech:"oven",steps:{nl:["Kook de aardappels gaar.","Leg de zalm met plakjes courgette en cherrytomaat op bakpapier, besprenkel met citroen en kruiden en vouw een pakketje.","Bak 15 min op 200°C en serveer met de aardappel."],en:["Boil the potatoes.","Place the salmon with zucchini slices and cherry tomato on parchment, drizzle with lemon and herbs and fold a parcel.","Bake 15 min at 200°C and serve with the potato."]}});

add("Kip-saltimbocca light met ham, salie & aardappel","Light chicken saltimbocca with ham, sage & potato",["dinner"],
  [{slug:"chicken_breast",g:150},{slug:"ham_lean",g:30},{slug:"potato",g:220},{slug:"green_beans",g:120}],
  {steps:{nl:["Dek de kipfilet af met een plak magere ham en een paar salieblaadjes en zet vast.","Bak 'm in een hete pan gaar, ham-kant eerst.","Serveer met gekookte aardappel en sperziebonen."],en:["Cover the chicken with a slice of lean ham and a few sage leaves and secure.","Pan-fry until done, ham-side first.","Serve with boiled potato and green beans."]}});

add("Zeebaars met venkel, aardappel & citroen","Sea bass with fennel, potato & lemon",["dinner"],
  [{slug:"sea_bass",g:160},{slug:"potato",g:220},{slug:"fennel",g:120},{slug:"olive_oil",g:6}],
  {tech:"oven",steps:{nl:["Snijd de venkel en aardappel, hussel met olijfolie en rooster 22 min op 200°C.","Leg de zeebaars de laatste 10 min erbij, met citroen en peper.","Serveer met wat venkelgroen."],en:["Slice the fennel and potato, toss with olive oil and roast 22 min at 200°C.","Add the sea bass for the final 10 min, with lemon and pepper.","Serve with some fennel fronds."]}});

add("Enchilada-bowl met kip, bonen & mais","Enchilada bowl with chicken, beans & corn",["dinner"],
  [{slug:"chicken_breast",g:150},{slug:"rice_dry",g:60},{slug:"black_beans",g:100},{slug:"corn",g:60},{slug:"passata",g:100}],
  {steps:{nl:["Kook de rijst gaar.","Bak de kip met komijn en paprikapoeder, voeg passata, bonen en mais toe en laat pruttelen.","Schik over de rijst en werk af met limoen en koriander."],en:["Cook the rice.","Fry the chicken with cumin and paprika, add passata, beans and corn and simmer.","Arrange over the rice and finish with lime and coriander."]}});

add("Thaise basilicum-kip met rijst & ei","Thai basil chicken with rice & egg",["dinner"],
  [{slug:"chicken_mince",g:150},{slug:"rice_dry",g:65},{slug:"paprika",g:80},{slug:"egg",g:55},{slug:"soy_sauce",g:12}],
  {steps:{nl:["Kook de rijst gaar.","Roerbak het kipgehakt op hoog vuur met knoflook en paprika, blus met sojasaus en roer veel Thaise basilicum erdoor.","Bak een ei met krokante randjes en leg het op de rijst met de kip."],en:["Cook the rice.","Stir-fry the chicken mince on high heat with garlic and pepper, deglaze with soy sauce and stir in plenty of Thai basil.","Fry an egg with crispy edges and place it on the rice with the chicken."]}});

add("Paella light met kip, garnaal & rijst","Light paella with chicken, shrimp & rice",["dinner"],
  [{slug:"chicken_breast",g:120},{slug:"shrimp",g:100},{slug:"rice_dry",g:65},{slug:"paprika",g:80},{slug:"peas",g:60}],
  {steps:{nl:["Bak de kip aan, voeg de rijst, paprika en saffraan-bouillon toe.","Laat de rijst garen tot bijna droog.","Leg de garnalen en doperwten er de laatste 5 min bij tot gaar."],en:["Sear the chicken, add the rice, pepper and saffron stock.","Let the rice cook until nearly dry.","Add the shrimp and peas for the final 5 min until done."]}});

add("Gigantes met witte bonen, tomaat & feta","Gigantes with white beans, tomato & feta",["dinner"],
  [{slug:"white_beans",g:200},{slug:"passata",g:150},{slug:"onion",g:50},{slug:"feta_light",g:40},{slug:"bread_whole",g:60}],
  {veg:true,tech:"oven",steps:{nl:["Fruit de ui, voeg de passata en witte bonen toe met oregano en laat 10 min pruttelen.","Schep in een ovenschaal en verkruimel de feta erover.","Bak 15 min op 200°C en serveer met het volkorenbrood."],en:["Sweat the onion, add the passata and white beans with oregano and simmer 10 min.","Spoon into a dish and crumble the feta over.","Bake 15 min at 200°C and serve with the wholegrain bread."]}});

add("Indiase dal makhani light met rijst","Light dal makhani with rice",["dinner"],
  [{slug:"lentils",g:180},{slug:"rice_dry",g:60},{slug:"passata",g:100},{slug:"onion",g:40},{slug:"curry_paste",g:15}],
  {vegan:true,steps:{nl:["Kook de rijst gaar.","Fruit de ui met de currypasta, voeg de linzen en passata toe en laat 15 min zacht pruttelen.","Breng op smaak met wat kaneel en serveer over de rijst."],en:["Cook the rice.","Fry the onion with the curry paste, add the lentils and passata and simmer gently 15 min.","Season with a little cinnamon and serve over the rice."]}});

add("Biefstuk met chimichurri, aardappel & salade","Steak with chimichurri, potato & salad",["dinner"],
  [{slug:"beef_lean",g:150},{slug:"potato",g:220},{slug:"lettuce",g:60},{slug:"tomato",g:60},{slug:"olive_oil",g:6}],
  {steps:{nl:["Kook de aardappels gaar.","Bak de biefstuk 2–3 min per kant en laat rusten.","Maak een chimichurri van peterselie, knoflook, azijn en de olijfolie en lepel over de aangesneden biefstuk; serveer met een frisse salade."],en:["Boil the potatoes.","Sear the steak 2–3 min per side and rest.","Make a chimichurri of parsley, garlic, vinegar and the olive oil and spoon over the sliced steak; serve with a fresh salad."]}});

// --- snack ---
add("Proteïnemuffin van havermout & banaan","Protein muffin of oats & banana",["snack"],
  [{slug:"oats",g:40},{slug:"banana",g:60},{slug:"egg",g:50},{slug:"whey",g:15}],
  {veg:true,tech:"oven",steps:{nl:["Pureer de havermout, banaan, het ei en de whey tot beslag.","Verdeel over muffinvormpjes.","Bak 18 min op 180°C tot gaar."],en:["Blend the oats, banana, egg and whey into a batter.","Divide over muffin cups.","Bake 18 min at 180°C until done."]}});

add("Skyr met granola & aardbei","Skyr with granola & strawberry",["snack"],
  [{slug:"skyr",g:150},{slug:"granola",g:25},{slug:"strawberry",g:60}],
  {veg:true,tech:"assembly",steps:{nl:["Schep de skyr in een kom.","Strooi de granola erover.","Top met plakjes aardbei."],en:["Spoon the skyr into a bowl.","Scatter the granola over.","Top with sliced strawberry."]}});

add("Gerookte-kiprolletjes met komkommer","Smoked chicken rolls with cucumber",["snack"],
  [{slug:"chicken_breast",g:80},{slug:"cottage",g:60},{slug:"cucumber",g:50}],
  {tech:"assembly",steps:{nl:["Besmeer plakjes gerookte kip met hüttenkäse.","Leg er een reepje komkommer op en rol op.","Zet eventueel vast met een prikker."],en:["Spread slices of smoked chicken with cottage cheese.","Place a strip of cucumber on top and roll up.","Secure with a cocktail stick if needed."]}});

add("Hüttenkäse met ananas","Cottage cheese with pineapple",["snack"],
  [{slug:"cottage",g:150},{slug:"pineapple",g:80}],
  {veg:true,tech:"assembly",steps:{nl:["Schep de hüttenkäse in een kom.","Top met blokjes ananas."],en:["Spoon the cottage cheese into a bowl.","Top with diced pineapple."]}});

add("Rijstwafels met kalkoen & mosterd","Rice cakes with turkey & mustard",["snack"],
  [{slug:"rice_cakes",g:26},{slug:"turkey_breast",g:60},{slug:"mustard",g:5},{slug:"cucumber",g:30}],
  {tech:"assembly",steps:{nl:["Bestrijk de rijstwafels dun met mosterd.","Beleg met plakjes kalkoenfilet en komkommer."],en:["Spread the rice cakes thinly with mustard.","Top with turkey slices and cucumber."]}});

add("Skyr met bosvruchten & pompoenpit","Skyr with mixed berries & pumpkin seeds",["snack"],
  [{slug:"skyr",g:150},{slug:"mixed_berries",g:70},{slug:"pumpkin_seeds",g:10}],
  {veg:true,tech:"assembly",steps:{nl:["Schep de skyr in een kom.","Top met de bosvruchten en pompoenpitten."],en:["Spoon the skyr into a bowl.","Top with the mixed berries and pumpkin seeds."]}});

add("Appel met kaneel & kwark","Apple with cinnamon & quark",["snack"],
  [{slug:"apple",g:150},{slug:"quark_lowfat",g:100}],
  {veg:true,tech:"assembly",steps:{nl:["Snijd de appel in partjes.","Serveer met een kommetje kwark en een snuf kaneel om in te dippen."],en:["Slice the apple into wedges.","Serve with a bowl of quark and a pinch of cinnamon to dip."]}});

add("Banaan met pindakaas & kaneel","Banana with peanut butter & cinnamon",["snack"],
  [{slug:"banana",g:120},{slug:"peanut_butter",g:15}],
  {veg:true,vegan:true,tech:"assembly",steps:{nl:["Snijd de banaan in de lengte door.","Besmeer met pindakaas en bestrooi met kaneel."],en:["Slice the banana lengthwise.","Spread with peanut butter and dust with cinnamon."]}});

// ---------- SQL ----------
const usedSlugs = new Set(); dishes.forEach((d) => d.items.forEach((it) => usedSlugs.add(it.slug)));
const esc = (s) => s.replace(/'/g, "''");
let sql = "-- GECUREERDE recepten-seed (handgeschreven, vetarm). Draai NA dish-library.sql.\n";
sql += "-- Vervangt de oude core-set: de DELETE ruimt de gegenereerde gerechten op.\nbegin;\n";
sql += "delete from public.dishes where source='core';\n\n";
sql += "insert into public.ingredients (slug,name_nl,name_en,kcal,protein,carbs,fat,category,source) values\n";
sql += ING.filter((r) => usedSlugs.has(r[0])).map((r) => `('${r[0]}','${esc(r[1])}','${esc(r[2])}',${r[3]},${r[4]},${r[5]},${r[6]},'${r[7]}','core')`).join(",\n");
sql += "\non conflict (slug) do update set kcal=excluded.kcal,protein=excluded.protein,carbs=excluded.carbs,fat=excluded.fat,category=excluded.category,name_nl=excluded.name_nl,name_en=excluded.name_en;\n\n";
sql += "insert into public.dishes (slug,name_nl,name_en,moments,goals,items,tags,prefs,steps,steps_en,technique,temp,source) values\n";
sql += dishes.map((d) => `('${d.slug}','${esc(d.nl)}','${esc(d.en)}',ARRAY[${d.moments.map((m) => `'${m}'`).join(",")}],ARRAY[${d.goals.map((g) => `'${g}'`).join(",")}],'${JSON.stringify(d.items)}'::jsonb,ARRAY[${d.tags.map((t) => `'${t}'`).join(",")}]::text[],ARRAY[${d.prefs.map((p) => `'${p}'`).join(",")}]::text[],'${esc(d.steps)}','${esc(d.steps_en)}','${esc(d.technique)}',${d.temp ? `'${esc(d.temp)}'` : "null"},'core')`).join(",\n");
sql += "\non conflict (slug) do update set name_nl=excluded.name_nl,name_en=excluded.name_en,moments=excluded.moments,goals=excluded.goals,items=excluded.items,tags=excluded.tags,prefs=excluded.prefs,steps=excluded.steps,steps_en=excluded.steps_en,technique=excluded.technique,temp=excluded.temp;\ncommit;\n";
writeFileSync(new URL("./curated-seed.sql", import.meta.url), sql);

// ---------- MARKDOWN (om de recepten te keuren) ----------
const momLabel = { breakfast: "Ontbijt", lunch: "Lunch", dinner: "Diner", snack: "Tussendoortje" };
const goalLabel = { cut: "afvallen", maintain: "onderhoud", gain: "spieropbouw" };
let md = "# HybridFuel — gecureerde recepten (blok 1)\n\n";
md += `${dishes.length} recepten · vetarm · sporter-geschikt · macro's per portie zoals getoond.\n\n`;
for (const mk of ["breakfast", "lunch", "dinner", "snack"]) {
  const inMoment = dishes.filter((d) => d.moments.includes(mk));
  md += `## ${momLabel[mk]} (${inMoment.length})\n\n`;
  inMoment.forEach((d) => {
    const extra = d.moments.filter((m) => m !== mk).map((m) => momLabel[m]);
    md += `### ${d.nl}\n`;
    md += `**${d.mac.kcal} kcal** · ${d.mac.p}g eiwit · ${d.mac.c}g koolhydraten · ${d.mac.f}g vet`;
    md += `  _(${d.goals.map((g) => goalLabel[g]).join(", ")}${extra.length ? " · ook " + extra.join("/") : ""}${d.temp ? " · sous-vide " + d.temp : ""})_\n\n`;
    md += "**Ingrediënten:** " + d.items.map((it) => `${it.g} g ${IMAP[it.slug].nl.toLowerCase()}`).join(" · ") + "\n\n";
    md += "**Bereiding:**\n" + d.steps.split("\n").map((s) => s.replace(/^(\d+)\.\s*/, "$1. ")).join("\n") + "\n\n";
  });
}
writeFileSync(new URL("./curated-recepten.md", import.meta.url), md);

// rapport
const byMoment = { breakfast: 0, lunch: 0, dinner: 0, snack: 0 };
dishes.forEach((d) => d.moments.forEach((m) => byMoment[m]++));
console.log("gerechten:", dishes.length, "| per moment:", byMoment);
let hiFat = dishes.filter((d) => d.mac.f > 22).map((d) => d.nl + " (" + d.mac.f + "g vet)");
console.log("hoog vet (>22g):", hiFat.length ? hiFat.join("; ") : "geen");
dishes.forEach((d) => { if ((d.mac.p * 4) / d.mac.kcal < 0.20) console.log("  laag eiwit%:", d.nl, d.mac); });
