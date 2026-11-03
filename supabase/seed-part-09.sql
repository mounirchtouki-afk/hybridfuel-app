-- AUTO-GEGENEREERD core-seed deel 9/9 (33 gerechten). Draai NA dish-library.sql.
-- Draai de delen op volgorde (01, 02, ...). Elk deel is los veilig (upsert).
begin;
insert into public.dishes (slug,name_nl,name_en,moments,goals,items,tags,prefs,steps,steps_en,technique,temp,source) values
('wholegrain_toast_with_peanut_butter_banana','Volkoren toast met pindakaas & banaan','Wholegrain toast with peanut butter & banana',ARRAY['breakfast'],ARRAY['maintain'],'[{"slug":"bread_whole","g":70},{"slug":"peanut_butter","g":20},{"slug":"banana","g":80}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY['wholebread']::text[],'1. Rooster of snijd het brood.
2. Beleg met je topping.
3. Breng op smaak met peper en zout.','1. Toast or slice the bread.
2. Top with your topping.
3. Season with salt and pepper.','assembly',null,'core'),
('wholegrain_toast_with_hummus_egg','Volkoren toast met hummus & ei','Wholegrain toast with hummus & egg',ARRAY['breakfast'],ARRAY['maintain'],'[{"slug":"bread_whole","g":70},{"slug":"hummus","g":40},{"slug":"egg","g":100}]'::jsonb,ARRAY['vegetarian']::text[],ARRAY['wholebread']::text[],'1. Rooster of snijd het brood.
2. Beleg met ei.
3. Breng op smaak met peper en zout.','1. Toast or slice the bread.
2. Top with egg.
3. Season with salt and pepper.','assembly',null,'core'),
('wholegrain_toast_with_quark_strawberry','Volkoren toast met kwark & aardbei','Wholegrain toast with quark & strawberry',ARRAY['breakfast'],ARRAY['maintain'],'[{"slug":"bread_whole","g":70},{"slug":"quark_low","g":80},{"slug":"strawberries","g":60}]'::jsonb,ARRAY['vegetarian']::text[],ARRAY['wholebread']::text[],'1. Rooster of snijd het brood.
2. Beleg met je topping.
3. Breng op smaak met peper en zout.','1. Toast or slice the bread.
2. Top with your topping.
3. Season with salt and pepper.','assembly',null,'core'),
('skyr_with_banana','Skyr met banaan','Skyr with banana',ARRAY['snack'],ARRAY['cut','maintain'],'[{"slug":"skyr","g":150},{"slug":"banana","g":70}]'::jsonb,ARRAY['vegetarian','high_protein']::text[],ARRAY['quark']::text[],'1. Doe de skyr in een kom.
2. Meng of top met banaan.','1. Spoon the skyr into a bowl.
2. Mix or top with banana.','assembly',null,'core'),
('cottage_cheese_with_banana','Hüttenkäse met banaan','Cottage cheese with banana',ARRAY['snack'],ARRAY['cut','maintain'],'[{"slug":"cottage","g":150},{"slug":"banana","g":70}]'::jsonb,ARRAY['vegetarian','high_protein']::text[],ARRAY['quark']::text[],'1. Doe de hüttenkäse in een kom.
2. Meng of top met banaan.','1. Spoon the cottage cheese into a bowl.
2. Mix or top with banana.','assembly',null,'core'),
('skyr_with_blueberries','Skyr met blauwe bessen','Skyr with blueberries',ARRAY['snack'],ARRAY['cut','maintain'],'[{"slug":"skyr","g":150},{"slug":"blueberries","g":70}]'::jsonb,ARRAY['vegetarian','high_protein']::text[],ARRAY['quark']::text[],'1. Doe de skyr in een kom.
2. Meng of top met blauwe bessen.','1. Spoon the skyr into a bowl.
2. Mix or top with blueberries.','assembly',null,'core'),
('cottage_cheese_with_blueberries','Hüttenkäse met blauwe bessen','Cottage cheese with blueberries',ARRAY['snack'],ARRAY['cut','maintain'],'[{"slug":"cottage","g":150},{"slug":"blueberries","g":70}]'::jsonb,ARRAY['vegetarian','high_protein']::text[],ARRAY['quark']::text[],'1. Doe de hüttenkäse in een kom.
2. Meng of top met blauwe bessen.','1. Spoon the cottage cheese into a bowl.
2. Mix or top with blueberries.','assembly',null,'core'),
('skyr_with_strawberries','Skyr met aardbeien','Skyr with strawberries',ARRAY['snack'],ARRAY['cut','maintain'],'[{"slug":"skyr","g":150},{"slug":"strawberries","g":70}]'::jsonb,ARRAY['vegetarian','high_protein']::text[],ARRAY['quark']::text[],'1. Doe de skyr in een kom.
2. Meng of top met aardbeien.','1. Spoon the skyr into a bowl.
2. Mix or top with strawberries.','assembly',null,'core'),
('cottage_cheese_with_strawberries','Hüttenkäse met aardbeien','Cottage cheese with strawberries',ARRAY['snack'],ARRAY['cut','maintain'],'[{"slug":"cottage","g":150},{"slug":"strawberries","g":70}]'::jsonb,ARRAY['vegetarian','high_protein']::text[],ARRAY['quark']::text[],'1. Doe de hüttenkäse in een kom.
2. Meng of top met aardbeien.','1. Spoon the cottage cheese into a bowl.
2. Mix or top with strawberries.','assembly',null,'core'),
('skyr_with_mango','Skyr met mango','Skyr with mango',ARRAY['snack'],ARRAY['cut','maintain'],'[{"slug":"skyr","g":150},{"slug":"mango","g":70}]'::jsonb,ARRAY['vegetarian','high_protein']::text[],ARRAY['quark']::text[],'1. Doe de skyr in een kom.
2. Meng of top met mango.','1. Spoon the skyr into a bowl.
2. Mix or top with mango.','assembly',null,'core'),
('cottage_cheese_with_mango','Hüttenkäse met mango','Cottage cheese with mango',ARRAY['snack'],ARRAY['cut','maintain'],'[{"slug":"cottage","g":150},{"slug":"mango","g":70}]'::jsonb,ARRAY['vegetarian','high_protein']::text[],ARRAY['quark']::text[],'1. Doe de hüttenkäse in een kom.
2. Meng of top met mango.','1. Spoon the cottage cheese into a bowl.
2. Mix or top with mango.','assembly',null,'core'),
('skyr_with_raspberries','Skyr met frambozen','Skyr with raspberries',ARRAY['snack'],ARRAY['cut','maintain'],'[{"slug":"skyr","g":150},{"slug":"raspberries","g":70}]'::jsonb,ARRAY['vegetarian','high_protein']::text[],ARRAY['quark']::text[],'1. Doe de skyr in een kom.
2. Meng of top met frambozen.','1. Spoon the skyr into a bowl.
2. Mix or top with raspberries.','assembly',null,'core'),
('cottage_cheese_with_raspberries','Hüttenkäse met frambozen','Cottage cheese with raspberries',ARRAY['snack'],ARRAY['cut','maintain'],'[{"slug":"cottage","g":150},{"slug":"raspberries","g":70}]'::jsonb,ARRAY['vegetarian','high_protein']::text[],ARRAY['quark']::text[],'1. Doe de hüttenkäse in een kom.
2. Meng of top met frambozen.','1. Spoon the cottage cheese into a bowl.
2. Mix or top with raspberries.','assembly',null,'core'),
('skyr_with_kiwi','Skyr met kiwi','Skyr with kiwi',ARRAY['snack'],ARRAY['cut','maintain'],'[{"slug":"skyr","g":150},{"slug":"kiwi","g":70}]'::jsonb,ARRAY['vegetarian','high_protein']::text[],ARRAY['quark']::text[],'1. Doe de skyr in een kom.
2. Meng of top met kiwi.','1. Spoon the skyr into a bowl.
2. Mix or top with kiwi.','assembly',null,'core'),
('cottage_cheese_with_kiwi','Hüttenkäse met kiwi','Cottage cheese with kiwi',ARRAY['snack'],ARRAY['cut','maintain'],'[{"slug":"cottage","g":150},{"slug":"kiwi","g":70}]'::jsonb,ARRAY['vegetarian','high_protein']::text[],ARRAY['quark']::text[],'1. Doe de hüttenkäse in een kom.
2. Meng of top met kiwi.','1. Spoon the cottage cheese into a bowl.
2. Mix or top with kiwi.','assembly',null,'core'),
('skyr_with_pineapple','Skyr met ananas','Skyr with pineapple',ARRAY['snack'],ARRAY['cut','maintain'],'[{"slug":"skyr","g":150},{"slug":"pineapple","g":70}]'::jsonb,ARRAY['vegetarian','high_protein']::text[],ARRAY['quark']::text[],'1. Doe de skyr in een kom.
2. Meng of top met ananas.','1. Spoon the skyr into a bowl.
2. Mix or top with pineapple.','assembly',null,'core'),
('cottage_cheese_with_pineapple','Hüttenkäse met ananas','Cottage cheese with pineapple',ARRAY['snack'],ARRAY['cut','maintain'],'[{"slug":"cottage","g":150},{"slug":"pineapple","g":70}]'::jsonb,ARRAY['vegetarian','high_protein']::text[],ARRAY['quark']::text[],'1. Doe de hüttenkäse in een kom.
2. Meng of top met ananas.','1. Spoon the cottage cheese into a bowl.
2. Mix or top with pineapple.','assembly',null,'core'),
('protein_bar','Proteïnereep','Protein bar',ARRAY['snack'],ARRAY['cut','maintain'],'[{"slug":"protein_bar","g":60}]'::jsonb,ARRAY['vegetarian','high_protein']::text[],ARRAY['bar']::text[],'1. Pak de proteïnereep als snack onderweg.','1. Grab the protein bar as an on-the-go snack.','assembly',null,'core'),
('edamame_with_sea_salt','Edamame met zeezout','Edamame with sea salt',ARRAY['snack'],ARRAY['cut','maintain'],'[{"slug":"edamame","g":150}]'::jsonb,ARRAY['vegetarian','vegan','high_protein']::text[],ARRAY[]::text[],'1. Kook of stoom de edamame 4–5 min.
2. Bestrooi met een snuf zeezout.','1. Boil or steam the edamame 4–5 min.
2. Sprinkle with a pinch of sea salt.','pan',null,'core'),
('dark_chocolate_with_almonds','Pure chocolade met amandelen','Dark chocolate with almonds',ARRAY['snack'],ARRAY['maintain'],'[{"slug":"dark_choc","g":20},{"slug":"almonds","g":20}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY['nuts']::text[],'1. Weeg de portie af.
2. Serveer als snack tussendoor.','1. Weigh out the portion.
2. Enjoy as a snack.','assembly',null,'core'),
('pumpkin_seeds','Pompoenpitten','Pumpkin seeds',ARRAY['snack'],ARRAY['maintain'],'[{"slug":"pumpkin_seeds","g":30}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY['nuts']::text[],'1. Weeg de portie af.
2. Serveer als snack tussendoor.','1. Weigh out the portion.
2. Enjoy as a snack.','assembly',null,'core'),
('two_boiled_eggs','Twee gekookte eieren','Two boiled eggs',ARRAY['snack'],ARRAY['cut','maintain'],'[{"slug":"egg","g":120}]'::jsonb,ARRAY['vegetarian','high_protein']::text[],ARRAY[]::text[],'1. Kook de eieren 8–9 min.
2. Pel en bestrooi met peper en zout.','1. Boil the eggs 8–9 min.
2. Peel and season with salt and pepper.','pan',null,'core'),
('roasted_chickpeas','Geroosterde kikkererwten','Roasted chickpeas',ARRAY['snack'],ARRAY['maintain'],'[{"slug":"chickpeas","g":120}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY[]::text[],'1. Bak de kikkererwten in een pan rondom gaar; kruid met peper en zout.
2. Verdeel over het bord en werk af.','1. Pan-fry the chickpeas until done; season with salt and pepper.
2. Plate up and finish.','pan',null,'core'),
('greek_yoghurt_with_granola','Griekse yoghurt met granola','Greek yoghurt with granola',ARRAY['snack'],ARRAY['maintain'],'[{"slug":"greek_yoghurt","g":150},{"slug":"granola","g":30}]'::jsonb,ARRAY['vegetarian']::text[],ARRAY[]::text[],'1. Doe de griekse yoghurt 2% in een kom.
2. Schep de granola erover.
3. Serveer direct.','1. Spoon the greek yoghurt 2% into a bowl.
2. Add the granola on top.
3. Serve.','assembly',null,'core'),
('apple_with_almonds','Appel met amandelen','Apple with almonds',ARRAY['snack'],ARRAY['maintain'],'[{"slug":"apple","g":150},{"slug":"almonds","g":20}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY['fruit']::text[],'1. Snijd appel in partjes.
2. Serveer met amandelen om in te dippen.','1. Slice the apple.
2. Serve with almonds to dip.','assembly',null,'core'),
('tomato_soup_with_chicken','Tomatensoep met kip','Tomato soup with chicken',ARRAY['lunch'],ARRAY['cut','maintain'],'[{"slug":"tomato","g":250},{"slug":"chicken_breast","g":100},{"slug":"bread_whole","g":40},{"slug":"olive_oil","g":5}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['soup']::text[],'1. Fruit de groente kort aan.
2. Voeg bouillon (en eventueel eiwit) toe en laat garen.
3. Pureer naar wens en serveer met het brood.','1. Sweat the vegetables briefly.
2. Add stock (and protein if using) and simmer.
3. Blend if you like and serve with the bread.','soup',null,'core'),
('tomato_soup_with_lentils','Tomatensoep met linzen','Tomato soup with lentils',ARRAY['lunch'],ARRAY['maintain'],'[{"slug":"tomato","g":250},{"slug":"lentils","g":120},{"slug":"bread_whole","g":40}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY['soup']::text[],'1. Fruit de groente kort aan.
2. Voeg bouillon (en eventueel eiwit) toe en laat garen.
3. Pureer naar wens en serveer met het brood.','1. Sweat the vegetables briefly.
2. Add stock (and protein if using) and simmer.
3. Blend if you like and serve with the bread.','soup',null,'core'),
('cauliflower_soup_with_chicken','Bloemkoolsoep met kip','Cauliflower soup with chicken',ARRAY['lunch'],ARRAY['cut','maintain'],'[{"slug":"cauliflower","g":250},{"slug":"chicken_breast","g":100},{"slug":"bread_whole","g":40},{"slug":"olive_oil","g":5}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['soup']::text[],'1. Fruit de groente kort aan.
2. Voeg bouillon (en eventueel eiwit) toe en laat garen.
3. Pureer naar wens en serveer met het brood.','1. Sweat the vegetables briefly.
2. Add stock (and protein if using) and simmer.
3. Blend if you like and serve with the bread.','soup',null,'core'),
('cauliflower_soup_with_lentils','Bloemkoolsoep met linzen','Cauliflower soup with lentils',ARRAY['lunch'],ARRAY['maintain'],'[{"slug":"cauliflower","g":250},{"slug":"lentils","g":120},{"slug":"bread_whole","g":40}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY['soup']::text[],'1. Fruit de groente kort aan.
2. Voeg bouillon (en eventueel eiwit) toe en laat garen.
3. Pureer naar wens en serveer met het brood.','1. Sweat the vegetables briefly.
2. Add stock (and protein if using) and simmer.
3. Blend if you like and serve with the bread.','soup',null,'core'),
('mushroom_soup_with_chicken','Champignonsoep met kip','Mushroom soup with chicken',ARRAY['lunch'],ARRAY['cut','maintain'],'[{"slug":"mushroom","g":250},{"slug":"chicken_breast","g":100},{"slug":"bread_whole","g":40},{"slug":"olive_oil","g":5}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['soup']::text[],'1. Fruit de groente kort aan.
2. Voeg bouillon (en eventueel eiwit) toe en laat garen.
3. Pureer naar wens en serveer met het brood.','1. Sweat the vegetables briefly.
2. Add stock (and protein if using) and simmer.
3. Blend if you like and serve with the bread.','soup',null,'core'),
('mushroom_soup_with_lentils','Champignonsoep met linzen','Mushroom soup with lentils',ARRAY['lunch'],ARRAY['cut','maintain'],'[{"slug":"mushroom","g":250},{"slug":"lentils","g":120},{"slug":"bread_whole","g":40}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY['soup']::text[],'1. Fruit de groente kort aan.
2. Voeg bouillon (en eventueel eiwit) toe en laat garen.
3. Pureer naar wens en serveer met het brood.','1. Sweat the vegetables briefly.
2. Add stock (and protein if using) and simmer.
3. Blend if you like and serve with the bread.','soup',null,'core'),
('carrot_soup_with_chicken','Wortelsoep met kip','Carrot soup with chicken',ARRAY['lunch'],ARRAY['cut','maintain'],'[{"slug":"carrot","g":250},{"slug":"chicken_breast","g":100},{"slug":"bread_whole","g":40},{"slug":"olive_oil","g":5}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['soup']::text[],'1. Fruit de groente kort aan.
2. Voeg bouillon (en eventueel eiwit) toe en laat garen.
3. Pureer naar wens en serveer met het brood.','1. Sweat the vegetables briefly.
2. Add stock (and protein if using) and simmer.
3. Blend if you like and serve with the bread.','soup',null,'core'),
('carrot_soup_with_lentils','Wortelsoep met linzen','Carrot soup with lentils',ARRAY['lunch'],ARRAY['maintain'],'[{"slug":"carrot","g":250},{"slug":"lentils","g":120},{"slug":"bread_whole","g":40}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY['soup']::text[],'1. Fruit de groente kort aan.
2. Voeg bouillon (en eventueel eiwit) toe en laat garen.
3. Pureer naar wens en serveer met het brood.','1. Sweat the vegetables briefly.
2. Add stock (and protein if using) and simmer.
3. Blend if you like and serve with the bread.','soup',null,'core')
on conflict (slug) do update set name_nl=excluded.name_nl,name_en=excluded.name_en,moments=excluded.moments,goals=excluded.goals,items=excluded.items,tags=excluded.tags,prefs=excluded.prefs,steps=excluded.steps,steps_en=excluded.steps_en,technique=excluded.technique,temp=excluded.temp;
commit;
