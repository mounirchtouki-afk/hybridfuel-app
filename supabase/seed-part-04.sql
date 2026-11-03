-- AUTO-GEGENEREERD core-seed deel 4/9 (200 gerechten). Draai NA dish-library.sql.
-- Draai de delen op volgorde (01, 02, ...). Elk deel is los veilig (upsert).
begin;
insert into public.dishes (slug,name_nl,name_en,moments,goals,items,tags,prefs,steps,steps_en,technique,temp,source) values
('pork_with_rice_broccoli','Varkenshaas met rijst & broccoli','Pork with rice & broccoli',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"pork_tenderloin","g":150},{"slug":"rice_dry","g":70},{"slug":"broccoli","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Kook de witte rijst (droog) volgens de verpakking.
2. Bak de varkenshaas in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok broccoli beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the white rice (dry) per the package.
2. Pan-fry the pork tenderloin in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the broccoli until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('pork_with_rice_green_beans','Varkenshaas met rijst & sperziebonen','Pork with rice & green beans',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"pork_tenderloin","g":150},{"slug":"rice_dry","g":70},{"slug":"green_beans","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Kook de witte rijst (droog) volgens de verpakking.
2. Bak de varkenshaas in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok sperziebonen beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the white rice (dry) per the package.
2. Pan-fry the pork tenderloin in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the green beans until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('pork_with_rice_spinach','Varkenshaas met rijst & spinazie','Pork with rice & spinach',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"pork_tenderloin","g":150},{"slug":"rice_dry","g":70},{"slug":"spinach","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Kook de witte rijst (droog) volgens de verpakking.
2. Bak de varkenshaas in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok spinazie beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the white rice (dry) per the package.
2. Pan-fry the pork tenderloin in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the spinach until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('pork_with_rice_asparagus','Varkenshaas met rijst & asperges','Pork with rice & asparagus',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"pork_tenderloin","g":150},{"slug":"rice_dry","g":70},{"slug":"asparagus","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Kook de witte rijst (droog) volgens de verpakking.
2. Bak de varkenshaas in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok asperges beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the white rice (dry) per the package.
2. Pan-fry the pork tenderloin in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the asparagus until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('pork_with_rice_zucchini','Varkenshaas met rijst & courgette','Pork with rice & zucchini',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"pork_tenderloin","g":150},{"slug":"rice_dry","g":70},{"slug":"zucchini","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Kook de witte rijst (droog) volgens de verpakking.
2. Bak de varkenshaas in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok courgette beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the white rice (dry) per the package.
2. Pan-fry the pork tenderloin in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the zucchini until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('pork_with_rice_stir_fry_veg','Varkenshaas met rijst & wokgroente','Pork with rice & stir-fry veg',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"pork_tenderloin","g":150},{"slug":"rice_dry","g":70},{"slug":"mixed_veg","g":150},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Kook de witte rijst (droog) volgens de verpakking.
2. Bak de varkenshaas in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok wokgroente beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the white rice (dry) per the package.
2. Pan-fry the pork tenderloin in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the stir-fry veg until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('pork_with_rice_mushrooms','Varkenshaas met rijst & champignons','Pork with rice & mushrooms',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"pork_tenderloin","g":150},{"slug":"rice_dry","g":70},{"slug":"mushroom","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Kook de witte rijst (droog) volgens de verpakking.
2. Bak de varkenshaas in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok champignons beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the white rice (dry) per the package.
2. Pan-fry the pork tenderloin in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the mushrooms until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('pork_with_rice_carrot','Varkenshaas met rijst & wortel','Pork with rice & carrot',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"pork_tenderloin","g":150},{"slug":"rice_dry","g":70},{"slug":"carrot","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Kook de witte rijst (droog) volgens de verpakking.
2. Bak de varkenshaas in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok wortel beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the white rice (dry) per the package.
2. Pan-fry the pork tenderloin in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the carrot until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('pork_with_rice_peas','Varkenshaas met rijst & doperwten','Pork with rice & peas',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"pork_tenderloin","g":150},{"slug":"rice_dry","g":70},{"slug":"peas","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Kook de witte rijst (droog) volgens de verpakking.
2. Bak de varkenshaas in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok doperwten beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the white rice (dry) per the package.
2. Pan-fry the pork tenderloin in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the peas until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('pork_with_rice_cauliflower','Varkenshaas met rijst & bloemkool','Pork with rice & cauliflower',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"pork_tenderloin","g":150},{"slug":"rice_dry","g":70},{"slug":"cauliflower","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Kook de witte rijst (droog) volgens de verpakking.
2. Bak de varkenshaas in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok bloemkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the white rice (dry) per the package.
2. Pan-fry the pork tenderloin in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the cauliflower until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('pork_with_rice_kale','Varkenshaas met rijst & boerenkool','Pork with rice & kale',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"pork_tenderloin","g":150},{"slug":"rice_dry","g":70},{"slug":"kale","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Kook de witte rijst (droog) volgens de verpakking.
2. Bak de varkenshaas in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok boerenkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the white rice (dry) per the package.
2. Pan-fry the pork tenderloin in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the kale until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('pork_with_rice_bok_choy','Varkenshaas met rijst & paksoi','Pork with rice & bok choy',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"pork_tenderloin","g":150},{"slug":"rice_dry","g":70},{"slug":"bok_choy","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Kook de witte rijst (droog) volgens de verpakking.
2. Bak de varkenshaas in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok paksoi beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the white rice (dry) per the package.
2. Pan-fry the pork tenderloin in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the bok choy until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('pork_with_sweet_potato_broccoli','Varkenshaas met zoete aardappel & broccoli','Pork with sweet potato & broccoli',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"pork_tenderloin","g":150},{"slug":"sweet_potato","g":200},{"slug":"broccoli","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de zoete aardappel volgens de verpakking.
2. Bak de varkenshaas in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok broccoli beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the sweet potato per the package.
2. Pan-fry the pork tenderloin in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the broccoli until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('pork_with_sweet_potato_green_beans','Varkenshaas met zoete aardappel & sperziebonen','Pork with sweet potato & green beans',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"pork_tenderloin","g":150},{"slug":"sweet_potato","g":200},{"slug":"green_beans","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de zoete aardappel volgens de verpakking.
2. Bak de varkenshaas in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok sperziebonen beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the sweet potato per the package.
2. Pan-fry the pork tenderloin in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the green beans until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('pork_with_sweet_potato_spinach','Varkenshaas met zoete aardappel & spinazie','Pork with sweet potato & spinach',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"pork_tenderloin","g":150},{"slug":"sweet_potato","g":200},{"slug":"spinach","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de zoete aardappel volgens de verpakking.
2. Bak de varkenshaas in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok spinazie beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the sweet potato per the package.
2. Pan-fry the pork tenderloin in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the spinach until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('pork_with_sweet_potato_asparagus','Varkenshaas met zoete aardappel & asperges','Pork with sweet potato & asparagus',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"pork_tenderloin","g":150},{"slug":"sweet_potato","g":200},{"slug":"asparagus","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de zoete aardappel volgens de verpakking.
2. Bak de varkenshaas in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok asperges beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the sweet potato per the package.
2. Pan-fry the pork tenderloin in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the asparagus until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('pork_with_sweet_potato_zucchini','Varkenshaas met zoete aardappel & courgette','Pork with sweet potato & zucchini',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"pork_tenderloin","g":150},{"slug":"sweet_potato","g":200},{"slug":"zucchini","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de zoete aardappel volgens de verpakking.
2. Bak de varkenshaas in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok courgette beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the sweet potato per the package.
2. Pan-fry the pork tenderloin in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the zucchini until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('pork_with_sweet_potato_stir_fry_veg','Varkenshaas met zoete aardappel & wokgroente','Pork with sweet potato & stir-fry veg',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"pork_tenderloin","g":150},{"slug":"sweet_potato","g":200},{"slug":"mixed_veg","g":150},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de zoete aardappel volgens de verpakking.
2. Bak de varkenshaas in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok wokgroente beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the sweet potato per the package.
2. Pan-fry the pork tenderloin in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the stir-fry veg until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('pork_with_sweet_potato_mushrooms','Varkenshaas met zoete aardappel & champignons','Pork with sweet potato & mushrooms',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"pork_tenderloin","g":150},{"slug":"sweet_potato","g":200},{"slug":"mushroom","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de zoete aardappel volgens de verpakking.
2. Bak de varkenshaas in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok champignons beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the sweet potato per the package.
2. Pan-fry the pork tenderloin in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the mushrooms until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('pork_with_sweet_potato_carrot','Varkenshaas met zoete aardappel & wortel','Pork with sweet potato & carrot',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"pork_tenderloin","g":150},{"slug":"sweet_potato","g":200},{"slug":"carrot","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de zoete aardappel volgens de verpakking.
2. Bak de varkenshaas in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok wortel beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the sweet potato per the package.
2. Pan-fry the pork tenderloin in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the carrot until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('pork_with_sweet_potato_peas','Varkenshaas met zoete aardappel & doperwten','Pork with sweet potato & peas',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"pork_tenderloin","g":150},{"slug":"sweet_potato","g":200},{"slug":"peas","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de zoete aardappel volgens de verpakking.
2. Bak de varkenshaas in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok doperwten beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the sweet potato per the package.
2. Pan-fry the pork tenderloin in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the peas until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('pork_with_sweet_potato_cauliflower','Varkenshaas met zoete aardappel & bloemkool','Pork with sweet potato & cauliflower',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"pork_tenderloin","g":150},{"slug":"sweet_potato","g":200},{"slug":"cauliflower","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de zoete aardappel volgens de verpakking.
2. Bak de varkenshaas in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok bloemkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the sweet potato per the package.
2. Pan-fry the pork tenderloin in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the cauliflower until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('pork_with_sweet_potato_kale','Varkenshaas met zoete aardappel & boerenkool','Pork with sweet potato & kale',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"pork_tenderloin","g":150},{"slug":"sweet_potato","g":200},{"slug":"kale","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de zoete aardappel volgens de verpakking.
2. Bak de varkenshaas in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok boerenkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the sweet potato per the package.
2. Pan-fry the pork tenderloin in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the kale until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('pork_with_sweet_potato_bok_choy','Varkenshaas met zoete aardappel & paksoi','Pork with sweet potato & bok choy',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"pork_tenderloin","g":150},{"slug":"sweet_potato","g":200},{"slug":"bok_choy","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de zoete aardappel volgens de verpakking.
2. Bak de varkenshaas in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok paksoi beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the sweet potato per the package.
2. Pan-fry the pork tenderloin in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the bok choy until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('pork_with_potato_broccoli','Varkenshaas met aardappel & broccoli','Pork with potato & broccoli',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"pork_tenderloin","g":150},{"slug":"potato","g":250},{"slug":"broccoli","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['steakpotato']::text[],'1. Kook de aardappel volgens de verpakking.
2. Bak de varkenshaas in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok broccoli beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the potato per the package.
2. Pan-fry the pork tenderloin in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the broccoli until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('pork_with_potato_green_beans','Varkenshaas met aardappel & sperziebonen','Pork with potato & green beans',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"pork_tenderloin","g":150},{"slug":"potato","g":250},{"slug":"green_beans","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['steakpotato']::text[],'1. Kook de aardappel volgens de verpakking.
2. Bak de varkenshaas in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok sperziebonen beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the potato per the package.
2. Pan-fry the pork tenderloin in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the green beans until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('pork_with_potato_spinach','Varkenshaas met aardappel & spinazie','Pork with potato & spinach',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"pork_tenderloin","g":150},{"slug":"potato","g":250},{"slug":"spinach","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['steakpotato']::text[],'1. Kook de aardappel volgens de verpakking.
2. Bak de varkenshaas in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok spinazie beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the potato per the package.
2. Pan-fry the pork tenderloin in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the spinach until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('pork_with_potato_asparagus','Varkenshaas met aardappel & asperges','Pork with potato & asparagus',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"pork_tenderloin","g":150},{"slug":"potato","g":250},{"slug":"asparagus","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['steakpotato']::text[],'1. Kook de aardappel volgens de verpakking.
2. Bak de varkenshaas in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok asperges beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the potato per the package.
2. Pan-fry the pork tenderloin in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the asparagus until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('pork_with_potato_zucchini','Varkenshaas met aardappel & courgette','Pork with potato & zucchini',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"pork_tenderloin","g":150},{"slug":"potato","g":250},{"slug":"zucchini","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['steakpotato']::text[],'1. Kook de aardappel volgens de verpakking.
2. Bak de varkenshaas in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok courgette beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the potato per the package.
2. Pan-fry the pork tenderloin in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the zucchini until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('pork_with_potato_stir_fry_veg','Varkenshaas met aardappel & wokgroente','Pork with potato & stir-fry veg',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"pork_tenderloin","g":150},{"slug":"potato","g":250},{"slug":"mixed_veg","g":150},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['steakpotato']::text[],'1. Kook de aardappel volgens de verpakking.
2. Bak de varkenshaas in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok wokgroente beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the potato per the package.
2. Pan-fry the pork tenderloin in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the stir-fry veg until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('pork_with_potato_mushrooms','Varkenshaas met aardappel & champignons','Pork with potato & mushrooms',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"pork_tenderloin","g":150},{"slug":"potato","g":250},{"slug":"mushroom","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['steakpotato']::text[],'1. Kook de aardappel volgens de verpakking.
2. Bak de varkenshaas in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok champignons beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the potato per the package.
2. Pan-fry the pork tenderloin in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the mushrooms until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('pork_with_potato_carrot','Varkenshaas met aardappel & wortel','Pork with potato & carrot',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"pork_tenderloin","g":150},{"slug":"potato","g":250},{"slug":"carrot","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['steakpotato']::text[],'1. Kook de aardappel volgens de verpakking.
2. Bak de varkenshaas in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok wortel beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the potato per the package.
2. Pan-fry the pork tenderloin in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the carrot until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('pork_with_potato_peas','Varkenshaas met aardappel & doperwten','Pork with potato & peas',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"pork_tenderloin","g":150},{"slug":"potato","g":250},{"slug":"peas","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['steakpotato']::text[],'1. Kook de aardappel volgens de verpakking.
2. Bak de varkenshaas in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok doperwten beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the potato per the package.
2. Pan-fry the pork tenderloin in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the peas until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('pork_with_potato_cauliflower','Varkenshaas met aardappel & bloemkool','Pork with potato & cauliflower',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"pork_tenderloin","g":150},{"slug":"potato","g":250},{"slug":"cauliflower","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['steakpotato']::text[],'1. Kook de aardappel volgens de verpakking.
2. Bak de varkenshaas in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok bloemkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the potato per the package.
2. Pan-fry the pork tenderloin in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the cauliflower until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('pork_with_potato_kale','Varkenshaas met aardappel & boerenkool','Pork with potato & kale',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"pork_tenderloin","g":150},{"slug":"potato","g":250},{"slug":"kale","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['steakpotato']::text[],'1. Kook de aardappel volgens de verpakking.
2. Bak de varkenshaas in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok boerenkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the potato per the package.
2. Pan-fry the pork tenderloin in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the kale until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('pork_with_potato_bok_choy','Varkenshaas met aardappel & paksoi','Pork with potato & bok choy',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"pork_tenderloin","g":150},{"slug":"potato","g":250},{"slug":"bok_choy","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['steakpotato']::text[],'1. Kook de aardappel volgens de verpakking.
2. Bak de varkenshaas in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok paksoi beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the potato per the package.
2. Pan-fry the pork tenderloin in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the bok choy until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('pork_with_pasta_broccoli','Varkenshaas met pasta & broccoli','Pork with pasta & broccoli',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"pork_tenderloin","g":150},{"slug":"pasta_dry","g":80},{"slug":"broccoli","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['pastabol']::text[],'1. Kook de volkoren pasta (droog) volgens de verpakking.
2. Bak de varkenshaas in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok broccoli beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat pasta (dry) per the package.
2. Pan-fry the pork tenderloin in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the broccoli until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('pork_with_pasta_green_beans','Varkenshaas met pasta & sperziebonen','Pork with pasta & green beans',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"pork_tenderloin","g":150},{"slug":"pasta_dry","g":80},{"slug":"green_beans","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['pastabol']::text[],'1. Kook de volkoren pasta (droog) volgens de verpakking.
2. Bak de varkenshaas in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok sperziebonen beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat pasta (dry) per the package.
2. Pan-fry the pork tenderloin in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the green beans until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('pork_with_pasta_spinach','Varkenshaas met pasta & spinazie','Pork with pasta & spinach',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"pork_tenderloin","g":150},{"slug":"pasta_dry","g":80},{"slug":"spinach","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['pastabol']::text[],'1. Kook de volkoren pasta (droog) volgens de verpakking.
2. Bak de varkenshaas in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok spinazie beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat pasta (dry) per the package.
2. Pan-fry the pork tenderloin in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the spinach until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('pork_with_pasta_asparagus','Varkenshaas met pasta & asperges','Pork with pasta & asparagus',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"pork_tenderloin","g":150},{"slug":"pasta_dry","g":80},{"slug":"asparagus","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['pastabol']::text[],'1. Kook de volkoren pasta (droog) volgens de verpakking.
2. Bak de varkenshaas in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok asperges beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat pasta (dry) per the package.
2. Pan-fry the pork tenderloin in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the asparagus until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('pork_with_pasta_zucchini','Varkenshaas met pasta & courgette','Pork with pasta & zucchini',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"pork_tenderloin","g":150},{"slug":"pasta_dry","g":80},{"slug":"zucchini","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['pastabol']::text[],'1. Kook de volkoren pasta (droog) volgens de verpakking.
2. Bak de varkenshaas in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok courgette beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat pasta (dry) per the package.
2. Pan-fry the pork tenderloin in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the zucchini until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('pork_with_pasta_stir_fry_veg','Varkenshaas met pasta & wokgroente','Pork with pasta & stir-fry veg',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"pork_tenderloin","g":150},{"slug":"pasta_dry","g":80},{"slug":"mixed_veg","g":150},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['pastabol']::text[],'1. Kook de volkoren pasta (droog) volgens de verpakking.
2. Bak de varkenshaas in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok wokgroente beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat pasta (dry) per the package.
2. Pan-fry the pork tenderloin in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the stir-fry veg until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('pork_with_pasta_mushrooms','Varkenshaas met pasta & champignons','Pork with pasta & mushrooms',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"pork_tenderloin","g":150},{"slug":"pasta_dry","g":80},{"slug":"mushroom","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['pastabol']::text[],'1. Kook de volkoren pasta (droog) volgens de verpakking.
2. Bak de varkenshaas in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok champignons beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat pasta (dry) per the package.
2. Pan-fry the pork tenderloin in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the mushrooms until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('pork_with_pasta_carrot','Varkenshaas met pasta & wortel','Pork with pasta & carrot',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"pork_tenderloin","g":150},{"slug":"pasta_dry","g":80},{"slug":"carrot","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['pastabol']::text[],'1. Kook de volkoren pasta (droog) volgens de verpakking.
2. Bak de varkenshaas in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok wortel beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat pasta (dry) per the package.
2. Pan-fry the pork tenderloin in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the carrot until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('pork_with_pasta_peas','Varkenshaas met pasta & doperwten','Pork with pasta & peas',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"pork_tenderloin","g":150},{"slug":"pasta_dry","g":80},{"slug":"peas","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['pastabol']::text[],'1. Kook de volkoren pasta (droog) volgens de verpakking.
2. Bak de varkenshaas in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok doperwten beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat pasta (dry) per the package.
2. Pan-fry the pork tenderloin in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the peas until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('pork_with_pasta_cauliflower','Varkenshaas met pasta & bloemkool','Pork with pasta & cauliflower',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"pork_tenderloin","g":150},{"slug":"pasta_dry","g":80},{"slug":"cauliflower","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['pastabol']::text[],'1. Kook de volkoren pasta (droog) volgens de verpakking.
2. Bak de varkenshaas in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok bloemkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat pasta (dry) per the package.
2. Pan-fry the pork tenderloin in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the cauliflower until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('pork_with_pasta_kale','Varkenshaas met pasta & boerenkool','Pork with pasta & kale',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"pork_tenderloin","g":150},{"slug":"pasta_dry","g":80},{"slug":"kale","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['pastabol']::text[],'1. Kook de volkoren pasta (droog) volgens de verpakking.
2. Bak de varkenshaas in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok boerenkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat pasta (dry) per the package.
2. Pan-fry the pork tenderloin in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the kale until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('pork_with_pasta_bok_choy','Varkenshaas met pasta & paksoi','Pork with pasta & bok choy',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"pork_tenderloin","g":150},{"slug":"pasta_dry","g":80},{"slug":"bok_choy","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['pastabol']::text[],'1. Kook de volkoren pasta (droog) volgens de verpakking.
2. Bak de varkenshaas in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok paksoi beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat pasta (dry) per the package.
2. Pan-fry the pork tenderloin in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the bok choy until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('pork_with_quinoa_broccoli','Varkenshaas met quinoa & broccoli','Pork with quinoa & broccoli',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"pork_tenderloin","g":150},{"slug":"quinoa_dry","g":70},{"slug":"broccoli","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de quinoa (droog) volgens de verpakking.
2. Bak de varkenshaas in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok broccoli beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the quinoa (dry) per the package.
2. Pan-fry the pork tenderloin in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the broccoli until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('pork_with_quinoa_green_beans','Varkenshaas met quinoa & sperziebonen','Pork with quinoa & green beans',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"pork_tenderloin","g":150},{"slug":"quinoa_dry","g":70},{"slug":"green_beans","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de quinoa (droog) volgens de verpakking.
2. Bak de varkenshaas in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok sperziebonen beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the quinoa (dry) per the package.
2. Pan-fry the pork tenderloin in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the green beans until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('pork_with_quinoa_spinach','Varkenshaas met quinoa & spinazie','Pork with quinoa & spinach',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"pork_tenderloin","g":150},{"slug":"quinoa_dry","g":70},{"slug":"spinach","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de quinoa (droog) volgens de verpakking.
2. Bak de varkenshaas in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok spinazie beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the quinoa (dry) per the package.
2. Pan-fry the pork tenderloin in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the spinach until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('pork_with_quinoa_asparagus','Varkenshaas met quinoa & asperges','Pork with quinoa & asparagus',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"pork_tenderloin","g":150},{"slug":"quinoa_dry","g":70},{"slug":"asparagus","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de quinoa (droog) volgens de verpakking.
2. Bak de varkenshaas in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok asperges beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the quinoa (dry) per the package.
2. Pan-fry the pork tenderloin in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the asparagus until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('pork_with_quinoa_zucchini','Varkenshaas met quinoa & courgette','Pork with quinoa & zucchini',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"pork_tenderloin","g":150},{"slug":"quinoa_dry","g":70},{"slug":"zucchini","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de quinoa (droog) volgens de verpakking.
2. Bak de varkenshaas in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok courgette beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the quinoa (dry) per the package.
2. Pan-fry the pork tenderloin in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the zucchini until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('pork_with_quinoa_stir_fry_veg','Varkenshaas met quinoa & wokgroente','Pork with quinoa & stir-fry veg',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"pork_tenderloin","g":150},{"slug":"quinoa_dry","g":70},{"slug":"mixed_veg","g":150},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de quinoa (droog) volgens de verpakking.
2. Bak de varkenshaas in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok wokgroente beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the quinoa (dry) per the package.
2. Pan-fry the pork tenderloin in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the stir-fry veg until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('pork_with_quinoa_mushrooms','Varkenshaas met quinoa & champignons','Pork with quinoa & mushrooms',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"pork_tenderloin","g":150},{"slug":"quinoa_dry","g":70},{"slug":"mushroom","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de quinoa (droog) volgens de verpakking.
2. Bak de varkenshaas in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok champignons beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the quinoa (dry) per the package.
2. Pan-fry the pork tenderloin in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the mushrooms until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('pork_with_quinoa_carrot','Varkenshaas met quinoa & wortel','Pork with quinoa & carrot',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"pork_tenderloin","g":150},{"slug":"quinoa_dry","g":70},{"slug":"carrot","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de quinoa (droog) volgens de verpakking.
2. Bak de varkenshaas in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok wortel beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the quinoa (dry) per the package.
2. Pan-fry the pork tenderloin in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the carrot until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('pork_with_quinoa_peas','Varkenshaas met quinoa & doperwten','Pork with quinoa & peas',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"pork_tenderloin","g":150},{"slug":"quinoa_dry","g":70},{"slug":"peas","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de quinoa (droog) volgens de verpakking.
2. Bak de varkenshaas in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok doperwten beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the quinoa (dry) per the package.
2. Pan-fry the pork tenderloin in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the peas until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('pork_with_quinoa_cauliflower','Varkenshaas met quinoa & bloemkool','Pork with quinoa & cauliflower',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"pork_tenderloin","g":150},{"slug":"quinoa_dry","g":70},{"slug":"cauliflower","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de quinoa (droog) volgens de verpakking.
2. Bak de varkenshaas in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok bloemkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the quinoa (dry) per the package.
2. Pan-fry the pork tenderloin in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the cauliflower until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('pork_with_quinoa_kale','Varkenshaas met quinoa & boerenkool','Pork with quinoa & kale',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"pork_tenderloin","g":150},{"slug":"quinoa_dry","g":70},{"slug":"kale","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de quinoa (droog) volgens de verpakking.
2. Bak de varkenshaas in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok boerenkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the quinoa (dry) per the package.
2. Pan-fry the pork tenderloin in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the kale until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('pork_with_quinoa_bok_choy','Varkenshaas met quinoa & paksoi','Pork with quinoa & bok choy',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"pork_tenderloin","g":150},{"slug":"quinoa_dry","g":70},{"slug":"bok_choy","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de quinoa (droog) volgens de verpakking.
2. Bak de varkenshaas in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok paksoi beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the quinoa (dry) per the package.
2. Pan-fry the pork tenderloin in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the bok choy until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('pork_with_noodles_broccoli','Varkenshaas met noedels & broccoli','Pork with noodles & broccoli',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"pork_tenderloin","g":150},{"slug":"noodles_dry","g":80},{"slug":"broccoli","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['woknoodles']::text[],'1. Kook de volkoren noedels (droog) volgens de verpakking.
2. Bak de varkenshaas in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok broccoli beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat noodles (dry) per the package.
2. Pan-fry the pork tenderloin in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the broccoli until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('pork_with_noodles_green_beans','Varkenshaas met noedels & sperziebonen','Pork with noodles & green beans',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"pork_tenderloin","g":150},{"slug":"noodles_dry","g":80},{"slug":"green_beans","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['woknoodles']::text[],'1. Kook de volkoren noedels (droog) volgens de verpakking.
2. Bak de varkenshaas in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok sperziebonen beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat noodles (dry) per the package.
2. Pan-fry the pork tenderloin in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the green beans until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('pork_with_noodles_spinach','Varkenshaas met noedels & spinazie','Pork with noodles & spinach',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"pork_tenderloin","g":150},{"slug":"noodles_dry","g":80},{"slug":"spinach","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['woknoodles']::text[],'1. Kook de volkoren noedels (droog) volgens de verpakking.
2. Bak de varkenshaas in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok spinazie beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat noodles (dry) per the package.
2. Pan-fry the pork tenderloin in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the spinach until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('pork_with_noodles_asparagus','Varkenshaas met noedels & asperges','Pork with noodles & asparagus',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"pork_tenderloin","g":150},{"slug":"noodles_dry","g":80},{"slug":"asparagus","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['woknoodles']::text[],'1. Kook de volkoren noedels (droog) volgens de verpakking.
2. Bak de varkenshaas in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok asperges beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat noodles (dry) per the package.
2. Pan-fry the pork tenderloin in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the asparagus until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('pork_with_noodles_zucchini','Varkenshaas met noedels & courgette','Pork with noodles & zucchini',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"pork_tenderloin","g":150},{"slug":"noodles_dry","g":80},{"slug":"zucchini","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['woknoodles']::text[],'1. Kook de volkoren noedels (droog) volgens de verpakking.
2. Bak de varkenshaas in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok courgette beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat noodles (dry) per the package.
2. Pan-fry the pork tenderloin in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the zucchini until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('pork_with_noodles_stir_fry_veg','Varkenshaas met noedels & wokgroente','Pork with noodles & stir-fry veg',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"pork_tenderloin","g":150},{"slug":"noodles_dry","g":80},{"slug":"mixed_veg","g":150},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['woknoodles']::text[],'1. Kook de volkoren noedels (droog) volgens de verpakking.
2. Bak de varkenshaas in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok wokgroente beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat noodles (dry) per the package.
2. Pan-fry the pork tenderloin in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the stir-fry veg until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('pork_with_noodles_mushrooms','Varkenshaas met noedels & champignons','Pork with noodles & mushrooms',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"pork_tenderloin","g":150},{"slug":"noodles_dry","g":80},{"slug":"mushroom","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['woknoodles']::text[],'1. Kook de volkoren noedels (droog) volgens de verpakking.
2. Bak de varkenshaas in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok champignons beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat noodles (dry) per the package.
2. Pan-fry the pork tenderloin in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the mushrooms until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('pork_with_noodles_carrot','Varkenshaas met noedels & wortel','Pork with noodles & carrot',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"pork_tenderloin","g":150},{"slug":"noodles_dry","g":80},{"slug":"carrot","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['woknoodles']::text[],'1. Kook de volkoren noedels (droog) volgens de verpakking.
2. Bak de varkenshaas in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok wortel beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat noodles (dry) per the package.
2. Pan-fry the pork tenderloin in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the carrot until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('pork_with_noodles_peas','Varkenshaas met noedels & doperwten','Pork with noodles & peas',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"pork_tenderloin","g":150},{"slug":"noodles_dry","g":80},{"slug":"peas","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['woknoodles']::text[],'1. Kook de volkoren noedels (droog) volgens de verpakking.
2. Bak de varkenshaas in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok doperwten beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat noodles (dry) per the package.
2. Pan-fry the pork tenderloin in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the peas until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('pork_with_noodles_cauliflower','Varkenshaas met noedels & bloemkool','Pork with noodles & cauliflower',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"pork_tenderloin","g":150},{"slug":"noodles_dry","g":80},{"slug":"cauliflower","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['woknoodles']::text[],'1. Kook de volkoren noedels (droog) volgens de verpakking.
2. Bak de varkenshaas in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok bloemkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat noodles (dry) per the package.
2. Pan-fry the pork tenderloin in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the cauliflower until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('pork_with_noodles_kale','Varkenshaas met noedels & boerenkool','Pork with noodles & kale',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"pork_tenderloin","g":150},{"slug":"noodles_dry","g":80},{"slug":"kale","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['woknoodles']::text[],'1. Kook de volkoren noedels (droog) volgens de verpakking.
2. Bak de varkenshaas in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok boerenkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat noodles (dry) per the package.
2. Pan-fry the pork tenderloin in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the kale until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('pork_with_noodles_bok_choy','Varkenshaas met noedels & paksoi','Pork with noodles & bok choy',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"pork_tenderloin","g":150},{"slug":"noodles_dry","g":80},{"slug":"bok_choy","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['woknoodles']::text[],'1. Kook de volkoren noedels (droog) volgens de verpakking.
2. Bak de varkenshaas in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok paksoi beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat noodles (dry) per the package.
2. Pan-fry the pork tenderloin in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the bok choy until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('pork_with_couscous_broccoli','Varkenshaas met couscous & broccoli','Pork with couscous & broccoli',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"pork_tenderloin","g":150},{"slug":"couscous_dry","g":70},{"slug":"broccoli","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de volkoren couscous (droog) volgens de verpakking.
2. Bak de varkenshaas in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok broccoli beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat couscous (dry) per the package.
2. Pan-fry the pork tenderloin in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the broccoli until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('pork_with_couscous_green_beans','Varkenshaas met couscous & sperziebonen','Pork with couscous & green beans',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"pork_tenderloin","g":150},{"slug":"couscous_dry","g":70},{"slug":"green_beans","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de volkoren couscous (droog) volgens de verpakking.
2. Bak de varkenshaas in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok sperziebonen beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat couscous (dry) per the package.
2. Pan-fry the pork tenderloin in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the green beans until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('pork_with_couscous_spinach','Varkenshaas met couscous & spinazie','Pork with couscous & spinach',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"pork_tenderloin","g":150},{"slug":"couscous_dry","g":70},{"slug":"spinach","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de volkoren couscous (droog) volgens de verpakking.
2. Bak de varkenshaas in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok spinazie beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat couscous (dry) per the package.
2. Pan-fry the pork tenderloin in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the spinach until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('pork_with_couscous_asparagus','Varkenshaas met couscous & asperges','Pork with couscous & asparagus',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"pork_tenderloin","g":150},{"slug":"couscous_dry","g":70},{"slug":"asparagus","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de volkoren couscous (droog) volgens de verpakking.
2. Bak de varkenshaas in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok asperges beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat couscous (dry) per the package.
2. Pan-fry the pork tenderloin in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the asparagus until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('pork_with_couscous_zucchini','Varkenshaas met couscous & courgette','Pork with couscous & zucchini',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"pork_tenderloin","g":150},{"slug":"couscous_dry","g":70},{"slug":"zucchini","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de volkoren couscous (droog) volgens de verpakking.
2. Bak de varkenshaas in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok courgette beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat couscous (dry) per the package.
2. Pan-fry the pork tenderloin in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the zucchini until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('pork_with_couscous_stir_fry_veg','Varkenshaas met couscous & wokgroente','Pork with couscous & stir-fry veg',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"pork_tenderloin","g":150},{"slug":"couscous_dry","g":70},{"slug":"mixed_veg","g":150},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de volkoren couscous (droog) volgens de verpakking.
2. Bak de varkenshaas in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok wokgroente beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat couscous (dry) per the package.
2. Pan-fry the pork tenderloin in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the stir-fry veg until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('pork_with_couscous_mushrooms','Varkenshaas met couscous & champignons','Pork with couscous & mushrooms',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"pork_tenderloin","g":150},{"slug":"couscous_dry","g":70},{"slug":"mushroom","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de volkoren couscous (droog) volgens de verpakking.
2. Bak de varkenshaas in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok champignons beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat couscous (dry) per the package.
2. Pan-fry the pork tenderloin in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the mushrooms until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('pork_with_couscous_carrot','Varkenshaas met couscous & wortel','Pork with couscous & carrot',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"pork_tenderloin","g":150},{"slug":"couscous_dry","g":70},{"slug":"carrot","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de volkoren couscous (droog) volgens de verpakking.
2. Bak de varkenshaas in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok wortel beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat couscous (dry) per the package.
2. Pan-fry the pork tenderloin in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the carrot until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('pork_with_couscous_peas','Varkenshaas met couscous & doperwten','Pork with couscous & peas',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"pork_tenderloin","g":150},{"slug":"couscous_dry","g":70},{"slug":"peas","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de volkoren couscous (droog) volgens de verpakking.
2. Bak de varkenshaas in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok doperwten beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat couscous (dry) per the package.
2. Pan-fry the pork tenderloin in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the peas until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('pork_with_couscous_cauliflower','Varkenshaas met couscous & bloemkool','Pork with couscous & cauliflower',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"pork_tenderloin","g":150},{"slug":"couscous_dry","g":70},{"slug":"cauliflower","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de volkoren couscous (droog) volgens de verpakking.
2. Bak de varkenshaas in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok bloemkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat couscous (dry) per the package.
2. Pan-fry the pork tenderloin in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the cauliflower until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('pork_with_couscous_kale','Varkenshaas met couscous & boerenkool','Pork with couscous & kale',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"pork_tenderloin","g":150},{"slug":"couscous_dry","g":70},{"slug":"kale","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de volkoren couscous (droog) volgens de verpakking.
2. Bak de varkenshaas in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok boerenkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat couscous (dry) per the package.
2. Pan-fry the pork tenderloin in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the kale until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('pork_with_couscous_bok_choy','Varkenshaas met couscous & paksoi','Pork with couscous & bok choy',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"pork_tenderloin","g":150},{"slug":"couscous_dry","g":70},{"slug":"bok_choy","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de volkoren couscous (droog) volgens de verpakking.
2. Bak de varkenshaas in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok paksoi beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat couscous (dry) per the package.
2. Pan-fry the pork tenderloin in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the bok choy until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('pork_with_bulgur_broccoli','Varkenshaas met bulgur & broccoli','Pork with bulgur & broccoli',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"pork_tenderloin","g":150},{"slug":"bulgur_dry","g":70},{"slug":"broccoli","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de bulgur (droog) volgens de verpakking.
2. Bak de varkenshaas in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok broccoli beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the bulgur (dry) per the package.
2. Pan-fry the pork tenderloin in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the broccoli until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('pork_with_bulgur_green_beans','Varkenshaas met bulgur & sperziebonen','Pork with bulgur & green beans',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"pork_tenderloin","g":150},{"slug":"bulgur_dry","g":70},{"slug":"green_beans","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de bulgur (droog) volgens de verpakking.
2. Bak de varkenshaas in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok sperziebonen beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the bulgur (dry) per the package.
2. Pan-fry the pork tenderloin in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the green beans until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('pork_with_bulgur_spinach','Varkenshaas met bulgur & spinazie','Pork with bulgur & spinach',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"pork_tenderloin","g":150},{"slug":"bulgur_dry","g":70},{"slug":"spinach","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de bulgur (droog) volgens de verpakking.
2. Bak de varkenshaas in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok spinazie beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the bulgur (dry) per the package.
2. Pan-fry the pork tenderloin in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the spinach until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('pork_with_bulgur_asparagus','Varkenshaas met bulgur & asperges','Pork with bulgur & asparagus',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"pork_tenderloin","g":150},{"slug":"bulgur_dry","g":70},{"slug":"asparagus","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de bulgur (droog) volgens de verpakking.
2. Bak de varkenshaas in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok asperges beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the bulgur (dry) per the package.
2. Pan-fry the pork tenderloin in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the asparagus until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('pork_with_bulgur_zucchini','Varkenshaas met bulgur & courgette','Pork with bulgur & zucchini',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"pork_tenderloin","g":150},{"slug":"bulgur_dry","g":70},{"slug":"zucchini","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de bulgur (droog) volgens de verpakking.
2. Bak de varkenshaas in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok courgette beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the bulgur (dry) per the package.
2. Pan-fry the pork tenderloin in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the zucchini until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('pork_with_bulgur_stir_fry_veg','Varkenshaas met bulgur & wokgroente','Pork with bulgur & stir-fry veg',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"pork_tenderloin","g":150},{"slug":"bulgur_dry","g":70},{"slug":"mixed_veg","g":150},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de bulgur (droog) volgens de verpakking.
2. Bak de varkenshaas in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok wokgroente beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the bulgur (dry) per the package.
2. Pan-fry the pork tenderloin in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the stir-fry veg until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('pork_with_bulgur_mushrooms','Varkenshaas met bulgur & champignons','Pork with bulgur & mushrooms',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"pork_tenderloin","g":150},{"slug":"bulgur_dry","g":70},{"slug":"mushroom","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de bulgur (droog) volgens de verpakking.
2. Bak de varkenshaas in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok champignons beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the bulgur (dry) per the package.
2. Pan-fry the pork tenderloin in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the mushrooms until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('pork_with_bulgur_carrot','Varkenshaas met bulgur & wortel','Pork with bulgur & carrot',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"pork_tenderloin","g":150},{"slug":"bulgur_dry","g":70},{"slug":"carrot","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de bulgur (droog) volgens de verpakking.
2. Bak de varkenshaas in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok wortel beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the bulgur (dry) per the package.
2. Pan-fry the pork tenderloin in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the carrot until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('pork_with_bulgur_peas','Varkenshaas met bulgur & doperwten','Pork with bulgur & peas',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"pork_tenderloin","g":150},{"slug":"bulgur_dry","g":70},{"slug":"peas","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de bulgur (droog) volgens de verpakking.
2. Bak de varkenshaas in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok doperwten beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the bulgur (dry) per the package.
2. Pan-fry the pork tenderloin in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the peas until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('pork_with_bulgur_cauliflower','Varkenshaas met bulgur & bloemkool','Pork with bulgur & cauliflower',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"pork_tenderloin","g":150},{"slug":"bulgur_dry","g":70},{"slug":"cauliflower","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de bulgur (droog) volgens de verpakking.
2. Bak de varkenshaas in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok bloemkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the bulgur (dry) per the package.
2. Pan-fry the pork tenderloin in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the cauliflower until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('pork_with_bulgur_kale','Varkenshaas met bulgur & boerenkool','Pork with bulgur & kale',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"pork_tenderloin","g":150},{"slug":"bulgur_dry","g":70},{"slug":"kale","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de bulgur (droog) volgens de verpakking.
2. Bak de varkenshaas in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok boerenkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the bulgur (dry) per the package.
2. Pan-fry the pork tenderloin in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the kale until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('pork_with_bulgur_bok_choy','Varkenshaas met bulgur & paksoi','Pork with bulgur & bok choy',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"pork_tenderloin","g":150},{"slug":"bulgur_dry","g":70},{"slug":"bok_choy","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de bulgur (droog) volgens de verpakking.
2. Bak de varkenshaas in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok paksoi beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the bulgur (dry) per the package.
2. Pan-fry the pork tenderloin in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the bok choy until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('pork_with_basmati_rice_broccoli','Varkenshaas met basmatirijst & broccoli','Pork with basmati rice & broccoli',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"pork_tenderloin","g":150},{"slug":"basmati_dry","g":70},{"slug":"broccoli","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de basmatirijst (droog) volgens de verpakking.
2. Bak de varkenshaas in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok broccoli beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the basmati rice (dry) per the package.
2. Pan-fry the pork tenderloin in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the broccoli until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('pork_with_basmati_rice_green_beans','Varkenshaas met basmatirijst & sperziebonen','Pork with basmati rice & green beans',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"pork_tenderloin","g":150},{"slug":"basmati_dry","g":70},{"slug":"green_beans","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de basmatirijst (droog) volgens de verpakking.
2. Bak de varkenshaas in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok sperziebonen beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the basmati rice (dry) per the package.
2. Pan-fry the pork tenderloin in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the green beans until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('pork_with_basmati_rice_spinach','Varkenshaas met basmatirijst & spinazie','Pork with basmati rice & spinach',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"pork_tenderloin","g":150},{"slug":"basmati_dry","g":70},{"slug":"spinach","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de basmatirijst (droog) volgens de verpakking.
2. Bak de varkenshaas in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok spinazie beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the basmati rice (dry) per the package.
2. Pan-fry the pork tenderloin in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the spinach until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('pork_with_basmati_rice_asparagus','Varkenshaas met basmatirijst & asperges','Pork with basmati rice & asparagus',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"pork_tenderloin","g":150},{"slug":"basmati_dry","g":70},{"slug":"asparagus","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de basmatirijst (droog) volgens de verpakking.
2. Bak de varkenshaas in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok asperges beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the basmati rice (dry) per the package.
2. Pan-fry the pork tenderloin in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the asparagus until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('pork_with_basmati_rice_zucchini','Varkenshaas met basmatirijst & courgette','Pork with basmati rice & zucchini',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"pork_tenderloin","g":150},{"slug":"basmati_dry","g":70},{"slug":"zucchini","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de basmatirijst (droog) volgens de verpakking.
2. Bak de varkenshaas in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok courgette beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the basmati rice (dry) per the package.
2. Pan-fry the pork tenderloin in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the zucchini until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('pork_with_basmati_rice_stir_fry_veg','Varkenshaas met basmatirijst & wokgroente','Pork with basmati rice & stir-fry veg',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"pork_tenderloin","g":150},{"slug":"basmati_dry","g":70},{"slug":"mixed_veg","g":150},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de basmatirijst (droog) volgens de verpakking.
2. Bak de varkenshaas in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok wokgroente beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the basmati rice (dry) per the package.
2. Pan-fry the pork tenderloin in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the stir-fry veg until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('pork_with_basmati_rice_mushrooms','Varkenshaas met basmatirijst & champignons','Pork with basmati rice & mushrooms',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"pork_tenderloin","g":150},{"slug":"basmati_dry","g":70},{"slug":"mushroom","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de basmatirijst (droog) volgens de verpakking.
2. Bak de varkenshaas in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok champignons beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the basmati rice (dry) per the package.
2. Pan-fry the pork tenderloin in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the mushrooms until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('pork_with_basmati_rice_carrot','Varkenshaas met basmatirijst & wortel','Pork with basmati rice & carrot',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"pork_tenderloin","g":150},{"slug":"basmati_dry","g":70},{"slug":"carrot","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de basmatirijst (droog) volgens de verpakking.
2. Bak de varkenshaas in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok wortel beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the basmati rice (dry) per the package.
2. Pan-fry the pork tenderloin in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the carrot until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('pork_with_basmati_rice_peas','Varkenshaas met basmatirijst & doperwten','Pork with basmati rice & peas',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"pork_tenderloin","g":150},{"slug":"basmati_dry","g":70},{"slug":"peas","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de basmatirijst (droog) volgens de verpakking.
2. Bak de varkenshaas in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok doperwten beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the basmati rice (dry) per the package.
2. Pan-fry the pork tenderloin in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the peas until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('pork_with_basmati_rice_cauliflower','Varkenshaas met basmatirijst & bloemkool','Pork with basmati rice & cauliflower',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"pork_tenderloin","g":150},{"slug":"basmati_dry","g":70},{"slug":"cauliflower","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de basmatirijst (droog) volgens de verpakking.
2. Bak de varkenshaas in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok bloemkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the basmati rice (dry) per the package.
2. Pan-fry the pork tenderloin in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the cauliflower until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('pork_with_basmati_rice_kale','Varkenshaas met basmatirijst & boerenkool','Pork with basmati rice & kale',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"pork_tenderloin","g":150},{"slug":"basmati_dry","g":70},{"slug":"kale","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de basmatirijst (droog) volgens de verpakking.
2. Bak de varkenshaas in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok boerenkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the basmati rice (dry) per the package.
2. Pan-fry the pork tenderloin in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the kale until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('pork_with_basmati_rice_bok_choy','Varkenshaas met basmatirijst & paksoi','Pork with basmati rice & bok choy',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"pork_tenderloin","g":150},{"slug":"basmati_dry","g":70},{"slug":"bok_choy","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de basmatirijst (droog) volgens de verpakking.
2. Bak de varkenshaas in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok paksoi beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the basmati rice (dry) per the package.
2. Pan-fry the pork tenderloin in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the bok choy until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('shrimp_with_rice_broccoli','Garnalen met rijst & broccoli','Shrimp with rice & broccoli',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"shrimp","g":150},{"slug":"rice_dry","g":70},{"slug":"broccoli","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Kook de witte rijst (droog) volgens de verpakking.
2. Bak of pocheer de garnalen kort tot net gaar; kruid met peper en zout.
3. Stoom of wok broccoli beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the white rice (dry) per the package.
2. Sear or poach the shrimp until just done; season with salt and pepper.
3. Steam or stir-fry the broccoli until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('shrimp_with_rice_green_beans','Garnalen met rijst & sperziebonen','Shrimp with rice & green beans',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"shrimp","g":150},{"slug":"rice_dry","g":70},{"slug":"green_beans","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Kook de witte rijst (droog) volgens de verpakking.
2. Bak of pocheer de garnalen kort tot net gaar; kruid met peper en zout.
3. Stoom of wok sperziebonen beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the white rice (dry) per the package.
2. Sear or poach the shrimp until just done; season with salt and pepper.
3. Steam or stir-fry the green beans until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('shrimp_with_rice_spinach','Garnalen met rijst & spinazie','Shrimp with rice & spinach',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"shrimp","g":150},{"slug":"rice_dry","g":70},{"slug":"spinach","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Kook de witte rijst (droog) volgens de verpakking.
2. Bak of pocheer de garnalen kort tot net gaar; kruid met peper en zout.
3. Stoom of wok spinazie beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the white rice (dry) per the package.
2. Sear or poach the shrimp until just done; season with salt and pepper.
3. Steam or stir-fry the spinach until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('shrimp_with_rice_asparagus','Garnalen met rijst & asperges','Shrimp with rice & asparagus',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"shrimp","g":150},{"slug":"rice_dry","g":70},{"slug":"asparagus","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Kook de witte rijst (droog) volgens de verpakking.
2. Bak of pocheer de garnalen kort tot net gaar; kruid met peper en zout.
3. Stoom of wok asperges beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the white rice (dry) per the package.
2. Sear or poach the shrimp until just done; season with salt and pepper.
3. Steam or stir-fry the asparagus until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('shrimp_with_rice_zucchini','Garnalen met rijst & courgette','Shrimp with rice & zucchini',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"shrimp","g":150},{"slug":"rice_dry","g":70},{"slug":"zucchini","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Kook de witte rijst (droog) volgens de verpakking.
2. Bak of pocheer de garnalen kort tot net gaar; kruid met peper en zout.
3. Stoom of wok courgette beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the white rice (dry) per the package.
2. Sear or poach the shrimp until just done; season with salt and pepper.
3. Steam or stir-fry the zucchini until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('shrimp_with_rice_stir_fry_veg','Garnalen met rijst & wokgroente','Shrimp with rice & stir-fry veg',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"shrimp","g":150},{"slug":"rice_dry","g":70},{"slug":"mixed_veg","g":150},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Kook de witte rijst (droog) volgens de verpakking.
2. Bak of pocheer de garnalen kort tot net gaar; kruid met peper en zout.
3. Stoom of wok wokgroente beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the white rice (dry) per the package.
2. Sear or poach the shrimp until just done; season with salt and pepper.
3. Steam or stir-fry the stir-fry veg until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('shrimp_with_rice_mushrooms','Garnalen met rijst & champignons','Shrimp with rice & mushrooms',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"shrimp","g":150},{"slug":"rice_dry","g":70},{"slug":"mushroom","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Kook de witte rijst (droog) volgens de verpakking.
2. Bak of pocheer de garnalen kort tot net gaar; kruid met peper en zout.
3. Stoom of wok champignons beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the white rice (dry) per the package.
2. Sear or poach the shrimp until just done; season with salt and pepper.
3. Steam or stir-fry the mushrooms until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('shrimp_with_rice_carrot','Garnalen met rijst & wortel','Shrimp with rice & carrot',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"shrimp","g":150},{"slug":"rice_dry","g":70},{"slug":"carrot","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Kook de witte rijst (droog) volgens de verpakking.
2. Bak of pocheer de garnalen kort tot net gaar; kruid met peper en zout.
3. Stoom of wok wortel beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the white rice (dry) per the package.
2. Sear or poach the shrimp until just done; season with salt and pepper.
3. Steam or stir-fry the carrot until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('shrimp_with_rice_peas','Garnalen met rijst & doperwten','Shrimp with rice & peas',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"shrimp","g":150},{"slug":"rice_dry","g":70},{"slug":"peas","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Kook de witte rijst (droog) volgens de verpakking.
2. Bak of pocheer de garnalen kort tot net gaar; kruid met peper en zout.
3. Stoom of wok doperwten beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the white rice (dry) per the package.
2. Sear or poach the shrimp until just done; season with salt and pepper.
3. Steam or stir-fry the peas until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('shrimp_with_rice_cauliflower','Garnalen met rijst & bloemkool','Shrimp with rice & cauliflower',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"shrimp","g":150},{"slug":"rice_dry","g":70},{"slug":"cauliflower","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Kook de witte rijst (droog) volgens de verpakking.
2. Bak of pocheer de garnalen kort tot net gaar; kruid met peper en zout.
3. Stoom of wok bloemkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the white rice (dry) per the package.
2. Sear or poach the shrimp until just done; season with salt and pepper.
3. Steam or stir-fry the cauliflower until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('shrimp_with_rice_kale','Garnalen met rijst & boerenkool','Shrimp with rice & kale',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"shrimp","g":150},{"slug":"rice_dry","g":70},{"slug":"kale","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Kook de witte rijst (droog) volgens de verpakking.
2. Bak of pocheer de garnalen kort tot net gaar; kruid met peper en zout.
3. Stoom of wok boerenkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the white rice (dry) per the package.
2. Sear or poach the shrimp until just done; season with salt and pepper.
3. Steam or stir-fry the kale until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('shrimp_with_rice_bok_choy','Garnalen met rijst & paksoi','Shrimp with rice & bok choy',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"shrimp","g":150},{"slug":"rice_dry","g":70},{"slug":"bok_choy","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Kook de witte rijst (droog) volgens de verpakking.
2. Bak of pocheer de garnalen kort tot net gaar; kruid met peper en zout.
3. Stoom of wok paksoi beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the white rice (dry) per the package.
2. Sear or poach the shrimp until just done; season with salt and pepper.
3. Steam or stir-fry the bok choy until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('shrimp_with_sweet_potato_broccoli','Garnalen met zoete aardappel & broccoli','Shrimp with sweet potato & broccoli',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"shrimp","g":150},{"slug":"sweet_potato","g":200},{"slug":"broccoli","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de zoete aardappel volgens de verpakking.
2. Bak of pocheer de garnalen kort tot net gaar; kruid met peper en zout.
3. Stoom of wok broccoli beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the sweet potato per the package.
2. Sear or poach the shrimp until just done; season with salt and pepper.
3. Steam or stir-fry the broccoli until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('shrimp_with_sweet_potato_green_beans','Garnalen met zoete aardappel & sperziebonen','Shrimp with sweet potato & green beans',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"shrimp","g":150},{"slug":"sweet_potato","g":200},{"slug":"green_beans","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de zoete aardappel volgens de verpakking.
2. Bak of pocheer de garnalen kort tot net gaar; kruid met peper en zout.
3. Stoom of wok sperziebonen beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the sweet potato per the package.
2. Sear or poach the shrimp until just done; season with salt and pepper.
3. Steam or stir-fry the green beans until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('shrimp_with_sweet_potato_spinach','Garnalen met zoete aardappel & spinazie','Shrimp with sweet potato & spinach',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"shrimp","g":150},{"slug":"sweet_potato","g":200},{"slug":"spinach","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de zoete aardappel volgens de verpakking.
2. Bak of pocheer de garnalen kort tot net gaar; kruid met peper en zout.
3. Stoom of wok spinazie beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the sweet potato per the package.
2. Sear or poach the shrimp until just done; season with salt and pepper.
3. Steam or stir-fry the spinach until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('shrimp_with_sweet_potato_asparagus','Garnalen met zoete aardappel & asperges','Shrimp with sweet potato & asparagus',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"shrimp","g":150},{"slug":"sweet_potato","g":200},{"slug":"asparagus","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de zoete aardappel volgens de verpakking.
2. Bak of pocheer de garnalen kort tot net gaar; kruid met peper en zout.
3. Stoom of wok asperges beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the sweet potato per the package.
2. Sear or poach the shrimp until just done; season with salt and pepper.
3. Steam or stir-fry the asparagus until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('shrimp_with_sweet_potato_zucchini','Garnalen met zoete aardappel & courgette','Shrimp with sweet potato & zucchini',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"shrimp","g":150},{"slug":"sweet_potato","g":200},{"slug":"zucchini","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de zoete aardappel volgens de verpakking.
2. Bak of pocheer de garnalen kort tot net gaar; kruid met peper en zout.
3. Stoom of wok courgette beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the sweet potato per the package.
2. Sear or poach the shrimp until just done; season with salt and pepper.
3. Steam or stir-fry the zucchini until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('shrimp_with_sweet_potato_stir_fry_veg','Garnalen met zoete aardappel & wokgroente','Shrimp with sweet potato & stir-fry veg',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"shrimp","g":150},{"slug":"sweet_potato","g":200},{"slug":"mixed_veg","g":150},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de zoete aardappel volgens de verpakking.
2. Bak of pocheer de garnalen kort tot net gaar; kruid met peper en zout.
3. Stoom of wok wokgroente beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the sweet potato per the package.
2. Sear or poach the shrimp until just done; season with salt and pepper.
3. Steam or stir-fry the stir-fry veg until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('shrimp_with_sweet_potato_mushrooms','Garnalen met zoete aardappel & champignons','Shrimp with sweet potato & mushrooms',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"shrimp","g":150},{"slug":"sweet_potato","g":200},{"slug":"mushroom","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de zoete aardappel volgens de verpakking.
2. Bak of pocheer de garnalen kort tot net gaar; kruid met peper en zout.
3. Stoom of wok champignons beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the sweet potato per the package.
2. Sear or poach the shrimp until just done; season with salt and pepper.
3. Steam or stir-fry the mushrooms until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('shrimp_with_sweet_potato_carrot','Garnalen met zoete aardappel & wortel','Shrimp with sweet potato & carrot',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"shrimp","g":150},{"slug":"sweet_potato","g":200},{"slug":"carrot","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de zoete aardappel volgens de verpakking.
2. Bak of pocheer de garnalen kort tot net gaar; kruid met peper en zout.
3. Stoom of wok wortel beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the sweet potato per the package.
2. Sear or poach the shrimp until just done; season with salt and pepper.
3. Steam or stir-fry the carrot until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('shrimp_with_sweet_potato_peas','Garnalen met zoete aardappel & doperwten','Shrimp with sweet potato & peas',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"shrimp","g":150},{"slug":"sweet_potato","g":200},{"slug":"peas","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de zoete aardappel volgens de verpakking.
2. Bak of pocheer de garnalen kort tot net gaar; kruid met peper en zout.
3. Stoom of wok doperwten beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the sweet potato per the package.
2. Sear or poach the shrimp until just done; season with salt and pepper.
3. Steam or stir-fry the peas until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('shrimp_with_sweet_potato_cauliflower','Garnalen met zoete aardappel & bloemkool','Shrimp with sweet potato & cauliflower',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"shrimp","g":150},{"slug":"sweet_potato","g":200},{"slug":"cauliflower","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de zoete aardappel volgens de verpakking.
2. Bak of pocheer de garnalen kort tot net gaar; kruid met peper en zout.
3. Stoom of wok bloemkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the sweet potato per the package.
2. Sear or poach the shrimp until just done; season with salt and pepper.
3. Steam or stir-fry the cauliflower until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('shrimp_with_sweet_potato_kale','Garnalen met zoete aardappel & boerenkool','Shrimp with sweet potato & kale',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"shrimp","g":150},{"slug":"sweet_potato","g":200},{"slug":"kale","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de zoete aardappel volgens de verpakking.
2. Bak of pocheer de garnalen kort tot net gaar; kruid met peper en zout.
3. Stoom of wok boerenkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the sweet potato per the package.
2. Sear or poach the shrimp until just done; season with salt and pepper.
3. Steam or stir-fry the kale until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('shrimp_with_sweet_potato_bok_choy','Garnalen met zoete aardappel & paksoi','Shrimp with sweet potato & bok choy',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"shrimp","g":150},{"slug":"sweet_potato","g":200},{"slug":"bok_choy","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de zoete aardappel volgens de verpakking.
2. Bak of pocheer de garnalen kort tot net gaar; kruid met peper en zout.
3. Stoom of wok paksoi beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the sweet potato per the package.
2. Sear or poach the shrimp until just done; season with salt and pepper.
3. Steam or stir-fry the bok choy until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('shrimp_with_potato_broccoli','Garnalen met aardappel & broccoli','Shrimp with potato & broccoli',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"shrimp","g":150},{"slug":"potato","g":250},{"slug":"broccoli","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['steakpotato']::text[],'1. Kook de aardappel volgens de verpakking.
2. Bak of pocheer de garnalen kort tot net gaar; kruid met peper en zout.
3. Stoom of wok broccoli beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the potato per the package.
2. Sear or poach the shrimp until just done; season with salt and pepper.
3. Steam or stir-fry the broccoli until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('shrimp_with_potato_green_beans','Garnalen met aardappel & sperziebonen','Shrimp with potato & green beans',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"shrimp","g":150},{"slug":"potato","g":250},{"slug":"green_beans","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['steakpotato']::text[],'1. Kook de aardappel volgens de verpakking.
2. Bak of pocheer de garnalen kort tot net gaar; kruid met peper en zout.
3. Stoom of wok sperziebonen beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the potato per the package.
2. Sear or poach the shrimp until just done; season with salt and pepper.
3. Steam or stir-fry the green beans until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('shrimp_with_potato_spinach','Garnalen met aardappel & spinazie','Shrimp with potato & spinach',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"shrimp","g":150},{"slug":"potato","g":250},{"slug":"spinach","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['steakpotato']::text[],'1. Kook de aardappel volgens de verpakking.
2. Bak of pocheer de garnalen kort tot net gaar; kruid met peper en zout.
3. Stoom of wok spinazie beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the potato per the package.
2. Sear or poach the shrimp until just done; season with salt and pepper.
3. Steam or stir-fry the spinach until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('shrimp_with_potato_asparagus','Garnalen met aardappel & asperges','Shrimp with potato & asparagus',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"shrimp","g":150},{"slug":"potato","g":250},{"slug":"asparagus","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['steakpotato']::text[],'1. Kook de aardappel volgens de verpakking.
2. Bak of pocheer de garnalen kort tot net gaar; kruid met peper en zout.
3. Stoom of wok asperges beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the potato per the package.
2. Sear or poach the shrimp until just done; season with salt and pepper.
3. Steam or stir-fry the asparagus until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('shrimp_with_potato_zucchini','Garnalen met aardappel & courgette','Shrimp with potato & zucchini',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"shrimp","g":150},{"slug":"potato","g":250},{"slug":"zucchini","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['steakpotato']::text[],'1. Kook de aardappel volgens de verpakking.
2. Bak of pocheer de garnalen kort tot net gaar; kruid met peper en zout.
3. Stoom of wok courgette beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the potato per the package.
2. Sear or poach the shrimp until just done; season with salt and pepper.
3. Steam or stir-fry the zucchini until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('shrimp_with_potato_stir_fry_veg','Garnalen met aardappel & wokgroente','Shrimp with potato & stir-fry veg',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"shrimp","g":150},{"slug":"potato","g":250},{"slug":"mixed_veg","g":150},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['steakpotato']::text[],'1. Kook de aardappel volgens de verpakking.
2. Bak of pocheer de garnalen kort tot net gaar; kruid met peper en zout.
3. Stoom of wok wokgroente beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the potato per the package.
2. Sear or poach the shrimp until just done; season with salt and pepper.
3. Steam or stir-fry the stir-fry veg until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('shrimp_with_potato_mushrooms','Garnalen met aardappel & champignons','Shrimp with potato & mushrooms',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"shrimp","g":150},{"slug":"potato","g":250},{"slug":"mushroom","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['steakpotato']::text[],'1. Kook de aardappel volgens de verpakking.
2. Bak of pocheer de garnalen kort tot net gaar; kruid met peper en zout.
3. Stoom of wok champignons beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the potato per the package.
2. Sear or poach the shrimp until just done; season with salt and pepper.
3. Steam or stir-fry the mushrooms until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('shrimp_with_potato_carrot','Garnalen met aardappel & wortel','Shrimp with potato & carrot',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"shrimp","g":150},{"slug":"potato","g":250},{"slug":"carrot","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['steakpotato']::text[],'1. Kook de aardappel volgens de verpakking.
2. Bak of pocheer de garnalen kort tot net gaar; kruid met peper en zout.
3. Stoom of wok wortel beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the potato per the package.
2. Sear or poach the shrimp until just done; season with salt and pepper.
3. Steam or stir-fry the carrot until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('shrimp_with_potato_peas','Garnalen met aardappel & doperwten','Shrimp with potato & peas',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"shrimp","g":150},{"slug":"potato","g":250},{"slug":"peas","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['steakpotato']::text[],'1. Kook de aardappel volgens de verpakking.
2. Bak of pocheer de garnalen kort tot net gaar; kruid met peper en zout.
3. Stoom of wok doperwten beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the potato per the package.
2. Sear or poach the shrimp until just done; season with salt and pepper.
3. Steam or stir-fry the peas until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('shrimp_with_potato_cauliflower','Garnalen met aardappel & bloemkool','Shrimp with potato & cauliflower',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"shrimp","g":150},{"slug":"potato","g":250},{"slug":"cauliflower","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['steakpotato']::text[],'1. Kook de aardappel volgens de verpakking.
2. Bak of pocheer de garnalen kort tot net gaar; kruid met peper en zout.
3. Stoom of wok bloemkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the potato per the package.
2. Sear or poach the shrimp until just done; season with salt and pepper.
3. Steam or stir-fry the cauliflower until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('shrimp_with_potato_kale','Garnalen met aardappel & boerenkool','Shrimp with potato & kale',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"shrimp","g":150},{"slug":"potato","g":250},{"slug":"kale","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['steakpotato']::text[],'1. Kook de aardappel volgens de verpakking.
2. Bak of pocheer de garnalen kort tot net gaar; kruid met peper en zout.
3. Stoom of wok boerenkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the potato per the package.
2. Sear or poach the shrimp until just done; season with salt and pepper.
3. Steam or stir-fry the kale until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('shrimp_with_potato_bok_choy','Garnalen met aardappel & paksoi','Shrimp with potato & bok choy',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"shrimp","g":150},{"slug":"potato","g":250},{"slug":"bok_choy","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['steakpotato']::text[],'1. Kook de aardappel volgens de verpakking.
2. Bak of pocheer de garnalen kort tot net gaar; kruid met peper en zout.
3. Stoom of wok paksoi beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the potato per the package.
2. Sear or poach the shrimp until just done; season with salt and pepper.
3. Steam or stir-fry the bok choy until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('shrimp_with_pasta_broccoli','Garnalen met pasta & broccoli','Shrimp with pasta & broccoli',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"shrimp","g":150},{"slug":"pasta_dry","g":80},{"slug":"broccoli","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['pastabol']::text[],'1. Kook de volkoren pasta (droog) volgens de verpakking.
2. Bak of pocheer de garnalen kort tot net gaar; kruid met peper en zout.
3. Stoom of wok broccoli beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat pasta (dry) per the package.
2. Sear or poach the shrimp until just done; season with salt and pepper.
3. Steam or stir-fry the broccoli until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('shrimp_with_pasta_green_beans','Garnalen met pasta & sperziebonen','Shrimp with pasta & green beans',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"shrimp","g":150},{"slug":"pasta_dry","g":80},{"slug":"green_beans","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['pastabol']::text[],'1. Kook de volkoren pasta (droog) volgens de verpakking.
2. Bak of pocheer de garnalen kort tot net gaar; kruid met peper en zout.
3. Stoom of wok sperziebonen beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat pasta (dry) per the package.
2. Sear or poach the shrimp until just done; season with salt and pepper.
3. Steam or stir-fry the green beans until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('shrimp_with_pasta_spinach','Garnalen met pasta & spinazie','Shrimp with pasta & spinach',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"shrimp","g":150},{"slug":"pasta_dry","g":80},{"slug":"spinach","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['pastabol']::text[],'1. Kook de volkoren pasta (droog) volgens de verpakking.
2. Bak of pocheer de garnalen kort tot net gaar; kruid met peper en zout.
3. Stoom of wok spinazie beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat pasta (dry) per the package.
2. Sear or poach the shrimp until just done; season with salt and pepper.
3. Steam or stir-fry the spinach until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('shrimp_with_pasta_asparagus','Garnalen met pasta & asperges','Shrimp with pasta & asparagus',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"shrimp","g":150},{"slug":"pasta_dry","g":80},{"slug":"asparagus","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['pastabol']::text[],'1. Kook de volkoren pasta (droog) volgens de verpakking.
2. Bak of pocheer de garnalen kort tot net gaar; kruid met peper en zout.
3. Stoom of wok asperges beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat pasta (dry) per the package.
2. Sear or poach the shrimp until just done; season with salt and pepper.
3. Steam or stir-fry the asparagus until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('shrimp_with_pasta_zucchini','Garnalen met pasta & courgette','Shrimp with pasta & zucchini',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"shrimp","g":150},{"slug":"pasta_dry","g":80},{"slug":"zucchini","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['pastabol']::text[],'1. Kook de volkoren pasta (droog) volgens de verpakking.
2. Bak of pocheer de garnalen kort tot net gaar; kruid met peper en zout.
3. Stoom of wok courgette beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat pasta (dry) per the package.
2. Sear or poach the shrimp until just done; season with salt and pepper.
3. Steam or stir-fry the zucchini until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('shrimp_with_pasta_stir_fry_veg','Garnalen met pasta & wokgroente','Shrimp with pasta & stir-fry veg',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"shrimp","g":150},{"slug":"pasta_dry","g":80},{"slug":"mixed_veg","g":150},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['pastabol']::text[],'1. Kook de volkoren pasta (droog) volgens de verpakking.
2. Bak of pocheer de garnalen kort tot net gaar; kruid met peper en zout.
3. Stoom of wok wokgroente beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat pasta (dry) per the package.
2. Sear or poach the shrimp until just done; season with salt and pepper.
3. Steam or stir-fry the stir-fry veg until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('shrimp_with_pasta_mushrooms','Garnalen met pasta & champignons','Shrimp with pasta & mushrooms',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"shrimp","g":150},{"slug":"pasta_dry","g":80},{"slug":"mushroom","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['pastabol']::text[],'1. Kook de volkoren pasta (droog) volgens de verpakking.
2. Bak of pocheer de garnalen kort tot net gaar; kruid met peper en zout.
3. Stoom of wok champignons beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat pasta (dry) per the package.
2. Sear or poach the shrimp until just done; season with salt and pepper.
3. Steam or stir-fry the mushrooms until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('shrimp_with_pasta_carrot','Garnalen met pasta & wortel','Shrimp with pasta & carrot',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"shrimp","g":150},{"slug":"pasta_dry","g":80},{"slug":"carrot","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['pastabol']::text[],'1. Kook de volkoren pasta (droog) volgens de verpakking.
2. Bak of pocheer de garnalen kort tot net gaar; kruid met peper en zout.
3. Stoom of wok wortel beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat pasta (dry) per the package.
2. Sear or poach the shrimp until just done; season with salt and pepper.
3. Steam or stir-fry the carrot until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('shrimp_with_pasta_peas','Garnalen met pasta & doperwten','Shrimp with pasta & peas',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"shrimp","g":150},{"slug":"pasta_dry","g":80},{"slug":"peas","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['pastabol']::text[],'1. Kook de volkoren pasta (droog) volgens de verpakking.
2. Bak of pocheer de garnalen kort tot net gaar; kruid met peper en zout.
3. Stoom of wok doperwten beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat pasta (dry) per the package.
2. Sear or poach the shrimp until just done; season with salt and pepper.
3. Steam or stir-fry the peas until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('shrimp_with_pasta_cauliflower','Garnalen met pasta & bloemkool','Shrimp with pasta & cauliflower',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"shrimp","g":150},{"slug":"pasta_dry","g":80},{"slug":"cauliflower","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['pastabol']::text[],'1. Kook de volkoren pasta (droog) volgens de verpakking.
2. Bak of pocheer de garnalen kort tot net gaar; kruid met peper en zout.
3. Stoom of wok bloemkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat pasta (dry) per the package.
2. Sear or poach the shrimp until just done; season with salt and pepper.
3. Steam or stir-fry the cauliflower until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('shrimp_with_pasta_kale','Garnalen met pasta & boerenkool','Shrimp with pasta & kale',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"shrimp","g":150},{"slug":"pasta_dry","g":80},{"slug":"kale","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['pastabol']::text[],'1. Kook de volkoren pasta (droog) volgens de verpakking.
2. Bak of pocheer de garnalen kort tot net gaar; kruid met peper en zout.
3. Stoom of wok boerenkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat pasta (dry) per the package.
2. Sear or poach the shrimp until just done; season with salt and pepper.
3. Steam or stir-fry the kale until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('shrimp_with_pasta_bok_choy','Garnalen met pasta & paksoi','Shrimp with pasta & bok choy',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"shrimp","g":150},{"slug":"pasta_dry","g":80},{"slug":"bok_choy","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['pastabol']::text[],'1. Kook de volkoren pasta (droog) volgens de verpakking.
2. Bak of pocheer de garnalen kort tot net gaar; kruid met peper en zout.
3. Stoom of wok paksoi beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat pasta (dry) per the package.
2. Sear or poach the shrimp until just done; season with salt and pepper.
3. Steam or stir-fry the bok choy until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('shrimp_with_quinoa_broccoli','Garnalen met quinoa & broccoli','Shrimp with quinoa & broccoli',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"shrimp","g":150},{"slug":"quinoa_dry","g":70},{"slug":"broccoli","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de quinoa (droog) volgens de verpakking.
2. Bak of pocheer de garnalen kort tot net gaar; kruid met peper en zout.
3. Stoom of wok broccoli beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the quinoa (dry) per the package.
2. Sear or poach the shrimp until just done; season with salt and pepper.
3. Steam or stir-fry the broccoli until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('shrimp_with_quinoa_green_beans','Garnalen met quinoa & sperziebonen','Shrimp with quinoa & green beans',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"shrimp","g":150},{"slug":"quinoa_dry","g":70},{"slug":"green_beans","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de quinoa (droog) volgens de verpakking.
2. Bak of pocheer de garnalen kort tot net gaar; kruid met peper en zout.
3. Stoom of wok sperziebonen beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the quinoa (dry) per the package.
2. Sear or poach the shrimp until just done; season with salt and pepper.
3. Steam or stir-fry the green beans until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('shrimp_with_quinoa_spinach','Garnalen met quinoa & spinazie','Shrimp with quinoa & spinach',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"shrimp","g":150},{"slug":"quinoa_dry","g":70},{"slug":"spinach","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de quinoa (droog) volgens de verpakking.
2. Bak of pocheer de garnalen kort tot net gaar; kruid met peper en zout.
3. Stoom of wok spinazie beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the quinoa (dry) per the package.
2. Sear or poach the shrimp until just done; season with salt and pepper.
3. Steam or stir-fry the spinach until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('shrimp_with_quinoa_asparagus','Garnalen met quinoa & asperges','Shrimp with quinoa & asparagus',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"shrimp","g":150},{"slug":"quinoa_dry","g":70},{"slug":"asparagus","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de quinoa (droog) volgens de verpakking.
2. Bak of pocheer de garnalen kort tot net gaar; kruid met peper en zout.
3. Stoom of wok asperges beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the quinoa (dry) per the package.
2. Sear or poach the shrimp until just done; season with salt and pepper.
3. Steam or stir-fry the asparagus until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('shrimp_with_quinoa_zucchini','Garnalen met quinoa & courgette','Shrimp with quinoa & zucchini',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"shrimp","g":150},{"slug":"quinoa_dry","g":70},{"slug":"zucchini","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de quinoa (droog) volgens de verpakking.
2. Bak of pocheer de garnalen kort tot net gaar; kruid met peper en zout.
3. Stoom of wok courgette beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the quinoa (dry) per the package.
2. Sear or poach the shrimp until just done; season with salt and pepper.
3. Steam or stir-fry the zucchini until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('shrimp_with_quinoa_stir_fry_veg','Garnalen met quinoa & wokgroente','Shrimp with quinoa & stir-fry veg',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"shrimp","g":150},{"slug":"quinoa_dry","g":70},{"slug":"mixed_veg","g":150},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de quinoa (droog) volgens de verpakking.
2. Bak of pocheer de garnalen kort tot net gaar; kruid met peper en zout.
3. Stoom of wok wokgroente beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the quinoa (dry) per the package.
2. Sear or poach the shrimp until just done; season with salt and pepper.
3. Steam or stir-fry the stir-fry veg until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('shrimp_with_quinoa_mushrooms','Garnalen met quinoa & champignons','Shrimp with quinoa & mushrooms',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"shrimp","g":150},{"slug":"quinoa_dry","g":70},{"slug":"mushroom","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de quinoa (droog) volgens de verpakking.
2. Bak of pocheer de garnalen kort tot net gaar; kruid met peper en zout.
3. Stoom of wok champignons beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the quinoa (dry) per the package.
2. Sear or poach the shrimp until just done; season with salt and pepper.
3. Steam or stir-fry the mushrooms until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('shrimp_with_quinoa_carrot','Garnalen met quinoa & wortel','Shrimp with quinoa & carrot',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"shrimp","g":150},{"slug":"quinoa_dry","g":70},{"slug":"carrot","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de quinoa (droog) volgens de verpakking.
2. Bak of pocheer de garnalen kort tot net gaar; kruid met peper en zout.
3. Stoom of wok wortel beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the quinoa (dry) per the package.
2. Sear or poach the shrimp until just done; season with salt and pepper.
3. Steam or stir-fry the carrot until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('shrimp_with_quinoa_peas','Garnalen met quinoa & doperwten','Shrimp with quinoa & peas',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"shrimp","g":150},{"slug":"quinoa_dry","g":70},{"slug":"peas","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de quinoa (droog) volgens de verpakking.
2. Bak of pocheer de garnalen kort tot net gaar; kruid met peper en zout.
3. Stoom of wok doperwten beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the quinoa (dry) per the package.
2. Sear or poach the shrimp until just done; season with salt and pepper.
3. Steam or stir-fry the peas until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('shrimp_with_quinoa_cauliflower','Garnalen met quinoa & bloemkool','Shrimp with quinoa & cauliflower',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"shrimp","g":150},{"slug":"quinoa_dry","g":70},{"slug":"cauliflower","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de quinoa (droog) volgens de verpakking.
2. Bak of pocheer de garnalen kort tot net gaar; kruid met peper en zout.
3. Stoom of wok bloemkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the quinoa (dry) per the package.
2. Sear or poach the shrimp until just done; season with salt and pepper.
3. Steam or stir-fry the cauliflower until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('shrimp_with_quinoa_kale','Garnalen met quinoa & boerenkool','Shrimp with quinoa & kale',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"shrimp","g":150},{"slug":"quinoa_dry","g":70},{"slug":"kale","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de quinoa (droog) volgens de verpakking.
2. Bak of pocheer de garnalen kort tot net gaar; kruid met peper en zout.
3. Stoom of wok boerenkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the quinoa (dry) per the package.
2. Sear or poach the shrimp until just done; season with salt and pepper.
3. Steam or stir-fry the kale until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('shrimp_with_quinoa_bok_choy','Garnalen met quinoa & paksoi','Shrimp with quinoa & bok choy',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"shrimp","g":150},{"slug":"quinoa_dry","g":70},{"slug":"bok_choy","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de quinoa (droog) volgens de verpakking.
2. Bak of pocheer de garnalen kort tot net gaar; kruid met peper en zout.
3. Stoom of wok paksoi beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the quinoa (dry) per the package.
2. Sear or poach the shrimp until just done; season with salt and pepper.
3. Steam or stir-fry the bok choy until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('shrimp_with_noodles_broccoli','Garnalen met noedels & broccoli','Shrimp with noodles & broccoli',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"shrimp","g":150},{"slug":"noodles_dry","g":80},{"slug":"broccoli","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['woknoodles']::text[],'1. Kook de volkoren noedels (droog) volgens de verpakking.
2. Bak of pocheer de garnalen kort tot net gaar; kruid met peper en zout.
3. Stoom of wok broccoli beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat noodles (dry) per the package.
2. Sear or poach the shrimp until just done; season with salt and pepper.
3. Steam or stir-fry the broccoli until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('shrimp_with_noodles_green_beans','Garnalen met noedels & sperziebonen','Shrimp with noodles & green beans',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"shrimp","g":150},{"slug":"noodles_dry","g":80},{"slug":"green_beans","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['woknoodles']::text[],'1. Kook de volkoren noedels (droog) volgens de verpakking.
2. Bak of pocheer de garnalen kort tot net gaar; kruid met peper en zout.
3. Stoom of wok sperziebonen beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat noodles (dry) per the package.
2. Sear or poach the shrimp until just done; season with salt and pepper.
3. Steam or stir-fry the green beans until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('shrimp_with_noodles_spinach','Garnalen met noedels & spinazie','Shrimp with noodles & spinach',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"shrimp","g":150},{"slug":"noodles_dry","g":80},{"slug":"spinach","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['woknoodles']::text[],'1. Kook de volkoren noedels (droog) volgens de verpakking.
2. Bak of pocheer de garnalen kort tot net gaar; kruid met peper en zout.
3. Stoom of wok spinazie beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat noodles (dry) per the package.
2. Sear or poach the shrimp until just done; season with salt and pepper.
3. Steam or stir-fry the spinach until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('shrimp_with_noodles_asparagus','Garnalen met noedels & asperges','Shrimp with noodles & asparagus',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"shrimp","g":150},{"slug":"noodles_dry","g":80},{"slug":"asparagus","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['woknoodles']::text[],'1. Kook de volkoren noedels (droog) volgens de verpakking.
2. Bak of pocheer de garnalen kort tot net gaar; kruid met peper en zout.
3. Stoom of wok asperges beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat noodles (dry) per the package.
2. Sear or poach the shrimp until just done; season with salt and pepper.
3. Steam or stir-fry the asparagus until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('shrimp_with_noodles_zucchini','Garnalen met noedels & courgette','Shrimp with noodles & zucchini',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"shrimp","g":150},{"slug":"noodles_dry","g":80},{"slug":"zucchini","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['woknoodles']::text[],'1. Kook de volkoren noedels (droog) volgens de verpakking.
2. Bak of pocheer de garnalen kort tot net gaar; kruid met peper en zout.
3. Stoom of wok courgette beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat noodles (dry) per the package.
2. Sear or poach the shrimp until just done; season with salt and pepper.
3. Steam or stir-fry the zucchini until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('shrimp_with_noodles_stir_fry_veg','Garnalen met noedels & wokgroente','Shrimp with noodles & stir-fry veg',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"shrimp","g":150},{"slug":"noodles_dry","g":80},{"slug":"mixed_veg","g":150},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['woknoodles']::text[],'1. Kook de volkoren noedels (droog) volgens de verpakking.
2. Bak of pocheer de garnalen kort tot net gaar; kruid met peper en zout.
3. Stoom of wok wokgroente beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat noodles (dry) per the package.
2. Sear or poach the shrimp until just done; season with salt and pepper.
3. Steam or stir-fry the stir-fry veg until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('shrimp_with_noodles_mushrooms','Garnalen met noedels & champignons','Shrimp with noodles & mushrooms',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"shrimp","g":150},{"slug":"noodles_dry","g":80},{"slug":"mushroom","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['woknoodles']::text[],'1. Kook de volkoren noedels (droog) volgens de verpakking.
2. Bak of pocheer de garnalen kort tot net gaar; kruid met peper en zout.
3. Stoom of wok champignons beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat noodles (dry) per the package.
2. Sear or poach the shrimp until just done; season with salt and pepper.
3. Steam or stir-fry the mushrooms until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('shrimp_with_noodles_carrot','Garnalen met noedels & wortel','Shrimp with noodles & carrot',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"shrimp","g":150},{"slug":"noodles_dry","g":80},{"slug":"carrot","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['woknoodles']::text[],'1. Kook de volkoren noedels (droog) volgens de verpakking.
2. Bak of pocheer de garnalen kort tot net gaar; kruid met peper en zout.
3. Stoom of wok wortel beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat noodles (dry) per the package.
2. Sear or poach the shrimp until just done; season with salt and pepper.
3. Steam or stir-fry the carrot until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('shrimp_with_noodles_peas','Garnalen met noedels & doperwten','Shrimp with noodles & peas',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"shrimp","g":150},{"slug":"noodles_dry","g":80},{"slug":"peas","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['woknoodles']::text[],'1. Kook de volkoren noedels (droog) volgens de verpakking.
2. Bak of pocheer de garnalen kort tot net gaar; kruid met peper en zout.
3. Stoom of wok doperwten beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat noodles (dry) per the package.
2. Sear or poach the shrimp until just done; season with salt and pepper.
3. Steam or stir-fry the peas until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('shrimp_with_noodles_cauliflower','Garnalen met noedels & bloemkool','Shrimp with noodles & cauliflower',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"shrimp","g":150},{"slug":"noodles_dry","g":80},{"slug":"cauliflower","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['woknoodles']::text[],'1. Kook de volkoren noedels (droog) volgens de verpakking.
2. Bak of pocheer de garnalen kort tot net gaar; kruid met peper en zout.
3. Stoom of wok bloemkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat noodles (dry) per the package.
2. Sear or poach the shrimp until just done; season with salt and pepper.
3. Steam or stir-fry the cauliflower until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('shrimp_with_noodles_kale','Garnalen met noedels & boerenkool','Shrimp with noodles & kale',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"shrimp","g":150},{"slug":"noodles_dry","g":80},{"slug":"kale","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['woknoodles']::text[],'1. Kook de volkoren noedels (droog) volgens de verpakking.
2. Bak of pocheer de garnalen kort tot net gaar; kruid met peper en zout.
3. Stoom of wok boerenkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat noodles (dry) per the package.
2. Sear or poach the shrimp until just done; season with salt and pepper.
3. Steam or stir-fry the kale until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('shrimp_with_noodles_bok_choy','Garnalen met noedels & paksoi','Shrimp with noodles & bok choy',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"shrimp","g":150},{"slug":"noodles_dry","g":80},{"slug":"bok_choy","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['woknoodles']::text[],'1. Kook de volkoren noedels (droog) volgens de verpakking.
2. Bak of pocheer de garnalen kort tot net gaar; kruid met peper en zout.
3. Stoom of wok paksoi beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat noodles (dry) per the package.
2. Sear or poach the shrimp until just done; season with salt and pepper.
3. Steam or stir-fry the bok choy until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('shrimp_with_couscous_broccoli','Garnalen met couscous & broccoli','Shrimp with couscous & broccoli',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"shrimp","g":150},{"slug":"couscous_dry","g":70},{"slug":"broccoli","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de volkoren couscous (droog) volgens de verpakking.
2. Bak of pocheer de garnalen kort tot net gaar; kruid met peper en zout.
3. Stoom of wok broccoli beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat couscous (dry) per the package.
2. Sear or poach the shrimp until just done; season with salt and pepper.
3. Steam or stir-fry the broccoli until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('shrimp_with_couscous_green_beans','Garnalen met couscous & sperziebonen','Shrimp with couscous & green beans',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"shrimp","g":150},{"slug":"couscous_dry","g":70},{"slug":"green_beans","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de volkoren couscous (droog) volgens de verpakking.
2. Bak of pocheer de garnalen kort tot net gaar; kruid met peper en zout.
3. Stoom of wok sperziebonen beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat couscous (dry) per the package.
2. Sear or poach the shrimp until just done; season with salt and pepper.
3. Steam or stir-fry the green beans until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('shrimp_with_couscous_spinach','Garnalen met couscous & spinazie','Shrimp with couscous & spinach',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"shrimp","g":150},{"slug":"couscous_dry","g":70},{"slug":"spinach","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de volkoren couscous (droog) volgens de verpakking.
2. Bak of pocheer de garnalen kort tot net gaar; kruid met peper en zout.
3. Stoom of wok spinazie beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat couscous (dry) per the package.
2. Sear or poach the shrimp until just done; season with salt and pepper.
3. Steam or stir-fry the spinach until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('shrimp_with_couscous_asparagus','Garnalen met couscous & asperges','Shrimp with couscous & asparagus',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"shrimp","g":150},{"slug":"couscous_dry","g":70},{"slug":"asparagus","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de volkoren couscous (droog) volgens de verpakking.
2. Bak of pocheer de garnalen kort tot net gaar; kruid met peper en zout.
3. Stoom of wok asperges beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat couscous (dry) per the package.
2. Sear or poach the shrimp until just done; season with salt and pepper.
3. Steam or stir-fry the asparagus until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('shrimp_with_couscous_zucchini','Garnalen met couscous & courgette','Shrimp with couscous & zucchini',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"shrimp","g":150},{"slug":"couscous_dry","g":70},{"slug":"zucchini","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de volkoren couscous (droog) volgens de verpakking.
2. Bak of pocheer de garnalen kort tot net gaar; kruid met peper en zout.
3. Stoom of wok courgette beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat couscous (dry) per the package.
2. Sear or poach the shrimp until just done; season with salt and pepper.
3. Steam or stir-fry the zucchini until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('shrimp_with_couscous_stir_fry_veg','Garnalen met couscous & wokgroente','Shrimp with couscous & stir-fry veg',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"shrimp","g":150},{"slug":"couscous_dry","g":70},{"slug":"mixed_veg","g":150},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de volkoren couscous (droog) volgens de verpakking.
2. Bak of pocheer de garnalen kort tot net gaar; kruid met peper en zout.
3. Stoom of wok wokgroente beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat couscous (dry) per the package.
2. Sear or poach the shrimp until just done; season with salt and pepper.
3. Steam or stir-fry the stir-fry veg until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('shrimp_with_couscous_mushrooms','Garnalen met couscous & champignons','Shrimp with couscous & mushrooms',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"shrimp","g":150},{"slug":"couscous_dry","g":70},{"slug":"mushroom","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de volkoren couscous (droog) volgens de verpakking.
2. Bak of pocheer de garnalen kort tot net gaar; kruid met peper en zout.
3. Stoom of wok champignons beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat couscous (dry) per the package.
2. Sear or poach the shrimp until just done; season with salt and pepper.
3. Steam or stir-fry the mushrooms until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('shrimp_with_couscous_carrot','Garnalen met couscous & wortel','Shrimp with couscous & carrot',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"shrimp","g":150},{"slug":"couscous_dry","g":70},{"slug":"carrot","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de volkoren couscous (droog) volgens de verpakking.
2. Bak of pocheer de garnalen kort tot net gaar; kruid met peper en zout.
3. Stoom of wok wortel beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat couscous (dry) per the package.
2. Sear or poach the shrimp until just done; season with salt and pepper.
3. Steam or stir-fry the carrot until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('shrimp_with_couscous_peas','Garnalen met couscous & doperwten','Shrimp with couscous & peas',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"shrimp","g":150},{"slug":"couscous_dry","g":70},{"slug":"peas","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de volkoren couscous (droog) volgens de verpakking.
2. Bak of pocheer de garnalen kort tot net gaar; kruid met peper en zout.
3. Stoom of wok doperwten beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat couscous (dry) per the package.
2. Sear or poach the shrimp until just done; season with salt and pepper.
3. Steam or stir-fry the peas until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('shrimp_with_couscous_cauliflower','Garnalen met couscous & bloemkool','Shrimp with couscous & cauliflower',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"shrimp","g":150},{"slug":"couscous_dry","g":70},{"slug":"cauliflower","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de volkoren couscous (droog) volgens de verpakking.
2. Bak of pocheer de garnalen kort tot net gaar; kruid met peper en zout.
3. Stoom of wok bloemkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat couscous (dry) per the package.
2. Sear or poach the shrimp until just done; season with salt and pepper.
3. Steam or stir-fry the cauliflower until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('shrimp_with_couscous_kale','Garnalen met couscous & boerenkool','Shrimp with couscous & kale',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"shrimp","g":150},{"slug":"couscous_dry","g":70},{"slug":"kale","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de volkoren couscous (droog) volgens de verpakking.
2. Bak of pocheer de garnalen kort tot net gaar; kruid met peper en zout.
3. Stoom of wok boerenkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat couscous (dry) per the package.
2. Sear or poach the shrimp until just done; season with salt and pepper.
3. Steam or stir-fry the kale until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('shrimp_with_couscous_bok_choy','Garnalen met couscous & paksoi','Shrimp with couscous & bok choy',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"shrimp","g":150},{"slug":"couscous_dry","g":70},{"slug":"bok_choy","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de volkoren couscous (droog) volgens de verpakking.
2. Bak of pocheer de garnalen kort tot net gaar; kruid met peper en zout.
3. Stoom of wok paksoi beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat couscous (dry) per the package.
2. Sear or poach the shrimp until just done; season with salt and pepper.
3. Steam or stir-fry the bok choy until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('shrimp_with_bulgur_broccoli','Garnalen met bulgur & broccoli','Shrimp with bulgur & broccoli',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"shrimp","g":150},{"slug":"bulgur_dry","g":70},{"slug":"broccoli","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de bulgur (droog) volgens de verpakking.
2. Bak of pocheer de garnalen kort tot net gaar; kruid met peper en zout.
3. Stoom of wok broccoli beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the bulgur (dry) per the package.
2. Sear or poach the shrimp until just done; season with salt and pepper.
3. Steam or stir-fry the broccoli until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('shrimp_with_bulgur_green_beans','Garnalen met bulgur & sperziebonen','Shrimp with bulgur & green beans',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"shrimp","g":150},{"slug":"bulgur_dry","g":70},{"slug":"green_beans","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de bulgur (droog) volgens de verpakking.
2. Bak of pocheer de garnalen kort tot net gaar; kruid met peper en zout.
3. Stoom of wok sperziebonen beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the bulgur (dry) per the package.
2. Sear or poach the shrimp until just done; season with salt and pepper.
3. Steam or stir-fry the green beans until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('shrimp_with_bulgur_spinach','Garnalen met bulgur & spinazie','Shrimp with bulgur & spinach',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"shrimp","g":150},{"slug":"bulgur_dry","g":70},{"slug":"spinach","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de bulgur (droog) volgens de verpakking.
2. Bak of pocheer de garnalen kort tot net gaar; kruid met peper en zout.
3. Stoom of wok spinazie beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the bulgur (dry) per the package.
2. Sear or poach the shrimp until just done; season with salt and pepper.
3. Steam or stir-fry the spinach until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('shrimp_with_bulgur_asparagus','Garnalen met bulgur & asperges','Shrimp with bulgur & asparagus',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"shrimp","g":150},{"slug":"bulgur_dry","g":70},{"slug":"asparagus","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de bulgur (droog) volgens de verpakking.
2. Bak of pocheer de garnalen kort tot net gaar; kruid met peper en zout.
3. Stoom of wok asperges beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the bulgur (dry) per the package.
2. Sear or poach the shrimp until just done; season with salt and pepper.
3. Steam or stir-fry the asparagus until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('shrimp_with_bulgur_zucchini','Garnalen met bulgur & courgette','Shrimp with bulgur & zucchini',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"shrimp","g":150},{"slug":"bulgur_dry","g":70},{"slug":"zucchini","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de bulgur (droog) volgens de verpakking.
2. Bak of pocheer de garnalen kort tot net gaar; kruid met peper en zout.
3. Stoom of wok courgette beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the bulgur (dry) per the package.
2. Sear or poach the shrimp until just done; season with salt and pepper.
3. Steam or stir-fry the zucchini until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('shrimp_with_bulgur_stir_fry_veg','Garnalen met bulgur & wokgroente','Shrimp with bulgur & stir-fry veg',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"shrimp","g":150},{"slug":"bulgur_dry","g":70},{"slug":"mixed_veg","g":150},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de bulgur (droog) volgens de verpakking.
2. Bak of pocheer de garnalen kort tot net gaar; kruid met peper en zout.
3. Stoom of wok wokgroente beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the bulgur (dry) per the package.
2. Sear or poach the shrimp until just done; season with salt and pepper.
3. Steam or stir-fry the stir-fry veg until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('shrimp_with_bulgur_mushrooms','Garnalen met bulgur & champignons','Shrimp with bulgur & mushrooms',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"shrimp","g":150},{"slug":"bulgur_dry","g":70},{"slug":"mushroom","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de bulgur (droog) volgens de verpakking.
2. Bak of pocheer de garnalen kort tot net gaar; kruid met peper en zout.
3. Stoom of wok champignons beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the bulgur (dry) per the package.
2. Sear or poach the shrimp until just done; season with salt and pepper.
3. Steam or stir-fry the mushrooms until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('shrimp_with_bulgur_carrot','Garnalen met bulgur & wortel','Shrimp with bulgur & carrot',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"shrimp","g":150},{"slug":"bulgur_dry","g":70},{"slug":"carrot","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de bulgur (droog) volgens de verpakking.
2. Bak of pocheer de garnalen kort tot net gaar; kruid met peper en zout.
3. Stoom of wok wortel beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the bulgur (dry) per the package.
2. Sear or poach the shrimp until just done; season with salt and pepper.
3. Steam or stir-fry the carrot until tender-crisp.
4. Plate up and finish.','pan',null,'core')
on conflict (slug) do update set name_nl=excluded.name_nl,name_en=excluded.name_en,moments=excluded.moments,goals=excluded.goals,items=excluded.items,tags=excluded.tags,prefs=excluded.prefs,steps=excluded.steps,steps_en=excluded.steps_en,technique=excluded.technique,temp=excluded.temp;
commit;
