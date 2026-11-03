-- GECUREERDE recepten-seed (handgeschreven, vetarm). Draai NA dish-library.sql.
-- Vervangt de oude core-set: de DELETE ruimt de gegenereerde gerechten op.
begin;
delete from public.dishes where source='core';

insert into public.ingredients (slug,name_nl,name_en,kcal,protein,carbs,fat,category,source) values
('chicken_breast','Kipfilet','Chicken breast',120,23,0,2.6,'vlees','core'),
('turkey_breast','Kalkoenfilet','Turkey breast',110,24,0,1.5,'vlees','core'),
('beef_lean','Mager rundvlees','Lean beef',150,21,0,7,'vlees','core'),
('beef_mince5','Rundergehakt 5%','Beef mince 5%',137,21,0,5,'vlees','core'),
('rosbief','Rosbief','Roast beef',120,22,0,3,'vlees','core'),
('cod','Kabeljauw','Cod',82,18,0,0.7,'vis','core'),
('white_fish','Witvis','White fish',85,18,0,1,'vis','core'),
('salmon','Zalm','Salmon',208,20,0,13,'vis','core'),
('smoked_salmon','Gerookte zalm','Smoked salmon',180,22,0,10,'vis','core'),
('tuna_can','Tonijn (uit blik)','Tuna (canned)',100,23,0,1,'vis','core'),
('shrimp','Garnalen','Shrimp',85,20,0,1,'vis','core'),
('egg','Ei','Egg',143,13,1,10,'ei','core'),
('egg_white','Eiwit','Egg white',52,11,0.7,0.2,'ei','core'),
('skyr','Skyr','Skyr',63,11,4,0.2,'zuivel','core'),
('quark_lowfat','Magere kwark','Low-fat quark',57,10,4,0.3,'zuivel','core'),
('cottage','Hüttenkäse','Cottage cheese',85,12,3,2,'zuivel','core'),
('yoghurt_lowfat','Magere yoghurt','Low-fat yoghurt',42,4,6,0.1,'zuivel','core'),
('milk_semi','Halfvolle melk','Semi-skimmed milk',47,3.4,4.8,1.5,'zuivel','core'),
('feta_light','Feta (light)','Feta (light)',160,14,2,10,'zuivel','core'),
('whey','Whey-eiwitpoeder','Whey protein',380,78,8,6,'zuivel','core'),
('tofu','Tofu','Tofu',120,13,1,7,'vega','core'),
('edamame','Edamame','Edamame',121,12,9,5,'peulvrucht','core'),
('lentils','Linzen (gekookt)','Lentils (cooked)',116,9,20,0.4,'peulvrucht','core'),
('chickpeas','Kikkererwten (gekookt)','Chickpeas (cooked)',164,9,27,2.6,'peulvrucht','core'),
('kidney_beans','Kidneybonen','Kidney beans',127,9,22,0.5,'peulvrucht','core'),
('oats','Havermout','Oats',371,13,59,7,'granen','core'),
('rice_dry','Rijst (droog)','Rice (dry)',360,7,78,1,'granen','core'),
('pasta_whole','Volkoren pasta (droog)','Whole-wheat pasta (dry)',350,13,63,2.5,'granen','core'),
('couscous','Couscous (droog)','Couscous (dry)',376,13,77,1.6,'granen','core'),
('quinoa','Quinoa (droog)','Quinoa (dry)',368,14,64,6,'granen','core'),
('bread_whole','Volkorenbrood','Wholegrain bread',247,9,41,3.5,'granen','core'),
('wrap_whole','Volkoren wrap','Wholegrain wrap',300,9,49,6,'granen','core'),
('crackers_whole','Volkoren crackers','Wholegrain crackers',380,11,66,8,'granen','core'),
('rice_cakes','Rijstwafels','Rice cakes',387,8,81,3,'granen','core'),
('potato','Aardappel','Potato',77,2,17,0.1,'granen','core'),
('sweet_potato','Zoete aardappel','Sweet potato',86,1.6,20,0.1,'granen','core'),
('banana','Banaan','Banana',89,1.1,23,0.3,'fruit','core'),
('apple','Appel','Apple',52,0.3,14,0.2,'fruit','core'),
('blueberries','Blauwe bessen','Blueberries',57,0.7,14,0.3,'fruit','core'),
('strawberry','Aardbeien','Strawberries',33,0.7,8,0.3,'fruit','core'),
('mixed_berries','Bosvruchten','Mixed berries',45,1,10,0.3,'fruit','core'),
('broccoli','Broccoli','Broccoli',34,2.8,7,0.4,'groente','core'),
('green_beans','Sperziebonen','Green beans',31,1.8,7,0.2,'groente','core'),
('spinach','Spinazie','Spinach',23,2.9,3.6,0.4,'groente','core'),
('paprika','Paprika','Bell pepper',31,1,6,0.3,'groente','core'),
('cucumber','Komkommer','Cucumber',15,0.7,3.6,0.1,'groente','core'),
('tomato','Tomaat','Tomato',18,0.9,3.9,0.2,'groente','core'),
('cherry_tomato','Cherrytomaat','Cherry tomato',18,0.9,3.9,0.2,'groente','core'),
('zucchini','Courgette','Zucchini',17,1.2,3.1,0.3,'groente','core'),
('carrot','Wortel','Carrot',41,0.9,10,0.2,'groente','core'),
('lettuce','Sla','Lettuce',15,1.4,2.9,0.2,'groente','core'),
('sugarsnap','Sugarsnaps','Sugar snaps',42,2.8,7.5,0.2,'groente','core'),
('peas','Doperwten','Peas',81,5,14,0.4,'groente','core'),
('onion','Ui','Onion',40,1.1,9,0.1,'groente','core'),
('corn','Mais','Corn',86,3.2,19,1.2,'groente','core'),
('olive_oil','Olijfolie','Olive oil',884,0,0,100,'vet','core'),
('almonds','Amandelen','Almonds',579,21,22,49,'noten','core'),
('walnuts','Walnoten','Walnuts',654,15,14,65,'noten','core'),
('chia','Chiazaad','Chia seeds',486,17,42,31,'noten','core'),
('honey','Honing','Honey',304,0,82,0,'overig','core'),
('teriyaki','Teriyakisaus','Teriyaki sauce',89,3,15,0,'overig','core'),
('soy_sauce','Sojasaus','Soy sauce',60,6,6,0,'overig','core'),
('hummus_light','Hummus (light)','Hummus (light)',170,8,15,8,'overig','core'),
('mustard','Mosterd','Mustard',66,4,5,3,'overig','core'),
('satay_light','Satésaus (light)','Satay sauce (light)',150,7,10,9,'overig','core')
on conflict (slug) do update set kcal=excluded.kcal,protein=excluded.protein,carbs=excluded.carbs,fat=excluded.fat,category=excluded.category,name_nl=excluded.name_nl,name_en=excluded.name_en;

