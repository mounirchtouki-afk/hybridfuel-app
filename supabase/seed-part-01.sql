-- AUTO-GEGENEREERD core-seed deel 1/9 (200 gerechten). Draai NA dish-library.sql.
-- Draai de delen op volgorde (01, 02, ...). Elk deel is los veilig (upsert).
begin;
insert into public.ingredients (slug,name_nl,name_en,kcal,protein,carbs,fat,category,source) values
('chicken_breast','Kipfilet (gegrild)','Grilled chicken breast',165,31,0,3.6,'vlees','core'),
('turkey_breast','Kalkoenfilet','Turkey breast',135,29,0,1,'vlees','core'),
('lean_beef_5','Rundergehakt 5%','Lean beef mince 5%',137,21,0,5,'vlees','core'),
('beef_steak','Biefstuk','Beef steak',187,27,0,8,'vlees','core'),
('pork_tenderloin','Varkenshaas','Pork tenderloin',143,26,0,4,'vlees','core'),
('salmon','Zalmfilet','Salmon fillet',208,20,0,13,'vis','core'),
('cod','Kabeljauw','Cod',82,18,0,0.7,'vis','core'),
('tuna_water','Tonijn in water','Tuna in water',116,26,0,1,'vis','core'),
('shrimp','Garnalen','Shrimp',99,24,0.2,0.3,'vis','core'),
('tofu','Tofu','Tofu',144,15,2,9,'vega','core'),
('tempeh','Tempeh','Tempeh',192,20,8,11,'vega','core'),
('egg','Ei','Egg',143,13,1,10,'zuivel','core'),
('skyr','Skyr','Skyr',63,11,4,0.2,'zuivel','core'),
('quark_low','Magere kwark','Low-fat quark',57,10,4,0.2,'zuivel','core'),
('greek_yoghurt','Griekse yoghurt 2%','Greek yoghurt 2%',73,9,4,2,'zuivel','core'),
('low_yoghurt','Magere yoghurt','Low-fat yoghurt',42,4,6,0.1,'zuivel','core'),
('cottage','Hüttenkäse','Cottage cheese',98,11,3,5,'zuivel','core'),
('whey','Whey-eiwit','Whey protein',370,80,8,6,'supplement','core'),
('skim_milk','Magere melk','Skimmed milk',35,3.4,5,0.1,'zuivel','core'),
('feta','Feta','Feta',264,14,4,21,'zuivel','core'),
('rice_dry','Witte rijst (droog)','White rice (dry)',360,7,79,1,'granen','core'),
('basmati_dry','Basmatirijst (droog)','Basmati rice (dry)',356,8,78,1,'granen','core'),
('pasta_dry','Volkoren pasta (droog)','Wholewheat pasta (dry)',348,14,67,2.5,'granen','core'),
('noodles_dry','Volkoren noedels (droog)','Wholewheat noodles (dry)',353,13,68,2,'granen','core'),
('quinoa_dry','Quinoa (droog)','Quinoa (dry)',368,14,64,6,'granen','core'),
('couscous_dry','Volkoren couscous (droog)','Wholewheat couscous (dry)',358,12,72,2,'granen','core'),
('oats','Havermout','Oats',379,13,60,7,'granen','core'),
('bread_whole','Volkoren brood','Wholegrain bread',247,9,41,3.4,'granen','core'),
('wrap_whole','Volkoren wrap','Wholegrain wrap',297,9,49,6,'granen','core'),
('potato','Aardappel','Potato',77,2,17,0.1,'groente','core'),
('sweet_potato','Zoete aardappel','Sweet potato',86,1.6,20,0.1,'groente','core'),
('rice_cakes','Rijstwafels','Rice cakes',387,8,82,3,'granen','core'),
('broccoli','Broccoli','Broccoli',34,2.8,7,0.4,'groente','core'),
('green_beans','Sperziebonen','Green beans',31,1.8,7,0.1,'groente','core'),
('spinach','Spinazie','Spinach',23,2.9,3.6,0.4,'groente','core'),
('asparagus','Asperges','Asparagus',20,2.2,3.9,0.1,'groente','core'),
('zucchini','Courgette','Zucchini',17,1.2,3.1,0.3,'groente','core'),
('bell_pepper','Paprika','Bell pepper',31,1,6,0.3,'groente','core'),
('cucumber','Komkommer','Cucumber',15,0.7,3.6,0.1,'groente','core'),
('tomato','Tomaat','Tomato',18,0.9,3.9,0.2,'groente','core'),
('mixed_veg','Wokgroente','Stir-fry veg',40,2,6,0.5,'groente','core'),
('romaine','Romaine sla','Romaine lettuce',17,1.2,3.3,0.3,'groente','core'),
('carrot','Wortel','Carrot',41,0.9,10,0.2,'groente','core'),
('mushroom','Champignons','Mushrooms',22,3.1,3.3,0.3,'groente','core'),
('banana','Banaan','Banana',89,1.1,23,0.3,'fruit','core'),
('blueberries','Blauwe bessen','Blueberries',57,0.7,14,0.3,'fruit','core'),
('strawberries','Aardbeien','Strawberries',32,0.7,8,0.3,'fruit','core'),
('apple','Appel','Apple',52,0.3,14,0.2,'fruit','core'),
('mango','Mango','Mango',60,0.8,15,0.4,'fruit','core'),
('olive_oil','Olijfolie','Olive oil',884,0,0,100,'vet','core'),
('peanut_butter','Pindakaas','Peanut butter',588,25,20,50,'vet','core'),
('almonds','Amandelen','Almonds',579,21,22,50,'noten','core'),
('walnuts','Walnoten','Walnuts',654,15,14,65,'noten','core'),
('avocado','Avocado','Avocado',160,2,9,15,'vet','core'),
('tomato_sauce','Tomatensaus','Tomato sauce',35,1.5,6,0.3,'saus','core'),
('teriyaki','Teriyakisaus','Teriyaki sauce',89,3,16,0.1,'saus','core'),
('curry_sauce','Currysaus (light)','Curry sauce (light)',70,1.5,7,4,'saus','core'),
('honey','Honing','Honey',304,0.3,82,0,'saus','core'),
('hummus','Hummus','Hummus',177,8,14,10,'saus','core'),
('chicken_thigh','Kipdij','Chicken thigh',177,24,0,9,'vlees','core'),
('white_fish','Witvis (tilapia)','White fish (tilapia)',96,20,0,2,'vis','core'),
('meatballs_lean','Magere gehaktballen','Lean meatballs',172,19,4,9,'vlees','core'),
('seitan','Seitan','Seitan',143,25,4,2,'vega','core'),
('edamame','Edamame','Edamame',121,12,9,5,'vega','core'),
('chickpeas','Kikkererwten','Chickpeas',164,9,27,3,'peulvrucht','core'),
('black_beans','Zwarte bonen','Black beans',132,9,24,0.5,'peulvrucht','core'),
('lentils','Linzen (gekookt)','Lentils (cooked)',116,9,20,0.4,'peulvrucht','core'),
('bulgur_dry','Bulgur (droog)','Bulgur (dry)',342,12,76,1.3,'granen','core'),
('granola','Granola','Granola',471,10,64,18,'granen','core'),
('muesli','Muesli','Muesli',367,9,66,6,'granen','core'),
('peas','Doperwten','Peas',81,5,14,0.4,'groente','core'),
('cauliflower','Bloemkool','Cauliflower',25,1.9,5,0.3,'groente','core'),
('kale','Boerenkool','Kale',49,4.3,9,0.9,'groente','core'),
('bok_choy','Paksoi','Bok choy',13,1.5,2.2,0.2,'groente','core'),
('green_salad','Gemengde salade','Mixed salad',20,1.4,3.5,0.3,'groente','core'),
('raspberries','Frambozen','Raspberries',52,1.2,12,0.7,'fruit','core'),
('kiwi','Kiwi','Kiwi',61,1.1,15,0.5,'fruit','core'),
('pineapple','Ananas','Pineapple',50,0.5,13,0.1,'fruit','core'),
('chia','Chiazaad','Chia seeds',486,17,42,31,'noten','core'),
('pumpkin_seeds','Pompoenpitten','Pumpkin seeds',559,30,11,49,'noten','core'),
('protein_bar','Proteïnereep','Protein bar',355,33,30,9,'supplement','core'),
('dark_choc','Pure chocolade 85%','Dark chocolate 85%',592,10,20,52,'snack','core')
on conflict (slug) do nothing;

