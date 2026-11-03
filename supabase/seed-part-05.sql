-- AUTO-GEGENEREERD core-seed deel 5/9 (200 gerechten). Draai NA dish-library.sql.
-- Draai de delen op volgorde (01, 02, ...). Elk deel is los veilig (upsert).
begin;
insert into public.dishes (slug,name_nl,name_en,moments,goals,items,tags,prefs,steps,steps_en,technique,temp,source) values
('shrimp_with_bulgur_peas','Garnalen met bulgur & doperwten','Shrimp with bulgur & peas',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"shrimp","g":150},{"slug":"bulgur_dry","g":70},{"slug":"peas","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de bulgur (droog) volgens de verpakking.
2. Bak of pocheer de garnalen kort tot net gaar; kruid met peper en zout.
3. Stoom of wok doperwten beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the bulgur (dry) per the package.
2. Sear or poach the shrimp until just done; season with salt and pepper.
3. Steam or stir-fry the peas until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('shrimp_with_bulgur_cauliflower','Garnalen met bulgur & bloemkool','Shrimp with bulgur & cauliflower',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"shrimp","g":150},{"slug":"bulgur_dry","g":70},{"slug":"cauliflower","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de bulgur (droog) volgens de verpakking.
2. Bak of pocheer de garnalen kort tot net gaar; kruid met peper en zout.
3. Stoom of wok bloemkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the bulgur (dry) per the package.
2. Sear or poach the shrimp until just done; season with salt and pepper.
3. Steam or stir-fry the cauliflower until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('shrimp_with_bulgur_kale','Garnalen met bulgur & boerenkool','Shrimp with bulgur & kale',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"shrimp","g":150},{"slug":"bulgur_dry","g":70},{"slug":"kale","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de bulgur (droog) volgens de verpakking.
2. Bak of pocheer de garnalen kort tot net gaar; kruid met peper en zout.
3. Stoom of wok boerenkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the bulgur (dry) per the package.
2. Sear or poach the shrimp until just done; season with salt and pepper.
3. Steam or stir-fry the kale until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('shrimp_with_bulgur_bok_choy','Garnalen met bulgur & paksoi','Shrimp with bulgur & bok choy',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"shrimp","g":150},{"slug":"bulgur_dry","g":70},{"slug":"bok_choy","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de bulgur (droog) volgens de verpakking.
2. Bak of pocheer de garnalen kort tot net gaar; kruid met peper en zout.
3. Stoom of wok paksoi beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the bulgur (dry) per the package.
2. Sear or poach the shrimp until just done; season with salt and pepper.
3. Steam or stir-fry the bok choy until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('shrimp_with_basmati_rice_broccoli','Garnalen met basmatirijst & broccoli','Shrimp with basmati rice & broccoli',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"shrimp","g":150},{"slug":"basmati_dry","g":70},{"slug":"broccoli","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de basmatirijst (droog) volgens de verpakking.
2. Bak of pocheer de garnalen kort tot net gaar; kruid met peper en zout.
3. Stoom of wok broccoli beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the basmati rice (dry) per the package.
2. Sear or poach the shrimp until just done; season with salt and pepper.
3. Steam or stir-fry the broccoli until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('shrimp_with_basmati_rice_green_beans','Garnalen met basmatirijst & sperziebonen','Shrimp with basmati rice & green beans',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"shrimp","g":150},{"slug":"basmati_dry","g":70},{"slug":"green_beans","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de basmatirijst (droog) volgens de verpakking.
2. Bak of pocheer de garnalen kort tot net gaar; kruid met peper en zout.
3. Stoom of wok sperziebonen beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the basmati rice (dry) per the package.
2. Sear or poach the shrimp until just done; season with salt and pepper.
3. Steam or stir-fry the green beans until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('shrimp_with_basmati_rice_spinach','Garnalen met basmatirijst & spinazie','Shrimp with basmati rice & spinach',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"shrimp","g":150},{"slug":"basmati_dry","g":70},{"slug":"spinach","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de basmatirijst (droog) volgens de verpakking.
2. Bak of pocheer de garnalen kort tot net gaar; kruid met peper en zout.
3. Stoom of wok spinazie beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the basmati rice (dry) per the package.
2. Sear or poach the shrimp until just done; season with salt and pepper.
3. Steam or stir-fry the spinach until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('shrimp_with_basmati_rice_asparagus','Garnalen met basmatirijst & asperges','Shrimp with basmati rice & asparagus',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"shrimp","g":150},{"slug":"basmati_dry","g":70},{"slug":"asparagus","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de basmatirijst (droog) volgens de verpakking.
2. Bak of pocheer de garnalen kort tot net gaar; kruid met peper en zout.
3. Stoom of wok asperges beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the basmati rice (dry) per the package.
2. Sear or poach the shrimp until just done; season with salt and pepper.
3. Steam or stir-fry the asparagus until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('shrimp_with_basmati_rice_zucchini','Garnalen met basmatirijst & courgette','Shrimp with basmati rice & zucchini',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"shrimp","g":150},{"slug":"basmati_dry","g":70},{"slug":"zucchini","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de basmatirijst (droog) volgens de verpakking.
2. Bak of pocheer de garnalen kort tot net gaar; kruid met peper en zout.
3. Stoom of wok courgette beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the basmati rice (dry) per the package.
2. Sear or poach the shrimp until just done; season with salt and pepper.
3. Steam or stir-fry the zucchini until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('shrimp_with_basmati_rice_stir_fry_veg','Garnalen met basmatirijst & wokgroente','Shrimp with basmati rice & stir-fry veg',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"shrimp","g":150},{"slug":"basmati_dry","g":70},{"slug":"mixed_veg","g":150},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de basmatirijst (droog) volgens de verpakking.
2. Bak of pocheer de garnalen kort tot net gaar; kruid met peper en zout.
3. Stoom of wok wokgroente beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the basmati rice (dry) per the package.
2. Sear or poach the shrimp until just done; season with salt and pepper.
3. Steam or stir-fry the stir-fry veg until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('shrimp_with_basmati_rice_mushrooms','Garnalen met basmatirijst & champignons','Shrimp with basmati rice & mushrooms',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"shrimp","g":150},{"slug":"basmati_dry","g":70},{"slug":"mushroom","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de basmatirijst (droog) volgens de verpakking.
2. Bak of pocheer de garnalen kort tot net gaar; kruid met peper en zout.
3. Stoom of wok champignons beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the basmati rice (dry) per the package.
2. Sear or poach the shrimp until just done; season with salt and pepper.
3. Steam or stir-fry the mushrooms until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('shrimp_with_basmati_rice_carrot','Garnalen met basmatirijst & wortel','Shrimp with basmati rice & carrot',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"shrimp","g":150},{"slug":"basmati_dry","g":70},{"slug":"carrot","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de basmatirijst (droog) volgens de verpakking.
2. Bak of pocheer de garnalen kort tot net gaar; kruid met peper en zout.
3. Stoom of wok wortel beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the basmati rice (dry) per the package.
2. Sear or poach the shrimp until just done; season with salt and pepper.
3. Steam or stir-fry the carrot until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('shrimp_with_basmati_rice_peas','Garnalen met basmatirijst & doperwten','Shrimp with basmati rice & peas',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"shrimp","g":150},{"slug":"basmati_dry","g":70},{"slug":"peas","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de basmatirijst (droog) volgens de verpakking.
2. Bak of pocheer de garnalen kort tot net gaar; kruid met peper en zout.
3. Stoom of wok doperwten beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the basmati rice (dry) per the package.
2. Sear or poach the shrimp until just done; season with salt and pepper.
3. Steam or stir-fry the peas until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('shrimp_with_basmati_rice_cauliflower','Garnalen met basmatirijst & bloemkool','Shrimp with basmati rice & cauliflower',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"shrimp","g":150},{"slug":"basmati_dry","g":70},{"slug":"cauliflower","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de basmatirijst (droog) volgens de verpakking.
2. Bak of pocheer de garnalen kort tot net gaar; kruid met peper en zout.
3. Stoom of wok bloemkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the basmati rice (dry) per the package.
2. Sear or poach the shrimp until just done; season with salt and pepper.
3. Steam or stir-fry the cauliflower until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('shrimp_with_basmati_rice_kale','Garnalen met basmatirijst & boerenkool','Shrimp with basmati rice & kale',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"shrimp","g":150},{"slug":"basmati_dry","g":70},{"slug":"kale","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de basmatirijst (droog) volgens de verpakking.
2. Bak of pocheer de garnalen kort tot net gaar; kruid met peper en zout.
3. Stoom of wok boerenkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the basmati rice (dry) per the package.
2. Sear or poach the shrimp until just done; season with salt and pepper.
3. Steam or stir-fry the kale until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('shrimp_with_basmati_rice_bok_choy','Garnalen met basmatirijst & paksoi','Shrimp with basmati rice & bok choy',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"shrimp","g":150},{"slug":"basmati_dry","g":70},{"slug":"bok_choy","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de basmatirijst (droog) volgens de verpakking.
2. Bak of pocheer de garnalen kort tot net gaar; kruid met peper en zout.
3. Stoom of wok paksoi beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the basmati rice (dry) per the package.
2. Sear or poach the shrimp until just done; season with salt and pepper.
3. Steam or stir-fry the bok choy until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tofu_with_rice_broccoli','Tofu met rijst & broccoli','Tofu with rice & broccoli',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"tofu","g":150},{"slug":"rice_dry","g":70},{"slug":"broccoli","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Kook de witte rijst (droog) volgens de verpakking.
2. Bak de tofu in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok broccoli beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the white rice (dry) per the package.
2. Pan-fry the tofu in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the broccoli until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tofu_with_rice_green_beans','Tofu met rijst & sperziebonen','Tofu with rice & green beans',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"tofu","g":150},{"slug":"rice_dry","g":70},{"slug":"green_beans","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Kook de witte rijst (droog) volgens de verpakking.
2. Bak de tofu in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok sperziebonen beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the white rice (dry) per the package.
2. Pan-fry the tofu in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the green beans until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tofu_with_rice_spinach','Tofu met rijst & spinazie','Tofu with rice & spinach',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"tofu","g":150},{"slug":"rice_dry","g":70},{"slug":"spinach","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Kook de witte rijst (droog) volgens de verpakking.
2. Bak de tofu in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok spinazie beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the white rice (dry) per the package.
2. Pan-fry the tofu in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the spinach until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tofu_with_rice_asparagus','Tofu met rijst & asperges','Tofu with rice & asparagus',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"tofu","g":150},{"slug":"rice_dry","g":70},{"slug":"asparagus","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Kook de witte rijst (droog) volgens de verpakking.
2. Bak de tofu in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok asperges beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the white rice (dry) per the package.
2. Pan-fry the tofu in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the asparagus until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tofu_with_rice_zucchini','Tofu met rijst & courgette','Tofu with rice & zucchini',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"tofu","g":150},{"slug":"rice_dry","g":70},{"slug":"zucchini","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Kook de witte rijst (droog) volgens de verpakking.
2. Bak de tofu in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok courgette beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the white rice (dry) per the package.
2. Pan-fry the tofu in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the zucchini until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tofu_with_rice_stir_fry_veg','Tofu met rijst & wokgroente','Tofu with rice & stir-fry veg',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"tofu","g":150},{"slug":"rice_dry","g":70},{"slug":"mixed_veg","g":150},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Kook de witte rijst (droog) volgens de verpakking.
2. Bak de tofu in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok wokgroente beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the white rice (dry) per the package.
2. Pan-fry the tofu in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the stir-fry veg until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tofu_with_rice_mushrooms','Tofu met rijst & champignons','Tofu with rice & mushrooms',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"tofu","g":150},{"slug":"rice_dry","g":70},{"slug":"mushroom","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Kook de witte rijst (droog) volgens de verpakking.
2. Bak de tofu in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok champignons beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the white rice (dry) per the package.
2. Pan-fry the tofu in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the mushrooms until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tofu_with_rice_carrot','Tofu met rijst & wortel','Tofu with rice & carrot',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"tofu","g":150},{"slug":"rice_dry","g":70},{"slug":"carrot","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Kook de witte rijst (droog) volgens de verpakking.
2. Bak de tofu in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok wortel beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the white rice (dry) per the package.
2. Pan-fry the tofu in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the carrot until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tofu_with_rice_peas','Tofu met rijst & doperwten','Tofu with rice & peas',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"tofu","g":150},{"slug":"rice_dry","g":70},{"slug":"peas","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Kook de witte rijst (droog) volgens de verpakking.
2. Bak de tofu in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok doperwten beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the white rice (dry) per the package.
2. Pan-fry the tofu in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the peas until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tofu_with_rice_cauliflower','Tofu met rijst & bloemkool','Tofu with rice & cauliflower',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"tofu","g":150},{"slug":"rice_dry","g":70},{"slug":"cauliflower","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Kook de witte rijst (droog) volgens de verpakking.
2. Bak de tofu in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok bloemkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the white rice (dry) per the package.
2. Pan-fry the tofu in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the cauliflower until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tofu_with_rice_kale','Tofu met rijst & boerenkool','Tofu with rice & kale',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"tofu","g":150},{"slug":"rice_dry","g":70},{"slug":"kale","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Kook de witte rijst (droog) volgens de verpakking.
2. Bak de tofu in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok boerenkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the white rice (dry) per the package.
2. Pan-fry the tofu in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the kale until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tofu_with_rice_bok_choy','Tofu met rijst & paksoi','Tofu with rice & bok choy',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"tofu","g":150},{"slug":"rice_dry","g":70},{"slug":"bok_choy","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Kook de witte rijst (droog) volgens de verpakking.
2. Bak de tofu in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok paksoi beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the white rice (dry) per the package.
2. Pan-fry the tofu in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the bok choy until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tofu_with_sweet_potato_broccoli','Tofu met zoete aardappel & broccoli','Tofu with sweet potato & broccoli',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"tofu","g":150},{"slug":"sweet_potato","g":200},{"slug":"broccoli","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY[]::text[],'1. Kook de zoete aardappel volgens de verpakking.
2. Bak de tofu in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok broccoli beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the sweet potato per the package.
2. Pan-fry the tofu in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the broccoli until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tofu_with_sweet_potato_green_beans','Tofu met zoete aardappel & sperziebonen','Tofu with sweet potato & green beans',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"tofu","g":150},{"slug":"sweet_potato","g":200},{"slug":"green_beans","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY[]::text[],'1. Kook de zoete aardappel volgens de verpakking.
2. Bak de tofu in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok sperziebonen beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the sweet potato per the package.
2. Pan-fry the tofu in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the green beans until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tofu_with_sweet_potato_spinach','Tofu met zoete aardappel & spinazie','Tofu with sweet potato & spinach',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"tofu","g":150},{"slug":"sweet_potato","g":200},{"slug":"spinach","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY[]::text[],'1. Kook de zoete aardappel volgens de verpakking.
2. Bak de tofu in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok spinazie beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the sweet potato per the package.
2. Pan-fry the tofu in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the spinach until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tofu_with_sweet_potato_asparagus','Tofu met zoete aardappel & asperges','Tofu with sweet potato & asparagus',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"tofu","g":150},{"slug":"sweet_potato","g":200},{"slug":"asparagus","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY[]::text[],'1. Kook de zoete aardappel volgens de verpakking.
2. Bak de tofu in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok asperges beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the sweet potato per the package.
2. Pan-fry the tofu in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the asparagus until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tofu_with_sweet_potato_zucchini','Tofu met zoete aardappel & courgette','Tofu with sweet potato & zucchini',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"tofu","g":150},{"slug":"sweet_potato","g":200},{"slug":"zucchini","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY[]::text[],'1. Kook de zoete aardappel volgens de verpakking.
2. Bak de tofu in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok courgette beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the sweet potato per the package.
2. Pan-fry the tofu in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the zucchini until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tofu_with_sweet_potato_stir_fry_veg','Tofu met zoete aardappel & wokgroente','Tofu with sweet potato & stir-fry veg',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"tofu","g":150},{"slug":"sweet_potato","g":200},{"slug":"mixed_veg","g":150},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY[]::text[],'1. Kook de zoete aardappel volgens de verpakking.
2. Bak de tofu in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok wokgroente beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the sweet potato per the package.
2. Pan-fry the tofu in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the stir-fry veg until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tofu_with_sweet_potato_mushrooms','Tofu met zoete aardappel & champignons','Tofu with sweet potato & mushrooms',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"tofu","g":150},{"slug":"sweet_potato","g":200},{"slug":"mushroom","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY[]::text[],'1. Kook de zoete aardappel volgens de verpakking.
2. Bak de tofu in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok champignons beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the sweet potato per the package.
2. Pan-fry the tofu in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the mushrooms until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tofu_with_sweet_potato_carrot','Tofu met zoete aardappel & wortel','Tofu with sweet potato & carrot',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"tofu","g":150},{"slug":"sweet_potato","g":200},{"slug":"carrot","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY[]::text[],'1. Kook de zoete aardappel volgens de verpakking.
2. Bak de tofu in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok wortel beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the sweet potato per the package.
2. Pan-fry the tofu in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the carrot until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tofu_with_sweet_potato_peas','Tofu met zoete aardappel & doperwten','Tofu with sweet potato & peas',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"tofu","g":150},{"slug":"sweet_potato","g":200},{"slug":"peas","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY[]::text[],'1. Kook de zoete aardappel volgens de verpakking.
2. Bak de tofu in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok doperwten beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the sweet potato per the package.
2. Pan-fry the tofu in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the peas until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tofu_with_sweet_potato_cauliflower','Tofu met zoete aardappel & bloemkool','Tofu with sweet potato & cauliflower',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"tofu","g":150},{"slug":"sweet_potato","g":200},{"slug":"cauliflower","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY[]::text[],'1. Kook de zoete aardappel volgens de verpakking.
2. Bak de tofu in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok bloemkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the sweet potato per the package.
2. Pan-fry the tofu in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the cauliflower until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tofu_with_sweet_potato_kale','Tofu met zoete aardappel & boerenkool','Tofu with sweet potato & kale',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"tofu","g":150},{"slug":"sweet_potato","g":200},{"slug":"kale","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY[]::text[],'1. Kook de zoete aardappel volgens de verpakking.
2. Bak de tofu in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok boerenkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the sweet potato per the package.
2. Pan-fry the tofu in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the kale until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tofu_with_sweet_potato_bok_choy','Tofu met zoete aardappel & paksoi','Tofu with sweet potato & bok choy',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"tofu","g":150},{"slug":"sweet_potato","g":200},{"slug":"bok_choy","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY[]::text[],'1. Kook de zoete aardappel volgens de verpakking.
2. Bak de tofu in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok paksoi beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the sweet potato per the package.
2. Pan-fry the tofu in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the bok choy until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tofu_with_potato_broccoli','Tofu met aardappel & broccoli','Tofu with potato & broccoli',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"tofu","g":150},{"slug":"potato","g":250},{"slug":"broccoli","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY['steakpotato']::text[],'1. Kook de aardappel volgens de verpakking.
2. Bak de tofu in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok broccoli beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the potato per the package.
2. Pan-fry the tofu in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the broccoli until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tofu_with_potato_green_beans','Tofu met aardappel & sperziebonen','Tofu with potato & green beans',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"tofu","g":150},{"slug":"potato","g":250},{"slug":"green_beans","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY['steakpotato']::text[],'1. Kook de aardappel volgens de verpakking.
2. Bak de tofu in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok sperziebonen beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the potato per the package.
2. Pan-fry the tofu in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the green beans until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tofu_with_potato_spinach','Tofu met aardappel & spinazie','Tofu with potato & spinach',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"tofu","g":150},{"slug":"potato","g":250},{"slug":"spinach","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY['steakpotato']::text[],'1. Kook de aardappel volgens de verpakking.
2. Bak de tofu in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok spinazie beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the potato per the package.
2. Pan-fry the tofu in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the spinach until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tofu_with_potato_asparagus','Tofu met aardappel & asperges','Tofu with potato & asparagus',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"tofu","g":150},{"slug":"potato","g":250},{"slug":"asparagus","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY['steakpotato']::text[],'1. Kook de aardappel volgens de verpakking.
2. Bak de tofu in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok asperges beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the potato per the package.
2. Pan-fry the tofu in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the asparagus until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tofu_with_potato_zucchini','Tofu met aardappel & courgette','Tofu with potato & zucchini',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"tofu","g":150},{"slug":"potato","g":250},{"slug":"zucchini","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY['steakpotato']::text[],'1. Kook de aardappel volgens de verpakking.
2. Bak de tofu in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok courgette beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the potato per the package.
2. Pan-fry the tofu in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the zucchini until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tofu_with_potato_stir_fry_veg','Tofu met aardappel & wokgroente','Tofu with potato & stir-fry veg',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"tofu","g":150},{"slug":"potato","g":250},{"slug":"mixed_veg","g":150},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY['steakpotato']::text[],'1. Kook de aardappel volgens de verpakking.
2. Bak de tofu in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok wokgroente beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the potato per the package.
2. Pan-fry the tofu in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the stir-fry veg until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tofu_with_potato_mushrooms','Tofu met aardappel & champignons','Tofu with potato & mushrooms',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"tofu","g":150},{"slug":"potato","g":250},{"slug":"mushroom","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY['steakpotato']::text[],'1. Kook de aardappel volgens de verpakking.
2. Bak de tofu in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok champignons beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the potato per the package.
2. Pan-fry the tofu in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the mushrooms until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tofu_with_potato_carrot','Tofu met aardappel & wortel','Tofu with potato & carrot',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"tofu","g":150},{"slug":"potato","g":250},{"slug":"carrot","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY['steakpotato']::text[],'1. Kook de aardappel volgens de verpakking.
2. Bak de tofu in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok wortel beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the potato per the package.
2. Pan-fry the tofu in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the carrot until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tofu_with_potato_peas','Tofu met aardappel & doperwten','Tofu with potato & peas',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"tofu","g":150},{"slug":"potato","g":250},{"slug":"peas","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY['steakpotato']::text[],'1. Kook de aardappel volgens de verpakking.
2. Bak de tofu in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok doperwten beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the potato per the package.
2. Pan-fry the tofu in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the peas until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tofu_with_potato_cauliflower','Tofu met aardappel & bloemkool','Tofu with potato & cauliflower',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"tofu","g":150},{"slug":"potato","g":250},{"slug":"cauliflower","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY['steakpotato']::text[],'1. Kook de aardappel volgens de verpakking.
2. Bak de tofu in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok bloemkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the potato per the package.
2. Pan-fry the tofu in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the cauliflower until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tofu_with_potato_kale','Tofu met aardappel & boerenkool','Tofu with potato & kale',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"tofu","g":150},{"slug":"potato","g":250},{"slug":"kale","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY['steakpotato']::text[],'1. Kook de aardappel volgens de verpakking.
2. Bak de tofu in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok boerenkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the potato per the package.
2. Pan-fry the tofu in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the kale until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tofu_with_potato_bok_choy','Tofu met aardappel & paksoi','Tofu with potato & bok choy',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"tofu","g":150},{"slug":"potato","g":250},{"slug":"bok_choy","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY['steakpotato']::text[],'1. Kook de aardappel volgens de verpakking.
2. Bak de tofu in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok paksoi beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the potato per the package.
2. Pan-fry the tofu in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the bok choy until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tofu_with_pasta_broccoli','Tofu met pasta & broccoli','Tofu with pasta & broccoli',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"tofu","g":150},{"slug":"pasta_dry","g":80},{"slug":"broccoli","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY['pastabol']::text[],'1. Kook de volkoren pasta (droog) volgens de verpakking.
2. Bak de tofu in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok broccoli beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat pasta (dry) per the package.
2. Pan-fry the tofu in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the broccoli until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tofu_with_pasta_green_beans','Tofu met pasta & sperziebonen','Tofu with pasta & green beans',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"tofu","g":150},{"slug":"pasta_dry","g":80},{"slug":"green_beans","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY['pastabol']::text[],'1. Kook de volkoren pasta (droog) volgens de verpakking.
2. Bak de tofu in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok sperziebonen beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat pasta (dry) per the package.
2. Pan-fry the tofu in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the green beans until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tofu_with_pasta_spinach','Tofu met pasta & spinazie','Tofu with pasta & spinach',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"tofu","g":150},{"slug":"pasta_dry","g":80},{"slug":"spinach","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY['pastabol']::text[],'1. Kook de volkoren pasta (droog) volgens de verpakking.
2. Bak de tofu in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok spinazie beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat pasta (dry) per the package.
2. Pan-fry the tofu in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the spinach until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tofu_with_pasta_asparagus','Tofu met pasta & asperges','Tofu with pasta & asparagus',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"tofu","g":150},{"slug":"pasta_dry","g":80},{"slug":"asparagus","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY['pastabol']::text[],'1. Kook de volkoren pasta (droog) volgens de verpakking.
2. Bak de tofu in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok asperges beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat pasta (dry) per the package.
2. Pan-fry the tofu in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the asparagus until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tofu_with_pasta_zucchini','Tofu met pasta & courgette','Tofu with pasta & zucchini',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"tofu","g":150},{"slug":"pasta_dry","g":80},{"slug":"zucchini","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY['pastabol']::text[],'1. Kook de volkoren pasta (droog) volgens de verpakking.
2. Bak de tofu in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok courgette beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat pasta (dry) per the package.
2. Pan-fry the tofu in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the zucchini until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tofu_with_pasta_stir_fry_veg','Tofu met pasta & wokgroente','Tofu with pasta & stir-fry veg',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"tofu","g":150},{"slug":"pasta_dry","g":80},{"slug":"mixed_veg","g":150},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY['pastabol']::text[],'1. Kook de volkoren pasta (droog) volgens de verpakking.
2. Bak de tofu in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok wokgroente beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat pasta (dry) per the package.
2. Pan-fry the tofu in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the stir-fry veg until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tofu_with_pasta_mushrooms','Tofu met pasta & champignons','Tofu with pasta & mushrooms',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"tofu","g":150},{"slug":"pasta_dry","g":80},{"slug":"mushroom","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY['pastabol']::text[],'1. Kook de volkoren pasta (droog) volgens de verpakking.
2. Bak de tofu in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok champignons beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat pasta (dry) per the package.
2. Pan-fry the tofu in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the mushrooms until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tofu_with_pasta_carrot','Tofu met pasta & wortel','Tofu with pasta & carrot',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"tofu","g":150},{"slug":"pasta_dry","g":80},{"slug":"carrot","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY['pastabol']::text[],'1. Kook de volkoren pasta (droog) volgens de verpakking.
2. Bak de tofu in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok wortel beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat pasta (dry) per the package.
2. Pan-fry the tofu in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the carrot until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tofu_with_pasta_peas','Tofu met pasta & doperwten','Tofu with pasta & peas',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"tofu","g":150},{"slug":"pasta_dry","g":80},{"slug":"peas","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY['pastabol']::text[],'1. Kook de volkoren pasta (droog) volgens de verpakking.
2. Bak de tofu in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok doperwten beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat pasta (dry) per the package.
2. Pan-fry the tofu in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the peas until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tofu_with_pasta_cauliflower','Tofu met pasta & bloemkool','Tofu with pasta & cauliflower',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"tofu","g":150},{"slug":"pasta_dry","g":80},{"slug":"cauliflower","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY['pastabol']::text[],'1. Kook de volkoren pasta (droog) volgens de verpakking.
2. Bak de tofu in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok bloemkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat pasta (dry) per the package.
2. Pan-fry the tofu in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the cauliflower until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tofu_with_pasta_kale','Tofu met pasta & boerenkool','Tofu with pasta & kale',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"tofu","g":150},{"slug":"pasta_dry","g":80},{"slug":"kale","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY['pastabol']::text[],'1. Kook de volkoren pasta (droog) volgens de verpakking.
2. Bak de tofu in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok boerenkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat pasta (dry) per the package.
2. Pan-fry the tofu in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the kale until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tofu_with_pasta_bok_choy','Tofu met pasta & paksoi','Tofu with pasta & bok choy',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"tofu","g":150},{"slug":"pasta_dry","g":80},{"slug":"bok_choy","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY['pastabol']::text[],'1. Kook de volkoren pasta (droog) volgens de verpakking.
2. Bak de tofu in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok paksoi beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat pasta (dry) per the package.
2. Pan-fry the tofu in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the bok choy until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tofu_with_quinoa_broccoli','Tofu met quinoa & broccoli','Tofu with quinoa & broccoli',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"tofu","g":150},{"slug":"quinoa_dry","g":70},{"slug":"broccoli","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY[]::text[],'1. Kook de quinoa (droog) volgens de verpakking.
2. Bak de tofu in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok broccoli beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the quinoa (dry) per the package.
2. Pan-fry the tofu in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the broccoli until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tofu_with_quinoa_green_beans','Tofu met quinoa & sperziebonen','Tofu with quinoa & green beans',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"tofu","g":150},{"slug":"quinoa_dry","g":70},{"slug":"green_beans","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY[]::text[],'1. Kook de quinoa (droog) volgens de verpakking.
2. Bak de tofu in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok sperziebonen beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the quinoa (dry) per the package.
2. Pan-fry the tofu in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the green beans until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tofu_with_quinoa_spinach','Tofu met quinoa & spinazie','Tofu with quinoa & spinach',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"tofu","g":150},{"slug":"quinoa_dry","g":70},{"slug":"spinach","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY[]::text[],'1. Kook de quinoa (droog) volgens de verpakking.
2. Bak de tofu in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok spinazie beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the quinoa (dry) per the package.
2. Pan-fry the tofu in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the spinach until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tofu_with_quinoa_asparagus','Tofu met quinoa & asperges','Tofu with quinoa & asparagus',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"tofu","g":150},{"slug":"quinoa_dry","g":70},{"slug":"asparagus","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY[]::text[],'1. Kook de quinoa (droog) volgens de verpakking.
2. Bak de tofu in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok asperges beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the quinoa (dry) per the package.
2. Pan-fry the tofu in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the asparagus until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tofu_with_quinoa_zucchini','Tofu met quinoa & courgette','Tofu with quinoa & zucchini',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"tofu","g":150},{"slug":"quinoa_dry","g":70},{"slug":"zucchini","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY[]::text[],'1. Kook de quinoa (droog) volgens de verpakking.
2. Bak de tofu in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok courgette beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the quinoa (dry) per the package.
2. Pan-fry the tofu in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the zucchini until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tofu_with_quinoa_stir_fry_veg','Tofu met quinoa & wokgroente','Tofu with quinoa & stir-fry veg',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"tofu","g":150},{"slug":"quinoa_dry","g":70},{"slug":"mixed_veg","g":150},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY[]::text[],'1. Kook de quinoa (droog) volgens de verpakking.
2. Bak de tofu in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok wokgroente beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the quinoa (dry) per the package.
2. Pan-fry the tofu in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the stir-fry veg until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tofu_with_quinoa_mushrooms','Tofu met quinoa & champignons','Tofu with quinoa & mushrooms',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"tofu","g":150},{"slug":"quinoa_dry","g":70},{"slug":"mushroom","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY[]::text[],'1. Kook de quinoa (droog) volgens de verpakking.
2. Bak de tofu in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok champignons beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the quinoa (dry) per the package.
2. Pan-fry the tofu in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the mushrooms until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tofu_with_quinoa_carrot','Tofu met quinoa & wortel','Tofu with quinoa & carrot',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"tofu","g":150},{"slug":"quinoa_dry","g":70},{"slug":"carrot","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY[]::text[],'1. Kook de quinoa (droog) volgens de verpakking.
2. Bak de tofu in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok wortel beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the quinoa (dry) per the package.
2. Pan-fry the tofu in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the carrot until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tofu_with_quinoa_peas','Tofu met quinoa & doperwten','Tofu with quinoa & peas',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"tofu","g":150},{"slug":"quinoa_dry","g":70},{"slug":"peas","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY[]::text[],'1. Kook de quinoa (droog) volgens de verpakking.
2. Bak de tofu in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok doperwten beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the quinoa (dry) per the package.
2. Pan-fry the tofu in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the peas until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tofu_with_quinoa_cauliflower','Tofu met quinoa & bloemkool','Tofu with quinoa & cauliflower',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"tofu","g":150},{"slug":"quinoa_dry","g":70},{"slug":"cauliflower","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY[]::text[],'1. Kook de quinoa (droog) volgens de verpakking.
2. Bak de tofu in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok bloemkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the quinoa (dry) per the package.
2. Pan-fry the tofu in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the cauliflower until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tofu_with_quinoa_kale','Tofu met quinoa & boerenkool','Tofu with quinoa & kale',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"tofu","g":150},{"slug":"quinoa_dry","g":70},{"slug":"kale","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY[]::text[],'1. Kook de quinoa (droog) volgens de verpakking.
2. Bak de tofu in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok boerenkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the quinoa (dry) per the package.
2. Pan-fry the tofu in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the kale until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tofu_with_quinoa_bok_choy','Tofu met quinoa & paksoi','Tofu with quinoa & bok choy',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"tofu","g":150},{"slug":"quinoa_dry","g":70},{"slug":"bok_choy","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY[]::text[],'1. Kook de quinoa (droog) volgens de verpakking.
2. Bak de tofu in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok paksoi beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the quinoa (dry) per the package.
2. Pan-fry the tofu in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the bok choy until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tofu_with_noodles_broccoli','Tofu met noedels & broccoli','Tofu with noodles & broccoli',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"tofu","g":150},{"slug":"noodles_dry","g":80},{"slug":"broccoli","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY['woknoodles']::text[],'1. Kook de volkoren noedels (droog) volgens de verpakking.
2. Bak de tofu in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok broccoli beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat noodles (dry) per the package.
2. Pan-fry the tofu in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the broccoli until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tofu_with_noodles_green_beans','Tofu met noedels & sperziebonen','Tofu with noodles & green beans',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"tofu","g":150},{"slug":"noodles_dry","g":80},{"slug":"green_beans","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY['woknoodles']::text[],'1. Kook de volkoren noedels (droog) volgens de verpakking.
2. Bak de tofu in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok sperziebonen beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat noodles (dry) per the package.
2. Pan-fry the tofu in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the green beans until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tofu_with_noodles_spinach','Tofu met noedels & spinazie','Tofu with noodles & spinach',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"tofu","g":150},{"slug":"noodles_dry","g":80},{"slug":"spinach","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY['woknoodles']::text[],'1. Kook de volkoren noedels (droog) volgens de verpakking.
2. Bak de tofu in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok spinazie beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat noodles (dry) per the package.
2. Pan-fry the tofu in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the spinach until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tofu_with_noodles_asparagus','Tofu met noedels & asperges','Tofu with noodles & asparagus',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"tofu","g":150},{"slug":"noodles_dry","g":80},{"slug":"asparagus","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY['woknoodles']::text[],'1. Kook de volkoren noedels (droog) volgens de verpakking.
2. Bak de tofu in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok asperges beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat noodles (dry) per the package.
2. Pan-fry the tofu in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the asparagus until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tofu_with_noodles_zucchini','Tofu met noedels & courgette','Tofu with noodles & zucchini',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"tofu","g":150},{"slug":"noodles_dry","g":80},{"slug":"zucchini","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY['woknoodles']::text[],'1. Kook de volkoren noedels (droog) volgens de verpakking.
2. Bak de tofu in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok courgette beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat noodles (dry) per the package.
2. Pan-fry the tofu in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the zucchini until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tofu_with_noodles_stir_fry_veg','Tofu met noedels & wokgroente','Tofu with noodles & stir-fry veg',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"tofu","g":150},{"slug":"noodles_dry","g":80},{"slug":"mixed_veg","g":150},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY['woknoodles']::text[],'1. Kook de volkoren noedels (droog) volgens de verpakking.
2. Bak de tofu in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok wokgroente beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat noodles (dry) per the package.
2. Pan-fry the tofu in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the stir-fry veg until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tofu_with_noodles_mushrooms','Tofu met noedels & champignons','Tofu with noodles & mushrooms',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"tofu","g":150},{"slug":"noodles_dry","g":80},{"slug":"mushroom","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY['woknoodles']::text[],'1. Kook de volkoren noedels (droog) volgens de verpakking.
2. Bak de tofu in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok champignons beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat noodles (dry) per the package.
2. Pan-fry the tofu in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the mushrooms until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tofu_with_noodles_carrot','Tofu met noedels & wortel','Tofu with noodles & carrot',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"tofu","g":150},{"slug":"noodles_dry","g":80},{"slug":"carrot","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY['woknoodles']::text[],'1. Kook de volkoren noedels (droog) volgens de verpakking.
2. Bak de tofu in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok wortel beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat noodles (dry) per the package.
2. Pan-fry the tofu in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the carrot until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tofu_with_noodles_peas','Tofu met noedels & doperwten','Tofu with noodles & peas',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"tofu","g":150},{"slug":"noodles_dry","g":80},{"slug":"peas","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY['woknoodles']::text[],'1. Kook de volkoren noedels (droog) volgens de verpakking.
2. Bak de tofu in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok doperwten beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat noodles (dry) per the package.
2. Pan-fry the tofu in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the peas until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tofu_with_noodles_cauliflower','Tofu met noedels & bloemkool','Tofu with noodles & cauliflower',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"tofu","g":150},{"slug":"noodles_dry","g":80},{"slug":"cauliflower","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY['woknoodles']::text[],'1. Kook de volkoren noedels (droog) volgens de verpakking.
2. Bak de tofu in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok bloemkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat noodles (dry) per the package.
2. Pan-fry the tofu in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the cauliflower until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tofu_with_noodles_kale','Tofu met noedels & boerenkool','Tofu with noodles & kale',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"tofu","g":150},{"slug":"noodles_dry","g":80},{"slug":"kale","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY['woknoodles']::text[],'1. Kook de volkoren noedels (droog) volgens de verpakking.
2. Bak de tofu in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok boerenkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat noodles (dry) per the package.
2. Pan-fry the tofu in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the kale until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tofu_with_noodles_bok_choy','Tofu met noedels & paksoi','Tofu with noodles & bok choy',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"tofu","g":150},{"slug":"noodles_dry","g":80},{"slug":"bok_choy","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY['woknoodles']::text[],'1. Kook de volkoren noedels (droog) volgens de verpakking.
2. Bak de tofu in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok paksoi beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat noodles (dry) per the package.
2. Pan-fry the tofu in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the bok choy until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tofu_with_couscous_broccoli','Tofu met couscous & broccoli','Tofu with couscous & broccoli',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"tofu","g":150},{"slug":"couscous_dry","g":70},{"slug":"broccoli","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY[]::text[],'1. Kook de volkoren couscous (droog) volgens de verpakking.
2. Bak de tofu in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok broccoli beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat couscous (dry) per the package.
2. Pan-fry the tofu in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the broccoli until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tofu_with_couscous_green_beans','Tofu met couscous & sperziebonen','Tofu with couscous & green beans',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"tofu","g":150},{"slug":"couscous_dry","g":70},{"slug":"green_beans","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY[]::text[],'1. Kook de volkoren couscous (droog) volgens de verpakking.
2. Bak de tofu in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok sperziebonen beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat couscous (dry) per the package.
2. Pan-fry the tofu in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the green beans until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tofu_with_couscous_spinach','Tofu met couscous & spinazie','Tofu with couscous & spinach',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"tofu","g":150},{"slug":"couscous_dry","g":70},{"slug":"spinach","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY[]::text[],'1. Kook de volkoren couscous (droog) volgens de verpakking.
2. Bak de tofu in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok spinazie beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat couscous (dry) per the package.
2. Pan-fry the tofu in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the spinach until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tofu_with_couscous_asparagus','Tofu met couscous & asperges','Tofu with couscous & asparagus',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"tofu","g":150},{"slug":"couscous_dry","g":70},{"slug":"asparagus","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY[]::text[],'1. Kook de volkoren couscous (droog) volgens de verpakking.
2. Bak de tofu in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok asperges beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat couscous (dry) per the package.
2. Pan-fry the tofu in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the asparagus until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tofu_with_couscous_zucchini','Tofu met couscous & courgette','Tofu with couscous & zucchini',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"tofu","g":150},{"slug":"couscous_dry","g":70},{"slug":"zucchini","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY[]::text[],'1. Kook de volkoren couscous (droog) volgens de verpakking.
2. Bak de tofu in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok courgette beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat couscous (dry) per the package.
2. Pan-fry the tofu in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the zucchini until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tofu_with_couscous_stir_fry_veg','Tofu met couscous & wokgroente','Tofu with couscous & stir-fry veg',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"tofu","g":150},{"slug":"couscous_dry","g":70},{"slug":"mixed_veg","g":150},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY[]::text[],'1. Kook de volkoren couscous (droog) volgens de verpakking.
2. Bak de tofu in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok wokgroente beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat couscous (dry) per the package.
2. Pan-fry the tofu in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the stir-fry veg until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tofu_with_couscous_mushrooms','Tofu met couscous & champignons','Tofu with couscous & mushrooms',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"tofu","g":150},{"slug":"couscous_dry","g":70},{"slug":"mushroom","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY[]::text[],'1. Kook de volkoren couscous (droog) volgens de verpakking.
2. Bak de tofu in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok champignons beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat couscous (dry) per the package.
2. Pan-fry the tofu in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the mushrooms until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tofu_with_couscous_carrot','Tofu met couscous & wortel','Tofu with couscous & carrot',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"tofu","g":150},{"slug":"couscous_dry","g":70},{"slug":"carrot","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY[]::text[],'1. Kook de volkoren couscous (droog) volgens de verpakking.
2. Bak de tofu in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok wortel beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat couscous (dry) per the package.
2. Pan-fry the tofu in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the carrot until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tofu_with_couscous_peas','Tofu met couscous & doperwten','Tofu with couscous & peas',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"tofu","g":150},{"slug":"couscous_dry","g":70},{"slug":"peas","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY[]::text[],'1. Kook de volkoren couscous (droog) volgens de verpakking.
2. Bak de tofu in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok doperwten beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat couscous (dry) per the package.
2. Pan-fry the tofu in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the peas until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tofu_with_couscous_cauliflower','Tofu met couscous & bloemkool','Tofu with couscous & cauliflower',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"tofu","g":150},{"slug":"couscous_dry","g":70},{"slug":"cauliflower","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY[]::text[],'1. Kook de volkoren couscous (droog) volgens de verpakking.
2. Bak de tofu in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok bloemkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat couscous (dry) per the package.
2. Pan-fry the tofu in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the cauliflower until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tofu_with_couscous_kale','Tofu met couscous & boerenkool','Tofu with couscous & kale',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"tofu","g":150},{"slug":"couscous_dry","g":70},{"slug":"kale","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY[]::text[],'1. Kook de volkoren couscous (droog) volgens de verpakking.
2. Bak de tofu in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok boerenkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat couscous (dry) per the package.
2. Pan-fry the tofu in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the kale until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tofu_with_couscous_bok_choy','Tofu met couscous & paksoi','Tofu with couscous & bok choy',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"tofu","g":150},{"slug":"couscous_dry","g":70},{"slug":"bok_choy","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY[]::text[],'1. Kook de volkoren couscous (droog) volgens de verpakking.
2. Bak de tofu in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok paksoi beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat couscous (dry) per the package.
2. Pan-fry the tofu in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the bok choy until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tofu_with_bulgur_broccoli','Tofu met bulgur & broccoli','Tofu with bulgur & broccoli',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"tofu","g":150},{"slug":"bulgur_dry","g":70},{"slug":"broccoli","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY[]::text[],'1. Kook de bulgur (droog) volgens de verpakking.
2. Bak de tofu in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok broccoli beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the bulgur (dry) per the package.
2. Pan-fry the tofu in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the broccoli until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tofu_with_bulgur_green_beans','Tofu met bulgur & sperziebonen','Tofu with bulgur & green beans',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"tofu","g":150},{"slug":"bulgur_dry","g":70},{"slug":"green_beans","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY[]::text[],'1. Kook de bulgur (droog) volgens de verpakking.
2. Bak de tofu in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok sperziebonen beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the bulgur (dry) per the package.
2. Pan-fry the tofu in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the green beans until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tofu_with_bulgur_spinach','Tofu met bulgur & spinazie','Tofu with bulgur & spinach',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"tofu","g":150},{"slug":"bulgur_dry","g":70},{"slug":"spinach","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY[]::text[],'1. Kook de bulgur (droog) volgens de verpakking.
2. Bak de tofu in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok spinazie beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the bulgur (dry) per the package.
2. Pan-fry the tofu in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the spinach until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tofu_with_bulgur_asparagus','Tofu met bulgur & asperges','Tofu with bulgur & asparagus',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"tofu","g":150},{"slug":"bulgur_dry","g":70},{"slug":"asparagus","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY[]::text[],'1. Kook de bulgur (droog) volgens de verpakking.
2. Bak de tofu in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok asperges beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the bulgur (dry) per the package.
2. Pan-fry the tofu in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the asparagus until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tofu_with_bulgur_zucchini','Tofu met bulgur & courgette','Tofu with bulgur & zucchini',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"tofu","g":150},{"slug":"bulgur_dry","g":70},{"slug":"zucchini","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY[]::text[],'1. Kook de bulgur (droog) volgens de verpakking.
2. Bak de tofu in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok courgette beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the bulgur (dry) per the package.
2. Pan-fry the tofu in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the zucchini until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tofu_with_bulgur_stir_fry_veg','Tofu met bulgur & wokgroente','Tofu with bulgur & stir-fry veg',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"tofu","g":150},{"slug":"bulgur_dry","g":70},{"slug":"mixed_veg","g":150},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY[]::text[],'1. Kook de bulgur (droog) volgens de verpakking.
2. Bak de tofu in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok wokgroente beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the bulgur (dry) per the package.
2. Pan-fry the tofu in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the stir-fry veg until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tofu_with_bulgur_mushrooms','Tofu met bulgur & champignons','Tofu with bulgur & mushrooms',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"tofu","g":150},{"slug":"bulgur_dry","g":70},{"slug":"mushroom","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY[]::text[],'1. Kook de bulgur (droog) volgens de verpakking.
2. Bak de tofu in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok champignons beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the bulgur (dry) per the package.
2. Pan-fry the tofu in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the mushrooms until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tofu_with_bulgur_carrot','Tofu met bulgur & wortel','Tofu with bulgur & carrot',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"tofu","g":150},{"slug":"bulgur_dry","g":70},{"slug":"carrot","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY[]::text[],'1. Kook de bulgur (droog) volgens de verpakking.
2. Bak de tofu in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok wortel beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the bulgur (dry) per the package.
2. Pan-fry the tofu in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the carrot until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tofu_with_bulgur_peas','Tofu met bulgur & doperwten','Tofu with bulgur & peas',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"tofu","g":150},{"slug":"bulgur_dry","g":70},{"slug":"peas","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY[]::text[],'1. Kook de bulgur (droog) volgens de verpakking.
2. Bak de tofu in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok doperwten beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the bulgur (dry) per the package.
2. Pan-fry the tofu in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the peas until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tofu_with_bulgur_cauliflower','Tofu met bulgur & bloemkool','Tofu with bulgur & cauliflower',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"tofu","g":150},{"slug":"bulgur_dry","g":70},{"slug":"cauliflower","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY[]::text[],'1. Kook de bulgur (droog) volgens de verpakking.
2. Bak de tofu in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok bloemkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the bulgur (dry) per the package.
2. Pan-fry the tofu in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the cauliflower until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tofu_with_bulgur_kale','Tofu met bulgur & boerenkool','Tofu with bulgur & kale',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"tofu","g":150},{"slug":"bulgur_dry","g":70},{"slug":"kale","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY[]::text[],'1. Kook de bulgur (droog) volgens de verpakking.
2. Bak de tofu in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok boerenkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the bulgur (dry) per the package.
2. Pan-fry the tofu in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the kale until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tofu_with_bulgur_bok_choy','Tofu met bulgur & paksoi','Tofu with bulgur & bok choy',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"tofu","g":150},{"slug":"bulgur_dry","g":70},{"slug":"bok_choy","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY[]::text[],'1. Kook de bulgur (droog) volgens de verpakking.
2. Bak de tofu in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok paksoi beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the bulgur (dry) per the package.
2. Pan-fry the tofu in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the bok choy until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tofu_with_basmati_rice_broccoli','Tofu met basmatirijst & broccoli','Tofu with basmati rice & broccoli',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"tofu","g":150},{"slug":"basmati_dry","g":70},{"slug":"broccoli","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY[]::text[],'1. Kook de basmatirijst (droog) volgens de verpakking.
2. Bak de tofu in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok broccoli beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the basmati rice (dry) per the package.
2. Pan-fry the tofu in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the broccoli until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tofu_with_basmati_rice_green_beans','Tofu met basmatirijst & sperziebonen','Tofu with basmati rice & green beans',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"tofu","g":150},{"slug":"basmati_dry","g":70},{"slug":"green_beans","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY[]::text[],'1. Kook de basmatirijst (droog) volgens de verpakking.
2. Bak de tofu in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok sperziebonen beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the basmati rice (dry) per the package.
2. Pan-fry the tofu in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the green beans until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tofu_with_basmati_rice_spinach','Tofu met basmatirijst & spinazie','Tofu with basmati rice & spinach',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"tofu","g":150},{"slug":"basmati_dry","g":70},{"slug":"spinach","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY[]::text[],'1. Kook de basmatirijst (droog) volgens de verpakking.
2. Bak de tofu in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok spinazie beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the basmati rice (dry) per the package.
2. Pan-fry the tofu in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the spinach until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tofu_with_basmati_rice_asparagus','Tofu met basmatirijst & asperges','Tofu with basmati rice & asparagus',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"tofu","g":150},{"slug":"basmati_dry","g":70},{"slug":"asparagus","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY[]::text[],'1. Kook de basmatirijst (droog) volgens de verpakking.
2. Bak de tofu in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok asperges beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the basmati rice (dry) per the package.
2. Pan-fry the tofu in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the asparagus until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tofu_with_basmati_rice_zucchini','Tofu met basmatirijst & courgette','Tofu with basmati rice & zucchini',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"tofu","g":150},{"slug":"basmati_dry","g":70},{"slug":"zucchini","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY[]::text[],'1. Kook de basmatirijst (droog) volgens de verpakking.
2. Bak de tofu in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok courgette beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the basmati rice (dry) per the package.
2. Pan-fry the tofu in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the zucchini until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tofu_with_basmati_rice_stir_fry_veg','Tofu met basmatirijst & wokgroente','Tofu with basmati rice & stir-fry veg',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"tofu","g":150},{"slug":"basmati_dry","g":70},{"slug":"mixed_veg","g":150},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY[]::text[],'1. Kook de basmatirijst (droog) volgens de verpakking.
2. Bak de tofu in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok wokgroente beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the basmati rice (dry) per the package.
2. Pan-fry the tofu in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the stir-fry veg until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tofu_with_basmati_rice_mushrooms','Tofu met basmatirijst & champignons','Tofu with basmati rice & mushrooms',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"tofu","g":150},{"slug":"basmati_dry","g":70},{"slug":"mushroom","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY[]::text[],'1. Kook de basmatirijst (droog) volgens de verpakking.
2. Bak de tofu in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok champignons beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the basmati rice (dry) per the package.
2. Pan-fry the tofu in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the mushrooms until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tofu_with_basmati_rice_carrot','Tofu met basmatirijst & wortel','Tofu with basmati rice & carrot',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"tofu","g":150},{"slug":"basmati_dry","g":70},{"slug":"carrot","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY[]::text[],'1. Kook de basmatirijst (droog) volgens de verpakking.
2. Bak de tofu in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok wortel beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the basmati rice (dry) per the package.
2. Pan-fry the tofu in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the carrot until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tofu_with_basmati_rice_peas','Tofu met basmatirijst & doperwten','Tofu with basmati rice & peas',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"tofu","g":150},{"slug":"basmati_dry","g":70},{"slug":"peas","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY[]::text[],'1. Kook de basmatirijst (droog) volgens de verpakking.
2. Bak de tofu in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok doperwten beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the basmati rice (dry) per the package.
2. Pan-fry the tofu in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the peas until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tofu_with_basmati_rice_cauliflower','Tofu met basmatirijst & bloemkool','Tofu with basmati rice & cauliflower',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"tofu","g":150},{"slug":"basmati_dry","g":70},{"slug":"cauliflower","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY[]::text[],'1. Kook de basmatirijst (droog) volgens de verpakking.
2. Bak de tofu in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok bloemkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the basmati rice (dry) per the package.
2. Pan-fry the tofu in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the cauliflower until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tofu_with_basmati_rice_kale','Tofu met basmatirijst & boerenkool','Tofu with basmati rice & kale',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"tofu","g":150},{"slug":"basmati_dry","g":70},{"slug":"kale","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY[]::text[],'1. Kook de basmatirijst (droog) volgens de verpakking.
2. Bak de tofu in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok boerenkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the basmati rice (dry) per the package.
2. Pan-fry the tofu in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the kale until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tofu_with_basmati_rice_bok_choy','Tofu met basmatirijst & paksoi','Tofu with basmati rice & bok choy',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"tofu","g":150},{"slug":"basmati_dry","g":70},{"slug":"bok_choy","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY[]::text[],'1. Kook de basmatirijst (droog) volgens de verpakking.
2. Bak de tofu in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok paksoi beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the basmati rice (dry) per the package.
2. Pan-fry the tofu in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the bok choy until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tempeh_with_rice_broccoli','Tempeh met rijst & broccoli','Tempeh with rice & broccoli',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"tempeh","g":130},{"slug":"rice_dry","g":70},{"slug":"broccoli","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Kook de witte rijst (droog) volgens de verpakking.
2. Bak de tempeh in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok broccoli beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the white rice (dry) per the package.
2. Pan-fry the tempeh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the broccoli until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tempeh_with_rice_green_beans','Tempeh met rijst & sperziebonen','Tempeh with rice & green beans',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"tempeh","g":130},{"slug":"rice_dry","g":70},{"slug":"green_beans","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Kook de witte rijst (droog) volgens de verpakking.
2. Bak de tempeh in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok sperziebonen beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the white rice (dry) per the package.
2. Pan-fry the tempeh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the green beans until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tempeh_with_rice_spinach','Tempeh met rijst & spinazie','Tempeh with rice & spinach',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"tempeh","g":130},{"slug":"rice_dry","g":70},{"slug":"spinach","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Kook de witte rijst (droog) volgens de verpakking.
2. Bak de tempeh in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok spinazie beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the white rice (dry) per the package.
2. Pan-fry the tempeh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the spinach until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tempeh_with_rice_asparagus','Tempeh met rijst & asperges','Tempeh with rice & asparagus',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"tempeh","g":130},{"slug":"rice_dry","g":70},{"slug":"asparagus","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Kook de witte rijst (droog) volgens de verpakking.
2. Bak de tempeh in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok asperges beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the white rice (dry) per the package.
2. Pan-fry the tempeh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the asparagus until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tempeh_with_rice_zucchini','Tempeh met rijst & courgette','Tempeh with rice & zucchini',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"tempeh","g":130},{"slug":"rice_dry","g":70},{"slug":"zucchini","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Kook de witte rijst (droog) volgens de verpakking.
2. Bak de tempeh in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok courgette beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the white rice (dry) per the package.
2. Pan-fry the tempeh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the zucchini until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tempeh_with_rice_stir_fry_veg','Tempeh met rijst & wokgroente','Tempeh with rice & stir-fry veg',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"tempeh","g":130},{"slug":"rice_dry","g":70},{"slug":"mixed_veg","g":150},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Kook de witte rijst (droog) volgens de verpakking.
2. Bak de tempeh in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok wokgroente beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the white rice (dry) per the package.
2. Pan-fry the tempeh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the stir-fry veg until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tempeh_with_rice_mushrooms','Tempeh met rijst & champignons','Tempeh with rice & mushrooms',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"tempeh","g":130},{"slug":"rice_dry","g":70},{"slug":"mushroom","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Kook de witte rijst (droog) volgens de verpakking.
2. Bak de tempeh in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok champignons beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the white rice (dry) per the package.
2. Pan-fry the tempeh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the mushrooms until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tempeh_with_rice_carrot','Tempeh met rijst & wortel','Tempeh with rice & carrot',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"tempeh","g":130},{"slug":"rice_dry","g":70},{"slug":"carrot","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Kook de witte rijst (droog) volgens de verpakking.
2. Bak de tempeh in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok wortel beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the white rice (dry) per the package.
2. Pan-fry the tempeh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the carrot until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tempeh_with_rice_peas','Tempeh met rijst & doperwten','Tempeh with rice & peas',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"tempeh","g":130},{"slug":"rice_dry","g":70},{"slug":"peas","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Kook de witte rijst (droog) volgens de verpakking.
2. Bak de tempeh in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok doperwten beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the white rice (dry) per the package.
2. Pan-fry the tempeh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the peas until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tempeh_with_rice_cauliflower','Tempeh met rijst & bloemkool','Tempeh with rice & cauliflower',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"tempeh","g":130},{"slug":"rice_dry","g":70},{"slug":"cauliflower","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Kook de witte rijst (droog) volgens de verpakking.
2. Bak de tempeh in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok bloemkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the white rice (dry) per the package.
2. Pan-fry the tempeh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the cauliflower until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tempeh_with_rice_kale','Tempeh met rijst & boerenkool','Tempeh with rice & kale',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"tempeh","g":130},{"slug":"rice_dry","g":70},{"slug":"kale","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Kook de witte rijst (droog) volgens de verpakking.
2. Bak de tempeh in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok boerenkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the white rice (dry) per the package.
2. Pan-fry the tempeh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the kale until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tempeh_with_rice_bok_choy','Tempeh met rijst & paksoi','Tempeh with rice & bok choy',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"tempeh","g":130},{"slug":"rice_dry","g":70},{"slug":"bok_choy","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Kook de witte rijst (droog) volgens de verpakking.
2. Bak de tempeh in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok paksoi beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the white rice (dry) per the package.
2. Pan-fry the tempeh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the bok choy until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tempeh_with_sweet_potato_broccoli','Tempeh met zoete aardappel & broccoli','Tempeh with sweet potato & broccoli',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"tempeh","g":130},{"slug":"sweet_potato","g":200},{"slug":"broccoli","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY[]::text[],'1. Kook de zoete aardappel volgens de verpakking.
2. Bak de tempeh in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok broccoli beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the sweet potato per the package.
2. Pan-fry the tempeh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the broccoli until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tempeh_with_sweet_potato_green_beans','Tempeh met zoete aardappel & sperziebonen','Tempeh with sweet potato & green beans',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"tempeh","g":130},{"slug":"sweet_potato","g":200},{"slug":"green_beans","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY[]::text[],'1. Kook de zoete aardappel volgens de verpakking.
2. Bak de tempeh in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok sperziebonen beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the sweet potato per the package.
2. Pan-fry the tempeh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the green beans until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tempeh_with_sweet_potato_spinach','Tempeh met zoete aardappel & spinazie','Tempeh with sweet potato & spinach',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"tempeh","g":130},{"slug":"sweet_potato","g":200},{"slug":"spinach","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY[]::text[],'1. Kook de zoete aardappel volgens de verpakking.
2. Bak de tempeh in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok spinazie beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the sweet potato per the package.
2. Pan-fry the tempeh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the spinach until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tempeh_with_sweet_potato_asparagus','Tempeh met zoete aardappel & asperges','Tempeh with sweet potato & asparagus',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"tempeh","g":130},{"slug":"sweet_potato","g":200},{"slug":"asparagus","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY[]::text[],'1. Kook de zoete aardappel volgens de verpakking.
2. Bak de tempeh in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok asperges beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the sweet potato per the package.
2. Pan-fry the tempeh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the asparagus until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tempeh_with_sweet_potato_zucchini','Tempeh met zoete aardappel & courgette','Tempeh with sweet potato & zucchini',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"tempeh","g":130},{"slug":"sweet_potato","g":200},{"slug":"zucchini","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY[]::text[],'1. Kook de zoete aardappel volgens de verpakking.
2. Bak de tempeh in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok courgette beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the sweet potato per the package.
2. Pan-fry the tempeh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the zucchini until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tempeh_with_sweet_potato_stir_fry_veg','Tempeh met zoete aardappel & wokgroente','Tempeh with sweet potato & stir-fry veg',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"tempeh","g":130},{"slug":"sweet_potato","g":200},{"slug":"mixed_veg","g":150},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY[]::text[],'1. Kook de zoete aardappel volgens de verpakking.
2. Bak de tempeh in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok wokgroente beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the sweet potato per the package.
2. Pan-fry the tempeh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the stir-fry veg until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tempeh_with_sweet_potato_mushrooms','Tempeh met zoete aardappel & champignons','Tempeh with sweet potato & mushrooms',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"tempeh","g":130},{"slug":"sweet_potato","g":200},{"slug":"mushroom","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY[]::text[],'1. Kook de zoete aardappel volgens de verpakking.
2. Bak de tempeh in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok champignons beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the sweet potato per the package.
2. Pan-fry the tempeh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the mushrooms until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tempeh_with_sweet_potato_carrot','Tempeh met zoete aardappel & wortel','Tempeh with sweet potato & carrot',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"tempeh","g":130},{"slug":"sweet_potato","g":200},{"slug":"carrot","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY[]::text[],'1. Kook de zoete aardappel volgens de verpakking.
2. Bak de tempeh in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok wortel beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the sweet potato per the package.
2. Pan-fry the tempeh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the carrot until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tempeh_with_sweet_potato_peas','Tempeh met zoete aardappel & doperwten','Tempeh with sweet potato & peas',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"tempeh","g":130},{"slug":"sweet_potato","g":200},{"slug":"peas","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY[]::text[],'1. Kook de zoete aardappel volgens de verpakking.
2. Bak de tempeh in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok doperwten beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the sweet potato per the package.
2. Pan-fry the tempeh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the peas until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tempeh_with_sweet_potato_cauliflower','Tempeh met zoete aardappel & bloemkool','Tempeh with sweet potato & cauliflower',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"tempeh","g":130},{"slug":"sweet_potato","g":200},{"slug":"cauliflower","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY[]::text[],'1. Kook de zoete aardappel volgens de verpakking.
2. Bak de tempeh in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok bloemkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the sweet potato per the package.
2. Pan-fry the tempeh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the cauliflower until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tempeh_with_sweet_potato_kale','Tempeh met zoete aardappel & boerenkool','Tempeh with sweet potato & kale',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"tempeh","g":130},{"slug":"sweet_potato","g":200},{"slug":"kale","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY[]::text[],'1. Kook de zoete aardappel volgens de verpakking.
2. Bak de tempeh in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok boerenkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the sweet potato per the package.
2. Pan-fry the tempeh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the kale until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tempeh_with_sweet_potato_bok_choy','Tempeh met zoete aardappel & paksoi','Tempeh with sweet potato & bok choy',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"tempeh","g":130},{"slug":"sweet_potato","g":200},{"slug":"bok_choy","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY[]::text[],'1. Kook de zoete aardappel volgens de verpakking.
2. Bak de tempeh in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok paksoi beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the sweet potato per the package.
2. Pan-fry the tempeh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the bok choy until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tempeh_with_potato_broccoli','Tempeh met aardappel & broccoli','Tempeh with potato & broccoli',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"tempeh","g":130},{"slug":"potato","g":250},{"slug":"broccoli","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY['steakpotato']::text[],'1. Kook de aardappel volgens de verpakking.
2. Bak de tempeh in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok broccoli beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the potato per the package.
2. Pan-fry the tempeh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the broccoli until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tempeh_with_potato_green_beans','Tempeh met aardappel & sperziebonen','Tempeh with potato & green beans',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"tempeh","g":130},{"slug":"potato","g":250},{"slug":"green_beans","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY['steakpotato']::text[],'1. Kook de aardappel volgens de verpakking.
2. Bak de tempeh in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok sperziebonen beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the potato per the package.
2. Pan-fry the tempeh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the green beans until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tempeh_with_potato_spinach','Tempeh met aardappel & spinazie','Tempeh with potato & spinach',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"tempeh","g":130},{"slug":"potato","g":250},{"slug":"spinach","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY['steakpotato']::text[],'1. Kook de aardappel volgens de verpakking.
2. Bak de tempeh in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok spinazie beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the potato per the package.
2. Pan-fry the tempeh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the spinach until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tempeh_with_potato_asparagus','Tempeh met aardappel & asperges','Tempeh with potato & asparagus',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"tempeh","g":130},{"slug":"potato","g":250},{"slug":"asparagus","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY['steakpotato']::text[],'1. Kook de aardappel volgens de verpakking.
2. Bak de tempeh in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok asperges beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the potato per the package.
2. Pan-fry the tempeh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the asparagus until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tempeh_with_potato_zucchini','Tempeh met aardappel & courgette','Tempeh with potato & zucchini',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"tempeh","g":130},{"slug":"potato","g":250},{"slug":"zucchini","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY['steakpotato']::text[],'1. Kook de aardappel volgens de verpakking.
2. Bak de tempeh in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok courgette beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the potato per the package.
2. Pan-fry the tempeh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the zucchini until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tempeh_with_potato_stir_fry_veg','Tempeh met aardappel & wokgroente','Tempeh with potato & stir-fry veg',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"tempeh","g":130},{"slug":"potato","g":250},{"slug":"mixed_veg","g":150},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY['steakpotato']::text[],'1. Kook de aardappel volgens de verpakking.
2. Bak de tempeh in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok wokgroente beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the potato per the package.
2. Pan-fry the tempeh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the stir-fry veg until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tempeh_with_potato_mushrooms','Tempeh met aardappel & champignons','Tempeh with potato & mushrooms',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"tempeh","g":130},{"slug":"potato","g":250},{"slug":"mushroom","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY['steakpotato']::text[],'1. Kook de aardappel volgens de verpakking.
2. Bak de tempeh in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok champignons beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the potato per the package.
2. Pan-fry the tempeh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the mushrooms until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tempeh_with_potato_carrot','Tempeh met aardappel & wortel','Tempeh with potato & carrot',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"tempeh","g":130},{"slug":"potato","g":250},{"slug":"carrot","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY['steakpotato']::text[],'1. Kook de aardappel volgens de verpakking.
2. Bak de tempeh in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok wortel beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the potato per the package.
2. Pan-fry the tempeh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the carrot until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tempeh_with_potato_peas','Tempeh met aardappel & doperwten','Tempeh with potato & peas',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"tempeh","g":130},{"slug":"potato","g":250},{"slug":"peas","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY['steakpotato']::text[],'1. Kook de aardappel volgens de verpakking.
2. Bak de tempeh in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok doperwten beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the potato per the package.
2. Pan-fry the tempeh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the peas until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tempeh_with_potato_cauliflower','Tempeh met aardappel & bloemkool','Tempeh with potato & cauliflower',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"tempeh","g":130},{"slug":"potato","g":250},{"slug":"cauliflower","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY['steakpotato']::text[],'1. Kook de aardappel volgens de verpakking.
2. Bak de tempeh in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok bloemkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the potato per the package.
2. Pan-fry the tempeh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the cauliflower until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tempeh_with_potato_kale','Tempeh met aardappel & boerenkool','Tempeh with potato & kale',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"tempeh","g":130},{"slug":"potato","g":250},{"slug":"kale","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY['steakpotato']::text[],'1. Kook de aardappel volgens de verpakking.
2. Bak de tempeh in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok boerenkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the potato per the package.
2. Pan-fry the tempeh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the kale until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tempeh_with_potato_bok_choy','Tempeh met aardappel & paksoi','Tempeh with potato & bok choy',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"tempeh","g":130},{"slug":"potato","g":250},{"slug":"bok_choy","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY['steakpotato']::text[],'1. Kook de aardappel volgens de verpakking.
2. Bak de tempeh in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok paksoi beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the potato per the package.
2. Pan-fry the tempeh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the bok choy until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tempeh_with_pasta_broccoli','Tempeh met pasta & broccoli','Tempeh with pasta & broccoli',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"tempeh","g":130},{"slug":"pasta_dry","g":80},{"slug":"broccoli","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY['pastabol']::text[],'1. Kook de volkoren pasta (droog) volgens de verpakking.
2. Bak de tempeh in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok broccoli beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat pasta (dry) per the package.
2. Pan-fry the tempeh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the broccoli until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tempeh_with_pasta_green_beans','Tempeh met pasta & sperziebonen','Tempeh with pasta & green beans',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"tempeh","g":130},{"slug":"pasta_dry","g":80},{"slug":"green_beans","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY['pastabol']::text[],'1. Kook de volkoren pasta (droog) volgens de verpakking.
2. Bak de tempeh in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok sperziebonen beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat pasta (dry) per the package.
2. Pan-fry the tempeh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the green beans until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tempeh_with_pasta_spinach','Tempeh met pasta & spinazie','Tempeh with pasta & spinach',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"tempeh","g":130},{"slug":"pasta_dry","g":80},{"slug":"spinach","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY['pastabol']::text[],'1. Kook de volkoren pasta (droog) volgens de verpakking.
2. Bak de tempeh in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok spinazie beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat pasta (dry) per the package.
2. Pan-fry the tempeh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the spinach until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tempeh_with_pasta_asparagus','Tempeh met pasta & asperges','Tempeh with pasta & asparagus',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"tempeh","g":130},{"slug":"pasta_dry","g":80},{"slug":"asparagus","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY['pastabol']::text[],'1. Kook de volkoren pasta (droog) volgens de verpakking.
2. Bak de tempeh in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok asperges beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat pasta (dry) per the package.
2. Pan-fry the tempeh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the asparagus until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tempeh_with_pasta_zucchini','Tempeh met pasta & courgette','Tempeh with pasta & zucchini',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"tempeh","g":130},{"slug":"pasta_dry","g":80},{"slug":"zucchini","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY['pastabol']::text[],'1. Kook de volkoren pasta (droog) volgens de verpakking.
2. Bak de tempeh in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok courgette beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat pasta (dry) per the package.
2. Pan-fry the tempeh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the zucchini until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tempeh_with_pasta_stir_fry_veg','Tempeh met pasta & wokgroente','Tempeh with pasta & stir-fry veg',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"tempeh","g":130},{"slug":"pasta_dry","g":80},{"slug":"mixed_veg","g":150},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY['pastabol']::text[],'1. Kook de volkoren pasta (droog) volgens de verpakking.
2. Bak de tempeh in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok wokgroente beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat pasta (dry) per the package.
2. Pan-fry the tempeh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the stir-fry veg until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tempeh_with_pasta_mushrooms','Tempeh met pasta & champignons','Tempeh with pasta & mushrooms',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"tempeh","g":130},{"slug":"pasta_dry","g":80},{"slug":"mushroom","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY['pastabol']::text[],'1. Kook de volkoren pasta (droog) volgens de verpakking.
2. Bak de tempeh in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok champignons beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat pasta (dry) per the package.
2. Pan-fry the tempeh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the mushrooms until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tempeh_with_pasta_carrot','Tempeh met pasta & wortel','Tempeh with pasta & carrot',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"tempeh","g":130},{"slug":"pasta_dry","g":80},{"slug":"carrot","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY['pastabol']::text[],'1. Kook de volkoren pasta (droog) volgens de verpakking.
2. Bak de tempeh in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok wortel beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat pasta (dry) per the package.
2. Pan-fry the tempeh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the carrot until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tempeh_with_pasta_peas','Tempeh met pasta & doperwten','Tempeh with pasta & peas',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"tempeh","g":130},{"slug":"pasta_dry","g":80},{"slug":"peas","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY['pastabol']::text[],'1. Kook de volkoren pasta (droog) volgens de verpakking.
2. Bak de tempeh in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok doperwten beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat pasta (dry) per the package.
2. Pan-fry the tempeh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the peas until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tempeh_with_pasta_cauliflower','Tempeh met pasta & bloemkool','Tempeh with pasta & cauliflower',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"tempeh","g":130},{"slug":"pasta_dry","g":80},{"slug":"cauliflower","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY['pastabol']::text[],'1. Kook de volkoren pasta (droog) volgens de verpakking.
2. Bak de tempeh in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok bloemkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat pasta (dry) per the package.
2. Pan-fry the tempeh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the cauliflower until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tempeh_with_pasta_kale','Tempeh met pasta & boerenkool','Tempeh with pasta & kale',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"tempeh","g":130},{"slug":"pasta_dry","g":80},{"slug":"kale","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY['pastabol']::text[],'1. Kook de volkoren pasta (droog) volgens de verpakking.
2. Bak de tempeh in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok boerenkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat pasta (dry) per the package.
2. Pan-fry the tempeh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the kale until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tempeh_with_pasta_bok_choy','Tempeh met pasta & paksoi','Tempeh with pasta & bok choy',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"tempeh","g":130},{"slug":"pasta_dry","g":80},{"slug":"bok_choy","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY['pastabol']::text[],'1. Kook de volkoren pasta (droog) volgens de verpakking.
2. Bak de tempeh in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok paksoi beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat pasta (dry) per the package.
2. Pan-fry the tempeh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the bok choy until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tempeh_with_quinoa_broccoli','Tempeh met quinoa & broccoli','Tempeh with quinoa & broccoli',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"tempeh","g":130},{"slug":"quinoa_dry","g":70},{"slug":"broccoli","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY[]::text[],'1. Kook de quinoa (droog) volgens de verpakking.
2. Bak de tempeh in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok broccoli beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the quinoa (dry) per the package.
2. Pan-fry the tempeh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the broccoli until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tempeh_with_quinoa_green_beans','Tempeh met quinoa & sperziebonen','Tempeh with quinoa & green beans',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"tempeh","g":130},{"slug":"quinoa_dry","g":70},{"slug":"green_beans","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY[]::text[],'1. Kook de quinoa (droog) volgens de verpakking.
2. Bak de tempeh in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok sperziebonen beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the quinoa (dry) per the package.
2. Pan-fry the tempeh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the green beans until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tempeh_with_quinoa_spinach','Tempeh met quinoa & spinazie','Tempeh with quinoa & spinach',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"tempeh","g":130},{"slug":"quinoa_dry","g":70},{"slug":"spinach","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY[]::text[],'1. Kook de quinoa (droog) volgens de verpakking.
2. Bak de tempeh in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok spinazie beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the quinoa (dry) per the package.
2. Pan-fry the tempeh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the spinach until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tempeh_with_quinoa_asparagus','Tempeh met quinoa & asperges','Tempeh with quinoa & asparagus',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"tempeh","g":130},{"slug":"quinoa_dry","g":70},{"slug":"asparagus","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY[]::text[],'1. Kook de quinoa (droog) volgens de verpakking.
2. Bak de tempeh in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok asperges beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the quinoa (dry) per the package.
2. Pan-fry the tempeh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the asparagus until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tempeh_with_quinoa_zucchini','Tempeh met quinoa & courgette','Tempeh with quinoa & zucchini',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"tempeh","g":130},{"slug":"quinoa_dry","g":70},{"slug":"zucchini","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY[]::text[],'1. Kook de quinoa (droog) volgens de verpakking.
2. Bak de tempeh in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok courgette beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the quinoa (dry) per the package.
2. Pan-fry the tempeh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the zucchini until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tempeh_with_quinoa_stir_fry_veg','Tempeh met quinoa & wokgroente','Tempeh with quinoa & stir-fry veg',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"tempeh","g":130},{"slug":"quinoa_dry","g":70},{"slug":"mixed_veg","g":150},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY[]::text[],'1. Kook de quinoa (droog) volgens de verpakking.
2. Bak de tempeh in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok wokgroente beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the quinoa (dry) per the package.
2. Pan-fry the tempeh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the stir-fry veg until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tempeh_with_quinoa_mushrooms','Tempeh met quinoa & champignons','Tempeh with quinoa & mushrooms',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"tempeh","g":130},{"slug":"quinoa_dry","g":70},{"slug":"mushroom","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY[]::text[],'1. Kook de quinoa (droog) volgens de verpakking.
2. Bak de tempeh in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok champignons beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the quinoa (dry) per the package.
2. Pan-fry the tempeh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the mushrooms until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tempeh_with_quinoa_carrot','Tempeh met quinoa & wortel','Tempeh with quinoa & carrot',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"tempeh","g":130},{"slug":"quinoa_dry","g":70},{"slug":"carrot","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY[]::text[],'1. Kook de quinoa (droog) volgens de verpakking.
2. Bak de tempeh in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok wortel beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the quinoa (dry) per the package.
2. Pan-fry the tempeh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the carrot until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tempeh_with_quinoa_peas','Tempeh met quinoa & doperwten','Tempeh with quinoa & peas',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"tempeh","g":130},{"slug":"quinoa_dry","g":70},{"slug":"peas","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY[]::text[],'1. Kook de quinoa (droog) volgens de verpakking.
2. Bak de tempeh in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok doperwten beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the quinoa (dry) per the package.
2. Pan-fry the tempeh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the peas until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tempeh_with_quinoa_cauliflower','Tempeh met quinoa & bloemkool','Tempeh with quinoa & cauliflower',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"tempeh","g":130},{"slug":"quinoa_dry","g":70},{"slug":"cauliflower","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY[]::text[],'1. Kook de quinoa (droog) volgens de verpakking.
2. Bak de tempeh in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok bloemkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the quinoa (dry) per the package.
2. Pan-fry the tempeh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the cauliflower until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tempeh_with_quinoa_kale','Tempeh met quinoa & boerenkool','Tempeh with quinoa & kale',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"tempeh","g":130},{"slug":"quinoa_dry","g":70},{"slug":"kale","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY[]::text[],'1. Kook de quinoa (droog) volgens de verpakking.
2. Bak de tempeh in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok boerenkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the quinoa (dry) per the package.
2. Pan-fry the tempeh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the kale until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tempeh_with_quinoa_bok_choy','Tempeh met quinoa & paksoi','Tempeh with quinoa & bok choy',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"tempeh","g":130},{"slug":"quinoa_dry","g":70},{"slug":"bok_choy","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY[]::text[],'1. Kook de quinoa (droog) volgens de verpakking.
2. Bak de tempeh in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok paksoi beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the quinoa (dry) per the package.
2. Pan-fry the tempeh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the bok choy until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tempeh_with_noodles_broccoli','Tempeh met noedels & broccoli','Tempeh with noodles & broccoli',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"tempeh","g":130},{"slug":"noodles_dry","g":80},{"slug":"broccoli","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY['woknoodles']::text[],'1. Kook de volkoren noedels (droog) volgens de verpakking.
2. Bak de tempeh in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok broccoli beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat noodles (dry) per the package.
2. Pan-fry the tempeh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the broccoli until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tempeh_with_noodles_green_beans','Tempeh met noedels & sperziebonen','Tempeh with noodles & green beans',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"tempeh","g":130},{"slug":"noodles_dry","g":80},{"slug":"green_beans","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY['woknoodles']::text[],'1. Kook de volkoren noedels (droog) volgens de verpakking.
2. Bak de tempeh in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok sperziebonen beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat noodles (dry) per the package.
2. Pan-fry the tempeh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the green beans until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tempeh_with_noodles_spinach','Tempeh met noedels & spinazie','Tempeh with noodles & spinach',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"tempeh","g":130},{"slug":"noodles_dry","g":80},{"slug":"spinach","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY['woknoodles']::text[],'1. Kook de volkoren noedels (droog) volgens de verpakking.
2. Bak de tempeh in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok spinazie beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat noodles (dry) per the package.
2. Pan-fry the tempeh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the spinach until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tempeh_with_noodles_asparagus','Tempeh met noedels & asperges','Tempeh with noodles & asparagus',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"tempeh","g":130},{"slug":"noodles_dry","g":80},{"slug":"asparagus","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY['woknoodles']::text[],'1. Kook de volkoren noedels (droog) volgens de verpakking.
2. Bak de tempeh in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok asperges beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat noodles (dry) per the package.
2. Pan-fry the tempeh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the asparagus until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tempeh_with_noodles_zucchini','Tempeh met noedels & courgette','Tempeh with noodles & zucchini',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"tempeh","g":130},{"slug":"noodles_dry","g":80},{"slug":"zucchini","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY['woknoodles']::text[],'1. Kook de volkoren noedels (droog) volgens de verpakking.
2. Bak de tempeh in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok courgette beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat noodles (dry) per the package.
2. Pan-fry the tempeh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the zucchini until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tempeh_with_noodles_stir_fry_veg','Tempeh met noedels & wokgroente','Tempeh with noodles & stir-fry veg',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"tempeh","g":130},{"slug":"noodles_dry","g":80},{"slug":"mixed_veg","g":150},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY['woknoodles']::text[],'1. Kook de volkoren noedels (droog) volgens de verpakking.
2. Bak de tempeh in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok wokgroente beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat noodles (dry) per the package.
2. Pan-fry the tempeh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the stir-fry veg until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tempeh_with_noodles_mushrooms','Tempeh met noedels & champignons','Tempeh with noodles & mushrooms',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"tempeh","g":130},{"slug":"noodles_dry","g":80},{"slug":"mushroom","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY['woknoodles']::text[],'1. Kook de volkoren noedels (droog) volgens de verpakking.
2. Bak de tempeh in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok champignons beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat noodles (dry) per the package.
2. Pan-fry the tempeh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the mushrooms until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tempeh_with_noodles_carrot','Tempeh met noedels & wortel','Tempeh with noodles & carrot',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"tempeh","g":130},{"slug":"noodles_dry","g":80},{"slug":"carrot","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY['woknoodles']::text[],'1. Kook de volkoren noedels (droog) volgens de verpakking.
2. Bak de tempeh in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok wortel beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat noodles (dry) per the package.
2. Pan-fry the tempeh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the carrot until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tempeh_with_noodles_peas','Tempeh met noedels & doperwten','Tempeh with noodles & peas',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"tempeh","g":130},{"slug":"noodles_dry","g":80},{"slug":"peas","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY['woknoodles']::text[],'1. Kook de volkoren noedels (droog) volgens de verpakking.
2. Bak de tempeh in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok doperwten beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat noodles (dry) per the package.
2. Pan-fry the tempeh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the peas until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tempeh_with_noodles_cauliflower','Tempeh met noedels & bloemkool','Tempeh with noodles & cauliflower',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"tempeh","g":130},{"slug":"noodles_dry","g":80},{"slug":"cauliflower","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY['woknoodles']::text[],'1. Kook de volkoren noedels (droog) volgens de verpakking.
2. Bak de tempeh in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok bloemkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat noodles (dry) per the package.
2. Pan-fry the tempeh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the cauliflower until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tempeh_with_noodles_kale','Tempeh met noedels & boerenkool','Tempeh with noodles & kale',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"tempeh","g":130},{"slug":"noodles_dry","g":80},{"slug":"kale","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY['woknoodles']::text[],'1. Kook de volkoren noedels (droog) volgens de verpakking.
2. Bak de tempeh in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok boerenkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat noodles (dry) per the package.
2. Pan-fry the tempeh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the kale until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tempeh_with_noodles_bok_choy','Tempeh met noedels & paksoi','Tempeh with noodles & bok choy',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"tempeh","g":130},{"slug":"noodles_dry","g":80},{"slug":"bok_choy","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY['woknoodles']::text[],'1. Kook de volkoren noedels (droog) volgens de verpakking.
2. Bak de tempeh in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok paksoi beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat noodles (dry) per the package.
2. Pan-fry the tempeh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the bok choy until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tempeh_with_couscous_broccoli','Tempeh met couscous & broccoli','Tempeh with couscous & broccoli',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"tempeh","g":130},{"slug":"couscous_dry","g":70},{"slug":"broccoli","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY[]::text[],'1. Kook de volkoren couscous (droog) volgens de verpakking.
2. Bak de tempeh in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok broccoli beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat couscous (dry) per the package.
2. Pan-fry the tempeh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the broccoli until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tempeh_with_couscous_green_beans','Tempeh met couscous & sperziebonen','Tempeh with couscous & green beans',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"tempeh","g":130},{"slug":"couscous_dry","g":70},{"slug":"green_beans","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY[]::text[],'1. Kook de volkoren couscous (droog) volgens de verpakking.
2. Bak de tempeh in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok sperziebonen beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat couscous (dry) per the package.
2. Pan-fry the tempeh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the green beans until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tempeh_with_couscous_spinach','Tempeh met couscous & spinazie','Tempeh with couscous & spinach',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"tempeh","g":130},{"slug":"couscous_dry","g":70},{"slug":"spinach","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY[]::text[],'1. Kook de volkoren couscous (droog) volgens de verpakking.
2. Bak de tempeh in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok spinazie beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat couscous (dry) per the package.
2. Pan-fry the tempeh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the spinach until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('tempeh_with_couscous_asparagus','Tempeh met couscous & asperges','Tempeh with couscous & asparagus',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"tempeh","g":130},{"slug":"couscous_dry","g":70},{"slug":"asparagus","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY[]::text[],'1. Kook de volkoren couscous (droog) volgens de verpakking.
2. Bak de tempeh in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok asperges beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat couscous (dry) per the package.
2. Pan-fry the tempeh in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the asparagus until tender-crisp.
4. Plate up and finish.','pan',null,'core')
on conflict (slug) do update set name_nl=excluded.name_nl,name_en=excluded.name_en,moments=excluded.moments,goals=excluded.goals,items=excluded.items,tags=excluded.tags,prefs=excluded.prefs,steps=excluded.steps,steps_en=excluded.steps_en,technique=excluded.technique,temp=excluded.temp;
commit;
