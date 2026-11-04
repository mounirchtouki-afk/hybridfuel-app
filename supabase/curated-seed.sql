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
('orange','Sinaasappel','Orange',47,0.9,12,0.1,'fruit','core'),
('kiwi','Kiwi','Kiwi',61,1.1,15,0.5,'fruit','core'),
('dates','Dadels','Dates',282,2,75,0.4,'fruit','core'),
('coconut_light','Kokosmelk (light)','Coconut milk (light)',73,0.6,2,7,'overig','core'),
('curry_paste','Currypasta','Curry paste',110,2,10,6,'overig','core'),
('passata','Tomatenpassata','Tomato passata',35,1.5,6,0.3,'groente','core'),
('pesto','Pesto','Pesto',300,4,4,30,'vet','core'),
('mozzarella_light','Mozzarella (light)','Mozzarella (light)',170,20,2,9,'zuivel','core'),
('cashew','Cashewnoten','Cashews',553,18,30,44,'noten','core'),
('pumpkin_seeds','Pompoenpitten','Pumpkin seeds',559,30,11,49,'noten','core'),
('peanut_butter','Pindakaas','Peanut butter',588,25,20,50,'noten','core'),
('turkey_mince','Kalkoengehakt','Turkey mince',150,18,0,8,'vlees','core'),
('seitan','Seitan','Seitan',120,21,4,2,'vega','core'),
('polenta','Polenta','Polenta',85,2,18,0.4,'granen','core'),
('butternut','Pompoen (butternut)','Butternut squash',45,1,12,0.1,'groente','core'),
('beetroot','Rode biet','Beetroot',43,1.6,10,0.2,'groente','core'),
('fennel','Venkel','Fennel',31,1.2,7,0.2,'groente','core'),
('brussels_sprouts','Spruitjes','Brussels sprouts',43,3.4,9,0.3,'groente','core'),
('bok_choy','Paksoi','Bok choy',13,1.5,2.2,0.2,'groente','core'),
('bean_sprouts','Taugé','Bean sprouts',23,3,4,0.1,'groente','core'),
('pineapple','Ananas','Pineapple',50,0.5,13,0.1,'fruit','core'),
('grapes','Druiven','Grapes',69,0.7,18,0.2,'fruit','core'),
('soy_yoghurt','Sojayoghurt','Soy yoghurt',50,4,5,2,'zuivel','core'),
('oat_milk','Havermelk','Oat milk',45,1,7,1.5,'overig','core'),
('harissa','Harissa','Harissa',70,3,10,2,'overig','core'),
('miso','Miso','Miso',199,12,26,6,'overig','core'),
('sesame','Sesamzaad','Sesame seeds',573,18,23,50,'noten','core'),
('tuna_steak','Tonijnsteak','Tuna steak',130,28,0,1,'vis','core'),
('sea_bass','Zeebaars','Sea bass',100,20,0,2,'vis','core'),
('white_beans','Witte bonen','White beans',127,8,21,0.5,'peulvrucht','core'),
('radish','Radijs','Radish',16,0.7,3,0.1,'groente','core'),
('gochujang','Gochujang','Gochujang',165,4,34,2,'overig','core'),
('granola','Granola','Granola',450,8,64,14,'granen','core'),
('kale','Boerenkool','Kale',49,4,9,0.9,'groente','core'),
('endive','Andijvie','Endive',17,1.3,3,0.2,'groente','core'),
('oyster_sauce','Oestersaus','Oyster sauce',51,2,11,0.3,'overig','core'),
('almond_butter','Amandelpasta','Almond butter',614,21,19,56,'noten','core'),
('trout','Forel','Trout',140,20,0,6,'vis','core'),
('mussels','Mosselen','Mussels',86,12,4,2,'vis','core'),
('pomegranate','Granaatappel','Pomegranate',83,1.7,19,1.2,'fruit','core'),
('melon','Meloen','Melon',34,0.8,8,0.2,'fruit','core'),
('cherries','Kersen','Cherries',63,1,16,0.2,'fruit','core')
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
2. Serve with a spoon of quark, roughly chopped walnuts and a pinch of cinnamon.','assembly',null,'core'),
('wholegrain_wrap_with_scrambled_egg_mushroom_tomato','Volkoren wrap met roerei, champignon & tomaat','Wholegrain wrap with scrambled egg, mushroom & tomato',ARRAY['breakfast'],ARRAY['maintain'],'[{"slug":"egg","g":100},{"slug":"egg_white","g":60},{"slug":"mushroom","g":60},{"slug":"tomato","g":60},{"slug":"wrap_whole","g":60}]'::jsonb,ARRAY['sport','vegetarian']::text[],ARRAY[]::text[],'1. Klop het ei met het eiwit los.
2. Bak de champignons tot ze kleuren, giet het ei erbij en roer tot een zacht roerei.
3. Warm de wrap, beleg met het roerei en plakjes tomaat en rol op.','1. Whisk the egg with the egg white.
2. Fry the mushrooms until coloured, add the egg and stir to soft scrambled egg.
3. Warm the wrap, fill with the egg and tomato and roll up.','pan',null,'core'),
('soy_yoghurt_with_oats_banana_chia','Sojayoghurt met havermout, banaan & chiazaad','Soy yoghurt with oats, banana & chia',ARRAY['breakfast'],ARRAY['maintain'],'[{"slug":"soy_yoghurt","g":200},{"slug":"oats","g":45},{"slug":"banana","g":80},{"slug":"chia","g":10}]'::jsonb,ARRAY['sport','vegetarian','vegan']::text[],ARRAY[]::text[],'1. Meng de sojayoghurt met de havermout en het chiazaad.
2. Laat 10 min staan tot het indikt.
3. Top met schijfjes banaan.','1. Mix the soy yoghurt with the oats and chia.
2. Let stand 10 min to thicken.
3. Top with banana slices.','pan',null,'core'),
('wholegrain_bread_with_cottage_cheese_strawberry_honey','Volkorenbrood met hüttenkäse, aardbei & honing','Wholegrain bread with cottage cheese, strawberry & honey',ARRAY['breakfast'],ARRAY['maintain'],'[{"slug":"bread_whole","g":70},{"slug":"cottage","g":80},{"slug":"strawberry","g":60},{"slug":"honey","g":8}]'::jsonb,ARRAY['sport','vegetarian']::text[],ARRAY[]::text[],'1. Rooster het volkorenbrood en besmeer met de hüttenkäse.
2. Beleg met plakjes aardbei.
3. Druppel de honing erover.','1. Toast the wholegrain bread and spread with the cottage cheese.
2. Top with strawberry slices.
3. Drizzle the honey over.','assembly',null,'core'),
('omelette_with_smoked_salmon_spinach_tomato','Omelet met gerookte zalm, spinazie & tomaat','Omelette with smoked salmon, spinach & tomato',ARRAY['breakfast','lunch'],ARRAY['cut','maintain'],'[{"slug":"egg","g":100},{"slug":"egg_white","g":60},{"slug":"smoked_salmon","g":50},{"slug":"spinach","g":40},{"slug":"tomato","g":50}]'::jsonb,ARRAY['sport','high_protein']::text[],ARRAY[]::text[],'1. Klop het ei met het eiwit los en bak een omelet in een antiaanbakpan.
2. Beleg de ene helft met spinazie, tomaat en gerookte zalm.
3. Klap dicht en laat kort nagaren.','1. Whisk the egg with the egg white and cook an omelette in a non-stick pan.
2. Top one half with spinach, tomato and smoked salmon.
3. Fold over and cook briefly.','pan',null,'core'),
('quark_smoothie_with_mango_orange_oats','Kwark-smoothie met mango, sinaasappel & havermout','Quark smoothie with mango, orange & oats',ARRAY['breakfast'],ARRAY['cut','maintain'],'[{"slug":"quark_lowfat","g":200},{"slug":"mango","g":80},{"slug":"orange","g":100},{"slug":"oats","g":30}]'::jsonb,ARRAY['sport','high_protein','vegetarian']::text[],ARRAY[]::text[],'1. Doe de kwark, mango, het sinaasappelsap en de havermout in de blender.
2. Mix glad.
3. Schenk in een glas of kom.','1. Add the quark, mango, orange juice and oats to the blender.
2. Blend smooth.
3. Pour into a glass or bowl.','blender',null,'core'),
('oatmeal_with_oat_milk_pear_walnut','Havermout met havermelk, peer & walnoot','Oatmeal with oat milk, pear & walnut',ARRAY['breakfast'],ARRAY['maintain'],'[{"slug":"oats","g":70},{"slug":"oat_milk","g":250},{"slug":"pear","g":100},{"slug":"walnuts","g":10}]'::jsonb,ARRAY['sport','vegetarian','vegan']::text[],ARRAY[]::text[],'1. Breng de havermout met de havermelk al roerend aan de kook en gaar 3–4 min.
2. Roer er een snuf kaneel door.
3. Top met blokjes peer en grof gehakte walnoten.','1. Bring the oats and oat milk to a simmer, stirring, and cook 3–4 min.
2. Stir in a pinch of cinnamon.
3. Top with diced pear and roughly chopped walnuts.','pan',null,'core'),
('egg_muffins_with_vegetables_low_fat_cheese','Eiermuffins met groente & magere kaas','Egg muffins with vegetables & low-fat cheese',ARRAY['breakfast','snack'],ARRAY['cut','maintain'],'[{"slug":"egg","g":150},{"slug":"paprika","g":60},{"slug":"spinach","g":40},{"slug":"low_fat_cheese","g":30}]'::jsonb,ARRAY['sport','high_protein','vegetarian']::text[],ARRAY[]::text[],'1. Klop de eieren los met peper en zout.
2. Verdeel fijne paprika, spinazie en magere kaas over muffinvormpjes en giet het ei erbij.
3. Bak 18–20 min op 180°C tot gestold.','1. Whisk the eggs with salt and pepper.
2. Divide finely chopped pepper, spinach and low-fat cheese over muffin cups and pour the egg in.
3. Bake 18–20 min at 180°C until set.','oven',null,'core'),
('protein_pancake_with_blueberries','Proteïnepannenkoek met blauwe bessen','Protein pancake with blueberries',ARRAY['breakfast'],ARRAY['cut','maintain'],'[{"slug":"oats","g":50},{"slug":"egg","g":50},{"slug":"egg_white","g":60},{"slug":"whey","g":15},{"slug":"blueberries","g":60}]'::jsonb,ARRAY['sport','high_protein','vegetarian']::text[],ARRAY[]::text[],'1. Pureer de havermout, het ei, eiwit en de whey tot een glad beslag.
2. Bak er pannenkoekjes van in een antiaanbakpan.
3. Top met blauwe bessen.','1. Blend the oats, egg, egg white and whey into a smooth batter.
2. Cook pancakes in a non-stick pan.
3. Top with blueberries.','pan',null,'core'),
('wholegrain_toastie_with_low_fat_cheese_ham_tomato','Volkoren tosti met magere kaas, ham & tomaat','Wholegrain toastie with low-fat cheese, ham & tomato',ARRAY['breakfast','lunch'],ARRAY['maintain'],'[{"slug":"bread_whole","g":80},{"slug":"low_fat_cheese","g":30},{"slug":"ham_lean","g":40},{"slug":"tomato","g":50}]'::jsonb,ARRAY['sport']::text[],ARRAY[]::text[],'1. Beleg een snee volkorenbrood met magere kaas, ham en plakjes tomaat.
2. Leg de tweede snee erop.
3. Rooster in een tostiapparaat of koekenpan tot goudbruin.','1. Top a slice of wholegrain bread with low-fat cheese, ham and tomato.
2. Place the second slice on top.
3. Toast in a sandwich press or pan until golden.','pan',null,'core'),
('skyr_with_oats_grapes_almonds','Skyr met havermout, druiven & amandel','Skyr with oats, grapes & almonds',ARRAY['breakfast','snack'],ARRAY['cut','maintain'],'[{"slug":"skyr","g":200},{"slug":"oats","g":35},{"slug":"grapes","g":80},{"slug":"almonds","g":10}]'::jsonb,ARRAY['sport','high_protein','vegetarian']::text[],ARRAY[]::text[],'1. Meng de skyr met de havermout.
2. Top met gehalveerde druiven.
3. Strooi grof gehakte amandelen erover.','1. Mix the skyr with the oats.
2. Top with halved grapes.
3. Scatter roughly chopped almonds over.','pan',null,'core'),
('sushi_bowl_with_salmon_rice_cucumber_edamame','Sushi-bowl met zalm, rijst, komkommer & edamame','Sushi bowl with salmon, rice, cucumber & edamame',ARRAY['lunch','dinner'],ARRAY['gain','maintain'],'[{"slug":"salmon","g":120},{"slug":"rice_dry","g":65},{"slug":"cucumber","g":60},{"slug":"edamame","g":60},{"slug":"soy_sauce","g":10}]'::jsonb,ARRAY['sport']::text[],ARRAY[]::text[],'1. Kook de rijst en breng op smaak met een scheut rijstazijn.
2. Snijd de zalm in blokjes (sushikwaliteit) of gaar ''m kort.
3. Schik rijst, zalm, komkommer en edamame in een kom; besprenkel met sojasaus en sesam.','1. Cook the rice and season with a splash of rice vinegar.
2. Cube the salmon (sushi-grade) or sear it briefly.
3. Arrange rice, salmon, cucumber and edamame in a bowl; drizzle with soy sauce and sesame.','pan',null,'core'),
('spanish_potato_tortilla_with_salad','Spaanse aardappel-tortilla met salade','Spanish potato tortilla with salad',ARRAY['lunch'],ARRAY['maintain'],'[{"slug":"egg","g":150},{"slug":"potato","g":150},{"slug":"onion","g":50},{"slug":"lettuce","g":60},{"slug":"olive_oil","g":6}]'::jsonb,ARRAY['sport','vegetarian']::text[],ARRAY[]::text[],'1. Bak dunne plakjes aardappel en ui zacht in de olijfolie.
2. Klop de eieren los, giet erbij en gaar de tortilla op laag vuur rondom.
3. Serveer met een frisse salade.','1. Soften thin potato slices and onion in the olive oil.
2. Whisk the eggs, pour in and cook the tortilla through on low heat.
3. Serve with a fresh salad.','pan',null,'core'),
('greek_salad_with_feta_olives_wholegrain_pita','Griekse salade met feta, olijven & volkoren pita','Greek salad with feta, olives & wholegrain pita',ARRAY['lunch'],ARRAY['maintain'],'[{"slug":"feta_light","g":50},{"slug":"cucumber","g":100},{"slug":"tomato","g":120},{"slug":"red_onion","g":30},{"slug":"olives","g":20},{"slug":"pita_whole","g":60}]'::jsonb,ARRAY['sport','vegetarian']::text[],ARRAY[]::text[],'1. Snijd komkommer, tomaat en rode ui grof.
2. Meng met de olijven en blokjes feta.
3. Maak aan met citroen, oregano en peper; serveer met de warme pita.','1. Roughly chop cucumber, tomato and red onion.
2. Mix with the olives and cubed feta.
3. Dress with lemon, oregano and pepper; serve with the warm pita.','pan',null,'core'),
('quinoa_salad_with_butternut_feta_rocket','Quinoasalade met butternut, feta & rucola','Quinoa salad with butternut, feta & rocket',ARRAY['lunch'],ARRAY['maintain'],'[{"slug":"quinoa","g":60},{"slug":"butternut","g":150},{"slug":"feta_light","g":40},{"slug":"rocket","g":40},{"slug":"olive_oil","g":6}]'::jsonb,ARRAY['sport','vegetarian']::text[],ARRAY[]::text[],'1. Rooster de butternut-blokjes met de olijfolie 25 min op 200°C.
2. Kook de quinoa gaar en laat afkoelen.
3. Meng met de rucola en butternut, verkruimel de feta erover.','1. Roast the butternut cubes with the olive oil 25 min at 200°C.
2. Cook the quinoa and let cool.
3. Mix with the rocket and butternut, crumble the feta over.','oven',null,'core'),
('tuna_rice_salad_with_corn_pepper_spring_onion','Tonijn-rijstsalade met mais, paprika & bosui','Tuna rice salad with corn, pepper & spring onion',ARRAY['lunch'],ARRAY['maintain'],'[{"slug":"tuna_can","g":100},{"slug":"rice_dry","g":60},{"slug":"corn","g":70},{"slug":"paprika","g":70},{"slug":"spring_onion","g":15}]'::jsonb,ARRAY['sport']::text[],ARRAY[]::text[],'1. Kook de rijst en laat afkoelen.
2. Meng met de tonijn, mais, blokjes paprika en bosui.
3. Maak aan met citroen, peper en zout.','1. Cook the rice and let cool.
2. Mix with the tuna, corn, diced pepper and spring onion.
3. Dress with lemon, salt and pepper.','pan',null,'core'),
('whole_wheat_noodle_salad_with_chicken_bean_sprouts_lime','Volkoren noedelsalade met kip, taugé & limoen','Whole-wheat noodle salad with chicken, bean sprouts & lime',ARRAY['lunch'],ARRAY['cut','maintain'],'[{"slug":"noodles_whole","g":60},{"slug":"chicken_breast","g":130},{"slug":"bean_sprouts","g":60},{"slug":"carrot","g":50},{"slug":"soy_sauce","g":10}]'::jsonb,ARRAY['sport','high_protein']::text[],ARRAY[]::text[],'1. Kook de noedels beetgaar en spoel koud.
2. Gril de kipfilet en snijd in reepjes.
3. Meng de noedels met taugé, julienne wortel, de kip, sojasaus en limoen.','1. Cook the noodles al dente and rinse cold.
2. Grill the chicken and slice.
3. Toss the noodles with bean sprouts, julienned carrot, the chicken, soy sauce and lime.','pan',null,'core'),
('lentil_salad_with_smoked_chicken_beetroot_feta','Linzensalade met gerookte kip, biet & feta','Lentil salad with smoked chicken, beetroot & feta',ARRAY['lunch'],ARRAY['cut','maintain'],'[{"slug":"lentils","g":150},{"slug":"chicken_breast","g":100},{"slug":"beetroot","g":80},{"slug":"feta_light","g":30},{"slug":"rocket","g":30}]'::jsonb,ARRAY['sport','high_protein']::text[],ARRAY[]::text[],'1. Meng de gekookte linzen met blokjes rode biet en rucola.
2. Verdeel de gerookte kip erover.
3. Verkruimel de feta erover en maak aan met citroen en peper.','1. Mix the cooked lentils with diced beetroot and rocket.
2. Spread the smoked chicken over.
3. Crumble the feta over and dress with lemon and pepper.','pan',null,'core'),
('chickpea_salad_with_harissa_cucumber_mint','Kikkererwtensalade met harissa, komkommer & munt','Chickpea salad with harissa, cucumber & mint',ARRAY['lunch'],ARRAY['maintain'],'[{"slug":"chickpeas","g":180},{"slug":"cucumber","g":80},{"slug":"tomato","g":80},{"slug":"harissa","g":15},{"slug":"olive_oil","g":5}]'::jsonb,ARRAY['sport','vegetarian','vegan']::text[],ARRAY[]::text[],'1. Meng de kikkererwten met blokjes komkommer en tomaat.
2. Roer de harissa met de olijfolie en wat citroen tot een dressing.
3. Schep erdoor en werk af met verse munt.','1. Mix the chickpeas with diced cucumber and tomato.
2. Stir the harissa with the olive oil and some lemon into a dressing.
3. Toss through and finish with fresh mint.','pan',null,'core'),
('caprese_pasta_salad_with_light_mozzarella_tomato','Caprese-pastasalade met mozzarella light & tomaat','Caprese pasta salad with light mozzarella & tomato',ARRAY['lunch'],ARRAY['maintain'],'[{"slug":"pasta_whole","g":70},{"slug":"mozzarella_light","g":60},{"slug":"cherry_tomato","g":120},{"slug":"rocket","g":30},{"slug":"pesto","g":8}]'::jsonb,ARRAY['sport','vegetarian']::text[],ARRAY[]::text[],'1. Kook de volkoren pasta beetgaar en spoel koud.
2. Meng met gehalveerde cherrytomaten, blokjes mozzarella en rucola.
3. Roer de pesto erdoor en breng op smaak met peper.','1. Cook the wholegrain pasta al dente and rinse cold.
2. Mix with halved cherry tomatoes, cubed mozzarella and rocket.
3. Stir the pesto through and season with pepper.','pan',null,'core'),
('miso_soup_with_tofu_bean_sprouts_noodles','Misosoep met tofu, taugé & noedels','Miso soup with tofu, bean sprouts & noodles',ARRAY['lunch'],ARRAY['maintain'],'[{"slug":"miso","g":20},{"slug":"tofu","g":150},{"slug":"noodles_whole","g":50},{"slug":"bean_sprouts","g":60},{"slug":"spring_onion","g":15}]'::jsonb,ARRAY['sport','vegetarian','vegan']::text[],ARRAY[]::text[],'1. Kook de noedels beetgaar.
2. Roer de miso los in heet (niet kokend) water.
3. Voeg de tofublokjes, taugé en noedels toe, verwarm zacht en werk af met bosui.','1. Cook the noodles al dente.
2. Whisk the miso into hot (not boiling) water.
3. Add the tofu cubes, bean sprouts and noodles, warm gently and finish with spring onion.','soup',null,'core'),
('chicken_bowl_with_sweet_potato_sprouts_mustard_dressing','Kipfilet-bowl met zoete aardappel, spruitjes & mosterddressing','Chicken bowl with sweet potato, sprouts & mustard dressing',ARRAY['lunch','dinner'],ARRAY['cut','maintain'],'[{"slug":"chicken_breast","g":130},{"slug":"sweet_potato","g":180},{"slug":"brussels_sprouts","g":120},{"slug":"yoghurt_lowfat","g":40},{"slug":"mustard","g":5}]'::jsonb,ARRAY['sport','high_protein']::text[],ARRAY[]::text[],'1. Rooster de zoete aardappel en gehalveerde spruitjes 25 min op 200°C.
2. Gril de kipfilet gaar en snijd aan.
3. Roer een dressing van yoghurt, mosterd en citroen en schep over de bowl.','1. Roast the sweet potato and halved sprouts 25 min at 200°C.
2. Grill the chicken and slice.
3. Stir a dressing of yoghurt, mustard and lemon and spoon over the bowl.','oven',null,'core'),
('indian_chicken_tikka_with_rice_cucumber_yoghurt','Indiase kip-tikka met rijst & komkommer-yoghurt','Indian chicken tikka with rice & cucumber yoghurt',ARRAY['dinner'],ARRAY['cut','maintain'],'[{"slug":"chicken_breast","g":150},{"slug":"rice_dry","g":65},{"slug":"yoghurt_lowfat","g":60},{"slug":"cucumber","g":60},{"slug":"curry_paste","g":20}]'::jsonb,ARRAY['sport','high_protein']::text[],ARRAY[]::text[],'1. Marineer de kipblokjes in de helft van de yoghurt met de currypasta en gril ze gaar.
2. Kook de rijst gaar.
3. Rasp de komkommer door de rest van de yoghurt tot een frisse saus; serveer met de rijst.','1. Marinate the chicken cubes in half the yoghurt with the curry paste and grill until done.
2. Cook the rice.
3. Grate the cucumber into the rest of the yoghurt for a cooling sauce; serve with the rice.','pan',null,'core'),
('oven_salmon_with_butternut_sprouts','Zalm uit de oven met butternut & spruitjes','Oven salmon with butternut & sprouts',ARRAY['dinner'],ARRAY['maintain'],'[{"slug":"salmon","g":140},{"slug":"butternut","g":200},{"slug":"brussels_sprouts","g":120},{"slug":"olive_oil","g":5}]'::jsonb,ARRAY['sport']::text[],ARRAY[]::text[],'1. Rooster de butternut en gehalveerde spruitjes met de olijfolie 25 min op 200°C.
2. Leg de zalm de laatste 12 min erbij, met peper en citroen.
3. Serveer samen.','1. Roast the butternut and halved sprouts with the olive oil 25 min at 200°C.
2. Add the salmon for the final 12 min, with pepper and lemon.
3. Serve together.','oven',null,'core'),
('chicken_noodle_wok_with_bok_choy_bean_sprouts','Kip-noedelwok met paksoi & taugé','Chicken noodle wok with bok choy & bean sprouts',ARRAY['dinner'],ARRAY['cut','maintain'],'[{"slug":"chicken_breast","g":150},{"slug":"noodles_whole","g":70},{"slug":"bok_choy","g":120},{"slug":"bean_sprouts","g":60},{"slug":"soy_sauce","g":12}]'::jsonb,ARRAY['sport','high_protein']::text[],ARRAY[]::text[],'1. Kook de noedels beetgaar.
2. Roerbak de kipreepjes op hoog vuur, voeg paksoi en taugé toe.
3. Blus af met sojasaus en meng de noedels erdoor.','1. Cook the noodles al dente.
2. Stir-fry the chicken strips on high heat, add bok choy and bean sprouts.
3. Deglaze with soy sauce and toss the noodles through.','pan',null,'core'),
('spaghetti_with_shrimp_cherry_tomato_rocket','Spaghetti met garnalen, cherrytomaat & rucola','Spaghetti with shrimp, cherry tomato & rocket',ARRAY['dinner'],ARRAY['cut','maintain'],'[{"slug":"pasta_whole","g":75},{"slug":"shrimp","g":130},{"slug":"cherry_tomato","g":120},{"slug":"rocket","g":30},{"slug":"olive_oil","g":6}]'::jsonb,ARRAY['sport','high_protein']::text[],ARRAY[]::text[],'1. Kook de volkoren spaghetti beetgaar.
2. Bak de garnalen met knoflook in de olijfolie, voeg de cherrytomaten toe.
3. Meng de pasta en rucola erdoor en breng op smaak met peper en citroen.','1. Cook the wholegrain spaghetti al dente.
2. Fry the shrimp with garlic in the olive oil, add the cherry tomatoes.
3. Toss the pasta and rocket through and season with pepper and lemon.','pan',null,'core'),
('grilled_chicken_with_polenta_grilled_vegetables','Gegrilde kip met polenta & gegrilde groente','Grilled chicken with polenta & grilled vegetables',ARRAY['dinner'],ARRAY['cut','maintain'],'[{"slug":"chicken_breast","g":150},{"slug":"polenta","g":200},{"slug":"zucchini","g":100},{"slug":"paprika","g":80},{"slug":"olive_oil","g":6}]'::jsonb,ARRAY['sport','high_protein']::text[],ARRAY[]::text[],'1. Verwarm de polenta volgens de verpakking tot een zachte brij.
2. Gril de courgette en paprika in een grillpan.
3. Gril de kipfilet gaar, snijd aan en serveer op de polenta met de groente.','1. Warm the polenta per the pack into a soft mash.
2. Griddle the zucchini and pepper.
3. Grill the chicken, slice and serve on the polenta with the vegetables.','pan',null,'core'),
('moroccan_chicken_tagine_with_couscous_butternut','Marokkaanse kiptagine met couscous & butternut','Moroccan chicken tagine with couscous & butternut',ARRAY['dinner'],ARRAY['gain','maintain'],'[{"slug":"chicken_thigh","g":150},{"slug":"couscous","g":60},{"slug":"butternut","g":150},{"slug":"onion","g":40},{"slug":"chickpeas","g":60}]'::jsonb,ARRAY['sport']::text[],ARRAY[]::text[],'1. Stoof de kipdij met ui, butternut en kikkererwten aan; voeg ras el hanout en bouillon toe.
2. Laat 25 min zachtjes stoven tot alles gaar is.
3. Wel de couscous in het hete stoofvocht onder folie en serveer met de tagine.','1. Sweat the chicken thigh with onion, butternut and chickpeas; add ras el hanout and stock.
2. Simmer gently 25 min until tender.
3. Soak the couscous in the hot broth under foil and serve with the tagine.','soup',null,'core'),
('white_fish_with_fennel_potato_lemon','Witvis met venkel, aardappel & citroen','White fish with fennel, potato & lemon',ARRAY['dinner'],ARRAY['cut','maintain'],'[{"slug":"white_fish","g":160},{"slug":"potato","g":220},{"slug":"fennel","g":120},{"slug":"olive_oil","g":6}]'::jsonb,ARRAY['sport','high_protein']::text[],ARRAY[]::text[],'1. Snijd de venkel en aardappel, hussel met olijfolie en rooster 22 min op 200°C.
2. Leg de witvis de laatste 12 min erbij, met citroen en peper.
3. Serveer met wat venkelgroen.','1. Slice the fennel and potato, toss with olive oil and roast 22 min at 200°C.
2. Add the white fish for the final 12 min, with lemon and pepper.
3. Serve with some fennel fronds.','oven',null,'core'),
('light_moussaka_with_eggplant_beef_mince_potato','Moussaka light met aubergine, rundergehakt & aardappel','Light moussaka with eggplant, beef mince & potato',ARRAY['dinner'],ARRAY['cut','maintain'],'[{"slug":"beef_mince5","g":140},{"slug":"eggplant","g":150},{"slug":"potato","g":180},{"slug":"passata","g":120},{"slug":"onion","g":40}]'::jsonb,ARRAY['sport','high_protein']::text[],ARRAY[]::text[],'1. Gril plakken aubergine en kook plakken aardappel voor.
2. Rul het gehakt met ui en passata en breng op smaak met kaneel en oregano.
3. Laag aardappel, aubergine en gehakt in een ovenschaal en bak 25 min op 200°C.','1. Griddle eggplant slices and pre-cook potato slices.
2. Brown the mince with onion and passata and season with cinnamon and oregano.
3. Layer potato, eggplant and mince in a dish and bake 25 min at 200°C.','oven',null,'core'),
('teriyaki_salmon_with_noodles_bok_choy','Teriyaki-zalm met noedels & paksoi','Teriyaki salmon with noodles & bok choy',ARRAY['dinner'],ARRAY['gain','maintain'],'[{"slug":"salmon","g":140},{"slug":"noodles_whole","g":70},{"slug":"bok_choy","g":120},{"slug":"teriyaki","g":25}]'::jsonb,ARRAY['sport']::text[],ARRAY[]::text[],'1. Kook de noedels beetgaar.
2. Bak de zalm kort en lak met de teriyaki.
3. Roerbak de paksoi beetgaar, meng de noedels erdoor en serveer met de zalm.','1. Cook the noodles al dente.
2. Sear the salmon briefly and glaze with the teriyaki.
3. Stir-fry the bok choy, toss the noodles through and serve with the salmon.','pan',null,'core'),
('chicken_burrito_bowl_with_black_beans_rice_salsa','Kip-burrito bowl met zwarte bonen, rijst & salsa','Chicken burrito bowl with black beans, rice & salsa',ARRAY['dinner'],ARRAY['cut','gain','maintain'],'[{"slug":"chicken_breast","g":150},{"slug":"rice_dry","g":60},{"slug":"black_beans","g":100},{"slug":"corn","g":60},{"slug":"tomato","g":80}]'::jsonb,ARRAY['sport','high_protein']::text[],ARRAY[]::text[],'1. Kook de rijst gaar.
2. Bak de kip met komijn en paprikapoeder; verwarm de zwarte bonen en mais.
3. Maak een snelle salsa van tomaat, ui en limoen en schik alles over de rijst.','1. Cook the rice.
2. Fry the chicken with cumin and paprika; warm the black beans and corn.
3. Make a quick salsa of tomato, onion and lime and arrange over the rice.','pan',null,'core'),
('seitan_stroganoff_with_mushroom_brown_rice','Seitan-stroganoff met champignon & zilvervliesrijst','Seitan stroganoff with mushroom & brown rice',ARRAY['dinner'],ARRAY['cut','maintain'],'[{"slug":"seitan","g":150},{"slug":"brown_rice","g":65},{"slug":"mushroom","g":120},{"slug":"onion","g":40},{"slug":"soy_yoghurt","g":60}]'::jsonb,ARRAY['sport','high_protein','vegetarian','vegan']::text[],ARRAY[]::text[],'1. Kook de zilvervliesrijst gaar.
2. Bak de seitanreepjes met ui en champignons bruin.
3. Roer de sojayoghurt erdoor met mosterd en paprikapoeder; serveer over de rijst.','1. Cook the brown rice.
2. Fry the seitan strips with onion and mushrooms until browned.
3. Stir the soy yoghurt through with mustard and paprika; serve over the rice.','pan',null,'core'),
('thai_red_curry_with_chicken_pepper_rice','Thaise rode curry met kip, paprika & rijst','Thai red curry with chicken, pepper & rice',ARRAY['dinner'],ARRAY['cut','maintain'],'[{"slug":"chicken_breast","g":150},{"slug":"rice_dry","g":65},{"slug":"coconut_light","g":80},{"slug":"paprika","g":100},{"slug":"curry_paste","g":20}]'::jsonb,ARRAY['sport','high_protein']::text[],ARRAY[]::text[],'1. Kook de rijst gaar.
2. Bak de rode currypasta kort, voeg de kip en paprika toe.
3. Blus met kokosmelk, laat 8 min pruttelen en werk af met basilicum; serveer over de rijst.','1. Cook the rice.
2. Fry the red curry paste briefly, add the chicken and pepper.
3. Add coconut milk, simmer 8 min and finish with basil; serve over the rice.','pan',null,'core'),
('stuffed_sweet_potato_with_chicken_mince_vegetables','Gevulde zoete aardappel met kipgehakt & groente','Stuffed sweet potato with chicken mince & vegetables',ARRAY['dinner'],ARRAY['maintain'],'[{"slug":"sweet_potato","g":250},{"slug":"chicken_mince","g":120},{"slug":"paprika","g":60},{"slug":"corn","g":50},{"slug":"onion","g":30}]'::jsonb,ARRAY['sport']::text[],ARRAY[]::text[],'1. Bak de zoete aardappel 45 min heel in de oven op 200°C tot zacht.
2. Rul het kipgehakt met ui, paprika en mais en breng op smaak.
3. Snijd de zoete aardappel open en vul met het gehaktmengsel.','1. Bake the whole sweet potato 45 min at 200°C until soft.
2. Brown the chicken mince with onion, pepper and corn and season.
3. Split the sweet potato open and fill with the mince mixture.','oven',null,'core'),
('sous_vide_steak_54_c_with_sweet_potato_asparagus','Biefstuk sous-vide 54°C met zoete aardappel & asperges','Sous-vide steak 54°C with sweet potato & asparagus',ARRAY['dinner'],ARRAY['cut','maintain'],'[{"slug":"beef_lean","g":150},{"slug":"sweet_potato","g":200},{"slug":"asparagus","g":120},{"slug":"olive_oil","g":5}]'::jsonb,ARRAY['sport','high_protein','sousvide']::text[],ARRAY[]::text[],'1. Vacumeer de biefstuk en gaar sous-vide op 54°C (1,5–4 u) voor medium-rare.
2. Rooster de zoete aardappel en stoom de asperges beetgaar.
3. Schroei de biefstuk kort rondom, laat 2 min rusten en snijd aan.','1. Vacuum-seal the steak and cook sous-vide at 54°C (1.5–4 h) for medium-rare.
2. Roast the sweet potato and steam the asparagus.
3. Sear the steak all over, rest 2 min and slice.','sousvide','54°C','core'),
('cod_in_tomato_fennel_sauce_with_potato','Kabeljauw in tomaten-venkelsaus met aardappel','Cod in tomato-fennel sauce with potato',ARRAY['dinner'],ARRAY['cut','maintain'],'[{"slug":"cod","g":160},{"slug":"potato","g":220},{"slug":"fennel","g":100},{"slug":"passata","g":120},{"slug":"onion","g":40}]'::jsonb,ARRAY['sport','high_protein']::text[],ARRAY[]::text[],'1. Kook de aardappels gaar.
2. Stoof de venkel en ui zacht, voeg de passata toe en laat 8 min pruttelen.
3. Leg de kabeljauw in de saus en pocheer 6–8 min tot gaar; serveer met de aardappel.','1. Boil the potatoes.
2. Soften the fennel and onion, add the passata and simmer 8 min.
3. Lay the cod in the sauce and poach 6–8 min until done; serve with the potato.','pan',null,'core'),
('vegetarian_chili_with_quinoa_black_beans_corn','Vegetarische chili met quinoa, zwarte bonen & mais','Vegetarian chili with quinoa, black beans & corn',ARRAY['dinner'],ARRAY['gain','maintain'],'[{"slug":"quinoa","g":60},{"slug":"black_beans","g":150},{"slug":"corn","g":80},{"slug":"passata","g":150},{"slug":"paprika","g":80}]'::jsonb,ARRAY['sport','vegetarian','vegan']::text[],ARRAY[]::text[],'1. Kook de quinoa gaar.
2. Stoof de paprika, voeg passata, zwarte bonen en mais toe met komijn en chili.
3. Laat 10 min pruttelen en serveer over de quinoa.','1. Cook the quinoa.
2. Soften the pepper, add passata, black beans and corn with cumin and chili.
3. Simmer 10 min and serve over the quinoa.','pan',null,'core'),
('chicken_thigh_traybake_with_potato_pepper_onion','Kipdij-traybake met aardappel, paprika & ui','Chicken thigh traybake with potato, pepper & onion',ARRAY['dinner'],ARRAY['maintain'],'[{"slug":"chicken_thigh","g":150},{"slug":"potato","g":220},{"slug":"paprika","g":100},{"slug":"onion","g":50},{"slug":"olive_oil","g":6}]'::jsonb,ARRAY['sport']::text[],ARRAY[]::text[],'1. Snijd de aardappel, paprika en ui en hussel met de olijfolie en kruiden.
2. Leg de kipdij erbovenop in een ovenschaal.
3. Bak 30–35 min op 200°C tot alles gaar en goudbruin is.','1. Cut the potato, pepper and onion and toss with the olive oil and herbs.
2. Place the chicken thigh on top in an oven dish.
3. Bake 30–35 min at 200°C until everything is done and golden.','oven',null,'core'),
('greek_yoghurt_with_pineapple_pumpkin_seeds','Griekse yoghurt met ananas & pompoenpitten','Greek yoghurt with pineapple & pumpkin seeds',ARRAY['snack'],ARRAY['cut','maintain'],'[{"slug":"greek_yoghurt","g":150},{"slug":"pineapple","g":70},{"slug":"pumpkin_seeds","g":10}]'::jsonb,ARRAY['sport','high_protein','vegetarian']::text[],ARRAY[]::text[],'1. Schep de Griekse yoghurt in een kom.
2. Top met blokjes ananas.
3. Strooi de pompoenpitten erover.','1. Spoon the Greek yoghurt into a bowl.
2. Top with diced pineapple.
3. Scatter the pumpkin seeds over.','assembly',null,'core'),
('wholegrain_crackers_with_hummus_cucumber','Volkoren crackers met hummus & komkommer','Wholegrain crackers with hummus & cucumber',ARRAY['snack'],ARRAY['maintain'],'[{"slug":"crackers_whole","g":24},{"slug":"hummus_light","g":40},{"slug":"cucumber","g":50}]'::jsonb,ARRAY['sport','vegetarian','vegan']::text[],ARRAY[]::text[],'1. Besmeer de crackers met de hummus.
2. Beleg met dunne plakjes komkommer.','1. Spread the crackers with the hummus.
2. Top with thin cucumber slices.','assembly',null,'core'),
('quark_with_strawberry_almonds','Kwark met aardbei & amandel','Quark with strawberry & almonds',ARRAY['snack'],ARRAY['cut','maintain'],'[{"slug":"quark_lowfat","g":150},{"slug":"strawberry","g":70},{"slug":"almonds","g":10}]'::jsonb,ARRAY['sport','high_protein','vegetarian']::text[],ARRAY[]::text[],'1. Schep de kwark in een kom.
2. Top met plakjes aardbei en grof gehakte amandelen.','1. Spoon the quark into a bowl.
2. Top with sliced strawberry and roughly chopped almonds.','assembly',null,'core'),
('edamame_with_soy_sesame','Edamame met sojasaus & sesam','Edamame with soy & sesame',ARRAY['snack'],ARRAY['cut','maintain'],'[{"slug":"edamame","g":150},{"slug":"soy_sauce","g":8},{"slug":"sesame","g":5}]'::jsonb,ARRAY['sport','high_protein','vegetarian','vegan']::text[],ARRAY[]::text[],'1. Kook of stoom de edamame 4–5 min.
2. Besprenkel met sojasaus en bestrooi met sesamzaad.','1. Boil or steam the edamame 4–5 min.
2. Drizzle with soy sauce and sprinkle with sesame seeds.','pan',null,'core'),
('grapes_with_low_fat_cheese','Druiven met magere kaas','Grapes with low-fat cheese',ARRAY['snack'],ARRAY['maintain'],'[{"slug":"grapes","g":120},{"slug":"low_fat_cheese","g":40}]'::jsonb,ARRAY['sport','vegetarian']::text[],ARRAY[]::text[],'1. Snijd de magere kaas in blokjes.
2. Serveer met de druiven als frisse snack.','1. Cut the low-fat cheese into cubes.
2. Serve with the grapes as a fresh snack.','assembly',null,'core'),
('rice_cakes_with_cottage_cheese_tomato','Rijstwafels met hüttenkäse & tomaat','Rice cakes with cottage cheese & tomato',ARRAY['snack'],ARRAY['maintain'],'[{"slug":"rice_cakes","g":26},{"slug":"cottage","g":80},{"slug":"cherry_tomato","g":50}]'::jsonb,ARRAY['sport','vegetarian']::text[],ARRAY[]::text[],'1. Besmeer de rijstwafels met de hüttenkäse.
2. Beleg met gehalveerde cherrytomaat en wat peper.','1. Spread the rice cakes with the cottage cheese.
2. Top with halved cherry tomato and some pepper.','assembly',null,'core'),
('skyr_with_oats_apple_cinnamon','Skyr met havermout, appel & kaneel','Skyr with oats, apple & cinnamon',ARRAY['snack'],ARRAY['cut','maintain'],'[{"slug":"skyr","g":150},{"slug":"oats","g":25},{"slug":"apple","g":80}]'::jsonb,ARRAY['sport','high_protein','vegetarian']::text[],ARRAY[]::text[],'1. Meng de skyr met de havermout.
2. Top met blokjes appel en een snuf kaneel.','1. Mix the skyr with the oats.
2. Top with diced apple and a pinch of cinnamon.','assembly',null,'core'),
('french_herb_omelette_with_low_fat_cheese','Franse kruidenomelet met magere kaas','French herb omelette with low-fat cheese',ARRAY['breakfast'],ARRAY['cut','maintain'],'[{"slug":"egg","g":120},{"slug":"egg_white","g":60},{"slug":"low_fat_cheese","g":30}]'::jsonb,ARRAY['sport','high_protein','vegetarian']::text[],ARRAY[]::text[],'1. Klop het ei met het eiwit los en voeg fijngehakte bieslook en peterselie toe.
2. Giet in een hete antiaanbakpan met wat spray en roer de eerste seconden.
3. Strooi de magere kaas erover, vouw de omelet dubbel en serveer romig van binnen.','1. Whisk the egg with the egg white and add chopped chives and parsley.
2. Pour into a hot non-stick pan and stir the first few seconds.
3. Scatter the low-fat cheese over, fold the omelette and serve creamy inside.','pan',null,'core'),
('wholegrain_toast_with_avocado_egg_chili_flakes','Volkorenbrood met avocado, ei & chilivlokken','Wholegrain toast with avocado, egg & chili flakes',ARRAY['breakfast','lunch'],ARRAY['maintain'],'[{"slug":"bread_whole","g":80},{"slug":"avocado","g":50},{"slug":"egg","g":55},{"slug":"tomato","g":40}]'::jsonb,ARRAY['sport','vegetarian']::text[],ARRAY[]::text[],'1. Rooster het volkorenbrood.
2. Prak de avocado met citroen, peper en zout en verdeel over het brood.
3. Leg een gebakken of gepocheerd ei erop en werk af met tomaat en chilivlokken.','1. Toast the wholegrain bread.
2. Mash the avocado with lemon, salt and pepper and spread on the toast.
3. Top with a fried or poached egg and finish with tomato and chili flakes.','pan',null,'core'),
('chia_pudding_with_quark_mango','Chiapudding met kwark & mango','Chia pudding with quark & mango',ARRAY['breakfast'],ARRAY['maintain'],'[{"slug":"chia","g":20},{"slug":"milk_semi","g":150},{"slug":"quark_lowfat","g":100},{"slug":"mango","g":80}]'::jsonb,ARRAY['sport','vegetarian']::text[],ARRAY[]::text[],'1. Meng het chiazaad met de melk en laat minimaal een nacht opstijven tot pudding.
2. Roer de kwark erdoor voor extra eiwit.
3. Top met blokjes mango.','1. Mix the chia with the milk and let set overnight into a pudding.
2. Stir the quark through for extra protein.
3. Top with diced mango.','assembly',null,'core'),
('breakfast_burrito_with_egg_beans_salsa','Breakfast burrito met ei, bonen & salsa','Breakfast burrito with egg, beans & salsa',ARRAY['breakfast','lunch'],ARRAY['maintain'],'[{"slug":"wrap_whole","g":60},{"slug":"egg","g":100},{"slug":"black_beans","g":80},{"slug":"tomato","g":60},{"slug":"paprika","g":40}]'::jsonb,ARRAY['sport','vegetarian']::text[],ARRAY[]::text[],'1. Roer een zacht roerei van de eieren.
2. Verwarm de zwarte bonen met komijn; maak een snelle salsa van tomaat, paprika en limoen.
3. Vul de wrap met het roerei, de bonen en salsa en rol strak op.','1. Make a soft scrambled egg.
2. Warm the black beans with cumin; make a quick salsa of tomato, pepper and lime.
3. Fill the wrap with the egg, beans and salsa and roll up tightly.','pan',null,'core'),
('wholegrain_protein_waffles_with_quark_blueberry','Volkoren proteïnewafels met kwark & bosbes','Wholegrain protein waffles with quark & blueberry',ARRAY['breakfast'],ARRAY['cut','maintain'],'[{"slug":"oats","g":50},{"slug":"egg","g":50},{"slug":"egg_white","g":60},{"slug":"whey","g":15},{"slug":"quark_lowfat","g":80},{"slug":"blueberries","g":60}]'::jsonb,ARRAY['sport','high_protein','vegetarian']::text[],ARRAY[]::text[],'1. Pureer de havermout, het ei, eiwit en de whey tot een glad beslag.
2. Bak in een wafelijzer goudbruin en knapperig.
3. Serveer met een lepel kwark en blauwe bessen.','1. Blend the oats, egg, egg white and whey into a smooth batter.
2. Cook in a waffle iron until golden and crisp.
3. Serve with a spoon of quark and blueberries.','pan',null,'core'),
('spinach_feta_omelette','Spinazie-feta omelet','Spinach-feta omelette',ARRAY['breakfast','lunch'],ARRAY['cut','maintain'],'[{"slug":"egg","g":100},{"slug":"egg_white","g":60},{"slug":"spinach","g":60},{"slug":"feta_light","g":30}]'::jsonb,ARRAY['sport','high_protein','vegetarian']::text[],ARRAY[]::text[],'1. Slink de spinazie kort in een antiaanbakpan.
2. Klop het ei met het eiwit los, giet erbij en laat op laag vuur stollen.
3. Verkruimel de feta erover en vouw de omelet dubbel.','1. Wilt the spinach briefly in a non-stick pan.
2. Whisk the egg with the egg white, pour in and set on low heat.
3. Crumble the feta over and fold the omelette.','pan',null,'core'),
('green_smoothie_with_spinach_banana_mango_protein','Groene smoothie met spinazie, banaan, mango & eiwit','Green smoothie with spinach, banana, mango & protein',ARRAY['breakfast','snack'],ARRAY['cut','maintain'],'[{"slug":"spinach","g":40},{"slug":"banana","g":100},{"slug":"mango","g":80},{"slug":"whey","g":25},{"slug":"milk_semi","g":150}]'::jsonb,ARRAY['sport','high_protein','vegetarian']::text[],ARRAY[]::text[],'1. Doe de spinazie, banaan, mango, whey en melk in de blender.
2. Mix glad.
3. Schenk in een glas of kom.','1. Add the spinach, banana, mango, whey and milk to the blender.
2. Blend smooth.
3. Pour into a glass or bowl.','blender',null,'core'),
('wholegrain_bread_with_cottage_cheese_cucumber_radish','Volkorenbrood met hüttenkäse, komkommer & radijs','Wholegrain bread with cottage cheese, cucumber & radish',ARRAY['breakfast','lunch'],ARRAY['maintain'],'[{"slug":"bread_whole","g":80},{"slug":"cottage","g":80},{"slug":"cucumber","g":40},{"slug":"radish","g":30}]'::jsonb,ARRAY['sport','vegetarian']::text[],ARRAY[]::text[],'1. Rooster het volkorenbrood en besmeer met de hüttenkäse.
2. Beleg met dunne plakjes komkommer en radijs.
3. Werk af met bieslook en peper.','1. Toast the wholegrain bread and spread with the cottage cheese.
2. Top with thin slices of cucumber and radish.
3. Finish with chives and pepper.','assembly',null,'core'),
('vietnamese_bun_bowl_with_chicken_rice_noodles','Vietnamese bun-bowl met kip & rijstnoedels','Vietnamese bun bowl with chicken & rice noodles',ARRAY['lunch','dinner'],ARRAY['cut','maintain'],'[{"slug":"chicken_breast","g":140},{"slug":"rice_noodles","g":55},{"slug":"carrot","g":60},{"slug":"cucumber","g":60},{"slug":"bean_sprouts","g":50}]'::jsonb,ARRAY['sport','high_protein']::text[],ARRAY[]::text[],'1. Week de rijstnoedels gaar en spoel koud.
2. Gril de gemarineerde kip en snijd in reepjes.
3. Schik de noedels met julienne wortel, komkommer en taugé; leg de kip erop en werk af met verse munt, koriander en een limoendressing.','1. Soak the rice noodles and rinse cold.
2. Grill the marinated chicken and slice.
3. Arrange the noodles with julienned carrot, cucumber and bean sprouts; top with the chicken and finish with mint, coriander and a lime dressing.','pan',null,'core'),
('korean_bibimbap_with_beef_rice_vegetables_egg','Koreaanse bibimbap met rund, rijst, groente & ei','Korean bibimbap with beef, rice, vegetables & egg',ARRAY['lunch','dinner'],ARRAY['gain','maintain'],'[{"slug":"beef_lean","g":120},{"slug":"rice_dry","g":65},{"slug":"spinach","g":60},{"slug":"carrot","g":50},{"slug":"egg","g":55},{"slug":"gochujang","g":20}]'::jsonb,ARRAY['sport']::text[],ARRAY[]::text[],'1. Kook de rijst gaar.
2. Bak het rundvlees kort op hoog vuur; blancheer de spinazie en wortel apart.
3. Schik alles in een kom over de rijst, leg een gebakken ei erop en serveer met de gochujang.','1. Cook the rice.
2. Sear the beef briefly on high heat; blanch the spinach and carrot separately.
3. Arrange everything in a bowl over the rice, top with a fried egg and serve with the gochujang.','pan',null,'core'),
('lebanese_tabbouleh_with_bulgur_parsley_chickpeas','Libanese tabouleh met bulgur, peterselie & kikkererwt','Lebanese tabbouleh with bulgur, parsley & chickpeas',ARRAY['lunch'],ARRAY['maintain'],'[{"slug":"bulgur","g":50},{"slug":"chickpeas","g":120},{"slug":"tomato","g":100},{"slug":"cucumber","g":60},{"slug":"olive_oil","g":6}]'::jsonb,ARRAY['sport','vegetarian','vegan']::text[],ARRAY[]::text[],'1. Wel de bulgur gaar en laat afkoelen.
2. Hak veel verse peterselie en munt fijn en meng met de bulgur, tomaat, komkommer en kikkererwten.
3. Maak aan met citroen, olijfolie, peper en zout.','1. Soak the bulgur and let cool.
2. Finely chop plenty of fresh parsley and mint and mix with the bulgur, tomato, cucumber and chickpeas.
3. Dress with lemon, olive oil, salt and pepper.','pan',null,'core'),
('turkish_lentil_soup_with_wholegrain_bread','Turkse linzensoep met volkorenbrood','Turkish lentil soup with wholegrain bread',ARRAY['lunch'],ARRAY['maintain'],'[{"slug":"lentils","g":150},{"slug":"carrot","g":80},{"slug":"onion","g":50},{"slug":"potato","g":80},{"slug":"bread_whole","g":60}]'::jsonb,ARRAY['sport','vegetarian','vegan']::text[],ARRAY[]::text[],'1. Fruit de ui, wortel en aardappel kort aan met komijn en paprikapoeder.
2. Voeg de linzen en bouillon toe en laat 20 min garen.
3. Pureer glad, breng op smaak met citroen en serveer met het brood.','1. Sweat the onion, carrot and potato with cumin and paprika.
2. Add the lentils and stock and simmer 20 min.
3. Blend smooth, season with lemon and serve with the bread.','soup',null,'core'),
('poke_with_tofu_edamame_mango','Poké met tofu, edamame & mango','Poké with tofu, edamame & mango',ARRAY['lunch','dinner'],ARRAY['maintain'],'[{"slug":"tofu","g":160},{"slug":"rice_dry","g":65},{"slug":"edamame","g":60},{"slug":"mango","g":70},{"slug":"soy_sauce","g":10}]'::jsonb,ARRAY['sport','vegetarian','vegan']::text[],ARRAY[]::text[],'1. Kook de rijst en laat iets afkoelen.
2. Marineer de tofublokjes in sojasaus en bak ze goudbruin.
3. Schik rijst, tofu, edamame en mango in een kom en besprenkel met sesam en limoen.','1. Cook the rice and let cool slightly.
2. Marinate the tofu cubes in soy sauce and fry until golden.
3. Arrange rice, tofu, edamame and mango in a bowl and drizzle with sesame and lime.','pan',null,'core'),
('chicken_club_on_wholegrain_bread_with_egg_tomato','Kip-clubsandwich op volkorenbrood met ei & tomaat','Chicken club on wholegrain bread with egg & tomato',ARRAY['lunch'],ARRAY['cut','maintain'],'[{"slug":"bread_whole","g":90},{"slug":"chicken_breast","g":100},{"slug":"egg","g":55},{"slug":"tomato","g":50},{"slug":"lettuce","g":20}]'::jsonb,ARRAY['sport','high_protein']::text[],ARRAY[]::text[],'1. Gril de kipfilet en snijd in plakjes; kook het ei en snijd in plakjes.
2. Rooster het volkorenbrood.
3. Stapel met sla, kip, ei en tomaat en een lik mosterd-yoghurt; snijd in driehoeken.','1. Grill the chicken and slice; boil the egg and slice.
2. Toast the wholegrain bread.
3. Stack with lettuce, chicken, egg and tomato and a dab of mustard-yoghurt; cut into triangles.','pan',null,'core'),
('white_bean_salad_with_tuna_red_onion_parsley','Witte bonensalade met tonijn, rode ui & peterselie','White bean salad with tuna, red onion & parsley',ARRAY['lunch'],ARRAY['cut','maintain'],'[{"slug":"white_beans","g":150},{"slug":"tuna_can","g":100},{"slug":"red_onion","g":30},{"slug":"tomato","g":80},{"slug":"olive_oil","g":5}]'::jsonb,ARRAY['sport','high_protein']::text[],ARRAY[]::text[],'1. Meng de witte bonen met de uitgelekte tonijn.
2. Voeg fijne rode ui, tomaat en veel peterselie toe.
3. Maak aan met citroen, olijfolie, peper en zout.','1. Mix the white beans with the drained tuna.
2. Add finely chopped red onion, tomato and plenty of parsley.
3. Dress with lemon, olive oil, salt and pepper.','pan',null,'core'),
('roasted_vegetable_wrap_with_hummus_feta','Geroosterde-groentewrap met hummus & feta','Roasted vegetable wrap with hummus & feta',ARRAY['lunch'],ARRAY['maintain'],'[{"slug":"wrap_whole","g":60},{"slug":"eggplant","g":80},{"slug":"paprika","g":80},{"slug":"hummus_light","g":30},{"slug":"feta_light","g":30}]'::jsonb,ARRAY['sport','vegetarian']::text[],ARRAY[]::text[],'1. Rooster de aubergine en paprika 20 min op 200°C.
2. Besmeer de wrap met hummus.
3. Beleg met de geroosterde groente en verkruimelde feta en rol strak op.','1. Roast the eggplant and pepper 20 min at 200°C.
2. Spread the wrap with hummus.
3. Top with the roasted vegetables and crumbled feta and roll up tightly.','oven',null,'core'),
('rice_salad_with_salmon_edamame_avocado','Rijstsalade met zalm, edamame & avocado','Rice salad with salmon, edamame & avocado',ARRAY['lunch','dinner'],ARRAY['gain','maintain'],'[{"slug":"salmon","g":120},{"slug":"rice_dry","g":60},{"slug":"edamame","g":60},{"slug":"avocado","g":40},{"slug":"cucumber","g":50}]'::jsonb,ARRAY['sport']::text[],ARRAY[]::text[],'1. Kook de rijst en laat afkoelen.
2. Gaar de zalm kort en pluk in stukken.
3. Meng de rijst met edamame, komkommer en avocado, leg de zalm erop en besprenkel met sojasaus en limoen.','1. Cook the rice and let cool.
2. Cook the salmon briefly and flake.
3. Mix the rice with edamame, cucumber and avocado, top with the salmon and drizzle with soy sauce and lime.','pan',null,'core'),
('asian_chicken_soup_with_noodles_bok_choy','Aziatische kippensoep met noedels & paksoi','Asian chicken soup with noodles & bok choy',ARRAY['lunch'],ARRAY['cut','maintain'],'[{"slug":"chicken_breast","g":120},{"slug":"noodles_whole","g":55},{"slug":"bok_choy","g":100},{"slug":"carrot","g":50},{"slug":"soy_sauce","g":10}]'::jsonb,ARRAY['sport','high_protein']::text[],ARRAY[]::text[],'1. Trek een heldere bouillon met gember en knoflook.
2. Gaar de kipreepjes, noedels, paksoi en wortel kort in de bouillon.
3. Breng op smaak met sojasaus en werk af met bosui.','1. Make a clear broth with ginger and garlic.
2. Cook the chicken strips, noodles, bok choy and carrot briefly in the broth.
3. Season with soy sauce and finish with spring onion.','soup',null,'core'),
('quinoa_tabbouleh_with_feta_mint','Quinoa-tabouleh met feta & munt','Quinoa tabbouleh with feta & mint',ARRAY['lunch'],ARRAY['maintain'],'[{"slug":"quinoa","g":60},{"slug":"tomato","g":100},{"slug":"cucumber","g":60},{"slug":"feta_light","g":40},{"slug":"olive_oil","g":6}]'::jsonb,ARRAY['sport','vegetarian']::text[],ARRAY[]::text[],'1. Kook de quinoa gaar en laat afkoelen.
2. Meng met blokjes tomaat, komkommer en veel verse munt en peterselie.
3. Verkruimel de feta erover en maak aan met citroen en olijfolie.','1. Cook the quinoa and let cool.
2. Mix with diced tomato, cucumber and plenty of fresh mint and parsley.
3. Crumble the feta over and dress with lemon and olive oil.','pan',null,'core'),
('wrap_with_turkey_hummus_rocket','Wrap met kalkoen, hummus & rucola','Wrap with turkey, hummus & rocket',ARRAY['lunch'],ARRAY['cut','maintain'],'[{"slug":"wrap_whole","g":60},{"slug":"turkey_breast","g":120},{"slug":"hummus_light","g":30},{"slug":"rocket","g":30},{"slug":"tomato","g":50}]'::jsonb,ARRAY['sport','high_protein']::text[],ARRAY[]::text[],'1. Besmeer de wrap met de hummus.
2. Beleg met plakjes kalkoenfilet, rucola en tomaat.
3. Rol strak op en snijd doormidden.','1. Spread the wrap with the hummus.
2. Top with turkey slices, rocket and tomato.
3. Roll up tightly and halve.','pan',null,'core'),
('light_mushroom_risotto_with_chicken','Champignonrisotto light met kipfilet','Light mushroom risotto with chicken',ARRAY['dinner'],ARRAY['cut','maintain'],'[{"slug":"chicken_breast","g":140},{"slug":"rice_dry","g":70},{"slug":"mushroom","g":120},{"slug":"onion","g":40},{"slug":"low_fat_cheese","g":20}]'::jsonb,ARRAY['sport','high_protein']::text[],ARRAY[]::text[],'1. Fruit de ui, voeg de rijst toe en blus beetje bij beetje af met warme bouillon tot romig gaar.
2. Bak de champignons apart en roer ze er met de gegrilde kip doorheen.
3. Werk af met wat magere kaas en peterselie.','1. Sweat the onion, add the rice and ladle in warm stock bit by bit until creamy.
2. Fry the mushrooms separately and stir them through with the grilled chicken.
3. Finish with a little low-fat cheese and parsley.','pan',null,'core'),
('tuna_steak_with_soy_glaze_rice_bok_choy','Tonijnsteak met sojaglaze, rijst & bok choy','Tuna steak with soy glaze, rice & bok choy',ARRAY['dinner'],ARRAY['cut','maintain'],'[{"slug":"tuna_steak","g":150},{"slug":"rice_dry","g":65},{"slug":"bok_choy","g":120},{"slug":"soy_sauce","g":12},{"slug":"sesame","g":5}]'::jsonb,ARRAY['sport','high_protein']::text[],ARRAY[]::text[],'1. Kook de rijst gaar.
2. Schroei de tonijnsteak 1 min per kant (rosé van binnen) en lak met sojasaus.
3. Roerbak de paksoi beetgaar; serveer de tonijn aangesneden met sesam.','1. Cook the rice.
2. Sear the tuna steak 1 min per side (pink inside) and glaze with soy sauce.
3. Stir-fry the bok choy; serve the sliced tuna with sesame.','pan',null,'core'),
('chicken_shawarma_bowl_with_rice_salad_garlic_sauce','Kipshoarmabowl met rijst, salade & knoflooksaus','Chicken shawarma bowl with rice, salad & garlic sauce',ARRAY['dinner'],ARRAY['cut','maintain'],'[{"slug":"chicken_breast","g":150},{"slug":"rice_dry","g":65},{"slug":"tomato","g":60},{"slug":"cucumber","g":60},{"slug":"yoghurt_lowfat","g":50}]'::jsonb,ARRAY['sport','high_protein']::text[],ARRAY[]::text[],'1. Kook de rijst gaar.
2. Kruid de kipreepjes met shoarmakruiden en bak ze gaar.
3. Roer een knoflooksaus van yoghurt en citroen; schik rijst, kip en frisse salade en lepel de saus erover.','1. Cook the rice.
2. Season the chicken strips with shawarma spice and cook.
3. Stir a garlic sauce from yoghurt and lemon; arrange rice, chicken and fresh salad and spoon the sauce over.','pan',null,'core'),
('oven_bake_with_chicken_sweet_potato_broccoli','Ovenschotel met kip, zoete aardappel & broccoli','Oven bake with chicken, sweet potato & broccoli',ARRAY['dinner'],ARRAY['cut','maintain'],'[{"slug":"chicken_breast","g":150},{"slug":"sweet_potato","g":200},{"slug":"broccoli","g":150},{"slug":"low_fat_cheese","g":25},{"slug":"olive_oil","g":5}]'::jsonb,ARRAY['sport','high_protein']::text[],ARRAY[]::text[],'1. Kook de zoete aardappel en broccoli kort voor.
2. Leg met de kip in een ovenschaal, besprenkel met olijfolie en kruiden.
3. Bestrooi met magere kaas en bak 20 min op 200°C tot goudbruin.','1. Pre-cook the sweet potato and broccoli briefly.
2. Layer with the chicken in a dish, drizzle with olive oil and herbs.
3. Scatter with low-fat cheese and bake 20 min at 200°C until golden.','oven',null,'core'),
('vietnamese_caramel_chicken_with_rice','Vietnamese caramel-kip met rijst','Vietnamese caramel chicken with rice',ARRAY['dinner'],ARRAY['maintain'],'[{"slug":"chicken_thigh","g":150},{"slug":"rice_dry","g":65},{"slug":"soy_sauce","g":12},{"slug":"honey","g":10},{"slug":"spring_onion","g":15}]'::jsonb,ARRAY['sport']::text[],ARRAY[]::text[],'1. Kook de rijst gaar.
2. Karamelliseer de honing kort, voeg de kipdij, sojasaus en wat water toe en laat inkoken tot glazig.
3. Werk af met bosui en serveer over de rijst.','1. Cook the rice.
2. Caramelise the honey briefly, add the chicken thigh, soy sauce and a little water and reduce until glossy.
3. Finish with spring onion and serve over the rice.','pan',null,'core'),
('grilled_tuna_steak_with_white_beans_tomato','Gegrilde tonijnsteak met witte bonen & tomaat','Grilled tuna steak with white beans & tomato',ARRAY['dinner'],ARRAY['cut','maintain'],'[{"slug":"tuna_steak","g":150},{"slug":"white_beans","g":150},{"slug":"cherry_tomato","g":100},{"slug":"rocket","g":30},{"slug":"olive_oil","g":6}]'::jsonb,ARRAY['sport','high_protein']::text[],ARRAY[]::text[],'1. Gril de tonijnsteak 1 min per kant tot rosé.
2. Verwarm de witte bonen met knoflook en halveer de cherrytomaten.
3. Schik met rucola, besprenkel met olijfolie en citroen en leg de aangesneden tonijn erop.','1. Grill the tuna steak 1 min per side to pink.
2. Warm the white beans with garlic and halve the cherry tomatoes.
3. Arrange with rocket, drizzle with olive oil and lemon and lay the sliced tuna on top.','pan',null,'core'),
('turkey_chili_with_beans_rice','Kalkoen-chili met bonen & rijst','Turkey chili with beans & rice',ARRAY['dinner'],ARRAY['gain','maintain'],'[{"slug":"turkey_mince","g":140},{"slug":"kidney_beans","g":120},{"slug":"passata","g":150},{"slug":"corn","g":60},{"slug":"rice_dry","g":60}]'::jsonb,ARRAY['sport']::text[],ARRAY[]::text[],'1. Kook de rijst gaar.
2. Rul het kalkoengehakt, voeg passata, kidneybonen en mais toe met komijn en chili.
3. Laat 12 min pruttelen en serveer over de rijst.','1. Cook the rice.
2. Brown the turkey mince, add passata, kidney beans and corn with cumin and chili.
3. Simmer 12 min and serve over the rice.','pan',null,'core'),
('salmon_en_papillote_with_zucchini_tomato','Zalm en papillote met courgette & tomaat','Salmon en papillote with zucchini & tomato',ARRAY['dinner'],ARRAY['maintain'],'[{"slug":"salmon","g":140},{"slug":"potato","g":200},{"slug":"zucchini","g":100},{"slug":"cherry_tomato","g":80}]'::jsonb,ARRAY['sport']::text[],ARRAY[]::text[],'1. Kook de aardappels gaar.
2. Leg de zalm met plakjes courgette en cherrytomaat op bakpapier, besprenkel met citroen en kruiden en vouw een pakketje.
3. Bak 15 min op 200°C en serveer met de aardappel.','1. Boil the potatoes.
2. Place the salmon with zucchini slices and cherry tomato on parchment, drizzle with lemon and herbs and fold a parcel.
3. Bake 15 min at 200°C and serve with the potato.','oven',null,'core'),
('light_chicken_saltimbocca_with_ham_sage_potato','Kip-saltimbocca light met ham, salie & aardappel','Light chicken saltimbocca with ham, sage & potato',ARRAY['dinner'],ARRAY['cut','maintain'],'[{"slug":"chicken_breast","g":150},{"slug":"ham_lean","g":30},{"slug":"potato","g":220},{"slug":"green_beans","g":120}]'::jsonb,ARRAY['sport','high_protein']::text[],ARRAY[]::text[],'1. Dek de kipfilet af met een plak magere ham en een paar salieblaadjes en zet vast.
2. Bak ''m in een hete pan gaar, ham-kant eerst.
3. Serveer met gekookte aardappel en sperziebonen.','1. Cover the chicken with a slice of lean ham and a few sage leaves and secure.
2. Pan-fry until done, ham-side first.
3. Serve with boiled potato and green beans.','pan',null,'core'),
('sea_bass_with_fennel_potato_lemon','Zeebaars met venkel, aardappel & citroen','Sea bass with fennel, potato & lemon',ARRAY['dinner'],ARRAY['cut','maintain'],'[{"slug":"sea_bass","g":160},{"slug":"potato","g":220},{"slug":"fennel","g":120},{"slug":"olive_oil","g":6}]'::jsonb,ARRAY['sport','high_protein']::text[],ARRAY[]::text[],'1. Snijd de venkel en aardappel, hussel met olijfolie en rooster 22 min op 200°C.
2. Leg de zeebaars de laatste 10 min erbij, met citroen en peper.
3. Serveer met wat venkelgroen.','1. Slice the fennel and potato, toss with olive oil and roast 22 min at 200°C.
2. Add the sea bass for the final 10 min, with lemon and pepper.
3. Serve with some fennel fronds.','oven',null,'core'),
('enchilada_bowl_with_chicken_beans_corn','Enchilada-bowl met kip, bonen & mais','Enchilada bowl with chicken, beans & corn',ARRAY['dinner'],ARRAY['cut','gain','maintain'],'[{"slug":"chicken_breast","g":150},{"slug":"rice_dry","g":60},{"slug":"black_beans","g":100},{"slug":"corn","g":60},{"slug":"passata","g":100}]'::jsonb,ARRAY['sport','high_protein']::text[],ARRAY[]::text[],'1. Kook de rijst gaar.
2. Bak de kip met komijn en paprikapoeder, voeg passata, bonen en mais toe en laat pruttelen.
3. Schik over de rijst en werk af met limoen en koriander.','1. Cook the rice.
2. Fry the chicken with cumin and paprika, add passata, beans and corn and simmer.
3. Arrange over the rice and finish with lime and coriander.','pan',null,'core'),
('thai_basil_chicken_with_rice_egg','Thaise basilicum-kip met rijst & ei','Thai basil chicken with rice & egg',ARRAY['dinner'],ARRAY['maintain'],'[{"slug":"chicken_mince","g":150},{"slug":"rice_dry","g":65},{"slug":"paprika","g":80},{"slug":"egg","g":55},{"slug":"soy_sauce","g":12}]'::jsonb,ARRAY['sport']::text[],ARRAY[]::text[],'1. Kook de rijst gaar.
2. Roerbak het kipgehakt op hoog vuur met knoflook en paprika, blus met sojasaus en roer veel Thaise basilicum erdoor.
3. Bak een ei met krokante randjes en leg het op de rijst met de kip.','1. Cook the rice.
2. Stir-fry the chicken mince on high heat with garlic and pepper, deglaze with soy sauce and stir in plenty of Thai basil.
3. Fry an egg with crispy edges and place it on the rice with the chicken.','pan',null,'core'),
('light_paella_with_chicken_shrimp_rice','Paella light met kip, garnaal & rijst','Light paella with chicken, shrimp & rice',ARRAY['dinner'],ARRAY['cut','maintain'],'[{"slug":"chicken_breast","g":120},{"slug":"shrimp","g":100},{"slug":"rice_dry","g":65},{"slug":"paprika","g":80},{"slug":"peas","g":60}]'::jsonb,ARRAY['sport','high_protein']::text[],ARRAY[]::text[],'1. Bak de kip aan, voeg de rijst, paprika en saffraan-bouillon toe.
2. Laat de rijst garen tot bijna droog.
3. Leg de garnalen en doperwten er de laatste 5 min bij tot gaar.','1. Sear the chicken, add the rice, pepper and saffron stock.
2. Let the rice cook until nearly dry.
3. Add the shrimp and peas for the final 5 min until done.','pan',null,'core'),
('gigantes_with_white_beans_tomato_feta','Gigantes met witte bonen, tomaat & feta','Gigantes with white beans, tomato & feta',ARRAY['dinner'],ARRAY['maintain'],'[{"slug":"white_beans","g":200},{"slug":"passata","g":150},{"slug":"onion","g":50},{"slug":"feta_light","g":40},{"slug":"bread_whole","g":60}]'::jsonb,ARRAY['sport','vegetarian']::text[],ARRAY[]::text[],'1. Fruit de ui, voeg de passata en witte bonen toe met oregano en laat 10 min pruttelen.
2. Schep in een ovenschaal en verkruimel de feta erover.
3. Bak 15 min op 200°C en serveer met het volkorenbrood.','1. Sweat the onion, add the passata and white beans with oregano and simmer 10 min.
2. Spoon into a dish and crumble the feta over.
3. Bake 15 min at 200°C and serve with the wholegrain bread.','oven',null,'core'),
('light_dal_makhani_with_rice','Indiase dal makhani light met rijst','Light dal makhani with rice',ARRAY['dinner'],ARRAY['maintain'],'[{"slug":"lentils","g":180},{"slug":"rice_dry","g":60},{"slug":"passata","g":100},{"slug":"onion","g":40},{"slug":"curry_paste","g":15}]'::jsonb,ARRAY['sport','vegetarian','vegan']::text[],ARRAY[]::text[],'1. Kook de rijst gaar.
2. Fruit de ui met de currypasta, voeg de linzen en passata toe en laat 15 min zacht pruttelen.
3. Breng op smaak met wat kaneel en serveer over de rijst.','1. Cook the rice.
2. Fry the onion with the curry paste, add the lentils and passata and simmer gently 15 min.
3. Season with a little cinnamon and serve over the rice.','pan',null,'core'),
('steak_with_chimichurri_potato_salad','Biefstuk met chimichurri, aardappel & salade','Steak with chimichurri, potato & salad',ARRAY['dinner'],ARRAY['cut','maintain'],'[{"slug":"beef_lean","g":150},{"slug":"potato","g":220},{"slug":"lettuce","g":60},{"slug":"tomato","g":60},{"slug":"olive_oil","g":6}]'::jsonb,ARRAY['sport','high_protein']::text[],ARRAY[]::text[],'1. Kook de aardappels gaar.
2. Bak de biefstuk 2–3 min per kant en laat rusten.
3. Maak een chimichurri van peterselie, knoflook, azijn en de olijfolie en lepel over de aangesneden biefstuk; serveer met een frisse salade.','1. Boil the potatoes.
2. Sear the steak 2–3 min per side and rest.
3. Make a chimichurri of parsley, garlic, vinegar and the olive oil and spoon over the sliced steak; serve with a fresh salad.','pan',null,'core'),
('protein_muffin_of_oats_banana','Proteïnemuffin van havermout & banaan','Protein muffin of oats & banana',ARRAY['snack'],ARRAY['maintain'],'[{"slug":"oats","g":40},{"slug":"banana","g":60},{"slug":"egg","g":50},{"slug":"whey","g":15}]'::jsonb,ARRAY['sport','vegetarian']::text[],ARRAY[]::text[],'1. Pureer de havermout, banaan, het ei en de whey tot beslag.
2. Verdeel over muffinvormpjes.
3. Bak 18 min op 180°C tot gaar.','1. Blend the oats, banana, egg and whey into a batter.
2. Divide over muffin cups.
3. Bake 18 min at 180°C until done.','oven',null,'core'),
('skyr_with_granola_strawberry','Skyr met granola & aardbei','Skyr with granola & strawberry',ARRAY['snack'],ARRAY['cut','maintain'],'[{"slug":"skyr","g":150},{"slug":"granola","g":25},{"slug":"strawberry","g":60}]'::jsonb,ARRAY['sport','high_protein','vegetarian']::text[],ARRAY[]::text[],'1. Schep de skyr in een kom.
2. Strooi de granola erover.
3. Top met plakjes aardbei.','1. Spoon the skyr into a bowl.
2. Scatter the granola over.
3. Top with sliced strawberry.','assembly',null,'core'),
('smoked_chicken_rolls_with_cucumber','Gerookte-kiprolletjes met komkommer','Smoked chicken rolls with cucumber',ARRAY['snack'],ARRAY['cut','maintain'],'[{"slug":"chicken_breast","g":80},{"slug":"cottage","g":60},{"slug":"cucumber","g":50}]'::jsonb,ARRAY['sport','high_protein']::text[],ARRAY[]::text[],'1. Besmeer plakjes gerookte kip met hüttenkäse.
2. Leg er een reepje komkommer op en rol op.
3. Zet eventueel vast met een prikker.','1. Spread slices of smoked chicken with cottage cheese.
2. Place a strip of cucumber on top and roll up.
3. Secure with a cocktail stick if needed.','assembly',null,'core'),
('cottage_cheese_with_pineapple','Hüttenkäse met ananas','Cottage cheese with pineapple',ARRAY['snack'],ARRAY['cut','maintain'],'[{"slug":"cottage","g":150},{"slug":"pineapple","g":80}]'::jsonb,ARRAY['sport','high_protein','vegetarian']::text[],ARRAY[]::text[],'1. Schep de hüttenkäse in een kom.
2. Top met blokjes ananas.','1. Spoon the cottage cheese into a bowl.
2. Top with diced pineapple.','assembly',null,'core'),
('rice_cakes_with_turkey_mustard','Rijstwafels met kalkoen & mosterd','Rice cakes with turkey & mustard',ARRAY['snack'],ARRAY['cut','maintain'],'[{"slug":"rice_cakes","g":26},{"slug":"turkey_breast","g":60},{"slug":"mustard","g":5},{"slug":"cucumber","g":30}]'::jsonb,ARRAY['sport','high_protein']::text[],ARRAY[]::text[],'1. Bestrijk de rijstwafels dun met mosterd.
2. Beleg met plakjes kalkoenfilet en komkommer.','1. Spread the rice cakes thinly with mustard.
2. Top with turkey slices and cucumber.','assembly',null,'core'),
('skyr_with_mixed_berries_pumpkin_seeds','Skyr met bosvruchten & pompoenpit','Skyr with mixed berries & pumpkin seeds',ARRAY['snack'],ARRAY['cut','maintain'],'[{"slug":"skyr","g":150},{"slug":"mixed_berries","g":70},{"slug":"pumpkin_seeds","g":10}]'::jsonb,ARRAY['sport','high_protein','vegetarian']::text[],ARRAY[]::text[],'1. Schep de skyr in een kom.
2. Top met de bosvruchten en pompoenpitten.','1. Spoon the skyr into a bowl.
2. Top with the mixed berries and pumpkin seeds.','assembly',null,'core'),
('apple_with_cinnamon_quark','Appel met kaneel & kwark','Apple with cinnamon & quark',ARRAY['snack'],ARRAY['maintain'],'[{"slug":"apple","g":150},{"slug":"quark_lowfat","g":100}]'::jsonb,ARRAY['sport','vegetarian']::text[],ARRAY[]::text[],'1. Snijd de appel in partjes.
2. Serveer met een kommetje kwark en een snuf kaneel om in te dippen.','1. Slice the apple into wedges.
2. Serve with a bowl of quark and a pinch of cinnamon to dip.','assembly',null,'core'),
('banana_with_peanut_butter_cinnamon','Banaan met pindakaas & kaneel','Banana with peanut butter & cinnamon',ARRAY['snack'],ARRAY['maintain'],'[{"slug":"banana","g":120},{"slug":"peanut_butter","g":15}]'::jsonb,ARRAY['sport','vegetarian','vegan']::text[],ARRAY[]::text[],'1. Snijd de banaan in de lengte door.
2. Besmeer met pindakaas en bestrooi met kaneel.','1. Slice the banana lengthwise.
2. Spread with peanut butter and dust with cinnamon.','assembly',null,'core'),
('tofu_scramble_with_pepper_wholegrain_bread','Tofu-scramble met paprika & volkorenbrood','Tofu scramble with pepper & wholegrain bread',ARRAY['breakfast'],ARRAY['cut','maintain'],'[{"slug":"tofu","g":150},{"slug":"paprika","g":60},{"slug":"spinach","g":40},{"slug":"bread_whole","g":60}]'::jsonb,ARRAY['sport','high_protein','vegetarian','vegan']::text[],ARRAY[]::text[],'1. Verkruimel de tofu en bak ''m met kurkuma, komijn en peper tot ''roerei''.
2. Voeg de paprika en spinazie toe en bak kort mee.
3. Serveer op het geroosterde volkorenbrood.','1. Crumble the tofu and fry with turmeric, cumin and pepper into a ''scramble''.
2. Add the pepper and spinach and cook briefly.
3. Serve on the toasted wholegrain bread.','pan',null,'core'),
('vegan_protein_smoothie_with_oat_milk_banana_peanut_butter','Vegan proteïne-smoothie met havermelk, banaan & pindakaas','Vegan protein smoothie with oat milk, banana & peanut butter',ARRAY['breakfast','snack'],ARRAY['maintain'],'[{"slug":"oat_milk","g":250},{"slug":"banana","g":100},{"slug":"peanut_butter","g":15},{"slug":"oats","g":30}]'::jsonb,ARRAY['sport','vegetarian','vegan']::text[],ARRAY[]::text[],'1. Doe de havermelk, banaan, pindakaas en havermout in de blender.
2. Mix glad.
3. Schenk in een glas.','1. Add the oat milk, banana, peanut butter and oats to the blender.
2. Blend smooth.
3. Pour into a glass.','blender',null,'core'),
('shakshuka_with_chickpeas_egg','Shakshuka met kikkererwten & ei','Shakshuka with chickpeas & egg',ARRAY['breakfast','lunch'],ARRAY['maintain'],'[{"slug":"egg","g":100},{"slug":"chickpeas","g":100},{"slug":"passata","g":150},{"slug":"paprika","g":80},{"slug":"bread_whole","g":50}]'::jsonb,ARRAY['sport','vegetarian']::text[],ARRAY[]::text[],'1. Stoof de paprika zacht, voeg passata en kikkererwten toe met komijn en paprikapoeder.
2. Laat 8 min pruttelen, maak kuiltjes en breek de eieren erin.
3. Dek af tot het eiwit stolt; serveer met het brood.','1. Soften the pepper, add passata and chickpeas with cumin and paprika.
2. Simmer 8 min, make wells and crack the eggs in.
3. Cover until the whites set; serve with the bread.','pan',null,'core'),
('chia_overnight_with_soy_yoghurt_mixed_berries','Chia-overnight met sojayoghurt & bosvruchten','Chia overnight with soy yoghurt & mixed berries',ARRAY['breakfast'],ARRAY['maintain'],'[{"slug":"chia","g":20},{"slug":"soy_yoghurt","g":200},{"slug":"oats","g":30},{"slug":"mixed_berries","g":80}]'::jsonb,ARRAY['sport','vegetarian','vegan']::text[],ARRAY[]::text[],'1. Meng het chiazaad, de sojayoghurt en havermout in een pot.
2. Laat een nacht opstijven.
3. Top met bosvruchten.','1. Mix the chia, soy yoghurt and oats in a jar.
2. Let set overnight.
3. Top with mixed berries.','assembly',null,'core'),
('savoury_oats_with_egg_spinach','Hartige havermout met ei & spinazie','Savoury oats with egg & spinach',ARRAY['breakfast'],ARRAY['maintain'],'[{"slug":"oats","g":60},{"slug":"egg","g":55},{"slug":"spinach","g":50},{"slug":"low_fat_cheese","g":20}]'::jsonb,ARRAY['sport','vegetarian']::text[],ARRAY[]::text[],'1. Kook de havermout met water (of bouillon) tot een zachte pap.
2. Roer de spinazie en magere kaas erdoor tot geslonken.
3. Leg een gepocheerd of zacht gebakken ei erop.','1. Cook the oats with water (or stock) into a soft porridge.
2. Stir the spinach and low-fat cheese through until wilted.
3. Top with a poached or soft-fried egg.','pan',null,'core'),
('wholegrain_bread_with_almond_butter_strawberry','Volkorenbrood met amandelpasta & aardbei','Wholegrain bread with almond butter & strawberry',ARRAY['breakfast','snack'],ARRAY['maintain'],'[{"slug":"bread_whole","g":70},{"slug":"almond_butter","g":15},{"slug":"strawberry","g":60}]'::jsonb,ARRAY['sport','vegetarian','vegan']::text[],ARRAY[]::text[],'1. Rooster het volkorenbrood.
2. Besmeer dun met amandelpasta.
3. Beleg met plakjes aardbei.','1. Toast the wholegrain bread.
2. Spread thinly with almond butter.
3. Top with strawberry slices.','assembly',null,'core'),
('quark_with_granola_apple_cinnamon','Kwark met granola, appel & kaneel','Quark with granola, apple & cinnamon',ARRAY['breakfast'],ARRAY['cut','maintain'],'[{"slug":"quark_lowfat","g":200},{"slug":"granola","g":30},{"slug":"apple","g":80}]'::jsonb,ARRAY['sport','high_protein','vegetarian']::text[],ARRAY[]::text[],'1. Schep de kwark in een kom.
2. Strooi de granola erover.
3. Top met blokjes appel en een snuf kaneel.','1. Spoon the quark into a bowl.
2. Scatter the granola over.
3. Top with diced apple and a pinch of cinnamon.','pan',null,'core'),
('greek_yoghurt_with_dates_walnut_honey','Griekse yoghurt met dadels, walnoot & honing','Greek yoghurt with dates, walnut & honey',ARRAY['breakfast','snack'],ARRAY['maintain'],'[{"slug":"greek_yoghurt","g":200},{"slug":"dates","g":30},{"slug":"walnuts","g":12},{"slug":"honey","g":8}]'::jsonb,ARRAY['sport','vegetarian']::text[],ARRAY[]::text[],'1. Schep de Griekse yoghurt in een kom.
2. Snijd de dadels klein en strooi met de walnoten erover.
3. Druppel de honing erover.','1. Spoon the Greek yoghurt into a bowl.
2. Chop the dates and scatter with the walnuts over.
3. Drizzle the honey over.','assembly',null,'core'),
('light_gado_gado_with_tofu_egg_peanut_dressing','Gado-gado light met tofu, ei & pindadressing','Light gado-gado with tofu, egg & peanut dressing',ARRAY['lunch','dinner'],ARRAY['cut','maintain'],'[{"slug":"tofu","g":120},{"slug":"egg","g":55},{"slug":"green_beans","g":80},{"slug":"bean_sprouts","g":60},{"slug":"peanut_butter","g":15}]'::jsonb,ARRAY['sport','high_protein','vegetarian']::text[],ARRAY[]::text[],'1. Blancheer de sperziebonen en taugé; kook het ei en halveer.
2. Bak de tofublokjes goudbruin.
3. Roer een dressing van pindakaas, sojasaus, limoen en water en lepel over de groente, tofu en ei.','1. Blanch the green beans and bean sprouts; boil the egg and halve.
2. Fry the tofu cubes until golden.
3. Stir a dressing of peanut butter, soy sauce, lime and water and spoon over the vegetables, tofu and egg.','pan',null,'core'),
('mexican_quesadilla_with_chicken_beans_cheese','Mexicaanse quesadilla met kip, bonen & kaas','Mexican quesadilla with chicken, beans & cheese',ARRAY['lunch','dinner'],ARRAY['cut','maintain'],'[{"slug":"wrap_whole","g":60},{"slug":"chicken_breast","g":100},{"slug":"black_beans","g":80},{"slug":"low_fat_cheese","g":30},{"slug":"paprika","g":50}]'::jsonb,ARRAY['sport','high_protein']::text[],ARRAY[]::text[],'1. Bak de kip met komijn en paprikapoeder en verwarm de bonen.
2. Vul de helft van de wrap met kip, bonen, paprika en magere kaas en klap dicht.
3. Bak de quesadilla aan beide kanten goudbruin en snijd in punten.','1. Fry the chicken with cumin and paprika and warm the beans.
2. Fill half the wrap with chicken, beans, pepper and low-fat cheese and fold over.
3. Toast the quesadilla golden on both sides and cut into wedges.','pan',null,'core'),
('minestrone_soup_with_beans_wholegrain_pasta','Minestronesoep met bonen & volkoren pasta','Minestrone soup with beans & wholegrain pasta',ARRAY['lunch'],ARRAY['maintain'],'[{"slug":"white_beans","g":120},{"slug":"pasta_whole","g":40},{"slug":"passata","g":120},{"slug":"carrot","g":60},{"slug":"zucchini","g":60}]'::jsonb,ARRAY['sport','vegetarian','vegan']::text[],ARRAY[]::text[],'1. Fruit de wortel en courgette kort aan.
2. Voeg passata, bouillon en de witte bonen toe en laat 10 min garen.
3. Kook de pasta er kort in mee en breng op smaak met Italiaanse kruiden.','1. Sweat the carrot and zucchini briefly.
2. Add passata, stock and the white beans and simmer 10 min.
3. Cook the pasta in it briefly and season with Italian herbs.','soup',null,'core'),
('oven_falafel_bowl_with_tzatziki','Falafel-bowl uit de oven met tzatziki','Oven falafel bowl with tzatziki',ARRAY['lunch'],ARRAY['maintain'],'[{"slug":"chickpeas","g":150},{"slug":"bulgur","g":50},{"slug":"yoghurt_lowfat","g":60},{"slug":"cucumber","g":60},{"slug":"tomato","g":60}]'::jsonb,ARRAY['sport','vegetarian']::text[],ARRAY[]::text[],'1. Pureer de kikkererwten met knoflook, komijn en peterselie, vorm balletjes en bak 20 min op 200°C.
2. Kook de bulgur gaar.
3. Rasp de komkommer door de yoghurt tot tzatziki; schik met de bulgur, tomaat en falafel.','1. Blend the chickpeas with garlic, cumin and parsley, shape balls and bake 20 min at 200°C.
2. Cook the bulgur.
3. Grate the cucumber into the yoghurt for tzatziki; arrange with the bulgur, tomato and falafel.','oven',null,'core'),
('mezze_lunch_with_hummus_bulgur_vegetables_feta','Mezze-lunch met hummus, bulgur, groente & feta','Mezze lunch with hummus, bulgur, vegetables & feta',ARRAY['lunch'],ARRAY['maintain'],'[{"slug":"bulgur","g":50},{"slug":"hummus_light","g":40},{"slug":"feta_light","g":30},{"slug":"paprika","g":60},{"slug":"cucumber","g":60}]'::jsonb,ARRAY['sport','vegetarian']::text[],ARRAY[]::text[],'1. Kook de bulgur gaar en laat afkoelen.
2. Schik met de hummus, blokjes paprika en komkommer.
3. Verkruimel de feta erover en werk af met munt en citroen.','1. Cook the bulgur and let cool.
2. Arrange with the hummus, diced pepper and cucumber.
3. Crumble the feta over and finish with mint and lemon.','pan',null,'core'),
('tuna_melt_on_wholegrain_bread_with_low_fat_cheese','Tonijnmelt op volkorenbrood met magere kaas','Tuna melt on wholegrain bread with low-fat cheese',ARRAY['lunch'],ARRAY['cut','maintain'],'[{"slug":"bread_whole","g":80},{"slug":"tuna_can","g":100},{"slug":"low_fat_cheese","g":30},{"slug":"yoghurt_lowfat","g":20},{"slug":"tomato","g":40}]'::jsonb,ARRAY['sport','high_protein']::text[],ARRAY[]::text[],'1. Meng de tonijn met een lepel yoghurt en peper.
2. Verdeel over het volkorenbrood, leg plakjes tomaat en magere kaas erop.
3. Gratineer onder de grill tot de kaas smelt.','1. Mix the tuna with a spoon of yoghurt and pepper.
2. Spread over the wholegrain bread, top with tomato and low-fat cheese.
3. Grill until the cheese melts.','oven',null,'core'),
('chicken_bowl_with_bulgur_roasted_vegetables_yoghurt','Kipfilet-bowl met bulgur, geroosterde groente & yoghurt','Chicken bowl with bulgur, roasted vegetables & yoghurt',ARRAY['lunch','dinner'],ARRAY['cut','maintain'],'[{"slug":"chicken_breast","g":130},{"slug":"bulgur","g":55},{"slug":"eggplant","g":80},{"slug":"paprika","g":70},{"slug":"yoghurt_lowfat","g":40}]'::jsonb,ARRAY['sport','high_protein']::text[],ARRAY[]::text[],'1. Rooster de aubergine en paprika 20 min op 200°C.
2. Kook de bulgur gaar en gril de kipfilet.
3. Schik alles in een kom en lepel een frisse yoghurt-citroendressing erover.','1. Roast the eggplant and pepper 20 min at 200°C.
2. Cook the bulgur and grill the chicken.
3. Arrange in a bowl and spoon a fresh yoghurt-lemon dressing over.','oven',null,'core'),
('thai_beef_salad_with_herbs_lime','Thaise rundvleessalade met kruiden & limoen','Thai beef salad with herbs & lime',ARRAY['lunch','dinner'],ARRAY['cut','maintain'],'[{"slug":"beef_lean","g":130},{"slug":"lettuce","g":80},{"slug":"cucumber","g":60},{"slug":"carrot","g":50},{"slug":"soy_sauce","g":10}]'::jsonb,ARRAY['sport','high_protein']::text[],ARRAY[]::text[],'1. Gril het rundvlees rosé en snijd dun.
2. Meng de sla, komkommer en wortel met verse munt en koriander.
3. Maak aan met sojasaus, limoen en chili en leg het vlees erop.','1. Grill the beef to pink and slice thin.
2. Toss the lettuce, cucumber and carrot with fresh mint and coriander.
3. Dress with soy sauce, lime and chili and lay the beef on top.','pan',null,'core'),
('caesar_bowl_with_shrimp','Caesar-bowl met garnalen','Caesar bowl with shrimp',ARRAY['lunch'],ARRAY['cut','maintain'],'[{"slug":"shrimp","g":120},{"slug":"lettuce","g":80},{"slug":"bread_whole","g":40},{"slug":"greek_yoghurt","g":40},{"slug":"low_fat_cheese","g":15}]'::jsonb,ARRAY['sport','high_protein']::text[],ARRAY[]::text[],'1. Bak de garnalen kort gaar.
2. Rooster blokjes volkorenbrood tot croutons.
3. Meng de sla met een dressing van yoghurt, mosterd, citroen en magere kaas; schik garnalen en croutons erop.','1. Sear the shrimp until done.
2. Toast diced wholegrain bread into croutons.
3. Toss the lettuce with a dressing of yoghurt, mustard, lemon and low-fat cheese; arrange shrimp and croutons on top.','pan',null,'core'),
('gazpacho_with_shrimp_wholegrain_bread','Gazpacho met garnaal & volkorenbrood','Gazpacho with shrimp & wholegrain bread',ARRAY['lunch'],ARRAY['cut','maintain'],'[{"slug":"tomato","g":250},{"slug":"cucumber","g":80},{"slug":"paprika","g":60},{"slug":"shrimp","g":100},{"slug":"bread_whole","g":50}]'::jsonb,ARRAY['sport','high_protein']::text[],ARRAY[]::text[],'1. Pureer de tomaat, komkommer en paprika met knoflook, azijn en peper tot een koude soep.
2. Bak de garnalen kort gaar.
3. Schenk de gazpacho in een kom, leg de garnalen erop en serveer met het brood.','1. Blend the tomato, cucumber and pepper with garlic, vinegar and pepper into a cold soup.
2. Sear the shrimp until done.
3. Pour the gazpacho into a bowl, top with the shrimp and serve with the bread.','blender',null,'core'),
('light_butter_chicken_with_rice','Butter chicken light met rijst','Light butter chicken with rice',ARRAY['dinner'],ARRAY['cut','maintain'],'[{"slug":"chicken_breast","g":150},{"slug":"rice_dry","g":65},{"slug":"passata","g":120},{"slug":"yoghurt_lowfat","g":50},{"slug":"curry_paste","g":20}]'::jsonb,ARRAY['sport','high_protein']::text[],ARRAY[]::text[],'1. Kook de rijst gaar.
2. Marineer de kip in wat yoghurt en bak ''m aan; voeg de currypasta en passata toe.
3. Roer de rest van de yoghurt erdoor voor romigheid en laat 8 min pruttelen; serveer over de rijst.','1. Cook the rice.
2. Marinate the chicken in some yoghurt and sear; add the curry paste and passata.
3. Stir the rest of the yoghurt through for creaminess and simmer 8 min; serve over the rice.','pan',null,'core'),
('chana_masala_with_rice','Chana masala met rijst','Chana masala with rice',ARRAY['dinner'],ARRAY['gain','maintain'],'[{"slug":"chickpeas","g":200},{"slug":"rice_dry","g":60},{"slug":"passata","g":120},{"slug":"onion","g":50},{"slug":"curry_paste","g":20}]'::jsonb,ARRAY['sport','vegetarian','vegan']::text[],ARRAY[]::text[],'1. Kook de rijst gaar.
2. Fruit de ui met de currypasta, voeg de kikkererwten en passata toe.
3. Laat 12 min pruttelen en serveer over de rijst met koriander.','1. Cook the rice.
2. Fry the onion with the curry paste, add the chickpeas and passata.
3. Simmer 12 min and serve over the rice with coriander.','pan',null,'core'),
('tandoori_chicken_with_rice_cucumber_salad','Tandoori-kip met rijst & komkommersalade','Tandoori chicken with rice & cucumber salad',ARRAY['dinner'],ARRAY['cut','maintain'],'[{"slug":"chicken_breast","g":150},{"slug":"rice_dry","g":65},{"slug":"yoghurt_lowfat","g":60},{"slug":"cucumber","g":80},{"slug":"curry_paste","g":15}]'::jsonb,ARRAY['sport','high_protein']::text[],ARRAY[]::text[],'1. Marineer de kip in yoghurt met de currypasta en gril ''m gaar.
2. Kook de rijst gaar.
3. Maak een frisse komkommersalade met citroen en serveer met de kip en rijst.','1. Marinate the chicken in yoghurt with the curry paste and grill until done.
2. Cook the rice.
3. Make a fresh cucumber salad with lemon and serve with the chicken and rice.','pan',null,'core'),
('light_nasi_goreng_with_chicken_egg','Nasi goreng light met kip & ei','Light nasi goreng with chicken & egg',ARRAY['dinner'],ARRAY['cut','maintain'],'[{"slug":"chicken_breast","g":130},{"slug":"rice_dry","g":65},{"slug":"egg","g":55},{"slug":"carrot","g":60},{"slug":"soy_sauce","g":15}]'::jsonb,ARRAY['sport','high_protein']::text[],ARRAY[]::text[],'1. Kook de rijst en laat afkoelen.
2. Bak de kip met wat ketjap en sambal, voeg de rijst en wortel toe en roerbak.
3. Bak een ei apart en leg het op de nasi.','1. Cook the rice and let cool.
2. Fry the chicken with ketjap and sambal, add the rice and carrot and stir-fry.
3. Fry an egg separately and place it on the nasi.','pan',null,'core'),
('jerk_chicken_with_rice_beans','Jerk chicken met rijst & bonen','Jerk chicken with rice & beans',ARRAY['dinner'],ARRAY['gain','maintain'],'[{"slug":"chicken_thigh","g":150},{"slug":"rice_dry","g":60},{"slug":"kidney_beans","g":100},{"slug":"paprika","g":60},{"slug":"spring_onion","g":15}]'::jsonb,ARRAY['sport']::text[],ARRAY[]::text[],'1. Marineer de kipdij in jerk-kruiden en gril of bak ''m gaar.
2. Kook de rijst met de kidneybonen en wat kruiden.
3. Serveer met de paprika en bosui.','1. Marinate the chicken thigh in jerk spice and grill or pan-fry.
2. Cook the rice with the kidney beans and some spice.
3. Serve with the pepper and spring onion.','pan',null,'core'),
('oyakodon_chicken_egg_on_rice','Oyakodon — kip & ei op rijst','Oyakodon — chicken & egg on rice',ARRAY['dinner'],ARRAY['cut','gain','maintain'],'[{"slug":"chicken_breast","g":140},{"slug":"rice_dry","g":65},{"slug":"egg","g":100},{"slug":"onion","g":50},{"slug":"soy_sauce","g":15}]'::jsonb,ARRAY['sport','high_protein']::text[],ARRAY[]::text[],'1. Kook de rijst gaar.
2. Sudder de kip met ui in een mix van sojasaus, dashi en een beetje honing.
3. Giet losgeklopt ei erover, dek af tot het net gestold is en schep over de rijst.','1. Cook the rice.
2. Simmer the chicken with onion in a mix of soy sauce, dashi and a little honey.
3. Pour beaten egg over, cover until just set and spoon over the rice.','pan',null,'core'),
('oven_katsu_chicken_with_rice_curry_sauce','Katsu-kip uit de oven met rijst & currysaus','Oven katsu chicken with rice & curry sauce',ARRAY['dinner'],ARRAY['cut','maintain'],'[{"slug":"chicken_breast","g":150},{"slug":"rice_dry","g":65},{"slug":"bread_whole","g":30},{"slug":"carrot","g":60},{"slug":"curry_paste","g":15}]'::jsonb,ARRAY['sport','high_protein']::text[],ARRAY[]::text[],'1. Paneer de kipfilet met verkruimeld volkorenbrood en bak ''m 20 min krokant in de oven op 200°C.
2. Kook de rijst gaar.
3. Maak een currysaus van currypasta, wortel en bouillon; snijd de kip aan en lepel de saus erover.','1. Coat the chicken with crushed wholegrain bread and bake 20 min crisp at 200°C.
2. Cook the rice.
3. Make a curry sauce of curry paste, carrot and stock; slice the chicken and spoon the sauce over.','oven',null,'core'),
('chicken_tacos_with_beans_salsa','Kip-taco''s met bonen & salsa','Chicken tacos with beans & salsa',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"chicken_breast","g":140},{"slug":"wrap_whole","g":50},{"slug":"black_beans","g":80},{"slug":"tomato","g":60},{"slug":"corn","g":50}]'::jsonb,ARRAY['sport','high_protein']::text[],ARRAY[]::text[],'1. Bak de kip met komijn en paprikapoeder; verwarm de bonen en mais.
2. Maak een snelle salsa van tomaat, ui en limoen.
3. Vul de warme tortilla''s met kip, bonen, mais en salsa.','1. Fry the chicken with cumin and paprika; warm the beans and corn.
2. Make a quick salsa of tomato, onion and lime.
3. Fill the warm tortillas with chicken, beans, corn and salsa.','pan',null,'core'),
('light_pasta_puttanesca_with_tuna_olives','Pasta puttanesca light met tonijn & olijven','Light pasta puttanesca with tuna & olives',ARRAY['dinner'],ARRAY['cut','maintain'],'[{"slug":"pasta_whole","g":75},{"slug":"tuna_can","g":100},{"slug":"passata","g":150},{"slug":"olives","g":20},{"slug":"onion","g":40}]'::jsonb,ARRAY['sport','high_protein']::text[],ARRAY[]::text[],'1. Kook de volkoren pasta beetgaar.
2. Fruit de ui, voeg passata, olijven en kappertjes toe en laat 8 min pruttelen.
3. Roer de tonijn erdoor en meng met de pasta.','1. Cook the wholegrain pasta al dente.
2. Sweat the onion, add passata, olives and capers and simmer 8 min.
3. Stir the tuna through and toss with the pasta.','pan',null,'core'),
('miso_salmon_with_brown_rice_sprouts','Misozalm met zilvervliesrijst & spruitjes','Miso salmon with brown rice & sprouts',ARRAY['dinner'],ARRAY['gain','maintain'],'[{"slug":"salmon","g":140},{"slug":"brown_rice","g":65},{"slug":"brussels_sprouts","g":120},{"slug":"miso","g":15}]'::jsonb,ARRAY['sport']::text[],ARRAY[]::text[],'1. Bestrijk de zalm met miso en wat honing en bak ''m 12 min op 200°C.
2. Kook de zilvervliesrijst gaar.
3. Rooster de gehalveerde spruitjes mee in de oven en serveer samen.','1. Brush the salmon with miso and a little honey and bake 12 min at 200°C.
2. Cook the brown rice.
3. Roast the halved sprouts in the oven and serve together.','oven',null,'core'),
('greek_chicken_gyros_with_pita_tzatziki','Griekse kip-gyros met pita & tzatziki','Greek chicken gyros with pita & tzatziki',ARRAY['dinner'],ARRAY['cut','maintain'],'[{"slug":"chicken_breast","g":150},{"slug":"pita_whole","g":60},{"slug":"yoghurt_lowfat","g":50},{"slug":"cucumber","g":60},{"slug":"tomato","g":60}]'::jsonb,ARRAY['sport','high_protein']::text[],ARRAY[]::text[],'1. Kruid de kipreepjes met oregano, knoflook en citroen en bak gaar.
2. Rasp de komkommer door de yoghurt tot tzatziki.
3. Vul de warme pita met kip, tomaat en tzatziki.','1. Season the chicken strips with oregano, garlic and lemon and cook.
2. Grate the cucumber into the yoghurt for tzatziki.
3. Fill the warm pita with chicken, tomato and tzatziki.','pan',null,'core'),
('endive_mash_with_turkey','Stamppot andijvie met kalkoen','Endive mash with turkey',ARRAY['dinner'],ARRAY['cut','maintain'],'[{"slug":"potato","g":250},{"slug":"endive","g":120},{"slug":"turkey_breast","g":130},{"slug":"milk_semi","g":50}]'::jsonb,ARRAY['sport','high_protein']::text[],ARRAY[]::text[],'1. Kook de aardappels gaar en stamp met een scheut melk.
2. Roer de fijngesneden rauwe andijvie erdoor tot licht geslonken.
3. Bak de kalkoenfilet gaar en serveer op de stamppot.','1. Boil the potatoes and mash with a splash of milk.
2. Stir the finely chopped raw endive through until lightly wilted.
3. Pan-fry the turkey and serve on the mash.','pan',null,'core'),
('kale_mash_with_turkey','Boerenkoolstamppot met kalkoen','Kale mash with turkey',ARRAY['dinner'],ARRAY['cut','maintain'],'[{"slug":"potato","g":250},{"slug":"kale","g":120},{"slug":"turkey_breast","g":130},{"slug":"milk_semi","g":50}]'::jsonb,ARRAY['sport','high_protein']::text[],ARRAY[]::text[],'1. Kook de aardappels met de boerenkool gaar.
2. Stamp met een scheut melk en breng op smaak met peper en nootmuskaat.
3. Bak de kalkoenfilet gaar en serveer op de stamppot.','1. Boil the potatoes with the kale.
2. Mash with a splash of milk and season with pepper and nutmeg.
3. Pan-fry the turkey and serve on the mash.','pan',null,'core'),
('keralan_fish_curry_with_white_fish_rice','Keralaanse viscurry met witvis & rijst','Keralan fish curry with white fish & rice',ARRAY['dinner'],ARRAY['cut','maintain'],'[{"slug":"white_fish","g":160},{"slug":"rice_dry","g":65},{"slug":"coconut_light","g":80},{"slug":"tomato","g":80},{"slug":"curry_paste","g":15}]'::jsonb,ARRAY['sport','high_protein']::text[],ARRAY[]::text[],'1. Kook de rijst gaar.
2. Bak de currypasta kort, voeg de kokosmelk en tomaat toe en laat pruttelen.
3. Leg de witvis erin en pocheer 6 min tot gaar; serveer met de rijst.','1. Cook the rice.
2. Fry the curry paste briefly, add the coconut milk and tomato and simmer.
3. Lay the white fish in and poach 6 min until done; serve with the rice.','pan',null,'core'),
('stuffed_portobello_with_chicken_mince_cheese','Gevulde portobello met kipgehakt & kaas','Stuffed portobello with chicken mince & cheese',ARRAY['dinner'],ARRAY['cut','maintain'],'[{"slug":"mushroom","g":200},{"slug":"chicken_mince","g":120},{"slug":"passata","g":80},{"slug":"low_fat_cheese","g":30},{"slug":"potato","g":180}]'::jsonb,ARRAY['sport','high_protein']::text[],ARRAY[]::text[],'1. Rul het kipgehakt met de passata en kruiden.
2. Vul de portobello''s en bestrooi met magere kaas.
3. Bak 20 min op 200°C en serveer met gekookte aardappel.','1. Brown the chicken mince with the passata and herbs.
2. Fill the portobellos and scatter with low-fat cheese.
3. Bake 20 min at 200°C and serve with boiled potato.','oven',null,'core'),
('sweet_potato_stew_with_chickpea_spinach','Zoete-aardappelstoof met kikkererwt & spinazie','Sweet potato stew with chickpea & spinach',ARRAY['dinner'],ARRAY['maintain'],'[{"slug":"sweet_potato","g":220},{"slug":"chickpeas","g":150},{"slug":"spinach","g":80},{"slug":"passata","g":120},{"slug":"curry_paste","g":15}]'::jsonb,ARRAY['sport','vegetarian','vegan']::text[],ARRAY[]::text[],'1. Bak de currypasta kort, voeg blokjes zoete aardappel en passata toe en laat 15 min garen.
2. Roer de kikkererwten erdoor en laat nog 5 min pruttelen.
3. Roer de spinazie erdoor tot geslonken.','1. Fry the curry paste briefly, add diced sweet potato and passata and cook 15 min.
2. Stir the chickpeas through and simmer 5 min more.
3. Stir the spinach through until wilted.','pan',null,'core'),
('beef_stir_fry_with_broccoli_oyster_sauce','Biefstuk-roerbak met broccoli & oestersaus','Beef stir-fry with broccoli & oyster sauce',ARRAY['dinner'],ARRAY['cut','maintain'],'[{"slug":"beef_lean","g":150},{"slug":"rice_dry","g":65},{"slug":"broccoli","g":150},{"slug":"oyster_sauce","g":20}]'::jsonb,ARRAY['sport','high_protein']::text[],ARRAY[]::text[],'1. Kook de rijst gaar.
2. Bak de reepjes rundvlees kort op hoog vuur en haal uit de pan.
3. Roerbak de broccoli beetgaar, voeg het vlees en de oestersaus terug en bak 1 min; serveer over de rijst.','1. Cook the rice.
2. Sear the beef strips briefly on high heat and remove.
3. Stir-fry the broccoli, return the beef and oyster sauce and cook 1 min; serve over the rice.','pan',null,'core'),
('oven_tofu_katsu_with_rice','Tofu-katsu uit de oven met rijst','Oven tofu katsu with rice',ARRAY['dinner'],ARRAY['gain','maintain'],'[{"slug":"tofu","g":180},{"slug":"rice_dry","g":65},{"slug":"bread_whole","g":30},{"slug":"carrot","g":60},{"slug":"curry_paste","g":15}]'::jsonb,ARRAY['sport','vegetarian','vegan']::text[],ARRAY[]::text[],'1. Paneer de tofuplakken met verkruimeld volkorenbrood en bak 20 min krokant op 200°C.
2. Kook de rijst gaar.
3. Maak een currysaus van currypasta, wortel en water en lepel over de tofu en rijst.','1. Coat the tofu slices with crushed wholegrain bread and bake 20 min crisp at 200°C.
2. Cook the rice.
3. Make a curry sauce of curry paste, carrot and water and spoon over the tofu and rice.','oven',null,'core'),
('chia_pudding_with_oat_milk_mixed_berries','Chiapudding met havermelk & bosvruchten','Chia pudding with oat milk & mixed berries',ARRAY['snack'],ARRAY['maintain'],'[{"slug":"chia","g":20},{"slug":"oat_milk","g":150},{"slug":"mixed_berries","g":60}]'::jsonb,ARRAY['sport','vegetarian','vegan']::text[],ARRAY[]::text[],'1. Meng het chiazaad met de havermelk en laat een nacht opstijven.
2. Roer los en top met bosvruchten.','1. Mix the chia with the oat milk and let set overnight.
2. Stir loose and top with mixed berries.','assembly',null,'core'),
('quark_with_mango_chia','Kwark met mango & chiazaad','Quark with mango & chia',ARRAY['snack'],ARRAY['cut','maintain'],'[{"slug":"quark_lowfat","g":150},{"slug":"mango","g":70},{"slug":"chia","g":8}]'::jsonb,ARRAY['sport','high_protein','vegetarian']::text[],ARRAY[]::text[],'1. Schep de kwark in een kom.
2. Top met blokjes mango en chiazaad.','1. Spoon the quark into a bowl.
2. Top with diced mango and chia.','assembly',null,'core'),
('wholegrain_crackers_with_avocado_tomato','Volkoren crackers met avocado & tomaat','Wholegrain crackers with avocado & tomato',ARRAY['snack'],ARRAY['maintain'],'[{"slug":"crackers_whole","g":24},{"slug":"avocado","g":40},{"slug":"cherry_tomato","g":50}]'::jsonb,ARRAY['sport','vegetarian','vegan']::text[],ARRAY[]::text[],'1. Prak de avocado met citroen en peper.
2. Besmeer de crackers en top met gehalveerde cherrytomaat.','1. Mash the avocado with lemon and pepper.
2. Spread the crackers and top with halved cherry tomato.','assembly',null,'core'),
('two_boiled_eggs_with_pepper','Twee gekookte eieren met peper','Two boiled eggs with pepper',ARRAY['snack'],ARRAY['cut','maintain'],'[{"slug":"egg","g":120}]'::jsonb,ARRAY['sport','high_protein','vegetarian']::text[],ARRAY[]::text[],'1. Kook de eieren 7–8 min hard.
2. Pel, halveer en bestrooi met peper en wat zout.','1. Hard-boil the eggs 7–8 min.
2. Peel, halve and sprinkle with pepper and a little salt.','pan',null,'core'),
('edamame_with_chili_lime','Edamame met chili & limoen','Edamame with chili & lime',ARRAY['snack'],ARRAY['cut','maintain'],'[{"slug":"edamame","g":150},{"slug":"soy_sauce","g":8}]'::jsonb,ARRAY['sport','high_protein','vegetarian','vegan']::text[],ARRAY[]::text[],'1. Kook of stoom de edamame 4–5 min.
2. Besprenkel met sojasaus, limoen en wat chilivlokken.','1. Boil or steam the edamame 4–5 min.
2. Drizzle with soy sauce, lime and some chili flakes.','pan',null,'core'),
('rice_cakes_with_cottage_cheese_cucumber','Rijstwafels met hüttenkäse & komkommer','Rice cakes with cottage cheese & cucumber',ARRAY['snack'],ARRAY['maintain'],'[{"slug":"rice_cakes","g":26},{"slug":"cottage","g":80},{"slug":"cucumber","g":40}]'::jsonb,ARRAY['sport','vegetarian']::text[],ARRAY[]::text[],'1. Besmeer de rijstwafels met de hüttenkäse.
2. Beleg met dunne plakjes komkommer en wat peper.','1. Spread the rice cakes with the cottage cheese.
2. Top with thin cucumber slices and some pepper.','assembly',null,'core'),
('skyr_with_dates_walnut','Skyr met dadels & walnoot','Skyr with dates & walnut',ARRAY['snack'],ARRAY['cut','maintain'],'[{"slug":"skyr","g":150},{"slug":"dates","g":25},{"slug":"walnuts","g":10}]'::jsonb,ARRAY['sport','high_protein','vegetarian']::text[],ARRAY[]::text[],'1. Schep de skyr in een kom.
2. Snijd de dadels klein en strooi met de walnoten erover.','1. Spoon the skyr into a bowl.
2. Chop the dates and scatter with the walnuts over.','assembly',null,'core'),
('grapes_with_almonds','Druiven met amandelen','Grapes with almonds',ARRAY['snack'],ARRAY['maintain'],'[{"slug":"grapes","g":120},{"slug":"almonds","g":15}]'::jsonb,ARRAY['sport','vegetarian','vegan']::text[],ARRAY[]::text[],'1. Was de druiven.
2. Serveer met een handje amandelen als frisse, knapperige snack.','1. Wash the grapes.
2. Serve with a handful of almonds as a fresh, crunchy snack.','assembly',null,'core'),
('omelette_with_tomato_spring_onion_low_fat_cheese','Omelet met tomaat, bosui & magere kaas','Omelette with tomato, spring onion & low-fat cheese',ARRAY['breakfast','lunch'],ARRAY['cut','maintain'],'[{"slug":"egg","g":120},{"slug":"egg_white","g":60},{"slug":"tomato","g":60},{"slug":"spring_onion","g":15},{"slug":"low_fat_cheese","g":25}]'::jsonb,ARRAY['sport','high_protein','vegetarian']::text[],ARRAY[]::text[],'1. Klop het ei met het eiwit los.
2. Giet in een hete antiaanbakpan, strooi tomaat, bosui en magere kaas erover.
3. Vouw dubbel en laat kort nagaren.','1. Whisk the egg with the egg white.
2. Pour into a hot non-stick pan, scatter tomato, spring onion and low-fat cheese over.
3. Fold and cook briefly.','pan',null,'core'),
('skyr_with_cherries_almonds','Skyr met kersen & amandel','Skyr with cherries & almonds',ARRAY['breakfast','snack'],ARRAY['cut','maintain'],'[{"slug":"skyr","g":200},{"slug":"cherries","g":80},{"slug":"almonds","g":10}]'::jsonb,ARRAY['sport','high_protein','vegetarian']::text[],ARRAY[]::text[],'1. Schep de skyr in een kom.
2. Ontpit de kersen en verdeel erover.
3. Strooi grof gehakte amandelen erover.','1. Spoon the skyr into a bowl.
2. Pit the cherries and scatter over.
3. Scatter roughly chopped almonds over.','assembly',null,'core'),
('oatmeal_with_milk_banana_pumpkin_seeds','Havermout met melk, banaan & pompoenpit','Oatmeal with milk, banana & pumpkin seeds',ARRAY['breakfast'],ARRAY['maintain'],'[{"slug":"oats","g":70},{"slug":"milk_semi","g":250},{"slug":"banana","g":80},{"slug":"pumpkin_seeds","g":10}]'::jsonb,ARRAY['sport','vegetarian']::text[],ARRAY[]::text[],'1. Breng de havermout met de melk al roerend aan de kook en gaar 3–4 min.
2. Top met schijfjes banaan.
3. Strooi de pompoenpitten erover.','1. Bring the oats and milk to a simmer, stirring, and cook 3–4 min.
2. Top with banana slices.
3. Scatter the pumpkin seeds over.','pan',null,'core'),
('wholegrain_bread_with_egg_avocado_rocket','Volkorenbrood met ei, avocado & rucola','Wholegrain bread with egg, avocado & rocket',ARRAY['breakfast','lunch'],ARRAY['maintain'],'[{"slug":"bread_whole","g":80},{"slug":"egg","g":55},{"slug":"avocado","g":45},{"slug":"rocket","g":20}]'::jsonb,ARRAY['sport','vegetarian']::text[],ARRAY[]::text[],'1. Rooster het volkorenbrood.
2. Prak de avocado met citroen en peper erop.
3. Leg een gepocheerd ei en wat rucola erop.','1. Toast the wholegrain bread.
2. Mash the avocado with lemon and pepper on top.
3. Top with a poached egg and some rocket.','pan',null,'core'),
('quark_smoothie_bowl_with_mixed_berries_granola','Kwark-smoothiebowl met bosvruchten & granola','Quark smoothie bowl with mixed berries & granola',ARRAY['breakfast'],ARRAY['maintain'],'[{"slug":"quark_lowfat","g":200},{"slug":"mixed_berries","g":100},{"slug":"banana","g":60},{"slug":"granola","g":25}]'::jsonb,ARRAY['sport','vegetarian']::text[],ARRAY[]::text[],'1. Mix de kwark, bosvruchten en banaan tot een dikke smoothie.
2. Schep in een kom.
3. Strooi de granola erover.','1. Blend the quark, mixed berries and banana into a thick smoothie.
2. Spoon into a bowl.
3. Scatter the granola over.','blender',null,'core'),
('vegan_oatmeal_with_oat_milk_apple_cinnamon','Vegan havermout met havermelk, appel & kaneel','Vegan oatmeal with oat milk, apple & cinnamon',ARRAY['breakfast'],ARRAY['maintain'],'[{"slug":"oats","g":70},{"slug":"oat_milk","g":250},{"slug":"apple","g":100},{"slug":"walnuts","g":10}]'::jsonb,ARRAY['sport','vegetarian','vegan']::text[],ARRAY[]::text[],'1. Breng de havermout met de havermelk aan de kook en gaar 3–4 min.
2. Roer er een snuf kaneel door.
3. Top met blokjes appel en walnoot.','1. Bring the oats and oat milk to a simmer and cook 3–4 min.
2. Stir in a pinch of cinnamon.
3. Top with diced apple and walnut.','pan',null,'core'),
('green_shakshuka_with_spinach_egg','Spinazie-ei shakshuka verde','Green shakshuka with spinach & egg',ARRAY['breakfast','lunch'],ARRAY['maintain'],'[{"slug":"egg","g":120},{"slug":"spinach","g":100},{"slug":"onion","g":40},{"slug":"bread_whole","g":60},{"slug":"feta_light","g":25}]'::jsonb,ARRAY['sport','vegetarian']::text[],ARRAY[]::text[],'1. Fruit de ui, voeg veel spinazie toe tot geslonken.
2. Maak kuiltjes en breek de eieren erin; dek af tot het eiwit stolt.
3. Verkruimel de feta erover en serveer met het brood.','1. Sweat the onion, add plenty of spinach until wilted.
2. Make wells and crack the eggs in; cover until the whites set.
3. Crumble the feta over and serve with the bread.','pan',null,'core'),
('wholegrain_banana_pancake_with_quark_walnut','Volkoren bananenpannenkoek met kwark & walnoot','Wholegrain banana pancake with quark & walnut',ARRAY['breakfast'],ARRAY['maintain'],'[{"slug":"oats","g":50},{"slug":"banana","g":70},{"slug":"egg","g":50},{"slug":"egg_white","g":60},{"slug":"quark_lowfat","g":80}]'::jsonb,ARRAY['sport','vegetarian']::text[],ARRAY[]::text[],'1. Pureer de havermout, banaan, het ei en eiwit tot beslag.
2. Bak er pannenkoekjes van.
3. Serveer met een lepel kwark en walnoot.','1. Blend the oats, banana, egg and egg white into a batter.
2. Cook pancakes.
3. Serve with a spoon of quark and walnut.','pan',null,'core'),
('trout_salad_with_potato_green_beans_mustard_dressing','Forelsalade met aardappel, haricots & mosterddressing','Trout salad with potato, green beans & mustard dressing',ARRAY['lunch','dinner'],ARRAY['cut','maintain'],'[{"slug":"trout","g":130},{"slug":"potato","g":180},{"slug":"green_beans","g":120},{"slug":"yoghurt_lowfat","g":40},{"slug":"mustard","g":5}]'::jsonb,ARRAY['sport','high_protein']::text[],ARRAY[]::text[],'1. Kook de aardappels en sperziebonen beetgaar; gaar de forel kort.
2. Roer een dressing van yoghurt, mosterd en citroen.
3. Pluk de forel in stukken en meng alles met de dressing.','1. Boil the potatoes and green beans; cook the trout briefly.
2. Stir a dressing of yoghurt, mustard and lemon.
3. Flake the trout and toss everything with the dressing.','pan',null,'core'),
('pasta_salad_with_feta_olive_cucumber_tomato','Pastasalade met feta, olijf, komkommer & tomaat','Pasta salad with feta, olive, cucumber & tomato',ARRAY['lunch'],ARRAY['maintain'],'[{"slug":"pasta_whole","g":70},{"slug":"feta_light","g":40},{"slug":"olives","g":20},{"slug":"cucumber","g":80},{"slug":"tomato","g":80}]'::jsonb,ARRAY['sport','vegetarian']::text[],ARRAY[]::text[],'1. Kook de volkoren pasta beetgaar en spoel koud.
2. Meng met komkommer, tomaat en olijven.
3. Verkruimel de feta erover en maak aan met citroen, oregano en peper.','1. Cook the wholegrain pasta al dente and rinse cold.
2. Mix with cucumber, tomato and olives.
3. Crumble the feta over and dress with lemon, oregano and pepper.','pan',null,'core'),
('chicken_pita_with_harissa_lettuce_yoghurt','Kip-pita met harissa, sla & yoghurt','Chicken pita with harissa, lettuce & yoghurt',ARRAY['lunch'],ARRAY['cut','maintain'],'[{"slug":"pita_whole","g":60},{"slug":"chicken_breast","g":140},{"slug":"harissa","g":12},{"slug":"lettuce","g":30},{"slug":"yoghurt_lowfat","g":40}]'::jsonb,ARRAY['sport','high_protein']::text[],ARRAY[]::text[],'1. Bak de kipreepjes met wat harissa.
2. Roer een frisse yoghurtsaus met citroen.
3. Vul de warme pita met sla, kip en de yoghurtsaus.','1. Fry the chicken strips with a little harissa.
2. Stir a fresh yoghurt sauce with lemon.
3. Fill the warm pita with lettuce, chicken and the yoghurt sauce.','pan',null,'core'),
('lentil_beetroot_salad_with_walnut_feta','Linzen-bietensalade met walnoot & feta','Lentil-beetroot salad with walnut & feta',ARRAY['lunch'],ARRAY['maintain'],'[{"slug":"lentils","g":160},{"slug":"beetroot","g":100},{"slug":"feta_light","g":30},{"slug":"rocket","g":30},{"slug":"walnuts","g":10}]'::jsonb,ARRAY['sport','vegetarian']::text[],ARRAY[]::text[],'1. Meng de gekookte linzen met blokjes rode biet en rucola.
2. Verkruimel de feta erover en strooi walnoten erop.
3. Maak aan met citroen, mosterd en peper.','1. Mix the cooked lentils with diced beetroot and rocket.
2. Crumble the feta over and scatter walnuts on top.
3. Dress with lemon, mustard and pepper.','pan',null,'core'),
('spanish_pintxos_plate_with_egg_tuna_pepper','Spaanse pintxos-bord met ei, tonijn & paprika','Spanish pintxos plate with egg, tuna & pepper',ARRAY['lunch'],ARRAY['cut','maintain'],'[{"slug":"bread_whole","g":70},{"slug":"tuna_can","g":80},{"slug":"egg","g":55},{"slug":"paprika","g":60},{"slug":"olives","g":15}]'::jsonb,ARRAY['sport','high_protein']::text[],ARRAY[]::text[],'1. Kook het ei en snijd in plakjes.
2. Rooster plakjes volkorenbrood.
3. Beleg met tonijn, ei, geroosterde paprika en een olijf; prik vast met een stokje.','1. Boil the egg and slice.
2. Toast slices of wholegrain bread.
3. Top with tuna, egg, roasted pepper and an olive; secure with a stick.','pan',null,'core'),
('baba_ganoush_mezze_with_bulgur','Baba ganoush-mezze met bulgur','Baba ganoush mezze with bulgur',ARRAY['lunch'],ARRAY['maintain'],'[{"slug":"eggplant","g":150},{"slug":"bulgur","g":55},{"slug":"chickpeas","g":80},{"slug":"tomato","g":60},{"slug":"olive_oil","g":6}]'::jsonb,ARRAY['sport','vegetarian','vegan']::text[],ARRAY[]::text[],'1. Rooster de aubergine tot zacht en pureer met knoflook, citroen en olijfolie tot baba ganoush.
2. Kook de bulgur gaar.
3. Schik met de kikkererwten en tomaat en lepel de baba ganoush erbij.','1. Roast the eggplant until soft and blend with garlic, lemon and olive oil into baba ganoush.
2. Cook the bulgur.
3. Arrange with the chickpeas and tomato and spoon the baba ganoush alongside.','oven',null,'core'),
('chicken_mango_avocado_salad','Kip-mango-avocadosalade','Chicken, mango & avocado salad',ARRAY['lunch'],ARRAY['cut','maintain'],'[{"slug":"chicken_breast","g":130},{"slug":"mango","g":80},{"slug":"avocado","g":40},{"slug":"lettuce","g":60},{"slug":"cucumber","g":50}]'::jsonb,ARRAY['sport','high_protein']::text[],ARRAY[]::text[],'1. Gril de kipfilet en snijd in reepjes.
2. Meng de sla met blokjes mango, avocado en komkommer.
3. Leg de kip erop en maak aan met limoen, peper en zout.','1. Grill the chicken and slice.
2. Toss the lettuce with diced mango, avocado and cucumber.
3. Top with the chicken and dress with lime, salt and pepper.','pan',null,'core'),
('rice_salad_with_edamame_corn_tofu','Rijstsalade met edamame, mais & tofu','Rice salad with edamame, corn & tofu',ARRAY['lunch'],ARRAY['maintain'],'[{"slug":"tofu","g":140},{"slug":"rice_dry","g":60},{"slug":"edamame","g":60},{"slug":"corn","g":60},{"slug":"soy_sauce","g":10}]'::jsonb,ARRAY['sport','vegetarian','vegan']::text[],ARRAY[]::text[],'1. Kook de rijst en laat afkoelen.
2. Bak de tofublokjes goudbruin.
3. Meng de rijst met edamame, mais en tofu en besprenkel met sojasaus, limoen en sesam.','1. Cook the rice and let cool.
2. Fry the tofu cubes until golden.
3. Mix the rice with edamame, corn and tofu and drizzle with soy sauce, lime and sesame.','pan',null,'core'),
('turkey_club_salad_with_egg_tomato','Kalkoen-clubsalade met ei & tomaat','Turkey club salad with egg & tomato',ARRAY['lunch'],ARRAY['cut','maintain'],'[{"slug":"turkey_breast","g":120},{"slug":"lettuce","g":80},{"slug":"egg","g":55},{"slug":"tomato","g":60},{"slug":"bread_whole","g":40}]'::jsonb,ARRAY['sport','high_protein']::text[],ARRAY[]::text[],'1. Kook het ei en halveer; rooster blokjes brood tot croutons.
2. Schik de sla met de kalkoen, tomaat en ei.
3. Werk af met een yoghurt-mosterddressing en de croutons.','1. Boil the egg and halve; toast diced bread into croutons.
2. Arrange the lettuce with the turkey, tomato and egg.
3. Finish with a yoghurt-mustard dressing and the croutons.','pan',null,'core'),
('soto_ayam_indonesian_chicken_soup_with_rice','Soto ayam — Indonesische kippensoep met rijst','Soto ayam — Indonesian chicken soup with rice',ARRAY['lunch','dinner'],ARRAY['cut','maintain'],'[{"slug":"chicken_breast","g":120},{"slug":"rice_dry","g":55},{"slug":"bean_sprouts","g":60},{"slug":"carrot","g":50},{"slug":"egg","g":55}]'::jsonb,ARRAY['sport','high_protein']::text[],ARRAY[]::text[],'1. Trek een gele bouillon met kurkuma, gember en knoflook.
2. Gaar de kip erin en pluk ''m fijn; kook de rijst apart.
3. Serveer de bouillon met rijst, kip, taugé en een halve gekookt ei.','1. Make a yellow broth with turmeric, ginger and garlic.
2. Poach the chicken in it and shred; cook the rice separately.
3. Serve the broth with rice, chicken, bean sprouts and half a boiled egg.','soup',null,'core'),
('caprese_salad_with_mozzarella_tomato_basil','Caprese-salade met mozzarella, tomaat & basilicum','Caprese salad with mozzarella, tomato & basil',ARRAY['lunch'],ARRAY['maintain'],'[{"slug":"mozzarella_light","g":80},{"slug":"tomato","g":150},{"slug":"bread_whole","g":50},{"slug":"olive_oil","g":6}]'::jsonb,ARRAY['sport','vegetarian']::text[],ARRAY[]::text[],'1. Snijd de tomaat en mozzarella in plakken en leg dakpansgewijs.
2. Besprenkel met olijfolie, peper en verse basilicum.
3. Serveer met geroosterd volkorenbrood.','1. Slice the tomato and mozzarella and arrange overlapping.
2. Drizzle with olive oil, pepper and fresh basil.
3. Serve with toasted wholegrain bread.','pan',null,'core'),
('grilled_trout_with_potato_fennel','Gegrilde forel met aardappel & venkel','Grilled trout with potato & fennel',ARRAY['dinner'],ARRAY['cut','maintain'],'[{"slug":"trout","g":160},{"slug":"potato","g":220},{"slug":"fennel","g":120},{"slug":"olive_oil","g":6}]'::jsonb,ARRAY['sport','high_protein']::text[],ARRAY[]::text[],'1. Rooster de venkel en aardappel met olijfolie 22 min op 200°C.
2. Gril of bak de forel 3–4 min per kant met citroen.
3. Serveer samen met wat venkelgroen.','1. Roast the fennel and potato with olive oil 22 min at 200°C.
2. Grill or pan-fry the trout 3–4 min per side with lemon.
3. Serve together with some fennel fronds.','oven',null,'core'),
('mussels_in_tomato_garlic_broth_with_bread','Mosselen in tomaten-knoflookbouillon met brood','Mussels in tomato-garlic broth with bread',ARRAY['dinner'],ARRAY['cut','maintain'],'[{"slug":"mussels","g":300},{"slug":"passata","g":120},{"slug":"onion","g":50},{"slug":"bread_whole","g":70},{"slug":"olive_oil","g":5}]'::jsonb,ARRAY['sport','high_protein']::text[],ARRAY[]::text[],'1. Fruit de ui en knoflook in de olijfolie, voeg passata en een scheut water toe.
2. Doe de schoongemaakte mosselen erin, dek af en stoom 5–6 min tot ze open zijn.
3. Werk af met peterselie en serveer met het brood om te dippen.','1. Sweat the onion and garlic in the olive oil, add passata and a splash of water.
2. Add the cleaned mussels, cover and steam 5–6 min until open.
3. Finish with parsley and serve with the bread to dip.','soup',null,'core'),
('persian_chicken_with_saffron_rice_pomegranate','Perzische kip met saffraanrijst & granaatappel','Persian chicken with saffron rice & pomegranate',ARRAY['dinner'],ARRAY['cut','maintain'],'[{"slug":"chicken_breast","g":150},{"slug":"rice_dry","g":65},{"slug":"pomegranate","g":50},{"slug":"yoghurt_lowfat","g":40},{"slug":"onion","g":40}]'::jsonb,ARRAY['sport','high_protein']::text[],ARRAY[]::text[],'1. Kook de rijst met een snuf saffraan.
2. Bak de kip met ui en wat kaneel gaar.
3. Serveer met een lepel yoghurt en granaatappelpitjes.','1. Cook the rice with a pinch of saffron.
2. Fry the chicken with onion and a little cinnamon.
3. Serve with a spoon of yoghurt and pomegranate seeds.','pan',null,'core'),
('ethiopian_misir_wot_lentils_with_rice','Ethiopische misir wot (linzen) met rijst','Ethiopian misir wot (lentils) with rice',ARRAY['dinner'],ARRAY['maintain'],'[{"slug":"lentils","g":200},{"slug":"rice_dry","g":60},{"slug":"passata","g":120},{"slug":"onion","g":50},{"slug":"curry_paste","g":15}]'::jsonb,ARRAY['sport','vegetarian','vegan']::text[],ARRAY[]::text[],'1. Kook de rijst gaar.
2. Fruit de ui met berbere-kruiden (of currypasta), voeg de linzen en passata toe.
3. Laat 15 min pruttelen tot een dikke stoof en serveer over de rijst.','1. Cook the rice.
2. Fry the onion with berbere spice (or curry paste), add the lentils and passata.
3. Simmer 15 min into a thick stew and serve over the rice.','pan',null,'core'),
('oven_chicken_schnitzel_with_potato_salad','Kip-schnitzel uit de oven met aardappelsalade','Oven chicken schnitzel with potato salad',ARRAY['dinner'],ARRAY['cut','maintain'],'[{"slug":"chicken_breast","g":150},{"slug":"bread_whole","g":30},{"slug":"potato","g":200},{"slug":"yoghurt_lowfat","g":40},{"slug":"cucumber","g":50}]'::jsonb,ARRAY['sport','high_protein']::text[],ARRAY[]::text[],'1. Paneer de platgeslagen kipfilet met verkruimeld volkorenbrood en bak 20 min krokant op 200°C.
2. Kook de aardappels en laat afkoelen.
3. Meng de aardappel met yoghurt, mosterd, komkommer en bieslook tot salade.','1. Coat the flattened chicken with crushed wholegrain bread and bake 20 min crisp at 200°C.
2. Boil the potatoes and let cool.
3. Mix the potato with yoghurt, mustard, cucumber and chives into a salad.','oven',null,'core'),
('spanish_chicken_with_pepper_tomato_rice','Spaanse kip met paprika, tomaat & rijst','Spanish chicken with pepper, tomato & rice',ARRAY['dinner'],ARRAY['maintain'],'[{"slug":"chicken_thigh","g":150},{"slug":"rice_dry","g":65},{"slug":"paprika","g":100},{"slug":"passata","g":100},{"slug":"onion","g":40}]'::jsonb,ARRAY['sport']::text[],ARRAY[]::text[],'1. Kook de rijst gaar.
2. Bak de kipdij aan, voeg ui, paprika en passata toe met paprikapoeder.
3. Laat 12 min stoven en serveer over de rijst.','1. Cook the rice.
2. Sear the chicken thigh, add onion, pepper and passata with paprika.
3. Stew 12 min and serve over the rice.','pan',null,'core'),
('gyudon_japanese_beef_onion_on_rice','Gyudon — Japanse rund-ui op rijst','Gyudon — Japanese beef & onion on rice',ARRAY['dinner'],ARRAY['cut','gain','maintain'],'[{"slug":"beef_lean","g":140},{"slug":"rice_dry","g":65},{"slug":"onion","g":80},{"slug":"soy_sauce","g":15},{"slug":"egg","g":55}]'::jsonb,ARRAY['sport','high_protein']::text[],ARRAY[]::text[],'1. Kook de rijst gaar.
2. Sudder dungesneden rundvlees met ui in sojasaus, dashi en wat honing.
3. Schep over de rijst en leg een zacht gekookt ei erop.','1. Cook the rice.
2. Simmer thinly sliced beef with onion in soy sauce, dashi and a little honey.
3. Spoon over the rice and top with a soft-boiled egg.','pan',null,'core'),
('bibimbap_with_tofu_vegetables','Bibimbap met tofu & groente','Bibimbap with tofu & vegetables',ARRAY['dinner'],ARRAY['maintain'],'[{"slug":"tofu","g":160},{"slug":"rice_dry","g":65},{"slug":"spinach","g":60},{"slug":"carrot","g":50},{"slug":"gochujang","g":20}]'::jsonb,ARRAY['sport','vegetarian','vegan']::text[],ARRAY[]::text[],'1. Kook de rijst gaar.
2. Bak de tofublokjes goudbruin; blancheer de spinazie en wortel apart.
3. Schik over de rijst en serveer met de gochujang.','1. Cook the rice.
2. Fry the tofu until golden; blanch the spinach and carrot separately.
3. Arrange over the rice and serve with the gochujang.','pan',null,'core'),
('sweet_potato_chili_with_beef','Zoete-aardappel-chili met rund','Sweet potato chili with beef',ARRAY['dinner'],ARRAY['cut','gain','maintain'],'[{"slug":"beef_mince5","g":140},{"slug":"sweet_potato","g":180},{"slug":"kidney_beans","g":120},{"slug":"passata","g":120},{"slug":"corn","g":50}]'::jsonb,ARRAY['sport','high_protein']::text[],ARRAY[]::text[],'1. Rul het gehakt, voeg blokjes zoete aardappel, passata, bonen en mais toe met komijn en chili.
2. Laat 20 min pruttelen tot de zoete aardappel gaar is.
3. Werk af met koriander.','1. Brown the mince, add diced sweet potato, passata, beans and corn with cumin and chili.
2. Simmer 20 min until the sweet potato is done.
3. Finish with coriander.','pan',null,'core'),
('thai_green_curry_with_chicken_eggplant','Thaise groene curry met kip & aubergine','Thai green curry with chicken & eggplant',ARRAY['dinner'],ARRAY['cut','maintain'],'[{"slug":"chicken_breast","g":150},{"slug":"rice_dry","g":65},{"slug":"coconut_light","g":80},{"slug":"eggplant","g":100},{"slug":"curry_paste","g":20}]'::jsonb,ARRAY['sport','high_protein']::text[],ARRAY[]::text[],'1. Kook de rijst gaar.
2. Bak de groene currypasta kort, voeg de kip en aubergine toe.
3. Blus met kokosmelk, laat 10 min pruttelen en werk af met Thaise basilicum.','1. Cook the rice.
2. Fry the green curry paste briefly, add the chicken and eggplant.
3. Add coconut milk, simmer 10 min and finish with Thai basil.','pan',null,'core'),
('light_pho_with_beef_rice_noodles','Pho light met rund & rijstnoedels','Light pho with beef & rice noodles',ARRAY['dinner'],ARRAY['maintain'],'[{"slug":"beef_lean","g":120},{"slug":"rice_noodles","g":55},{"slug":"bean_sprouts","g":60},{"slug":"carrot","g":40},{"slug":"soy_sauce","g":12}]'::jsonb,ARRAY['sport']::text[],ARRAY[]::text[],'1. Trek een heldere bouillon met gember, kaneel en steranijs.
2. Week de rijstnoedels gaar en verdeel in een kom met taugé.
3. Leg dunne plakjes rauw rundvlees erop en overgiet met de hete bouillon; werk af met limoen en kruiden.','1. Make a clear broth with ginger, cinnamon and star anise.
2. Soak the rice noodles and divide into a bowl with bean sprouts.
3. Lay thin slices of raw beef on top and pour over the hot broth; finish with lime and herbs.','soup',null,'core'),
('palak_with_chickpea_spinach','Palak met kikkererwt & spinazie','Palak with chickpea & spinach',ARRAY['dinner'],ARRAY['gain','maintain'],'[{"slug":"chickpeas","g":180},{"slug":"rice_dry","g":60},{"slug":"spinach","g":120},{"slug":"onion","g":40},{"slug":"curry_paste","g":15}]'::jsonb,ARRAY['sport','vegetarian','vegan']::text[],ARRAY[]::text[],'1. Kook de rijst gaar.
2. Fruit de ui met de currypasta, pureer de spinazie erdoor tot een groene saus.
3. Roer de kikkererwten erdoor en laat 8 min pruttelen; serveer over de rijst.','1. Cook the rice.
2. Fry the onion with the curry paste, blend the spinach through into a green sauce.
3. Stir the chickpeas through and simmer 8 min; serve over the rice.','pan',null,'core'),
('light_chicken_parmigiana_with_wholegrain_pasta','Kip-parmigiana light met volkoren pasta','Light chicken parmigiana with wholegrain pasta',ARRAY['dinner'],ARRAY['cut','gain','maintain'],'[{"slug":"chicken_breast","g":150},{"slug":"pasta_whole","g":70},{"slug":"passata","g":150},{"slug":"mozzarella_light","g":40},{"slug":"onion","g":40}]'::jsonb,ARRAY['sport','high_protein']::text[],ARRAY[]::text[],'1. Kook de volkoren pasta beetgaar.
2. Bak de kipfilet aan, leg in een schaal met passata en mozzarella en gratineer 12 min op 200°C.
3. Serveer op de pasta met basilicum.','1. Cook the wholegrain pasta al dente.
2. Sear the chicken, place in a dish with passata and mozzarella and bake 12 min at 200°C.
3. Serve on the pasta with basil.','oven',null,'core'),
('salmon_with_dill_mustard_potato_peas','Zalm met dille-mosterd, aardappel & doperwten','Salmon with dill-mustard, potato & peas',ARRAY['dinner'],ARRAY['gain','maintain'],'[{"slug":"salmon","g":140},{"slug":"potato","g":220},{"slug":"peas","g":120},{"slug":"mustard","g":8},{"slug":"yoghurt_lowfat","g":30}]'::jsonb,ARRAY['sport']::text[],ARRAY[]::text[],'1. Kook de aardappels en doperwten.
2. Bak de zalm gaar.
3. Roer een saus van yoghurt, mosterd, dille en citroen en lepel over de zalm.','1. Boil the potatoes and peas.
2. Cook the salmon.
3. Stir a sauce of yoghurt, mustard, dill and lemon and spoon over the salmon.','pan',null,'core'),
('sous_vide_steak_54_c_with_light_pepper_sauce_vegetables','Biefstuk sous-vide 54°C met pepersaus light & groente','Sous-vide steak 54°C with light pepper sauce & vegetables',ARRAY['dinner'],ARRAY['cut','maintain'],'[{"slug":"beef_lean","g":150},{"slug":"potato","g":200},{"slug":"green_beans","g":120},{"slug":"milk_semi","g":50}]'::jsonb,ARRAY['sport','high_protein','sousvide']::text[],ARRAY[]::text[],'1. Vacumeer de biefstuk en gaar sous-vide op 54°C (1,5–4 u).
2. Maak een lichte pepersaus met melk, bouillon en gebroken peper.
3. Schroei de biefstuk kort, serveer met aardappel, sperziebonen en de saus.','1. Vacuum-seal the steak and cook sous-vide at 54°C (1.5–4 h).
2. Make a light pepper sauce with milk, stock and cracked pepper.
3. Sear the steak briefly, serve with potato, green beans and the sauce.','sousvide','54°C','core'),
('sous_vide_chicken_63_c_with_bulgur_roasted_vegetables','Kip sous-vide 63°C met bulgur & geroosterde groente','Sous-vide chicken 63°C with bulgur & roasted vegetables',ARRAY['dinner'],ARRAY['cut','maintain'],'[{"slug":"chicken_breast","g":160},{"slug":"bulgur","g":60},{"slug":"paprika","g":80},{"slug":"zucchini","g":80},{"slug":"olive_oil","g":5}]'::jsonb,ARRAY['sport','high_protein','sousvide']::text[],ARRAY[]::text[],'1. Vacumeer de kipfilet en gaar sous-vide op 63°C (1,5–4 u).
2. Kook de bulgur gaar en rooster de paprika en courgette.
3. Schroei de kip kort aan en serveer op de bulgur met de groente.','1. Vacuum-seal the chicken and cook sous-vide at 63°C (1.5–4 h).
2. Cook the bulgur and roast the pepper and zucchini.
3. Sear the chicken briefly and serve on the bulgur with the vegetables.','sousvide','63°C','core'),
('light_tofu_rendang_with_rice','Tofu-rendang light met rijst','Light tofu rendang with rice',ARRAY['dinner'],ARRAY['maintain'],'[{"slug":"tofu","g":180},{"slug":"rice_dry","g":65},{"slug":"coconut_light","g":80},{"slug":"onion","g":40},{"slug":"curry_paste","g":20}]'::jsonb,ARRAY['sport','vegetarian','vegan']::text[],ARRAY[]::text[],'1. Kook de rijst gaar.
2. Bak de tofublokjes goudbruin, voeg ui, currypasta en kokosmelk toe.
3. Laat zachtjes inkoken tot een dikke, kruidige saus en serveer over de rijst.','1. Cook the rice.
2. Fry the tofu until golden, add onion, curry paste and coconut milk.
3. Reduce gently into a thick, spiced sauce and serve over the rice.','pan',null,'core'),
('skyr_with_pomegranate_pumpkin_seeds','Skyr met granaatappel & pompoenpit','Skyr with pomegranate & pumpkin seeds',ARRAY['snack'],ARRAY['cut','maintain'],'[{"slug":"skyr","g":150},{"slug":"pomegranate","g":50},{"slug":"pumpkin_seeds","g":10}]'::jsonb,ARRAY['sport','high_protein','vegetarian']::text[],ARRAY[]::text[],'1. Schep de skyr in een kom.
2. Top met granaatappelpitjes en pompoenpitten.','1. Spoon the skyr into a bowl.
2. Top with pomegranate seeds and pumpkin seeds.','assembly',null,'core'),
('melon_with_lean_ham','Meloen met magere ham','Melon with lean ham',ARRAY['snack'],ARRAY['cut','maintain'],'[{"slug":"melon","g":150},{"slug":"ham_lean","g":40}]'::jsonb,ARRAY['sport','high_protein']::text[],ARRAY[]::text[],'1. Snijd de meloen in partjes.
2. Wikkel er dunne plakjes magere ham omheen.','1. Slice the melon into wedges.
2. Wrap thin slices of lean ham around them.','assembly',null,'core'),
('quark_with_cherries_almonds','Kwark met kersen & amandel','Quark with cherries & almonds',ARRAY['snack'],ARRAY['cut','maintain'],'[{"slug":"quark_lowfat","g":150},{"slug":"cherries","g":70},{"slug":"almonds","g":10}]'::jsonb,ARRAY['sport','high_protein','vegetarian']::text[],ARRAY[]::text[],'1. Schep de kwark in een kom.
2. Ontpit de kersen en verdeel met de amandelen erover.','1. Spoon the quark into a bowl.
2. Pit the cherries and scatter with the almonds over.','assembly',null,'core'),
('wholegrain_crackers_with_tuna_cucumber','Volkoren crackers met tonijn & komkommer','Wholegrain crackers with tuna & cucumber',ARRAY['snack'],ARRAY['cut','maintain'],'[{"slug":"crackers_whole","g":24},{"slug":"tuna_can","g":60},{"slug":"cucumber","g":40}]'::jsonb,ARRAY['sport','high_protein']::text[],ARRAY[]::text[],'1. Meng de tonijn met wat peper en citroen.
2. Verdeel over de crackers en beleg met komkommer.','1. Mix the tuna with some pepper and lemon.
2. Spread over the crackers and top with cucumber.','assembly',null,'core'),
('rice_cakes_with_almond_butter_banana','Rijstwafels met amandelpasta & banaan','Rice cakes with almond butter & banana',ARRAY['snack'],ARRAY['maintain'],'[{"slug":"rice_cakes","g":26},{"slug":"almond_butter","g":15},{"slug":"banana","g":60}]'::jsonb,ARRAY['sport','vegetarian','vegan']::text[],ARRAY[]::text[],'1. Besmeer de rijstwafels dun met amandelpasta.
2. Beleg met schijfjes banaan.','1. Spread the rice cakes thinly with almond butter.
2. Top with banana slices.','assembly',null,'core'),
('cottage_cheese_with_tomato_chives','Hüttenkäse met tomaat & bieslook','Cottage cheese with tomato & chives',ARRAY['snack'],ARRAY['cut','maintain'],'[{"slug":"cottage","g":150},{"slug":"cherry_tomato","g":60}]'::jsonb,ARRAY['sport','high_protein','vegetarian']::text[],ARRAY[]::text[],'1. Schep de hüttenkäse in een kom.
2. Meng er gehalveerde cherrytomaat door en werk af met bieslook en peper.','1. Spoon the cottage cheese into a bowl.
2. Mix in halved cherry tomato and finish with chives and pepper.','assembly',null,'core'),
('apple_with_walnut_cinnamon','Appel met walnoot & kaneel','Apple with walnut & cinnamon',ARRAY['snack'],ARRAY['maintain'],'[{"slug":"apple","g":150},{"slug":"walnuts","g":12}]'::jsonb,ARRAY['sport','vegetarian','vegan']::text[],ARRAY[]::text[],'1. Snijd de appel in partjes.
2. Bestrooi met kaneel en serveer met grof gehakte walnoten.','1. Slice the apple into wedges.
2. Dust with cinnamon and serve with roughly chopped walnuts.','assembly',null,'core'),
('melon_with_quark_mint','Meloen met kwark & munt','Melon with quark & mint',ARRAY['snack'],ARRAY['cut','maintain'],'[{"slug":"melon","g":150},{"slug":"quark_lowfat","g":100}]'::jsonb,ARRAY['sport','high_protein','vegetarian']::text[],ARRAY[]::text[],'1. Snijd de meloen in blokjes.
2. Serveer met een lepel kwark en wat verse munt.','1. Cube the melon.
2. Serve with a spoon of quark and some fresh mint.','assembly',null,'core')
on conflict (slug) do update set name_nl=excluded.name_nl,name_en=excluded.name_en,moments=excluded.moments,goals=excluded.goals,items=excluded.items,tags=excluded.tags,prefs=excluded.prefs,steps=excluded.steps,steps_en=excluded.steps_en,technique=excluded.technique,temp=excluded.temp;
commit;
