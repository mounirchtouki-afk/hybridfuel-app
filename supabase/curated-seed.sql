-- GECUREERDE recepten-seed (handgeschreven, vetarm). Draai NA dish-library.sql.
-- Vervangt de oude core-set: de DELETE ruimt de gegenereerde gerechten op.
begin;
delete from public.dishes where source='core';

insert into public.ingredients (slug,name_nl,name_en,kcal,protein,carbs,fat,category,source) values
('chicken_breast','Kipfilet','Chicken breast',120,23,0,2.6,'vlees','core'),
('chicken_thigh','Kipdij','Chicken thigh',150,19,0,8,'vlees','core'),
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
('greek_yoghurt','Magere Griekse yoghurt','Low-fat Greek yoghurt',59,10,4,0.4,'zuivel','core'),
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
('mushroom','Champignons','Mushrooms',22,3,3.3,0.3,'groente','core'),
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
('satay_light','Satésaus (light)','Satay sauce (light)',150,7,10,9,'overig','core'),
('flat_iron','Flat iron steak','Flat iron steak',160,22,0,8,'vlees','core'),
('avocado','Avocado','Avocado',160,2,9,15,'vet','core'),
('rice_yellow','Gele rijst (droog)','Yellow rice (dry)',360,7,78,1,'granen','core'),
('sourdough','Desembrood','Sourdough bread',250,9,48,1.5,'granen','core'),
('low_fat_cheese','Magere kaas','Low-fat cheese',240,27,0,14,'zuivel','core'),
('red_onion','Rode ui','Red onion',40,1.1,9,0.1,'groente','core'),
('celery','Selderij','Celery',16,0.7,3,0.2,'groente','core'),
('spring_onion','Bosui','Spring onion',32,1.8,7,0.2,'groente','core'),
('olives','Olijven','Olives',115,0.8,6,11,'vet','core'),
('ketjap_manis','Ketjap manis','Sweet soy sauce',250,2,60,0,'overig','core'),
('dark_choc70','Pure chocolade 70%','Dark chocolate 70%',600,8,46,42,'overig','core'),
('chicken_mince','Kipgehakt','Chicken mince',143,17,0,8,'vlees','core'),
('ham_lean','Magere ham','Lean ham',110,21,1,2,'vlees','core'),
('brown_rice','Zilvervliesrijst (droog)','Brown rice (dry)',360,8,76,2.5,'granen','core'),
('noodles_whole','Volkoren noedels (droog)','Whole-wheat noodles (dry)',350,13,65,2,'granen','core'),
('rice_noodles','Rijstnoedels (droog)','Rice noodles (dry)',360,3,83,0.5,'granen','core'),
('bulgur','Bulgur (droog)','Bulgur (dry)',342,12,63,1.3,'granen','core'),
('pita_whole','Volkoren pita','Wholegrain pita',260,10,49,2.5,'granen','core'),
('black_beans','Zwarte bonen','Black beans',132,9,24,0.5,'peulvrucht','core'),
('cauliflower','Bloemkool','Cauliflower',25,1.9,5,0.3,'groente','core'),
('eggplant','Aubergine','Eggplant',25,1,6,0.2,'groente','core'),
('leek','Prei','Leek',31,1.5,6,0.3,'groente','core'),
('asparagus','Asperges','Asparagus',20,2.2,4,0.1,'groente','core'),
('rocket','Rucola','Rocket',25,2.6,3.7,0.7,'groente','core'),
('mango','Mango','Mango',60,0.8,15,0.4,'fruit','core'),
('raspberry','Frambozen','Raspberries',52,1.2,12,0.7,'fruit','core'),
('pear','Peer','Pear',57,0.4,15,0.1,'fruit','core'),
('kiwi','Kiwi','Kiwi',61,1.1,15,0.5,'fruit','core'),
('dates','Dadels','Dates',282,2,75,0.4,'fruit','core'),
('coconut_light','Kokosmelk (light)','Coconut milk (light)',73,0.6,2,7,'overig','core'),
('curry_paste','Currypasta','Curry paste',110,2,10,6,'overig','core'),
('passata','Tomatenpassata','Tomato passata',35,1.5,6,0.3,'groente','core'),
('pesto','Pesto','Pesto',300,4,4,30,'vet','core'),
('mozzarella_light','Mozzarella (light)','Mozzarella (light)',170,20,2,9,'zuivel','core'),
('cashew','Cashewnoten','Cashews',553,18,30,44,'noten','core'),
('pumpkin_seeds','Pompoenpitten','Pumpkin seeds',559,30,11,49,'noten','core'),
('peanut_butter','Pindakaas','Peanut butter',588,25,20,50,'noten','core')
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
2. Stir in a pinch of cinnamon and top with banana slices.','assembly',null,'core'),
('sweet_potato_mash_with_flat_iron_poached_egg_avocado','Zoete-aardappelpuree met flat iron, gepocheerd ei & avocado','Sweet potato mash with flat iron, poached egg & avocado',ARRAY['dinner'],ARRAY['gain','maintain'],'[{"slug":"sweet_potato","g":220},{"slug":"flat_iron","g":150},{"slug":"egg","g":55},{"slug":"avocado","g":40},{"slug":"olive_oil","g":3}]'::jsonb,ARRAY['sport']::text[],ARRAY[]::text[],'1. Kook de zoete aardappel gaar en stamp tot een gladde puree met peper en zout.
2. Bak de flat iron 2–3 min per kant tot medium-rare en laat even rusten.
3. Pocheer het ei 3 min in zacht kokend water met een scheut azijn.
4. Serveer de puree met de aangesneden flat iron, het gepocheerde ei en waaiertjes avocado.','1. Boil the sweet potato and mash smooth with salt and pepper.
2. Sear the flat iron 2–3 min per side to medium-rare and rest briefly.
3. Poach the egg 3 min in gently simmering water with a splash of vinegar.
4. Serve the mash with the sliced flat iron, the poached egg and fanned avocado.','pan',null,'core'),
('salmon_with_yellow_rice_vegetables_sweet_soy','Zalmfilet met gele rijst, groente & ketjap manis','Salmon with yellow rice, vegetables & sweet soy',ARRAY['dinner'],ARRAY['gain','maintain'],'[{"slug":"salmon","g":140},{"slug":"rice_yellow","g":65},{"slug":"broccoli","g":100},{"slug":"paprika","g":100},{"slug":"ketjap_manis","g":15}]'::jsonb,ARRAY['sport']::text[],ARRAY[]::text[],'1. Kook de rijst met een snuf kurkuma tot gele rijst.
2. Bak of stoom de zalm gaar, met peper en citroen.
3. Roerbak de broccoli en paprika beetgaar.
4. Serveer samen en lepel de ketjap manis over de zalm.','1. Cook the rice with a pinch of turmeric for yellow rice.
2. Pan-fry or steam the salmon, with pepper and lemon.
3. Stir-fry the broccoli and pepper until tender.
4. Serve together and spoon the sweet soy over the salmon.','pan',null,'core'),
('quark_with_blueberries_honey_dark_chocolate','Kwark met bosbessen, honing & pure chocolade','Quark with blueberries, honey & dark chocolate',ARRAY['snack'],ARRAY['maintain'],'[{"slug":"quark_lowfat","g":150},{"slug":"blueberries","g":60},{"slug":"honey","g":8},{"slug":"dark_choc70","g":12}]'::jsonb,ARRAY['sport','vegetarian']::text[],ARRAY[]::text[],'1. Schep de kwark in een kom.
2. Top met de bosbessen en een druppel honing.
3. Hak de pure chocolade (70%) grof en strooi erover.','1. Spoon the quark into a bowl.
2. Top with the blueberries and a drizzle of honey.
3. Roughly chop the 70% dark chocolate and scatter over.','assembly',null,'core'),
('corn_chicken_with_yellow_rice_vegetables_teriyaki','Mais-kipfilet met gele rijst, groente & teriyaki','Corn chicken with yellow rice, vegetables & teriyaki',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"chicken_breast","g":150},{"slug":"rice_yellow","g":65},{"slug":"corn","g":80},{"slug":"broccoli","g":120},{"slug":"teriyaki","g":25}]'::jsonb,ARRAY['sport','high_protein']::text[],ARRAY[]::text[],'1. Kook de rijst met een snuf kurkuma tot gele rijst.
2. Bak de kipfilet gaar, voeg de teriyaki toe en laat glaceren.
3. Warm de mais en stoom de broccoli beetgaar.
4. Schik alles over de rijst.','1. Cook the rice with a pinch of turmeric for yellow rice.
2. Sear the chicken, add the teriyaki and let it glaze.
3. Warm the corn and steam the broccoli until tender.
4. Arrange everything over the rice.','pan',null,'core'),
('couscous_stew_with_chicken_thigh_cinnamon_vegetables','Couscous-stoofpotje met kipdij, kaneel & groente','Couscous stew with chicken thigh, cinnamon & vegetables',ARRAY['dinner'],ARRAY['maintain'],'[{"slug":"chicken_thigh","g":150},{"slug":"couscous","g":60},{"slug":"carrot","g":80},{"slug":"zucchini","g":80},{"slug":"onion","g":40}]'::jsonb,ARRAY['sport']::text[],ARRAY[]::text[],'1. Stoof de kipdij met de ui, wortel en courgette aan; voeg een snuf kaneel en kippenbouillon toe.
2. Laat 20–25 min zachtjes stoven tot kip en groente gaar zijn in een geurig vocht.
3. Doe de couscous in een kom, schep het hete stoofvocht erover tot net onder en dek af met folie.
4. Laat 5 min wellen, roer los met een vork en schep de stoof met kip en groente erover.','1. Sweat the chicken thigh with the onion, carrot and zucchini; add a pinch of cinnamon and chicken stock.
2. Simmer gently 20–25 min until the chicken and vegetables are tender in a fragrant broth.
3. Put the couscous in a bowl, ladle the hot broth over to just below the surface and cover with foil.
4. Let it swell 5 min, fluff with a fork and spoon the stew with chicken and vegetables over.','soup',null,'core'),
('couscous_salad_with_red_onion_feta_hummus_celery','Couscoussalade met rode ui, feta, hummus & selderij','Couscous salad with red onion, feta, hummus & celery',ARRAY['lunch'],ARRAY['maintain'],'[{"slug":"couscous","g":60},{"slug":"red_onion","g":30},{"slug":"feta_light","g":40},{"slug":"hummus_light","g":30},{"slug":"celery","g":40},{"slug":"tomato","g":80},{"slug":"spring_onion","g":15}]'::jsonb,ARRAY['sport','vegetarian']::text[],ARRAY[]::text[],'1. Wel de couscous met heet water tot gaar, roer los met een vork en laat afkoelen.
2. Meng met fijngesneden rode ui, selderij en tomaat.
3. Roer de hummus erdoor, verkruimel de feta erover en werk af met bosui of bieslook.','1. Soak the couscous in hot water until done, fluff with a fork and let cool.
2. Mix with finely chopped red onion, celery and tomato.
3. Stir the hummus through, crumble the feta over and finish with spring onion or chives.','pan',null,'core'),
('cold_pasta_salad_with_tuna_lemon_olives','Koude pastasalade met tonijn, citroen & olijven','Cold pasta salad with tuna, lemon & olives',ARRAY['lunch'],ARRAY['cut','maintain'],'[{"slug":"pasta_whole","g":70},{"slug":"tuna_can","g":100},{"slug":"red_onion","g":30},{"slug":"olives","g":20},{"slug":"tomato","g":100},{"slug":"olive_oil","g":4}]'::jsonb,ARRAY['sport','high_protein']::text[],ARRAY[]::text[],'1. Kook de volkoren pasta beetgaar, spoel koud en laat uitlekken.
2. Meng met de tonijn, fijne rode ui, olijven en tomaat.
3. Maak aan met citroensap, een scheutje olijfolie, peper en zout.','1. Cook the wholegrain pasta al dente, rinse cold and drain.
2. Mix with the tuna, finely chopped red onion, olives and tomato.
3. Dress with lemon juice, a drizzle of olive oil, salt and pepper.','pan',null,'core'),
('sourdough_with_avocado_poached_egg_tomato_salsa','Desembrood met avocado, gepocheerd ei & tomatensalsa','Sourdough with avocado, poached egg & tomato salsa',ARRAY['breakfast','lunch'],ARRAY['maintain'],'[{"slug":"sourdough","g":80},{"slug":"avocado","g":50},{"slug":"egg","g":55},{"slug":"tomato","g":60},{"slug":"red_onion","g":20}]'::jsonb,ARRAY['sport','vegetarian']::text[],ARRAY[]::text[],'1. Rooster het desembrood.
2. Maak een snelle salsa van fijngesneden tomaat en rode ui met peper en zout.
3. Pocheer het ei 3 min in zacht kokend water met een scheut azijn.
4. Besmeer het brood met geprakte avocado, leg het ei erop en schep de salsa erover.','1. Toast the sourdough.
2. Make a quick salsa of finely chopped tomato and red onion with salt and pepper.
3. Poach the egg 3 min in gently simmering water with a splash of vinegar.
4. Spread the bread with mashed avocado, place the egg on top and spoon the salsa over.','pan',null,'core'),
('sourdough_with_tomato_low_fat_cheese_boiled_egg','Desembrood met tomaat, magere kaas & gekookt ei','Sourdough with tomato, low-fat cheese & boiled egg',ARRAY['breakfast','lunch'],ARRAY['maintain'],'[{"slug":"sourdough","g":80},{"slug":"tomato","g":60},{"slug":"low_fat_cheese","g":30},{"slug":"egg","g":55},{"slug":"lettuce","g":20}]'::jsonb,ARRAY['sport','vegetarian']::text[],ARRAY[]::text[],'1. Kook het ei 7–8 min hard, pel en snijd in plakjes.
2. Rooster het desembrood.
3. Beleg met sla, plakjes tomaat, magere kaas en het gesneden ei.','1. Hard-boil the egg 7–8 min, peel and slice.
2. Toast the sourdough.
3. Top with lettuce, tomato slices, low-fat cheese and the sliced egg.','pan',null,'core'),
('sourdough_with_hummus_feta_spring_onion','Desembrood met hummus, feta & bosui','Sourdough with hummus, feta & spring onion',ARRAY['breakfast','lunch'],ARRAY['maintain'],'[{"slug":"sourdough","g":80},{"slug":"hummus_light","g":30},{"slug":"feta_light","g":30},{"slug":"tomato","g":60},{"slug":"spring_onion","g":15}]'::jsonb,ARRAY['sport','vegetarian']::text[],ARRAY[]::text[],'1. Rooster het desembrood en besmeer met de hummus.
2. Beleg met plakjes tomaat en verkruimelde feta.
3. Werk af met fijngesneden bosui of bieslook.','1. Toast the sourdough and spread with the hummus.
2. Top with tomato slices and crumbled feta.
3. Finish with finely chopped spring onion or chives.','pan',null,'core'),
('greek_yoghurt_with_oats_mango_pumpkin_seeds','Griekse yoghurt met havermout, mango & pompoenpitten','Greek yoghurt with oats, mango & pumpkin seeds',ARRAY['breakfast'],ARRAY['cut','maintain'],'[{"slug":"greek_yoghurt","g":200},{"slug":"oats","g":40},{"slug":"mango","g":80},{"slug":"pumpkin_seeds","g":10}]'::jsonb,ARRAY['sport','high_protein','vegetarian']::text[],ARRAY[]::text[],'1. Meng de Griekse yoghurt met de havermout.
2. Schep in een kom en top met blokjes mango.
3. Strooi de pompoenpitten erover.','1. Mix the Greek yoghurt with the oats.
2. Spoon into a bowl and top with diced mango.
3. Scatter the pumpkin seeds over.','pan',null,'core'),
('wholegrain_porridge_with_banana_cinnamon_walnuts','Volkoren pap met banaan, kaneel & walnoten','Wholegrain porridge with banana, cinnamon & walnuts',ARRAY['breakfast'],ARRAY['maintain'],'[{"slug":"oats","g":70},{"slug":"milk_semi","g":250},{"slug":"banana","g":80},{"slug":"walnuts","g":10}]'::jsonb,ARRAY['sport','vegetarian']::text[],ARRAY[]::text[],'1. Breng de havermout met de melk al roerend aan de kook en gaar 3–4 min.
2. Roer er een snuf kaneel door.
3. Top met schijfjes banaan en grof gehakte walnoten.','1. Bring the oats and milk to a simmer, stirring, and cook 3–4 min.
2. Stir in a pinch of cinnamon.
3. Top with banana slices and roughly chopped walnuts.','pan',null,'core'),
('egg_white_omelette_with_mushrooms_spinach_tomato','Eiwitomelet met champignons, spinazie & tomaat','Egg-white omelette with mushrooms, spinach & tomato',ARRAY['breakfast'],ARRAY['cut','maintain'],'[{"slug":"egg","g":50},{"slug":"egg_white","g":120},{"slug":"mushroom","g":80},{"slug":"spinach","g":40},{"slug":"tomato","g":60}]'::jsonb,ARRAY['sport','high_protein','vegetarian']::text[],ARRAY[]::text[],'1. Klop het ei met het eiwit los.
2. Bak de champignons tot ze kleuren, voeg de spinazie en tomaat kort toe.
3. Giet het ei erbij en laat op laag vuur stollen tot een omelet.','1. Whisk the egg with the egg whites.
2. Fry the mushrooms until coloured, add the spinach and tomato briefly.
3. Pour in the egg and let it set on low heat into an omelette.','pan',null,'core'),
('wholegrain_bread_with_peanut_butter_banana','Volkorenboterham met pindakaas & banaan','Wholegrain bread with peanut butter & banana',ARRAY['breakfast','snack'],ARRAY['maintain'],'[{"slug":"bread_whole","g":70},{"slug":"peanut_butter","g":20},{"slug":"banana","g":80}]'::jsonb,ARRAY['sport','vegetarian','vegan']::text[],ARRAY[]::text[],'1. Rooster het volkorenbrood.
2. Besmeer dun met pindakaas.
3. Beleg met schijfjes banaan.','1. Toast the wholegrain bread.
2. Spread thinly with peanut butter.
3. Top with banana slices.','assembly',null,'core'),
('quark_with_raspberry_kiwi_chia','Kwark met framboos, kiwi & chiazaad','Quark with raspberry, kiwi & chia',ARRAY['breakfast','snack'],ARRAY['cut','maintain'],'[{"slug":"quark_lowfat","g":200},{"slug":"raspberry","g":60},{"slug":"kiwi","g":60},{"slug":"chia","g":10}]'::jsonb,ARRAY['sport','high_protein','vegetarian']::text[],ARRAY[]::text[],'1. Schep de kwark in een kom.
2. Top met frambozen en schijfjes kiwi.
3. Strooi het chiazaad erover.','1. Spoon the quark into a bowl.
2. Top with raspberries and kiwi slices.
3. Scatter the chia over.','assembly',null,'core'),
('shakshuka_with_egg_pepper_wholegrain_bread','Shakshuka met ei, paprika & volkorenbrood','Shakshuka with egg, pepper & wholegrain bread',ARRAY['breakfast','lunch'],ARRAY['maintain'],'[{"slug":"egg","g":120},{"slug":"passata","g":150},{"slug":"paprika","g":100},{"slug":"onion","g":40},{"slug":"bread_whole","g":60}]'::jsonb,ARRAY['sport','vegetarian']::text[],ARRAY[]::text[],'1. Fruit de ui en paprika zacht, voeg de passata toe met komijn en paprikapoeder.
2. Laat 8 min pruttelen, maak kuiltjes en breek de eieren erin.
3. Dek af en gaar tot het eiwit gestold is; serveer met het brood.','1. Soften the onion and pepper, add the passata with cumin and paprika.
2. Simmer 8 min, make wells and crack the eggs in.
3. Cover and cook until the whites set; serve with the bread.','pan',null,'core'),
('skyr_bowl_with_apple_cinnamon_walnuts','Skyr-bowl met appel, kaneel & walnoten','Skyr bowl with apple, cinnamon & walnuts',ARRAY['breakfast'],ARRAY['cut','maintain'],'[{"slug":"skyr","g":200},{"slug":"apple","g":100},{"slug":"oats","g":30},{"slug":"walnuts","g":10}]'::jsonb,ARRAY['sport','high_protein','vegetarian']::text[],ARRAY[]::text[],'1. Meng de skyr met de havermout.
2. Top met blokjes appel en een snuf kaneel.
3. Strooi grof gehakte walnoten erover.','1. Mix the skyr with the oats.
2. Top with diced apple and a pinch of cinnamon.
3. Scatter roughly chopped walnuts over.','pan',null,'core'),
('wholegrain_wrap_with_cottage_cheese_turkey_cucumber','Volkoren wrap met hüttenkäse, kalkoen & komkommer','Wholegrain wrap with cottage cheese, turkey & cucumber',ARRAY['breakfast','lunch'],ARRAY['cut','maintain'],'[{"slug":"wrap_whole","g":60},{"slug":"cottage","g":80},{"slug":"turkey_breast","g":70},{"slug":"cucumber","g":50}]'::jsonb,ARRAY['sport','high_protein']::text[],ARRAY[]::text[],'1. Besmeer de wrap met de hüttenkäse.
2. Beleg met plakjes kalkoenfilet en komkommer.
3. Rol strak op en snijd doormidden.','1. Spread the wrap with the cottage cheese.
2. Top with turkey slices and cucumber.
3. Roll up tightly and halve.','pan',null,'core'),
('protein_overnight_oats_with_banana_peanut_butter','Proteïne-overnight oats met banaan & pindakaas','Protein overnight oats with banana & peanut butter',ARRAY['breakfast'],ARRAY['maintain'],'[{"slug":"oats","g":50},{"slug":"skyr","g":150},{"slug":"milk_semi","g":100},{"slug":"banana","g":60},{"slug":"peanut_butter","g":12}]'::jsonb,ARRAY['sport','vegetarian']::text[],ARRAY[]::text[],'1. Meng de havermout, skyr en melk in een pot en laat een nacht opstijven.
2. Roer de volgende ochtend los.
3. Top met schijfjes banaan en een lepel pindakaas.','1. Mix the oats, skyr and milk in a jar and let set overnight.
2. Stir loose in the morning.
3. Top with banana slices and a spoon of peanut butter.','assembly',null,'core'),
('smoked_chicken_on_wholegrain_bread_with_egg_tomato','Gerookte kip op volkorenbrood met ei & tomaat','Smoked chicken on wholegrain bread with egg & tomato',ARRAY['breakfast','lunch'],ARRAY['cut','maintain'],'[{"slug":"bread_whole","g":80},{"slug":"chicken_breast","g":60},{"slug":"egg","g":55},{"slug":"tomato","g":50},{"slug":"lettuce","g":20}]'::jsonb,ARRAY['sport','high_protein']::text[],ARRAY[]::text[],'1. Kook het ei 7–8 min hard, pel en snijd in plakjes.
2. Rooster het volkorenbrood.
3. Beleg met sla, gerookte kip, plakjes tomaat en ei.','1. Hard-boil the egg 7–8 min, peel and slice.
2. Toast the wholegrain bread.
3. Top with lettuce, smoked chicken, tomato slices and egg.','pan',null,'core'),
('light_chicken_caesar_salad_with_egg_wholegrain_croutons','Kip-caesarsalade light met ei & volkoren croutons','Light chicken caesar salad with egg & wholegrain croutons',ARRAY['lunch'],ARRAY['cut','maintain'],'[{"slug":"chicken_breast","g":130},{"slug":"lettuce","g":80},{"slug":"egg","g":55},{"slug":"bread_whole","g":40},{"slug":"greek_yoghurt","g":40}]'::jsonb,ARRAY['sport','high_protein']::text[],ARRAY[]::text[],'1. Gril de kipfilet gaar en snijd in reepjes; kook het ei en halveer.
2. Rooster blokjes volkorenbrood tot croutons.
3. Meng de sla met een dressing van yoghurt, mosterd, citroen en peper; schik kip, ei en croutons erop.','1. Grill the chicken and slice; boil the egg and halve.
2. Toast diced wholegrain bread into croutons.
3. Toss the lettuce with a dressing of yoghurt, mustard, lemon and pepper; arrange chicken, egg and croutons on top.','pan',null,'core'),
('nicoise_salad_with_tuna_egg_green_beans','Niçoise-salade met tonijn, ei & sperziebonen','Niçoise salad with tuna, egg & green beans',ARRAY['lunch'],ARRAY['cut','maintain'],'[{"slug":"tuna_can","g":100},{"slug":"potato","g":150},{"slug":"green_beans","g":100},{"slug":"egg","g":55},{"slug":"tomato","g":80},{"slug":"olives","g":15}]'::jsonb,ARRAY['sport','high_protein']::text[],ARRAY[]::text[],'1. Kook de aardappels en sperziebonen beetgaar; kook het ei en halveer.
2. Schik de aardappel, sperziebonen, tomaat en olijven op een bord.
3. Verdeel de tonijn en het ei erover en besprenkel met citroen en peper.','1. Boil the potatoes and green beans; boil the egg and halve.
2. Arrange the potato, green beans, tomato and olives on a plate.
3. Spread the tuna and egg over and drizzle with lemon and pepper.','pan',null,'core'),
('bulgur_salad_with_chickpeas_feta_mint','Bulgursalade met kikkererwten, feta & munt','Bulgur salad with chickpeas, feta & mint',ARRAY['lunch'],ARRAY['maintain'],'[{"slug":"bulgur","g":60},{"slug":"chickpeas","g":100},{"slug":"feta_light","g":40},{"slug":"cucumber","g":80},{"slug":"tomato","g":80}]'::jsonb,ARRAY['sport','vegetarian']::text[],ARRAY[]::text[],'1. Kook de bulgur gaar en laat afkoelen.
2. Meng met kikkererwten, blokjes komkommer en tomaat.
3. Verkruimel de feta erover en werk af met munt, citroen en peper.','1. Cook the bulgur and let cool.
2. Mix with chickpeas, diced cucumber and tomato.
3. Crumble the feta over and finish with mint, lemon and pepper.','pan',null,'core'),
('pita_with_chicken_shawarma_yoghurt_sauce_salad','Pita met kipshoarma, yoghurtsaus & salade','Pita with chicken shawarma, yoghurt sauce & salad',ARRAY['lunch','dinner'],ARRAY['cut','maintain'],'[{"slug":"pita_whole","g":60},{"slug":"chicken_breast","g":140},{"slug":"yoghurt_lowfat","g":40},{"slug":"lettuce","g":30},{"slug":"tomato","g":60}]'::jsonb,ARRAY['sport','high_protein']::text[],ARRAY[]::text[],'1. Kruid de kipreepjes met shoarmakruiden en bak ze gaar.
2. Roer een saus van yoghurt, knoflook, citroen en peper.
3. Vul de warme pita met sla, tomaat, de kip en de yoghurtsaus.','1. Season the chicken strips with shawarma spice and cook through.
2. Stir a sauce of yoghurt, garlic, lemon and pepper.
3. Fill the warm pita with lettuce, tomato, the chicken and the yoghurt sauce.','pan',null,'core'),
('whole_wheat_noodles_with_tofu_broccoli_soy','Volkoren noedels met tofu, broccoli & soja','Whole-wheat noodles with tofu, broccoli & soy',ARRAY['lunch','dinner'],ARRAY['maintain'],'[{"slug":"noodles_whole","g":70},{"slug":"tofu","g":160},{"slug":"broccoli","g":120},{"slug":"soy_sauce","g":12}]'::jsonb,ARRAY['sport','vegetarian','vegan']::text[],ARRAY[]::text[],'1. Kook de volkoren noedels beetgaar.
2. Bak de tofublokjes goudbruin, voeg de broccoli toe en roerbak beetgaar.
3. Meng de noedels en sojasaus erdoor.','1. Cook the whole-wheat noodles al dente.
2. Fry the tofu until golden, add the broccoli and stir-fry until tender.
3. Toss the noodles and soy sauce through.','pan',null,'core'),
('mexican_bowl_with_black_beans_corn_avocado','Mexicaanse bowl met zwarte bonen, mais & avocado','Mexican bowl with black beans, corn & avocado',ARRAY['lunch','dinner'],ARRAY['gain','maintain'],'[{"slug":"black_beans","g":150},{"slug":"rice_dry","g":60},{"slug":"corn","g":80},{"slug":"avocado","g":40},{"slug":"tomato","g":80}]'::jsonb,ARRAY['sport','vegetarian','vegan']::text[],ARRAY[]::text[],'1. Kook de rijst gaar.
2. Verwarm de zwarte bonen met komijn en paprikapoeder.
3. Schik rijst, bonen, mais, tomaat en avocado in een kom; knijp er limoen over.','1. Cook the rice.
2. Warm the black beans with cumin and paprika.
3. Arrange rice, beans, corn, tomato and avocado in a bowl; squeeze lime over.','pan',null,'core'),
('smoked_salmon_on_wholegrain_bread_with_cottage_cheese','Gerookte zalm op volkorenbrood met hüttenkäse','Smoked salmon on wholegrain bread with cottage cheese',ARRAY['lunch','breakfast'],ARRAY['cut','maintain'],'[{"slug":"bread_whole","g":80},{"slug":"smoked_salmon","g":60},{"slug":"cottage","g":60},{"slug":"red_onion","g":20},{"slug":"cucumber","g":40}]'::jsonb,ARRAY['sport','high_protein']::text[],ARRAY[]::text[],'1. Rooster het volkorenbrood en besmeer met de hüttenkäse.
2. Beleg met de gerookte zalm.
3. Werk af met fijne rode ui, komkommer en peper.','1. Toast the wholegrain bread and spread with the cottage cheese.
2. Top with the smoked salmon.
3. Finish with finely chopped red onion, cucumber and pepper.','pan',null,'core'),
('thai_chicken_salad_with_rice_noodles_lime','Thaise kipsalade met rijstnoedels & limoen','Thai chicken salad with rice noodles & lime',ARRAY['lunch'],ARRAY['cut','maintain'],'[{"slug":"chicken_breast","g":130},{"slug":"rice_noodles","g":55},{"slug":"carrot","g":60},{"slug":"cucumber","g":60},{"slug":"soy_sauce","g":10}]'::jsonb,ARRAY['sport','high_protein']::text[],ARRAY[]::text[],'1. Week de rijstnoedels gaar en spoel koud.
2. Gril de kipfilet en snijd in reepjes.
3. Meng de noedels met julienne van wortel en komkommer, de kip, sojasaus, limoen en verse koriander.','1. Soak the rice noodles until done and rinse cold.
2. Grill the chicken and slice.
3. Toss the noodles with julienned carrot and cucumber, the chicken, soy sauce, lime and fresh coriander.','pan',null,'core'),
('lentil_soup_with_carrot_leek_wholegrain_bread','Linzensoep met wortel, prei & volkorenbrood','Lentil soup with carrot, leek & wholegrain bread',ARRAY['lunch'],ARRAY['maintain'],'[{"slug":"lentils","g":150},{"slug":"carrot","g":80},{"slug":"leek","g":60},{"slug":"onion","g":40},{"slug":"bread_whole","g":60}]'::jsonb,ARRAY['sport','vegetarian','vegan']::text[],ARRAY[]::text[],'1. Fruit de ui, wortel en prei kort aan.
2. Voeg de linzen en bouillon toe en laat 15–18 min garen.
3. Breng op smaak met komijn en peper; serveer met het brood.','1. Sweat the onion, carrot and leek briefly.
2. Add the lentils and stock and simmer 15–18 min.
3. Season with cumin and pepper; serve with the bread.','soup',null,'core'),
('omelette_with_lean_ham_mushroom_pepper','Omelet met magere ham, champignon & paprika','Omelette with lean ham, mushroom & pepper',ARRAY['lunch','breakfast'],ARRAY['cut','maintain'],'[{"slug":"egg","g":100},{"slug":"egg_white","g":60},{"slug":"ham_lean","g":50},{"slug":"mushroom","g":60},{"slug":"paprika","g":60}]'::jsonb,ARRAY['sport','high_protein']::text[],ARRAY[]::text[],'1. Klop het ei met het eiwit los.
2. Bak de champignons en paprika kort, voeg de ham toe.
3. Giet het ei erbij en laat op laag vuur stollen.','1. Whisk the egg with the egg white.
2. Fry the mushrooms and pepper briefly, add the ham.
3. Pour in the egg and set on low heat.','pan',null,'core'),
('roast_beef_bowl_with_brown_rice_rocket_tomato','Rosbief-bowl met zilvervliesrijst, rucola & tomaat','Roast beef bowl with brown rice, rocket & tomato',ARRAY['lunch'],ARRAY['maintain'],'[{"slug":"rosbief","g":90},{"slug":"brown_rice","g":60},{"slug":"rocket","g":40},{"slug":"cherry_tomato","g":100},{"slug":"olive_oil","g":5}]'::jsonb,ARRAY['sport']::text[],ARRAY[]::text[],'1. Kook de zilvervliesrijst gaar en laat iets afkoelen.
2. Schik rijst, rucola en gehalveerde cherrytomaten in een kom.
3. Verdeel de rosbief erover en besprenkel met olijfolie, citroen en peper.','1. Cook the brown rice and let cool slightly.
2. Arrange rice, rocket and halved cherry tomatoes in a bowl.
3. Spread the roast beef over and drizzle with olive oil, lemon and pepper.','pan',null,'core'),
('shrimp_salad_with_mango_avocado_little_gem','Garnalensalade met mango, avocado & little gem','Shrimp salad with mango, avocado & little gem',ARRAY['lunch'],ARRAY['cut','maintain'],'[{"slug":"shrimp","g":120},{"slug":"mango","g":80},{"slug":"avocado","g":40},{"slug":"lettuce","g":60},{"slug":"cucumber","g":50}]'::jsonb,ARRAY['sport','high_protein']::text[],ARRAY[]::text[],'1. Bak de garnalen kort tot ze roze en gaar zijn.
2. Schik de sla met blokjes mango, avocado en komkommer.
3. Verdeel de garnalen erover en maak aan met limoen, peper en zout.','1. Sear the shrimp until pink and done.
2. Arrange the lettuce with diced mango, avocado and cucumber.
3. Spread the shrimp over and dress with lime, salt and pepper.','pan',null,'core'),
('caprese_sandwich_with_light_mozzarella_tomato_basil','Caprese-boterham met mozzarella light, tomaat & basilicum','Caprese sandwich with light mozzarella, tomato & basil',ARRAY['lunch'],ARRAY['maintain'],'[{"slug":"bread_whole","g":80},{"slug":"mozzarella_light","g":60},{"slug":"tomato","g":80},{"slug":"pesto","g":8}]'::jsonb,ARRAY['sport','vegetarian']::text[],ARRAY[]::text[],'1. Rooster het volkorenbrood en bestrijk dun met pesto.
2. Beleg met plakjes mozzarella en tomaat.
3. Werk af met verse basilicum en peper.','1. Toast the wholegrain bread and spread thinly with pesto.
2. Top with mozzarella and tomato slices.
3. Finish with fresh basil and pepper.','pan',null,'core'),
('couscous_with_roasted_vegetables_chicken','Couscous met geroosterde groente & kipfilet','Couscous with roasted vegetables & chicken',ARRAY['lunch','dinner'],ARRAY['cut','maintain'],'[{"slug":"couscous","g":60},{"slug":"chicken_breast","g":130},{"slug":"eggplant","g":80},{"slug":"paprika","g":80},{"slug":"olive_oil","g":6}]'::jsonb,ARRAY['sport','high_protein']::text[],ARRAY[]::text[],'1. Rooster de aubergine en paprika met de olijfolie 20 min op 200°C.
2. Wel de couscous met heet water tot gaar en roer los.
3. Bak de kipfilet gaar, snijd aan en meng met de couscous en geroosterde groente.','1. Roast the eggplant and pepper with the olive oil 20 min at 200°C.
2. Soak the couscous in hot water until done and fluff.
3. Cook the chicken, slice and mix with the couscous and roasted vegetables.','oven',null,'core'),
('chicken_curry_with_light_coconut_milk_pepper_rice','Kipcurry met kokosmelk light, paprika & rijst','Chicken curry with light coconut milk, pepper & rice',ARRAY['dinner'],ARRAY['cut','maintain'],'[{"slug":"chicken_breast","g":150},{"slug":"rice_dry","g":65},{"slug":"coconut_light","g":80},{"slug":"paprika","g":100},{"slug":"curry_paste","g":20}]'::jsonb,ARRAY['sport','high_protein']::text[],ARRAY[]::text[],'1. Kook de rijst gaar.
2. Bak de currypasta kort aan, voeg de kip en paprika toe en bak mee.
3. Blus af met de kokosmelk en laat 8 min pruttelen; serveer over de rijst.','1. Cook the rice.
2. Fry the curry paste briefly, add the chicken and pepper and cook.
3. Deglaze with the coconut milk and simmer 8 min; serve over the rice.','pan',null,'core'),
('salmon_teriyaki_with_brown_rice_broccoli','Zalm-teriyaki met zilvervliesrijst & broccoli','Salmon teriyaki with brown rice & broccoli',ARRAY['dinner'],ARRAY['gain','maintain'],'[{"slug":"salmon","g":140},{"slug":"brown_rice","g":65},{"slug":"broccoli","g":150},{"slug":"teriyaki","g":25}]'::jsonb,ARRAY['sport']::text[],ARRAY[]::text[],'1. Kook de zilvervliesrijst gaar.
2. Bak de zalm kort aan beide kanten en lak met de teriyaki.
3. Stoom de broccoli beetgaar en serveer over de rijst.','1. Cook the brown rice.
2. Sear the salmon on both sides and glaze with the teriyaki.
3. Steam the broccoli until tender and serve over the rice.','pan',null,'core'),
('oven_white_fish_with_tomato_zucchini_potato','Witvis uit de oven met tomaat, courgette & aardappel','Oven white fish with tomato, zucchini & potato',ARRAY['dinner'],ARRAY['cut','maintain'],'[{"slug":"white_fish","g":160},{"slug":"potato","g":220},{"slug":"zucchini","g":120},{"slug":"cherry_tomato","g":100},{"slug":"olive_oil","g":6}]'::jsonb,ARRAY['sport','high_protein']::text[],ARRAY[]::text[],'1. Snijd de aardappel en courgette, hussel met olijfolie en rooster 20 min op 200°C.
2. Leg de witvis met cherrytomaten de laatste 12 min erbij.
3. Breng op smaak met citroen, peper en zout.','1. Slice the potato and zucchini, toss with olive oil and roast 20 min at 200°C.
2. Add the white fish with cherry tomatoes for the final 12 min.
3. Season with lemon, salt and pepper.','oven',null,'core'),
('chicken_mince_bolognese_with_wholegrain_pasta_zucchini','Kipgehakt-bolognese met volkoren pasta & courgette','Chicken mince bolognese with wholegrain pasta & zucchini',ARRAY['dinner'],ARRAY['gain','maintain'],'[{"slug":"chicken_mince","g":150},{"slug":"pasta_whole","g":75},{"slug":"passata","g":150},{"slug":"zucchini","g":100},{"slug":"onion","g":40}]'::jsonb,ARRAY['sport']::text[],ARRAY[]::text[],'1. Kook de volkoren pasta beetgaar.
2. Rul het kipgehakt met de ui, voeg de passata en blokjes courgette toe.
3. Laat 10 min pruttelen met Italiaanse kruiden en schep over de pasta.','1. Cook the wholegrain pasta al dente.
2. Brown the chicken mince with the onion, add the passata and diced zucchini.
3. Simmer 10 min with Italian herbs and spoon over the pasta.','pan',null,'core'),
('chicken_fajita_bowl_with_pepper_black_beans_rice','Kip-fajita bowl met paprika, zwarte bonen & rijst','Chicken fajita bowl with pepper, black beans & rice',ARRAY['dinner'],ARRAY['cut','gain','maintain'],'[{"slug":"chicken_breast","g":150},{"slug":"rice_dry","g":60},{"slug":"paprika","g":100},{"slug":"black_beans","g":100},{"slug":"onion","g":40}]'::jsonb,ARRAY['sport','high_protein']::text[],ARRAY[]::text[],'1. Kook de rijst gaar.
2. Bak de kip met fajitakruiden, paprika en ui op hoog vuur.
3. Verwarm de zwarte bonen en schik alles over de rijst; werk af met limoen.','1. Cook the rice.
2. Fry the chicken with fajita spice, pepper and onion on high heat.
3. Warm the black beans and arrange everything over the rice; finish with lime.','pan',null,'core'),
('steak_with_sweet_potato_fries_salad','Biefstuk met zoete-aardappelfriet & salade','Steak with sweet potato fries & salad',ARRAY['dinner'],ARRAY['cut','maintain'],'[{"slug":"beef_lean","g":150},{"slug":"sweet_potato","g":220},{"slug":"lettuce","g":60},{"slug":"tomato","g":80},{"slug":"olive_oil","g":6}]'::jsonb,ARRAY['sport','high_protein']::text[],ARRAY[]::text[],'1. Snijd de zoete aardappel in frieten, hussel met olijfolie en bak 25 min op 220°C.
2. Bak de biefstuk 2–3 min per kant en laat rusten.
3. Serveer met een frisse salade van sla en tomaat.','1. Cut the sweet potato into fries, toss with olive oil and bake 25 min at 220°C.
2. Sear the steak 2–3 min per side and rest.
3. Serve with a fresh salad of lettuce and tomato.','oven',null,'core'),
('sous_vide_salmon_50_c_with_potato_asparagus','Zalm sous-vide 50°C met aardappel & asperges','Sous-vide salmon 50°C with potato & asparagus',ARRAY['dinner'],ARRAY['maintain'],'[{"slug":"salmon","g":140},{"slug":"potato","g":220},{"slug":"asparagus","g":120},{"slug":"olive_oil","g":5}]'::jsonb,ARRAY['sport','sousvide']::text[],ARRAY[]::text[],'1. Vacumeer de zalm met wat olijfolie en citroen en gaar sous-vide op 50°C (30–40 min).
2. Kook de aardappels gaar en stoom de asperges beetgaar.
3. Schroei de zalm eventueel kort op de velkant en serveer met de groente.','1. Vacuum-seal the salmon with a little olive oil and lemon and cook sous-vide at 50°C (30–40 min).
2. Boil the potatoes and steam the asparagus until tender.
3. Optionally sear the salmon briefly skin-side and serve with the vegetables.','sousvide','50°C','core'),
('turkey_stir_fry_with_cashew_pepper_rice','Kalkoen-roerbak met cashew, paprika & rijst','Turkey stir-fry with cashew, pepper & rice',ARRAY['dinner'],ARRAY['cut','maintain'],'[{"slug":"turkey_breast","g":150},{"slug":"rice_dry","g":65},{"slug":"paprika","g":100},{"slug":"cashew","g":15},{"slug":"soy_sauce","g":12}]'::jsonb,ARRAY['sport','high_protein']::text[],ARRAY[]::text[],'1. Kook de rijst gaar.
2. Roerbak de kalkoenreepjes op hoog vuur, voeg de paprika toe.
3. Blus af met sojasaus, roer de cashewnoten erdoor en serveer over de rijst.','1. Cook the rice.
2. Stir-fry the turkey strips on high heat, add the pepper.
3. Deglaze with soy sauce, stir in the cashews and serve over the rice.','pan',null,'core'),
('shrimp_curry_with_light_coconut_milk_rice','Garnalencurry met kokosmelk light & rijst','Shrimp curry with light coconut milk & rice',ARRAY['dinner'],ARRAY['maintain'],'[{"slug":"shrimp","g":140},{"slug":"rice_dry","g":65},{"slug":"coconut_light","g":80},{"slug":"paprika","g":80},{"slug":"curry_paste","g":20}]'::jsonb,ARRAY['sport']::text[],ARRAY[]::text[],'1. Kook de rijst gaar.
2. Bak de currypasta kort, voeg de paprika en kokosmelk toe en laat pruttelen.
3. Voeg de garnalen toe en gaar 3–4 min tot ze roze zijn; serveer over de rijst.','1. Cook the rice.
2. Fry the curry paste briefly, add the pepper and coconut milk and simmer.
3. Add the shrimp and cook 3–4 min until pink; serve over the rice.','pan',null,'core'),
('tofu_teriyaki_with_noodles_broccoli','Tofu-teriyaki met noedels & broccoli','Tofu teriyaki with noodles & broccoli',ARRAY['dinner'],ARRAY['maintain'],'[{"slug":"tofu","g":180},{"slug":"noodles_whole","g":70},{"slug":"broccoli","g":150},{"slug":"teriyaki","g":25}]'::jsonb,ARRAY['sport','vegetarian','vegan']::text[],ARRAY[]::text[],'1. Kook de volkoren noedels beetgaar.
2. Bak de tofublokjes goudbruin en knapperig.
3. Voeg de broccoli en teriyaki toe, roerbak beetgaar en meng de noedels erdoor.','1. Cook the whole-wheat noodles al dente.
2. Fry the tofu until golden and crisp.
3. Add the broccoli and teriyaki, stir-fry until tender and toss the noodles through.','pan',null,'core'),
('chicken_souvlaki_with_bulgur_tzatziki_tomato','Kip-souvlaki met bulgur, tzatziki & tomaat','Chicken souvlaki with bulgur, tzatziki & tomato',ARRAY['dinner'],ARRAY['cut','maintain'],'[{"slug":"chicken_breast","g":150},{"slug":"bulgur","g":60},{"slug":"yoghurt_lowfat","g":60},{"slug":"cucumber","g":60},{"slug":"tomato","g":80}]'::jsonb,ARRAY['sport','high_protein']::text[],ARRAY[]::text[],'1. Kook de bulgur gaar.
2. Rijg de gekruide kip en gril gaar.
3. Rasp de komkommer en meng met de yoghurt en knoflook tot tzatziki; serveer met de bulgur en tomaat.','1. Cook the bulgur.
2. Skewer the seasoned chicken and grill.
3. Grate the cucumber and mix with the yoghurt and garlic into tzatziki; serve with the bulgur and tomato.','pan',null,'core'),
('lentil_dal_with_rice_spinach','Linzen-dal met rijst & spinazie','Lentil dal with rice & spinach',ARRAY['dinner'],ARRAY['maintain'],'[{"slug":"lentils","g":180},{"slug":"rice_dry","g":60},{"slug":"spinach","g":80},{"slug":"onion","g":40},{"slug":"curry_paste","g":15}]'::jsonb,ARRAY['sport','vegetarian','vegan']::text[],ARRAY[]::text[],'1. Kook de rijst gaar.
2. Fruit de ui met de currypasta, voeg de linzen en een scheut water toe en laat 10 min pruttelen.
3. Roer de spinazie erdoor tot geslonken en serveer over de rijst.','1. Cook the rice.
2. Fry the onion with the curry paste, add the lentils and a splash of water and simmer 10 min.
3. Stir the spinach through until wilted and serve over the rice.','pan',null,'core'),
('stuffed_pepper_with_chicken_mince_rice_tomato','Gevulde paprika met kipgehakt, rijst & tomaat','Stuffed pepper with chicken mince, rice & tomato',ARRAY['dinner'],ARRAY['maintain'],'[{"slug":"paprika","g":160},{"slug":"chicken_mince","g":120},{"slug":"rice_dry","g":50},{"slug":"passata","g":100},{"slug":"onion","g":40}]'::jsonb,ARRAY['sport']::text[],ARRAY[]::text[],'1. Kook de rijst gaar en rul het kipgehakt met de ui.
2. Meng de rijst, het gehakt en de passata met kruiden.
3. Vul de halve paprika''s en bak 25 min op 200°C tot gaar.','1. Cook the rice and brown the chicken mince with the onion.
2. Mix the rice, mince and passata with herbs.
3. Fill the pepper halves and bake 25 min at 200°C until done.','oven',null,'core'),
('white_fish_with_curry_cauliflower_rice','Witvis met kerrie, bloemkool & rijst','White fish with curry, cauliflower & rice',ARRAY['dinner'],ARRAY['cut','maintain'],'[{"slug":"white_fish","g":160},{"slug":"rice_dry","g":65},{"slug":"cauliflower","g":150},{"slug":"coconut_light","g":60},{"slug":"curry_paste","g":15}]'::jsonb,ARRAY['sport','high_protein']::text[],ARRAY[]::text[],'1. Kook de rijst gaar.
2. Bak de currypasta kort, voeg de kokosmelk en bloemkoolroosjes toe en gaar 8 min.
3. Leg de witvis erin en pocheer 5–6 min tot gaar; serveer met de rijst.','1. Cook the rice.
2. Fry the curry paste briefly, add the coconut milk and cauliflower florets and cook 8 min.
3. Lay the white fish in and poach 5–6 min until done; serve with the rice.','pan',null,'core'),
('beef_chili_con_carne_with_kidney_beans_rice','Rundergehakt-chili con carne met kidneybonen & rijst','Beef chili con carne with kidney beans & rice',ARRAY['dinner'],ARRAY['gain','maintain'],'[{"slug":"beef_mince5","g":140},{"slug":"kidney_beans","g":120},{"slug":"passata","g":150},{"slug":"corn","g":60},{"slug":"rice_dry","g":60}]'::jsonb,ARRAY['sport']::text[],ARRAY[]::text[],'1. Kook de rijst gaar.
2. Rul het gehakt, voeg de passata, kidneybonen en mais toe met komijn, paprikapoeder en chili.
3. Laat 12 min pruttelen en serveer over de rijst.','1. Cook the rice.
2. Brown the mince, add the passata, kidney beans and corn with cumin, paprika and chili.
3. Simmer 12 min and serve over the rice.','pan',null,'core'),
('cod_with_pea_mash_potato','Kabeljauw met erwtenpuree & aardappel','Cod with pea mash & potato',ARRAY['dinner'],ARRAY['cut','maintain'],'[{"slug":"cod","g":160},{"slug":"potato","g":220},{"slug":"peas","g":150},{"slug":"olive_oil","g":5}]'::jsonb,ARRAY['sport','high_protein']::text[],ARRAY[]::text[],'1. Kook de aardappels gaar.
2. Kook de doperwten kort en pureer ze grof met wat peper en munt.
3. Bak de kabeljauw 3–4 min per kant tot gaar en serveer met de puree en aardappel.','1. Boil the potatoes.
2. Cook the peas briefly and mash coarsely with pepper and mint.
3. Pan-fry the cod 3–4 min per side until done and serve with the mash and potato.','pan',null,'core'),
('sous_vide_chicken_thigh_65_c_with_sweet_potato_vegetables','Kipdij sous-vide 65°C met zoete aardappel & groente','Sous-vide chicken thigh 65°C with sweet potato & vegetables',ARRAY['dinner'],ARRAY['maintain'],'[{"slug":"chicken_thigh","g":150},{"slug":"sweet_potato","g":200},{"slug":"green_beans","g":120},{"slug":"olive_oil","g":5}]'::jsonb,ARRAY['sport','sousvide']::text[],ARRAY[]::text[],'1. Vacumeer de kipdij en gaar sous-vide op 65°C (1,5–4 u) tot mals en gaar.
2. Rooster de zoete aardappel in de oven op 200°C in ca. 25 min.
3. Stoom de sperziebonen beetgaar, schroei de kipdij kort aan en serveer samen.','1. Vacuum-seal the chicken thigh and cook sous-vide at 65°C (1.5–4 h) until tender and done.
2. Roast the sweet potato in the oven at 200°C for about 25 min.
3. Steam the green beans, sear the thigh briefly and serve together.','sousvide','65°C','core'),
('wholegrain_crackers_with_low_fat_cheese_cucumber','Volkoren crackers met magere kaas & komkommer','Wholegrain crackers with low-fat cheese & cucumber',ARRAY['snack'],ARRAY['maintain'],'[{"slug":"crackers_whole","g":24},{"slug":"low_fat_cheese","g":30},{"slug":"cucumber","g":40}]'::jsonb,ARRAY['sport','vegetarian']::text[],ARRAY[]::text[],'1. Beleg de crackers met plakjes magere kaas.
2. Leg er dunne plakjes komkommer op.
3. Maal er wat peper over.','1. Top the crackers with slices of low-fat cheese.
2. Add thin cucumber slices.
3. Grind some pepper over.','assembly',null,'core'),
('protein_energy_balls_of_date_oats_peanut_butter','Proteïne-energieballen van dadel, havermout & pindakaas','Protein energy balls of date, oats & peanut butter',ARRAY['snack'],ARRAY['maintain'],'[{"slug":"dates","g":60},{"slug":"oats","g":30},{"slug":"peanut_butter","g":15},{"slug":"whey","g":15}]'::jsonb,ARRAY['sport','vegetarian']::text[],ARRAY[]::text[],'1. Pureer de dadels met de havermout, pindakaas en whey tot een kleverige massa.
2. Rol er balletjes van.
3. Laat 30 min opstijven in de koelkast.','1. Blend the dates with the oats, peanut butter and whey into a sticky mass.
2. Roll into balls.
3. Chill 30 min to firm up.','blender',null,'core'),
('quark_with_mango_pumpkin_seeds','Kwark met mango & pompoenpitten','Quark with mango & pumpkin seeds',ARRAY['snack'],ARRAY['cut','maintain'],'[{"slug":"quark_lowfat","g":150},{"slug":"mango","g":70},{"slug":"pumpkin_seeds","g":10}]'::jsonb,ARRAY['sport','high_protein','vegetarian']::text[],ARRAY[]::text[],'1. Schep de kwark in een kom.
2. Top met blokjes mango.
3. Strooi de pompoenpitten erover.','1. Spoon the quark into a bowl.
2. Top with diced mango.
3. Scatter the pumpkin seeds over.','assembly',null,'core'),
('cottage_cheese_with_cucumber_tomato','Hüttenkäse met komkommer & tomaat','Cottage cheese with cucumber & tomato',ARRAY['snack'],ARRAY['cut','maintain'],'[{"slug":"cottage","g":150},{"slug":"cucumber","g":60},{"slug":"cherry_tomato","g":60}]'::jsonb,ARRAY['sport','high_protein','vegetarian']::text[],ARRAY[]::text[],'1. Schep de hüttenkäse in een kom.
2. Meng er blokjes komkommer en gehalveerde cherrytomaat door.
3. Breng op smaak met peper en wat bieslook.','1. Spoon the cottage cheese into a bowl.
2. Mix in diced cucumber and halved cherry tomato.
3. Season with pepper and some chives.','assembly',null,'core'),
('rice_cakes_with_peanut_butter_banana','Rijstwafels met pindakaas & banaan','Rice cakes with peanut butter & banana',ARRAY['snack'],ARRAY['maintain'],'[{"slug":"rice_cakes","g":26},{"slug":"peanut_butter","g":15},{"slug":"banana","g":60}]'::jsonb,ARRAY['sport','vegetarian','vegan']::text[],ARRAY[]::text[],'1. Besmeer de rijstwafels dun met pindakaas.
2. Beleg met schijfjes banaan.','1. Spread the rice cakes thinly with peanut butter.
2. Top with banana slices.','assembly',null,'core'),
('apple_with_peanut_butter','Appel met pindakaas','Apple with peanut butter',ARRAY['snack'],ARRAY['maintain'],'[{"slug":"apple","g":150},{"slug":"peanut_butter","g":15}]'::jsonb,ARRAY['sport','vegetarian','vegan']::text[],ARRAY[]::text[],'1. Snijd de appel in partjes.
2. Dip ze in de pindakaas.','1. Slice the apple into wedges.
2. Dip them in the peanut butter.','assembly',null,'core'),
('skyr_with_oats_raspberries','Skyr met havermout & frambozen','Skyr with oats & raspberries',ARRAY['snack'],ARRAY['cut','maintain'],'[{"slug":"skyr","g":150},{"slug":"oats","g":25},{"slug":"raspberry","g":60}]'::jsonb,ARRAY['sport','high_protein','vegetarian']::text[],ARRAY[]::text[],'1. Meng de skyr met de havermout.
2. Top met de frambozen.','1. Mix the skyr with the oats.
2. Top with the raspberries.','assembly',null,'core'),
('pear_with_walnuts_cinnamon','Peer met walnoten & kaneel','Pear with walnuts & cinnamon',ARRAY['snack'],ARRAY['maintain'],'[{"slug":"pear","g":150},{"slug":"walnuts","g":12},{"slug":"quark_lowfat","g":80}]'::jsonb,ARRAY['sport','vegetarian']::text[],ARRAY[]::text[],'1. Snijd de peer in partjes.
2. Serveer met een lepel kwark, grof gehakte walnoten en een snuf kaneel.','1. Slice the pear into wedges.
2. Serve with a spoon of quark, roughly chopped walnuts and a pinch of cinnamon.','assembly',null,'core')
on conflict (slug) do update set name_nl=excluded.name_nl,name_en=excluded.name_en,moments=excluded.moments,goals=excluded.goals,items=excluded.items,tags=excluded.tags,prefs=excluded.prefs,steps=excluded.steps,steps_en=excluded.steps_en,technique=excluded.technique,temp=excluded.temp;
commit;