insert into public.dishes (slug,name_nl,name_en,moments,goals,items,tags,prefs,steps,steps_en,technique,temp,source) values
('chicken_with_rice_broccoli','Kip met rijst & broccoli','Chicken with rice & broccoli',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"chicken_breast","g":160},{"slug":"rice_dry","g":70},{"slug":"broccoli","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Kook de witte rijst (droog) volgens de verpakking.
2. Bak de kipfilet (gegrild) in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok broccoli beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the white rice (dry) per the package.
2. Pan-fry the grilled chicken breast in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the broccoli until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_with_rice_green_beans','Kip met rijst & sperziebonen','Chicken with rice & green beans',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"chicken_breast","g":160},{"slug":"rice_dry","g":70},{"slug":"green_beans","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Kook de witte rijst (droog) volgens de verpakking.
2. Bak de kipfilet (gegrild) in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok sperziebonen beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the white rice (dry) per the package.
2. Pan-fry the grilled chicken breast in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the green beans until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_with_rice_spinach','Kip met rijst & spinazie','Chicken with rice & spinach',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"chicken_breast","g":160},{"slug":"rice_dry","g":70},{"slug":"spinach","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Kook de witte rijst (droog) volgens de verpakking.
2. Bak de kipfilet (gegrild) in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok spinazie beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the white rice (dry) per the package.
2. Pan-fry the grilled chicken breast in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the spinach until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_with_rice_asparagus','Kip met rijst & asperges','Chicken with rice & asparagus',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"chicken_breast","g":160},{"slug":"rice_dry","g":70},{"slug":"asparagus","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Kook de witte rijst (droog) volgens de verpakking.
2. Bak de kipfilet (gegrild) in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok asperges beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the white rice (dry) per the package.
2. Pan-fry the grilled chicken breast in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the asparagus until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_with_rice_zucchini','Kip met rijst & courgette','Chicken with rice & zucchini',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"chicken_breast","g":160},{"slug":"rice_dry","g":70},{"slug":"zucchini","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Kook de witte rijst (droog) volgens de verpakking.
2. Bak de kipfilet (gegrild) in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok courgette beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the white rice (dry) per the package.
2. Pan-fry the grilled chicken breast in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the zucchini until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_with_rice_stir_fry_veg','Kip met rijst & wokgroente','Chicken with rice & stir-fry veg',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"chicken_breast","g":160},{"slug":"rice_dry","g":70},{"slug":"mixed_veg","g":150},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Kook de witte rijst (droog) volgens de verpakking.
2. Bak de kipfilet (gegrild) in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok wokgroente beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the white rice (dry) per the package.
2. Pan-fry the grilled chicken breast in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the stir-fry veg until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_with_rice_mushrooms','Kip met rijst & champignons','Chicken with rice & mushrooms',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"chicken_breast","g":160},{"slug":"rice_dry","g":70},{"slug":"mushroom","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Kook de witte rijst (droog) volgens de verpakking.
2. Bak de kipfilet (gegrild) in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok champignons beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the white rice (dry) per the package.
2. Pan-fry the grilled chicken breast in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the mushrooms until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_with_rice_carrot','Kip met rijst & wortel','Chicken with rice & carrot',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"chicken_breast","g":160},{"slug":"rice_dry","g":70},{"slug":"carrot","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Kook de witte rijst (droog) volgens de verpakking.
2. Bak de kipfilet (gegrild) in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok wortel beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the white rice (dry) per the package.
2. Pan-fry the grilled chicken breast in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the carrot until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_with_rice_peas','Kip met rijst & doperwten','Chicken with rice & peas',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"chicken_breast","g":160},{"slug":"rice_dry","g":70},{"slug":"peas","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Kook de witte rijst (droog) volgens de verpakking.
2. Bak de kipfilet (gegrild) in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok doperwten beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the white rice (dry) per the package.
2. Pan-fry the grilled chicken breast in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the peas until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_with_rice_cauliflower','Kip met rijst & bloemkool','Chicken with rice & cauliflower',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"chicken_breast","g":160},{"slug":"rice_dry","g":70},{"slug":"cauliflower","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Kook de witte rijst (droog) volgens de verpakking.
2. Bak de kipfilet (gegrild) in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok bloemkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the white rice (dry) per the package.
2. Pan-fry the grilled chicken breast in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the cauliflower until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_with_rice_kale','Kip met rijst & boerenkool','Chicken with rice & kale',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"chicken_breast","g":160},{"slug":"rice_dry","g":70},{"slug":"kale","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Kook de witte rijst (droog) volgens de verpakking.
2. Bak de kipfilet (gegrild) in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok boerenkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the white rice (dry) per the package.
2. Pan-fry the grilled chicken breast in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the kale until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_with_rice_bok_choy','Kip met rijst & paksoi','Chicken with rice & bok choy',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"chicken_breast","g":160},{"slug":"rice_dry","g":70},{"slug":"bok_choy","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Kook de witte rijst (droog) volgens de verpakking.
2. Bak de kipfilet (gegrild) in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok paksoi beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the white rice (dry) per the package.
2. Pan-fry the grilled chicken breast in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the bok choy until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_with_sweet_potato_broccoli','Kip met zoete aardappel & broccoli','Chicken with sweet potato & broccoli',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"chicken_breast","g":160},{"slug":"sweet_potato","g":200},{"slug":"broccoli","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Kook de zoete aardappel volgens de verpakking.
2. Bak de kipfilet (gegrild) in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok broccoli beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the sweet potato per the package.
2. Pan-fry the grilled chicken breast in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the broccoli until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_with_sweet_potato_green_beans','Kip met zoete aardappel & sperziebonen','Chicken with sweet potato & green beans',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"chicken_breast","g":160},{"slug":"sweet_potato","g":200},{"slug":"green_beans","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Kook de zoete aardappel volgens de verpakking.
2. Bak de kipfilet (gegrild) in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok sperziebonen beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the sweet potato per the package.
2. Pan-fry the grilled chicken breast in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the green beans until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_with_sweet_potato_spinach','Kip met zoete aardappel & spinazie','Chicken with sweet potato & spinach',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"chicken_breast","g":160},{"slug":"sweet_potato","g":200},{"slug":"spinach","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Kook de zoete aardappel volgens de verpakking.
2. Bak de kipfilet (gegrild) in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok spinazie beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the sweet potato per the package.
2. Pan-fry the grilled chicken breast in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the spinach until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_with_sweet_potato_asparagus','Kip met zoete aardappel & asperges','Chicken with sweet potato & asparagus',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"chicken_breast","g":160},{"slug":"sweet_potato","g":200},{"slug":"asparagus","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Kook de zoete aardappel volgens de verpakking.
2. Bak de kipfilet (gegrild) in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok asperges beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the sweet potato per the package.
2. Pan-fry the grilled chicken breast in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the asparagus until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_with_sweet_potato_zucchini','Kip met zoete aardappel & courgette','Chicken with sweet potato & zucchini',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"chicken_breast","g":160},{"slug":"sweet_potato","g":200},{"slug":"zucchini","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Kook de zoete aardappel volgens de verpakking.
2. Bak de kipfilet (gegrild) in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok courgette beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the sweet potato per the package.
2. Pan-fry the grilled chicken breast in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the zucchini until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_with_sweet_potato_stir_fry_veg','Kip met zoete aardappel & wokgroente','Chicken with sweet potato & stir-fry veg',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"chicken_breast","g":160},{"slug":"sweet_potato","g":200},{"slug":"mixed_veg","g":150},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Kook de zoete aardappel volgens de verpakking.
2. Bak de kipfilet (gegrild) in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok wokgroente beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the sweet potato per the package.
2. Pan-fry the grilled chicken breast in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the stir-fry veg until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_with_sweet_potato_mushrooms','Kip met zoete aardappel & champignons','Chicken with sweet potato & mushrooms',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"chicken_breast","g":160},{"slug":"sweet_potato","g":200},{"slug":"mushroom","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Kook de zoete aardappel volgens de verpakking.
2. Bak de kipfilet (gegrild) in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok champignons beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the sweet potato per the package.
2. Pan-fry the grilled chicken breast in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the mushrooms until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_with_sweet_potato_carrot','Kip met zoete aardappel & wortel','Chicken with sweet potato & carrot',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"chicken_breast","g":160},{"slug":"sweet_potato","g":200},{"slug":"carrot","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Kook de zoete aardappel volgens de verpakking.
2. Bak de kipfilet (gegrild) in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok wortel beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the sweet potato per the package.
2. Pan-fry the grilled chicken breast in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the carrot until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_with_sweet_potato_peas','Kip met zoete aardappel & doperwten','Chicken with sweet potato & peas',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"chicken_breast","g":160},{"slug":"sweet_potato","g":200},{"slug":"peas","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Kook de zoete aardappel volgens de verpakking.
2. Bak de kipfilet (gegrild) in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok doperwten beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the sweet potato per the package.
2. Pan-fry the grilled chicken breast in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the peas until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_with_sweet_potato_cauliflower','Kip met zoete aardappel & bloemkool','Chicken with sweet potato & cauliflower',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"chicken_breast","g":160},{"slug":"sweet_potato","g":200},{"slug":"cauliflower","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Kook de zoete aardappel volgens de verpakking.
2. Bak de kipfilet (gegrild) in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok bloemkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the sweet potato per the package.
2. Pan-fry the grilled chicken breast in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the cauliflower until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_with_sweet_potato_kale','Kip met zoete aardappel & boerenkool','Chicken with sweet potato & kale',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"chicken_breast","g":160},{"slug":"sweet_potato","g":200},{"slug":"kale","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Kook de zoete aardappel volgens de verpakking.
2. Bak de kipfilet (gegrild) in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok boerenkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the sweet potato per the package.
2. Pan-fry the grilled chicken breast in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the kale until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_with_sweet_potato_bok_choy','Kip met zoete aardappel & paksoi','Chicken with sweet potato & bok choy',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"chicken_breast","g":160},{"slug":"sweet_potato","g":200},{"slug":"bok_choy","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Kook de zoete aardappel volgens de verpakking.
2. Bak de kipfilet (gegrild) in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok paksoi beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the sweet potato per the package.
2. Pan-fry the grilled chicken breast in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the bok choy until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_with_potato_broccoli','Kip met aardappel & broccoli','Chicken with potato & broccoli',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"chicken_breast","g":160},{"slug":"potato","g":250},{"slug":"broccoli","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['chickenrice','ricechicken','steakpotato']::text[],'1. Kook de aardappel volgens de verpakking.
2. Bak de kipfilet (gegrild) in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok broccoli beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the potato per the package.
2. Pan-fry the grilled chicken breast in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the broccoli until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_with_potato_green_beans','Kip met aardappel & sperziebonen','Chicken with potato & green beans',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"chicken_breast","g":160},{"slug":"potato","g":250},{"slug":"green_beans","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['chickenrice','ricechicken','steakpotato']::text[],'1. Kook de aardappel volgens de verpakking.
2. Bak de kipfilet (gegrild) in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok sperziebonen beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the potato per the package.
2. Pan-fry the grilled chicken breast in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the green beans until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_with_potato_spinach','Kip met aardappel & spinazie','Chicken with potato & spinach',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"chicken_breast","g":160},{"slug":"potato","g":250},{"slug":"spinach","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['chickenrice','ricechicken','steakpotato']::text[],'1. Kook de aardappel volgens de verpakking.
2. Bak de kipfilet (gegrild) in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok spinazie beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the potato per the package.
2. Pan-fry the grilled chicken breast in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the spinach until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_with_potato_asparagus','Kip met aardappel & asperges','Chicken with potato & asparagus',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"chicken_breast","g":160},{"slug":"potato","g":250},{"slug":"asparagus","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['chickenrice','ricechicken','steakpotato']::text[],'1. Kook de aardappel volgens de verpakking.
2. Bak de kipfilet (gegrild) in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok asperges beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the potato per the package.
2. Pan-fry the grilled chicken breast in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the asparagus until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_with_potato_zucchini','Kip met aardappel & courgette','Chicken with potato & zucchini',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"chicken_breast","g":160},{"slug":"potato","g":250},{"slug":"zucchini","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['chickenrice','ricechicken','steakpotato']::text[],'1. Kook de aardappel volgens de verpakking.
2. Bak de kipfilet (gegrild) in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok courgette beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the potato per the package.
2. Pan-fry the grilled chicken breast in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the zucchini until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_with_potato_stir_fry_veg','Kip met aardappel & wokgroente','Chicken with potato & stir-fry veg',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"chicken_breast","g":160},{"slug":"potato","g":250},{"slug":"mixed_veg","g":150},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['chickenrice','ricechicken','steakpotato']::text[],'1. Kook de aardappel volgens de verpakking.
2. Bak de kipfilet (gegrild) in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok wokgroente beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the potato per the package.
2. Pan-fry the grilled chicken breast in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the stir-fry veg until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_with_potato_mushrooms','Kip met aardappel & champignons','Chicken with potato & mushrooms',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"chicken_breast","g":160},{"slug":"potato","g":250},{"slug":"mushroom","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['chickenrice','ricechicken','steakpotato']::text[],'1. Kook de aardappel volgens de verpakking.
2. Bak de kipfilet (gegrild) in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok champignons beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the potato per the package.
2. Pan-fry the grilled chicken breast in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the mushrooms until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_with_potato_carrot','Kip met aardappel & wortel','Chicken with potato & carrot',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"chicken_breast","g":160},{"slug":"potato","g":250},{"slug":"carrot","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['chickenrice','ricechicken','steakpotato']::text[],'1. Kook de aardappel volgens de verpakking.
2. Bak de kipfilet (gegrild) in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok wortel beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the potato per the package.
2. Pan-fry the grilled chicken breast in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the carrot until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_with_potato_peas','Kip met aardappel & doperwten','Chicken with potato & peas',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"chicken_breast","g":160},{"slug":"potato","g":250},{"slug":"peas","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['chickenrice','ricechicken','steakpotato']::text[],'1. Kook de aardappel volgens de verpakking.
2. Bak de kipfilet (gegrild) in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok doperwten beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the potato per the package.
2. Pan-fry the grilled chicken breast in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the peas until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_with_potato_cauliflower','Kip met aardappel & bloemkool','Chicken with potato & cauliflower',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"chicken_breast","g":160},{"slug":"potato","g":250},{"slug":"cauliflower","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['chickenrice','ricechicken','steakpotato']::text[],'1. Kook de aardappel volgens de verpakking.
2. Bak de kipfilet (gegrild) in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok bloemkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the potato per the package.
2. Pan-fry the grilled chicken breast in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the cauliflower until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_with_potato_kale','Kip met aardappel & boerenkool','Chicken with potato & kale',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"chicken_breast","g":160},{"slug":"potato","g":250},{"slug":"kale","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['chickenrice','ricechicken','steakpotato']::text[],'1. Kook de aardappel volgens de verpakking.
2. Bak de kipfilet (gegrild) in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok boerenkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the potato per the package.
2. Pan-fry the grilled chicken breast in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the kale until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_with_potato_bok_choy','Kip met aardappel & paksoi','Chicken with potato & bok choy',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"chicken_breast","g":160},{"slug":"potato","g":250},{"slug":"bok_choy","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['chickenrice','ricechicken','steakpotato']::text[],'1. Kook de aardappel volgens de verpakking.
2. Bak de kipfilet (gegrild) in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok paksoi beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the potato per the package.
2. Pan-fry the grilled chicken breast in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the bok choy until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_with_pasta_broccoli','Kip met pasta & broccoli','Chicken with pasta & broccoli',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"chicken_breast","g":160},{"slug":"pasta_dry","g":80},{"slug":"broccoli","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['chickenrice','ricechicken','pastabol']::text[],'1. Kook de volkoren pasta (droog) volgens de verpakking.
2. Bak de kipfilet (gegrild) in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok broccoli beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat pasta (dry) per the package.
2. Pan-fry the grilled chicken breast in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the broccoli until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_with_pasta_green_beans','Kip met pasta & sperziebonen','Chicken with pasta & green beans',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"chicken_breast","g":160},{"slug":"pasta_dry","g":80},{"slug":"green_beans","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['chickenrice','ricechicken','pastabol']::text[],'1. Kook de volkoren pasta (droog) volgens de verpakking.
2. Bak de kipfilet (gegrild) in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok sperziebonen beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat pasta (dry) per the package.
2. Pan-fry the grilled chicken breast in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the green beans until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_with_pasta_spinach','Kip met pasta & spinazie','Chicken with pasta & spinach',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"chicken_breast","g":160},{"slug":"pasta_dry","g":80},{"slug":"spinach","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['chickenrice','ricechicken','pastabol']::text[],'1. Kook de volkoren pasta (droog) volgens de verpakking.
2. Bak de kipfilet (gegrild) in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok spinazie beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat pasta (dry) per the package.
2. Pan-fry the grilled chicken breast in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the spinach until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_with_pasta_asparagus','Kip met pasta & asperges','Chicken with pasta & asparagus',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"chicken_breast","g":160},{"slug":"pasta_dry","g":80},{"slug":"asparagus","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['chickenrice','ricechicken','pastabol']::text[],'1. Kook de volkoren pasta (droog) volgens de verpakking.
2. Bak de kipfilet (gegrild) in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok asperges beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat pasta (dry) per the package.
2. Pan-fry the grilled chicken breast in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the asparagus until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_with_pasta_zucchini','Kip met pasta & courgette','Chicken with pasta & zucchini',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"chicken_breast","g":160},{"slug":"pasta_dry","g":80},{"slug":"zucchini","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['chickenrice','ricechicken','pastabol']::text[],'1. Kook de volkoren pasta (droog) volgens de verpakking.
2. Bak de kipfilet (gegrild) in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok courgette beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat pasta (dry) per the package.
2. Pan-fry the grilled chicken breast in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the zucchini until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_with_pasta_stir_fry_veg','Kip met pasta & wokgroente','Chicken with pasta & stir-fry veg',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"chicken_breast","g":160},{"slug":"pasta_dry","g":80},{"slug":"mixed_veg","g":150},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['chickenrice','ricechicken','pastabol']::text[],'1. Kook de volkoren pasta (droog) volgens de verpakking.
2. Bak de kipfilet (gegrild) in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok wokgroente beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat pasta (dry) per the package.
2. Pan-fry the grilled chicken breast in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the stir-fry veg until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_with_pasta_mushrooms','Kip met pasta & champignons','Chicken with pasta & mushrooms',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"chicken_breast","g":160},{"slug":"pasta_dry","g":80},{"slug":"mushroom","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['chickenrice','ricechicken','pastabol']::text[],'1. Kook de volkoren pasta (droog) volgens de verpakking.
2. Bak de kipfilet (gegrild) in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok champignons beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat pasta (dry) per the package.
2. Pan-fry the grilled chicken breast in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the mushrooms until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_with_pasta_carrot','Kip met pasta & wortel','Chicken with pasta & carrot',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"chicken_breast","g":160},{"slug":"pasta_dry","g":80},{"slug":"carrot","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['chickenrice','ricechicken','pastabol']::text[],'1. Kook de volkoren pasta (droog) volgens de verpakking.
2. Bak de kipfilet (gegrild) in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok wortel beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat pasta (dry) per the package.
2. Pan-fry the grilled chicken breast in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the carrot until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_with_pasta_peas','Kip met pasta & doperwten','Chicken with pasta & peas',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"chicken_breast","g":160},{"slug":"pasta_dry","g":80},{"slug":"peas","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['chickenrice','ricechicken','pastabol']::text[],'1. Kook de volkoren pasta (droog) volgens de verpakking.
2. Bak de kipfilet (gegrild) in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok doperwten beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat pasta (dry) per the package.
2. Pan-fry the grilled chicken breast in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the peas until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_with_pasta_cauliflower','Kip met pasta & bloemkool','Chicken with pasta & cauliflower',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"chicken_breast","g":160},{"slug":"pasta_dry","g":80},{"slug":"cauliflower","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['chickenrice','ricechicken','pastabol']::text[],'1. Kook de volkoren pasta (droog) volgens de verpakking.
2. Bak de kipfilet (gegrild) in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok bloemkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat pasta (dry) per the package.
2. Pan-fry the grilled chicken breast in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the cauliflower until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_with_pasta_kale','Kip met pasta & boerenkool','Chicken with pasta & kale',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"chicken_breast","g":160},{"slug":"pasta_dry","g":80},{"slug":"kale","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['chickenrice','ricechicken','pastabol']::text[],'1. Kook de volkoren pasta (droog) volgens de verpakking.
2. Bak de kipfilet (gegrild) in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok boerenkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat pasta (dry) per the package.
2. Pan-fry the grilled chicken breast in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the kale until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_with_pasta_bok_choy','Kip met pasta & paksoi','Chicken with pasta & bok choy',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"chicken_breast","g":160},{"slug":"pasta_dry","g":80},{"slug":"bok_choy","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['chickenrice','ricechicken','pastabol']::text[],'1. Kook de volkoren pasta (droog) volgens de verpakking.
2. Bak de kipfilet (gegrild) in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok paksoi beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat pasta (dry) per the package.
2. Pan-fry the grilled chicken breast in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the bok choy until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_with_quinoa_broccoli','Kip met quinoa & broccoli','Chicken with quinoa & broccoli',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"chicken_breast","g":160},{"slug":"quinoa_dry","g":70},{"slug":"broccoli","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Kook de quinoa (droog) volgens de verpakking.
2. Bak de kipfilet (gegrild) in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok broccoli beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the quinoa (dry) per the package.
2. Pan-fry the grilled chicken breast in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the broccoli until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_with_quinoa_green_beans','Kip met quinoa & sperziebonen','Chicken with quinoa & green beans',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"chicken_breast","g":160},{"slug":"quinoa_dry","g":70},{"slug":"green_beans","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Kook de quinoa (droog) volgens de verpakking.
2. Bak de kipfilet (gegrild) in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok sperziebonen beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the quinoa (dry) per the package.
2. Pan-fry the grilled chicken breast in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the green beans until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_with_quinoa_spinach','Kip met quinoa & spinazie','Chicken with quinoa & spinach',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"chicken_breast","g":160},{"slug":"quinoa_dry","g":70},{"slug":"spinach","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Kook de quinoa (droog) volgens de verpakking.
2. Bak de kipfilet (gegrild) in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok spinazie beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the quinoa (dry) per the package.
2. Pan-fry the grilled chicken breast in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the spinach until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_with_quinoa_asparagus','Kip met quinoa & asperges','Chicken with quinoa & asparagus',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"chicken_breast","g":160},{"slug":"quinoa_dry","g":70},{"slug":"asparagus","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Kook de quinoa (droog) volgens de verpakking.
2. Bak de kipfilet (gegrild) in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok asperges beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the quinoa (dry) per the package.
2. Pan-fry the grilled chicken breast in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the asparagus until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_with_quinoa_zucchini','Kip met quinoa & courgette','Chicken with quinoa & zucchini',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"chicken_breast","g":160},{"slug":"quinoa_dry","g":70},{"slug":"zucchini","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Kook de quinoa (droog) volgens de verpakking.
2. Bak de kipfilet (gegrild) in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok courgette beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the quinoa (dry) per the package.
2. Pan-fry the grilled chicken breast in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the zucchini until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_with_quinoa_stir_fry_veg','Kip met quinoa & wokgroente','Chicken with quinoa & stir-fry veg',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"chicken_breast","g":160},{"slug":"quinoa_dry","g":70},{"slug":"mixed_veg","g":150},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Kook de quinoa (droog) volgens de verpakking.
2. Bak de kipfilet (gegrild) in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok wokgroente beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the quinoa (dry) per the package.
2. Pan-fry the grilled chicken breast in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the stir-fry veg until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_with_quinoa_mushrooms','Kip met quinoa & champignons','Chicken with quinoa & mushrooms',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"chicken_breast","g":160},{"slug":"quinoa_dry","g":70},{"slug":"mushroom","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Kook de quinoa (droog) volgens de verpakking.
2. Bak de kipfilet (gegrild) in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok champignons beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the quinoa (dry) per the package.
2. Pan-fry the grilled chicken breast in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the mushrooms until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_with_quinoa_carrot','Kip met quinoa & wortel','Chicken with quinoa & carrot',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"chicken_breast","g":160},{"slug":"quinoa_dry","g":70},{"slug":"carrot","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Kook de quinoa (droog) volgens de verpakking.
2. Bak de kipfilet (gegrild) in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok wortel beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the quinoa (dry) per the package.
2. Pan-fry the grilled chicken breast in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the carrot until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_with_quinoa_peas','Kip met quinoa & doperwten','Chicken with quinoa & peas',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"chicken_breast","g":160},{"slug":"quinoa_dry","g":70},{"slug":"peas","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Kook de quinoa (droog) volgens de verpakking.
2. Bak de kipfilet (gegrild) in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok doperwten beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the quinoa (dry) per the package.
2. Pan-fry the grilled chicken breast in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the peas until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_with_quinoa_cauliflower','Kip met quinoa & bloemkool','Chicken with quinoa & cauliflower',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"chicken_breast","g":160},{"slug":"quinoa_dry","g":70},{"slug":"cauliflower","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Kook de quinoa (droog) volgens de verpakking.
2. Bak de kipfilet (gegrild) in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok bloemkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the quinoa (dry) per the package.
2. Pan-fry the grilled chicken breast in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the cauliflower until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_with_quinoa_kale','Kip met quinoa & boerenkool','Chicken with quinoa & kale',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"chicken_breast","g":160},{"slug":"quinoa_dry","g":70},{"slug":"kale","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Kook de quinoa (droog) volgens de verpakking.
2. Bak de kipfilet (gegrild) in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok boerenkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the quinoa (dry) per the package.
2. Pan-fry the grilled chicken breast in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the kale until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_with_quinoa_bok_choy','Kip met quinoa & paksoi','Chicken with quinoa & bok choy',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"chicken_breast","g":160},{"slug":"quinoa_dry","g":70},{"slug":"bok_choy","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Kook de quinoa (droog) volgens de verpakking.
2. Bak de kipfilet (gegrild) in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok paksoi beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the quinoa (dry) per the package.
2. Pan-fry the grilled chicken breast in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the bok choy until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_with_noodles_broccoli','Kip met noedels & broccoli','Chicken with noodles & broccoli',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"chicken_breast","g":160},{"slug":"noodles_dry","g":80},{"slug":"broccoli","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['chickenrice','ricechicken','woknoodles']::text[],'1. Kook de volkoren noedels (droog) volgens de verpakking.
2. Bak de kipfilet (gegrild) in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok broccoli beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat noodles (dry) per the package.
2. Pan-fry the grilled chicken breast in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the broccoli until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_with_noodles_green_beans','Kip met noedels & sperziebonen','Chicken with noodles & green beans',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"chicken_breast","g":160},{"slug":"noodles_dry","g":80},{"slug":"green_beans","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['chickenrice','ricechicken','woknoodles']::text[],'1. Kook de volkoren noedels (droog) volgens de verpakking.
2. Bak de kipfilet (gegrild) in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok sperziebonen beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat noodles (dry) per the package.
2. Pan-fry the grilled chicken breast in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the green beans until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_with_noodles_spinach','Kip met noedels & spinazie','Chicken with noodles & spinach',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"chicken_breast","g":160},{"slug":"noodles_dry","g":80},{"slug":"spinach","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['chickenrice','ricechicken','woknoodles']::text[],'1. Kook de volkoren noedels (droog) volgens de verpakking.
2. Bak de kipfilet (gegrild) in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok spinazie beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat noodles (dry) per the package.
2. Pan-fry the grilled chicken breast in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the spinach until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_with_noodles_asparagus','Kip met noedels & asperges','Chicken with noodles & asparagus',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"chicken_breast","g":160},{"slug":"noodles_dry","g":80},{"slug":"asparagus","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['chickenrice','ricechicken','woknoodles']::text[],'1. Kook de volkoren noedels (droog) volgens de verpakking.
2. Bak de kipfilet (gegrild) in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok asperges beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat noodles (dry) per the package.
2. Pan-fry the grilled chicken breast in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the asparagus until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_with_noodles_zucchini','Kip met noedels & courgette','Chicken with noodles & zucchini',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"chicken_breast","g":160},{"slug":"noodles_dry","g":80},{"slug":"zucchini","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['chickenrice','ricechicken','woknoodles']::text[],'1. Kook de volkoren noedels (droog) volgens de verpakking.
2. Bak de kipfilet (gegrild) in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok courgette beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat noodles (dry) per the package.
2. Pan-fry the grilled chicken breast in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the zucchini until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_with_noodles_stir_fry_veg','Kip met noedels & wokgroente','Chicken with noodles & stir-fry veg',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"chicken_breast","g":160},{"slug":"noodles_dry","g":80},{"slug":"mixed_veg","g":150},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['chickenrice','ricechicken','woknoodles']::text[],'1. Kook de volkoren noedels (droog) volgens de verpakking.
2. Bak de kipfilet (gegrild) in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok wokgroente beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat noodles (dry) per the package.
2. Pan-fry the grilled chicken breast in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the stir-fry veg until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_with_noodles_mushrooms','Kip met noedels & champignons','Chicken with noodles & mushrooms',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"chicken_breast","g":160},{"slug":"noodles_dry","g":80},{"slug":"mushroom","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['chickenrice','ricechicken','woknoodles']::text[],'1. Kook de volkoren noedels (droog) volgens de verpakking.
2. Bak de kipfilet (gegrild) in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok champignons beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat noodles (dry) per the package.
2. Pan-fry the grilled chicken breast in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the mushrooms until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_with_noodles_carrot','Kip met noedels & wortel','Chicken with noodles & carrot',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"chicken_breast","g":160},{"slug":"noodles_dry","g":80},{"slug":"carrot","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['chickenrice','ricechicken','woknoodles']::text[],'1. Kook de volkoren noedels (droog) volgens de verpakking.
2. Bak de kipfilet (gegrild) in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok wortel beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat noodles (dry) per the package.
2. Pan-fry the grilled chicken breast in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the carrot until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_with_noodles_peas','Kip met noedels & doperwten','Chicken with noodles & peas',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"chicken_breast","g":160},{"slug":"noodles_dry","g":80},{"slug":"peas","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['chickenrice','ricechicken','woknoodles']::text[],'1. Kook de volkoren noedels (droog) volgens de verpakking.
2. Bak de kipfilet (gegrild) in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok doperwten beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat noodles (dry) per the package.
2. Pan-fry the grilled chicken breast in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the peas until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_with_noodles_cauliflower','Kip met noedels & bloemkool','Chicken with noodles & cauliflower',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"chicken_breast","g":160},{"slug":"noodles_dry","g":80},{"slug":"cauliflower","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['chickenrice','ricechicken','woknoodles']::text[],'1. Kook de volkoren noedels (droog) volgens de verpakking.
2. Bak de kipfilet (gegrild) in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok bloemkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat noodles (dry) per the package.
2. Pan-fry the grilled chicken breast in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the cauliflower until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_with_noodles_kale','Kip met noedels & boerenkool','Chicken with noodles & kale',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"chicken_breast","g":160},{"slug":"noodles_dry","g":80},{"slug":"kale","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['chickenrice','ricechicken','woknoodles']::text[],'1. Kook de volkoren noedels (droog) volgens de verpakking.
2. Bak de kipfilet (gegrild) in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok boerenkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat noodles (dry) per the package.
2. Pan-fry the grilled chicken breast in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the kale until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_with_noodles_bok_choy','Kip met noedels & paksoi','Chicken with noodles & bok choy',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"chicken_breast","g":160},{"slug":"noodles_dry","g":80},{"slug":"bok_choy","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['chickenrice','ricechicken','woknoodles']::text[],'1. Kook de volkoren noedels (droog) volgens de verpakking.
2. Bak de kipfilet (gegrild) in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok paksoi beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat noodles (dry) per the package.
2. Pan-fry the grilled chicken breast in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the bok choy until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_with_couscous_broccoli','Kip met couscous & broccoli','Chicken with couscous & broccoli',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"chicken_breast","g":160},{"slug":"couscous_dry","g":70},{"slug":"broccoli","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Kook de volkoren couscous (droog) volgens de verpakking.
2. Bak de kipfilet (gegrild) in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok broccoli beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat couscous (dry) per the package.
2. Pan-fry the grilled chicken breast in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the broccoli until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_with_couscous_green_beans','Kip met couscous & sperziebonen','Chicken with couscous & green beans',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"chicken_breast","g":160},{"slug":"couscous_dry","g":70},{"slug":"green_beans","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Kook de volkoren couscous (droog) volgens de verpakking.
2. Bak de kipfilet (gegrild) in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok sperziebonen beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat couscous (dry) per the package.
2. Pan-fry the grilled chicken breast in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the green beans until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_with_couscous_spinach','Kip met couscous & spinazie','Chicken with couscous & spinach',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"chicken_breast","g":160},{"slug":"couscous_dry","g":70},{"slug":"spinach","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Kook de volkoren couscous (droog) volgens de verpakking.
2. Bak de kipfilet (gegrild) in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok spinazie beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat couscous (dry) per the package.
2. Pan-fry the grilled chicken breast in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the spinach until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_with_couscous_asparagus','Kip met couscous & asperges','Chicken with couscous & asparagus',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"chicken_breast","g":160},{"slug":"couscous_dry","g":70},{"slug":"asparagus","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Kook de volkoren couscous (droog) volgens de verpakking.
2. Bak de kipfilet (gegrild) in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok asperges beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat couscous (dry) per the package.
2. Pan-fry the grilled chicken breast in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the asparagus until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_with_couscous_zucchini','Kip met couscous & courgette','Chicken with couscous & zucchini',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"chicken_breast","g":160},{"slug":"couscous_dry","g":70},{"slug":"zucchini","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Kook de volkoren couscous (droog) volgens de verpakking.
2. Bak de kipfilet (gegrild) in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok courgette beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat couscous (dry) per the package.
2. Pan-fry the grilled chicken breast in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the zucchini until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_with_couscous_stir_fry_veg','Kip met couscous & wokgroente','Chicken with couscous & stir-fry veg',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"chicken_breast","g":160},{"slug":"couscous_dry","g":70},{"slug":"mixed_veg","g":150},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Kook de volkoren couscous (droog) volgens de verpakking.
2. Bak de kipfilet (gegrild) in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok wokgroente beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat couscous (dry) per the package.
2. Pan-fry the grilled chicken breast in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the stir-fry veg until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_with_couscous_mushrooms','Kip met couscous & champignons','Chicken with couscous & mushrooms',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"chicken_breast","g":160},{"slug":"couscous_dry","g":70},{"slug":"mushroom","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Kook de volkoren couscous (droog) volgens de verpakking.
2. Bak de kipfilet (gegrild) in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok champignons beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat couscous (dry) per the package.
2. Pan-fry the grilled chicken breast in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the mushrooms until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_with_couscous_carrot','Kip met couscous & wortel','Chicken with couscous & carrot',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"chicken_breast","g":160},{"slug":"couscous_dry","g":70},{"slug":"carrot","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Kook de volkoren couscous (droog) volgens de verpakking.
2. Bak de kipfilet (gegrild) in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok wortel beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat couscous (dry) per the package.
2. Pan-fry the grilled chicken breast in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the carrot until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_with_couscous_peas','Kip met couscous & doperwten','Chicken with couscous & peas',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"chicken_breast","g":160},{"slug":"couscous_dry","g":70},{"slug":"peas","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Kook de volkoren couscous (droog) volgens de verpakking.
2. Bak de kipfilet (gegrild) in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok doperwten beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat couscous (dry) per the package.
2. Pan-fry the grilled chicken breast in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the peas until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_with_couscous_cauliflower','Kip met couscous & bloemkool','Chicken with couscous & cauliflower',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"chicken_breast","g":160},{"slug":"couscous_dry","g":70},{"slug":"cauliflower","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Kook de volkoren couscous (droog) volgens de verpakking.
2. Bak de kipfilet (gegrild) in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok bloemkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat couscous (dry) per the package.
2. Pan-fry the grilled chicken breast in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the cauliflower until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_with_couscous_kale','Kip met couscous & boerenkool','Chicken with couscous & kale',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"chicken_breast","g":160},{"slug":"couscous_dry","g":70},{"slug":"kale","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Kook de volkoren couscous (droog) volgens de verpakking.
2. Bak de kipfilet (gegrild) in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok boerenkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat couscous (dry) per the package.
2. Pan-fry the grilled chicken breast in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the kale until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_with_couscous_bok_choy','Kip met couscous & paksoi','Chicken with couscous & bok choy',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"chicken_breast","g":160},{"slug":"couscous_dry","g":70},{"slug":"bok_choy","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Kook de volkoren couscous (droog) volgens de verpakking.
2. Bak de kipfilet (gegrild) in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok paksoi beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat couscous (dry) per the package.
2. Pan-fry the grilled chicken breast in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the bok choy until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_with_bulgur_broccoli','Kip met bulgur & broccoli','Chicken with bulgur & broccoli',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"chicken_breast","g":160},{"slug":"bulgur_dry","g":70},{"slug":"broccoli","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Kook de bulgur (droog) volgens de verpakking.
2. Bak de kipfilet (gegrild) in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok broccoli beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the bulgur (dry) per the package.
2. Pan-fry the grilled chicken breast in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the broccoli until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_with_bulgur_green_beans','Kip met bulgur & sperziebonen','Chicken with bulgur & green beans',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"chicken_breast","g":160},{"slug":"bulgur_dry","g":70},{"slug":"green_beans","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Kook de bulgur (droog) volgens de verpakking.
2. Bak de kipfilet (gegrild) in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok sperziebonen beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the bulgur (dry) per the package.
2. Pan-fry the grilled chicken breast in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the green beans until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_with_bulgur_spinach','Kip met bulgur & spinazie','Chicken with bulgur & spinach',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"chicken_breast","g":160},{"slug":"bulgur_dry","g":70},{"slug":"spinach","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Kook de bulgur (droog) volgens de verpakking.
2. Bak de kipfilet (gegrild) in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok spinazie beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the bulgur (dry) per the package.
2. Pan-fry the grilled chicken breast in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the spinach until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_with_bulgur_asparagus','Kip met bulgur & asperges','Chicken with bulgur & asparagus',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"chicken_breast","g":160},{"slug":"bulgur_dry","g":70},{"slug":"asparagus","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Kook de bulgur (droog) volgens de verpakking.
2. Bak de kipfilet (gegrild) in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok asperges beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the bulgur (dry) per the package.
2. Pan-fry the grilled chicken breast in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the asparagus until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_with_bulgur_zucchini','Kip met bulgur & courgette','Chicken with bulgur & zucchini',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"chicken_breast","g":160},{"slug":"bulgur_dry","g":70},{"slug":"zucchini","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Kook de bulgur (droog) volgens de verpakking.
2. Bak de kipfilet (gegrild) in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok courgette beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the bulgur (dry) per the package.
2. Pan-fry the grilled chicken breast in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the zucchini until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_with_bulgur_stir_fry_veg','Kip met bulgur & wokgroente','Chicken with bulgur & stir-fry veg',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"chicken_breast","g":160},{"slug":"bulgur_dry","g":70},{"slug":"mixed_veg","g":150},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Kook de bulgur (droog) volgens de verpakking.
2. Bak de kipfilet (gegrild) in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok wokgroente beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the bulgur (dry) per the package.
2. Pan-fry the grilled chicken breast in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the stir-fry veg until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_with_bulgur_mushrooms','Kip met bulgur & champignons','Chicken with bulgur & mushrooms',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"chicken_breast","g":160},{"slug":"bulgur_dry","g":70},{"slug":"mushroom","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Kook de bulgur (droog) volgens de verpakking.
2. Bak de kipfilet (gegrild) in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok champignons beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the bulgur (dry) per the package.
2. Pan-fry the grilled chicken breast in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the mushrooms until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_with_bulgur_carrot','Kip met bulgur & wortel','Chicken with bulgur & carrot',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"chicken_breast","g":160},{"slug":"bulgur_dry","g":70},{"slug":"carrot","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Kook de bulgur (droog) volgens de verpakking.
2. Bak de kipfilet (gegrild) in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok wortel beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the bulgur (dry) per the package.
2. Pan-fry the grilled chicken breast in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the carrot until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_with_bulgur_peas','Kip met bulgur & doperwten','Chicken with bulgur & peas',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"chicken_breast","g":160},{"slug":"bulgur_dry","g":70},{"slug":"peas","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Kook de bulgur (droog) volgens de verpakking.
2. Bak de kipfilet (gegrild) in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok doperwten beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the bulgur (dry) per the package.
2. Pan-fry the grilled chicken breast in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the peas until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_with_bulgur_cauliflower','Kip met bulgur & bloemkool','Chicken with bulgur & cauliflower',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"chicken_breast","g":160},{"slug":"bulgur_dry","g":70},{"slug":"cauliflower","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Kook de bulgur (droog) volgens de verpakking.
2. Bak de kipfilet (gegrild) in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok bloemkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the bulgur (dry) per the package.
2. Pan-fry the grilled chicken breast in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the cauliflower until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_with_bulgur_kale','Kip met bulgur & boerenkool','Chicken with bulgur & kale',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"chicken_breast","g":160},{"slug":"bulgur_dry","g":70},{"slug":"kale","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Kook de bulgur (droog) volgens de verpakking.
2. Bak de kipfilet (gegrild) in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok boerenkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the bulgur (dry) per the package.
2. Pan-fry the grilled chicken breast in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the kale until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_with_bulgur_bok_choy','Kip met bulgur & paksoi','Chicken with bulgur & bok choy',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"chicken_breast","g":160},{"slug":"bulgur_dry","g":70},{"slug":"bok_choy","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Kook de bulgur (droog) volgens de verpakking.
2. Bak de kipfilet (gegrild) in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok paksoi beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the bulgur (dry) per the package.
2. Pan-fry the grilled chicken breast in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the bok choy until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_with_basmati_rice_broccoli','Kip met basmatirijst & broccoli','Chicken with basmati rice & broccoli',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"chicken_breast","g":160},{"slug":"basmati_dry","g":70},{"slug":"broccoli","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Kook de basmatirijst (droog) volgens de verpakking.
2. Bak de kipfilet (gegrild) in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok broccoli beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the basmati rice (dry) per the package.
2. Pan-fry the grilled chicken breast in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the broccoli until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_with_basmati_rice_green_beans','Kip met basmatirijst & sperziebonen','Chicken with basmati rice & green beans',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"chicken_breast","g":160},{"slug":"basmati_dry","g":70},{"slug":"green_beans","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Kook de basmatirijst (droog) volgens de verpakking.
2. Bak de kipfilet (gegrild) in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok sperziebonen beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the basmati rice (dry) per the package.
2. Pan-fry the grilled chicken breast in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the green beans until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_with_basmati_rice_spinach','Kip met basmatirijst & spinazie','Chicken with basmati rice & spinach',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"chicken_breast","g":160},{"slug":"basmati_dry","g":70},{"slug":"spinach","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Kook de basmatirijst (droog) volgens de verpakking.
2. Bak de kipfilet (gegrild) in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok spinazie beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the basmati rice (dry) per the package.
2. Pan-fry the grilled chicken breast in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the spinach until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_with_basmati_rice_asparagus','Kip met basmatirijst & asperges','Chicken with basmati rice & asparagus',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"chicken_breast","g":160},{"slug":"basmati_dry","g":70},{"slug":"asparagus","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Kook de basmatirijst (droog) volgens de verpakking.
2. Bak de kipfilet (gegrild) in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok asperges beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the basmati rice (dry) per the package.
2. Pan-fry the grilled chicken breast in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the asparagus until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_with_basmati_rice_zucchini','Kip met basmatirijst & courgette','Chicken with basmati rice & zucchini',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"chicken_breast","g":160},{"slug":"basmati_dry","g":70},{"slug":"zucchini","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Kook de basmatirijst (droog) volgens de verpakking.
2. Bak de kipfilet (gegrild) in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok courgette beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the basmati rice (dry) per the package.
2. Pan-fry the grilled chicken breast in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the zucchini until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_with_basmati_rice_stir_fry_veg','Kip met basmatirijst & wokgroente','Chicken with basmati rice & stir-fry veg',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"chicken_breast","g":160},{"slug":"basmati_dry","g":70},{"slug":"mixed_veg","g":150},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Kook de basmatirijst (droog) volgens de verpakking.
2. Bak de kipfilet (gegrild) in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok wokgroente beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the basmati rice (dry) per the package.
2. Pan-fry the grilled chicken breast in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the stir-fry veg until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_with_basmati_rice_mushrooms','Kip met basmatirijst & champignons','Chicken with basmati rice & mushrooms',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"chicken_breast","g":160},{"slug":"basmati_dry","g":70},{"slug":"mushroom","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Kook de basmatirijst (droog) volgens de verpakking.
2. Bak de kipfilet (gegrild) in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok champignons beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the basmati rice (dry) per the package.
2. Pan-fry the grilled chicken breast in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the mushrooms until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_with_basmati_rice_carrot','Kip met basmatirijst & wortel','Chicken with basmati rice & carrot',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"chicken_breast","g":160},{"slug":"basmati_dry","g":70},{"slug":"carrot","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Kook de basmatirijst (droog) volgens de verpakking.
2. Bak de kipfilet (gegrild) in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok wortel beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the basmati rice (dry) per the package.
2. Pan-fry the grilled chicken breast in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the carrot until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_with_basmati_rice_peas','Kip met basmatirijst & doperwten','Chicken with basmati rice & peas',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"chicken_breast","g":160},{"slug":"basmati_dry","g":70},{"slug":"peas","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Kook de basmatirijst (droog) volgens de verpakking.
2. Bak de kipfilet (gegrild) in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok doperwten beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the basmati rice (dry) per the package.
2. Pan-fry the grilled chicken breast in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the peas until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_with_basmati_rice_cauliflower','Kip met basmatirijst & bloemkool','Chicken with basmati rice & cauliflower',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"chicken_breast","g":160},{"slug":"basmati_dry","g":70},{"slug":"cauliflower","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Kook de basmatirijst (droog) volgens de verpakking.
2. Bak de kipfilet (gegrild) in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok bloemkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the basmati rice (dry) per the package.
2. Pan-fry the grilled chicken breast in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the cauliflower until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_with_basmati_rice_kale','Kip met basmatirijst & boerenkool','Chicken with basmati rice & kale',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"chicken_breast","g":160},{"slug":"basmati_dry","g":70},{"slug":"kale","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Kook de basmatirijst (droog) volgens de verpakking.
2. Bak de kipfilet (gegrild) in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok boerenkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the basmati rice (dry) per the package.
2. Pan-fry the grilled chicken breast in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the kale until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_with_basmati_rice_bok_choy','Kip met basmatirijst & paksoi','Chicken with basmati rice & bok choy',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"chicken_breast","g":160},{"slug":"basmati_dry","g":70},{"slug":"bok_choy","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Kook de basmatirijst (droog) volgens de verpakking.
2. Bak de kipfilet (gegrild) in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok paksoi beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the basmati rice (dry) per the package.
2. Pan-fry the grilled chicken breast in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the bok choy until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('salmon_with_rice_broccoli','Zalm met rijst & broccoli','Salmon with rice & broccoli',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"salmon","g":150},{"slug":"rice_dry","g":70},{"slug":"broccoli","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['salmonveg','chickenrice','ricechicken']::text[],'1. Kook de witte rijst (droog) volgens de verpakking.
2. Bak of pocheer de zalmfilet kort tot net gaar; kruid met peper en zout.
3. Stoom of wok broccoli beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the white rice (dry) per the package.
2. Sear or poach the salmon fillet until just done; season with salt and pepper.
3. Steam or stir-fry the broccoli until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('salmon_with_rice_green_beans','Zalm met rijst & sperziebonen','Salmon with rice & green beans',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"salmon","g":150},{"slug":"rice_dry","g":70},{"slug":"green_beans","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['salmonveg','chickenrice','ricechicken']::text[],'1. Kook de witte rijst (droog) volgens de verpakking.
2. Bak of pocheer de zalmfilet kort tot net gaar; kruid met peper en zout.
3. Stoom of wok sperziebonen beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the white rice (dry) per the package.
2. Sear or poach the salmon fillet until just done; season with salt and pepper.
3. Steam or stir-fry the green beans until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('salmon_with_rice_spinach','Zalm met rijst & spinazie','Salmon with rice & spinach',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"salmon","g":150},{"slug":"rice_dry","g":70},{"slug":"spinach","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['salmonveg','chickenrice','ricechicken']::text[],'1. Kook de witte rijst (droog) volgens de verpakking.
2. Bak of pocheer de zalmfilet kort tot net gaar; kruid met peper en zout.
3. Stoom of wok spinazie beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the white rice (dry) per the package.
2. Sear or poach the salmon fillet until just done; season with salt and pepper.
3. Steam or stir-fry the spinach until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('salmon_with_rice_asparagus','Zalm met rijst & asperges','Salmon with rice & asparagus',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"salmon","g":150},{"slug":"rice_dry","g":70},{"slug":"asparagus","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['salmonveg','chickenrice','ricechicken']::text[],'1. Kook de witte rijst (droog) volgens de verpakking.
2. Bak of pocheer de zalmfilet kort tot net gaar; kruid met peper en zout.
3. Stoom of wok asperges beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the white rice (dry) per the package.
2. Sear or poach the salmon fillet until just done; season with salt and pepper.
3. Steam or stir-fry the asparagus until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('salmon_with_rice_zucchini','Zalm met rijst & courgette','Salmon with rice & zucchini',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"salmon","g":150},{"slug":"rice_dry","g":70},{"slug":"zucchini","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['salmonveg','chickenrice','ricechicken']::text[],'1. Kook de witte rijst (droog) volgens de verpakking.
2. Bak of pocheer de zalmfilet kort tot net gaar; kruid met peper en zout.
3. Stoom of wok courgette beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the white rice (dry) per the package.
2. Sear or poach the salmon fillet until just done; season with salt and pepper.
3. Steam or stir-fry the zucchini until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('salmon_with_rice_stir_fry_veg','Zalm met rijst & wokgroente','Salmon with rice & stir-fry veg',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"salmon","g":150},{"slug":"rice_dry","g":70},{"slug":"mixed_veg","g":150},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['salmonveg','chickenrice','ricechicken']::text[],'1. Kook de witte rijst (droog) volgens de verpakking.
2. Bak of pocheer de zalmfilet kort tot net gaar; kruid met peper en zout.
3. Stoom of wok wokgroente beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the white rice (dry) per the package.
2. Sear or poach the salmon fillet until just done; season with salt and pepper.
3. Steam or stir-fry the stir-fry veg until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('salmon_with_rice_mushrooms','Zalm met rijst & champignons','Salmon with rice & mushrooms',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"salmon","g":150},{"slug":"rice_dry","g":70},{"slug":"mushroom","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['salmonveg','chickenrice','ricechicken']::text[],'1. Kook de witte rijst (droog) volgens de verpakking.
2. Bak of pocheer de zalmfilet kort tot net gaar; kruid met peper en zout.
3. Stoom of wok champignons beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the white rice (dry) per the package.
2. Sear or poach the salmon fillet until just done; season with salt and pepper.
3. Steam or stir-fry the mushrooms until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('salmon_with_rice_carrot','Zalm met rijst & wortel','Salmon with rice & carrot',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"salmon","g":150},{"slug":"rice_dry","g":70},{"slug":"carrot","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['salmonveg','chickenrice','ricechicken']::text[],'1. Kook de witte rijst (droog) volgens de verpakking.
2. Bak of pocheer de zalmfilet kort tot net gaar; kruid met peper en zout.
3. Stoom of wok wortel beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the white rice (dry) per the package.
2. Sear or poach the salmon fillet until just done; season with salt and pepper.
3. Steam or stir-fry the carrot until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('salmon_with_rice_peas','Zalm met rijst & doperwten','Salmon with rice & peas',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"salmon","g":150},{"slug":"rice_dry","g":70},{"slug":"peas","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['salmonveg','chickenrice','ricechicken']::text[],'1. Kook de witte rijst (droog) volgens de verpakking.
2. Bak of pocheer de zalmfilet kort tot net gaar; kruid met peper en zout.
3. Stoom of wok doperwten beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the white rice (dry) per the package.
2. Sear or poach the salmon fillet until just done; season with salt and pepper.
3. Steam or stir-fry the peas until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('salmon_with_rice_cauliflower','Zalm met rijst & bloemkool','Salmon with rice & cauliflower',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"salmon","g":150},{"slug":"rice_dry","g":70},{"slug":"cauliflower","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['salmonveg','chickenrice','ricechicken']::text[],'1. Kook de witte rijst (droog) volgens de verpakking.
2. Bak of pocheer de zalmfilet kort tot net gaar; kruid met peper en zout.
3. Stoom of wok bloemkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the white rice (dry) per the package.
2. Sear or poach the salmon fillet until just done; season with salt and pepper.
3. Steam or stir-fry the cauliflower until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('salmon_with_rice_kale','Zalm met rijst & boerenkool','Salmon with rice & kale',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"salmon","g":150},{"slug":"rice_dry","g":70},{"slug":"kale","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['salmonveg','chickenrice','ricechicken']::text[],'1. Kook de witte rijst (droog) volgens de verpakking.
2. Bak of pocheer de zalmfilet kort tot net gaar; kruid met peper en zout.
3. Stoom of wok boerenkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the white rice (dry) per the package.
2. Sear or poach the salmon fillet until just done; season with salt and pepper.
3. Steam or stir-fry the kale until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('salmon_with_rice_bok_choy','Zalm met rijst & paksoi','Salmon with rice & bok choy',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"salmon","g":150},{"slug":"rice_dry","g":70},{"slug":"bok_choy","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['salmonveg','chickenrice','ricechicken']::text[],'1. Kook de witte rijst (droog) volgens de verpakking.
2. Bak of pocheer de zalmfilet kort tot net gaar; kruid met peper en zout.
3. Stoom of wok paksoi beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the white rice (dry) per the package.
2. Sear or poach the salmon fillet until just done; season with salt and pepper.
3. Steam or stir-fry the bok choy until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('salmon_with_sweet_potato_broccoli','Zalm met zoete aardappel & broccoli','Salmon with sweet potato & broccoli',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"salmon","g":150},{"slug":"sweet_potato","g":200},{"slug":"broccoli","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['salmonveg']::text[],'1. Kook de zoete aardappel volgens de verpakking.
2. Bak of pocheer de zalmfilet kort tot net gaar; kruid met peper en zout.
3. Stoom of wok broccoli beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the sweet potato per the package.
2. Sear or poach the salmon fillet until just done; season with salt and pepper.
3. Steam or stir-fry the broccoli until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('salmon_with_sweet_potato_green_beans','Zalm met zoete aardappel & sperziebonen','Salmon with sweet potato & green beans',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"salmon","g":150},{"slug":"sweet_potato","g":200},{"slug":"green_beans","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['salmonveg']::text[],'1. Kook de zoete aardappel volgens de verpakking.
2. Bak of pocheer de zalmfilet kort tot net gaar; kruid met peper en zout.
3. Stoom of wok sperziebonen beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the sweet potato per the package.
2. Sear or poach the salmon fillet until just done; season with salt and pepper.
3. Steam or stir-fry the green beans until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('salmon_with_sweet_potato_spinach','Zalm met zoete aardappel & spinazie','Salmon with sweet potato & spinach',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"salmon","g":150},{"slug":"sweet_potato","g":200},{"slug":"spinach","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['salmonveg']::text[],'1. Kook de zoete aardappel volgens de verpakking.
2. Bak of pocheer de zalmfilet kort tot net gaar; kruid met peper en zout.
3. Stoom of wok spinazie beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the sweet potato per the package.
2. Sear or poach the salmon fillet until just done; season with salt and pepper.
3. Steam or stir-fry the spinach until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('salmon_with_sweet_potato_asparagus','Zalm met zoete aardappel & asperges','Salmon with sweet potato & asparagus',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"salmon","g":150},{"slug":"sweet_potato","g":200},{"slug":"asparagus","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['salmonveg']::text[],'1. Kook de zoete aardappel volgens de verpakking.
2. Bak of pocheer de zalmfilet kort tot net gaar; kruid met peper en zout.
3. Stoom of wok asperges beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the sweet potato per the package.
2. Sear or poach the salmon fillet until just done; season with salt and pepper.
3. Steam or stir-fry the asparagus until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('salmon_with_sweet_potato_zucchini','Zalm met zoete aardappel & courgette','Salmon with sweet potato & zucchini',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"salmon","g":150},{"slug":"sweet_potato","g":200},{"slug":"zucchini","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['salmonveg']::text[],'1. Kook de zoete aardappel volgens de verpakking.
2. Bak of pocheer de zalmfilet kort tot net gaar; kruid met peper en zout.
3. Stoom of wok courgette beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the sweet potato per the package.
2. Sear or poach the salmon fillet until just done; season with salt and pepper.
3. Steam or stir-fry the zucchini until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('salmon_with_sweet_potato_stir_fry_veg','Zalm met zoete aardappel & wokgroente','Salmon with sweet potato & stir-fry veg',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"salmon","g":150},{"slug":"sweet_potato","g":200},{"slug":"mixed_veg","g":150},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['salmonveg']::text[],'1. Kook de zoete aardappel volgens de verpakking.
2. Bak of pocheer de zalmfilet kort tot net gaar; kruid met peper en zout.
3. Stoom of wok wokgroente beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the sweet potato per the package.
2. Sear or poach the salmon fillet until just done; season with salt and pepper.
3. Steam or stir-fry the stir-fry veg until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('salmon_with_sweet_potato_mushrooms','Zalm met zoete aardappel & champignons','Salmon with sweet potato & mushrooms',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"salmon","g":150},{"slug":"sweet_potato","g":200},{"slug":"mushroom","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['salmonveg']::text[],'1. Kook de zoete aardappel volgens de verpakking.
2. Bak of pocheer de zalmfilet kort tot net gaar; kruid met peper en zout.
3. Stoom of wok champignons beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the sweet potato per the package.
2. Sear or poach the salmon fillet until just done; season with salt and pepper.
3. Steam or stir-fry the mushrooms until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('salmon_with_sweet_potato_carrot','Zalm met zoete aardappel & wortel','Salmon with sweet potato & carrot',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"salmon","g":150},{"slug":"sweet_potato","g":200},{"slug":"carrot","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['salmonveg']::text[],'1. Kook de zoete aardappel volgens de verpakking.
2. Bak of pocheer de zalmfilet kort tot net gaar; kruid met peper en zout.
3. Stoom of wok wortel beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the sweet potato per the package.
2. Sear or poach the salmon fillet until just done; season with salt and pepper.
3. Steam or stir-fry the carrot until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('salmon_with_sweet_potato_peas','Zalm met zoete aardappel & doperwten','Salmon with sweet potato & peas',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"salmon","g":150},{"slug":"sweet_potato","g":200},{"slug":"peas","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['salmonveg']::text[],'1. Kook de zoete aardappel volgens de verpakking.
2. Bak of pocheer de zalmfilet kort tot net gaar; kruid met peper en zout.
3. Stoom of wok doperwten beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the sweet potato per the package.
2. Sear or poach the salmon fillet until just done; season with salt and pepper.
3. Steam or stir-fry the peas until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('salmon_with_sweet_potato_cauliflower','Zalm met zoete aardappel & bloemkool','Salmon with sweet potato & cauliflower',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"salmon","g":150},{"slug":"sweet_potato","g":200},{"slug":"cauliflower","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['salmonveg']::text[],'1. Kook de zoete aardappel volgens de verpakking.
2. Bak of pocheer de zalmfilet kort tot net gaar; kruid met peper en zout.
3. Stoom of wok bloemkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the sweet potato per the package.
2. Sear or poach the salmon fillet until just done; season with salt and pepper.
3. Steam or stir-fry the cauliflower until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('salmon_with_sweet_potato_kale','Zalm met zoete aardappel & boerenkool','Salmon with sweet potato & kale',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"salmon","g":150},{"slug":"sweet_potato","g":200},{"slug":"kale","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['salmonveg']::text[],'1. Kook de zoete aardappel volgens de verpakking.
2. Bak of pocheer de zalmfilet kort tot net gaar; kruid met peper en zout.
3. Stoom of wok boerenkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the sweet potato per the package.
2. Sear or poach the salmon fillet until just done; season with salt and pepper.
3. Steam or stir-fry the kale until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('salmon_with_sweet_potato_bok_choy','Zalm met zoete aardappel & paksoi','Salmon with sweet potato & bok choy',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"salmon","g":150},{"slug":"sweet_potato","g":200},{"slug":"bok_choy","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['salmonveg']::text[],'1. Kook de zoete aardappel volgens de verpakking.
2. Bak of pocheer de zalmfilet kort tot net gaar; kruid met peper en zout.
3. Stoom of wok paksoi beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the sweet potato per the package.
2. Sear or poach the salmon fillet until just done; season with salt and pepper.
3. Steam or stir-fry the bok choy until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('salmon_with_potato_broccoli','Zalm met aardappel & broccoli','Salmon with potato & broccoli',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"salmon","g":150},{"slug":"potato","g":250},{"slug":"broccoli","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['salmonveg','steakpotato']::text[],'1. Kook de aardappel volgens de verpakking.
2. Bak of pocheer de zalmfilet kort tot net gaar; kruid met peper en zout.
3. Stoom of wok broccoli beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the potato per the package.
2. Sear or poach the salmon fillet until just done; season with salt and pepper.
3. Steam or stir-fry the broccoli until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('salmon_with_potato_green_beans','Zalm met aardappel & sperziebonen','Salmon with potato & green beans',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"salmon","g":150},{"slug":"potato","g":250},{"slug":"green_beans","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['salmonveg','steakpotato']::text[],'1. Kook de aardappel volgens de verpakking.
2. Bak of pocheer de zalmfilet kort tot net gaar; kruid met peper en zout.
3. Stoom of wok sperziebonen beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the potato per the package.
2. Sear or poach the salmon fillet until just done; season with salt and pepper.
3. Steam or stir-fry the green beans until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('salmon_with_potato_spinach','Zalm met aardappel & spinazie','Salmon with potato & spinach',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"salmon","g":150},{"slug":"potato","g":250},{"slug":"spinach","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['salmonveg','steakpotato']::text[],'1. Kook de aardappel volgens de verpakking.
2. Bak of pocheer de zalmfilet kort tot net gaar; kruid met peper en zout.
3. Stoom of wok spinazie beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the potato per the package.
2. Sear or poach the salmon fillet until just done; season with salt and pepper.
3. Steam or stir-fry the spinach until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('salmon_with_potato_asparagus','Zalm met aardappel & asperges','Salmon with potato & asparagus',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"salmon","g":150},{"slug":"potato","g":250},{"slug":"asparagus","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['salmonveg','steakpotato']::text[],'1. Kook de aardappel volgens de verpakking.
2. Bak of pocheer de zalmfilet kort tot net gaar; kruid met peper en zout.
3. Stoom of wok asperges beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the potato per the package.
2. Sear or poach the salmon fillet until just done; season with salt and pepper.
3. Steam or stir-fry the asparagus until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('salmon_with_potato_zucchini','Zalm met aardappel & courgette','Salmon with potato & zucchini',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"salmon","g":150},{"slug":"potato","g":250},{"slug":"zucchini","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['salmonveg','steakpotato']::text[],'1. Kook de aardappel volgens de verpakking.
2. Bak of pocheer de zalmfilet kort tot net gaar; kruid met peper en zout.
3. Stoom of wok courgette beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the potato per the package.
2. Sear or poach the salmon fillet until just done; season with salt and pepper.
3. Steam or stir-fry the zucchini until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('salmon_with_potato_stir_fry_veg','Zalm met aardappel & wokgroente','Salmon with potato & stir-fry veg',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"salmon","g":150},{"slug":"potato","g":250},{"slug":"mixed_veg","g":150},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['salmonveg','steakpotato']::text[],'1. Kook de aardappel volgens de verpakking.
2. Bak of pocheer de zalmfilet kort tot net gaar; kruid met peper en zout.
3. Stoom of wok wokgroente beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the potato per the package.
2. Sear or poach the salmon fillet until just done; season with salt and pepper.
3. Steam or stir-fry the stir-fry veg until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('salmon_with_potato_mushrooms','Zalm met aardappel & champignons','Salmon with potato & mushrooms',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"salmon","g":150},{"slug":"potato","g":250},{"slug":"mushroom","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['salmonveg','steakpotato']::text[],'1. Kook de aardappel volgens de verpakking.
2. Bak of pocheer de zalmfilet kort tot net gaar; kruid met peper en zout.
3. Stoom of wok champignons beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the potato per the package.
2. Sear or poach the salmon fillet until just done; season with salt and pepper.
3. Steam or stir-fry the mushrooms until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('salmon_with_potato_carrot','Zalm met aardappel & wortel','Salmon with potato & carrot',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"salmon","g":150},{"slug":"potato","g":250},{"slug":"carrot","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['salmonveg','steakpotato']::text[],'1. Kook de aardappel volgens de verpakking.
2. Bak of pocheer de zalmfilet kort tot net gaar; kruid met peper en zout.
3. Stoom of wok wortel beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the potato per the package.
2. Sear or poach the salmon fillet until just done; season with salt and pepper.
3. Steam or stir-fry the carrot until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('salmon_with_potato_peas','Zalm met aardappel & doperwten','Salmon with potato & peas',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"salmon","g":150},{"slug":"potato","g":250},{"slug":"peas","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['salmonveg','steakpotato']::text[],'1. Kook de aardappel volgens de verpakking.
2. Bak of pocheer de zalmfilet kort tot net gaar; kruid met peper en zout.
3. Stoom of wok doperwten beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the potato per the package.
2. Sear or poach the salmon fillet until just done; season with salt and pepper.
3. Steam or stir-fry the peas until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('salmon_with_potato_cauliflower','Zalm met aardappel & bloemkool','Salmon with potato & cauliflower',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"salmon","g":150},{"slug":"potato","g":250},{"slug":"cauliflower","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['salmonveg','steakpotato']::text[],'1. Kook de aardappel volgens de verpakking.
2. Bak of pocheer de zalmfilet kort tot net gaar; kruid met peper en zout.
3. Stoom of wok bloemkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the potato per the package.
2. Sear or poach the salmon fillet until just done; season with salt and pepper.
3. Steam or stir-fry the cauliflower until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('salmon_with_potato_kale','Zalm met aardappel & boerenkool','Salmon with potato & kale',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"salmon","g":150},{"slug":"potato","g":250},{"slug":"kale","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['salmonveg','steakpotato']::text[],'1. Kook de aardappel volgens de verpakking.
2. Bak of pocheer de zalmfilet kort tot net gaar; kruid met peper en zout.
3. Stoom of wok boerenkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the potato per the package.
2. Sear or poach the salmon fillet until just done; season with salt and pepper.
3. Steam or stir-fry the kale until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('salmon_with_potato_bok_choy','Zalm met aardappel & paksoi','Salmon with potato & bok choy',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"salmon","g":150},{"slug":"potato","g":250},{"slug":"bok_choy","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['salmonveg','steakpotato']::text[],'1. Kook de aardappel volgens de verpakking.
2. Bak of pocheer de zalmfilet kort tot net gaar; kruid met peper en zout.
3. Stoom of wok paksoi beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the potato per the package.
2. Sear or poach the salmon fillet until just done; season with salt and pepper.
3. Steam or stir-fry the bok choy until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('salmon_with_quinoa_broccoli','Zalm met quinoa & broccoli','Salmon with quinoa & broccoli',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"salmon","g":150},{"slug":"quinoa_dry","g":70},{"slug":"broccoli","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['salmonveg']::text[],'1. Kook de quinoa (droog) volgens de verpakking.
2. Bak of pocheer de zalmfilet kort tot net gaar; kruid met peper en zout.
3. Stoom of wok broccoli beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the quinoa (dry) per the package.
2. Sear or poach the salmon fillet until just done; season with salt and pepper.
3. Steam or stir-fry the broccoli until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('salmon_with_quinoa_green_beans','Zalm met quinoa & sperziebonen','Salmon with quinoa & green beans',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"salmon","g":150},{"slug":"quinoa_dry","g":70},{"slug":"green_beans","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['salmonveg']::text[],'1. Kook de quinoa (droog) volgens de verpakking.
2. Bak of pocheer de zalmfilet kort tot net gaar; kruid met peper en zout.
3. Stoom of wok sperziebonen beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the quinoa (dry) per the package.
2. Sear or poach the salmon fillet until just done; season with salt and pepper.
3. Steam or stir-fry the green beans until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('salmon_with_quinoa_spinach','Zalm met quinoa & spinazie','Salmon with quinoa & spinach',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"salmon","g":150},{"slug":"quinoa_dry","g":70},{"slug":"spinach","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['salmonveg']::text[],'1. Kook de quinoa (droog) volgens de verpakking.
2. Bak of pocheer de zalmfilet kort tot net gaar; kruid met peper en zout.
3. Stoom of wok spinazie beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the quinoa (dry) per the package.
2. Sear or poach the salmon fillet until just done; season with salt and pepper.
3. Steam or stir-fry the spinach until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('salmon_with_quinoa_asparagus','Zalm met quinoa & asperges','Salmon with quinoa & asparagus',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"salmon","g":150},{"slug":"quinoa_dry","g":70},{"slug":"asparagus","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['salmonveg']::text[],'1. Kook de quinoa (droog) volgens de verpakking.
2. Bak of pocheer de zalmfilet kort tot net gaar; kruid met peper en zout.
3. Stoom of wok asperges beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the quinoa (dry) per the package.
2. Sear or poach the salmon fillet until just done; season with salt and pepper.
3. Steam or stir-fry the asparagus until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('salmon_with_quinoa_zucchini','Zalm met quinoa & courgette','Salmon with quinoa & zucchini',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"salmon","g":150},{"slug":"quinoa_dry","g":70},{"slug":"zucchini","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['salmonveg']::text[],'1. Kook de quinoa (droog) volgens de verpakking.
2. Bak of pocheer de zalmfilet kort tot net gaar; kruid met peper en zout.
3. Stoom of wok courgette beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the quinoa (dry) per the package.
2. Sear or poach the salmon fillet until just done; season with salt and pepper.
3. Steam or stir-fry the zucchini until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('salmon_with_quinoa_stir_fry_veg','Zalm met quinoa & wokgroente','Salmon with quinoa & stir-fry veg',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"salmon","g":150},{"slug":"quinoa_dry","g":70},{"slug":"mixed_veg","g":150},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['salmonveg']::text[],'1. Kook de quinoa (droog) volgens de verpakking.
2. Bak of pocheer de zalmfilet kort tot net gaar; kruid met peper en zout.
3. Stoom of wok wokgroente beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the quinoa (dry) per the package.
2. Sear or poach the salmon fillet until just done; season with salt and pepper.
3. Steam or stir-fry the stir-fry veg until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('salmon_with_quinoa_mushrooms','Zalm met quinoa & champignons','Salmon with quinoa & mushrooms',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"salmon","g":150},{"slug":"quinoa_dry","g":70},{"slug":"mushroom","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['salmonveg']::text[],'1. Kook de quinoa (droog) volgens de verpakking.
2. Bak of pocheer de zalmfilet kort tot net gaar; kruid met peper en zout.
3. Stoom of wok champignons beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the quinoa (dry) per the package.
2. Sear or poach the salmon fillet until just done; season with salt and pepper.
3. Steam or stir-fry the mushrooms until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('salmon_with_quinoa_carrot','Zalm met quinoa & wortel','Salmon with quinoa & carrot',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"salmon","g":150},{"slug":"quinoa_dry","g":70},{"slug":"carrot","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['salmonveg']::text[],'1. Kook de quinoa (droog) volgens de verpakking.
2. Bak of pocheer de zalmfilet kort tot net gaar; kruid met peper en zout.
3. Stoom of wok wortel beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the quinoa (dry) per the package.
2. Sear or poach the salmon fillet until just done; season with salt and pepper.
3. Steam or stir-fry the carrot until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('salmon_with_quinoa_peas','Zalm met quinoa & doperwten','Salmon with quinoa & peas',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"salmon","g":150},{"slug":"quinoa_dry","g":70},{"slug":"peas","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['salmonveg']::text[],'1. Kook de quinoa (droog) volgens de verpakking.
2. Bak of pocheer de zalmfilet kort tot net gaar; kruid met peper en zout.
3. Stoom of wok doperwten beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the quinoa (dry) per the package.
2. Sear or poach the salmon fillet until just done; season with salt and pepper.
3. Steam or stir-fry the peas until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('salmon_with_quinoa_cauliflower','Zalm met quinoa & bloemkool','Salmon with quinoa & cauliflower',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"salmon","g":150},{"slug":"quinoa_dry","g":70},{"slug":"cauliflower","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['salmonveg']::text[],'1. Kook de quinoa (droog) volgens de verpakking.
2. Bak of pocheer de zalmfilet kort tot net gaar; kruid met peper en zout.
3. Stoom of wok bloemkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the quinoa (dry) per the package.
2. Sear or poach the salmon fillet until just done; season with salt and pepper.
3. Steam or stir-fry the cauliflower until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('salmon_with_quinoa_kale','Zalm met quinoa & boerenkool','Salmon with quinoa & kale',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"salmon","g":150},{"slug":"quinoa_dry","g":70},{"slug":"kale","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['salmonveg']::text[],'1. Kook de quinoa (droog) volgens de verpakking.
2. Bak of pocheer de zalmfilet kort tot net gaar; kruid met peper en zout.
3. Stoom of wok boerenkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the quinoa (dry) per the package.
2. Sear or poach the salmon fillet until just done; season with salt and pepper.
3. Steam or stir-fry the kale until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('salmon_with_quinoa_bok_choy','Zalm met quinoa & paksoi','Salmon with quinoa & bok choy',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"salmon","g":150},{"slug":"quinoa_dry","g":70},{"slug":"bok_choy","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['salmonveg']::text[],'1. Kook de quinoa (droog) volgens de verpakking.
2. Bak of pocheer de zalmfilet kort tot net gaar; kruid met peper en zout.
3. Stoom of wok paksoi beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the quinoa (dry) per the package.
2. Sear or poach the salmon fillet until just done; season with salt and pepper.
3. Steam or stir-fry the bok choy until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('salmon_with_couscous_broccoli','Zalm met couscous & broccoli','Salmon with couscous & broccoli',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"salmon","g":150},{"slug":"couscous_dry","g":70},{"slug":"broccoli","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['salmonveg']::text[],'1. Kook de volkoren couscous (droog) volgens de verpakking.
2. Bak of pocheer de zalmfilet kort tot net gaar; kruid met peper en zout.
3. Stoom of wok broccoli beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat couscous (dry) per the package.
2. Sear or poach the salmon fillet until just done; season with salt and pepper.
3. Steam or stir-fry the broccoli until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('salmon_with_couscous_green_beans','Zalm met couscous & sperziebonen','Salmon with couscous & green beans',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"salmon","g":150},{"slug":"couscous_dry","g":70},{"slug":"green_beans","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['salmonveg']::text[],'1. Kook de volkoren couscous (droog) volgens de verpakking.
2. Bak of pocheer de zalmfilet kort tot net gaar; kruid met peper en zout.
3. Stoom of wok sperziebonen beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat couscous (dry) per the package.
2. Sear or poach the salmon fillet until just done; season with salt and pepper.
3. Steam or stir-fry the green beans until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('salmon_with_couscous_spinach','Zalm met couscous & spinazie','Salmon with couscous & spinach',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"salmon","g":150},{"slug":"couscous_dry","g":70},{"slug":"spinach","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['salmonveg']::text[],'1. Kook de volkoren couscous (droog) volgens de verpakking.
2. Bak of pocheer de zalmfilet kort tot net gaar; kruid met peper en zout.
3. Stoom of wok spinazie beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat couscous (dry) per the package.
2. Sear or poach the salmon fillet until just done; season with salt and pepper.
3. Steam or stir-fry the spinach until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('salmon_with_couscous_asparagus','Zalm met couscous & asperges','Salmon with couscous & asparagus',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"salmon","g":150},{"slug":"couscous_dry","g":70},{"slug":"asparagus","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['salmonveg']::text[],'1. Kook de volkoren couscous (droog) volgens de verpakking.
2. Bak of pocheer de zalmfilet kort tot net gaar; kruid met peper en zout.
3. Stoom of wok asperges beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat couscous (dry) per the package.
2. Sear or poach the salmon fillet until just done; season with salt and pepper.
3. Steam or stir-fry the asparagus until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('salmon_with_couscous_zucchini','Zalm met couscous & courgette','Salmon with couscous & zucchini',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"salmon","g":150},{"slug":"couscous_dry","g":70},{"slug":"zucchini","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['salmonveg']::text[],'1. Kook de volkoren couscous (droog) volgens de verpakking.
2. Bak of pocheer de zalmfilet kort tot net gaar; kruid met peper en zout.
3. Stoom of wok courgette beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat couscous (dry) per the package.
2. Sear or poach the salmon fillet until just done; season with salt and pepper.
3. Steam or stir-fry the zucchini until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('salmon_with_couscous_stir_fry_veg','Zalm met couscous & wokgroente','Salmon with couscous & stir-fry veg',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"salmon","g":150},{"slug":"couscous_dry","g":70},{"slug":"mixed_veg","g":150},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['salmonveg']::text[],'1. Kook de volkoren couscous (droog) volgens de verpakking.
2. Bak of pocheer de zalmfilet kort tot net gaar; kruid met peper en zout.
3. Stoom of wok wokgroente beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat couscous (dry) per the package.
2. Sear or poach the salmon fillet until just done; season with salt and pepper.
3. Steam or stir-fry the stir-fry veg until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('salmon_with_couscous_mushrooms','Zalm met couscous & champignons','Salmon with couscous & mushrooms',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"salmon","g":150},{"slug":"couscous_dry","g":70},{"slug":"mushroom","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['salmonveg']::text[],'1. Kook de volkoren couscous (droog) volgens de verpakking.
2. Bak of pocheer de zalmfilet kort tot net gaar; kruid met peper en zout.
3. Stoom of wok champignons beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat couscous (dry) per the package.
2. Sear or poach the salmon fillet until just done; season with salt and pepper.
3. Steam or stir-fry the mushrooms until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('salmon_with_couscous_carrot','Zalm met couscous & wortel','Salmon with couscous & carrot',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"salmon","g":150},{"slug":"couscous_dry","g":70},{"slug":"carrot","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['salmonveg']::text[],'1. Kook de volkoren couscous (droog) volgens de verpakking.
2. Bak of pocheer de zalmfilet kort tot net gaar; kruid met peper en zout.
3. Stoom of wok wortel beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat couscous (dry) per the package.
2. Sear or poach the salmon fillet until just done; season with salt and pepper.
3. Steam or stir-fry the carrot until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('salmon_with_couscous_peas','Zalm met couscous & doperwten','Salmon with couscous & peas',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"salmon","g":150},{"slug":"couscous_dry","g":70},{"slug":"peas","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['salmonveg']::text[],'1. Kook de volkoren couscous (droog) volgens de verpakking.
2. Bak of pocheer de zalmfilet kort tot net gaar; kruid met peper en zout.
3. Stoom of wok doperwten beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat couscous (dry) per the package.
2. Sear or poach the salmon fillet until just done; season with salt and pepper.
3. Steam or stir-fry the peas until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('salmon_with_couscous_cauliflower','Zalm met couscous & bloemkool','Salmon with couscous & cauliflower',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"salmon","g":150},{"slug":"couscous_dry","g":70},{"slug":"cauliflower","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['salmonveg']::text[],'1. Kook de volkoren couscous (droog) volgens de verpakking.
2. Bak of pocheer de zalmfilet kort tot net gaar; kruid met peper en zout.
3. Stoom of wok bloemkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat couscous (dry) per the package.
2. Sear or poach the salmon fillet until just done; season with salt and pepper.
3. Steam or stir-fry the cauliflower until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('salmon_with_couscous_kale','Zalm met couscous & boerenkool','Salmon with couscous & kale',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"salmon","g":150},{"slug":"couscous_dry","g":70},{"slug":"kale","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['salmonveg']::text[],'1. Kook de volkoren couscous (droog) volgens de verpakking.
2. Bak of pocheer de zalmfilet kort tot net gaar; kruid met peper en zout.
3. Stoom of wok boerenkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat couscous (dry) per the package.
2. Sear or poach the salmon fillet until just done; season with salt and pepper.
3. Steam or stir-fry the kale until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('salmon_with_couscous_bok_choy','Zalm met couscous & paksoi','Salmon with couscous & bok choy',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"salmon","g":150},{"slug":"couscous_dry","g":70},{"slug":"bok_choy","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['salmonveg']::text[],'1. Kook de volkoren couscous (droog) volgens de verpakking.
2. Bak of pocheer de zalmfilet kort tot net gaar; kruid met peper en zout.
3. Stoom of wok paksoi beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat couscous (dry) per the package.
2. Sear or poach the salmon fillet until just done; season with salt and pepper.
3. Steam or stir-fry the bok choy until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('salmon_with_bulgur_broccoli','Zalm met bulgur & broccoli','Salmon with bulgur & broccoli',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"salmon","g":150},{"slug":"bulgur_dry","g":70},{"slug":"broccoli","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['salmonveg']::text[],'1. Kook de bulgur (droog) volgens de verpakking.
2. Bak of pocheer de zalmfilet kort tot net gaar; kruid met peper en zout.
3. Stoom of wok broccoli beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the bulgur (dry) per the package.
2. Sear or poach the salmon fillet until just done; season with salt and pepper.
3. Steam or stir-fry the broccoli until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('salmon_with_bulgur_green_beans','Zalm met bulgur & sperziebonen','Salmon with bulgur & green beans',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"salmon","g":150},{"slug":"bulgur_dry","g":70},{"slug":"green_beans","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['salmonveg']::text[],'1. Kook de bulgur (droog) volgens de verpakking.
2. Bak of pocheer de zalmfilet kort tot net gaar; kruid met peper en zout.
3. Stoom of wok sperziebonen beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the bulgur (dry) per the package.
2. Sear or poach the salmon fillet until just done; season with salt and pepper.
3. Steam or stir-fry the green beans until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('salmon_with_bulgur_spinach','Zalm met bulgur & spinazie','Salmon with bulgur & spinach',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"salmon","g":150},{"slug":"bulgur_dry","g":70},{"slug":"spinach","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['salmonveg']::text[],'1. Kook de bulgur (droog) volgens de verpakking.
2. Bak of pocheer de zalmfilet kort tot net gaar; kruid met peper en zout.
3. Stoom of wok spinazie beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the bulgur (dry) per the package.
2. Sear or poach the salmon fillet until just done; season with salt and pepper.
3. Steam or stir-fry the spinach until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('salmon_with_bulgur_asparagus','Zalm met bulgur & asperges','Salmon with bulgur & asparagus',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"salmon","g":150},{"slug":"bulgur_dry","g":70},{"slug":"asparagus","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['salmonveg']::text[],'1. Kook de bulgur (droog) volgens de verpakking.
2. Bak of pocheer de zalmfilet kort tot net gaar; kruid met peper en zout.
3. Stoom of wok asperges beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the bulgur (dry) per the package.
2. Sear or poach the salmon fillet until just done; season with salt and pepper.
3. Steam or stir-fry the asparagus until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('salmon_with_bulgur_zucchini','Zalm met bulgur & courgette','Salmon with bulgur & zucchini',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"salmon","g":150},{"slug":"bulgur_dry","g":70},{"slug":"zucchini","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['salmonveg']::text[],'1. Kook de bulgur (droog) volgens de verpakking.
2. Bak of pocheer de zalmfilet kort tot net gaar; kruid met peper en zout.
3. Stoom of wok courgette beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the bulgur (dry) per the package.
2. Sear or poach the salmon fillet until just done; season with salt and pepper.
3. Steam or stir-fry the zucchini until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('salmon_with_bulgur_stir_fry_veg','Zalm met bulgur & wokgroente','Salmon with bulgur & stir-fry veg',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"salmon","g":150},{"slug":"bulgur_dry","g":70},{"slug":"mixed_veg","g":150},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['salmonveg']::text[],'1. Kook de bulgur (droog) volgens de verpakking.
2. Bak of pocheer de zalmfilet kort tot net gaar; kruid met peper en zout.
3. Stoom of wok wokgroente beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the bulgur (dry) per the package.
2. Sear or poach the salmon fillet until just done; season with salt and pepper.
3. Steam or stir-fry the stir-fry veg until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('salmon_with_bulgur_mushrooms','Zalm met bulgur & champignons','Salmon with bulgur & mushrooms',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"salmon","g":150},{"slug":"bulgur_dry","g":70},{"slug":"mushroom","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['salmonveg']::text[],'1. Kook de bulgur (droog) volgens de verpakking.
2. Bak of pocheer de zalmfilet kort tot net gaar; kruid met peper en zout.
3. Stoom of wok champignons beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the bulgur (dry) per the package.
2. Sear or poach the salmon fillet until just done; season with salt and pepper.
3. Steam or stir-fry the mushrooms until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('salmon_with_bulgur_carrot','Zalm met bulgur & wortel','Salmon with bulgur & carrot',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"salmon","g":150},{"slug":"bulgur_dry","g":70},{"slug":"carrot","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['salmonveg']::text[],'1. Kook de bulgur (droog) volgens de verpakking.
2. Bak of pocheer de zalmfilet kort tot net gaar; kruid met peper en zout.
3. Stoom of wok wortel beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the bulgur (dry) per the package.
2. Sear or poach the salmon fillet until just done; season with salt and pepper.
3. Steam or stir-fry the carrot until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('salmon_with_bulgur_peas','Zalm met bulgur & doperwten','Salmon with bulgur & peas',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"salmon","g":150},{"slug":"bulgur_dry","g":70},{"slug":"peas","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['salmonveg']::text[],'1. Kook de bulgur (droog) volgens de verpakking.
2. Bak of pocheer de zalmfilet kort tot net gaar; kruid met peper en zout.
3. Stoom of wok doperwten beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the bulgur (dry) per the package.
2. Sear or poach the salmon fillet until just done; season with salt and pepper.
3. Steam or stir-fry the peas until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('salmon_with_bulgur_cauliflower','Zalm met bulgur & bloemkool','Salmon with bulgur & cauliflower',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"salmon","g":150},{"slug":"bulgur_dry","g":70},{"slug":"cauliflower","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['salmonveg']::text[],'1. Kook de bulgur (droog) volgens de verpakking.
2. Bak of pocheer de zalmfilet kort tot net gaar; kruid met peper en zout.
3. Stoom of wok bloemkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the bulgur (dry) per the package.
2. Sear or poach the salmon fillet until just done; season with salt and pepper.
3. Steam or stir-fry the cauliflower until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('salmon_with_bulgur_kale','Zalm met bulgur & boerenkool','Salmon with bulgur & kale',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"salmon","g":150},{"slug":"bulgur_dry","g":70},{"slug":"kale","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['salmonveg']::text[],'1. Kook de bulgur (droog) volgens de verpakking.
2. Bak of pocheer de zalmfilet kort tot net gaar; kruid met peper en zout.
3. Stoom of wok boerenkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the bulgur (dry) per the package.
2. Sear or poach the salmon fillet until just done; season with salt and pepper.
3. Steam or stir-fry the kale until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('salmon_with_bulgur_bok_choy','Zalm met bulgur & paksoi','Salmon with bulgur & bok choy',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"salmon","g":150},{"slug":"bulgur_dry","g":70},{"slug":"bok_choy","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['salmonveg']::text[],'1. Kook de bulgur (droog) volgens de verpakking.
2. Bak of pocheer de zalmfilet kort tot net gaar; kruid met peper en zout.
3. Stoom of wok paksoi beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the bulgur (dry) per the package.
2. Sear or poach the salmon fillet until just done; season with salt and pepper.
3. Steam or stir-fry the bok choy until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('salmon_with_basmati_rice_broccoli','Zalm met basmatirijst & broccoli','Salmon with basmati rice & broccoli',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"salmon","g":150},{"slug":"basmati_dry","g":70},{"slug":"broccoli","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['salmonveg']::text[],'1. Kook de basmatirijst (droog) volgens de verpakking.
2. Bak of pocheer de zalmfilet kort tot net gaar; kruid met peper en zout.
3. Stoom of wok broccoli beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the basmati rice (dry) per the package.
2. Sear or poach the salmon fillet until just done; season with salt and pepper.
3. Steam or stir-fry the broccoli until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('salmon_with_basmati_rice_green_beans','Zalm met basmatirijst & sperziebonen','Salmon with basmati rice & green beans',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"salmon","g":150},{"slug":"basmati_dry","g":70},{"slug":"green_beans","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['salmonveg']::text[],'1. Kook de basmatirijst (droog) volgens de verpakking.
2. Bak of pocheer de zalmfilet kort tot net gaar; kruid met peper en zout.
3. Stoom of wok sperziebonen beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the basmati rice (dry) per the package.
2. Sear or poach the salmon fillet until just done; season with salt and pepper.
3. Steam or stir-fry the green beans until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('salmon_with_basmati_rice_spinach','Zalm met basmatirijst & spinazie','Salmon with basmati rice & spinach',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"salmon","g":150},{"slug":"basmati_dry","g":70},{"slug":"spinach","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['salmonveg']::text[],'1. Kook de basmatirijst (droog) volgens de verpakking.
2. Bak of pocheer de zalmfilet kort tot net gaar; kruid met peper en zout.
3. Stoom of wok spinazie beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the basmati rice (dry) per the package.
2. Sear or poach the salmon fillet until just done; season with salt and pepper.
3. Steam or stir-fry the spinach until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('salmon_with_basmati_rice_asparagus','Zalm met basmatirijst & asperges','Salmon with basmati rice & asparagus',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"salmon","g":150},{"slug":"basmati_dry","g":70},{"slug":"asparagus","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['salmonveg']::text[],'1. Kook de basmatirijst (droog) volgens de verpakking.
2. Bak of pocheer de zalmfilet kort tot net gaar; kruid met peper en zout.
3. Stoom of wok asperges beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the basmati rice (dry) per the package.
2. Sear or poach the salmon fillet until just done; season with salt and pepper.
3. Steam or stir-fry the asparagus until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('salmon_with_basmati_rice_zucchini','Zalm met basmatirijst & courgette','Salmon with basmati rice & zucchini',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"salmon","g":150},{"slug":"basmati_dry","g":70},{"slug":"zucchini","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['salmonveg']::text[],'1. Kook de basmatirijst (droog) volgens de verpakking.
2. Bak of pocheer de zalmfilet kort tot net gaar; kruid met peper en zout.
3. Stoom of wok courgette beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the basmati rice (dry) per the package.
2. Sear or poach the salmon fillet until just done; season with salt and pepper.
3. Steam or stir-fry the zucchini until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('salmon_with_basmati_rice_stir_fry_veg','Zalm met basmatirijst & wokgroente','Salmon with basmati rice & stir-fry veg',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"salmon","g":150},{"slug":"basmati_dry","g":70},{"slug":"mixed_veg","g":150},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['salmonveg']::text[],'1. Kook de basmatirijst (droog) volgens de verpakking.
2. Bak of pocheer de zalmfilet kort tot net gaar; kruid met peper en zout.
3. Stoom of wok wokgroente beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the basmati rice (dry) per the package.
2. Sear or poach the salmon fillet until just done; season with salt and pepper.
3. Steam or stir-fry the stir-fry veg until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('salmon_with_basmati_rice_mushrooms','Zalm met basmatirijst & champignons','Salmon with basmati rice & mushrooms',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"salmon","g":150},{"slug":"basmati_dry","g":70},{"slug":"mushroom","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['salmonveg']::text[],'1. Kook de basmatirijst (droog) volgens de verpakking.
2. Bak of pocheer de zalmfilet kort tot net gaar; kruid met peper en zout.
3. Stoom of wok champignons beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the basmati rice (dry) per the package.
2. Sear or poach the salmon fillet until just done; season with salt and pepper.
3. Steam or stir-fry the mushrooms until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('salmon_with_basmati_rice_carrot','Zalm met basmatirijst & wortel','Salmon with basmati rice & carrot',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"salmon","g":150},{"slug":"basmati_dry","g":70},{"slug":"carrot","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['salmonveg']::text[],'1. Kook de basmatirijst (droog) volgens de verpakking.
2. Bak of pocheer de zalmfilet kort tot net gaar; kruid met peper en zout.
3. Stoom of wok wortel beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the basmati rice (dry) per the package.
2. Sear or poach the salmon fillet until just done; season with salt and pepper.
3. Steam or stir-fry the carrot until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('salmon_with_basmati_rice_peas','Zalm met basmatirijst & doperwten','Salmon with basmati rice & peas',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"salmon","g":150},{"slug":"basmati_dry","g":70},{"slug":"peas","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['salmonveg']::text[],'1. Kook de basmatirijst (droog) volgens de verpakking.
2. Bak of pocheer de zalmfilet kort tot net gaar; kruid met peper en zout.
3. Stoom of wok doperwten beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the basmati rice (dry) per the package.
2. Sear or poach the salmon fillet until just done; season with salt and pepper.
3. Steam or stir-fry the peas until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('salmon_with_basmati_rice_cauliflower','Zalm met basmatirijst & bloemkool','Salmon with basmati rice & cauliflower',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"salmon","g":150},{"slug":"basmati_dry","g":70},{"slug":"cauliflower","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['salmonveg']::text[],'1. Kook de basmatirijst (droog) volgens de verpakking.
2. Bak of pocheer de zalmfilet kort tot net gaar; kruid met peper en zout.
3. Stoom of wok bloemkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the basmati rice (dry) per the package.
2. Sear or poach the salmon fillet until just done; season with salt and pepper.
3. Steam or stir-fry the cauliflower until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('salmon_with_basmati_rice_kale','Zalm met basmatirijst & boerenkool','Salmon with basmati rice & kale',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"salmon","g":150},{"slug":"basmati_dry","g":70},{"slug":"kale","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['salmonveg']::text[],'1. Kook de basmatirijst (droog) volgens de verpakking.
2. Bak of pocheer de zalmfilet kort tot net gaar; kruid met peper en zout.
3. Stoom of wok boerenkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the basmati rice (dry) per the package.
2. Sear or poach the salmon fillet until just done; season with salt and pepper.
3. Steam or stir-fry the kale until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('salmon_with_basmati_rice_bok_choy','Zalm met basmatirijst & paksoi','Salmon with basmati rice & bok choy',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"salmon","g":150},{"slug":"basmati_dry","g":70},{"slug":"bok_choy","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['salmonveg']::text[],'1. Kook de basmatirijst (droog) volgens de verpakking.
2. Bak of pocheer de zalmfilet kort tot net gaar; kruid met peper en zout.
3. Stoom of wok paksoi beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the basmati rice (dry) per the package.
2. Sear or poach the salmon fillet until just done; season with salt and pepper.
3. Steam or stir-fry the bok choy until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('steak_with_rice_broccoli','Biefstuk met rijst & broccoli','Steak with rice & broccoli',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"beef_steak","g":150},{"slug":"rice_dry","g":70},{"slug":"broccoli","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['steakpotato','chickenrice','ricechicken']::text[],'1. Kook de witte rijst (droog) volgens de verpakking.
2. Bak de biefstuk in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok broccoli beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the white rice (dry) per the package.
2. Pan-fry the beef steak in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the broccoli until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('steak_with_rice_green_beans','Biefstuk met rijst & sperziebonen','Steak with rice & green beans',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"beef_steak","g":150},{"slug":"rice_dry","g":70},{"slug":"green_beans","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['steakpotato','chickenrice','ricechicken']::text[],'1. Kook de witte rijst (droog) volgens de verpakking.
2. Bak de biefstuk in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok sperziebonen beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the white rice (dry) per the package.
2. Pan-fry the beef steak in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the green beans until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('steak_with_rice_spinach','Biefstuk met rijst & spinazie','Steak with rice & spinach',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"beef_steak","g":150},{"slug":"rice_dry","g":70},{"slug":"spinach","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['steakpotato','chickenrice','ricechicken']::text[],'1. Kook de witte rijst (droog) volgens de verpakking.
2. Bak de biefstuk in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok spinazie beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the white rice (dry) per the package.
2. Pan-fry the beef steak in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the spinach until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('steak_with_rice_asparagus','Biefstuk met rijst & asperges','Steak with rice & asparagus',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"beef_steak","g":150},{"slug":"rice_dry","g":70},{"slug":"asparagus","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['steakpotato','chickenrice','ricechicken']::text[],'1. Kook de witte rijst (droog) volgens de verpakking.
2. Bak de biefstuk in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok asperges beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the white rice (dry) per the package.
2. Pan-fry the beef steak in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the asparagus until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('steak_with_rice_zucchini','Biefstuk met rijst & courgette','Steak with rice & zucchini',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"beef_steak","g":150},{"slug":"rice_dry","g":70},{"slug":"zucchini","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['steakpotato','chickenrice','ricechicken']::text[],'1. Kook de witte rijst (droog) volgens de verpakking.
2. Bak de biefstuk in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok courgette beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the white rice (dry) per the package.
2. Pan-fry the beef steak in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the zucchini until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('steak_with_rice_stir_fry_veg','Biefstuk met rijst & wokgroente','Steak with rice & stir-fry veg',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"beef_steak","g":150},{"slug":"rice_dry","g":70},{"slug":"mixed_veg","g":150},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['steakpotato','chickenrice','ricechicken']::text[],'1. Kook de witte rijst (droog) volgens de verpakking.
2. Bak de biefstuk in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok wokgroente beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the white rice (dry) per the package.
2. Pan-fry the beef steak in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the stir-fry veg until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('steak_with_rice_mushrooms','Biefstuk met rijst & champignons','Steak with rice & mushrooms',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"beef_steak","g":150},{"slug":"rice_dry","g":70},{"slug":"mushroom","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['steakpotato','chickenrice','ricechicken']::text[],'1. Kook de witte rijst (droog) volgens de verpakking.
2. Bak de biefstuk in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok champignons beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the white rice (dry) per the package.
2. Pan-fry the beef steak in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the mushrooms until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('steak_with_rice_carrot','Biefstuk met rijst & wortel','Steak with rice & carrot',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"beef_steak","g":150},{"slug":"rice_dry","g":70},{"slug":"carrot","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['steakpotato','chickenrice','ricechicken']::text[],'1. Kook de witte rijst (droog) volgens de verpakking.
2. Bak de biefstuk in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok wortel beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the white rice (dry) per the package.
2. Pan-fry the beef steak in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the carrot until tender-crisp.
4. Plate up and finish.','pan',null,'core')
on conflict (slug) do update set name_nl=excluded.name_nl,name_en=excluded.name_en,moments=excluded.moments,goals=excluded.goals,items=excluded.items,tags=excluded.tags,prefs=excluded.prefs,steps=excluded.steps,steps_en=excluded.steps_en,technique=excluded.technique,temp=excluded.temp;
commit;
