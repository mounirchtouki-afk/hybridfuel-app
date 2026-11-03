-- AUTO-GEGENEREERD core-seed deel 2/9 (200 gerechten). Draai NA dish-library.sql.
-- Draai de delen op volgorde (01, 02, ...). Elk deel is los veilig (upsert).
begin;
insert into public.dishes (slug,name_nl,name_en,moments,goals,items,tags,prefs,steps,steps_en,technique,temp,source) values
('steak_with_rice_peas','Biefstuk met rijst & doperwten','Steak with rice & peas',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"beef_steak","g":150},{"slug":"rice_dry","g":70},{"slug":"peas","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['steakpotato','chickenrice','ricechicken']::text[],'1. Kook de witte rijst (droog) volgens de verpakking.
2. Bak de biefstuk in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok doperwten beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the white rice (dry) per the package.
2. Pan-fry the beef steak in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the peas until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('steak_with_rice_cauliflower','Biefstuk met rijst & bloemkool','Steak with rice & cauliflower',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"beef_steak","g":150},{"slug":"rice_dry","g":70},{"slug":"cauliflower","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['steakpotato','chickenrice','ricechicken']::text[],'1. Kook de witte rijst (droog) volgens de verpakking.
2. Bak de biefstuk in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok bloemkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the white rice (dry) per the package.
2. Pan-fry the beef steak in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the cauliflower until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('steak_with_rice_kale','Biefstuk met rijst & boerenkool','Steak with rice & kale',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"beef_steak","g":150},{"slug":"rice_dry","g":70},{"slug":"kale","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['steakpotato','chickenrice','ricechicken']::text[],'1. Kook de witte rijst (droog) volgens de verpakking.
2. Bak de biefstuk in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok boerenkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the white rice (dry) per the package.
2. Pan-fry the beef steak in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the kale until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('steak_with_rice_bok_choy','Biefstuk met rijst & paksoi','Steak with rice & bok choy',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"beef_steak","g":150},{"slug":"rice_dry","g":70},{"slug":"bok_choy","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['steakpotato','chickenrice','ricechicken']::text[],'1. Kook de witte rijst (droog) volgens de verpakking.
2. Bak de biefstuk in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok paksoi beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the white rice (dry) per the package.
2. Pan-fry the beef steak in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the bok choy until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('steak_with_sweet_potato_broccoli','Biefstuk met zoete aardappel & broccoli','Steak with sweet potato & broccoli',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"beef_steak","g":150},{"slug":"sweet_potato","g":200},{"slug":"broccoli","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['steakpotato']::text[],'1. Kook de zoete aardappel volgens de verpakking.
2. Bak de biefstuk in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok broccoli beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the sweet potato per the package.
2. Pan-fry the beef steak in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the broccoli until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('steak_with_sweet_potato_green_beans','Biefstuk met zoete aardappel & sperziebonen','Steak with sweet potato & green beans',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"beef_steak","g":150},{"slug":"sweet_potato","g":200},{"slug":"green_beans","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['steakpotato']::text[],'1. Kook de zoete aardappel volgens de verpakking.
2. Bak de biefstuk in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok sperziebonen beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the sweet potato per the package.
2. Pan-fry the beef steak in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the green beans until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('steak_with_sweet_potato_spinach','Biefstuk met zoete aardappel & spinazie','Steak with sweet potato & spinach',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"beef_steak","g":150},{"slug":"sweet_potato","g":200},{"slug":"spinach","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['steakpotato']::text[],'1. Kook de zoete aardappel volgens de verpakking.
2. Bak de biefstuk in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok spinazie beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the sweet potato per the package.
2. Pan-fry the beef steak in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the spinach until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('steak_with_sweet_potato_asparagus','Biefstuk met zoete aardappel & asperges','Steak with sweet potato & asparagus',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"beef_steak","g":150},{"slug":"sweet_potato","g":200},{"slug":"asparagus","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['steakpotato']::text[],'1. Kook de zoete aardappel volgens de verpakking.
2. Bak de biefstuk in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok asperges beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the sweet potato per the package.
2. Pan-fry the beef steak in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the asparagus until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('steak_with_sweet_potato_zucchini','Biefstuk met zoete aardappel & courgette','Steak with sweet potato & zucchini',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"beef_steak","g":150},{"slug":"sweet_potato","g":200},{"slug":"zucchini","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['steakpotato']::text[],'1. Kook de zoete aardappel volgens de verpakking.
2. Bak de biefstuk in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok courgette beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the sweet potato per the package.
2. Pan-fry the beef steak in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the zucchini until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('steak_with_sweet_potato_stir_fry_veg','Biefstuk met zoete aardappel & wokgroente','Steak with sweet potato & stir-fry veg',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"beef_steak","g":150},{"slug":"sweet_potato","g":200},{"slug":"mixed_veg","g":150},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['steakpotato']::text[],'1. Kook de zoete aardappel volgens de verpakking.
2. Bak de biefstuk in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok wokgroente beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the sweet potato per the package.
2. Pan-fry the beef steak in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the stir-fry veg until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('steak_with_sweet_potato_mushrooms','Biefstuk met zoete aardappel & champignons','Steak with sweet potato & mushrooms',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"beef_steak","g":150},{"slug":"sweet_potato","g":200},{"slug":"mushroom","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['steakpotato']::text[],'1. Kook de zoete aardappel volgens de verpakking.
2. Bak de biefstuk in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok champignons beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the sweet potato per the package.
2. Pan-fry the beef steak in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the mushrooms until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('steak_with_sweet_potato_carrot','Biefstuk met zoete aardappel & wortel','Steak with sweet potato & carrot',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"beef_steak","g":150},{"slug":"sweet_potato","g":200},{"slug":"carrot","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['steakpotato']::text[],'1. Kook de zoete aardappel volgens de verpakking.
2. Bak de biefstuk in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok wortel beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the sweet potato per the package.
2. Pan-fry the beef steak in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the carrot until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('steak_with_sweet_potato_peas','Biefstuk met zoete aardappel & doperwten','Steak with sweet potato & peas',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"beef_steak","g":150},{"slug":"sweet_potato","g":200},{"slug":"peas","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['steakpotato']::text[],'1. Kook de zoete aardappel volgens de verpakking.
2. Bak de biefstuk in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok doperwten beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the sweet potato per the package.
2. Pan-fry the beef steak in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the peas until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('steak_with_sweet_potato_cauliflower','Biefstuk met zoete aardappel & bloemkool','Steak with sweet potato & cauliflower',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"beef_steak","g":150},{"slug":"sweet_potato","g":200},{"slug":"cauliflower","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['steakpotato']::text[],'1. Kook de zoete aardappel volgens de verpakking.
2. Bak de biefstuk in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok bloemkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the sweet potato per the package.
2. Pan-fry the beef steak in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the cauliflower until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('steak_with_sweet_potato_kale','Biefstuk met zoete aardappel & boerenkool','Steak with sweet potato & kale',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"beef_steak","g":150},{"slug":"sweet_potato","g":200},{"slug":"kale","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['steakpotato']::text[],'1. Kook de zoete aardappel volgens de verpakking.
2. Bak de biefstuk in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok boerenkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the sweet potato per the package.
2. Pan-fry the beef steak in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the kale until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('steak_with_sweet_potato_bok_choy','Biefstuk met zoete aardappel & paksoi','Steak with sweet potato & bok choy',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"beef_steak","g":150},{"slug":"sweet_potato","g":200},{"slug":"bok_choy","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['steakpotato']::text[],'1. Kook de zoete aardappel volgens de verpakking.
2. Bak de biefstuk in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok paksoi beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the sweet potato per the package.
2. Pan-fry the beef steak in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the bok choy until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('steak_with_potato_broccoli','Biefstuk met aardappel & broccoli','Steak with potato & broccoli',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"beef_steak","g":150},{"slug":"potato","g":250},{"slug":"broccoli","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['steakpotato']::text[],'1. Kook de aardappel volgens de verpakking.
2. Bak de biefstuk in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok broccoli beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the potato per the package.
2. Pan-fry the beef steak in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the broccoli until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('steak_with_potato_green_beans','Biefstuk met aardappel & sperziebonen','Steak with potato & green beans',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"beef_steak","g":150},{"slug":"potato","g":250},{"slug":"green_beans","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['steakpotato']::text[],'1. Kook de aardappel volgens de verpakking.
2. Bak de biefstuk in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok sperziebonen beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the potato per the package.
2. Pan-fry the beef steak in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the green beans until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('steak_with_potato_spinach','Biefstuk met aardappel & spinazie','Steak with potato & spinach',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"beef_steak","g":150},{"slug":"potato","g":250},{"slug":"spinach","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['steakpotato']::text[],'1. Kook de aardappel volgens de verpakking.
2. Bak de biefstuk in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok spinazie beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the potato per the package.
2. Pan-fry the beef steak in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the spinach until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('steak_with_potato_asparagus','Biefstuk met aardappel & asperges','Steak with potato & asparagus',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"beef_steak","g":150},{"slug":"potato","g":250},{"slug":"asparagus","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['steakpotato']::text[],'1. Kook de aardappel volgens de verpakking.
2. Bak de biefstuk in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok asperges beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the potato per the package.
2. Pan-fry the beef steak in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the asparagus until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('steak_with_potato_zucchini','Biefstuk met aardappel & courgette','Steak with potato & zucchini',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"beef_steak","g":150},{"slug":"potato","g":250},{"slug":"zucchini","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['steakpotato']::text[],'1. Kook de aardappel volgens de verpakking.
2. Bak de biefstuk in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok courgette beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the potato per the package.
2. Pan-fry the beef steak in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the zucchini until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('steak_with_potato_stir_fry_veg','Biefstuk met aardappel & wokgroente','Steak with potato & stir-fry veg',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"beef_steak","g":150},{"slug":"potato","g":250},{"slug":"mixed_veg","g":150},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['steakpotato']::text[],'1. Kook de aardappel volgens de verpakking.
2. Bak de biefstuk in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok wokgroente beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the potato per the package.
2. Pan-fry the beef steak in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the stir-fry veg until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('steak_with_potato_mushrooms','Biefstuk met aardappel & champignons','Steak with potato & mushrooms',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"beef_steak","g":150},{"slug":"potato","g":250},{"slug":"mushroom","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['steakpotato']::text[],'1. Kook de aardappel volgens de verpakking.
2. Bak de biefstuk in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok champignons beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the potato per the package.
2. Pan-fry the beef steak in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the mushrooms until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('steak_with_potato_carrot','Biefstuk met aardappel & wortel','Steak with potato & carrot',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"beef_steak","g":150},{"slug":"potato","g":250},{"slug":"carrot","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['steakpotato']::text[],'1. Kook de aardappel volgens de verpakking.
2. Bak de biefstuk in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok wortel beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the potato per the package.
2. Pan-fry the beef steak in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the carrot until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('steak_with_potato_peas','Biefstuk met aardappel & doperwten','Steak with potato & peas',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"beef_steak","g":150},{"slug":"potato","g":250},{"slug":"peas","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['steakpotato']::text[],'1. Kook de aardappel volgens de verpakking.
2. Bak de biefstuk in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok doperwten beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the potato per the package.
2. Pan-fry the beef steak in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the peas until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('steak_with_potato_cauliflower','Biefstuk met aardappel & bloemkool','Steak with potato & cauliflower',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"beef_steak","g":150},{"slug":"potato","g":250},{"slug":"cauliflower","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['steakpotato']::text[],'1. Kook de aardappel volgens de verpakking.
2. Bak de biefstuk in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok bloemkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the potato per the package.
2. Pan-fry the beef steak in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the cauliflower until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('steak_with_potato_kale','Biefstuk met aardappel & boerenkool','Steak with potato & kale',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"beef_steak","g":150},{"slug":"potato","g":250},{"slug":"kale","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['steakpotato']::text[],'1. Kook de aardappel volgens de verpakking.
2. Bak de biefstuk in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok boerenkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the potato per the package.
2. Pan-fry the beef steak in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the kale until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('steak_with_potato_bok_choy','Biefstuk met aardappel & paksoi','Steak with potato & bok choy',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"beef_steak","g":150},{"slug":"potato","g":250},{"slug":"bok_choy","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['steakpotato']::text[],'1. Kook de aardappel volgens de verpakking.
2. Bak de biefstuk in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok paksoi beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the potato per the package.
2. Pan-fry the beef steak in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the bok choy until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('steak_with_pasta_broccoli','Biefstuk met pasta & broccoli','Steak with pasta & broccoli',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"beef_steak","g":150},{"slug":"pasta_dry","g":80},{"slug":"broccoli","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['steakpotato','pastabol']::text[],'1. Kook de volkoren pasta (droog) volgens de verpakking.
2. Bak de biefstuk in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok broccoli beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat pasta (dry) per the package.
2. Pan-fry the beef steak in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the broccoli until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('steak_with_pasta_green_beans','Biefstuk met pasta & sperziebonen','Steak with pasta & green beans',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"beef_steak","g":150},{"slug":"pasta_dry","g":80},{"slug":"green_beans","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['steakpotato','pastabol']::text[],'1. Kook de volkoren pasta (droog) volgens de verpakking.
2. Bak de biefstuk in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok sperziebonen beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat pasta (dry) per the package.
2. Pan-fry the beef steak in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the green beans until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('steak_with_pasta_spinach','Biefstuk met pasta & spinazie','Steak with pasta & spinach',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"beef_steak","g":150},{"slug":"pasta_dry","g":80},{"slug":"spinach","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['steakpotato','pastabol']::text[],'1. Kook de volkoren pasta (droog) volgens de verpakking.
2. Bak de biefstuk in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok spinazie beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat pasta (dry) per the package.
2. Pan-fry the beef steak in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the spinach until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('steak_with_pasta_asparagus','Biefstuk met pasta & asperges','Steak with pasta & asparagus',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"beef_steak","g":150},{"slug":"pasta_dry","g":80},{"slug":"asparagus","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['steakpotato','pastabol']::text[],'1. Kook de volkoren pasta (droog) volgens de verpakking.
2. Bak de biefstuk in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok asperges beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat pasta (dry) per the package.
2. Pan-fry the beef steak in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the asparagus until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('steak_with_pasta_zucchini','Biefstuk met pasta & courgette','Steak with pasta & zucchini',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"beef_steak","g":150},{"slug":"pasta_dry","g":80},{"slug":"zucchini","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['steakpotato','pastabol']::text[],'1. Kook de volkoren pasta (droog) volgens de verpakking.
2. Bak de biefstuk in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok courgette beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat pasta (dry) per the package.
2. Pan-fry the beef steak in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the zucchini until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('steak_with_pasta_stir_fry_veg','Biefstuk met pasta & wokgroente','Steak with pasta & stir-fry veg',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"beef_steak","g":150},{"slug":"pasta_dry","g":80},{"slug":"mixed_veg","g":150},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['steakpotato','pastabol']::text[],'1. Kook de volkoren pasta (droog) volgens de verpakking.
2. Bak de biefstuk in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok wokgroente beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat pasta (dry) per the package.
2. Pan-fry the beef steak in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the stir-fry veg until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('steak_with_pasta_mushrooms','Biefstuk met pasta & champignons','Steak with pasta & mushrooms',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"beef_steak","g":150},{"slug":"pasta_dry","g":80},{"slug":"mushroom","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['steakpotato','pastabol']::text[],'1. Kook de volkoren pasta (droog) volgens de verpakking.
2. Bak de biefstuk in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok champignons beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat pasta (dry) per the package.
2. Pan-fry the beef steak in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the mushrooms until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('steak_with_pasta_carrot','Biefstuk met pasta & wortel','Steak with pasta & carrot',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"beef_steak","g":150},{"slug":"pasta_dry","g":80},{"slug":"carrot","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['steakpotato','pastabol']::text[],'1. Kook de volkoren pasta (droog) volgens de verpakking.
2. Bak de biefstuk in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok wortel beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat pasta (dry) per the package.
2. Pan-fry the beef steak in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the carrot until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('steak_with_pasta_peas','Biefstuk met pasta & doperwten','Steak with pasta & peas',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"beef_steak","g":150},{"slug":"pasta_dry","g":80},{"slug":"peas","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['steakpotato','pastabol']::text[],'1. Kook de volkoren pasta (droog) volgens de verpakking.
2. Bak de biefstuk in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok doperwten beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat pasta (dry) per the package.
2. Pan-fry the beef steak in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the peas until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('steak_with_pasta_cauliflower','Biefstuk met pasta & bloemkool','Steak with pasta & cauliflower',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"beef_steak","g":150},{"slug":"pasta_dry","g":80},{"slug":"cauliflower","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['steakpotato','pastabol']::text[],'1. Kook de volkoren pasta (droog) volgens de verpakking.
2. Bak de biefstuk in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok bloemkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat pasta (dry) per the package.
2. Pan-fry the beef steak in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the cauliflower until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('steak_with_pasta_kale','Biefstuk met pasta & boerenkool','Steak with pasta & kale',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"beef_steak","g":150},{"slug":"pasta_dry","g":80},{"slug":"kale","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['steakpotato','pastabol']::text[],'1. Kook de volkoren pasta (droog) volgens de verpakking.
2. Bak de biefstuk in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok boerenkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat pasta (dry) per the package.
2. Pan-fry the beef steak in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the kale until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('steak_with_pasta_bok_choy','Biefstuk met pasta & paksoi','Steak with pasta & bok choy',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"beef_steak","g":150},{"slug":"pasta_dry","g":80},{"slug":"bok_choy","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['steakpotato','pastabol']::text[],'1. Kook de volkoren pasta (droog) volgens de verpakking.
2. Bak de biefstuk in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok paksoi beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat pasta (dry) per the package.
2. Pan-fry the beef steak in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the bok choy until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('steak_with_quinoa_broccoli','Biefstuk met quinoa & broccoli','Steak with quinoa & broccoli',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"beef_steak","g":150},{"slug":"quinoa_dry","g":70},{"slug":"broccoli","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['steakpotato']::text[],'1. Kook de quinoa (droog) volgens de verpakking.
2. Bak de biefstuk in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok broccoli beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the quinoa (dry) per the package.
2. Pan-fry the beef steak in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the broccoli until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('steak_with_quinoa_green_beans','Biefstuk met quinoa & sperziebonen','Steak with quinoa & green beans',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"beef_steak","g":150},{"slug":"quinoa_dry","g":70},{"slug":"green_beans","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['steakpotato']::text[],'1. Kook de quinoa (droog) volgens de verpakking.
2. Bak de biefstuk in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok sperziebonen beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the quinoa (dry) per the package.
2. Pan-fry the beef steak in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the green beans until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('steak_with_quinoa_spinach','Biefstuk met quinoa & spinazie','Steak with quinoa & spinach',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"beef_steak","g":150},{"slug":"quinoa_dry","g":70},{"slug":"spinach","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['steakpotato']::text[],'1. Kook de quinoa (droog) volgens de verpakking.
2. Bak de biefstuk in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok spinazie beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the quinoa (dry) per the package.
2. Pan-fry the beef steak in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the spinach until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('steak_with_quinoa_asparagus','Biefstuk met quinoa & asperges','Steak with quinoa & asparagus',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"beef_steak","g":150},{"slug":"quinoa_dry","g":70},{"slug":"asparagus","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['steakpotato']::text[],'1. Kook de quinoa (droog) volgens de verpakking.
2. Bak de biefstuk in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok asperges beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the quinoa (dry) per the package.
2. Pan-fry the beef steak in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the asparagus until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('steak_with_quinoa_zucchini','Biefstuk met quinoa & courgette','Steak with quinoa & zucchini',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"beef_steak","g":150},{"slug":"quinoa_dry","g":70},{"slug":"zucchini","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['steakpotato']::text[],'1. Kook de quinoa (droog) volgens de verpakking.
2. Bak de biefstuk in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok courgette beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the quinoa (dry) per the package.
2. Pan-fry the beef steak in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the zucchini until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('steak_with_quinoa_stir_fry_veg','Biefstuk met quinoa & wokgroente','Steak with quinoa & stir-fry veg',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"beef_steak","g":150},{"slug":"quinoa_dry","g":70},{"slug":"mixed_veg","g":150},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['steakpotato']::text[],'1. Kook de quinoa (droog) volgens de verpakking.
2. Bak de biefstuk in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok wokgroente beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the quinoa (dry) per the package.
2. Pan-fry the beef steak in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the stir-fry veg until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('steak_with_quinoa_mushrooms','Biefstuk met quinoa & champignons','Steak with quinoa & mushrooms',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"beef_steak","g":150},{"slug":"quinoa_dry","g":70},{"slug":"mushroom","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['steakpotato']::text[],'1. Kook de quinoa (droog) volgens de verpakking.
2. Bak de biefstuk in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok champignons beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the quinoa (dry) per the package.
2. Pan-fry the beef steak in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the mushrooms until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('steak_with_quinoa_carrot','Biefstuk met quinoa & wortel','Steak with quinoa & carrot',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"beef_steak","g":150},{"slug":"quinoa_dry","g":70},{"slug":"carrot","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['steakpotato']::text[],'1. Kook de quinoa (droog) volgens de verpakking.
2. Bak de biefstuk in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok wortel beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the quinoa (dry) per the package.
2. Pan-fry the beef steak in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the carrot until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('steak_with_quinoa_peas','Biefstuk met quinoa & doperwten','Steak with quinoa & peas',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"beef_steak","g":150},{"slug":"quinoa_dry","g":70},{"slug":"peas","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['steakpotato']::text[],'1. Kook de quinoa (droog) volgens de verpakking.
2. Bak de biefstuk in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok doperwten beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the quinoa (dry) per the package.
2. Pan-fry the beef steak in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the peas until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('steak_with_quinoa_cauliflower','Biefstuk met quinoa & bloemkool','Steak with quinoa & cauliflower',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"beef_steak","g":150},{"slug":"quinoa_dry","g":70},{"slug":"cauliflower","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['steakpotato']::text[],'1. Kook de quinoa (droog) volgens de verpakking.
2. Bak de biefstuk in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok bloemkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the quinoa (dry) per the package.
2. Pan-fry the beef steak in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the cauliflower until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('steak_with_quinoa_kale','Biefstuk met quinoa & boerenkool','Steak with quinoa & kale',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"beef_steak","g":150},{"slug":"quinoa_dry","g":70},{"slug":"kale","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['steakpotato']::text[],'1. Kook de quinoa (droog) volgens de verpakking.
2. Bak de biefstuk in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok boerenkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the quinoa (dry) per the package.
2. Pan-fry the beef steak in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the kale until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('steak_with_quinoa_bok_choy','Biefstuk met quinoa & paksoi','Steak with quinoa & bok choy',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"beef_steak","g":150},{"slug":"quinoa_dry","g":70},{"slug":"bok_choy","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['steakpotato']::text[],'1. Kook de quinoa (droog) volgens de verpakking.
2. Bak de biefstuk in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok paksoi beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the quinoa (dry) per the package.
2. Pan-fry the beef steak in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the bok choy until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('steak_with_noodles_broccoli','Biefstuk met noedels & broccoli','Steak with noodles & broccoli',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"beef_steak","g":150},{"slug":"noodles_dry","g":80},{"slug":"broccoli","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['steakpotato','woknoodles']::text[],'1. Kook de volkoren noedels (droog) volgens de verpakking.
2. Bak de biefstuk in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok broccoli beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat noodles (dry) per the package.
2. Pan-fry the beef steak in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the broccoli until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('steak_with_noodles_green_beans','Biefstuk met noedels & sperziebonen','Steak with noodles & green beans',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"beef_steak","g":150},{"slug":"noodles_dry","g":80},{"slug":"green_beans","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['steakpotato','woknoodles']::text[],'1. Kook de volkoren noedels (droog) volgens de verpakking.
2. Bak de biefstuk in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok sperziebonen beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat noodles (dry) per the package.
2. Pan-fry the beef steak in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the green beans until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('steak_with_noodles_spinach','Biefstuk met noedels & spinazie','Steak with noodles & spinach',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"beef_steak","g":150},{"slug":"noodles_dry","g":80},{"slug":"spinach","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['steakpotato','woknoodles']::text[],'1. Kook de volkoren noedels (droog) volgens de verpakking.
2. Bak de biefstuk in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok spinazie beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat noodles (dry) per the package.
2. Pan-fry the beef steak in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the spinach until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('steak_with_noodles_asparagus','Biefstuk met noedels & asperges','Steak with noodles & asparagus',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"beef_steak","g":150},{"slug":"noodles_dry","g":80},{"slug":"asparagus","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['steakpotato','woknoodles']::text[],'1. Kook de volkoren noedels (droog) volgens de verpakking.
2. Bak de biefstuk in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok asperges beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat noodles (dry) per the package.
2. Pan-fry the beef steak in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the asparagus until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('steak_with_noodles_zucchini','Biefstuk met noedels & courgette','Steak with noodles & zucchini',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"beef_steak","g":150},{"slug":"noodles_dry","g":80},{"slug":"zucchini","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['steakpotato','woknoodles']::text[],'1. Kook de volkoren noedels (droog) volgens de verpakking.
2. Bak de biefstuk in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok courgette beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat noodles (dry) per the package.
2. Pan-fry the beef steak in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the zucchini until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('steak_with_noodles_stir_fry_veg','Biefstuk met noedels & wokgroente','Steak with noodles & stir-fry veg',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"beef_steak","g":150},{"slug":"noodles_dry","g":80},{"slug":"mixed_veg","g":150},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['steakpotato','woknoodles']::text[],'1. Kook de volkoren noedels (droog) volgens de verpakking.
2. Bak de biefstuk in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok wokgroente beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat noodles (dry) per the package.
2. Pan-fry the beef steak in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the stir-fry veg until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('steak_with_noodles_mushrooms','Biefstuk met noedels & champignons','Steak with noodles & mushrooms',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"beef_steak","g":150},{"slug":"noodles_dry","g":80},{"slug":"mushroom","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['steakpotato','woknoodles']::text[],'1. Kook de volkoren noedels (droog) volgens de verpakking.
2. Bak de biefstuk in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok champignons beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat noodles (dry) per the package.
2. Pan-fry the beef steak in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the mushrooms until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('steak_with_noodles_carrot','Biefstuk met noedels & wortel','Steak with noodles & carrot',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"beef_steak","g":150},{"slug":"noodles_dry","g":80},{"slug":"carrot","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['steakpotato','woknoodles']::text[],'1. Kook de volkoren noedels (droog) volgens de verpakking.
2. Bak de biefstuk in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok wortel beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat noodles (dry) per the package.
2. Pan-fry the beef steak in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the carrot until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('steak_with_noodles_peas','Biefstuk met noedels & doperwten','Steak with noodles & peas',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"beef_steak","g":150},{"slug":"noodles_dry","g":80},{"slug":"peas","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['steakpotato','woknoodles']::text[],'1. Kook de volkoren noedels (droog) volgens de verpakking.
2. Bak de biefstuk in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok doperwten beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat noodles (dry) per the package.
2. Pan-fry the beef steak in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the peas until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('steak_with_noodles_cauliflower','Biefstuk met noedels & bloemkool','Steak with noodles & cauliflower',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"beef_steak","g":150},{"slug":"noodles_dry","g":80},{"slug":"cauliflower","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['steakpotato','woknoodles']::text[],'1. Kook de volkoren noedels (droog) volgens de verpakking.
2. Bak de biefstuk in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok bloemkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat noodles (dry) per the package.
2. Pan-fry the beef steak in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the cauliflower until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('steak_with_noodles_kale','Biefstuk met noedels & boerenkool','Steak with noodles & kale',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"beef_steak","g":150},{"slug":"noodles_dry","g":80},{"slug":"kale","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['steakpotato','woknoodles']::text[],'1. Kook de volkoren noedels (droog) volgens de verpakking.
2. Bak de biefstuk in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok boerenkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat noodles (dry) per the package.
2. Pan-fry the beef steak in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the kale until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('steak_with_noodles_bok_choy','Biefstuk met noedels & paksoi','Steak with noodles & bok choy',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"beef_steak","g":150},{"slug":"noodles_dry","g":80},{"slug":"bok_choy","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['steakpotato','woknoodles']::text[],'1. Kook de volkoren noedels (droog) volgens de verpakking.
2. Bak de biefstuk in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok paksoi beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat noodles (dry) per the package.
2. Pan-fry the beef steak in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the bok choy until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('steak_with_couscous_broccoli','Biefstuk met couscous & broccoli','Steak with couscous & broccoli',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"beef_steak","g":150},{"slug":"couscous_dry","g":70},{"slug":"broccoli","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['steakpotato']::text[],'1. Kook de volkoren couscous (droog) volgens de verpakking.
2. Bak de biefstuk in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok broccoli beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat couscous (dry) per the package.
2. Pan-fry the beef steak in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the broccoli until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('steak_with_couscous_green_beans','Biefstuk met couscous & sperziebonen','Steak with couscous & green beans',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"beef_steak","g":150},{"slug":"couscous_dry","g":70},{"slug":"green_beans","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['steakpotato']::text[],'1. Kook de volkoren couscous (droog) volgens de verpakking.
2. Bak de biefstuk in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok sperziebonen beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat couscous (dry) per the package.
2. Pan-fry the beef steak in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the green beans until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('steak_with_couscous_spinach','Biefstuk met couscous & spinazie','Steak with couscous & spinach',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"beef_steak","g":150},{"slug":"couscous_dry","g":70},{"slug":"spinach","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['steakpotato']::text[],'1. Kook de volkoren couscous (droog) volgens de verpakking.
2. Bak de biefstuk in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok spinazie beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat couscous (dry) per the package.
2. Pan-fry the beef steak in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the spinach until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('steak_with_couscous_asparagus','Biefstuk met couscous & asperges','Steak with couscous & asparagus',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"beef_steak","g":150},{"slug":"couscous_dry","g":70},{"slug":"asparagus","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['steakpotato']::text[],'1. Kook de volkoren couscous (droog) volgens de verpakking.
2. Bak de biefstuk in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok asperges beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat couscous (dry) per the package.
2. Pan-fry the beef steak in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the asparagus until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('steak_with_couscous_zucchini','Biefstuk met couscous & courgette','Steak with couscous & zucchini',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"beef_steak","g":150},{"slug":"couscous_dry","g":70},{"slug":"zucchini","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['steakpotato']::text[],'1. Kook de volkoren couscous (droog) volgens de verpakking.
2. Bak de biefstuk in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok courgette beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat couscous (dry) per the package.
2. Pan-fry the beef steak in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the zucchini until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('steak_with_couscous_stir_fry_veg','Biefstuk met couscous & wokgroente','Steak with couscous & stir-fry veg',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"beef_steak","g":150},{"slug":"couscous_dry","g":70},{"slug":"mixed_veg","g":150},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['steakpotato']::text[],'1. Kook de volkoren couscous (droog) volgens de verpakking.
2. Bak de biefstuk in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok wokgroente beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat couscous (dry) per the package.
2. Pan-fry the beef steak in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the stir-fry veg until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('steak_with_couscous_mushrooms','Biefstuk met couscous & champignons','Steak with couscous & mushrooms',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"beef_steak","g":150},{"slug":"couscous_dry","g":70},{"slug":"mushroom","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['steakpotato']::text[],'1. Kook de volkoren couscous (droog) volgens de verpakking.
2. Bak de biefstuk in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok champignons beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat couscous (dry) per the package.
2. Pan-fry the beef steak in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the mushrooms until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('steak_with_couscous_carrot','Biefstuk met couscous & wortel','Steak with couscous & carrot',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"beef_steak","g":150},{"slug":"couscous_dry","g":70},{"slug":"carrot","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['steakpotato']::text[],'1. Kook de volkoren couscous (droog) volgens de verpakking.
2. Bak de biefstuk in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok wortel beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat couscous (dry) per the package.
2. Pan-fry the beef steak in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the carrot until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('steak_with_couscous_peas','Biefstuk met couscous & doperwten','Steak with couscous & peas',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"beef_steak","g":150},{"slug":"couscous_dry","g":70},{"slug":"peas","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['steakpotato']::text[],'1. Kook de volkoren couscous (droog) volgens de verpakking.
2. Bak de biefstuk in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok doperwten beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat couscous (dry) per the package.
2. Pan-fry the beef steak in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the peas until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('steak_with_couscous_cauliflower','Biefstuk met couscous & bloemkool','Steak with couscous & cauliflower',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"beef_steak","g":150},{"slug":"couscous_dry","g":70},{"slug":"cauliflower","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['steakpotato']::text[],'1. Kook de volkoren couscous (droog) volgens de verpakking.
2. Bak de biefstuk in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok bloemkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat couscous (dry) per the package.
2. Pan-fry the beef steak in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the cauliflower until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('steak_with_couscous_kale','Biefstuk met couscous & boerenkool','Steak with couscous & kale',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"beef_steak","g":150},{"slug":"couscous_dry","g":70},{"slug":"kale","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['steakpotato']::text[],'1. Kook de volkoren couscous (droog) volgens de verpakking.
2. Bak de biefstuk in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok boerenkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat couscous (dry) per the package.
2. Pan-fry the beef steak in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the kale until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('steak_with_couscous_bok_choy','Biefstuk met couscous & paksoi','Steak with couscous & bok choy',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"beef_steak","g":150},{"slug":"couscous_dry","g":70},{"slug":"bok_choy","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['steakpotato']::text[],'1. Kook de volkoren couscous (droog) volgens de verpakking.
2. Bak de biefstuk in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok paksoi beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat couscous (dry) per the package.
2. Pan-fry the beef steak in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the bok choy until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('steak_with_bulgur_broccoli','Biefstuk met bulgur & broccoli','Steak with bulgur & broccoli',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"beef_steak","g":150},{"slug":"bulgur_dry","g":70},{"slug":"broccoli","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['steakpotato']::text[],'1. Kook de bulgur (droog) volgens de verpakking.
2. Bak de biefstuk in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok broccoli beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the bulgur (dry) per the package.
2. Pan-fry the beef steak in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the broccoli until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('steak_with_bulgur_green_beans','Biefstuk met bulgur & sperziebonen','Steak with bulgur & green beans',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"beef_steak","g":150},{"slug":"bulgur_dry","g":70},{"slug":"green_beans","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['steakpotato']::text[],'1. Kook de bulgur (droog) volgens de verpakking.
2. Bak de biefstuk in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok sperziebonen beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the bulgur (dry) per the package.
2. Pan-fry the beef steak in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the green beans until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('steak_with_bulgur_spinach','Biefstuk met bulgur & spinazie','Steak with bulgur & spinach',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"beef_steak","g":150},{"slug":"bulgur_dry","g":70},{"slug":"spinach","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['steakpotato']::text[],'1. Kook de bulgur (droog) volgens de verpakking.
2. Bak de biefstuk in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok spinazie beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the bulgur (dry) per the package.
2. Pan-fry the beef steak in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the spinach until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('steak_with_bulgur_asparagus','Biefstuk met bulgur & asperges','Steak with bulgur & asparagus',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"beef_steak","g":150},{"slug":"bulgur_dry","g":70},{"slug":"asparagus","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['steakpotato']::text[],'1. Kook de bulgur (droog) volgens de verpakking.
2. Bak de biefstuk in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok asperges beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the bulgur (dry) per the package.
2. Pan-fry the beef steak in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the asparagus until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('steak_with_bulgur_zucchini','Biefstuk met bulgur & courgette','Steak with bulgur & zucchini',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"beef_steak","g":150},{"slug":"bulgur_dry","g":70},{"slug":"zucchini","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['steakpotato']::text[],'1. Kook de bulgur (droog) volgens de verpakking.
2. Bak de biefstuk in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok courgette beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the bulgur (dry) per the package.
2. Pan-fry the beef steak in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the zucchini until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('steak_with_bulgur_stir_fry_veg','Biefstuk met bulgur & wokgroente','Steak with bulgur & stir-fry veg',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"beef_steak","g":150},{"slug":"bulgur_dry","g":70},{"slug":"mixed_veg","g":150},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['steakpotato']::text[],'1. Kook de bulgur (droog) volgens de verpakking.
2. Bak de biefstuk in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok wokgroente beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the bulgur (dry) per the package.
2. Pan-fry the beef steak in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the stir-fry veg until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('steak_with_bulgur_mushrooms','Biefstuk met bulgur & champignons','Steak with bulgur & mushrooms',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"beef_steak","g":150},{"slug":"bulgur_dry","g":70},{"slug":"mushroom","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['steakpotato']::text[],'1. Kook de bulgur (droog) volgens de verpakking.
2. Bak de biefstuk in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok champignons beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the bulgur (dry) per the package.
2. Pan-fry the beef steak in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the mushrooms until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('steak_with_bulgur_carrot','Biefstuk met bulgur & wortel','Steak with bulgur & carrot',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"beef_steak","g":150},{"slug":"bulgur_dry","g":70},{"slug":"carrot","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['steakpotato']::text[],'1. Kook de bulgur (droog) volgens de verpakking.
2. Bak de biefstuk in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok wortel beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the bulgur (dry) per the package.
2. Pan-fry the beef steak in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the carrot until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('steak_with_bulgur_peas','Biefstuk met bulgur & doperwten','Steak with bulgur & peas',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"beef_steak","g":150},{"slug":"bulgur_dry","g":70},{"slug":"peas","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['steakpotato']::text[],'1. Kook de bulgur (droog) volgens de verpakking.
2. Bak de biefstuk in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok doperwten beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the bulgur (dry) per the package.
2. Pan-fry the beef steak in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the peas until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('steak_with_bulgur_cauliflower','Biefstuk met bulgur & bloemkool','Steak with bulgur & cauliflower',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"beef_steak","g":150},{"slug":"bulgur_dry","g":70},{"slug":"cauliflower","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['steakpotato']::text[],'1. Kook de bulgur (droog) volgens de verpakking.
2. Bak de biefstuk in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok bloemkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the bulgur (dry) per the package.
2. Pan-fry the beef steak in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the cauliflower until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('steak_with_bulgur_kale','Biefstuk met bulgur & boerenkool','Steak with bulgur & kale',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"beef_steak","g":150},{"slug":"bulgur_dry","g":70},{"slug":"kale","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['steakpotato']::text[],'1. Kook de bulgur (droog) volgens de verpakking.
2. Bak de biefstuk in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok boerenkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the bulgur (dry) per the package.
2. Pan-fry the beef steak in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the kale until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('steak_with_bulgur_bok_choy','Biefstuk met bulgur & paksoi','Steak with bulgur & bok choy',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"beef_steak","g":150},{"slug":"bulgur_dry","g":70},{"slug":"bok_choy","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['steakpotato']::text[],'1. Kook de bulgur (droog) volgens de verpakking.
2. Bak de biefstuk in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok paksoi beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the bulgur (dry) per the package.
2. Pan-fry the beef steak in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the bok choy until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('steak_with_basmati_rice_broccoli','Biefstuk met basmatirijst & broccoli','Steak with basmati rice & broccoli',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"beef_steak","g":150},{"slug":"basmati_dry","g":70},{"slug":"broccoli","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['steakpotato']::text[],'1. Kook de basmatirijst (droog) volgens de verpakking.
2. Bak de biefstuk in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok broccoli beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the basmati rice (dry) per the package.
2. Pan-fry the beef steak in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the broccoli until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('steak_with_basmati_rice_green_beans','Biefstuk met basmatirijst & sperziebonen','Steak with basmati rice & green beans',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"beef_steak","g":150},{"slug":"basmati_dry","g":70},{"slug":"green_beans","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['steakpotato']::text[],'1. Kook de basmatirijst (droog) volgens de verpakking.
2. Bak de biefstuk in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok sperziebonen beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the basmati rice (dry) per the package.
2. Pan-fry the beef steak in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the green beans until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('steak_with_basmati_rice_spinach','Biefstuk met basmatirijst & spinazie','Steak with basmati rice & spinach',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"beef_steak","g":150},{"slug":"basmati_dry","g":70},{"slug":"spinach","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['steakpotato']::text[],'1. Kook de basmatirijst (droog) volgens de verpakking.
2. Bak de biefstuk in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok spinazie beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the basmati rice (dry) per the package.
2. Pan-fry the beef steak in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the spinach until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('steak_with_basmati_rice_asparagus','Biefstuk met basmatirijst & asperges','Steak with basmati rice & asparagus',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"beef_steak","g":150},{"slug":"basmati_dry","g":70},{"slug":"asparagus","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['steakpotato']::text[],'1. Kook de basmatirijst (droog) volgens de verpakking.
2. Bak de biefstuk in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok asperges beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the basmati rice (dry) per the package.
2. Pan-fry the beef steak in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the asparagus until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('steak_with_basmati_rice_zucchini','Biefstuk met basmatirijst & courgette','Steak with basmati rice & zucchini',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"beef_steak","g":150},{"slug":"basmati_dry","g":70},{"slug":"zucchini","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['steakpotato']::text[],'1. Kook de basmatirijst (droog) volgens de verpakking.
2. Bak de biefstuk in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok courgette beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the basmati rice (dry) per the package.
2. Pan-fry the beef steak in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the zucchini until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('steak_with_basmati_rice_stir_fry_veg','Biefstuk met basmatirijst & wokgroente','Steak with basmati rice & stir-fry veg',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"beef_steak","g":150},{"slug":"basmati_dry","g":70},{"slug":"mixed_veg","g":150},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['steakpotato']::text[],'1. Kook de basmatirijst (droog) volgens de verpakking.
2. Bak de biefstuk in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok wokgroente beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the basmati rice (dry) per the package.
2. Pan-fry the beef steak in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the stir-fry veg until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('steak_with_basmati_rice_mushrooms','Biefstuk met basmatirijst & champignons','Steak with basmati rice & mushrooms',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"beef_steak","g":150},{"slug":"basmati_dry","g":70},{"slug":"mushroom","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['steakpotato']::text[],'1. Kook de basmatirijst (droog) volgens de verpakking.
2. Bak de biefstuk in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok champignons beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the basmati rice (dry) per the package.
2. Pan-fry the beef steak in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the mushrooms until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('steak_with_basmati_rice_carrot','Biefstuk met basmatirijst & wortel','Steak with basmati rice & carrot',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"beef_steak","g":150},{"slug":"basmati_dry","g":70},{"slug":"carrot","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['steakpotato']::text[],'1. Kook de basmatirijst (droog) volgens de verpakking.
2. Bak de biefstuk in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok wortel beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the basmati rice (dry) per the package.
2. Pan-fry the beef steak in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the carrot until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('steak_with_basmati_rice_peas','Biefstuk met basmatirijst & doperwten','Steak with basmati rice & peas',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"beef_steak","g":150},{"slug":"basmati_dry","g":70},{"slug":"peas","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['steakpotato']::text[],'1. Kook de basmatirijst (droog) volgens de verpakking.
2. Bak de biefstuk in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok doperwten beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the basmati rice (dry) per the package.
2. Pan-fry the beef steak in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the peas until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('steak_with_basmati_rice_cauliflower','Biefstuk met basmatirijst & bloemkool','Steak with basmati rice & cauliflower',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"beef_steak","g":150},{"slug":"basmati_dry","g":70},{"slug":"cauliflower","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['steakpotato']::text[],'1. Kook de basmatirijst (droog) volgens de verpakking.
2. Bak de biefstuk in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok bloemkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the basmati rice (dry) per the package.
2. Pan-fry the beef steak in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the cauliflower until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('steak_with_basmati_rice_kale','Biefstuk met basmatirijst & boerenkool','Steak with basmati rice & kale',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"beef_steak","g":150},{"slug":"basmati_dry","g":70},{"slug":"kale","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['steakpotato']::text[],'1. Kook de basmatirijst (droog) volgens de verpakking.
2. Bak de biefstuk in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok boerenkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the basmati rice (dry) per the package.
2. Pan-fry the beef steak in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the kale until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('steak_with_basmati_rice_bok_choy','Biefstuk met basmatirijst & paksoi','Steak with basmati rice & bok choy',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"beef_steak","g":150},{"slug":"basmati_dry","g":70},{"slug":"bok_choy","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['steakpotato']::text[],'1. Kook de basmatirijst (droog) volgens de verpakking.
2. Bak de biefstuk in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok paksoi beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the basmati rice (dry) per the package.
2. Pan-fry the beef steak in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the bok choy until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('beef_mince_with_rice_broccoli','Rundergehakt met rijst & broccoli','Beef mince with rice & broccoli',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"lean_beef_5","g":130},{"slug":"rice_dry","g":70},{"slug":"broccoli","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['pastabol','chickenrice','ricechicken']::text[],'1. Kook de witte rijst (droog) volgens de verpakking.
2. Bak de rundergehakt 5% in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok broccoli beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the white rice (dry) per the package.
2. Pan-fry the lean beef mince 5% in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the broccoli until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('beef_mince_with_rice_green_beans','Rundergehakt met rijst & sperziebonen','Beef mince with rice & green beans',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"lean_beef_5","g":130},{"slug":"rice_dry","g":70},{"slug":"green_beans","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['pastabol','chickenrice','ricechicken']::text[],'1. Kook de witte rijst (droog) volgens de verpakking.
2. Bak de rundergehakt 5% in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok sperziebonen beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the white rice (dry) per the package.
2. Pan-fry the lean beef mince 5% in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the green beans until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('beef_mince_with_rice_spinach','Rundergehakt met rijst & spinazie','Beef mince with rice & spinach',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"lean_beef_5","g":130},{"slug":"rice_dry","g":70},{"slug":"spinach","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['pastabol','chickenrice','ricechicken']::text[],'1. Kook de witte rijst (droog) volgens de verpakking.
2. Bak de rundergehakt 5% in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok spinazie beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the white rice (dry) per the package.
2. Pan-fry the lean beef mince 5% in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the spinach until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('beef_mince_with_rice_asparagus','Rundergehakt met rijst & asperges','Beef mince with rice & asparagus',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"lean_beef_5","g":130},{"slug":"rice_dry","g":70},{"slug":"asparagus","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['pastabol','chickenrice','ricechicken']::text[],'1. Kook de witte rijst (droog) volgens de verpakking.
2. Bak de rundergehakt 5% in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok asperges beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the white rice (dry) per the package.
2. Pan-fry the lean beef mince 5% in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the asparagus until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('beef_mince_with_rice_zucchini','Rundergehakt met rijst & courgette','Beef mince with rice & zucchini',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"lean_beef_5","g":130},{"slug":"rice_dry","g":70},{"slug":"zucchini","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['pastabol','chickenrice','ricechicken']::text[],'1. Kook de witte rijst (droog) volgens de verpakking.
2. Bak de rundergehakt 5% in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok courgette beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the white rice (dry) per the package.
2. Pan-fry the lean beef mince 5% in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the zucchini until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('beef_mince_with_rice_stir_fry_veg','Rundergehakt met rijst & wokgroente','Beef mince with rice & stir-fry veg',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"lean_beef_5","g":130},{"slug":"rice_dry","g":70},{"slug":"mixed_veg","g":150},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['pastabol','chickenrice','ricechicken']::text[],'1. Kook de witte rijst (droog) volgens de verpakking.
2. Bak de rundergehakt 5% in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok wokgroente beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the white rice (dry) per the package.
2. Pan-fry the lean beef mince 5% in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the stir-fry veg until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('beef_mince_with_rice_mushrooms','Rundergehakt met rijst & champignons','Beef mince with rice & mushrooms',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"lean_beef_5","g":130},{"slug":"rice_dry","g":70},{"slug":"mushroom","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['pastabol','chickenrice','ricechicken']::text[],'1. Kook de witte rijst (droog) volgens de verpakking.
2. Bak de rundergehakt 5% in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok champignons beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the white rice (dry) per the package.
2. Pan-fry the lean beef mince 5% in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the mushrooms until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('beef_mince_with_rice_carrot','Rundergehakt met rijst & wortel','Beef mince with rice & carrot',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"lean_beef_5","g":130},{"slug":"rice_dry","g":70},{"slug":"carrot","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['pastabol','chickenrice','ricechicken']::text[],'1. Kook de witte rijst (droog) volgens de verpakking.
2. Bak de rundergehakt 5% in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok wortel beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the white rice (dry) per the package.
2. Pan-fry the lean beef mince 5% in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the carrot until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('beef_mince_with_rice_peas','Rundergehakt met rijst & doperwten','Beef mince with rice & peas',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"lean_beef_5","g":130},{"slug":"rice_dry","g":70},{"slug":"peas","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['pastabol','chickenrice','ricechicken']::text[],'1. Kook de witte rijst (droog) volgens de verpakking.
2. Bak de rundergehakt 5% in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok doperwten beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the white rice (dry) per the package.
2. Pan-fry the lean beef mince 5% in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the peas until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('beef_mince_with_rice_cauliflower','Rundergehakt met rijst & bloemkool','Beef mince with rice & cauliflower',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"lean_beef_5","g":130},{"slug":"rice_dry","g":70},{"slug":"cauliflower","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['pastabol','chickenrice','ricechicken']::text[],'1. Kook de witte rijst (droog) volgens de verpakking.
2. Bak de rundergehakt 5% in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok bloemkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the white rice (dry) per the package.
2. Pan-fry the lean beef mince 5% in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the cauliflower until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('beef_mince_with_rice_kale','Rundergehakt met rijst & boerenkool','Beef mince with rice & kale',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"lean_beef_5","g":130},{"slug":"rice_dry","g":70},{"slug":"kale","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['pastabol','chickenrice','ricechicken']::text[],'1. Kook de witte rijst (droog) volgens de verpakking.
2. Bak de rundergehakt 5% in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok boerenkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the white rice (dry) per the package.
2. Pan-fry the lean beef mince 5% in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the kale until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('beef_mince_with_rice_bok_choy','Rundergehakt met rijst & paksoi','Beef mince with rice & bok choy',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"lean_beef_5","g":130},{"slug":"rice_dry","g":70},{"slug":"bok_choy","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['pastabol','chickenrice','ricechicken']::text[],'1. Kook de witte rijst (droog) volgens de verpakking.
2. Bak de rundergehakt 5% in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok paksoi beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the white rice (dry) per the package.
2. Pan-fry the lean beef mince 5% in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the bok choy until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('beef_mince_with_sweet_potato_broccoli','Rundergehakt met zoete aardappel & broccoli','Beef mince with sweet potato & broccoli',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"lean_beef_5","g":130},{"slug":"sweet_potato","g":200},{"slug":"broccoli","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['pastabol']::text[],'1. Kook de zoete aardappel volgens de verpakking.
2. Bak de rundergehakt 5% in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok broccoli beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the sweet potato per the package.
2. Pan-fry the lean beef mince 5% in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the broccoli until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('beef_mince_with_sweet_potato_green_beans','Rundergehakt met zoete aardappel & sperziebonen','Beef mince with sweet potato & green beans',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"lean_beef_5","g":130},{"slug":"sweet_potato","g":200},{"slug":"green_beans","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['pastabol']::text[],'1. Kook de zoete aardappel volgens de verpakking.
2. Bak de rundergehakt 5% in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok sperziebonen beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the sweet potato per the package.
2. Pan-fry the lean beef mince 5% in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the green beans until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('beef_mince_with_sweet_potato_spinach','Rundergehakt met zoete aardappel & spinazie','Beef mince with sweet potato & spinach',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"lean_beef_5","g":130},{"slug":"sweet_potato","g":200},{"slug":"spinach","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['pastabol']::text[],'1. Kook de zoete aardappel volgens de verpakking.
2. Bak de rundergehakt 5% in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok spinazie beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the sweet potato per the package.
2. Pan-fry the lean beef mince 5% in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the spinach until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('beef_mince_with_sweet_potato_asparagus','Rundergehakt met zoete aardappel & asperges','Beef mince with sweet potato & asparagus',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"lean_beef_5","g":130},{"slug":"sweet_potato","g":200},{"slug":"asparagus","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['pastabol']::text[],'1. Kook de zoete aardappel volgens de verpakking.
2. Bak de rundergehakt 5% in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok asperges beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the sweet potato per the package.
2. Pan-fry the lean beef mince 5% in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the asparagus until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('beef_mince_with_sweet_potato_zucchini','Rundergehakt met zoete aardappel & courgette','Beef mince with sweet potato & zucchini',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"lean_beef_5","g":130},{"slug":"sweet_potato","g":200},{"slug":"zucchini","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['pastabol']::text[],'1. Kook de zoete aardappel volgens de verpakking.
2. Bak de rundergehakt 5% in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok courgette beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the sweet potato per the package.
2. Pan-fry the lean beef mince 5% in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the zucchini until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('beef_mince_with_sweet_potato_stir_fry_veg','Rundergehakt met zoete aardappel & wokgroente','Beef mince with sweet potato & stir-fry veg',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"lean_beef_5","g":130},{"slug":"sweet_potato","g":200},{"slug":"mixed_veg","g":150},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['pastabol']::text[],'1. Kook de zoete aardappel volgens de verpakking.
2. Bak de rundergehakt 5% in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok wokgroente beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the sweet potato per the package.
2. Pan-fry the lean beef mince 5% in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the stir-fry veg until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('beef_mince_with_sweet_potato_mushrooms','Rundergehakt met zoete aardappel & champignons','Beef mince with sweet potato & mushrooms',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"lean_beef_5","g":130},{"slug":"sweet_potato","g":200},{"slug":"mushroom","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['pastabol']::text[],'1. Kook de zoete aardappel volgens de verpakking.
2. Bak de rundergehakt 5% in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok champignons beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the sweet potato per the package.
2. Pan-fry the lean beef mince 5% in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the mushrooms until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('beef_mince_with_sweet_potato_carrot','Rundergehakt met zoete aardappel & wortel','Beef mince with sweet potato & carrot',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"lean_beef_5","g":130},{"slug":"sweet_potato","g":200},{"slug":"carrot","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['pastabol']::text[],'1. Kook de zoete aardappel volgens de verpakking.
2. Bak de rundergehakt 5% in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok wortel beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the sweet potato per the package.
2. Pan-fry the lean beef mince 5% in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the carrot until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('beef_mince_with_sweet_potato_peas','Rundergehakt met zoete aardappel & doperwten','Beef mince with sweet potato & peas',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"lean_beef_5","g":130},{"slug":"sweet_potato","g":200},{"slug":"peas","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['pastabol']::text[],'1. Kook de zoete aardappel volgens de verpakking.
2. Bak de rundergehakt 5% in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok doperwten beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the sweet potato per the package.
2. Pan-fry the lean beef mince 5% in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the peas until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('beef_mince_with_sweet_potato_cauliflower','Rundergehakt met zoete aardappel & bloemkool','Beef mince with sweet potato & cauliflower',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"lean_beef_5","g":130},{"slug":"sweet_potato","g":200},{"slug":"cauliflower","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['pastabol']::text[],'1. Kook de zoete aardappel volgens de verpakking.
2. Bak de rundergehakt 5% in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok bloemkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the sweet potato per the package.
2. Pan-fry the lean beef mince 5% in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the cauliflower until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('beef_mince_with_sweet_potato_kale','Rundergehakt met zoete aardappel & boerenkool','Beef mince with sweet potato & kale',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"lean_beef_5","g":130},{"slug":"sweet_potato","g":200},{"slug":"kale","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['pastabol']::text[],'1. Kook de zoete aardappel volgens de verpakking.
2. Bak de rundergehakt 5% in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok boerenkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the sweet potato per the package.
2. Pan-fry the lean beef mince 5% in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the kale until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('beef_mince_with_sweet_potato_bok_choy','Rundergehakt met zoete aardappel & paksoi','Beef mince with sweet potato & bok choy',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"lean_beef_5","g":130},{"slug":"sweet_potato","g":200},{"slug":"bok_choy","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['pastabol']::text[],'1. Kook de zoete aardappel volgens de verpakking.
2. Bak de rundergehakt 5% in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok paksoi beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the sweet potato per the package.
2. Pan-fry the lean beef mince 5% in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the bok choy until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('beef_mince_with_potato_broccoli','Rundergehakt met aardappel & broccoli','Beef mince with potato & broccoli',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"lean_beef_5","g":130},{"slug":"potato","g":250},{"slug":"broccoli","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['pastabol','steakpotato']::text[],'1. Kook de aardappel volgens de verpakking.
2. Bak de rundergehakt 5% in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok broccoli beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the potato per the package.
2. Pan-fry the lean beef mince 5% in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the broccoli until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('beef_mince_with_potato_green_beans','Rundergehakt met aardappel & sperziebonen','Beef mince with potato & green beans',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"lean_beef_5","g":130},{"slug":"potato","g":250},{"slug":"green_beans","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['pastabol','steakpotato']::text[],'1. Kook de aardappel volgens de verpakking.
2. Bak de rundergehakt 5% in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok sperziebonen beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the potato per the package.
2. Pan-fry the lean beef mince 5% in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the green beans until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('beef_mince_with_potato_spinach','Rundergehakt met aardappel & spinazie','Beef mince with potato & spinach',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"lean_beef_5","g":130},{"slug":"potato","g":250},{"slug":"spinach","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['pastabol','steakpotato']::text[],'1. Kook de aardappel volgens de verpakking.
2. Bak de rundergehakt 5% in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok spinazie beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the potato per the package.
2. Pan-fry the lean beef mince 5% in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the spinach until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('beef_mince_with_potato_asparagus','Rundergehakt met aardappel & asperges','Beef mince with potato & asparagus',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"lean_beef_5","g":130},{"slug":"potato","g":250},{"slug":"asparagus","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['pastabol','steakpotato']::text[],'1. Kook de aardappel volgens de verpakking.
2. Bak de rundergehakt 5% in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok asperges beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the potato per the package.
2. Pan-fry the lean beef mince 5% in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the asparagus until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('beef_mince_with_potato_zucchini','Rundergehakt met aardappel & courgette','Beef mince with potato & zucchini',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"lean_beef_5","g":130},{"slug":"potato","g":250},{"slug":"zucchini","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['pastabol','steakpotato']::text[],'1. Kook de aardappel volgens de verpakking.
2. Bak de rundergehakt 5% in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok courgette beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the potato per the package.
2. Pan-fry the lean beef mince 5% in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the zucchini until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('beef_mince_with_potato_stir_fry_veg','Rundergehakt met aardappel & wokgroente','Beef mince with potato & stir-fry veg',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"lean_beef_5","g":130},{"slug":"potato","g":250},{"slug":"mixed_veg","g":150},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['pastabol','steakpotato']::text[],'1. Kook de aardappel volgens de verpakking.
2. Bak de rundergehakt 5% in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok wokgroente beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the potato per the package.
2. Pan-fry the lean beef mince 5% in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the stir-fry veg until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('beef_mince_with_potato_mushrooms','Rundergehakt met aardappel & champignons','Beef mince with potato & mushrooms',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"lean_beef_5","g":130},{"slug":"potato","g":250},{"slug":"mushroom","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['pastabol','steakpotato']::text[],'1. Kook de aardappel volgens de verpakking.
2. Bak de rundergehakt 5% in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok champignons beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the potato per the package.
2. Pan-fry the lean beef mince 5% in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the mushrooms until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('beef_mince_with_potato_carrot','Rundergehakt met aardappel & wortel','Beef mince with potato & carrot',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"lean_beef_5","g":130},{"slug":"potato","g":250},{"slug":"carrot","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['pastabol','steakpotato']::text[],'1. Kook de aardappel volgens de verpakking.
2. Bak de rundergehakt 5% in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok wortel beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the potato per the package.
2. Pan-fry the lean beef mince 5% in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the carrot until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('beef_mince_with_potato_peas','Rundergehakt met aardappel & doperwten','Beef mince with potato & peas',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"lean_beef_5","g":130},{"slug":"potato","g":250},{"slug":"peas","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['pastabol','steakpotato']::text[],'1. Kook de aardappel volgens de verpakking.
2. Bak de rundergehakt 5% in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok doperwten beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the potato per the package.
2. Pan-fry the lean beef mince 5% in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the peas until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('beef_mince_with_potato_cauliflower','Rundergehakt met aardappel & bloemkool','Beef mince with potato & cauliflower',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"lean_beef_5","g":130},{"slug":"potato","g":250},{"slug":"cauliflower","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['pastabol','steakpotato']::text[],'1. Kook de aardappel volgens de verpakking.
2. Bak de rundergehakt 5% in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok bloemkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the potato per the package.
2. Pan-fry the lean beef mince 5% in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the cauliflower until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('beef_mince_with_potato_kale','Rundergehakt met aardappel & boerenkool','Beef mince with potato & kale',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"lean_beef_5","g":130},{"slug":"potato","g":250},{"slug":"kale","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['pastabol','steakpotato']::text[],'1. Kook de aardappel volgens de verpakking.
2. Bak de rundergehakt 5% in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok boerenkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the potato per the package.
2. Pan-fry the lean beef mince 5% in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the kale until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('beef_mince_with_potato_bok_choy','Rundergehakt met aardappel & paksoi','Beef mince with potato & bok choy',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"lean_beef_5","g":130},{"slug":"potato","g":250},{"slug":"bok_choy","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['pastabol','steakpotato']::text[],'1. Kook de aardappel volgens de verpakking.
2. Bak de rundergehakt 5% in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok paksoi beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the potato per the package.
2. Pan-fry the lean beef mince 5% in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the bok choy until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('beef_mince_with_pasta_broccoli','Rundergehakt met pasta & broccoli','Beef mince with pasta & broccoli',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"lean_beef_5","g":130},{"slug":"pasta_dry","g":80},{"slug":"broccoli","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['pastabol']::text[],'1. Kook de volkoren pasta (droog) volgens de verpakking.
2. Bak de rundergehakt 5% in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok broccoli beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat pasta (dry) per the package.
2. Pan-fry the lean beef mince 5% in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the broccoli until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('beef_mince_with_pasta_green_beans','Rundergehakt met pasta & sperziebonen','Beef mince with pasta & green beans',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"lean_beef_5","g":130},{"slug":"pasta_dry","g":80},{"slug":"green_beans","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['pastabol']::text[],'1. Kook de volkoren pasta (droog) volgens de verpakking.
2. Bak de rundergehakt 5% in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok sperziebonen beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat pasta (dry) per the package.
2. Pan-fry the lean beef mince 5% in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the green beans until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('beef_mince_with_pasta_spinach','Rundergehakt met pasta & spinazie','Beef mince with pasta & spinach',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"lean_beef_5","g":130},{"slug":"pasta_dry","g":80},{"slug":"spinach","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['pastabol']::text[],'1. Kook de volkoren pasta (droog) volgens de verpakking.
2. Bak de rundergehakt 5% in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok spinazie beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat pasta (dry) per the package.
2. Pan-fry the lean beef mince 5% in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the spinach until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('beef_mince_with_pasta_asparagus','Rundergehakt met pasta & asperges','Beef mince with pasta & asparagus',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"lean_beef_5","g":130},{"slug":"pasta_dry","g":80},{"slug":"asparagus","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['pastabol']::text[],'1. Kook de volkoren pasta (droog) volgens de verpakking.
2. Bak de rundergehakt 5% in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok asperges beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat pasta (dry) per the package.
2. Pan-fry the lean beef mince 5% in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the asparagus until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('beef_mince_with_pasta_zucchini','Rundergehakt met pasta & courgette','Beef mince with pasta & zucchini',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"lean_beef_5","g":130},{"slug":"pasta_dry","g":80},{"slug":"zucchini","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['pastabol']::text[],'1. Kook de volkoren pasta (droog) volgens de verpakking.
2. Bak de rundergehakt 5% in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok courgette beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat pasta (dry) per the package.
2. Pan-fry the lean beef mince 5% in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the zucchini until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('beef_mince_with_pasta_stir_fry_veg','Rundergehakt met pasta & wokgroente','Beef mince with pasta & stir-fry veg',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"lean_beef_5","g":130},{"slug":"pasta_dry","g":80},{"slug":"mixed_veg","g":150},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['pastabol']::text[],'1. Kook de volkoren pasta (droog) volgens de verpakking.
2. Bak de rundergehakt 5% in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok wokgroente beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat pasta (dry) per the package.
2. Pan-fry the lean beef mince 5% in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the stir-fry veg until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('beef_mince_with_pasta_mushrooms','Rundergehakt met pasta & champignons','Beef mince with pasta & mushrooms',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"lean_beef_5","g":130},{"slug":"pasta_dry","g":80},{"slug":"mushroom","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['pastabol']::text[],'1. Kook de volkoren pasta (droog) volgens de verpakking.
2. Bak de rundergehakt 5% in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok champignons beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat pasta (dry) per the package.
2. Pan-fry the lean beef mince 5% in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the mushrooms until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('beef_mince_with_pasta_carrot','Rundergehakt met pasta & wortel','Beef mince with pasta & carrot',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"lean_beef_5","g":130},{"slug":"pasta_dry","g":80},{"slug":"carrot","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['pastabol']::text[],'1. Kook de volkoren pasta (droog) volgens de verpakking.
2. Bak de rundergehakt 5% in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok wortel beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat pasta (dry) per the package.
2. Pan-fry the lean beef mince 5% in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the carrot until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('beef_mince_with_pasta_peas','Rundergehakt met pasta & doperwten','Beef mince with pasta & peas',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"lean_beef_5","g":130},{"slug":"pasta_dry","g":80},{"slug":"peas","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['pastabol']::text[],'1. Kook de volkoren pasta (droog) volgens de verpakking.
2. Bak de rundergehakt 5% in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok doperwten beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat pasta (dry) per the package.
2. Pan-fry the lean beef mince 5% in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the peas until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('beef_mince_with_pasta_cauliflower','Rundergehakt met pasta & bloemkool','Beef mince with pasta & cauliflower',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"lean_beef_5","g":130},{"slug":"pasta_dry","g":80},{"slug":"cauliflower","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['pastabol']::text[],'1. Kook de volkoren pasta (droog) volgens de verpakking.
2. Bak de rundergehakt 5% in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok bloemkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat pasta (dry) per the package.
2. Pan-fry the lean beef mince 5% in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the cauliflower until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('beef_mince_with_pasta_kale','Rundergehakt met pasta & boerenkool','Beef mince with pasta & kale',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"lean_beef_5","g":130},{"slug":"pasta_dry","g":80},{"slug":"kale","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['pastabol']::text[],'1. Kook de volkoren pasta (droog) volgens de verpakking.
2. Bak de rundergehakt 5% in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok boerenkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat pasta (dry) per the package.
2. Pan-fry the lean beef mince 5% in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the kale until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('beef_mince_with_pasta_bok_choy','Rundergehakt met pasta & paksoi','Beef mince with pasta & bok choy',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"lean_beef_5","g":130},{"slug":"pasta_dry","g":80},{"slug":"bok_choy","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['pastabol']::text[],'1. Kook de volkoren pasta (droog) volgens de verpakking.
2. Bak de rundergehakt 5% in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok paksoi beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat pasta (dry) per the package.
2. Pan-fry the lean beef mince 5% in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the bok choy until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('beef_mince_with_quinoa_broccoli','Rundergehakt met quinoa & broccoli','Beef mince with quinoa & broccoli',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"lean_beef_5","g":130},{"slug":"quinoa_dry","g":70},{"slug":"broccoli","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['pastabol']::text[],'1. Kook de quinoa (droog) volgens de verpakking.
2. Bak de rundergehakt 5% in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok broccoli beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the quinoa (dry) per the package.
2. Pan-fry the lean beef mince 5% in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the broccoli until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('beef_mince_with_quinoa_green_beans','Rundergehakt met quinoa & sperziebonen','Beef mince with quinoa & green beans',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"lean_beef_5","g":130},{"slug":"quinoa_dry","g":70},{"slug":"green_beans","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['pastabol']::text[],'1. Kook de quinoa (droog) volgens de verpakking.
2. Bak de rundergehakt 5% in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok sperziebonen beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the quinoa (dry) per the package.
2. Pan-fry the lean beef mince 5% in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the green beans until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('beef_mince_with_quinoa_spinach','Rundergehakt met quinoa & spinazie','Beef mince with quinoa & spinach',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"lean_beef_5","g":130},{"slug":"quinoa_dry","g":70},{"slug":"spinach","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['pastabol']::text[],'1. Kook de quinoa (droog) volgens de verpakking.
2. Bak de rundergehakt 5% in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok spinazie beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the quinoa (dry) per the package.
2. Pan-fry the lean beef mince 5% in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the spinach until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('beef_mince_with_quinoa_asparagus','Rundergehakt met quinoa & asperges','Beef mince with quinoa & asparagus',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"lean_beef_5","g":130},{"slug":"quinoa_dry","g":70},{"slug":"asparagus","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['pastabol']::text[],'1. Kook de quinoa (droog) volgens de verpakking.
2. Bak de rundergehakt 5% in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok asperges beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the quinoa (dry) per the package.
2. Pan-fry the lean beef mince 5% in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the asparagus until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('beef_mince_with_quinoa_zucchini','Rundergehakt met quinoa & courgette','Beef mince with quinoa & zucchini',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"lean_beef_5","g":130},{"slug":"quinoa_dry","g":70},{"slug":"zucchini","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['pastabol']::text[],'1. Kook de quinoa (droog) volgens de verpakking.
2. Bak de rundergehakt 5% in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok courgette beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the quinoa (dry) per the package.
2. Pan-fry the lean beef mince 5% in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the zucchini until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('beef_mince_with_quinoa_stir_fry_veg','Rundergehakt met quinoa & wokgroente','Beef mince with quinoa & stir-fry veg',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"lean_beef_5","g":130},{"slug":"quinoa_dry","g":70},{"slug":"mixed_veg","g":150},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['pastabol']::text[],'1. Kook de quinoa (droog) volgens de verpakking.
2. Bak de rundergehakt 5% in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok wokgroente beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the quinoa (dry) per the package.
2. Pan-fry the lean beef mince 5% in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the stir-fry veg until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('beef_mince_with_quinoa_mushrooms','Rundergehakt met quinoa & champignons','Beef mince with quinoa & mushrooms',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"lean_beef_5","g":130},{"slug":"quinoa_dry","g":70},{"slug":"mushroom","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['pastabol']::text[],'1. Kook de quinoa (droog) volgens de verpakking.
2. Bak de rundergehakt 5% in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok champignons beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the quinoa (dry) per the package.
2. Pan-fry the lean beef mince 5% in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the mushrooms until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('beef_mince_with_quinoa_carrot','Rundergehakt met quinoa & wortel','Beef mince with quinoa & carrot',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"lean_beef_5","g":130},{"slug":"quinoa_dry","g":70},{"slug":"carrot","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['pastabol']::text[],'1. Kook de quinoa (droog) volgens de verpakking.
2. Bak de rundergehakt 5% in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok wortel beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the quinoa (dry) per the package.
2. Pan-fry the lean beef mince 5% in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the carrot until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('beef_mince_with_quinoa_peas','Rundergehakt met quinoa & doperwten','Beef mince with quinoa & peas',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"lean_beef_5","g":130},{"slug":"quinoa_dry","g":70},{"slug":"peas","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['pastabol']::text[],'1. Kook de quinoa (droog) volgens de verpakking.
2. Bak de rundergehakt 5% in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok doperwten beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the quinoa (dry) per the package.
2. Pan-fry the lean beef mince 5% in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the peas until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('beef_mince_with_quinoa_cauliflower','Rundergehakt met quinoa & bloemkool','Beef mince with quinoa & cauliflower',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"lean_beef_5","g":130},{"slug":"quinoa_dry","g":70},{"slug":"cauliflower","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['pastabol']::text[],'1. Kook de quinoa (droog) volgens de verpakking.
2. Bak de rundergehakt 5% in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok bloemkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the quinoa (dry) per the package.
2. Pan-fry the lean beef mince 5% in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the cauliflower until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('beef_mince_with_quinoa_kale','Rundergehakt met quinoa & boerenkool','Beef mince with quinoa & kale',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"lean_beef_5","g":130},{"slug":"quinoa_dry","g":70},{"slug":"kale","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['pastabol']::text[],'1. Kook de quinoa (droog) volgens de verpakking.
2. Bak de rundergehakt 5% in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok boerenkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the quinoa (dry) per the package.
2. Pan-fry the lean beef mince 5% in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the kale until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('beef_mince_with_quinoa_bok_choy','Rundergehakt met quinoa & paksoi','Beef mince with quinoa & bok choy',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"lean_beef_5","g":130},{"slug":"quinoa_dry","g":70},{"slug":"bok_choy","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['pastabol']::text[],'1. Kook de quinoa (droog) volgens de verpakking.
2. Bak de rundergehakt 5% in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok paksoi beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the quinoa (dry) per the package.
2. Pan-fry the lean beef mince 5% in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the bok choy until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('beef_mince_with_noodles_broccoli','Rundergehakt met noedels & broccoli','Beef mince with noodles & broccoli',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"lean_beef_5","g":130},{"slug":"noodles_dry","g":80},{"slug":"broccoli","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['pastabol','woknoodles']::text[],'1. Kook de volkoren noedels (droog) volgens de verpakking.
2. Bak de rundergehakt 5% in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok broccoli beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat noodles (dry) per the package.
2. Pan-fry the lean beef mince 5% in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the broccoli until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('beef_mince_with_noodles_green_beans','Rundergehakt met noedels & sperziebonen','Beef mince with noodles & green beans',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"lean_beef_5","g":130},{"slug":"noodles_dry","g":80},{"slug":"green_beans","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['pastabol','woknoodles']::text[],'1. Kook de volkoren noedels (droog) volgens de verpakking.
2. Bak de rundergehakt 5% in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok sperziebonen beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat noodles (dry) per the package.
2. Pan-fry the lean beef mince 5% in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the green beans until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('beef_mince_with_noodles_spinach','Rundergehakt met noedels & spinazie','Beef mince with noodles & spinach',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"lean_beef_5","g":130},{"slug":"noodles_dry","g":80},{"slug":"spinach","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['pastabol','woknoodles']::text[],'1. Kook de volkoren noedels (droog) volgens de verpakking.
2. Bak de rundergehakt 5% in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok spinazie beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat noodles (dry) per the package.
2. Pan-fry the lean beef mince 5% in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the spinach until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('beef_mince_with_noodles_asparagus','Rundergehakt met noedels & asperges','Beef mince with noodles & asparagus',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"lean_beef_5","g":130},{"slug":"noodles_dry","g":80},{"slug":"asparagus","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['pastabol','woknoodles']::text[],'1. Kook de volkoren noedels (droog) volgens de verpakking.
2. Bak de rundergehakt 5% in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok asperges beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat noodles (dry) per the package.
2. Pan-fry the lean beef mince 5% in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the asparagus until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('beef_mince_with_noodles_zucchini','Rundergehakt met noedels & courgette','Beef mince with noodles & zucchini',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"lean_beef_5","g":130},{"slug":"noodles_dry","g":80},{"slug":"zucchini","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['pastabol','woknoodles']::text[],'1. Kook de volkoren noedels (droog) volgens de verpakking.
2. Bak de rundergehakt 5% in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok courgette beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat noodles (dry) per the package.
2. Pan-fry the lean beef mince 5% in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the zucchini until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('beef_mince_with_noodles_stir_fry_veg','Rundergehakt met noedels & wokgroente','Beef mince with noodles & stir-fry veg',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"lean_beef_5","g":130},{"slug":"noodles_dry","g":80},{"slug":"mixed_veg","g":150},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['pastabol','woknoodles']::text[],'1. Kook de volkoren noedels (droog) volgens de verpakking.
2. Bak de rundergehakt 5% in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok wokgroente beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat noodles (dry) per the package.
2. Pan-fry the lean beef mince 5% in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the stir-fry veg until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('beef_mince_with_noodles_mushrooms','Rundergehakt met noedels & champignons','Beef mince with noodles & mushrooms',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"lean_beef_5","g":130},{"slug":"noodles_dry","g":80},{"slug":"mushroom","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['pastabol','woknoodles']::text[],'1. Kook de volkoren noedels (droog) volgens de verpakking.
2. Bak de rundergehakt 5% in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok champignons beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat noodles (dry) per the package.
2. Pan-fry the lean beef mince 5% in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the mushrooms until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('beef_mince_with_noodles_carrot','Rundergehakt met noedels & wortel','Beef mince with noodles & carrot',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"lean_beef_5","g":130},{"slug":"noodles_dry","g":80},{"slug":"carrot","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['pastabol','woknoodles']::text[],'1. Kook de volkoren noedels (droog) volgens de verpakking.
2. Bak de rundergehakt 5% in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok wortel beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat noodles (dry) per the package.
2. Pan-fry the lean beef mince 5% in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the carrot until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('beef_mince_with_noodles_peas','Rundergehakt met noedels & doperwten','Beef mince with noodles & peas',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"lean_beef_5","g":130},{"slug":"noodles_dry","g":80},{"slug":"peas","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['pastabol','woknoodles']::text[],'1. Kook de volkoren noedels (droog) volgens de verpakking.
2. Bak de rundergehakt 5% in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok doperwten beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat noodles (dry) per the package.
2. Pan-fry the lean beef mince 5% in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the peas until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('beef_mince_with_noodles_cauliflower','Rundergehakt met noedels & bloemkool','Beef mince with noodles & cauliflower',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"lean_beef_5","g":130},{"slug":"noodles_dry","g":80},{"slug":"cauliflower","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['pastabol','woknoodles']::text[],'1. Kook de volkoren noedels (droog) volgens de verpakking.
2. Bak de rundergehakt 5% in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok bloemkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat noodles (dry) per the package.
2. Pan-fry the lean beef mince 5% in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the cauliflower until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('beef_mince_with_noodles_kale','Rundergehakt met noedels & boerenkool','Beef mince with noodles & kale',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"lean_beef_5","g":130},{"slug":"noodles_dry","g":80},{"slug":"kale","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['pastabol','woknoodles']::text[],'1. Kook de volkoren noedels (droog) volgens de verpakking.
2. Bak de rundergehakt 5% in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok boerenkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat noodles (dry) per the package.
2. Pan-fry the lean beef mince 5% in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the kale until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('beef_mince_with_noodles_bok_choy','Rundergehakt met noedels & paksoi','Beef mince with noodles & bok choy',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"lean_beef_5","g":130},{"slug":"noodles_dry","g":80},{"slug":"bok_choy","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['pastabol','woknoodles']::text[],'1. Kook de volkoren noedels (droog) volgens de verpakking.
2. Bak de rundergehakt 5% in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok paksoi beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat noodles (dry) per the package.
2. Pan-fry the lean beef mince 5% in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the bok choy until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('beef_mince_with_couscous_broccoli','Rundergehakt met couscous & broccoli','Beef mince with couscous & broccoli',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"lean_beef_5","g":130},{"slug":"couscous_dry","g":70},{"slug":"broccoli","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['pastabol']::text[],'1. Kook de volkoren couscous (droog) volgens de verpakking.
2. Bak de rundergehakt 5% in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok broccoli beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat couscous (dry) per the package.
2. Pan-fry the lean beef mince 5% in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the broccoli until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('beef_mince_with_couscous_green_beans','Rundergehakt met couscous & sperziebonen','Beef mince with couscous & green beans',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"lean_beef_5","g":130},{"slug":"couscous_dry","g":70},{"slug":"green_beans","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['pastabol']::text[],'1. Kook de volkoren couscous (droog) volgens de verpakking.
2. Bak de rundergehakt 5% in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok sperziebonen beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat couscous (dry) per the package.
2. Pan-fry the lean beef mince 5% in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the green beans until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('beef_mince_with_couscous_spinach','Rundergehakt met couscous & spinazie','Beef mince with couscous & spinach',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"lean_beef_5","g":130},{"slug":"couscous_dry","g":70},{"slug":"spinach","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['pastabol']::text[],'1. Kook de volkoren couscous (droog) volgens de verpakking.
2. Bak de rundergehakt 5% in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok spinazie beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat couscous (dry) per the package.
2. Pan-fry the lean beef mince 5% in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the spinach until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('beef_mince_with_couscous_asparagus','Rundergehakt met couscous & asperges','Beef mince with couscous & asparagus',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"lean_beef_5","g":130},{"slug":"couscous_dry","g":70},{"slug":"asparagus","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['pastabol']::text[],'1. Kook de volkoren couscous (droog) volgens de verpakking.
2. Bak de rundergehakt 5% in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok asperges beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat couscous (dry) per the package.
2. Pan-fry the lean beef mince 5% in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the asparagus until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('beef_mince_with_couscous_zucchini','Rundergehakt met couscous & courgette','Beef mince with couscous & zucchini',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"lean_beef_5","g":130},{"slug":"couscous_dry","g":70},{"slug":"zucchini","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['pastabol']::text[],'1. Kook de volkoren couscous (droog) volgens de verpakking.
2. Bak de rundergehakt 5% in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok courgette beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat couscous (dry) per the package.
2. Pan-fry the lean beef mince 5% in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the zucchini until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('beef_mince_with_couscous_stir_fry_veg','Rundergehakt met couscous & wokgroente','Beef mince with couscous & stir-fry veg',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"lean_beef_5","g":130},{"slug":"couscous_dry","g":70},{"slug":"mixed_veg","g":150},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['pastabol']::text[],'1. Kook de volkoren couscous (droog) volgens de verpakking.
2. Bak de rundergehakt 5% in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok wokgroente beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat couscous (dry) per the package.
2. Pan-fry the lean beef mince 5% in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the stir-fry veg until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('beef_mince_with_couscous_mushrooms','Rundergehakt met couscous & champignons','Beef mince with couscous & mushrooms',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"lean_beef_5","g":130},{"slug":"couscous_dry","g":70},{"slug":"mushroom","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['pastabol']::text[],'1. Kook de volkoren couscous (droog) volgens de verpakking.
2. Bak de rundergehakt 5% in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok champignons beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat couscous (dry) per the package.
2. Pan-fry the lean beef mince 5% in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the mushrooms until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('beef_mince_with_couscous_carrot','Rundergehakt met couscous & wortel','Beef mince with couscous & carrot',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"lean_beef_5","g":130},{"slug":"couscous_dry","g":70},{"slug":"carrot","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['pastabol']::text[],'1. Kook de volkoren couscous (droog) volgens de verpakking.
2. Bak de rundergehakt 5% in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok wortel beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat couscous (dry) per the package.
2. Pan-fry the lean beef mince 5% in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the carrot until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('beef_mince_with_couscous_peas','Rundergehakt met couscous & doperwten','Beef mince with couscous & peas',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"lean_beef_5","g":130},{"slug":"couscous_dry","g":70},{"slug":"peas","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['pastabol']::text[],'1. Kook de volkoren couscous (droog) volgens de verpakking.
2. Bak de rundergehakt 5% in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok doperwten beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat couscous (dry) per the package.
2. Pan-fry the lean beef mince 5% in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the peas until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('beef_mince_with_couscous_cauliflower','Rundergehakt met couscous & bloemkool','Beef mince with couscous & cauliflower',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"lean_beef_5","g":130},{"slug":"couscous_dry","g":70},{"slug":"cauliflower","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['pastabol']::text[],'1. Kook de volkoren couscous (droog) volgens de verpakking.
2. Bak de rundergehakt 5% in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok bloemkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat couscous (dry) per the package.
2. Pan-fry the lean beef mince 5% in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the cauliflower until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('beef_mince_with_couscous_kale','Rundergehakt met couscous & boerenkool','Beef mince with couscous & kale',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"lean_beef_5","g":130},{"slug":"couscous_dry","g":70},{"slug":"kale","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['pastabol']::text[],'1. Kook de volkoren couscous (droog) volgens de verpakking.
2. Bak de rundergehakt 5% in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok boerenkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat couscous (dry) per the package.
2. Pan-fry the lean beef mince 5% in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the kale until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('beef_mince_with_couscous_bok_choy','Rundergehakt met couscous & paksoi','Beef mince with couscous & bok choy',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"lean_beef_5","g":130},{"slug":"couscous_dry","g":70},{"slug":"bok_choy","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['pastabol']::text[],'1. Kook de volkoren couscous (droog) volgens de verpakking.
2. Bak de rundergehakt 5% in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok paksoi beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat couscous (dry) per the package.
2. Pan-fry the lean beef mince 5% in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the bok choy until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('beef_mince_with_bulgur_broccoli','Rundergehakt met bulgur & broccoli','Beef mince with bulgur & broccoli',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"lean_beef_5","g":130},{"slug":"bulgur_dry","g":70},{"slug":"broccoli","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['pastabol']::text[],'1. Kook de bulgur (droog) volgens de verpakking.
2. Bak de rundergehakt 5% in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok broccoli beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the bulgur (dry) per the package.
2. Pan-fry the lean beef mince 5% in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the broccoli until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('beef_mince_with_bulgur_green_beans','Rundergehakt met bulgur & sperziebonen','Beef mince with bulgur & green beans',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"lean_beef_5","g":130},{"slug":"bulgur_dry","g":70},{"slug":"green_beans","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['pastabol']::text[],'1. Kook de bulgur (droog) volgens de verpakking.
2. Bak de rundergehakt 5% in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok sperziebonen beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the bulgur (dry) per the package.
2. Pan-fry the lean beef mince 5% in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the green beans until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('beef_mince_with_bulgur_spinach','Rundergehakt met bulgur & spinazie','Beef mince with bulgur & spinach',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"lean_beef_5","g":130},{"slug":"bulgur_dry","g":70},{"slug":"spinach","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['pastabol']::text[],'1. Kook de bulgur (droog) volgens de verpakking.
2. Bak de rundergehakt 5% in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok spinazie beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the bulgur (dry) per the package.
2. Pan-fry the lean beef mince 5% in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the spinach until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('beef_mince_with_bulgur_asparagus','Rundergehakt met bulgur & asperges','Beef mince with bulgur & asparagus',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"lean_beef_5","g":130},{"slug":"bulgur_dry","g":70},{"slug":"asparagus","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['pastabol']::text[],'1. Kook de bulgur (droog) volgens de verpakking.
2. Bak de rundergehakt 5% in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok asperges beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the bulgur (dry) per the package.
2. Pan-fry the lean beef mince 5% in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the asparagus until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('beef_mince_with_bulgur_zucchini','Rundergehakt met bulgur & courgette','Beef mince with bulgur & zucchini',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"lean_beef_5","g":130},{"slug":"bulgur_dry","g":70},{"slug":"zucchini","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['pastabol']::text[],'1. Kook de bulgur (droog) volgens de verpakking.
2. Bak de rundergehakt 5% in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok courgette beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the bulgur (dry) per the package.
2. Pan-fry the lean beef mince 5% in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the zucchini until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('beef_mince_with_bulgur_stir_fry_veg','Rundergehakt met bulgur & wokgroente','Beef mince with bulgur & stir-fry veg',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"lean_beef_5","g":130},{"slug":"bulgur_dry","g":70},{"slug":"mixed_veg","g":150},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['pastabol']::text[],'1. Kook de bulgur (droog) volgens de verpakking.
2. Bak de rundergehakt 5% in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok wokgroente beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the bulgur (dry) per the package.
2. Pan-fry the lean beef mince 5% in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the stir-fry veg until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('beef_mince_with_bulgur_mushrooms','Rundergehakt met bulgur & champignons','Beef mince with bulgur & mushrooms',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"lean_beef_5","g":130},{"slug":"bulgur_dry","g":70},{"slug":"mushroom","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['pastabol']::text[],'1. Kook de bulgur (droog) volgens de verpakking.
2. Bak de rundergehakt 5% in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok champignons beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the bulgur (dry) per the package.
2. Pan-fry the lean beef mince 5% in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the mushrooms until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('beef_mince_with_bulgur_carrot','Rundergehakt met bulgur & wortel','Beef mince with bulgur & carrot',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"lean_beef_5","g":130},{"slug":"bulgur_dry","g":70},{"slug":"carrot","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['pastabol']::text[],'1. Kook de bulgur (droog) volgens de verpakking.
2. Bak de rundergehakt 5% in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok wortel beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the bulgur (dry) per the package.
2. Pan-fry the lean beef mince 5% in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the carrot until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('beef_mince_with_bulgur_peas','Rundergehakt met bulgur & doperwten','Beef mince with bulgur & peas',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"lean_beef_5","g":130},{"slug":"bulgur_dry","g":70},{"slug":"peas","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['pastabol']::text[],'1. Kook de bulgur (droog) volgens de verpakking.
2. Bak de rundergehakt 5% in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok doperwten beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the bulgur (dry) per the package.
2. Pan-fry the lean beef mince 5% in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the peas until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('beef_mince_with_bulgur_cauliflower','Rundergehakt met bulgur & bloemkool','Beef mince with bulgur & cauliflower',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"lean_beef_5","g":130},{"slug":"bulgur_dry","g":70},{"slug":"cauliflower","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['pastabol']::text[],'1. Kook de bulgur (droog) volgens de verpakking.
2. Bak de rundergehakt 5% in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok bloemkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the bulgur (dry) per the package.
2. Pan-fry the lean beef mince 5% in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the cauliflower until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('beef_mince_with_bulgur_kale','Rundergehakt met bulgur & boerenkool','Beef mince with bulgur & kale',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"lean_beef_5","g":130},{"slug":"bulgur_dry","g":70},{"slug":"kale","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['pastabol']::text[],'1. Kook de bulgur (droog) volgens de verpakking.
2. Bak de rundergehakt 5% in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok boerenkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the bulgur (dry) per the package.
2. Pan-fry the lean beef mince 5% in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the kale until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('beef_mince_with_bulgur_bok_choy','Rundergehakt met bulgur & paksoi','Beef mince with bulgur & bok choy',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"lean_beef_5","g":130},{"slug":"bulgur_dry","g":70},{"slug":"bok_choy","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['pastabol']::text[],'1. Kook de bulgur (droog) volgens de verpakking.
2. Bak de rundergehakt 5% in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok paksoi beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the bulgur (dry) per the package.
2. Pan-fry the lean beef mince 5% in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the bok choy until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('beef_mince_with_basmati_rice_broccoli','Rundergehakt met basmatirijst & broccoli','Beef mince with basmati rice & broccoli',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"lean_beef_5","g":130},{"slug":"basmati_dry","g":70},{"slug":"broccoli","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['pastabol']::text[],'1. Kook de basmatirijst (droog) volgens de verpakking.
2. Bak de rundergehakt 5% in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok broccoli beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the basmati rice (dry) per the package.
2. Pan-fry the lean beef mince 5% in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the broccoli until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('beef_mince_with_basmati_rice_green_beans','Rundergehakt met basmatirijst & sperziebonen','Beef mince with basmati rice & green beans',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"lean_beef_5","g":130},{"slug":"basmati_dry","g":70},{"slug":"green_beans","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['pastabol']::text[],'1. Kook de basmatirijst (droog) volgens de verpakking.
2. Bak de rundergehakt 5% in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok sperziebonen beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the basmati rice (dry) per the package.
2. Pan-fry the lean beef mince 5% in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the green beans until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('beef_mince_with_basmati_rice_spinach','Rundergehakt met basmatirijst & spinazie','Beef mince with basmati rice & spinach',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"lean_beef_5","g":130},{"slug":"basmati_dry","g":70},{"slug":"spinach","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['pastabol']::text[],'1. Kook de basmatirijst (droog) volgens de verpakking.
2. Bak de rundergehakt 5% in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok spinazie beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the basmati rice (dry) per the package.
2. Pan-fry the lean beef mince 5% in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the spinach until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('beef_mince_with_basmati_rice_asparagus','Rundergehakt met basmatirijst & asperges','Beef mince with basmati rice & asparagus',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"lean_beef_5","g":130},{"slug":"basmati_dry","g":70},{"slug":"asparagus","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['pastabol']::text[],'1. Kook de basmatirijst (droog) volgens de verpakking.
2. Bak de rundergehakt 5% in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok asperges beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the basmati rice (dry) per the package.
2. Pan-fry the lean beef mince 5% in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the asparagus until tender-crisp.
4. Plate up and finish.','pan',null,'core')
on conflict (slug) do update set name_nl=excluded.name_nl,name_en=excluded.name_en,moments=excluded.moments,goals=excluded.goals,items=excluded.items,tags=excluded.tags,prefs=excluded.prefs,steps=excluded.steps,steps_en=excluded.steps_en,technique=excluded.technique,temp=excluded.temp;
commit;