insert into public.dishes (slug,name_nl,name_en,moments,goals,items,tags,prefs,steps,steps_en,technique,temp,source) values
('quark_oat_bowl_with_banana_cinnamon','Kwark-havermoutbowl met banaan & kaneel','Quark & oat bowl with banana & cinnamon',ARRAY['breakfast'],ARRAY['cut','maintain'],'[{"slug":"quark_lowfat","g":250},{"slug":"oats","g":50},{"slug":"banana","g":100}]'::jsonb,ARRAY['sport','high_protein','vegetarian']::text[],ARRAY[]::text[],'1. Roer de havermout door de kwark en laat ''m 10 min (of een nacht) wellen.
2. Schep in een kom.
3. Beleg met schijfjes banaan en een snuf kaneel.','1. Stir the oats through the quark and let it soak 10 min (or overnight).
2. Spoon into a bowl.
3. Top with banana slices and a pinch of cinnamon.','pan',null,'core'),
('skyr_with_oats_strawberry_honey','Skyr met havermout, aardbei & honing','Skyr with oats, strawberry & honey',ARRAY['breakfast'],ARRAY['cut','maintain'],'[{"slug":"skyr","g":250},{"slug":"oats","g":45},{"slug":"strawberry","g":80},{"slug":"honey","g":10}]'::jsonb,ARRAY['sport','high_protein','vegetarian']::text[],ARRAY[]::text[],'1. Meng de skyr met de havermout.
2. Schep in een kom en top met de aardbeien.
3. Druppel de honing erover.','1. Mix the skyr with the oats.
2. Spoon into a bowl and top with the strawberries.
3. Drizzle the honey over.','pan',null,'core'),
('omelette_with_chicken_pepper_wholegrain_bread','Omelet met kipfilet, paprika & volkorenbrood','Omelette with chicken, pepper & wholegrain bread',ARRAY['breakfast'],ARRAY['cut','maintain'],'[{"slug":"egg","g":100},{"slug":"egg_white","g":90},{"slug":"chicken_breast","g":60},{"slug":"paprika","g":60},{"slug":"bread_whole","g":60}]'::jsonb,ARRAY['sport','high_protein']::text[],ARRAY[]::text[],'1. Klop het ei met het eiwit los, breng op smaak met peper en zout.
2. Bak de in reepjes gesneden kipfilet en paprika kort in een antiaanbakpan.
3. Giet het ei erbij en laat de omelet op laag vuur stollen.
4. Serveer met het geroosterde volkorenbrood.','1. Whisk the egg with the egg white, season with salt and pepper.
2. Briefly fry the sliced chicken and pepper in a non-stick pan.
3. Pour in the egg and let the omelette set on low heat.
4. Serve with the toasted wholegrain bread.','pan',null,'core'),
('wholegrain_wrap_with_scrambled_egg_spinach_tomato','Volkoren wrap met roerei, spinazie & tomaat','Wholegrain wrap with scrambled egg, spinach & tomato',ARRAY['breakfast'],ARRAY['maintain'],'[{"slug":"egg","g":100},{"slug":"egg_white","g":60},{"slug":"spinach","g":40},{"slug":"tomato","g":60},{"slug":"wrap_whole","g":60}]'::jsonb,ARRAY['sport','vegetarian']::text[],ARRAY[]::text[],'1. Klop het ei met het eiwit los.
2. Roerbak de spinazie kort tot die slinkt, giet het ei erbij en roer tot een zacht roerei.
3. Warm de wrap, beleg met het roerei en plakjes tomaat.
4. Rol strak op en snijd doormidden.','1. Whisk the egg with the egg white.
2. Stir-fry the spinach until wilted, add the egg and stir to soft scrambled egg.
3. Warm the wrap, fill with the scrambled egg and tomato slices.
4. Roll up tightly and halve.','pan',null,'core'),
('oatmeal_with_milk_apple_cinnamon','Havermoutpap met melk, appel & kaneel','Oatmeal with milk, apple & cinnamon',ARRAY['breakfast'],ARRAY['maintain'],'[{"slug":"oats","g":70},{"slug":"milk_semi","g":250},{"slug":"apple","g":100},{"slug":"whey","g":20}]'::jsonb,ARRAY['sport','vegetarian']::text[],ARRAY[]::text[],'1. Breng de havermout met de melk al roerend aan de kook en laat 3–4 min garen.
2. Haal van het vuur en roer de whey erdoor.
3. Top met blokjes appel en een snuf kaneel.','1. Bring the oats and milk to a simmer, stirring, and cook 3–4 min.
2. Off the heat, stir in the whey.
3. Top with diced apple and a pinch of cinnamon.','pan',null,'core'),
('protein_oat_pancakes_with_quark','Proteïne-havermoutpannenkoekjes met kwark','Protein oat pancakes with quark',ARRAY['breakfast'],ARRAY['cut','maintain'],'[{"slug":"oats","g":50},{"slug":"egg","g":50},{"slug":"egg_white","g":60},{"slug":"banana","g":60},{"slug":"quark_lowfat","g":100}]'::jsonb,ARRAY['sport','high_protein','vegetarian']::text[],ARRAY[]::text[],'1. Pureer de havermout, het ei, eiwit en de banaan tot een glad beslag.
2. Bak er kleine pannenkoekjes van in een antiaanbakpan.
3. Serveer met een lepel magere kwark.','1. Blend the oats, egg, egg white and banana into a smooth batter.
2. Cook small pancakes in a non-stick pan.
3. Serve with a spoon of low-fat quark.','pan',null,'core'),
('overnight_oats_with_skyr_chia_mixed_berries','Overnight oats met skyr, chiazaad & bosvruchten','Overnight oats with skyr, chia & mixed berries',ARRAY['breakfast'],ARRAY['maintain'],'[{"slug":"oats","g":50},{"slug":"skyr","g":150},{"slug":"milk_semi","g":100},{"slug":"chia","g":10},{"slug":"mixed_berries","g":80}]'::jsonb,ARRAY['sport','vegetarian']::text[],ARRAY[]::text[],'1. Meng de havermout, skyr, melk en chiazaad in een pot.
2. Laat minimaal een nacht in de koelkast opstijven.
3. Roer de volgende ochtend los en top met de bosvruchten.','1. Mix the oats, skyr, milk and chia in a jar.
2. Chill overnight to set.
3. Stir loose in the morning and top with the mixed berries.','pan',null,'core'),
('wholegrain_sandwich_with_cottage_cheese_chicken_cucumber','Volkoren boterham met hüttenkäse, kipfilet & komkommer','Wholegrain sandwich with cottage cheese, chicken & cucumber',ARRAY['breakfast'],ARRAY['cut','maintain'],'[{"slug":"bread_whole","g":70},{"slug":"cottage","g":80},{"slug":"chicken_breast","g":60},{"slug":"cucumber","g":50}]'::jsonb,ARRAY['sport','high_protein']::text[],ARRAY[]::text[],'1. Rooster het volkorenbrood licht.
2. Besmeer met de hüttenkäse.
3. Beleg met plakjes kipfilet en komkommer, peper erover.','1. Lightly toast the wholegrain bread.
2. Spread with the cottage cheese.
3. Top with sliced chicken and cucumber, add pepper.','pan',null,'core'),
('smoothie_bowl_with_quark_banana_spinach','Smoothiebowl met kwark, banaan & spinazie','Smoothie bowl with quark, banana & spinach',ARRAY['breakfast'],ARRAY['cut','maintain'],'[{"slug":"quark_lowfat","g":200},{"slug":"banana","g":100},{"slug":"spinach","g":30},{"slug":"oats","g":40},{"slug":"milk_semi","g":80}]'::jsonb,ARRAY['sport','high_protein','vegetarian']::text[],ARRAY[]::text[],'1. Doe de kwark, banaan, spinazie, havermout en melk in de blender.
2. Mix tot een dikke smoothie.
3. Schep in een kom en top naar wens met wat extra havermout.','1. Add the quark, banana, spinach, oats and milk to the blender.
2. Blend to a thick smoothie.
3. Spoon into a bowl and top with a little extra oats.','blender',null,'core'),
('scrambled_egg_with_smoked_salmon_wholegrain_bread','Roerei met gerookte zalm & volkorenbrood','Scrambled egg with smoked salmon & wholegrain bread',ARRAY['breakfast'],ARRAY['cut','maintain'],'[{"slug":"egg","g":100},{"slug":"egg_white","g":60},{"slug":"smoked_salmon","g":50},{"slug":"bread_whole","g":70}]'::jsonb,ARRAY['sport','high_protein']::text[],ARRAY[]::text[],'1. Klop het ei met het eiwit los en roer tot een zacht roerei in een antiaanbakpan.
2. Rooster het volkorenbrood.
3. Serveer het roerei op het brood met de gerookte zalm en wat peper.','1. Whisk the egg with the egg white and stir to soft scrambled egg in a non-stick pan.
2. Toast the wholegrain bread.
3. Serve the egg on the bread with the smoked salmon and some pepper.','pan',null,'core'),
('tuna_salad_wrap_with_yoghurt_mustard_dressing','Tonijnsalade-wrap met yoghurt-mosterddressing','Tuna salad wrap with yoghurt-mustard dressing',ARRAY['lunch'],ARRAY['cut','maintain'],'[{"slug":"tuna_can","g":120},{"slug":"wrap_whole","g":60},{"slug":"yoghurt_lowfat","g":40},{"slug":"cucumber","g":60},{"slug":"lettuce","g":30},{"slug":"mustard","g":5}]'::jsonb,ARRAY['sport','high_protein']::text[],ARRAY[]::text[],'1. Meng de tonijn met de yoghurt, mosterd en een scheut citroen tot een smeuïge salade.
2. Beleg de wrap met sla en komkommer, schep de tonijnsalade erover.
3. Rol strak op en snijd schuin doormidden.','1. Mix the tuna with the yoghurt, mustard and a splash of lemon into a creamy salad.
2. Fill the wrap with lettuce and cucumber, spoon the tuna salad over.
3. Roll up tightly and cut diagonally.','pan',null,'core'),
('chicken_teriyaki_rice_bowl_with_edamame_broccoli','Kip-teriyaki rijstbowl met edamame & broccoli','Chicken teriyaki rice bowl with edamame & broccoli',ARRAY['lunch','dinner'],ARRAY['cut','maintain'],'[{"slug":"chicken_breast","g":150},{"slug":"rice_dry","g":65},{"slug":"edamame","g":60},{"slug":"broccoli","g":120},{"slug":"teriyaki","g":25}]'::jsonb,ARRAY['sport','high_protein']::text[],ARRAY['chickenrice']::text[],'1. Kook de rijst gaar.
2. Bak de in blokjes gesneden kipfilet in een hete pan, voeg de teriyaki toe en laat glaceren.
3. Stoom de broccoli en edamame beetgaar.
4. Schik alles in een kom over de rijst.','1. Cook the rice.
2. Sear the diced chicken in a hot pan, add the teriyaki and let it glaze.
3. Steam the broccoli and edamame until tender.
4. Arrange everything in a bowl over the rice.','pan',null,'core'),
('wholegrain_pasta_with_chicken_cherry_tomato_basil','Volkoren pasta met kipfilet, cherrytomaat & basilicum','Wholegrain pasta with chicken, cherry tomato & basil',ARRAY['lunch','dinner'],ARRAY['cut','maintain'],'[{"slug":"pasta_whole","g":75},{"slug":"chicken_breast","g":150},{"slug":"cherry_tomato","g":120},{"slug":"olive_oil","g":6}]'::jsonb,ARRAY['sport','high_protein']::text[],ARRAY[]::text[],'1. Kook de volkoren pasta beetgaar.
2. Bak de in reepjes gesneden kipfilet in de olijfolie, voeg de gehalveerde cherrytomaten toe en laat kort meebakken.
3. Meng de pasta erdoor en werk af met verse basilicum, peper en zout.','1. Cook the wholegrain pasta al dente.
2. Fry the sliced chicken in the olive oil, add the halved cherry tomatoes and cook briefly.
3. Toss the pasta through and finish with fresh basil, salt and pepper.','pan',null,'core'),
('lentil_salad_with_feta_cucumber_mint','Linzensalade met feta, komkommer & munt','Lentil salad with feta, cucumber & mint',ARRAY['lunch'],ARRAY['maintain'],'[{"slug":"lentils","g":180},{"slug":"feta_light","g":40},{"slug":"cucumber","g":80},{"slug":"tomato","g":80},{"slug":"olive_oil","g":5}]'::jsonb,ARRAY['sport','vegetarian']::text[],ARRAY[]::text[],'1. Meng de gekookte linzen met blokjes komkommer en tomaat.
2. Verkruimel de feta erover.
3. Maak aan met de olijfolie, citroen, verse munt, peper en zout.','1. Mix the cooked lentils with diced cucumber and tomato.
2. Crumble the feta over.
3. Dress with the olive oil, lemon, fresh mint, salt and pepper.','pan',null,'core'),
('couscous_salad_with_chickpeas_chicken','Couscoussalade met kikkererwten & kipfilet','Couscous salad with chickpeas & chicken',ARRAY['lunch'],ARRAY['gain','maintain'],'[{"slug":"couscous","g":60},{"slug":"chickpeas","g":100},{"slug":"chicken_breast","g":120},{"slug":"paprika","g":80},{"slug":"olive_oil","g":5}]'::jsonb,ARRAY['sport']::text[],ARRAY[]::text[],'1. Wel de couscous met heet water tot gaar, roer los met een vork.
2. Bak de kipfilet gaar en snijd in reepjes.
3. Meng de couscous met kikkererwten, blokjes paprika, de kip en de olijfolie; breng op smaak.','1. Soak the couscous in hot water until done, fluff with a fork.
2. Cook the chicken and slice.
3. Mix the couscous with chickpeas, diced pepper, the chicken and the olive oil; season.','pan',null,'core'),
('wholegrain_sandwiches_with_roast_beef_mustard','Volkoren boterhammen met rosbief & mosterd','Wholegrain sandwiches with roast beef & mustard',ARRAY['lunch'],ARRAY['cut','maintain'],'[{"slug":"bread_whole","g":90},{"slug":"rosbief","g":80},{"slug":"mustard","g":8},{"slug":"lettuce","g":20},{"slug":"tomato","g":40}]'::jsonb,ARRAY['sport','high_protein']::text[],ARRAY[]::text[],'1. Besmeer het volkorenbrood dun met mosterd.
2. Beleg met de rosbief, sla en plakjes tomaat.
3. Klap dicht en snijd doormidden.','1. Spread the wholegrain bread thinly with mustard.
2. Top with the roast beef, lettuce and tomato slices.
3. Close and cut in half.','pan',null,'core'),
('poke_bowl_with_tuna_rice_edamame','Pokébowl met tonijn, rijst & edamame','Poké bowl with tuna, rice & edamame',ARRAY['lunch','dinner'],ARRAY['cut','maintain'],'[{"slug":"tuna_can","g":120},{"slug":"rice_dry","g":65},{"slug":"edamame","g":70},{"slug":"cucumber","g":60},{"slug":"soy_sauce","g":10}]'::jsonb,ARRAY['sport','high_protein']::text[],ARRAY[]::text[],'1. Kook de rijst en laat iets afkoelen.
2. Verdeel de rijst in een kom.
3. Schik de tonijn, edamame en komkommer eromheen en besprenkel met sojasaus.','1. Cook the rice and let it cool slightly.
2. Divide the rice into a bowl.
3. Arrange the tuna, edamame and cucumber around it and drizzle with soy sauce.','pan',null,'core'),
('chicken_wrap_with_hummus_lettuce_carrot','Kipfilet-wrap met hummus, sla & wortel','Chicken wrap with hummus, lettuce & carrot',ARRAY['lunch'],ARRAY['cut','maintain'],'[{"slug":"wrap_whole","g":60},{"slug":"chicken_breast","g":120},{"slug":"hummus_light","g":30},{"slug":"lettuce","g":30},{"slug":"carrot","g":50}]'::jsonb,ARRAY['sport','high_protein']::text[],ARRAY['chickenwrap']::text[],'1. Besmeer de wrap met de hummus.
2. Beleg met gegrilde reepjes kipfilet, sla en geraspte wortel.
3. Rol strak op en snijd doormidden.','1. Spread the wrap with the hummus.
2. Top with grilled chicken strips, lettuce and grated carrot.
3. Roll up tightly and halve.','pan',null,'core'),
('smoked_chicken_salad_with_potato_green_beans','Gerookte-kipsalade met aardappel & sperziebonen','Smoked chicken salad with potato & green beans',ARRAY['lunch','dinner'],ARRAY['cut','maintain'],'[{"slug":"chicken_breast","g":130},{"slug":"potato","g":200},{"slug":"green_beans","g":120},{"slug":"yoghurt_lowfat","g":40},{"slug":"mustard","g":5}]'::jsonb,ARRAY['sport','high_protein']::text[],ARRAY[]::text[],'1. Kook de aardappels gaar en laat afkoelen; stoom de sperziebonen beetgaar.
2. Roer een dressing van de yoghurt, mosterd, citroen, peper en zout.
3. Meng de aardappel, sperziebonen en gegrilde kip met de dressing.','1. Boil the potatoes and let cool; steam the green beans until tender.
2. Stir a dressing from the yoghurt, mustard, lemon, salt and pepper.
3. Toss the potato, green beans and grilled chicken with the dressing.','pan',null,'core'),
('vegetable_soup_with_chicken_wholegrain_bread','Groentesoep met kip & volkorenbrood','Vegetable soup with chicken & wholegrain bread',ARRAY['lunch'],ARRAY['cut','maintain'],'[{"slug":"chicken_breast","g":100},{"slug":"carrot","g":80},{"slug":"zucchini","g":80},{"slug":"onion","g":40},{"slug":"bread_whole","g":60}]'::jsonb,ARRAY['sport','high_protein']::text[],ARRAY[]::text[],'1. Fruit de ui, wortel en courgette kort aan in een soeppan.
2. Voeg bouillon en de in blokjes gesneden kipfilet toe en laat 12–15 min zachtjes garen.
3. Breng op smaak en serveer met het volkorenbrood.','1. Sweat the onion, carrot and zucchini briefly in a soup pot.
2. Add stock and the diced chicken and simmer gently 12–15 min.
3. Season and serve with the wholegrain bread.','soup',null,'core'),
('shrimp_stir_fry_with_rice_sugar_snaps','Garnalen-roerbak met rijst & sugarsnaps','Shrimp stir-fry with rice & sugar snaps',ARRAY['lunch','dinner'],ARRAY['cut','maintain'],'[{"slug":"shrimp","g":140},{"slug":"rice_dry","g":65},{"slug":"sugarsnap","g":120},{"slug":"paprika","g":60},{"slug":"soy_sauce","g":12}]'::jsonb,ARRAY['sport','high_protein']::text[],ARRAY[]::text[],'1. Kook de rijst gaar.
2. Roerbak de sugarsnaps en paprika kort in een hete wok.
3. Voeg de garnalen en sojasaus toe en bak tot de garnalen roze en gaar zijn.
4. Serveer over de rijst.','1. Cook the rice.
2. Stir-fry the sugar snaps and pepper briefly in a hot wok.
3. Add the shrimp and soy sauce and cook until the shrimp are pink and done.
4. Serve over the rice.','pan',null,'core'),
('omelette_wrap_with_vegetables','Omelet-wrap met groente','Omelette wrap with vegetables',ARRAY['lunch','breakfast'],ARRAY['cut','maintain'],'[{"slug":"egg","g":100},{"slug":"egg_white","g":90},{"slug":"paprika","g":60},{"slug":"spinach","g":40},{"slug":"cottage","g":60}]'::jsonb,ARRAY['sport','high_protein','vegetarian']::text[],ARRAY[]::text[],'1. Klop het ei met het eiwit los en bak er een dunne omelet van.
2. Beleg met de hüttenkäse, paprika en spinazie.
3. Rol de omelet op als een wrap en snijd doormidden.','1. Whisk the egg with the egg white and cook a thin omelette.
2. Top with the cottage cheese, pepper and spinach.
3. Roll the omelette like a wrap and halve.','pan',null,'core'),
('steamed_cod_with_potato_green_beans','Gestoomde kabeljauw met aardappel & sperziebonen','Steamed cod with potato & green beans',ARRAY['dinner'],ARRAY['cut','maintain'],'[{"slug":"cod","g":160},{"slug":"potato","g":250},{"slug":"green_beans","g":150},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['sport','high_protein']::text[],ARRAY['codveg']::text[],'1. Kook de aardappels in 15–18 min gaar.
2. Stoom de sperziebonen 6–8 min beetgaar.
3. Bestrijk de kabeljauw met de olijfolie, peper en citroen; stoom of bak ''m 6–8 min tot de vis net schilfert.
4. Serveer met wat verse dille.','1. Boil the potatoes until done, 15–18 min.
2. Steam the green beans 6–8 min until tender.
3. Brush the cod with the olive oil, pepper and lemon; steam or pan-fry 6–8 min until it just flakes.
4. Serve with some fresh dill.','pan',null,'core'),
('oven_chicken_with_sweet_potato_broccoli','Kipfilet uit de oven met zoete aardappel & broccoli','Oven chicken with sweet potato & broccoli',ARRAY['dinner'],ARRAY['cut','maintain'],'[{"slug":"chicken_breast","g":160},{"slug":"sweet_potato","g":220},{"slug":"broccoli","g":150},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['sport','high_protein']::text[],ARRAY['chickenrice']::text[],'1. Verwarm de oven op 200°C. Snijd de zoete aardappel in parten, hussel met de helft van de olijfolie en rooster 25 min.
2. Bestrijk de kipfilet met de rest van de olie, peper en paprikapoeder en rooster de laatste 18 min mee.
3. Stoom de broccoli beetgaar en serveer alles samen.','1. Preheat the oven to 200°C. Cut the sweet potato into wedges, toss with half the olive oil and roast 25 min.
2. Brush the chicken with the rest of the oil, pepper and paprika and roast for the final 18 min.
3. Steam the broccoli until tender and serve together.','oven',null,'core'),
('lean_beef_stir_fry_with_pepper_onion_rice','Magere runderwok met paprika, ui & rijst','Lean beef stir-fry with pepper, onion & rice',ARRAY['dinner'],ARRAY['maintain'],'[{"slug":"beef_lean","g":150},{"slug":"rice_dry","g":65},{"slug":"paprika","g":100},{"slug":"onion","g":50},{"slug":"soy_sauce","g":12}]'::jsonb,ARRAY['sport']::text[],ARRAY[]::text[],'1. Kook de rijst gaar.
2. Snijd het rundvlees in reepjes en bak kort op hoog vuur aan; haal uit de pan.
3. Roerbak de paprika en ui, voeg het vlees en de sojasaus terug en bak nog 1 min.
4. Serveer over de rijst.','1. Cook the rice.
2. Slice the beef and sear briefly on high heat; remove from the pan.
3. Stir-fry the pepper and onion, return the beef and soy sauce and cook 1 min more.
4. Serve over the rice.','pan',null,'core'),
('oven_salmon_with_potato_spinach','Zalmfilet uit de oven met aardappel & spinazie','Oven salmon with potato & spinach',ARRAY['dinner'],ARRAY['maintain'],'[{"slug":"salmon","g":140},{"slug":"potato","g":220},{"slug":"spinach","g":120},{"slug":"olive_oil","g":5}]'::jsonb,ARRAY['sport']::text[],ARRAY['salmonveg']::text[],'1. Verwarm de oven op 200°C en rooster de aardappelparten 25 min.
2. Leg de zalm de laatste 12 min mee in de oven, met peper en citroen.
3. Slink de spinazie kort in een pan met de olijfolie en serveer alles samen.','1. Preheat the oven to 200°C and roast the potato wedges 25 min.
2. Add the salmon for the final 12 min, with pepper and lemon.
3. Wilt the spinach briefly in a pan with the olive oil and serve together.','oven',null,'core'),
('chicken_satay_bowl_with_rice_cucumber','Kipsaté-bowl met rijst & komkommer','Chicken satay bowl with rice & cucumber',ARRAY['dinner'],ARRAY['cut','maintain'],'[{"slug":"chicken_breast","g":150},{"slug":"rice_dry","g":65},{"slug":"satay_light","g":30},{"slug":"cucumber","g":80}]'::jsonb,ARRAY['sport','high_protein']::text[],ARRAY[]::text[],'1. Kook de rijst gaar.
2. Rijg de in blokjes gesneden kipfilet en gril of bak ''m gaar.
3. Verwarm de satésaus en lepel over de kip.
4. Serveer met de rijst en frisse komkommer.','1. Cook the rice.
2. Skewer the diced chicken and grill or pan-fry until done.
3. Warm the satay sauce and spoon over the chicken.
4. Serve with the rice and fresh cucumber.','pan',null,'core'),
('white_fish_with_quinoa_zucchini_lemon','Witvis met quinoa, courgette & citroen','White fish with quinoa, zucchini & lemon',ARRAY['dinner'],ARRAY['cut','maintain'],'[{"slug":"white_fish","g":160},{"slug":"quinoa","g":60},{"slug":"zucchini","g":150},{"slug":"olive_oil","g":6}]'::jsonb,ARRAY['sport','high_protein']::text[],ARRAY[]::text[],'1. Kook de quinoa gaar in ruim water.
2. Bak de courgette in de olijfolie goudbruin.
3. Bak de witvis 3–4 min per kant tot gaar, met peper en citroen.
4. Serveer de vis op de quinoa met de courgette.','1. Cook the quinoa in plenty of water.
2. Pan-fry the zucchini in the olive oil until golden.
3. Fry the white fish 3–4 min per side until done, with pepper and lemon.
4. Serve the fish on the quinoa with the zucchini.','pan',null,'core'),
('turkey_breast_with_mashed_potato_peas','Kalkoenfilet met aardappelpuree & doperwten','Turkey breast with mashed potato & peas',ARRAY['dinner'],ARRAY['cut','maintain'],'[{"slug":"turkey_breast","g":150},{"slug":"potato","g":250},{"slug":"milk_semi","g":50},{"slug":"peas","g":120}]'::jsonb,ARRAY['sport','high_protein']::text[],ARRAY[]::text[],'1. Kook de aardappels gaar en stamp met een scheut halfvolle melk tot puree.
2. Bak de kalkoenfilet 4–5 min per kant tot gaar.
3. Verwarm de doperwten en serveer alles samen.','1. Boil the potatoes and mash with a splash of semi-skimmed milk.
2. Pan-fry the turkey 4–5 min per side until done.
3. Warm the peas and serve together.','pan',null,'core'),
('chili_sin_carne_with_kidney_beans_rice','Chili sin carne met kidneybonen & rijst','Chili sin carne with kidney beans & rice',ARRAY['dinner'],ARRAY['gain','maintain'],'[{"slug":"kidney_beans","g":200},{"slug":"corn","g":80},{"slug":"tomato","g":150},{"slug":"rice_dry","g":65},{"slug":"onion","g":50}]'::jsonb,ARRAY['sport','vegetarian','vegan']::text[],ARRAY[]::text[],'1. Kook de rijst gaar.
2. Fruit de ui, voeg tomaat, kidneybonen en mais toe met komijn, paprikapoeder en chili.
3. Laat 10–12 min pruttelen en serveer over de rijst.','1. Cook the rice.
2. Sweat the onion, add tomato, kidney beans and corn with cumin, paprika and chili.
3. Simmer 10–12 min and serve over the rice.','pan',null,'core'),
('tofu_stir_fry_with_teriyaki_broccoli_rice','Tofu-roerbak met teriyaki, broccoli & rijst','Tofu stir-fry with teriyaki, broccoli & rice',ARRAY['dinner'],ARRAY['maintain'],'[{"slug":"tofu","g":180},{"slug":"rice_dry","g":65},{"slug":"broccoli","g":150},{"slug":"teriyaki","g":25}]'::jsonb,ARRAY['sport','vegetarian','vegan']::text[],ARRAY[]::text[],'1. Kook de rijst gaar.
2. Bak de tofublokjes rondom goudbruin en knapperig.
3. Voeg de broccoli en teriyaki toe en roerbak tot de broccoli beetgaar is.
4. Serveer over de rijst.','1. Cook the rice.
2. Fry the tofu cubes until golden and crisp all over.
3. Add the broccoli and teriyaki and stir-fry until the broccoli is tender.
4. Serve over the rice.','pan',null,'core'),
('sous_vide_steak_54_c_with_potato_grilled_vegetables','Biefstuk sous-vide 54°C met aardappel & gegrilde groente','Sous-vide steak 54°C with potato & grilled vegetables',ARRAY['dinner'],ARRAY['cut','maintain'],'[{"slug":"beef_lean","g":150},{"slug":"potato","g":220},{"slug":"zucchini","g":100},{"slug":"paprika","g":80},{"slug":"olive_oil","g":6}]'::jsonb,ARRAY['sport','high_protein','sousvide']::text[],ARRAY[]::text[],'1. Vacumeer de biefstuk en gaar sous-vide op 54°C (1,5–4 u) voor medium-rare.
2. Kook de aardappels gaar; gril de courgette en paprika in een grillpan.
3. Dep de biefstuk droog en schroei ''m rondom kort dicht in een gloeiend hete pan.
4. Laat 2 min rusten, snijd aan en serveer met de groente.','1. Vacuum-seal the steak and cook sous-vide at 54°C (1.5–4 h) for medium-rare.
2. Boil the potatoes; grill the zucchini and pepper in a griddle pan.
3. Pat the steak dry and sear it all over in a scorching-hot pan.
4. Rest 2 min, slice and serve with the vegetables.','sousvide','54°C','core'),
('sous_vide_chicken_63_c_with_sweet_potato_broccoli','Kip sous-vide 63°C met zoete aardappel & broccoli','Sous-vide chicken 63°C with sweet potato & broccoli',ARRAY['dinner'],ARRAY['cut','maintain'],'[{"slug":"chicken_breast","g":160},{"slug":"sweet_potato","g":200},{"slug":"broccoli","g":120},{"slug":"olive_oil","g":6}]'::jsonb,ARRAY['sport','high_protein','sousvide']::text[],ARRAY[]::text[],'1. Vacumeer de kipfilet en gaar sous-vide op 63°C (1,5–4 u) voor een sappige, gare kip.
2. Rooster de zoete aardappel in de oven op 200°C in ca. 25 min.
3. Stoom de broccoli beetgaar.
4. Dep de kip droog en schroei ''m kort aan in een hete pan; serveer met de groente.','1. Vacuum-seal the chicken and cook sous-vide at 63°C (1.5–4 h) for juicy, cooked-through chicken.
2. Roast the sweet potato in the oven at 200°C for about 25 min.
3. Steam the broccoli until tender.
4. Pat the chicken dry and sear briefly in a hot pan; serve with the vegetables.','sousvide','63°C','core'),
('spaghetti_bolognese_with_lean_beef_mince','Spaghetti bolognese van mager rundergehakt','Spaghetti bolognese with lean beef mince',ARRAY['dinner'],ARRAY['cut','maintain'],'[{"slug":"beef_mince5","g":150},{"slug":"pasta_whole","g":75},{"slug":"tomato","g":150},{"slug":"onion","g":50},{"slug":"olive_oil","g":5}]'::jsonb,ARRAY['sport','high_protein']::text[],ARRAY[]::text[],'1. Kook de volkoren spaghetti beetgaar.
2. Fruit de ui in de olijfolie, voeg het gehakt toe en rul het los.
3. Voeg de tomaat toe met Italiaanse kruiden en laat 10 min pruttelen.
4. Schep over de spaghetti.','1. Cook the wholegrain spaghetti al dente.
2. Sweat the onion in the olive oil, add the mince and break it up.
3. Add the tomato with Italian herbs and simmer 10 min.
4. Spoon over the spaghetti.','pan',null,'core'),
('low_fat_quark_with_blueberries_flaked_almonds','Magere kwark met blauwe bessen & amandelschaafsel','Low-fat quark with blueberries & flaked almonds',ARRAY['snack'],ARRAY['cut','maintain'],'[{"slug":"quark_lowfat","g":150},{"slug":"blueberries","g":60},{"slug":"almonds","g":10}]'::jsonb,ARRAY['sport','high_protein','vegetarian']::text[],ARRAY[]::text[],'1. Schep de kwark in een kom.
2. Top met de blauwe bessen en het amandelschaafsel.','1. Spoon the quark into a bowl.
2. Top with the blueberries and flaked almonds.','assembly',null,'core'),
('skyr_with_honey_walnuts','Skyr met honing & walnoten','Skyr with honey & walnuts',ARRAY['snack'],ARRAY['cut','maintain'],'[{"slug":"skyr","g":150},{"slug":"honey","g":10},{"slug":"walnuts","g":12}]'::jsonb,ARRAY['sport','high_protein','vegetarian']::text[],ARRAY[]::text[],'1. Schep de skyr in een kom.
2. Druppel de honing erover en strooi de grof gehakte walnoten erop.','1. Spoon the skyr into a bowl.
2. Drizzle the honey over and scatter the roughly chopped walnuts on top.','assembly',null,'core'),
('rice_cakes_with_chicken_cucumber','Rijstwafels met kipfilet & komkommer','Rice cakes with chicken & cucumber',ARRAY['snack'],ARRAY['cut','maintain'],'[{"slug":"rice_cakes","g":26},{"slug":"chicken_breast","g":60},{"slug":"cucumber","g":40}]'::jsonb,ARRAY['sport','high_protein']::text[],ARRAY[]::text[],'1. Beleg de rijstwafels met plakjes kipfilet.
2. Leg er dunne plakjes komkommer op en maal er wat peper over.','1. Top the rice cakes with sliced chicken.
2. Add thin cucumber slices and grind some pepper over.','assembly',null,'core'),
('protein_shake_with_banana','Proteïneshake met banaan','Protein shake with banana',ARRAY['snack'],ARRAY['cut','maintain'],'[{"slug":"whey","g":30},{"slug":"banana","g":80},{"slug":"milk_semi","g":200}]'::jsonb,ARRAY['sport','high_protein','vegetarian']::text[],ARRAY[]::text[],'1. Doe de whey, banaan en melk in de blender.
2. Mix glad en schenk in een glas — ideaal na je training.','1. Add the whey, banana and milk to the blender.
2. Blend smooth and pour into a glass — ideal after training.','blender',null,'core'),
('apple_with_almonds','Appel met amandelen','Apple with almonds',ARRAY['snack'],ARRAY['maintain'],'[{"slug":"apple","g":150},{"slug":"almonds","g":20}]'::jsonb,ARRAY['sport','vegetarian','vegan']::text[],ARRAY[]::text[],'1. Snijd de appel in partjes.
2. Eet met een handje amandelen als knapperige snack.','1. Slice the apple into wedges.
2. Enjoy with a handful of almonds as a crunchy snack.','assembly',null,'core'),
('wholegrain_crackers_with_cottage_cheese_tomato','Volkoren crackers met hüttenkäse & tomaat','Wholegrain crackers with cottage cheese & tomato',ARRAY['snack'],ARRAY['cut','maintain'],'[{"slug":"crackers_whole","g":24},{"slug":"cottage","g":80},{"slug":"tomato","g":50}]'::jsonb,ARRAY['sport','high_protein','vegetarian']::text[],ARRAY[]::text[],'1. Besmeer de crackers met de hüttenkäse.
2. Leg er plakjes tomaat op en maal er wat peper over.','1. Spread the crackers with the cottage cheese.
2. Top with tomato slices and grind some pepper over.','assembly',null,'core'),
('edamame_with_sea_salt','Edamame met zeezout','Edamame with sea salt',ARRAY['snack'],ARRAY['cut','maintain'],'[{"slug":"edamame","g":150}]'::jsonb,ARRAY['sport','high_protein','vegetarian','vegan']::text[],ARRAY[]::text[],'1. Kook of stoom de edamame 4–5 min.
2. Bestrooi met wat zeezout en knijp de boontjes uit de peul.','1. Boil or steam the edamame 4–5 min.
2. Sprinkle with sea salt and squeeze the beans from the pods.','pan',null,'core'),
('quark_with_cinnamon_banana','Kwark met kaneel & banaan','Quark with cinnamon & banana',ARRAY['snack'],ARRAY['cut','maintain'],'[{"slug":"quark_lowfat","g":150},{"slug":"banana","g":70}]'::jsonb,ARRAY['sport','high_protein','vegetarian']::text[],ARRAY[]::text[],'1. Schep de kwark in een kom.
2. Roer er een snuf kaneel door en top met schijfjes banaan.','1. Spoon the quark into a bowl.
2. Stir in a pinch of cinnamon and top with banana slices.','assembly',null,'core')
on conflict (slug) do update set name_nl=excluded.name_nl,name_en=excluded.name_en,moments=excluded.moments,goals=excluded.goals,items=excluded.items,tags=excluded.tags,prefs=excluded.prefs,steps=excluded.steps,steps_en=excluded.steps_en,technique=excluded.technique,temp=excluded.temp;
commit;
