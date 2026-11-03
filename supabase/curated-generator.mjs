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
