-- AUTO-GEGENEREERD core-seed deel 6/9 (200 gerechten). Draai NA dish-library.sql.
-- Draai de delen op volgorde (01, 02, ...). Elk deel is los veilig (upsert).
begin;
insert into public.dishes (slug,name_nl,name_en,moments,goals,items,tags,prefs,steps,steps_en,technique,temp,source) values
('tempeh_with_couscous_zucchini','Tempeh met couscous & courgette','Tempeh with couscous & zucchini',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"tempeh","g":130},{"slug":"couscous_dry","g":70},{"slug":"zucchini","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY[]::text[],'1. Kook de volkoren couscous (droog) volgens de verpakking.
2. Bak de tempeh in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok courgette beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat couscous (dry) per the package.
2. Pan-fry the tempeh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the zucchini until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tempeh_with_couscous_stir_fry_veg','Tempeh met couscous & wokgroente','Tempeh with couscous & stir-fry veg',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"tempeh","g":130},{"slug":"couscous_dry","g":70},{"slug":"mixed_veg","g":150},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY[]::text[],'1. Kook de volkoren couscous (droog) volgens de verpakking.
2. Bak de tempeh in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok wokgroente beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat couscous (dry) per the package.
2. Pan-fry the tempeh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the stir-fry veg until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tempeh_with_couscous_mushrooms','Tempeh met couscous & champignons','Tempeh with couscous & mushrooms',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"tempeh","g":130},{"slug":"couscous_dry","g":70},{"slug":"mushroom","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY[]::text[],'1. Kook de volkoren couscous (droog) volgens de verpakking.
2. Bak de tempeh in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok champignons beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat couscous (dry) per the package.
2. Pan-fry the tempeh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the mushrooms until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tempeh_with_couscous_carrot','Tempeh met couscous & wortel','Tempeh with couscous & carrot',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"tempeh","g":130},{"slug":"couscous_dry","g":70},{"slug":"carrot","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY[]::text[],'1. Kook de volkoren couscous (droog) volgens de verpakking.
2. Bak de tempeh in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok wortel beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat couscous (dry) per the package.
2. Pan-fry the tempeh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the carrot until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tempeh_with_couscous_peas','Tempeh met couscous & doperwten','Tempeh with couscous & peas',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"tempeh","g":130},{"slug":"couscous_dry","g":70},{"slug":"peas","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY[]::text[],'1. Kook de volkoren couscous (droog) volgens de verpakking.
2. Bak de tempeh in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok doperwten beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat couscous (dry) per the package.
2. Pan-fry the tempeh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the peas until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tempeh_with_couscous_cauliflower','Tempeh met couscous & bloemkool','Tempeh with couscous & cauliflower',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"tempeh","g":130},{"slug":"couscous_dry","g":70},{"slug":"cauliflower","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY[]::text[],'1. Kook de volkoren couscous (droog) volgens de verpakking.
2. Bak de tempeh in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok bloemkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat couscous (dry) per the package.
2. Pan-fry the tempeh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the cauliflower until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tempeh_with_couscous_kale','Tempeh met couscous & boerenkool','Tempeh with couscous & kale',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"tempeh","g":130},{"slug":"couscous_dry","g":70},{"slug":"kale","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY[]::text[],'1. Kook de volkoren couscous (droog) volgens de verpakking.
2. Bak de tempeh in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok boerenkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat couscous (dry) per the package.
2. Pan-fry the tempeh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the kale until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tempeh_with_couscous_bok_choy','Tempeh met couscous & paksoi','Tempeh with couscous & bok choy',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"tempeh","g":130},{"slug":"couscous_dry","g":70},{"slug":"bok_choy","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY[]::text[],'1. Kook de volkoren couscous (droog) volgens de verpakking.
2. Bak de tempeh in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok paksoi beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat couscous (dry) per the package.
2. Pan-fry the tempeh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the bok choy until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tempeh_with_bulgur_broccoli','Tempeh met bulgur & broccoli','Tempeh with bulgur & broccoli',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"tempeh","g":130},{"slug":"bulgur_dry","g":70},{"slug":"broccoli","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY[]::text[],'1. Kook de bulgur (droog) volgens de verpakking.
2. Bak de tempeh in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok broccoli beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the bulgur (dry) per the package.
2. Pan-fry the tempeh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the broccoli until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tempeh_with_bulgur_green_beans','Tempeh met bulgur & sperziebonen','Tempeh with bulgur & green beans',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"tempeh","g":130},{"slug":"bulgur_dry","g":70},{"slug":"green_beans","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY[]::text[],'1. Kook de bulgur (droog) volgens de verpakking.
2. Bak de tempeh in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok sperziebonen beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the bulgur (dry) per the package.
2. Pan-fry the tempeh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the green beans until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tempeh_with_bulgur_spinach','Tempeh met bulgur & spinazie','Tempeh with bulgur & spinach',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"tempeh","g":130},{"slug":"bulgur_dry","g":70},{"slug":"spinach","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY[]::text[],'1. Kook de bulgur (droog) volgens de verpakking.
2. Bak de tempeh in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok spinazie beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the bulgur (dry) per the package.
2. Pan-fry the tempeh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the spinach until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tempeh_with_bulgur_asparagus','Tempeh met bulgur & asperges','Tempeh with bulgur & asparagus',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"tempeh","g":130},{"slug":"bulgur_dry","g":70},{"slug":"asparagus","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY[]::text[],'1. Kook de bulgur (droog) volgens de verpakking.
2. Bak de tempeh in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok asperges beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the bulgur (dry) per the package.
2. Pan-fry the tempeh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the asparagus until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tempeh_with_bulgur_zucchini','Tempeh met bulgur & courgette','Tempeh with bulgur & zucchini',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"tempeh","g":130},{"slug":"bulgur_dry","g":70},{"slug":"zucchini","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY[]::text[],'1. Kook de bulgur (droog) volgens de verpakking.
2. Bak de tempeh in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok courgette beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the bulgur (dry) per the package.
2. Pan-fry the tempeh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the zucchini until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tempeh_with_bulgur_stir_fry_veg','Tempeh met bulgur & wokgroente','Tempeh with bulgur & stir-fry veg',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"tempeh","g":130},{"slug":"bulgur_dry","g":70},{"slug":"mixed_veg","g":150},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY[]::text[],'1. Kook de bulgur (droog) volgens de verpakking.
2. Bak de tempeh in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok wokgroente beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the bulgur (dry) per the package.
2. Pan-fry the tempeh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the stir-fry veg until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tempeh_with_bulgur_mushrooms','Tempeh met bulgur & champignons','Tempeh with bulgur & mushrooms',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"tempeh","g":130},{"slug":"bulgur_dry","g":70},{"slug":"mushroom","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY[]::text[],'1. Kook de bulgur (droog) volgens de verpakking.
2. Bak de tempeh in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok champignons beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the bulgur (dry) per the package.
2. Pan-fry the tempeh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the mushrooms until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tempeh_with_bulgur_carrot','Tempeh met bulgur & wortel','Tempeh with bulgur & carrot',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"tempeh","g":130},{"slug":"bulgur_dry","g":70},{"slug":"carrot","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY[]::text[],'1. Kook de bulgur (droog) volgens de verpakking.
2. Bak de tempeh in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok wortel beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the bulgur (dry) per the package.
2. Pan-fry the tempeh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the carrot until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tempeh_with_bulgur_peas','Tempeh met bulgur & doperwten','Tempeh with bulgur & peas',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"tempeh","g":130},{"slug":"bulgur_dry","g":70},{"slug":"peas","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY[]::text[],'1. Kook de bulgur (droog) volgens de verpakking.
2. Bak de tempeh in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok doperwten beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the bulgur (dry) per the package.
2. Pan-fry the tempeh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the peas until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tempeh_with_bulgur_cauliflower','Tempeh met bulgur & bloemkool','Tempeh with bulgur & cauliflower',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"tempeh","g":130},{"slug":"bulgur_dry","g":70},{"slug":"cauliflower","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY[]::text[],'1. Kook de bulgur (droog) volgens de verpakking.
2. Bak de tempeh in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok bloemkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the bulgur (dry) per the package.
2. Pan-fry the tempeh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the cauliflower until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tempeh_with_bulgur_kale','Tempeh met bulgur & boerenkool','Tempeh with bulgur & kale',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"tempeh","g":130},{"slug":"bulgur_dry","g":70},{"slug":"kale","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY[]::text[],'1. Kook de bulgur (droog) volgens de verpakking.
2. Bak de tempeh in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok boerenkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the bulgur (dry) per the package.
2. Pan-fry the tempeh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the kale until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tempeh_with_bulgur_bok_choy','Tempeh met bulgur & paksoi','Tempeh with bulgur & bok choy',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"tempeh","g":130},{"slug":"bulgur_dry","g":70},{"slug":"bok_choy","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY[]::text[],'1. Kook de bulgur (droog) volgens de verpakking.
2. Bak de tempeh in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok paksoi beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the bulgur (dry) per the package.
2. Pan-fry the tempeh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the bok choy until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tempeh_with_basmati_rice_broccoli','Tempeh met basmatirijst & broccoli','Tempeh with basmati rice & broccoli',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"tempeh","g":130},{"slug":"basmati_dry","g":70},{"slug":"broccoli","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY[]::text[],'1. Kook de basmatirijst (droog) volgens de verpakking.
2. Bak de tempeh in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok broccoli beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the basmati rice (dry) per the package.
2. Pan-fry the tempeh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the broccoli until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tempeh_with_basmati_rice_green_beans','Tempeh met basmatirijst & sperziebonen','Tempeh with basmati rice & green beans',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"tempeh","g":130},{"slug":"basmati_dry","g":70},{"slug":"green_beans","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY[]::text[],'1. Kook de basmatirijst (droog) volgens de verpakking.
2. Bak de tempeh in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok sperziebonen beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the basmati rice (dry) per the package.
2. Pan-fry the tempeh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the green beans until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tempeh_with_basmati_rice_spinach','Tempeh met basmatirijst & spinazie','Tempeh with basmati rice & spinach',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"tempeh","g":130},{"slug":"basmati_dry","g":70},{"slug":"spinach","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY[]::text[],'1. Kook de basmatirijst (droog) volgens de verpakking.
2. Bak de tempeh in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok spinazie beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the basmati rice (dry) per the package.
2. Pan-fry the tempeh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the spinach until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tempeh_with_basmati_rice_asparagus','Tempeh met basmatirijst & asperges','Tempeh with basmati rice & asparagus',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"tempeh","g":130},{"slug":"basmati_dry","g":70},{"slug":"asparagus","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY[]::text[],'1. Kook de basmatirijst (droog) volgens de verpakking.
2. Bak de tempeh in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok asperges beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the basmati rice (dry) per the package.
2. Pan-fry the tempeh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the asparagus until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tempeh_with_basmati_rice_zucchini','Tempeh met basmatirijst & courgette','Tempeh with basmati rice & zucchini',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"tempeh","g":130},{"slug":"basmati_dry","g":70},{"slug":"zucchini","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY[]::text[],'1. Kook de basmatirijst (droog) volgens de verpakking.
2. Bak de tempeh in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok courgette beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the basmati rice (dry) per the package.
2. Pan-fry the tempeh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the zucchini until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tempeh_with_basmati_rice_stir_fry_veg','Tempeh met basmatirijst & wokgroente','Tempeh with basmati rice & stir-fry veg',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"tempeh","g":130},{"slug":"basmati_dry","g":70},{"slug":"mixed_veg","g":150},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY[]::text[],'1. Kook de basmatirijst (droog) volgens de verpakking.
2. Bak de tempeh in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok wokgroente beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the basmati rice (dry) per the package.
2. Pan-fry the tempeh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the stir-fry veg until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tempeh_with_basmati_rice_mushrooms','Tempeh met basmatirijst & champignons','Tempeh with basmati rice & mushrooms',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"tempeh","g":130},{"slug":"basmati_dry","g":70},{"slug":"mushroom","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY[]::text[],'1. Kook de basmatirijst (droog) volgens de verpakking.
2. Bak de tempeh in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok champignons beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the basmati rice (dry) per the package.
2. Pan-fry the tempeh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the mushrooms until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tempeh_with_basmati_rice_carrot','Tempeh met basmatirijst & wortel','Tempeh with basmati rice & carrot',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"tempeh","g":130},{"slug":"basmati_dry","g":70},{"slug":"carrot","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY[]::text[],'1. Kook de basmatirijst (droog) volgens de verpakking.
2. Bak de tempeh in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok wortel beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the basmati rice (dry) per the package.
2. Pan-fry the tempeh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the carrot until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tempeh_with_basmati_rice_peas','Tempeh met basmatirijst & doperwten','Tempeh with basmati rice & peas',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"tempeh","g":130},{"slug":"basmati_dry","g":70},{"slug":"peas","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY[]::text[],'1. Kook de basmatirijst (droog) volgens de verpakking.
2. Bak de tempeh in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok doperwten beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the basmati rice (dry) per the package.
2. Pan-fry the tempeh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the peas until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tempeh_with_basmati_rice_cauliflower','Tempeh met basmatirijst & bloemkool','Tempeh with basmati rice & cauliflower',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"tempeh","g":130},{"slug":"basmati_dry","g":70},{"slug":"cauliflower","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY[]::text[],'1. Kook de basmatirijst (droog) volgens de verpakking.
2. Bak de tempeh in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok bloemkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the basmati rice (dry) per the package.
2. Pan-fry the tempeh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the cauliflower until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tempeh_with_basmati_rice_kale','Tempeh met basmatirijst & boerenkool','Tempeh with basmati rice & kale',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"tempeh","g":130},{"slug":"basmati_dry","g":70},{"slug":"kale","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY[]::text[],'1. Kook de basmatirijst (droog) volgens de verpakking.
2. Bak de tempeh in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok boerenkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the basmati rice (dry) per the package.
2. Pan-fry the tempeh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the kale until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tempeh_with_basmati_rice_bok_choy','Tempeh met basmatirijst & paksoi','Tempeh with basmati rice & bok choy',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"tempeh","g":130},{"slug":"basmati_dry","g":70},{"slug":"bok_choy","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY[]::text[],'1. Kook de basmatirijst (droog) volgens de verpakking.
2. Bak de tempeh in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok paksoi beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the basmati rice (dry) per the package.
2. Pan-fry the tempeh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the bok choy until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_thigh_with_rice_broccoli','Kipdij met rijst & broccoli','Chicken thigh with rice & broccoli',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"chicken_thigh","g":150},{"slug":"rice_dry","g":70},{"slug":"broccoli","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Kook de witte rijst (droog) volgens de verpakking.
2. Bak de kipdij in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok broccoli beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the white rice (dry) per the package.
2. Pan-fry the chicken thigh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the broccoli until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_thigh_with_rice_green_beans','Kipdij met rijst & sperziebonen','Chicken thigh with rice & green beans',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"chicken_thigh","g":150},{"slug":"rice_dry","g":70},{"slug":"green_beans","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Kook de witte rijst (droog) volgens de verpakking.
2. Bak de kipdij in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok sperziebonen beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the white rice (dry) per the package.
2. Pan-fry the chicken thigh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the green beans until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_thigh_with_rice_spinach','Kipdij met rijst & spinazie','Chicken thigh with rice & spinach',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"chicken_thigh","g":150},{"slug":"rice_dry","g":70},{"slug":"spinach","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Kook de witte rijst (droog) volgens de verpakking.
2. Bak de kipdij in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok spinazie beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the white rice (dry) per the package.
2. Pan-fry the chicken thigh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the spinach until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_thigh_with_rice_asparagus','Kipdij met rijst & asperges','Chicken thigh with rice & asparagus',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"chicken_thigh","g":150},{"slug":"rice_dry","g":70},{"slug":"asparagus","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Kook de witte rijst (droog) volgens de verpakking.
2. Bak de kipdij in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok asperges beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the white rice (dry) per the package.
2. Pan-fry the chicken thigh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the asparagus until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_thigh_with_rice_zucchini','Kipdij met rijst & courgette','Chicken thigh with rice & zucchini',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"chicken_thigh","g":150},{"slug":"rice_dry","g":70},{"slug":"zucchini","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Kook de witte rijst (droog) volgens de verpakking.
2. Bak de kipdij in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok courgette beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the white rice (dry) per the package.
2. Pan-fry the chicken thigh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the zucchini until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_thigh_with_rice_stir_fry_veg','Kipdij met rijst & wokgroente','Chicken thigh with rice & stir-fry veg',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"chicken_thigh","g":150},{"slug":"rice_dry","g":70},{"slug":"mixed_veg","g":150},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Kook de witte rijst (droog) volgens de verpakking.
2. Bak de kipdij in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok wokgroente beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the white rice (dry) per the package.
2. Pan-fry the chicken thigh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the stir-fry veg until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_thigh_with_rice_mushrooms','Kipdij met rijst & champignons','Chicken thigh with rice & mushrooms',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"chicken_thigh","g":150},{"slug":"rice_dry","g":70},{"slug":"mushroom","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Kook de witte rijst (droog) volgens de verpakking.
2. Bak de kipdij in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok champignons beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the white rice (dry) per the package.
2. Pan-fry the chicken thigh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the mushrooms until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_thigh_with_rice_carrot','Kipdij met rijst & wortel','Chicken thigh with rice & carrot',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"chicken_thigh","g":150},{"slug":"rice_dry","g":70},{"slug":"carrot","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Kook de witte rijst (droog) volgens de verpakking.
2. Bak de kipdij in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok wortel beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the white rice (dry) per the package.
2. Pan-fry the chicken thigh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the carrot until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_thigh_with_rice_peas','Kipdij met rijst & doperwten','Chicken thigh with rice & peas',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"chicken_thigh","g":150},{"slug":"rice_dry","g":70},{"slug":"peas","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Kook de witte rijst (droog) volgens de verpakking.
2. Bak de kipdij in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok doperwten beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the white rice (dry) per the package.
2. Pan-fry the chicken thigh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the peas until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_thigh_with_rice_cauliflower','Kipdij met rijst & bloemkool','Chicken thigh with rice & cauliflower',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"chicken_thigh","g":150},{"slug":"rice_dry","g":70},{"slug":"cauliflower","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Kook de witte rijst (droog) volgens de verpakking.
2. Bak de kipdij in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok bloemkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the white rice (dry) per the package.
2. Pan-fry the chicken thigh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the cauliflower until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_thigh_with_rice_kale','Kipdij met rijst & boerenkool','Chicken thigh with rice & kale',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"chicken_thigh","g":150},{"slug":"rice_dry","g":70},{"slug":"kale","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Kook de witte rijst (droog) volgens de verpakking.
2. Bak de kipdij in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok boerenkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the white rice (dry) per the package.
2. Pan-fry the chicken thigh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the kale until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_thigh_with_rice_bok_choy','Kipdij met rijst & paksoi','Chicken thigh with rice & bok choy',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"chicken_thigh","g":150},{"slug":"rice_dry","g":70},{"slug":"bok_choy","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Kook de witte rijst (droog) volgens de verpakking.
2. Bak de kipdij in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok paksoi beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the white rice (dry) per the package.
2. Pan-fry the chicken thigh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the bok choy until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_thigh_with_sweet_potato_broccoli','Kipdij met zoete aardappel & broccoli','Chicken thigh with sweet potato & broccoli',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"chicken_thigh","g":150},{"slug":"sweet_potato","g":200},{"slug":"broccoli","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY[]::text[],'1. Kook de zoete aardappel volgens de verpakking.
2. Bak de kipdij in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok broccoli beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the sweet potato per the package.
2. Pan-fry the chicken thigh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the broccoli until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_thigh_with_sweet_potato_green_beans','Kipdij met zoete aardappel & sperziebonen','Chicken thigh with sweet potato & green beans',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"chicken_thigh","g":150},{"slug":"sweet_potato","g":200},{"slug":"green_beans","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY[]::text[],'1. Kook de zoete aardappel volgens de verpakking.
2. Bak de kipdij in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok sperziebonen beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the sweet potato per the package.
2. Pan-fry the chicken thigh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the green beans until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_thigh_with_sweet_potato_spinach','Kipdij met zoete aardappel & spinazie','Chicken thigh with sweet potato & spinach',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"chicken_thigh","g":150},{"slug":"sweet_potato","g":200},{"slug":"spinach","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de zoete aardappel volgens de verpakking.
2. Bak de kipdij in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok spinazie beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the sweet potato per the package.
2. Pan-fry the chicken thigh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the spinach until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_thigh_with_sweet_potato_asparagus','Kipdij met zoete aardappel & asperges','Chicken thigh with sweet potato & asparagus',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"chicken_thigh","g":150},{"slug":"sweet_potato","g":200},{"slug":"asparagus","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de zoete aardappel volgens de verpakking.
2. Bak de kipdij in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok asperges beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the sweet potato per the package.
2. Pan-fry the chicken thigh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the asparagus until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_thigh_with_sweet_potato_zucchini','Kipdij met zoete aardappel & courgette','Chicken thigh with sweet potato & zucchini',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"chicken_thigh","g":150},{"slug":"sweet_potato","g":200},{"slug":"zucchini","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY[]::text[],'1. Kook de zoete aardappel volgens de verpakking.
2. Bak de kipdij in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok courgette beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the sweet potato per the package.
2. Pan-fry the chicken thigh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the zucchini until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_thigh_with_sweet_potato_stir_fry_veg','Kipdij met zoete aardappel & wokgroente','Chicken thigh with sweet potato & stir-fry veg',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"chicken_thigh","g":150},{"slug":"sweet_potato","g":200},{"slug":"mixed_veg","g":150},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY[]::text[],'1. Kook de zoete aardappel volgens de verpakking.
2. Bak de kipdij in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok wokgroente beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the sweet potato per the package.
2. Pan-fry the chicken thigh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the stir-fry veg until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_thigh_with_sweet_potato_mushrooms','Kipdij met zoete aardappel & champignons','Chicken thigh with sweet potato & mushrooms',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"chicken_thigh","g":150},{"slug":"sweet_potato","g":200},{"slug":"mushroom","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de zoete aardappel volgens de verpakking.
2. Bak de kipdij in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok champignons beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the sweet potato per the package.
2. Pan-fry the chicken thigh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the mushrooms until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_thigh_with_sweet_potato_carrot','Kipdij met zoete aardappel & wortel','Chicken thigh with sweet potato & carrot',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"chicken_thigh","g":150},{"slug":"sweet_potato","g":200},{"slug":"carrot","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY[]::text[],'1. Kook de zoete aardappel volgens de verpakking.
2. Bak de kipdij in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok wortel beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the sweet potato per the package.
2. Pan-fry the chicken thigh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the carrot until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_thigh_with_sweet_potato_peas','Kipdij met zoete aardappel & doperwten','Chicken thigh with sweet potato & peas',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"chicken_thigh","g":150},{"slug":"sweet_potato","g":200},{"slug":"peas","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY[]::text[],'1. Kook de zoete aardappel volgens de verpakking.
2. Bak de kipdij in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok doperwten beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the sweet potato per the package.
2. Pan-fry the chicken thigh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the peas until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_thigh_with_sweet_potato_cauliflower','Kipdij met zoete aardappel & bloemkool','Chicken thigh with sweet potato & cauliflower',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"chicken_thigh","g":150},{"slug":"sweet_potato","g":200},{"slug":"cauliflower","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY[]::text[],'1. Kook de zoete aardappel volgens de verpakking.
2. Bak de kipdij in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok bloemkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the sweet potato per the package.
2. Pan-fry the chicken thigh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the cauliflower until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_thigh_with_sweet_potato_kale','Kipdij met zoete aardappel & boerenkool','Chicken thigh with sweet potato & kale',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"chicken_thigh","g":150},{"slug":"sweet_potato","g":200},{"slug":"kale","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de zoete aardappel volgens de verpakking.
2. Bak de kipdij in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok boerenkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the sweet potato per the package.
2. Pan-fry the chicken thigh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the kale until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_thigh_with_sweet_potato_bok_choy','Kipdij met zoete aardappel & paksoi','Chicken thigh with sweet potato & bok choy',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"chicken_thigh","g":150},{"slug":"sweet_potato","g":200},{"slug":"bok_choy","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY[]::text[],'1. Kook de zoete aardappel volgens de verpakking.
2. Bak de kipdij in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok paksoi beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the sweet potato per the package.
2. Pan-fry the chicken thigh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the bok choy until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_thigh_with_potato_broccoli','Kipdij met aardappel & broccoli','Chicken thigh with potato & broccoli',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"chicken_thigh","g":150},{"slug":"potato","g":250},{"slug":"broccoli","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['steakpotato']::text[],'1. Kook de aardappel volgens de verpakking.
2. Bak de kipdij in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok broccoli beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the potato per the package.
2. Pan-fry the chicken thigh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the broccoli until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_thigh_with_potato_green_beans','Kipdij met aardappel & sperziebonen','Chicken thigh with potato & green beans',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"chicken_thigh","g":150},{"slug":"potato","g":250},{"slug":"green_beans","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['steakpotato']::text[],'1. Kook de aardappel volgens de verpakking.
2. Bak de kipdij in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok sperziebonen beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the potato per the package.
2. Pan-fry the chicken thigh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the green beans until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_thigh_with_potato_spinach','Kipdij met aardappel & spinazie','Chicken thigh with potato & spinach',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"chicken_thigh","g":150},{"slug":"potato","g":250},{"slug":"spinach","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['steakpotato']::text[],'1. Kook de aardappel volgens de verpakking.
2. Bak de kipdij in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok spinazie beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the potato per the package.
2. Pan-fry the chicken thigh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the spinach until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_thigh_with_potato_asparagus','Kipdij met aardappel & asperges','Chicken thigh with potato & asparagus',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"chicken_thigh","g":150},{"slug":"potato","g":250},{"slug":"asparagus","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['steakpotato']::text[],'1. Kook de aardappel volgens de verpakking.
2. Bak de kipdij in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok asperges beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the potato per the package.
2. Pan-fry the chicken thigh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the asparagus until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_thigh_with_potato_zucchini','Kipdij met aardappel & courgette','Chicken thigh with potato & zucchini',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"chicken_thigh","g":150},{"slug":"potato","g":250},{"slug":"zucchini","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['steakpotato']::text[],'1. Kook de aardappel volgens de verpakking.
2. Bak de kipdij in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok courgette beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the potato per the package.
2. Pan-fry the chicken thigh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the zucchini until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_thigh_with_potato_stir_fry_veg','Kipdij met aardappel & wokgroente','Chicken thigh with potato & stir-fry veg',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"chicken_thigh","g":150},{"slug":"potato","g":250},{"slug":"mixed_veg","g":150},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['steakpotato']::text[],'1. Kook de aardappel volgens de verpakking.
2. Bak de kipdij in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok wokgroente beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the potato per the package.
2. Pan-fry the chicken thigh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the stir-fry veg until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_thigh_with_potato_mushrooms','Kipdij met aardappel & champignons','Chicken thigh with potato & mushrooms',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"chicken_thigh","g":150},{"slug":"potato","g":250},{"slug":"mushroom","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['steakpotato']::text[],'1. Kook de aardappel volgens de verpakking.
2. Bak de kipdij in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok champignons beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the potato per the package.
2. Pan-fry the chicken thigh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the mushrooms until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_thigh_with_potato_carrot','Kipdij met aardappel & wortel','Chicken thigh with potato & carrot',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"chicken_thigh","g":150},{"slug":"potato","g":250},{"slug":"carrot","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['steakpotato']::text[],'1. Kook de aardappel volgens de verpakking.
2. Bak de kipdij in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok wortel beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the potato per the package.
2. Pan-fry the chicken thigh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the carrot until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_thigh_with_potato_peas','Kipdij met aardappel & doperwten','Chicken thigh with potato & peas',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"chicken_thigh","g":150},{"slug":"potato","g":250},{"slug":"peas","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['steakpotato']::text[],'1. Kook de aardappel volgens de verpakking.
2. Bak de kipdij in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok doperwten beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the potato per the package.
2. Pan-fry the chicken thigh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the peas until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_thigh_with_potato_cauliflower','Kipdij met aardappel & bloemkool','Chicken thigh with potato & cauliflower',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"chicken_thigh","g":150},{"slug":"potato","g":250},{"slug":"cauliflower","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['steakpotato']::text[],'1. Kook de aardappel volgens de verpakking.
2. Bak de kipdij in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok bloemkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the potato per the package.
2. Pan-fry the chicken thigh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the cauliflower until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_thigh_with_potato_kale','Kipdij met aardappel & boerenkool','Chicken thigh with potato & kale',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"chicken_thigh","g":150},{"slug":"potato","g":250},{"slug":"kale","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['steakpotato']::text[],'1. Kook de aardappel volgens de verpakking.
2. Bak de kipdij in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok boerenkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the potato per the package.
2. Pan-fry the chicken thigh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the kale until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_thigh_with_potato_bok_choy','Kipdij met aardappel & paksoi','Chicken thigh with potato & bok choy',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"chicken_thigh","g":150},{"slug":"potato","g":250},{"slug":"bok_choy","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['steakpotato']::text[],'1. Kook de aardappel volgens de verpakking.
2. Bak de kipdij in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok paksoi beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the potato per the package.
2. Pan-fry the chicken thigh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the bok choy until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_thigh_with_pasta_broccoli','Kipdij met pasta & broccoli','Chicken thigh with pasta & broccoli',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"chicken_thigh","g":150},{"slug":"pasta_dry","g":80},{"slug":"broccoli","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['pastabol']::text[],'1. Kook de volkoren pasta (droog) volgens de verpakking.
2. Bak de kipdij in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok broccoli beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat pasta (dry) per the package.
2. Pan-fry the chicken thigh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the broccoli until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_thigh_with_pasta_green_beans','Kipdij met pasta & sperziebonen','Chicken thigh with pasta & green beans',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"chicken_thigh","g":150},{"slug":"pasta_dry","g":80},{"slug":"green_beans","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['pastabol']::text[],'1. Kook de volkoren pasta (droog) volgens de verpakking.
2. Bak de kipdij in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok sperziebonen beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat pasta (dry) per the package.
2. Pan-fry the chicken thigh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the green beans until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_thigh_with_pasta_spinach','Kipdij met pasta & spinazie','Chicken thigh with pasta & spinach',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"chicken_thigh","g":150},{"slug":"pasta_dry","g":80},{"slug":"spinach","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['pastabol']::text[],'1. Kook de volkoren pasta (droog) volgens de verpakking.
2. Bak de kipdij in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok spinazie beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat pasta (dry) per the package.
2. Pan-fry the chicken thigh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the spinach until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_thigh_with_pasta_asparagus','Kipdij met pasta & asperges','Chicken thigh with pasta & asparagus',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"chicken_thigh","g":150},{"slug":"pasta_dry","g":80},{"slug":"asparagus","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['pastabol']::text[],'1. Kook de volkoren pasta (droog) volgens de verpakking.
2. Bak de kipdij in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok asperges beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat pasta (dry) per the package.
2. Pan-fry the chicken thigh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the asparagus until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_thigh_with_pasta_zucchini','Kipdij met pasta & courgette','Chicken thigh with pasta & zucchini',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"chicken_thigh","g":150},{"slug":"pasta_dry","g":80},{"slug":"zucchini","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['pastabol']::text[],'1. Kook de volkoren pasta (droog) volgens de verpakking.
2. Bak de kipdij in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok courgette beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat pasta (dry) per the package.
2. Pan-fry the chicken thigh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the zucchini until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_thigh_with_pasta_stir_fry_veg','Kipdij met pasta & wokgroente','Chicken thigh with pasta & stir-fry veg',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"chicken_thigh","g":150},{"slug":"pasta_dry","g":80},{"slug":"mixed_veg","g":150},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['pastabol']::text[],'1. Kook de volkoren pasta (droog) volgens de verpakking.
2. Bak de kipdij in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok wokgroente beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat pasta (dry) per the package.
2. Pan-fry the chicken thigh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the stir-fry veg until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_thigh_with_pasta_mushrooms','Kipdij met pasta & champignons','Chicken thigh with pasta & mushrooms',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"chicken_thigh","g":150},{"slug":"pasta_dry","g":80},{"slug":"mushroom","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['pastabol']::text[],'1. Kook de volkoren pasta (droog) volgens de verpakking.
2. Bak de kipdij in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok champignons beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat pasta (dry) per the package.
2. Pan-fry the chicken thigh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the mushrooms until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_thigh_with_pasta_carrot','Kipdij met pasta & wortel','Chicken thigh with pasta & carrot',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"chicken_thigh","g":150},{"slug":"pasta_dry","g":80},{"slug":"carrot","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['pastabol']::text[],'1. Kook de volkoren pasta (droog) volgens de verpakking.
2. Bak de kipdij in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok wortel beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat pasta (dry) per the package.
2. Pan-fry the chicken thigh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the carrot until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_thigh_with_pasta_peas','Kipdij met pasta & doperwten','Chicken thigh with pasta & peas',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"chicken_thigh","g":150},{"slug":"pasta_dry","g":80},{"slug":"peas","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['pastabol']::text[],'1. Kook de volkoren pasta (droog) volgens de verpakking.
2. Bak de kipdij in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok doperwten beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat pasta (dry) per the package.
2. Pan-fry the chicken thigh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the peas until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_thigh_with_pasta_cauliflower','Kipdij met pasta & bloemkool','Chicken thigh with pasta & cauliflower',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"chicken_thigh","g":150},{"slug":"pasta_dry","g":80},{"slug":"cauliflower","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['pastabol']::text[],'1. Kook de volkoren pasta (droog) volgens de verpakking.
2. Bak de kipdij in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok bloemkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat pasta (dry) per the package.
2. Pan-fry the chicken thigh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the cauliflower until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_thigh_with_pasta_kale','Kipdij met pasta & boerenkool','Chicken thigh with pasta & kale',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"chicken_thigh","g":150},{"slug":"pasta_dry","g":80},{"slug":"kale","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['pastabol']::text[],'1. Kook de volkoren pasta (droog) volgens de verpakking.
2. Bak de kipdij in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok boerenkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat pasta (dry) per the package.
2. Pan-fry the chicken thigh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the kale until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_thigh_with_pasta_bok_choy','Kipdij met pasta & paksoi','Chicken thigh with pasta & bok choy',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"chicken_thigh","g":150},{"slug":"pasta_dry","g":80},{"slug":"bok_choy","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['pastabol']::text[],'1. Kook de volkoren pasta (droog) volgens de verpakking.
2. Bak de kipdij in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok paksoi beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat pasta (dry) per the package.
2. Pan-fry the chicken thigh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the bok choy until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_thigh_with_quinoa_broccoli','Kipdij met quinoa & broccoli','Chicken thigh with quinoa & broccoli',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"chicken_thigh","g":150},{"slug":"quinoa_dry","g":70},{"slug":"broccoli","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY[]::text[],'1. Kook de quinoa (droog) volgens de verpakking.
2. Bak de kipdij in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok broccoli beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the quinoa (dry) per the package.
2. Pan-fry the chicken thigh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the broccoli until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_thigh_with_quinoa_green_beans','Kipdij met quinoa & sperziebonen','Chicken thigh with quinoa & green beans',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"chicken_thigh","g":150},{"slug":"quinoa_dry","g":70},{"slug":"green_beans","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY[]::text[],'1. Kook de quinoa (droog) volgens de verpakking.
2. Bak de kipdij in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok sperziebonen beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the quinoa (dry) per the package.
2. Pan-fry the chicken thigh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the green beans until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_thigh_with_quinoa_spinach','Kipdij met quinoa & spinazie','Chicken thigh with quinoa & spinach',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"chicken_thigh","g":150},{"slug":"quinoa_dry","g":70},{"slug":"spinach","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de quinoa (droog) volgens de verpakking.
2. Bak de kipdij in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok spinazie beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the quinoa (dry) per the package.
2. Pan-fry the chicken thigh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the spinach until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_thigh_with_quinoa_asparagus','Kipdij met quinoa & asperges','Chicken thigh with quinoa & asparagus',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"chicken_thigh","g":150},{"slug":"quinoa_dry","g":70},{"slug":"asparagus","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY[]::text[],'1. Kook de quinoa (droog) volgens de verpakking.
2. Bak de kipdij in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok asperges beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the quinoa (dry) per the package.
2. Pan-fry the chicken thigh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the asparagus until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_thigh_with_quinoa_zucchini','Kipdij met quinoa & courgette','Chicken thigh with quinoa & zucchini',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"chicken_thigh","g":150},{"slug":"quinoa_dry","g":70},{"slug":"zucchini","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY[]::text[],'1. Kook de quinoa (droog) volgens de verpakking.
2. Bak de kipdij in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok courgette beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the quinoa (dry) per the package.
2. Pan-fry the chicken thigh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the zucchini until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_thigh_with_quinoa_stir_fry_veg','Kipdij met quinoa & wokgroente','Chicken thigh with quinoa & stir-fry veg',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"chicken_thigh","g":150},{"slug":"quinoa_dry","g":70},{"slug":"mixed_veg","g":150},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY[]::text[],'1. Kook de quinoa (droog) volgens de verpakking.
2. Bak de kipdij in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok wokgroente beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the quinoa (dry) per the package.
2. Pan-fry the chicken thigh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the stir-fry veg until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_thigh_with_quinoa_mushrooms','Kipdij met quinoa & champignons','Chicken thigh with quinoa & mushrooms',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"chicken_thigh","g":150},{"slug":"quinoa_dry","g":70},{"slug":"mushroom","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de quinoa (droog) volgens de verpakking.
2. Bak de kipdij in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok champignons beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the quinoa (dry) per the package.
2. Pan-fry the chicken thigh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the mushrooms until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_thigh_with_quinoa_carrot','Kipdij met quinoa & wortel','Chicken thigh with quinoa & carrot',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"chicken_thigh","g":150},{"slug":"quinoa_dry","g":70},{"slug":"carrot","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY[]::text[],'1. Kook de quinoa (droog) volgens de verpakking.
2. Bak de kipdij in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok wortel beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the quinoa (dry) per the package.
2. Pan-fry the chicken thigh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the carrot until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_thigh_with_quinoa_peas','Kipdij met quinoa & doperwten','Chicken thigh with quinoa & peas',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"chicken_thigh","g":150},{"slug":"quinoa_dry","g":70},{"slug":"peas","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY[]::text[],'1. Kook de quinoa (droog) volgens de verpakking.
2. Bak de kipdij in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok doperwten beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the quinoa (dry) per the package.
2. Pan-fry the chicken thigh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the peas until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_thigh_with_quinoa_cauliflower','Kipdij met quinoa & bloemkool','Chicken thigh with quinoa & cauliflower',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"chicken_thigh","g":150},{"slug":"quinoa_dry","g":70},{"slug":"cauliflower","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY[]::text[],'1. Kook de quinoa (droog) volgens de verpakking.
2. Bak de kipdij in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok bloemkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the quinoa (dry) per the package.
2. Pan-fry the chicken thigh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the cauliflower until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_thigh_with_quinoa_kale','Kipdij met quinoa & boerenkool','Chicken thigh with quinoa & kale',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"chicken_thigh","g":150},{"slug":"quinoa_dry","g":70},{"slug":"kale","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY[]::text[],'1. Kook de quinoa (droog) volgens de verpakking.
2. Bak de kipdij in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok boerenkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the quinoa (dry) per the package.
2. Pan-fry the chicken thigh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the kale until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_thigh_with_quinoa_bok_choy','Kipdij met quinoa & paksoi','Chicken thigh with quinoa & bok choy',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"chicken_thigh","g":150},{"slug":"quinoa_dry","g":70},{"slug":"bok_choy","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY[]::text[],'1. Kook de quinoa (droog) volgens de verpakking.
2. Bak de kipdij in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok paksoi beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the quinoa (dry) per the package.
2. Pan-fry the chicken thigh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the bok choy until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_thigh_with_noodles_broccoli','Kipdij met noedels & broccoli','Chicken thigh with noodles & broccoli',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"chicken_thigh","g":150},{"slug":"noodles_dry","g":80},{"slug":"broccoli","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['woknoodles']::text[],'1. Kook de volkoren noedels (droog) volgens de verpakking.
2. Bak de kipdij in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok broccoli beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat noodles (dry) per the package.
2. Pan-fry the chicken thigh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the broccoli until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_thigh_with_noodles_green_beans','Kipdij met noedels & sperziebonen','Chicken thigh with noodles & green beans',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"chicken_thigh","g":150},{"slug":"noodles_dry","g":80},{"slug":"green_beans","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['woknoodles']::text[],'1. Kook de volkoren noedels (droog) volgens de verpakking.
2. Bak de kipdij in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok sperziebonen beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat noodles (dry) per the package.
2. Pan-fry the chicken thigh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the green beans until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_thigh_with_noodles_spinach','Kipdij met noedels & spinazie','Chicken thigh with noodles & spinach',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"chicken_thigh","g":150},{"slug":"noodles_dry","g":80},{"slug":"spinach","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['woknoodles']::text[],'1. Kook de volkoren noedels (droog) volgens de verpakking.
2. Bak de kipdij in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok spinazie beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat noodles (dry) per the package.
2. Pan-fry the chicken thigh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the spinach until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_thigh_with_noodles_asparagus','Kipdij met noedels & asperges','Chicken thigh with noodles & asparagus',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"chicken_thigh","g":150},{"slug":"noodles_dry","g":80},{"slug":"asparagus","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['woknoodles']::text[],'1. Kook de volkoren noedels (droog) volgens de verpakking.
2. Bak de kipdij in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok asperges beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat noodles (dry) per the package.
2. Pan-fry the chicken thigh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the asparagus until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_thigh_with_noodles_zucchini','Kipdij met noedels & courgette','Chicken thigh with noodles & zucchini',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"chicken_thigh","g":150},{"slug":"noodles_dry","g":80},{"slug":"zucchini","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['woknoodles']::text[],'1. Kook de volkoren noedels (droog) volgens de verpakking.
2. Bak de kipdij in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok courgette beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat noodles (dry) per the package.
2. Pan-fry the chicken thigh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the zucchini until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_thigh_with_noodles_stir_fry_veg','Kipdij met noedels & wokgroente','Chicken thigh with noodles & stir-fry veg',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"chicken_thigh","g":150},{"slug":"noodles_dry","g":80},{"slug":"mixed_veg","g":150},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['woknoodles']::text[],'1. Kook de volkoren noedels (droog) volgens de verpakking.
2. Bak de kipdij in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok wokgroente beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat noodles (dry) per the package.
2. Pan-fry the chicken thigh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the stir-fry veg until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_thigh_with_noodles_mushrooms','Kipdij met noedels & champignons','Chicken thigh with noodles & mushrooms',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"chicken_thigh","g":150},{"slug":"noodles_dry","g":80},{"slug":"mushroom","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['woknoodles']::text[],'1. Kook de volkoren noedels (droog) volgens de verpakking.
2. Bak de kipdij in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok champignons beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat noodles (dry) per the package.
2. Pan-fry the chicken thigh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the mushrooms until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_thigh_with_noodles_carrot','Kipdij met noedels & wortel','Chicken thigh with noodles & carrot',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"chicken_thigh","g":150},{"slug":"noodles_dry","g":80},{"slug":"carrot","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['woknoodles']::text[],'1. Kook de volkoren noedels (droog) volgens de verpakking.
2. Bak de kipdij in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok wortel beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat noodles (dry) per the package.
2. Pan-fry the chicken thigh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the carrot until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_thigh_with_noodles_peas','Kipdij met noedels & doperwten','Chicken thigh with noodles & peas',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"chicken_thigh","g":150},{"slug":"noodles_dry","g":80},{"slug":"peas","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['woknoodles']::text[],'1. Kook de volkoren noedels (droog) volgens de verpakking.
2. Bak de kipdij in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok doperwten beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat noodles (dry) per the package.
2. Pan-fry the chicken thigh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the peas until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_thigh_with_noodles_cauliflower','Kipdij met noedels & bloemkool','Chicken thigh with noodles & cauliflower',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"chicken_thigh","g":150},{"slug":"noodles_dry","g":80},{"slug":"cauliflower","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['woknoodles']::text[],'1. Kook de volkoren noedels (droog) volgens de verpakking.
2. Bak de kipdij in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok bloemkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat noodles (dry) per the package.
2. Pan-fry the chicken thigh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the cauliflower until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_thigh_with_noodles_kale','Kipdij met noedels & boerenkool','Chicken thigh with noodles & kale',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"chicken_thigh","g":150},{"slug":"noodles_dry","g":80},{"slug":"kale","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['woknoodles']::text[],'1. Kook de volkoren noedels (droog) volgens de verpakking.
2. Bak de kipdij in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok boerenkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat noodles (dry) per the package.
2. Pan-fry the chicken thigh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the kale until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_thigh_with_noodles_bok_choy','Kipdij met noedels & paksoi','Chicken thigh with noodles & bok choy',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"chicken_thigh","g":150},{"slug":"noodles_dry","g":80},{"slug":"bok_choy","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['woknoodles']::text[],'1. Kook de volkoren noedels (droog) volgens de verpakking.
2. Bak de kipdij in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok paksoi beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat noodles (dry) per the package.
2. Pan-fry the chicken thigh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the bok choy until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_thigh_with_couscous_broccoli','Kipdij met couscous & broccoli','Chicken thigh with couscous & broccoli',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"chicken_thigh","g":150},{"slug":"couscous_dry","g":70},{"slug":"broccoli","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY[]::text[],'1. Kook de volkoren couscous (droog) volgens de verpakking.
2. Bak de kipdij in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok broccoli beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat couscous (dry) per the package.
2. Pan-fry the chicken thigh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the broccoli until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_thigh_with_couscous_green_beans','Kipdij met couscous & sperziebonen','Chicken thigh with couscous & green beans',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"chicken_thigh","g":150},{"slug":"couscous_dry","g":70},{"slug":"green_beans","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY[]::text[],'1. Kook de volkoren couscous (droog) volgens de verpakking.
2. Bak de kipdij in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok sperziebonen beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat couscous (dry) per the package.
2. Pan-fry the chicken thigh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the green beans until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_thigh_with_couscous_spinach','Kipdij met couscous & spinazie','Chicken thigh with couscous & spinach',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"chicken_thigh","g":150},{"slug":"couscous_dry","g":70},{"slug":"spinach","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY[]::text[],'1. Kook de volkoren couscous (droog) volgens de verpakking.
2. Bak de kipdij in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok spinazie beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat couscous (dry) per the package.
2. Pan-fry the chicken thigh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the spinach until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_thigh_with_couscous_asparagus','Kipdij met couscous & asperges','Chicken thigh with couscous & asparagus',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"chicken_thigh","g":150},{"slug":"couscous_dry","g":70},{"slug":"asparagus","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY[]::text[],'1. Kook de volkoren couscous (droog) volgens de verpakking.
2. Bak de kipdij in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok asperges beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat couscous (dry) per the package.
2. Pan-fry the chicken thigh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the asparagus until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_thigh_with_couscous_zucchini','Kipdij met couscous & courgette','Chicken thigh with couscous & zucchini',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"chicken_thigh","g":150},{"slug":"couscous_dry","g":70},{"slug":"zucchini","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY[]::text[],'1. Kook de volkoren couscous (droog) volgens de verpakking.
2. Bak de kipdij in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok courgette beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat couscous (dry) per the package.
2. Pan-fry the chicken thigh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the zucchini until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_thigh_with_couscous_stir_fry_veg','Kipdij met couscous & wokgroente','Chicken thigh with couscous & stir-fry veg',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"chicken_thigh","g":150},{"slug":"couscous_dry","g":70},{"slug":"mixed_veg","g":150},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY[]::text[],'1. Kook de volkoren couscous (droog) volgens de verpakking.
2. Bak de kipdij in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok wokgroente beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat couscous (dry) per the package.
2. Pan-fry the chicken thigh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the stir-fry veg until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_thigh_with_couscous_mushrooms','Kipdij met couscous & champignons','Chicken thigh with couscous & mushrooms',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"chicken_thigh","g":150},{"slug":"couscous_dry","g":70},{"slug":"mushroom","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de volkoren couscous (droog) volgens de verpakking.
2. Bak de kipdij in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok champignons beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat couscous (dry) per the package.
2. Pan-fry the chicken thigh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the mushrooms until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_thigh_with_couscous_carrot','Kipdij met couscous & wortel','Chicken thigh with couscous & carrot',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"chicken_thigh","g":150},{"slug":"couscous_dry","g":70},{"slug":"carrot","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY[]::text[],'1. Kook de volkoren couscous (droog) volgens de verpakking.
2. Bak de kipdij in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok wortel beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat couscous (dry) per the package.
2. Pan-fry the chicken thigh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the carrot until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_thigh_with_couscous_peas','Kipdij met couscous & doperwten','Chicken thigh with couscous & peas',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"chicken_thigh","g":150},{"slug":"couscous_dry","g":70},{"slug":"peas","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY[]::text[],'1. Kook de volkoren couscous (droog) volgens de verpakking.
2. Bak de kipdij in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok doperwten beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat couscous (dry) per the package.
2. Pan-fry the chicken thigh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the peas until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_thigh_with_couscous_cauliflower','Kipdij met couscous & bloemkool','Chicken thigh with couscous & cauliflower',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"chicken_thigh","g":150},{"slug":"couscous_dry","g":70},{"slug":"cauliflower","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY[]::text[],'1. Kook de volkoren couscous (droog) volgens de verpakking.
2. Bak de kipdij in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok bloemkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat couscous (dry) per the package.
2. Pan-fry the chicken thigh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the cauliflower until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_thigh_with_couscous_kale','Kipdij met couscous & boerenkool','Chicken thigh with couscous & kale',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"chicken_thigh","g":150},{"slug":"couscous_dry","g":70},{"slug":"kale","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY[]::text[],'1. Kook de volkoren couscous (droog) volgens de verpakking.
2. Bak de kipdij in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok boerenkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat couscous (dry) per the package.
2. Pan-fry the chicken thigh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the kale until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_thigh_with_couscous_bok_choy','Kipdij met couscous & paksoi','Chicken thigh with couscous & bok choy',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"chicken_thigh","g":150},{"slug":"couscous_dry","g":70},{"slug":"bok_choy","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY[]::text[],'1. Kook de volkoren couscous (droog) volgens de verpakking.
2. Bak de kipdij in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok paksoi beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat couscous (dry) per the package.
2. Pan-fry the chicken thigh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the bok choy until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_thigh_with_bulgur_broccoli','Kipdij met bulgur & broccoli','Chicken thigh with bulgur & broccoli',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"chicken_thigh","g":150},{"slug":"bulgur_dry","g":70},{"slug":"broccoli","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY[]::text[],'1. Kook de bulgur (droog) volgens de verpakking.
2. Bak de kipdij in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok broccoli beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the bulgur (dry) per the package.
2. Pan-fry the chicken thigh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the broccoli until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_thigh_with_bulgur_green_beans','Kipdij met bulgur & sperziebonen','Chicken thigh with bulgur & green beans',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"chicken_thigh","g":150},{"slug":"bulgur_dry","g":70},{"slug":"green_beans","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY[]::text[],'1. Kook de bulgur (droog) volgens de verpakking.
2. Bak de kipdij in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok sperziebonen beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the bulgur (dry) per the package.
2. Pan-fry the chicken thigh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the green beans until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_thigh_with_bulgur_spinach','Kipdij met bulgur & spinazie','Chicken thigh with bulgur & spinach',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"chicken_thigh","g":150},{"slug":"bulgur_dry","g":70},{"slug":"spinach","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY[]::text[],'1. Kook de bulgur (droog) volgens de verpakking.
2. Bak de kipdij in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok spinazie beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the bulgur (dry) per the package.
2. Pan-fry the chicken thigh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the spinach until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_thigh_with_bulgur_asparagus','Kipdij met bulgur & asperges','Chicken thigh with bulgur & asparagus',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"chicken_thigh","g":150},{"slug":"bulgur_dry","g":70},{"slug":"asparagus","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY[]::text[],'1. Kook de bulgur (droog) volgens de verpakking.
2. Bak de kipdij in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok asperges beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the bulgur (dry) per the package.
2. Pan-fry the chicken thigh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the asparagus until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_thigh_with_bulgur_zucchini','Kipdij met bulgur & courgette','Chicken thigh with bulgur & zucchini',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"chicken_thigh","g":150},{"slug":"bulgur_dry","g":70},{"slug":"zucchini","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY[]::text[],'1. Kook de bulgur (droog) volgens de verpakking.
2. Bak de kipdij in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok courgette beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the bulgur (dry) per the package.
2. Pan-fry the chicken thigh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the zucchini until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_thigh_with_bulgur_stir_fry_veg','Kipdij met bulgur & wokgroente','Chicken thigh with bulgur & stir-fry veg',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"chicken_thigh","g":150},{"slug":"bulgur_dry","g":70},{"slug":"mixed_veg","g":150},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY[]::text[],'1. Kook de bulgur (droog) volgens de verpakking.
2. Bak de kipdij in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok wokgroente beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the bulgur (dry) per the package.
2. Pan-fry the chicken thigh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the stir-fry veg until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_thigh_with_bulgur_mushrooms','Kipdij met bulgur & champignons','Chicken thigh with bulgur & mushrooms',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"chicken_thigh","g":150},{"slug":"bulgur_dry","g":70},{"slug":"mushroom","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de bulgur (droog) volgens de verpakking.
2. Bak de kipdij in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok champignons beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the bulgur (dry) per the package.
2. Pan-fry the chicken thigh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the mushrooms until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_thigh_with_bulgur_carrot','Kipdij met bulgur & wortel','Chicken thigh with bulgur & carrot',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"chicken_thigh","g":150},{"slug":"bulgur_dry","g":70},{"slug":"carrot","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY[]::text[],'1. Kook de bulgur (droog) volgens de verpakking.
2. Bak de kipdij in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok wortel beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the bulgur (dry) per the package.
2. Pan-fry the chicken thigh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the carrot until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_thigh_with_bulgur_peas','Kipdij met bulgur & doperwten','Chicken thigh with bulgur & peas',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"chicken_thigh","g":150},{"slug":"bulgur_dry","g":70},{"slug":"peas","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY[]::text[],'1. Kook de bulgur (droog) volgens de verpakking.
2. Bak de kipdij in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok doperwten beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the bulgur (dry) per the package.
2. Pan-fry the chicken thigh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the peas until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_thigh_with_bulgur_cauliflower','Kipdij met bulgur & bloemkool','Chicken thigh with bulgur & cauliflower',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"chicken_thigh","g":150},{"slug":"bulgur_dry","g":70},{"slug":"cauliflower","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY[]::text[],'1. Kook de bulgur (droog) volgens de verpakking.
2. Bak de kipdij in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok bloemkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the bulgur (dry) per the package.
2. Pan-fry the chicken thigh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the cauliflower until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_thigh_with_bulgur_kale','Kipdij met bulgur & boerenkool','Chicken thigh with bulgur & kale',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"chicken_thigh","g":150},{"slug":"bulgur_dry","g":70},{"slug":"kale","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY[]::text[],'1. Kook de bulgur (droog) volgens de verpakking.
2. Bak de kipdij in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok boerenkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the bulgur (dry) per the package.
2. Pan-fry the chicken thigh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the kale until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_thigh_with_bulgur_bok_choy','Kipdij met bulgur & paksoi','Chicken thigh with bulgur & bok choy',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"chicken_thigh","g":150},{"slug":"bulgur_dry","g":70},{"slug":"bok_choy","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY[]::text[],'1. Kook de bulgur (droog) volgens de verpakking.
2. Bak de kipdij in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok paksoi beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the bulgur (dry) per the package.
2. Pan-fry the chicken thigh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the bok choy until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_thigh_with_basmati_rice_broccoli','Kipdij met basmatirijst & broccoli','Chicken thigh with basmati rice & broccoli',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"chicken_thigh","g":150},{"slug":"basmati_dry","g":70},{"slug":"broccoli","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY[]::text[],'1. Kook de basmatirijst (droog) volgens de verpakking.
2. Bak de kipdij in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok broccoli beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the basmati rice (dry) per the package.
2. Pan-fry the chicken thigh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the broccoli until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_thigh_with_basmati_rice_green_beans','Kipdij met basmatirijst & sperziebonen','Chicken thigh with basmati rice & green beans',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"chicken_thigh","g":150},{"slug":"basmati_dry","g":70},{"slug":"green_beans","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY[]::text[],'1. Kook de basmatirijst (droog) volgens de verpakking.
2. Bak de kipdij in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok sperziebonen beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the basmati rice (dry) per the package.
2. Pan-fry the chicken thigh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the green beans until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_thigh_with_basmati_rice_spinach','Kipdij met basmatirijst & spinazie','Chicken thigh with basmati rice & spinach',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"chicken_thigh","g":150},{"slug":"basmati_dry","g":70},{"slug":"spinach","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY[]::text[],'1. Kook de basmatirijst (droog) volgens de verpakking.
2. Bak de kipdij in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok spinazie beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the basmati rice (dry) per the package.
2. Pan-fry the chicken thigh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the spinach until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_thigh_with_basmati_rice_asparagus','Kipdij met basmatirijst & asperges','Chicken thigh with basmati rice & asparagus',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"chicken_thigh","g":150},{"slug":"basmati_dry","g":70},{"slug":"asparagus","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY[]::text[],'1. Kook de basmatirijst (droog) volgens de verpakking.
2. Bak de kipdij in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok asperges beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the basmati rice (dry) per the package.
2. Pan-fry the chicken thigh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the asparagus until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_thigh_with_basmati_rice_zucchini','Kipdij met basmatirijst & courgette','Chicken thigh with basmati rice & zucchini',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"chicken_thigh","g":150},{"slug":"basmati_dry","g":70},{"slug":"zucchini","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY[]::text[],'1. Kook de basmatirijst (droog) volgens de verpakking.
2. Bak de kipdij in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok courgette beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the basmati rice (dry) per the package.
2. Pan-fry the chicken thigh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the zucchini until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_thigh_with_basmati_rice_stir_fry_veg','Kipdij met basmatirijst & wokgroente','Chicken thigh with basmati rice & stir-fry veg',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"chicken_thigh","g":150},{"slug":"basmati_dry","g":70},{"slug":"mixed_veg","g":150},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY[]::text[],'1. Kook de basmatirijst (droog) volgens de verpakking.
2. Bak de kipdij in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok wokgroente beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the basmati rice (dry) per the package.
2. Pan-fry the chicken thigh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the stir-fry veg until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_thigh_with_basmati_rice_mushrooms','Kipdij met basmatirijst & champignons','Chicken thigh with basmati rice & mushrooms',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"chicken_thigh","g":150},{"slug":"basmati_dry","g":70},{"slug":"mushroom","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY[]::text[],'1. Kook de basmatirijst (droog) volgens de verpakking.
2. Bak de kipdij in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok champignons beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the basmati rice (dry) per the package.
2. Pan-fry the chicken thigh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the mushrooms until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_thigh_with_basmati_rice_carrot','Kipdij met basmatirijst & wortel','Chicken thigh with basmati rice & carrot',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"chicken_thigh","g":150},{"slug":"basmati_dry","g":70},{"slug":"carrot","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY[]::text[],'1. Kook de basmatirijst (droog) volgens de verpakking.
2. Bak de kipdij in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok wortel beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the basmati rice (dry) per the package.
2. Pan-fry the chicken thigh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the carrot until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_thigh_with_basmati_rice_peas','Kipdij met basmatirijst & doperwten','Chicken thigh with basmati rice & peas',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"chicken_thigh","g":150},{"slug":"basmati_dry","g":70},{"slug":"peas","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY[]::text[],'1. Kook de basmatirijst (droog) volgens de verpakking.
2. Bak de kipdij in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok doperwten beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the basmati rice (dry) per the package.
2. Pan-fry the chicken thigh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the peas until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_thigh_with_basmati_rice_cauliflower','Kipdij met basmatirijst & bloemkool','Chicken thigh with basmati rice & cauliflower',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"chicken_thigh","g":150},{"slug":"basmati_dry","g":70},{"slug":"cauliflower","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY[]::text[],'1. Kook de basmatirijst (droog) volgens de verpakking.
2. Bak de kipdij in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok bloemkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the basmati rice (dry) per the package.
2. Pan-fry the chicken thigh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the cauliflower until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_thigh_with_basmati_rice_kale','Kipdij met basmatirijst & boerenkool','Chicken thigh with basmati rice & kale',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"chicken_thigh","g":150},{"slug":"basmati_dry","g":70},{"slug":"kale","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY[]::text[],'1. Kook de basmatirijst (droog) volgens de verpakking.
2. Bak de kipdij in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok boerenkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the basmati rice (dry) per the package.
2. Pan-fry the chicken thigh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the kale until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_thigh_with_basmati_rice_bok_choy','Kipdij met basmatirijst & paksoi','Chicken thigh with basmati rice & bok choy',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"chicken_thigh","g":150},{"slug":"basmati_dry","g":70},{"slug":"bok_choy","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY[]::text[],'1. Kook de basmatirijst (droog) volgens de verpakking.
2. Bak de kipdij in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok paksoi beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the basmati rice (dry) per the package.
2. Pan-fry the chicken thigh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the bok choy until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('white_fish_with_rice_broccoli','Witvis met rijst & broccoli','White fish with rice & broccoli',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"white_fish","g":170},{"slug":"rice_dry","g":70},{"slug":"broccoli","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Kook de witte rijst (droog) volgens de verpakking.
2. Bak of pocheer de witvis (tilapia) kort tot net gaar; kruid met peper en zout.
3. Stoom of wok broccoli beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the white rice (dry) per the package.
2. Sear or poach the white fish (tilapia) until just done; season with salt and pepper.
3. Steam or stir-fry the broccoli until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('white_fish_with_rice_green_beans','Witvis met rijst & sperziebonen','White fish with rice & green beans',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"white_fish","g":170},{"slug":"rice_dry","g":70},{"slug":"green_beans","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Kook de witte rijst (droog) volgens de verpakking.
2. Bak of pocheer de witvis (tilapia) kort tot net gaar; kruid met peper en zout.
3. Stoom of wok sperziebonen beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the white rice (dry) per the package.
2. Sear or poach the white fish (tilapia) until just done; season with salt and pepper.
3. Steam or stir-fry the green beans until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('white_fish_with_rice_spinach','Witvis met rijst & spinazie','White fish with rice & spinach',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"white_fish","g":170},{"slug":"rice_dry","g":70},{"slug":"spinach","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Kook de witte rijst (droog) volgens de verpakking.
2. Bak of pocheer de witvis (tilapia) kort tot net gaar; kruid met peper en zout.
3. Stoom of wok spinazie beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the white rice (dry) per the package.
2. Sear or poach the white fish (tilapia) until just done; season with salt and pepper.
3. Steam or stir-fry the spinach until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('white_fish_with_rice_asparagus','Witvis met rijst & asperges','White fish with rice & asparagus',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"white_fish","g":170},{"slug":"rice_dry","g":70},{"slug":"asparagus","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Kook de witte rijst (droog) volgens de verpakking.
2. Bak of pocheer de witvis (tilapia) kort tot net gaar; kruid met peper en zout.
3. Stoom of wok asperges beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the white rice (dry) per the package.
2. Sear or poach the white fish (tilapia) until just done; season with salt and pepper.
3. Steam or stir-fry the asparagus until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('white_fish_with_rice_zucchini','Witvis met rijst & courgette','White fish with rice & zucchini',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"white_fish","g":170},{"slug":"rice_dry","g":70},{"slug":"zucchini","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Kook de witte rijst (droog) volgens de verpakking.
2. Bak of pocheer de witvis (tilapia) kort tot net gaar; kruid met peper en zout.
3. Stoom of wok courgette beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the white rice (dry) per the package.
2. Sear or poach the white fish (tilapia) until just done; season with salt and pepper.
3. Steam or stir-fry the zucchini until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('white_fish_with_rice_stir_fry_veg','Witvis met rijst & wokgroente','White fish with rice & stir-fry veg',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"white_fish","g":170},{"slug":"rice_dry","g":70},{"slug":"mixed_veg","g":150},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Kook de witte rijst (droog) volgens de verpakking.
2. Bak of pocheer de witvis (tilapia) kort tot net gaar; kruid met peper en zout.
3. Stoom of wok wokgroente beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the white rice (dry) per the package.
2. Sear or poach the white fish (tilapia) until just done; season with salt and pepper.
3. Steam or stir-fry the stir-fry veg until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('white_fish_with_rice_mushrooms','Witvis met rijst & champignons','White fish with rice & mushrooms',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"white_fish","g":170},{"slug":"rice_dry","g":70},{"slug":"mushroom","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Kook de witte rijst (droog) volgens de verpakking.
2. Bak of pocheer de witvis (tilapia) kort tot net gaar; kruid met peper en zout.
3. Stoom of wok champignons beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the white rice (dry) per the package.
2. Sear or poach the white fish (tilapia) until just done; season with salt and pepper.
3. Steam or stir-fry the mushrooms until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('white_fish_with_rice_carrot','Witvis met rijst & wortel','White fish with rice & carrot',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"white_fish","g":170},{"slug":"rice_dry","g":70},{"slug":"carrot","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Kook de witte rijst (droog) volgens de verpakking.
2. Bak of pocheer de witvis (tilapia) kort tot net gaar; kruid met peper en zout.
3. Stoom of wok wortel beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the white rice (dry) per the package.
2. Sear or poach the white fish (tilapia) until just done; season with salt and pepper.
3. Steam or stir-fry the carrot until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('white_fish_with_rice_peas','Witvis met rijst & doperwten','White fish with rice & peas',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"white_fish","g":170},{"slug":"rice_dry","g":70},{"slug":"peas","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Kook de witte rijst (droog) volgens de verpakking.
2. Bak of pocheer de witvis (tilapia) kort tot net gaar; kruid met peper en zout.
3. Stoom of wok doperwten beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the white rice (dry) per the package.
2. Sear or poach the white fish (tilapia) until just done; season with salt and pepper.
3. Steam or stir-fry the peas until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('white_fish_with_rice_cauliflower','Witvis met rijst & bloemkool','White fish with rice & cauliflower',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"white_fish","g":170},{"slug":"rice_dry","g":70},{"slug":"cauliflower","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Kook de witte rijst (droog) volgens de verpakking.
2. Bak of pocheer de witvis (tilapia) kort tot net gaar; kruid met peper en zout.
3. Stoom of wok bloemkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the white rice (dry) per the package.
2. Sear or poach the white fish (tilapia) until just done; season with salt and pepper.
3. Steam or stir-fry the cauliflower until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('white_fish_with_rice_kale','Witvis met rijst & boerenkool','White fish with rice & kale',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"white_fish","g":170},{"slug":"rice_dry","g":70},{"slug":"kale","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Kook de witte rijst (droog) volgens de verpakking.
2. Bak of pocheer de witvis (tilapia) kort tot net gaar; kruid met peper en zout.
3. Stoom of wok boerenkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the white rice (dry) per the package.
2. Sear or poach the white fish (tilapia) until just done; season with salt and pepper.
3. Steam or stir-fry the kale until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('white_fish_with_rice_bok_choy','Witvis met rijst & paksoi','White fish with rice & bok choy',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"white_fish","g":170},{"slug":"rice_dry","g":70},{"slug":"bok_choy","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Kook de witte rijst (droog) volgens de verpakking.
2. Bak of pocheer de witvis (tilapia) kort tot net gaar; kruid met peper en zout.
3. Stoom of wok paksoi beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the white rice (dry) per the package.
2. Sear or poach the white fish (tilapia) until just done; season with salt and pepper.
3. Steam or stir-fry the bok choy until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('white_fish_with_sweet_potato_broccoli','Witvis met zoete aardappel & broccoli','White fish with sweet potato & broccoli',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"white_fish","g":170},{"slug":"sweet_potato","g":200},{"slug":"broccoli","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de zoete aardappel volgens de verpakking.
2. Bak of pocheer de witvis (tilapia) kort tot net gaar; kruid met peper en zout.
3. Stoom of wok broccoli beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the sweet potato per the package.
2. Sear or poach the white fish (tilapia) until just done; season with salt and pepper.
3. Steam or stir-fry the broccoli until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('white_fish_with_sweet_potato_green_beans','Witvis met zoete aardappel & sperziebonen','White fish with sweet potato & green beans',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"white_fish","g":170},{"slug":"sweet_potato","g":200},{"slug":"green_beans","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de zoete aardappel volgens de verpakking.
2. Bak of pocheer de witvis (tilapia) kort tot net gaar; kruid met peper en zout.
3. Stoom of wok sperziebonen beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the sweet potato per the package.
2. Sear or poach the white fish (tilapia) until just done; season with salt and pepper.
3. Steam or stir-fry the green beans until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('white_fish_with_sweet_potato_spinach','Witvis met zoete aardappel & spinazie','White fish with sweet potato & spinach',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"white_fish","g":170},{"slug":"sweet_potato","g":200},{"slug":"spinach","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de zoete aardappel volgens de verpakking.
2. Bak of pocheer de witvis (tilapia) kort tot net gaar; kruid met peper en zout.
3. Stoom of wok spinazie beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the sweet potato per the package.
2. Sear or poach the white fish (tilapia) until just done; season with salt and pepper.
3. Steam or stir-fry the spinach until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('white_fish_with_sweet_potato_asparagus','Witvis met zoete aardappel & asperges','White fish with sweet potato & asparagus',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"white_fish","g":170},{"slug":"sweet_potato","g":200},{"slug":"asparagus","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de zoete aardappel volgens de verpakking.
2. Bak of pocheer de witvis (tilapia) kort tot net gaar; kruid met peper en zout.
3. Stoom of wok asperges beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the sweet potato per the package.
2. Sear or poach the white fish (tilapia) until just done; season with salt and pepper.
3. Steam or stir-fry the asparagus until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('white_fish_with_sweet_potato_zucchini','Witvis met zoete aardappel & courgette','White fish with sweet potato & zucchini',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"white_fish","g":170},{"slug":"sweet_potato","g":200},{"slug":"zucchini","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de zoete aardappel volgens de verpakking.
2. Bak of pocheer de witvis (tilapia) kort tot net gaar; kruid met peper en zout.
3. Stoom of wok courgette beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the sweet potato per the package.
2. Sear or poach the white fish (tilapia) until just done; season with salt and pepper.
3. Steam or stir-fry the zucchini until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('white_fish_with_sweet_potato_stir_fry_veg','Witvis met zoete aardappel & wokgroente','White fish with sweet potato & stir-fry veg',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"white_fish","g":170},{"slug":"sweet_potato","g":200},{"slug":"mixed_veg","g":150},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de zoete aardappel volgens de verpakking.
2. Bak of pocheer de witvis (tilapia) kort tot net gaar; kruid met peper en zout.
3. Stoom of wok wokgroente beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the sweet potato per the package.
2. Sear or poach the white fish (tilapia) until just done; season with salt and pepper.
3. Steam or stir-fry the stir-fry veg until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('white_fish_with_sweet_potato_mushrooms','Witvis met zoete aardappel & champignons','White fish with sweet potato & mushrooms',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"white_fish","g":170},{"slug":"sweet_potato","g":200},{"slug":"mushroom","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de zoete aardappel volgens de verpakking.
2. Bak of pocheer de witvis (tilapia) kort tot net gaar; kruid met peper en zout.
3. Stoom of wok champignons beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the sweet potato per the package.
2. Sear or poach the white fish (tilapia) until just done; season with salt and pepper.
3. Steam or stir-fry the mushrooms until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('white_fish_with_sweet_potato_carrot','Witvis met zoete aardappel & wortel','White fish with sweet potato & carrot',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"white_fish","g":170},{"slug":"sweet_potato","g":200},{"slug":"carrot","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de zoete aardappel volgens de verpakking.
2. Bak of pocheer de witvis (tilapia) kort tot net gaar; kruid met peper en zout.
3. Stoom of wok wortel beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the sweet potato per the package.
2. Sear or poach the white fish (tilapia) until just done; season with salt and pepper.
3. Steam or stir-fry the carrot until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('white_fish_with_sweet_potato_peas','Witvis met zoete aardappel & doperwten','White fish with sweet potato & peas',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"white_fish","g":170},{"slug":"sweet_potato","g":200},{"slug":"peas","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de zoete aardappel volgens de verpakking.
2. Bak of pocheer de witvis (tilapia) kort tot net gaar; kruid met peper en zout.
3. Stoom of wok doperwten beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the sweet potato per the package.
2. Sear or poach the white fish (tilapia) until just done; season with salt and pepper.
3. Steam or stir-fry the peas until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('white_fish_with_sweet_potato_cauliflower','Witvis met zoete aardappel & bloemkool','White fish with sweet potato & cauliflower',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"white_fish","g":170},{"slug":"sweet_potato","g":200},{"slug":"cauliflower","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de zoete aardappel volgens de verpakking.
2. Bak of pocheer de witvis (tilapia) kort tot net gaar; kruid met peper en zout.
3. Stoom of wok bloemkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the sweet potato per the package.
2. Sear or poach the white fish (tilapia) until just done; season with salt and pepper.
3. Steam or stir-fry the cauliflower until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('white_fish_with_sweet_potato_kale','Witvis met zoete aardappel & boerenkool','White fish with sweet potato & kale',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"white_fish","g":170},{"slug":"sweet_potato","g":200},{"slug":"kale","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de zoete aardappel volgens de verpakking.
2. Bak of pocheer de witvis (tilapia) kort tot net gaar; kruid met peper en zout.
3. Stoom of wok boerenkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the sweet potato per the package.
2. Sear or poach the white fish (tilapia) until just done; season with salt and pepper.
3. Steam or stir-fry the kale until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('white_fish_with_sweet_potato_bok_choy','Witvis met zoete aardappel & paksoi','White fish with sweet potato & bok choy',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"white_fish","g":170},{"slug":"sweet_potato","g":200},{"slug":"bok_choy","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de zoete aardappel volgens de verpakking.
2. Bak of pocheer de witvis (tilapia) kort tot net gaar; kruid met peper en zout.
3. Stoom of wok paksoi beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the sweet potato per the package.
2. Sear or poach the white fish (tilapia) until just done; season with salt and pepper.
3. Steam or stir-fry the bok choy until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('white_fish_with_potato_broccoli','Witvis met aardappel & broccoli','White fish with potato & broccoli',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"white_fish","g":170},{"slug":"potato","g":250},{"slug":"broccoli","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['steakpotato']::text[],'1. Kook de aardappel volgens de verpakking.
2. Bak of pocheer de witvis (tilapia) kort tot net gaar; kruid met peper en zout.
3. Stoom of wok broccoli beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the potato per the package.
2. Sear or poach the white fish (tilapia) until just done; season with salt and pepper.
3. Steam or stir-fry the broccoli until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('white_fish_with_potato_green_beans','Witvis met aardappel & sperziebonen','White fish with potato & green beans',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"white_fish","g":170},{"slug":"potato","g":250},{"slug":"green_beans","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['steakpotato']::text[],'1. Kook de aardappel volgens de verpakking.
2. Bak of pocheer de witvis (tilapia) kort tot net gaar; kruid met peper en zout.
3. Stoom of wok sperziebonen beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the potato per the package.
2. Sear or poach the white fish (tilapia) until just done; season with salt and pepper.
3. Steam or stir-fry the green beans until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('white_fish_with_potato_spinach','Witvis met aardappel & spinazie','White fish with potato & spinach',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"white_fish","g":170},{"slug":"potato","g":250},{"slug":"spinach","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['steakpotato']::text[],'1. Kook de aardappel volgens de verpakking.
2. Bak of pocheer de witvis (tilapia) kort tot net gaar; kruid met peper en zout.
3. Stoom of wok spinazie beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the potato per the package.
2. Sear or poach the white fish (tilapia) until just done; season with salt and pepper.
3. Steam or stir-fry the spinach until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('white_fish_with_potato_asparagus','Witvis met aardappel & asperges','White fish with potato & asparagus',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"white_fish","g":170},{"slug":"potato","g":250},{"slug":"asparagus","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['steakpotato']::text[],'1. Kook de aardappel volgens de verpakking.
2. Bak of pocheer de witvis (tilapia) kort tot net gaar; kruid met peper en zout.
3. Stoom of wok asperges beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the potato per the package.
2. Sear or poach the white fish (tilapia) until just done; season with salt and pepper.
3. Steam or stir-fry the asparagus until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('white_fish_with_potato_zucchini','Witvis met aardappel & courgette','White fish with potato & zucchini',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"white_fish","g":170},{"slug":"potato","g":250},{"slug":"zucchini","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['steakpotato']::text[],'1. Kook de aardappel volgens de verpakking.
2. Bak of pocheer de witvis (tilapia) kort tot net gaar; kruid met peper en zout.
3. Stoom of wok courgette beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the potato per the package.
2. Sear or poach the white fish (tilapia) until just done; season with salt and pepper.
3. Steam or stir-fry the zucchini until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('white_fish_with_potato_stir_fry_veg','Witvis met aardappel & wokgroente','White fish with potato & stir-fry veg',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"white_fish","g":170},{"slug":"potato","g":250},{"slug":"mixed_veg","g":150},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['steakpotato']::text[],'1. Kook de aardappel volgens de verpakking.
2. Bak of pocheer de witvis (tilapia) kort tot net gaar; kruid met peper en zout.
3. Stoom of wok wokgroente beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the potato per the package.
2. Sear or poach the white fish (tilapia) until just done; season with salt and pepper.
3. Steam or stir-fry the stir-fry veg until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('white_fish_with_potato_mushrooms','Witvis met aardappel & champignons','White fish with potato & mushrooms',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"white_fish","g":170},{"slug":"potato","g":250},{"slug":"mushroom","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['steakpotato']::text[],'1. Kook de aardappel volgens de verpakking.
2. Bak of pocheer de witvis (tilapia) kort tot net gaar; kruid met peper en zout.
3. Stoom of wok champignons beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the potato per the package.
2. Sear or poach the white fish (tilapia) until just done; season with salt and pepper.
3. Steam or stir-fry the mushrooms until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('white_fish_with_potato_carrot','Witvis met aardappel & wortel','White fish with potato & carrot',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"white_fish","g":170},{"slug":"potato","g":250},{"slug":"carrot","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['steakpotato']::text[],'1. Kook de aardappel volgens de verpakking.
2. Bak of pocheer de witvis (tilapia) kort tot net gaar; kruid met peper en zout.
3. Stoom of wok wortel beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the potato per the package.
2. Sear or poach the white fish (tilapia) until just done; season with salt and pepper.
3. Steam or stir-fry the carrot until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('white_fish_with_potato_peas','Witvis met aardappel & doperwten','White fish with potato & peas',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"white_fish","g":170},{"slug":"potato","g":250},{"slug":"peas","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['steakpotato']::text[],'1. Kook de aardappel volgens de verpakking.
2. Bak of pocheer de witvis (tilapia) kort tot net gaar; kruid met peper en zout.
3. Stoom of wok doperwten beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the potato per the package.
2. Sear or poach the white fish (tilapia) until just done; season with salt and pepper.
3. Steam or stir-fry the peas until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('white_fish_with_potato_cauliflower','Witvis met aardappel & bloemkool','White fish with potato & cauliflower',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"white_fish","g":170},{"slug":"potato","g":250},{"slug":"cauliflower","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['steakpotato']::text[],'1. Kook de aardappel volgens de verpakking.
2. Bak of pocheer de witvis (tilapia) kort tot net gaar; kruid met peper en zout.
3. Stoom of wok bloemkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the potato per the package.
2. Sear or poach the white fish (tilapia) until just done; season with salt and pepper.
3. Steam or stir-fry the cauliflower until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('white_fish_with_potato_kale','Witvis met aardappel & boerenkool','White fish with potato & kale',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"white_fish","g":170},{"slug":"potato","g":250},{"slug":"kale","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['steakpotato']::text[],'1. Kook de aardappel volgens de verpakking.
2. Bak of pocheer de witvis (tilapia) kort tot net gaar; kruid met peper en zout.
3. Stoom of wok boerenkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the potato per the package.
2. Sear or poach the white fish (tilapia) until just done; season with salt and pepper.
3. Steam or stir-fry the kale until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('white_fish_with_potato_bok_choy','Witvis met aardappel & paksoi','White fish with potato & bok choy',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"white_fish","g":170},{"slug":"potato","g":250},{"slug":"bok_choy","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['steakpotato']::text[],'1. Kook de aardappel volgens de verpakking.
2. Bak of pocheer de witvis (tilapia) kort tot net gaar; kruid met peper en zout.
3. Stoom of wok paksoi beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the potato per the package.
2. Sear or poach the white fish (tilapia) until just done; season with salt and pepper.
3. Steam or stir-fry the bok choy until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('white_fish_with_pasta_broccoli','Witvis met pasta & broccoli','White fish with pasta & broccoli',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"white_fish","g":170},{"slug":"pasta_dry","g":80},{"slug":"broccoli","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['pastabol']::text[],'1. Kook de volkoren pasta (droog) volgens de verpakking.
2. Bak of pocheer de witvis (tilapia) kort tot net gaar; kruid met peper en zout.
3. Stoom of wok broccoli beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat pasta (dry) per the package.
2. Sear or poach the white fish (tilapia) until just done; season with salt and pepper.
3. Steam or stir-fry the broccoli until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('white_fish_with_pasta_green_beans','Witvis met pasta & sperziebonen','White fish with pasta & green beans',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"white_fish","g":170},{"slug":"pasta_dry","g":80},{"slug":"green_beans","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['pastabol']::text[],'1. Kook de volkoren pasta (droog) volgens de verpakking.
2. Bak of pocheer de witvis (tilapia) kort tot net gaar; kruid met peper en zout.
3. Stoom of wok sperziebonen beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat pasta (dry) per the package.
2. Sear or poach the white fish (tilapia) until just done; season with salt and pepper.
3. Steam or stir-fry the green beans until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('white_fish_with_pasta_spinach','Witvis met pasta & spinazie','White fish with pasta & spinach',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"white_fish","g":170},{"slug":"pasta_dry","g":80},{"slug":"spinach","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['pastabol']::text[],'1. Kook de volkoren pasta (droog) volgens de verpakking.
2. Bak of pocheer de witvis (tilapia) kort tot net gaar; kruid met peper en zout.
3. Stoom of wok spinazie beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat pasta (dry) per the package.
2. Sear or poach the white fish (tilapia) until just done; season with salt and pepper.
3. Steam or stir-fry the spinach until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('white_fish_with_pasta_asparagus','Witvis met pasta & asperges','White fish with pasta & asparagus',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"white_fish","g":170},{"slug":"pasta_dry","g":80},{"slug":"asparagus","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['pastabol']::text[],'1. Kook de volkoren pasta (droog) volgens de verpakking.
2. Bak of pocheer de witvis (tilapia) kort tot net gaar; kruid met peper en zout.
3. Stoom of wok asperges beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat pasta (dry) per the package.
2. Sear or poach the white fish (tilapia) until just done; season with salt and pepper.
3. Steam or stir-fry the asparagus until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('white_fish_with_pasta_zucchini','Witvis met pasta & courgette','White fish with pasta & zucchini',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"white_fish","g":170},{"slug":"pasta_dry","g":80},{"slug":"zucchini","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['pastabol']::text[],'1. Kook de volkoren pasta (droog) volgens de verpakking.
2. Bak of pocheer de witvis (tilapia) kort tot net gaar; kruid met peper en zout.
3. Stoom of wok courgette beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat pasta (dry) per the package.
2. Sear or poach the white fish (tilapia) until just done; season with salt and pepper.
3. Steam or stir-fry the zucchini until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('white_fish_with_pasta_stir_fry_veg','Witvis met pasta & wokgroente','White fish with pasta & stir-fry veg',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"white_fish","g":170},{"slug":"pasta_dry","g":80},{"slug":"mixed_veg","g":150},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['pastabol']::text[],'1. Kook de volkoren pasta (droog) volgens de verpakking.
2. Bak of pocheer de witvis (tilapia) kort tot net gaar; kruid met peper en zout.
3. Stoom of wok wokgroente beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat pasta (dry) per the package.
2. Sear or poach the white fish (tilapia) until just done; season with salt and pepper.
3. Steam or stir-fry the stir-fry veg until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('white_fish_with_pasta_mushrooms','Witvis met pasta & champignons','White fish with pasta & mushrooms',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"white_fish","g":170},{"slug":"pasta_dry","g":80},{"slug":"mushroom","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['pastabol']::text[],'1. Kook de volkoren pasta (droog) volgens de verpakking.
2. Bak of pocheer de witvis (tilapia) kort tot net gaar; kruid met peper en zout.
3. Stoom of wok champignons beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat pasta (dry) per the package.
2. Sear or poach the white fish (tilapia) until just done; season with salt and pepper.
3. Steam or stir-fry the mushrooms until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('white_fish_with_pasta_carrot','Witvis met pasta & wortel','White fish with pasta & carrot',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"white_fish","g":170},{"slug":"pasta_dry","g":80},{"slug":"carrot","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['pastabol']::text[],'1. Kook de volkoren pasta (droog) volgens de verpakking.
2. Bak of pocheer de witvis (tilapia) kort tot net gaar; kruid met peper en zout.
3. Stoom of wok wortel beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat pasta (dry) per the package.
2. Sear or poach the white fish (tilapia) until just done; season with salt and pepper.
3. Steam or stir-fry the carrot until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('white_fish_with_pasta_peas','Witvis met pasta & doperwten','White fish with pasta & peas',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"white_fish","g":170},{"slug":"pasta_dry","g":80},{"slug":"peas","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['pastabol']::text[],'1. Kook de volkoren pasta (droog) volgens de verpakking.
2. Bak of pocheer de witvis (tilapia) kort tot net gaar; kruid met peper en zout.
3. Stoom of wok doperwten beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat pasta (dry) per the package.
2. Sear or poach the white fish (tilapia) until just done; season with salt and pepper.
3. Steam or stir-fry the peas until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('white_fish_with_pasta_cauliflower','Witvis met pasta & bloemkool','White fish with pasta & cauliflower',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"white_fish","g":170},{"slug":"pasta_dry","g":80},{"slug":"cauliflower","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['pastabol']::text[],'1. Kook de volkoren pasta (droog) volgens de verpakking.
2. Bak of pocheer de witvis (tilapia) kort tot net gaar; kruid met peper en zout.
3. Stoom of wok bloemkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat pasta (dry) per the package.
2. Sear or poach the white fish (tilapia) until just done; season with salt and pepper.
3. Steam or stir-fry the cauliflower until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('white_fish_with_pasta_kale','Witvis met pasta & boerenkool','White fish with pasta & kale',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"white_fish","g":170},{"slug":"pasta_dry","g":80},{"slug":"kale","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['pastabol']::text[],'1. Kook de volkoren pasta (droog) volgens de verpakking.
2. Bak of pocheer de witvis (tilapia) kort tot net gaar; kruid met peper en zout.
3. Stoom of wok boerenkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat pasta (dry) per the package.
2. Sear or poach the white fish (tilapia) until just done; season with salt and pepper.
3. Steam or stir-fry the kale until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('white_fish_with_pasta_bok_choy','Witvis met pasta & paksoi','White fish with pasta & bok choy',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"white_fish","g":170},{"slug":"pasta_dry","g":80},{"slug":"bok_choy","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['pastabol']::text[],'1. Kook de volkoren pasta (droog) volgens de verpakking.
2. Bak of pocheer de witvis (tilapia) kort tot net gaar; kruid met peper en zout.
3. Stoom of wok paksoi beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat pasta (dry) per the package.
2. Sear or poach the white fish (tilapia) until just done; season with salt and pepper.
3. Steam or stir-fry the bok choy until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('white_fish_with_quinoa_broccoli','Witvis met quinoa & broccoli','White fish with quinoa & broccoli',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"white_fish","g":170},{"slug":"quinoa_dry","g":70},{"slug":"broccoli","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de quinoa (droog) volgens de verpakking.
2. Bak of pocheer de witvis (tilapia) kort tot net gaar; kruid met peper en zout.
3. Stoom of wok broccoli beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the quinoa (dry) per the package.
2. Sear or poach the white fish (tilapia) until just done; season with salt and pepper.
3. Steam or stir-fry the broccoli until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('white_fish_with_quinoa_green_beans','Witvis met quinoa & sperziebonen','White fish with quinoa & green beans',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"white_fish","g":170},{"slug":"quinoa_dry","g":70},{"slug":"green_beans","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de quinoa (droog) volgens de verpakking.
2. Bak of pocheer de witvis (tilapia) kort tot net gaar; kruid met peper en zout.
3. Stoom of wok sperziebonen beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the quinoa (dry) per the package.
2. Sear or poach the white fish (tilapia) until just done; season with salt and pepper.
3. Steam or stir-fry the green beans until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('white_fish_with_quinoa_spinach','Witvis met quinoa & spinazie','White fish with quinoa & spinach',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"white_fish","g":170},{"slug":"quinoa_dry","g":70},{"slug":"spinach","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de quinoa (droog) volgens de verpakking.
2. Bak of pocheer de witvis (tilapia) kort tot net gaar; kruid met peper en zout.
3. Stoom of wok spinazie beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the quinoa (dry) per the package.
2. Sear or poach the white fish (tilapia) until just done; season with salt and pepper.
3. Steam or stir-fry the spinach until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('white_fish_with_quinoa_asparagus','Witvis met quinoa & asperges','White fish with quinoa & asparagus',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"white_fish","g":170},{"slug":"quinoa_dry","g":70},{"slug":"asparagus","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de quinoa (droog) volgens de verpakking.
2. Bak of pocheer de witvis (tilapia) kort tot net gaar; kruid met peper en zout.
3. Stoom of wok asperges beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the quinoa (dry) per the package.
2. Sear or poach the white fish (tilapia) until just done; season with salt and pepper.
3. Steam or stir-fry the asparagus until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('white_fish_with_quinoa_zucchini','Witvis met quinoa & courgette','White fish with quinoa & zucchini',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"white_fish","g":170},{"slug":"quinoa_dry","g":70},{"slug":"zucchini","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de quinoa (droog) volgens de verpakking.
2. Bak of pocheer de witvis (tilapia) kort tot net gaar; kruid met peper en zout.
3. Stoom of wok courgette beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the quinoa (dry) per the package.
2. Sear or poach the white fish (tilapia) until just done; season with salt and pepper.
3. Steam or stir-fry the zucchini until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('white_fish_with_quinoa_stir_fry_veg','Witvis met quinoa & wokgroente','White fish with quinoa & stir-fry veg',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"white_fish","g":170},{"slug":"quinoa_dry","g":70},{"slug":"mixed_veg","g":150},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de quinoa (droog) volgens de verpakking.
2. Bak of pocheer de witvis (tilapia) kort tot net gaar; kruid met peper en zout.
3. Stoom of wok wokgroente beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the quinoa (dry) per the package.
2. Sear or poach the white fish (tilapia) until just done; season with salt and pepper.
3. Steam or stir-fry the stir-fry veg until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('white_fish_with_quinoa_mushrooms','Witvis met quinoa & champignons','White fish with quinoa & mushrooms',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"white_fish","g":170},{"slug":"quinoa_dry","g":70},{"slug":"mushroom","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de quinoa (droog) volgens de verpakking.
2. Bak of pocheer de witvis (tilapia) kort tot net gaar; kruid met peper en zout.
3. Stoom of wok champignons beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the quinoa (dry) per the package.
2. Sear or poach the white fish (tilapia) until just done; season with salt and pepper.
3. Steam or stir-fry the mushrooms until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('white_fish_with_quinoa_carrot','Witvis met quinoa & wortel','White fish with quinoa & carrot',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"white_fish","g":170},{"slug":"quinoa_dry","g":70},{"slug":"carrot","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de quinoa (droog) volgens de verpakking.
2. Bak of pocheer de witvis (tilapia) kort tot net gaar; kruid met peper en zout.
3. Stoom of wok wortel beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the quinoa (dry) per the package.
2. Sear or poach the white fish (tilapia) until just done; season with salt and pepper.
3. Steam or stir-fry the carrot until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('white_fish_with_quinoa_peas','Witvis met quinoa & doperwten','White fish with quinoa & peas',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"white_fish","g":170},{"slug":"quinoa_dry","g":70},{"slug":"peas","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de quinoa (droog) volgens de verpakking.
2. Bak of pocheer de witvis (tilapia) kort tot net gaar; kruid met peper en zout.
3. Stoom of wok doperwten beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the quinoa (dry) per the package.
2. Sear or poach the white fish (tilapia) until just done; season with salt and pepper.
3. Steam or stir-fry the peas until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('white_fish_with_quinoa_cauliflower','Witvis met quinoa & bloemkool','White fish with quinoa & cauliflower',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"white_fish","g":170},{"slug":"quinoa_dry","g":70},{"slug":"cauliflower","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de quinoa (droog) volgens de verpakking.
2. Bak of pocheer de witvis (tilapia) kort tot net gaar; kruid met peper en zout.
3. Stoom of wok bloemkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the quinoa (dry) per the package.
2. Sear or poach the white fish (tilapia) until just done; season with salt and pepper.
3. Steam or stir-fry the cauliflower until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('white_fish_with_quinoa_kale','Witvis met quinoa & boerenkool','White fish with quinoa & kale',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"white_fish","g":170},{"slug":"quinoa_dry","g":70},{"slug":"kale","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de quinoa (droog) volgens de verpakking.
2. Bak of pocheer de witvis (tilapia) kort tot net gaar; kruid met peper en zout.
3. Stoom of wok boerenkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the quinoa (dry) per the package.
2. Sear or poach the white fish (tilapia) until just done; season with salt and pepper.
3. Steam or stir-fry the kale until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('white_fish_with_quinoa_bok_choy','Witvis met quinoa & paksoi','White fish with quinoa & bok choy',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"white_fish","g":170},{"slug":"quinoa_dry","g":70},{"slug":"bok_choy","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de quinoa (droog) volgens de verpakking.
2. Bak of pocheer de witvis (tilapia) kort tot net gaar; kruid met peper en zout.
3. Stoom of wok paksoi beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the quinoa (dry) per the package.
2. Sear or poach the white fish (tilapia) until just done; season with salt and pepper.
3. Steam or stir-fry the bok choy until tender-crisp.
4. Plate up and finish.','pan',null,'core')
on conflict (slug) do update set name_nl=excluded.name_nl,name_en=excluded.name_en,moments=excluded.moments,goals=excluded.goals,items=excluded.items,tags=excluded.tags,prefs=excluded.prefs,steps=excluded.steps,steps_en=excluded.steps_en,technique=excluded.technique,temp=excluded.temp;
commit;
