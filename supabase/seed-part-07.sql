-- AUTO-GEGENEREERD core-seed deel 7/9 (200 gerechten). Draai NA dish-library.sql.
-- Draai de delen op volgorde (01, 02, ...). Elk deel is los veilig (upsert).
begin;
insert into public.dishes (slug,name_nl,name_en,moments,goals,items,tags,prefs,steps,steps_en,technique,temp,source) values
('white_fish_with_noodles_broccoli','Witvis met noedels & broccoli','White fish with noodles & broccoli',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"white_fish","g":170},{"slug":"noodles_dry","g":80},{"slug":"broccoli","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['woknoodles']::text[],'1. Kook de volkoren noedels (droog) volgens de verpakking.
2. Bak of pocheer de witvis (tilapia) kort tot net gaar; kruid met peper en zout.
3. Stoom of wok broccoli beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat noodles (dry) per the package.
2. Sear or poach the white fish (tilapia) until just done; season with salt and pepper.
3. Steam or stir-fry the broccoli until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('white_fish_with_noodles_green_beans','Witvis met noedels & sperziebonen','White fish with noodles & green beans',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"white_fish","g":170},{"slug":"noodles_dry","g":80},{"slug":"green_beans","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['woknoodles']::text[],'1. Kook de volkoren noedels (droog) volgens de verpakking.
2. Bak of pocheer de witvis (tilapia) kort tot net gaar; kruid met peper en zout.
3. Stoom of wok sperziebonen beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat noodles (dry) per the package.
2. Sear or poach the white fish (tilapia) until just done; season with salt and pepper.
3. Steam or stir-fry the green beans until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('white_fish_with_noodles_spinach','Witvis met noedels & spinazie','White fish with noodles & spinach',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"white_fish","g":170},{"slug":"noodles_dry","g":80},{"slug":"spinach","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['woknoodles']::text[],'1. Kook de volkoren noedels (droog) volgens de verpakking.
2. Bak of pocheer de witvis (tilapia) kort tot net gaar; kruid met peper en zout.
3. Stoom of wok spinazie beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat noodles (dry) per the package.
2. Sear or poach the white fish (tilapia) until just done; season with salt and pepper.
3. Steam or stir-fry the spinach until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('white_fish_with_noodles_asparagus','Witvis met noedels & asperges','White fish with noodles & asparagus',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"white_fish","g":170},{"slug":"noodles_dry","g":80},{"slug":"asparagus","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['woknoodles']::text[],'1. Kook de volkoren noedels (droog) volgens de verpakking.
2. Bak of pocheer de witvis (tilapia) kort tot net gaar; kruid met peper en zout.
3. Stoom of wok asperges beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat noodles (dry) per the package.
2. Sear or poach the white fish (tilapia) until just done; season with salt and pepper.
3. Steam or stir-fry the asparagus until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('white_fish_with_noodles_zucchini','Witvis met noedels & courgette','White fish with noodles & zucchini',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"white_fish","g":170},{"slug":"noodles_dry","g":80},{"slug":"zucchini","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['woknoodles']::text[],'1. Kook de volkoren noedels (droog) volgens de verpakking.
2. Bak of pocheer de witvis (tilapia) kort tot net gaar; kruid met peper en zout.
3. Stoom of wok courgette beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat noodles (dry) per the package.
2. Sear or poach the white fish (tilapia) until just done; season with salt and pepper.
3. Steam or stir-fry the zucchini until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('white_fish_with_noodles_stir_fry_veg','Witvis met noedels & wokgroente','White fish with noodles & stir-fry veg',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"white_fish","g":170},{"slug":"noodles_dry","g":80},{"slug":"mixed_veg","g":150},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['woknoodles']::text[],'1. Kook de volkoren noedels (droog) volgens de verpakking.
2. Bak of pocheer de witvis (tilapia) kort tot net gaar; kruid met peper en zout.
3. Stoom of wok wokgroente beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat noodles (dry) per the package.
2. Sear or poach the white fish (tilapia) until just done; season with salt and pepper.
3. Steam or stir-fry the stir-fry veg until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('white_fish_with_noodles_mushrooms','Witvis met noedels & champignons','White fish with noodles & mushrooms',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"white_fish","g":170},{"slug":"noodles_dry","g":80},{"slug":"mushroom","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['woknoodles']::text[],'1. Kook de volkoren noedels (droog) volgens de verpakking.
2. Bak of pocheer de witvis (tilapia) kort tot net gaar; kruid met peper en zout.
3. Stoom of wok champignons beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat noodles (dry) per the package.
2. Sear or poach the white fish (tilapia) until just done; season with salt and pepper.
3. Steam or stir-fry the mushrooms until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('white_fish_with_noodles_carrot','Witvis met noedels & wortel','White fish with noodles & carrot',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"white_fish","g":170},{"slug":"noodles_dry","g":80},{"slug":"carrot","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['woknoodles']::text[],'1. Kook de volkoren noedels (droog) volgens de verpakking.
2. Bak of pocheer de witvis (tilapia) kort tot net gaar; kruid met peper en zout.
3. Stoom of wok wortel beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat noodles (dry) per the package.
2. Sear or poach the white fish (tilapia) until just done; season with salt and pepper.
3. Steam or stir-fry the carrot until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('white_fish_with_noodles_peas','Witvis met noedels & doperwten','White fish with noodles & peas',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"white_fish","g":170},{"slug":"noodles_dry","g":80},{"slug":"peas","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['woknoodles']::text[],'1. Kook de volkoren noedels (droog) volgens de verpakking.
2. Bak of pocheer de witvis (tilapia) kort tot net gaar; kruid met peper en zout.
3. Stoom of wok doperwten beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat noodles (dry) per the package.
2. Sear or poach the white fish (tilapia) until just done; season with salt and pepper.
3. Steam or stir-fry the peas until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('white_fish_with_noodles_cauliflower','Witvis met noedels & bloemkool','White fish with noodles & cauliflower',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"white_fish","g":170},{"slug":"noodles_dry","g":80},{"slug":"cauliflower","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['woknoodles']::text[],'1. Kook de volkoren noedels (droog) volgens de verpakking.
2. Bak of pocheer de witvis (tilapia) kort tot net gaar; kruid met peper en zout.
3. Stoom of wok bloemkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat noodles (dry) per the package.
2. Sear or poach the white fish (tilapia) until just done; season with salt and pepper.
3. Steam or stir-fry the cauliflower until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('white_fish_with_noodles_kale','Witvis met noedels & boerenkool','White fish with noodles & kale',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"white_fish","g":170},{"slug":"noodles_dry","g":80},{"slug":"kale","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['woknoodles']::text[],'1. Kook de volkoren noedels (droog) volgens de verpakking.
2. Bak of pocheer de witvis (tilapia) kort tot net gaar; kruid met peper en zout.
3. Stoom of wok boerenkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat noodles (dry) per the package.
2. Sear or poach the white fish (tilapia) until just done; season with salt and pepper.
3. Steam or stir-fry the kale until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('white_fish_with_noodles_bok_choy','Witvis met noedels & paksoi','White fish with noodles & bok choy',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"white_fish","g":170},{"slug":"noodles_dry","g":80},{"slug":"bok_choy","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['woknoodles']::text[],'1. Kook de volkoren noedels (droog) volgens de verpakking.
2. Bak of pocheer de witvis (tilapia) kort tot net gaar; kruid met peper en zout.
3. Stoom of wok paksoi beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat noodles (dry) per the package.
2. Sear or poach the white fish (tilapia) until just done; season with salt and pepper.
3. Steam or stir-fry the bok choy until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('white_fish_with_couscous_broccoli','Witvis met couscous & broccoli','White fish with couscous & broccoli',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"white_fish","g":170},{"slug":"couscous_dry","g":70},{"slug":"broccoli","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de volkoren couscous (droog) volgens de verpakking.
2. Bak of pocheer de witvis (tilapia) kort tot net gaar; kruid met peper en zout.
3. Stoom of wok broccoli beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat couscous (dry) per the package.
2. Sear or poach the white fish (tilapia) until just done; season with salt and pepper.
3. Steam or stir-fry the broccoli until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('white_fish_with_couscous_green_beans','Witvis met couscous & sperziebonen','White fish with couscous & green beans',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"white_fish","g":170},{"slug":"couscous_dry","g":70},{"slug":"green_beans","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de volkoren couscous (droog) volgens de verpakking.
2. Bak of pocheer de witvis (tilapia) kort tot net gaar; kruid met peper en zout.
3. Stoom of wok sperziebonen beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat couscous (dry) per the package.
2. Sear or poach the white fish (tilapia) until just done; season with salt and pepper.
3. Steam or stir-fry the green beans until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('white_fish_with_couscous_spinach','Witvis met couscous & spinazie','White fish with couscous & spinach',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"white_fish","g":170},{"slug":"couscous_dry","g":70},{"slug":"spinach","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de volkoren couscous (droog) volgens de verpakking.
2. Bak of pocheer de witvis (tilapia) kort tot net gaar; kruid met peper en zout.
3. Stoom of wok spinazie beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat couscous (dry) per the package.
2. Sear or poach the white fish (tilapia) until just done; season with salt and pepper.
3. Steam or stir-fry the spinach until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('white_fish_with_couscous_asparagus','Witvis met couscous & asperges','White fish with couscous & asparagus',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"white_fish","g":170},{"slug":"couscous_dry","g":70},{"slug":"asparagus","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de volkoren couscous (droog) volgens de verpakking.
2. Bak of pocheer de witvis (tilapia) kort tot net gaar; kruid met peper en zout.
3. Stoom of wok asperges beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat couscous (dry) per the package.
2. Sear or poach the white fish (tilapia) until just done; season with salt and pepper.
3. Steam or stir-fry the asparagus until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('white_fish_with_couscous_zucchini','Witvis met couscous & courgette','White fish with couscous & zucchini',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"white_fish","g":170},{"slug":"couscous_dry","g":70},{"slug":"zucchini","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de volkoren couscous (droog) volgens de verpakking.
2. Bak of pocheer de witvis (tilapia) kort tot net gaar; kruid met peper en zout.
3. Stoom of wok courgette beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat couscous (dry) per the package.
2. Sear or poach the white fish (tilapia) until just done; season with salt and pepper.
3. Steam or stir-fry the zucchini until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('white_fish_with_couscous_stir_fry_veg','Witvis met couscous & wokgroente','White fish with couscous & stir-fry veg',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"white_fish","g":170},{"slug":"couscous_dry","g":70},{"slug":"mixed_veg","g":150},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de volkoren couscous (droog) volgens de verpakking.
2. Bak of pocheer de witvis (tilapia) kort tot net gaar; kruid met peper en zout.
3. Stoom of wok wokgroente beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat couscous (dry) per the package.
2. Sear or poach the white fish (tilapia) until just done; season with salt and pepper.
3. Steam or stir-fry the stir-fry veg until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('white_fish_with_couscous_mushrooms','Witvis met couscous & champignons','White fish with couscous & mushrooms',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"white_fish","g":170},{"slug":"couscous_dry","g":70},{"slug":"mushroom","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de volkoren couscous (droog) volgens de verpakking.
2. Bak of pocheer de witvis (tilapia) kort tot net gaar; kruid met peper en zout.
3. Stoom of wok champignons beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat couscous (dry) per the package.
2. Sear or poach the white fish (tilapia) until just done; season with salt and pepper.
3. Steam or stir-fry the mushrooms until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('white_fish_with_couscous_carrot','Witvis met couscous & wortel','White fish with couscous & carrot',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"white_fish","g":170},{"slug":"couscous_dry","g":70},{"slug":"carrot","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de volkoren couscous (droog) volgens de verpakking.
2. Bak of pocheer de witvis (tilapia) kort tot net gaar; kruid met peper en zout.
3. Stoom of wok wortel beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat couscous (dry) per the package.
2. Sear or poach the white fish (tilapia) until just done; season with salt and pepper.
3. Steam or stir-fry the carrot until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('white_fish_with_couscous_peas','Witvis met couscous & doperwten','White fish with couscous & peas',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"white_fish","g":170},{"slug":"couscous_dry","g":70},{"slug":"peas","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de volkoren couscous (droog) volgens de verpakking.
2. Bak of pocheer de witvis (tilapia) kort tot net gaar; kruid met peper en zout.
3. Stoom of wok doperwten beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat couscous (dry) per the package.
2. Sear or poach the white fish (tilapia) until just done; season with salt and pepper.
3. Steam or stir-fry the peas until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('white_fish_with_couscous_cauliflower','Witvis met couscous & bloemkool','White fish with couscous & cauliflower',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"white_fish","g":170},{"slug":"couscous_dry","g":70},{"slug":"cauliflower","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de volkoren couscous (droog) volgens de verpakking.
2. Bak of pocheer de witvis (tilapia) kort tot net gaar; kruid met peper en zout.
3. Stoom of wok bloemkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat couscous (dry) per the package.
2. Sear or poach the white fish (tilapia) until just done; season with salt and pepper.
3. Steam or stir-fry the cauliflower until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('white_fish_with_couscous_kale','Witvis met couscous & boerenkool','White fish with couscous & kale',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"white_fish","g":170},{"slug":"couscous_dry","g":70},{"slug":"kale","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de volkoren couscous (droog) volgens de verpakking.
2. Bak of pocheer de witvis (tilapia) kort tot net gaar; kruid met peper en zout.
3. Stoom of wok boerenkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat couscous (dry) per the package.
2. Sear or poach the white fish (tilapia) until just done; season with salt and pepper.
3. Steam or stir-fry the kale until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('white_fish_with_couscous_bok_choy','Witvis met couscous & paksoi','White fish with couscous & bok choy',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"white_fish","g":170},{"slug":"couscous_dry","g":70},{"slug":"bok_choy","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de volkoren couscous (droog) volgens de verpakking.
2. Bak of pocheer de witvis (tilapia) kort tot net gaar; kruid met peper en zout.
3. Stoom of wok paksoi beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat couscous (dry) per the package.
2. Sear or poach the white fish (tilapia) until just done; season with salt and pepper.
3. Steam or stir-fry the bok choy until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('white_fish_with_bulgur_broccoli','Witvis met bulgur & broccoli','White fish with bulgur & broccoli',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"white_fish","g":170},{"slug":"bulgur_dry","g":70},{"slug":"broccoli","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de bulgur (droog) volgens de verpakking.
2. Bak of pocheer de witvis (tilapia) kort tot net gaar; kruid met peper en zout.
3. Stoom of wok broccoli beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the bulgur (dry) per the package.
2. Sear or poach the white fish (tilapia) until just done; season with salt and pepper.
3. Steam or stir-fry the broccoli until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('white_fish_with_bulgur_green_beans','Witvis met bulgur & sperziebonen','White fish with bulgur & green beans',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"white_fish","g":170},{"slug":"bulgur_dry","g":70},{"slug":"green_beans","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de bulgur (droog) volgens de verpakking.
2. Bak of pocheer de witvis (tilapia) kort tot net gaar; kruid met peper en zout.
3. Stoom of wok sperziebonen beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the bulgur (dry) per the package.
2. Sear or poach the white fish (tilapia) until just done; season with salt and pepper.
3. Steam or stir-fry the green beans until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('white_fish_with_bulgur_spinach','Witvis met bulgur & spinazie','White fish with bulgur & spinach',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"white_fish","g":170},{"slug":"bulgur_dry","g":70},{"slug":"spinach","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de bulgur (droog) volgens de verpakking.
2. Bak of pocheer de witvis (tilapia) kort tot net gaar; kruid met peper en zout.
3. Stoom of wok spinazie beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the bulgur (dry) per the package.
2. Sear or poach the white fish (tilapia) until just done; season with salt and pepper.
3. Steam or stir-fry the spinach until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('white_fish_with_bulgur_asparagus','Witvis met bulgur & asperges','White fish with bulgur & asparagus',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"white_fish","g":170},{"slug":"bulgur_dry","g":70},{"slug":"asparagus","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de bulgur (droog) volgens de verpakking.
2. Bak of pocheer de witvis (tilapia) kort tot net gaar; kruid met peper en zout.
3. Stoom of wok asperges beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the bulgur (dry) per the package.
2. Sear or poach the white fish (tilapia) until just done; season with salt and pepper.
3. Steam or stir-fry the asparagus until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('white_fish_with_bulgur_zucchini','Witvis met bulgur & courgette','White fish with bulgur & zucchini',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"white_fish","g":170},{"slug":"bulgur_dry","g":70},{"slug":"zucchini","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de bulgur (droog) volgens de verpakking.
2. Bak of pocheer de witvis (tilapia) kort tot net gaar; kruid met peper en zout.
3. Stoom of wok courgette beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the bulgur (dry) per the package.
2. Sear or poach the white fish (tilapia) until just done; season with salt and pepper.
3. Steam or stir-fry the zucchini until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('white_fish_with_bulgur_stir_fry_veg','Witvis met bulgur & wokgroente','White fish with bulgur & stir-fry veg',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"white_fish","g":170},{"slug":"bulgur_dry","g":70},{"slug":"mixed_veg","g":150},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de bulgur (droog) volgens de verpakking.
2. Bak of pocheer de witvis (tilapia) kort tot net gaar; kruid met peper en zout.
3. Stoom of wok wokgroente beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the bulgur (dry) per the package.
2. Sear or poach the white fish (tilapia) until just done; season with salt and pepper.
3. Steam or stir-fry the stir-fry veg until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('white_fish_with_bulgur_mushrooms','Witvis met bulgur & champignons','White fish with bulgur & mushrooms',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"white_fish","g":170},{"slug":"bulgur_dry","g":70},{"slug":"mushroom","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de bulgur (droog) volgens de verpakking.
2. Bak of pocheer de witvis (tilapia) kort tot net gaar; kruid met peper en zout.
3. Stoom of wok champignons beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the bulgur (dry) per the package.
2. Sear or poach the white fish (tilapia) until just done; season with salt and pepper.
3. Steam or stir-fry the mushrooms until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('white_fish_with_bulgur_carrot','Witvis met bulgur & wortel','White fish with bulgur & carrot',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"white_fish","g":170},{"slug":"bulgur_dry","g":70},{"slug":"carrot","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de bulgur (droog) volgens de verpakking.
2. Bak of pocheer de witvis (tilapia) kort tot net gaar; kruid met peper en zout.
3. Stoom of wok wortel beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the bulgur (dry) per the package.
2. Sear or poach the white fish (tilapia) until just done; season with salt and pepper.
3. Steam or stir-fry the carrot until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('white_fish_with_bulgur_peas','Witvis met bulgur & doperwten','White fish with bulgur & peas',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"white_fish","g":170},{"slug":"bulgur_dry","g":70},{"slug":"peas","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de bulgur (droog) volgens de verpakking.
2. Bak of pocheer de witvis (tilapia) kort tot net gaar; kruid met peper en zout.
3. Stoom of wok doperwten beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the bulgur (dry) per the package.
2. Sear or poach the white fish (tilapia) until just done; season with salt and pepper.
3. Steam or stir-fry the peas until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('white_fish_with_bulgur_cauliflower','Witvis met bulgur & bloemkool','White fish with bulgur & cauliflower',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"white_fish","g":170},{"slug":"bulgur_dry","g":70},{"slug":"cauliflower","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de bulgur (droog) volgens de verpakking.
2. Bak of pocheer de witvis (tilapia) kort tot net gaar; kruid met peper en zout.
3. Stoom of wok bloemkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the bulgur (dry) per the package.
2. Sear or poach the white fish (tilapia) until just done; season with salt and pepper.
3. Steam or stir-fry the cauliflower until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('white_fish_with_bulgur_kale','Witvis met bulgur & boerenkool','White fish with bulgur & kale',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"white_fish","g":170},{"slug":"bulgur_dry","g":70},{"slug":"kale","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de bulgur (droog) volgens de verpakking.
2. Bak of pocheer de witvis (tilapia) kort tot net gaar; kruid met peper en zout.
3. Stoom of wok boerenkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the bulgur (dry) per the package.
2. Sear or poach the white fish (tilapia) until just done; season with salt and pepper.
3. Steam or stir-fry the kale until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('white_fish_with_bulgur_bok_choy','Witvis met bulgur & paksoi','White fish with bulgur & bok choy',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"white_fish","g":170},{"slug":"bulgur_dry","g":70},{"slug":"bok_choy","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de bulgur (droog) volgens de verpakking.
2. Bak of pocheer de witvis (tilapia) kort tot net gaar; kruid met peper en zout.
3. Stoom of wok paksoi beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the bulgur (dry) per the package.
2. Sear or poach the white fish (tilapia) until just done; season with salt and pepper.
3. Steam or stir-fry the bok choy until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('white_fish_with_basmati_rice_broccoli','Witvis met basmatirijst & broccoli','White fish with basmati rice & broccoli',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"white_fish","g":170},{"slug":"basmati_dry","g":70},{"slug":"broccoli","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de basmatirijst (droog) volgens de verpakking.
2. Bak of pocheer de witvis (tilapia) kort tot net gaar; kruid met peper en zout.
3. Stoom of wok broccoli beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the basmati rice (dry) per the package.
2. Sear or poach the white fish (tilapia) until just done; season with salt and pepper.
3. Steam or stir-fry the broccoli until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('white_fish_with_basmati_rice_green_beans','Witvis met basmatirijst & sperziebonen','White fish with basmati rice & green beans',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"white_fish","g":170},{"slug":"basmati_dry","g":70},{"slug":"green_beans","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de basmatirijst (droog) volgens de verpakking.
2. Bak of pocheer de witvis (tilapia) kort tot net gaar; kruid met peper en zout.
3. Stoom of wok sperziebonen beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the basmati rice (dry) per the package.
2. Sear or poach the white fish (tilapia) until just done; season with salt and pepper.
3. Steam or stir-fry the green beans until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('white_fish_with_basmati_rice_spinach','Witvis met basmatirijst & spinazie','White fish with basmati rice & spinach',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"white_fish","g":170},{"slug":"basmati_dry","g":70},{"slug":"spinach","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de basmatirijst (droog) volgens de verpakking.
2. Bak of pocheer de witvis (tilapia) kort tot net gaar; kruid met peper en zout.
3. Stoom of wok spinazie beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the basmati rice (dry) per the package.
2. Sear or poach the white fish (tilapia) until just done; season with salt and pepper.
3. Steam or stir-fry the spinach until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('white_fish_with_basmati_rice_asparagus','Witvis met basmatirijst & asperges','White fish with basmati rice & asparagus',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"white_fish","g":170},{"slug":"basmati_dry","g":70},{"slug":"asparagus","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de basmatirijst (droog) volgens de verpakking.
2. Bak of pocheer de witvis (tilapia) kort tot net gaar; kruid met peper en zout.
3. Stoom of wok asperges beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the basmati rice (dry) per the package.
2. Sear or poach the white fish (tilapia) until just done; season with salt and pepper.
3. Steam or stir-fry the asparagus until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('white_fish_with_basmati_rice_zucchini','Witvis met basmatirijst & courgette','White fish with basmati rice & zucchini',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"white_fish","g":170},{"slug":"basmati_dry","g":70},{"slug":"zucchini","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de basmatirijst (droog) volgens de verpakking.
2. Bak of pocheer de witvis (tilapia) kort tot net gaar; kruid met peper en zout.
3. Stoom of wok courgette beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the basmati rice (dry) per the package.
2. Sear or poach the white fish (tilapia) until just done; season with salt and pepper.
3. Steam or stir-fry the zucchini until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('white_fish_with_basmati_rice_stir_fry_veg','Witvis met basmatirijst & wokgroente','White fish with basmati rice & stir-fry veg',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"white_fish","g":170},{"slug":"basmati_dry","g":70},{"slug":"mixed_veg","g":150},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de basmatirijst (droog) volgens de verpakking.
2. Bak of pocheer de witvis (tilapia) kort tot net gaar; kruid met peper en zout.
3. Stoom of wok wokgroente beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the basmati rice (dry) per the package.
2. Sear or poach the white fish (tilapia) until just done; season with salt and pepper.
3. Steam or stir-fry the stir-fry veg until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('white_fish_with_basmati_rice_mushrooms','Witvis met basmatirijst & champignons','White fish with basmati rice & mushrooms',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"white_fish","g":170},{"slug":"basmati_dry","g":70},{"slug":"mushroom","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de basmatirijst (droog) volgens de verpakking.
2. Bak of pocheer de witvis (tilapia) kort tot net gaar; kruid met peper en zout.
3. Stoom of wok champignons beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the basmati rice (dry) per the package.
2. Sear or poach the white fish (tilapia) until just done; season with salt and pepper.
3. Steam or stir-fry the mushrooms until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('white_fish_with_basmati_rice_carrot','Witvis met basmatirijst & wortel','White fish with basmati rice & carrot',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"white_fish","g":170},{"slug":"basmati_dry","g":70},{"slug":"carrot","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY[]::text[],'1. Kook de basmatirijst (droog) volgens de verpakking.
2. Bak of pocheer de witvis (tilapia) kort tot net gaar; kruid met peper en zout.
3. Stoom of wok wortel beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the basmati rice (dry) per the package.
2. Sear or poach the white fish (tilapia) until just done; season with salt and pepper.
3. Steam or stir-fry the carrot until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('white_fish_with_basmati_rice_peas','Witvis met basmatirijst & doperwten','White fish with basmati rice & peas',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"white_fish","g":170},{"slug":"basmati_dry","g":70},{"slug":"peas","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de basmatirijst (droog) volgens de verpakking.
2. Bak of pocheer de witvis (tilapia) kort tot net gaar; kruid met peper en zout.
3. Stoom of wok doperwten beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the basmati rice (dry) per the package.
2. Sear or poach the white fish (tilapia) until just done; season with salt and pepper.
3. Steam or stir-fry the peas until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('white_fish_with_basmati_rice_cauliflower','Witvis met basmatirijst & bloemkool','White fish with basmati rice & cauliflower',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"white_fish","g":170},{"slug":"basmati_dry","g":70},{"slug":"cauliflower","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de basmatirijst (droog) volgens de verpakking.
2. Bak of pocheer de witvis (tilapia) kort tot net gaar; kruid met peper en zout.
3. Stoom of wok bloemkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the basmati rice (dry) per the package.
2. Sear or poach the white fish (tilapia) until just done; season with salt and pepper.
3. Steam or stir-fry the cauliflower until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('white_fish_with_basmati_rice_kale','Witvis met basmatirijst & boerenkool','White fish with basmati rice & kale',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"white_fish","g":170},{"slug":"basmati_dry","g":70},{"slug":"kale","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de basmatirijst (droog) volgens de verpakking.
2. Bak of pocheer de witvis (tilapia) kort tot net gaar; kruid met peper en zout.
3. Stoom of wok boerenkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the basmati rice (dry) per the package.
2. Sear or poach the white fish (tilapia) until just done; season with salt and pepper.
3. Steam or stir-fry the kale until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('white_fish_with_basmati_rice_bok_choy','Witvis met basmatirijst & paksoi','White fish with basmati rice & bok choy',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"white_fish","g":170},{"slug":"basmati_dry","g":70},{"slug":"bok_choy","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de basmatirijst (droog) volgens de verpakking.
2. Bak of pocheer de witvis (tilapia) kort tot net gaar; kruid met peper en zout.
3. Stoom of wok paksoi beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the basmati rice (dry) per the package.
2. Sear or poach the white fish (tilapia) until just done; season with salt and pepper.
3. Steam or stir-fry the bok choy until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('meatballs_with_rice_broccoli','Gehaktballen met rijst & broccoli','Meatballs with rice & broccoli',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"meatballs_lean","g":140},{"slug":"rice_dry","g":70},{"slug":"broccoli","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Kook de witte rijst (droog) volgens de verpakking.
2. Bak de magere gehaktballen in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok broccoli beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the white rice (dry) per the package.
2. Pan-fry the lean meatballs in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the broccoli until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('meatballs_with_rice_green_beans','Gehaktballen met rijst & sperziebonen','Meatballs with rice & green beans',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"meatballs_lean","g":140},{"slug":"rice_dry","g":70},{"slug":"green_beans","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Kook de witte rijst (droog) volgens de verpakking.
2. Bak de magere gehaktballen in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok sperziebonen beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the white rice (dry) per the package.
2. Pan-fry the lean meatballs in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the green beans until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('meatballs_with_rice_spinach','Gehaktballen met rijst & spinazie','Meatballs with rice & spinach',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"meatballs_lean","g":140},{"slug":"rice_dry","g":70},{"slug":"spinach","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Kook de witte rijst (droog) volgens de verpakking.
2. Bak de magere gehaktballen in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok spinazie beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the white rice (dry) per the package.
2. Pan-fry the lean meatballs in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the spinach until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('meatballs_with_rice_asparagus','Gehaktballen met rijst & asperges','Meatballs with rice & asparagus',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"meatballs_lean","g":140},{"slug":"rice_dry","g":70},{"slug":"asparagus","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Kook de witte rijst (droog) volgens de verpakking.
2. Bak de magere gehaktballen in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok asperges beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the white rice (dry) per the package.
2. Pan-fry the lean meatballs in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the asparagus until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('meatballs_with_rice_zucchini','Gehaktballen met rijst & courgette','Meatballs with rice & zucchini',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"meatballs_lean","g":140},{"slug":"rice_dry","g":70},{"slug":"zucchini","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Kook de witte rijst (droog) volgens de verpakking.
2. Bak de magere gehaktballen in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok courgette beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the white rice (dry) per the package.
2. Pan-fry the lean meatballs in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the zucchini until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('meatballs_with_rice_stir_fry_veg','Gehaktballen met rijst & wokgroente','Meatballs with rice & stir-fry veg',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"meatballs_lean","g":140},{"slug":"rice_dry","g":70},{"slug":"mixed_veg","g":150},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Kook de witte rijst (droog) volgens de verpakking.
2. Bak de magere gehaktballen in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok wokgroente beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the white rice (dry) per the package.
2. Pan-fry the lean meatballs in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the stir-fry veg until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('meatballs_with_rice_mushrooms','Gehaktballen met rijst & champignons','Meatballs with rice & mushrooms',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"meatballs_lean","g":140},{"slug":"rice_dry","g":70},{"slug":"mushroom","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Kook de witte rijst (droog) volgens de verpakking.
2. Bak de magere gehaktballen in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok champignons beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the white rice (dry) per the package.
2. Pan-fry the lean meatballs in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the mushrooms until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('meatballs_with_rice_carrot','Gehaktballen met rijst & wortel','Meatballs with rice & carrot',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"meatballs_lean","g":140},{"slug":"rice_dry","g":70},{"slug":"carrot","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Kook de witte rijst (droog) volgens de verpakking.
2. Bak de magere gehaktballen in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok wortel beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the white rice (dry) per the package.
2. Pan-fry the lean meatballs in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the carrot until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('meatballs_with_rice_peas','Gehaktballen met rijst & doperwten','Meatballs with rice & peas',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"meatballs_lean","g":140},{"slug":"rice_dry","g":70},{"slug":"peas","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Kook de witte rijst (droog) volgens de verpakking.
2. Bak de magere gehaktballen in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok doperwten beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the white rice (dry) per the package.
2. Pan-fry the lean meatballs in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the peas until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('meatballs_with_rice_cauliflower','Gehaktballen met rijst & bloemkool','Meatballs with rice & cauliflower',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"meatballs_lean","g":140},{"slug":"rice_dry","g":70},{"slug":"cauliflower","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Kook de witte rijst (droog) volgens de verpakking.
2. Bak de magere gehaktballen in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok bloemkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the white rice (dry) per the package.
2. Pan-fry the lean meatballs in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the cauliflower until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('meatballs_with_rice_kale','Gehaktballen met rijst & boerenkool','Meatballs with rice & kale',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"meatballs_lean","g":140},{"slug":"rice_dry","g":70},{"slug":"kale","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Kook de witte rijst (droog) volgens de verpakking.
2. Bak de magere gehaktballen in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok boerenkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the white rice (dry) per the package.
2. Pan-fry the lean meatballs in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the kale until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('meatballs_with_rice_bok_choy','Gehaktballen met rijst & paksoi','Meatballs with rice & bok choy',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"meatballs_lean","g":140},{"slug":"rice_dry","g":70},{"slug":"bok_choy","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Kook de witte rijst (droog) volgens de verpakking.
2. Bak de magere gehaktballen in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok paksoi beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the white rice (dry) per the package.
2. Pan-fry the lean meatballs in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the bok choy until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('meatballs_with_sweet_potato_broccoli','Gehaktballen met zoete aardappel & broccoli','Meatballs with sweet potato & broccoli',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"meatballs_lean","g":140},{"slug":"sweet_potato","g":200},{"slug":"broccoli","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY[]::text[],'1. Kook de zoete aardappel volgens de verpakking.
2. Bak de magere gehaktballen in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok broccoli beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the sweet potato per the package.
2. Pan-fry the lean meatballs in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the broccoli until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('meatballs_with_sweet_potato_green_beans','Gehaktballen met zoete aardappel & sperziebonen','Meatballs with sweet potato & green beans',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"meatballs_lean","g":140},{"slug":"sweet_potato","g":200},{"slug":"green_beans","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY[]::text[],'1. Kook de zoete aardappel volgens de verpakking.
2. Bak de magere gehaktballen in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok sperziebonen beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the sweet potato per the package.
2. Pan-fry the lean meatballs in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the green beans until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('meatballs_with_sweet_potato_spinach','Gehaktballen met zoete aardappel & spinazie','Meatballs with sweet potato & spinach',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"meatballs_lean","g":140},{"slug":"sweet_potato","g":200},{"slug":"spinach","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY[]::text[],'1. Kook de zoete aardappel volgens de verpakking.
2. Bak de magere gehaktballen in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok spinazie beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the sweet potato per the package.
2. Pan-fry the lean meatballs in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the spinach until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('meatballs_with_sweet_potato_asparagus','Gehaktballen met zoete aardappel & asperges','Meatballs with sweet potato & asparagus',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"meatballs_lean","g":140},{"slug":"sweet_potato","g":200},{"slug":"asparagus","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY[]::text[],'1. Kook de zoete aardappel volgens de verpakking.
2. Bak de magere gehaktballen in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok asperges beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the sweet potato per the package.
2. Pan-fry the lean meatballs in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the asparagus until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('meatballs_with_sweet_potato_zucchini','Gehaktballen met zoete aardappel & courgette','Meatballs with sweet potato & zucchini',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"meatballs_lean","g":140},{"slug":"sweet_potato","g":200},{"slug":"zucchini","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY[]::text[],'1. Kook de zoete aardappel volgens de verpakking.
2. Bak de magere gehaktballen in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok courgette beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the sweet potato per the package.
2. Pan-fry the lean meatballs in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the zucchini until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('meatballs_with_sweet_potato_stir_fry_veg','Gehaktballen met zoete aardappel & wokgroente','Meatballs with sweet potato & stir-fry veg',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"meatballs_lean","g":140},{"slug":"sweet_potato","g":200},{"slug":"mixed_veg","g":150},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY[]::text[],'1. Kook de zoete aardappel volgens de verpakking.
2. Bak de magere gehaktballen in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok wokgroente beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the sweet potato per the package.
2. Pan-fry the lean meatballs in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the stir-fry veg until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('meatballs_with_sweet_potato_mushrooms','Gehaktballen met zoete aardappel & champignons','Meatballs with sweet potato & mushrooms',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"meatballs_lean","g":140},{"slug":"sweet_potato","g":200},{"slug":"mushroom","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY[]::text[],'1. Kook de zoete aardappel volgens de verpakking.
2. Bak de magere gehaktballen in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok champignons beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the sweet potato per the package.
2. Pan-fry the lean meatballs in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the mushrooms until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('meatballs_with_sweet_potato_carrot','Gehaktballen met zoete aardappel & wortel','Meatballs with sweet potato & carrot',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"meatballs_lean","g":140},{"slug":"sweet_potato","g":200},{"slug":"carrot","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY[]::text[],'1. Kook de zoete aardappel volgens de verpakking.
2. Bak de magere gehaktballen in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok wortel beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the sweet potato per the package.
2. Pan-fry the lean meatballs in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the carrot until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('meatballs_with_sweet_potato_peas','Gehaktballen met zoete aardappel & doperwten','Meatballs with sweet potato & peas',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"meatballs_lean","g":140},{"slug":"sweet_potato","g":200},{"slug":"peas","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY[]::text[],'1. Kook de zoete aardappel volgens de verpakking.
2. Bak de magere gehaktballen in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok doperwten beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the sweet potato per the package.
2. Pan-fry the lean meatballs in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the peas until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('meatballs_with_sweet_potato_cauliflower','Gehaktballen met zoete aardappel & bloemkool','Meatballs with sweet potato & cauliflower',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"meatballs_lean","g":140},{"slug":"sweet_potato","g":200},{"slug":"cauliflower","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY[]::text[],'1. Kook de zoete aardappel volgens de verpakking.
2. Bak de magere gehaktballen in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok bloemkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the sweet potato per the package.
2. Pan-fry the lean meatballs in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the cauliflower until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('meatballs_with_sweet_potato_kale','Gehaktballen met zoete aardappel & boerenkool','Meatballs with sweet potato & kale',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"meatballs_lean","g":140},{"slug":"sweet_potato","g":200},{"slug":"kale","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY[]::text[],'1. Kook de zoete aardappel volgens de verpakking.
2. Bak de magere gehaktballen in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok boerenkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the sweet potato per the package.
2. Pan-fry the lean meatballs in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the kale until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('meatballs_with_sweet_potato_bok_choy','Gehaktballen met zoete aardappel & paksoi','Meatballs with sweet potato & bok choy',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"meatballs_lean","g":140},{"slug":"sweet_potato","g":200},{"slug":"bok_choy","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY[]::text[],'1. Kook de zoete aardappel volgens de verpakking.
2. Bak de magere gehaktballen in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok paksoi beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the sweet potato per the package.
2. Pan-fry the lean meatballs in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the bok choy until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('meatballs_with_potato_broccoli','Gehaktballen met aardappel & broccoli','Meatballs with potato & broccoli',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"meatballs_lean","g":140},{"slug":"potato","g":250},{"slug":"broccoli","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['steakpotato']::text[],'1. Kook de aardappel volgens de verpakking.
2. Bak de magere gehaktballen in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok broccoli beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the potato per the package.
2. Pan-fry the lean meatballs in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the broccoli until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('meatballs_with_potato_green_beans','Gehaktballen met aardappel & sperziebonen','Meatballs with potato & green beans',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"meatballs_lean","g":140},{"slug":"potato","g":250},{"slug":"green_beans","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['steakpotato']::text[],'1. Kook de aardappel volgens de verpakking.
2. Bak de magere gehaktballen in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok sperziebonen beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the potato per the package.
2. Pan-fry the lean meatballs in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the green beans until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('meatballs_with_potato_spinach','Gehaktballen met aardappel & spinazie','Meatballs with potato & spinach',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"meatballs_lean","g":140},{"slug":"potato","g":250},{"slug":"spinach","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['steakpotato']::text[],'1. Kook de aardappel volgens de verpakking.
2. Bak de magere gehaktballen in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok spinazie beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the potato per the package.
2. Pan-fry the lean meatballs in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the spinach until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('meatballs_with_potato_asparagus','Gehaktballen met aardappel & asperges','Meatballs with potato & asparagus',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"meatballs_lean","g":140},{"slug":"potato","g":250},{"slug":"asparagus","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['steakpotato']::text[],'1. Kook de aardappel volgens de verpakking.
2. Bak de magere gehaktballen in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok asperges beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the potato per the package.
2. Pan-fry the lean meatballs in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the asparagus until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('meatballs_with_potato_zucchini','Gehaktballen met aardappel & courgette','Meatballs with potato & zucchini',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"meatballs_lean","g":140},{"slug":"potato","g":250},{"slug":"zucchini","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['steakpotato']::text[],'1. Kook de aardappel volgens de verpakking.
2. Bak de magere gehaktballen in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok courgette beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the potato per the package.
2. Pan-fry the lean meatballs in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the zucchini until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('meatballs_with_potato_stir_fry_veg','Gehaktballen met aardappel & wokgroente','Meatballs with potato & stir-fry veg',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"meatballs_lean","g":140},{"slug":"potato","g":250},{"slug":"mixed_veg","g":150},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['steakpotato']::text[],'1. Kook de aardappel volgens de verpakking.
2. Bak de magere gehaktballen in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok wokgroente beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the potato per the package.
2. Pan-fry the lean meatballs in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the stir-fry veg until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('meatballs_with_potato_mushrooms','Gehaktballen met aardappel & champignons','Meatballs with potato & mushrooms',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"meatballs_lean","g":140},{"slug":"potato","g":250},{"slug":"mushroom","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['steakpotato']::text[],'1. Kook de aardappel volgens de verpakking.
2. Bak de magere gehaktballen in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok champignons beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the potato per the package.
2. Pan-fry the lean meatballs in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the mushrooms until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('meatballs_with_potato_carrot','Gehaktballen met aardappel & wortel','Meatballs with potato & carrot',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"meatballs_lean","g":140},{"slug":"potato","g":250},{"slug":"carrot","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['steakpotato']::text[],'1. Kook de aardappel volgens de verpakking.
2. Bak de magere gehaktballen in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok wortel beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the potato per the package.
2. Pan-fry the lean meatballs in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the carrot until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('meatballs_with_potato_peas','Gehaktballen met aardappel & doperwten','Meatballs with potato & peas',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"meatballs_lean","g":140},{"slug":"potato","g":250},{"slug":"peas","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['steakpotato']::text[],'1. Kook de aardappel volgens de verpakking.
2. Bak de magere gehaktballen in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok doperwten beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the potato per the package.
2. Pan-fry the lean meatballs in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the peas until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('meatballs_with_potato_cauliflower','Gehaktballen met aardappel & bloemkool','Meatballs with potato & cauliflower',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"meatballs_lean","g":140},{"slug":"potato","g":250},{"slug":"cauliflower","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['steakpotato']::text[],'1. Kook de aardappel volgens de verpakking.
2. Bak de magere gehaktballen in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok bloemkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the potato per the package.
2. Pan-fry the lean meatballs in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the cauliflower until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('meatballs_with_potato_kale','Gehaktballen met aardappel & boerenkool','Meatballs with potato & kale',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"meatballs_lean","g":140},{"slug":"potato","g":250},{"slug":"kale","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['steakpotato']::text[],'1. Kook de aardappel volgens de verpakking.
2. Bak de magere gehaktballen in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok boerenkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the potato per the package.
2. Pan-fry the lean meatballs in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the kale until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('meatballs_with_potato_bok_choy','Gehaktballen met aardappel & paksoi','Meatballs with potato & bok choy',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"meatballs_lean","g":140},{"slug":"potato","g":250},{"slug":"bok_choy","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['steakpotato']::text[],'1. Kook de aardappel volgens de verpakking.
2. Bak de magere gehaktballen in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok paksoi beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the potato per the package.
2. Pan-fry the lean meatballs in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the bok choy until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('meatballs_with_pasta_broccoli','Gehaktballen met pasta & broccoli','Meatballs with pasta & broccoli',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"meatballs_lean","g":140},{"slug":"pasta_dry","g":80},{"slug":"broccoli","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['pastabol']::text[],'1. Kook de volkoren pasta (droog) volgens de verpakking.
2. Bak de magere gehaktballen in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok broccoli beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat pasta (dry) per the package.
2. Pan-fry the lean meatballs in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the broccoli until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('meatballs_with_pasta_green_beans','Gehaktballen met pasta & sperziebonen','Meatballs with pasta & green beans',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"meatballs_lean","g":140},{"slug":"pasta_dry","g":80},{"slug":"green_beans","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['pastabol']::text[],'1. Kook de volkoren pasta (droog) volgens de verpakking.
2. Bak de magere gehaktballen in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok sperziebonen beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat pasta (dry) per the package.
2. Pan-fry the lean meatballs in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the green beans until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('meatballs_with_pasta_spinach','Gehaktballen met pasta & spinazie','Meatballs with pasta & spinach',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"meatballs_lean","g":140},{"slug":"pasta_dry","g":80},{"slug":"spinach","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['pastabol']::text[],'1. Kook de volkoren pasta (droog) volgens de verpakking.
2. Bak de magere gehaktballen in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok spinazie beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat pasta (dry) per the package.
2. Pan-fry the lean meatballs in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the spinach until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('meatballs_with_pasta_asparagus','Gehaktballen met pasta & asperges','Meatballs with pasta & asparagus',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"meatballs_lean","g":140},{"slug":"pasta_dry","g":80},{"slug":"asparagus","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['pastabol']::text[],'1. Kook de volkoren pasta (droog) volgens de verpakking.
2. Bak de magere gehaktballen in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok asperges beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat pasta (dry) per the package.
2. Pan-fry the lean meatballs in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the asparagus until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('meatballs_with_pasta_zucchini','Gehaktballen met pasta & courgette','Meatballs with pasta & zucchini',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"meatballs_lean","g":140},{"slug":"pasta_dry","g":80},{"slug":"zucchini","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['pastabol']::text[],'1. Kook de volkoren pasta (droog) volgens de verpakking.
2. Bak de magere gehaktballen in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok courgette beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat pasta (dry) per the package.
2. Pan-fry the lean meatballs in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the zucchini until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('meatballs_with_pasta_stir_fry_veg','Gehaktballen met pasta & wokgroente','Meatballs with pasta & stir-fry veg',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"meatballs_lean","g":140},{"slug":"pasta_dry","g":80},{"slug":"mixed_veg","g":150},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['pastabol']::text[],'1. Kook de volkoren pasta (droog) volgens de verpakking.
2. Bak de magere gehaktballen in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok wokgroente beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat pasta (dry) per the package.
2. Pan-fry the lean meatballs in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the stir-fry veg until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('meatballs_with_pasta_mushrooms','Gehaktballen met pasta & champignons','Meatballs with pasta & mushrooms',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"meatballs_lean","g":140},{"slug":"pasta_dry","g":80},{"slug":"mushroom","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['pastabol']::text[],'1. Kook de volkoren pasta (droog) volgens de verpakking.
2. Bak de magere gehaktballen in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok champignons beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat pasta (dry) per the package.
2. Pan-fry the lean meatballs in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the mushrooms until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('meatballs_with_pasta_carrot','Gehaktballen met pasta & wortel','Meatballs with pasta & carrot',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"meatballs_lean","g":140},{"slug":"pasta_dry","g":80},{"slug":"carrot","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['pastabol']::text[],'1. Kook de volkoren pasta (droog) volgens de verpakking.
2. Bak de magere gehaktballen in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok wortel beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat pasta (dry) per the package.
2. Pan-fry the lean meatballs in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the carrot until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('meatballs_with_pasta_peas','Gehaktballen met pasta & doperwten','Meatballs with pasta & peas',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"meatballs_lean","g":140},{"slug":"pasta_dry","g":80},{"slug":"peas","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['pastabol']::text[],'1. Kook de volkoren pasta (droog) volgens de verpakking.
2. Bak de magere gehaktballen in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok doperwten beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat pasta (dry) per the package.
2. Pan-fry the lean meatballs in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the peas until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('meatballs_with_pasta_cauliflower','Gehaktballen met pasta & bloemkool','Meatballs with pasta & cauliflower',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"meatballs_lean","g":140},{"slug":"pasta_dry","g":80},{"slug":"cauliflower","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['pastabol']::text[],'1. Kook de volkoren pasta (droog) volgens de verpakking.
2. Bak de magere gehaktballen in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok bloemkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat pasta (dry) per the package.
2. Pan-fry the lean meatballs in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the cauliflower until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('meatballs_with_pasta_kale','Gehaktballen met pasta & boerenkool','Meatballs with pasta & kale',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"meatballs_lean","g":140},{"slug":"pasta_dry","g":80},{"slug":"kale","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['pastabol']::text[],'1. Kook de volkoren pasta (droog) volgens de verpakking.
2. Bak de magere gehaktballen in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok boerenkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat pasta (dry) per the package.
2. Pan-fry the lean meatballs in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the kale until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('meatballs_with_pasta_bok_choy','Gehaktballen met pasta & paksoi','Meatballs with pasta & bok choy',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"meatballs_lean","g":140},{"slug":"pasta_dry","g":80},{"slug":"bok_choy","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['pastabol']::text[],'1. Kook de volkoren pasta (droog) volgens de verpakking.
2. Bak de magere gehaktballen in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok paksoi beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat pasta (dry) per the package.
2. Pan-fry the lean meatballs in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the bok choy until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('meatballs_with_quinoa_broccoli','Gehaktballen met quinoa & broccoli','Meatballs with quinoa & broccoli',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"meatballs_lean","g":140},{"slug":"quinoa_dry","g":70},{"slug":"broccoli","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY[]::text[],'1. Kook de quinoa (droog) volgens de verpakking.
2. Bak de magere gehaktballen in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok broccoli beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the quinoa (dry) per the package.
2. Pan-fry the lean meatballs in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the broccoli until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('meatballs_with_quinoa_green_beans','Gehaktballen met quinoa & sperziebonen','Meatballs with quinoa & green beans',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"meatballs_lean","g":140},{"slug":"quinoa_dry","g":70},{"slug":"green_beans","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY[]::text[],'1. Kook de quinoa (droog) volgens de verpakking.
2. Bak de magere gehaktballen in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok sperziebonen beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the quinoa (dry) per the package.
2. Pan-fry the lean meatballs in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the green beans until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('meatballs_with_quinoa_spinach','Gehaktballen met quinoa & spinazie','Meatballs with quinoa & spinach',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"meatballs_lean","g":140},{"slug":"quinoa_dry","g":70},{"slug":"spinach","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY[]::text[],'1. Kook de quinoa (droog) volgens de verpakking.
2. Bak de magere gehaktballen in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok spinazie beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the quinoa (dry) per the package.
2. Pan-fry the lean meatballs in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the spinach until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('meatballs_with_quinoa_asparagus','Gehaktballen met quinoa & asperges','Meatballs with quinoa & asparagus',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"meatballs_lean","g":140},{"slug":"quinoa_dry","g":70},{"slug":"asparagus","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY[]::text[],'1. Kook de quinoa (droog) volgens de verpakking.
2. Bak de magere gehaktballen in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok asperges beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the quinoa (dry) per the package.
2. Pan-fry the lean meatballs in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the asparagus until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('meatballs_with_quinoa_zucchini','Gehaktballen met quinoa & courgette','Meatballs with quinoa & zucchini',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"meatballs_lean","g":140},{"slug":"quinoa_dry","g":70},{"slug":"zucchini","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY[]::text[],'1. Kook de quinoa (droog) volgens de verpakking.
2. Bak de magere gehaktballen in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok courgette beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the quinoa (dry) per the package.
2. Pan-fry the lean meatballs in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the zucchini until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('meatballs_with_quinoa_stir_fry_veg','Gehaktballen met quinoa & wokgroente','Meatballs with quinoa & stir-fry veg',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"meatballs_lean","g":140},{"slug":"quinoa_dry","g":70},{"slug":"mixed_veg","g":150},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY[]::text[],'1. Kook de quinoa (droog) volgens de verpakking.
2. Bak de magere gehaktballen in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok wokgroente beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the quinoa (dry) per the package.
2. Pan-fry the lean meatballs in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the stir-fry veg until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('meatballs_with_quinoa_mushrooms','Gehaktballen met quinoa & champignons','Meatballs with quinoa & mushrooms',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"meatballs_lean","g":140},{"slug":"quinoa_dry","g":70},{"slug":"mushroom","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY[]::text[],'1. Kook de quinoa (droog) volgens de verpakking.
2. Bak de magere gehaktballen in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok champignons beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the quinoa (dry) per the package.
2. Pan-fry the lean meatballs in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the mushrooms until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('meatballs_with_quinoa_carrot','Gehaktballen met quinoa & wortel','Meatballs with quinoa & carrot',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"meatballs_lean","g":140},{"slug":"quinoa_dry","g":70},{"slug":"carrot","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY[]::text[],'1. Kook de quinoa (droog) volgens de verpakking.
2. Bak de magere gehaktballen in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok wortel beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the quinoa (dry) per the package.
2. Pan-fry the lean meatballs in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the carrot until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('meatballs_with_quinoa_peas','Gehaktballen met quinoa & doperwten','Meatballs with quinoa & peas',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"meatballs_lean","g":140},{"slug":"quinoa_dry","g":70},{"slug":"peas","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY[]::text[],'1. Kook de quinoa (droog) volgens de verpakking.
2. Bak de magere gehaktballen in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok doperwten beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the quinoa (dry) per the package.
2. Pan-fry the lean meatballs in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the peas until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('meatballs_with_quinoa_cauliflower','Gehaktballen met quinoa & bloemkool','Meatballs with quinoa & cauliflower',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"meatballs_lean","g":140},{"slug":"quinoa_dry","g":70},{"slug":"cauliflower","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY[]::text[],'1. Kook de quinoa (droog) volgens de verpakking.
2. Bak de magere gehaktballen in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok bloemkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the quinoa (dry) per the package.
2. Pan-fry the lean meatballs in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the cauliflower until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('meatballs_with_quinoa_kale','Gehaktballen met quinoa & boerenkool','Meatballs with quinoa & kale',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"meatballs_lean","g":140},{"slug":"quinoa_dry","g":70},{"slug":"kale","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY[]::text[],'1. Kook de quinoa (droog) volgens de verpakking.
2. Bak de magere gehaktballen in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok boerenkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the quinoa (dry) per the package.
2. Pan-fry the lean meatballs in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the kale until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('meatballs_with_quinoa_bok_choy','Gehaktballen met quinoa & paksoi','Meatballs with quinoa & bok choy',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"meatballs_lean","g":140},{"slug":"quinoa_dry","g":70},{"slug":"bok_choy","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY[]::text[],'1. Kook de quinoa (droog) volgens de verpakking.
2. Bak de magere gehaktballen in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok paksoi beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the quinoa (dry) per the package.
2. Pan-fry the lean meatballs in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the bok choy until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('meatballs_with_noodles_broccoli','Gehaktballen met noedels & broccoli','Meatballs with noodles & broccoli',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"meatballs_lean","g":140},{"slug":"noodles_dry","g":80},{"slug":"broccoli","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['woknoodles']::text[],'1. Kook de volkoren noedels (droog) volgens de verpakking.
2. Bak de magere gehaktballen in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok broccoli beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat noodles (dry) per the package.
2. Pan-fry the lean meatballs in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the broccoli until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('meatballs_with_noodles_green_beans','Gehaktballen met noedels & sperziebonen','Meatballs with noodles & green beans',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"meatballs_lean","g":140},{"slug":"noodles_dry","g":80},{"slug":"green_beans","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['woknoodles']::text[],'1. Kook de volkoren noedels (droog) volgens de verpakking.
2. Bak de magere gehaktballen in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok sperziebonen beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat noodles (dry) per the package.
2. Pan-fry the lean meatballs in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the green beans until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('meatballs_with_noodles_spinach','Gehaktballen met noedels & spinazie','Meatballs with noodles & spinach',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"meatballs_lean","g":140},{"slug":"noodles_dry","g":80},{"slug":"spinach","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['woknoodles']::text[],'1. Kook de volkoren noedels (droog) volgens de verpakking.
2. Bak de magere gehaktballen in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok spinazie beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat noodles (dry) per the package.
2. Pan-fry the lean meatballs in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the spinach until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('meatballs_with_noodles_asparagus','Gehaktballen met noedels & asperges','Meatballs with noodles & asparagus',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"meatballs_lean","g":140},{"slug":"noodles_dry","g":80},{"slug":"asparagus","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['woknoodles']::text[],'1. Kook de volkoren noedels (droog) volgens de verpakking.
2. Bak de magere gehaktballen in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok asperges beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat noodles (dry) per the package.
2. Pan-fry the lean meatballs in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the asparagus until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('meatballs_with_noodles_zucchini','Gehaktballen met noedels & courgette','Meatballs with noodles & zucchini',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"meatballs_lean","g":140},{"slug":"noodles_dry","g":80},{"slug":"zucchini","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['woknoodles']::text[],'1. Kook de volkoren noedels (droog) volgens de verpakking.
2. Bak de magere gehaktballen in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok courgette beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat noodles (dry) per the package.
2. Pan-fry the lean meatballs in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the zucchini until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('meatballs_with_noodles_stir_fry_veg','Gehaktballen met noedels & wokgroente','Meatballs with noodles & stir-fry veg',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"meatballs_lean","g":140},{"slug":"noodles_dry","g":80},{"slug":"mixed_veg","g":150},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['woknoodles']::text[],'1. Kook de volkoren noedels (droog) volgens de verpakking.
2. Bak de magere gehaktballen in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok wokgroente beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat noodles (dry) per the package.
2. Pan-fry the lean meatballs in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the stir-fry veg until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('meatballs_with_noodles_mushrooms','Gehaktballen met noedels & champignons','Meatballs with noodles & mushrooms',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"meatballs_lean","g":140},{"slug":"noodles_dry","g":80},{"slug":"mushroom","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['woknoodles']::text[],'1. Kook de volkoren noedels (droog) volgens de verpakking.
2. Bak de magere gehaktballen in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok champignons beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat noodles (dry) per the package.
2. Pan-fry the lean meatballs in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the mushrooms until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('meatballs_with_noodles_carrot','Gehaktballen met noedels & wortel','Meatballs with noodles & carrot',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"meatballs_lean","g":140},{"slug":"noodles_dry","g":80},{"slug":"carrot","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['woknoodles']::text[],'1. Kook de volkoren noedels (droog) volgens de verpakking.
2. Bak de magere gehaktballen in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok wortel beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat noodles (dry) per the package.
2. Pan-fry the lean meatballs in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the carrot until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('meatballs_with_noodles_peas','Gehaktballen met noedels & doperwten','Meatballs with noodles & peas',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"meatballs_lean","g":140},{"slug":"noodles_dry","g":80},{"slug":"peas","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['woknoodles']::text[],'1. Kook de volkoren noedels (droog) volgens de verpakking.
2. Bak de magere gehaktballen in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok doperwten beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat noodles (dry) per the package.
2. Pan-fry the lean meatballs in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the peas until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('meatballs_with_noodles_cauliflower','Gehaktballen met noedels & bloemkool','Meatballs with noodles & cauliflower',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"meatballs_lean","g":140},{"slug":"noodles_dry","g":80},{"slug":"cauliflower","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['woknoodles']::text[],'1. Kook de volkoren noedels (droog) volgens de verpakking.
2. Bak de magere gehaktballen in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok bloemkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat noodles (dry) per the package.
2. Pan-fry the lean meatballs in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the cauliflower until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('meatballs_with_noodles_kale','Gehaktballen met noedels & boerenkool','Meatballs with noodles & kale',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"meatballs_lean","g":140},{"slug":"noodles_dry","g":80},{"slug":"kale","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['woknoodles']::text[],'1. Kook de volkoren noedels (droog) volgens de verpakking.
2. Bak de magere gehaktballen in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok boerenkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat noodles (dry) per the package.
2. Pan-fry the lean meatballs in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the kale until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('meatballs_with_noodles_bok_choy','Gehaktballen met noedels & paksoi','Meatballs with noodles & bok choy',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"meatballs_lean","g":140},{"slug":"noodles_dry","g":80},{"slug":"bok_choy","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['woknoodles']::text[],'1. Kook de volkoren noedels (droog) volgens de verpakking.
2. Bak de magere gehaktballen in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok paksoi beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat noodles (dry) per the package.
2. Pan-fry the lean meatballs in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the bok choy until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('meatballs_with_couscous_broccoli','Gehaktballen met couscous & broccoli','Meatballs with couscous & broccoli',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"meatballs_lean","g":140},{"slug":"couscous_dry","g":70},{"slug":"broccoli","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY[]::text[],'1. Kook de volkoren couscous (droog) volgens de verpakking.
2. Bak de magere gehaktballen in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok broccoli beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat couscous (dry) per the package.
2. Pan-fry the lean meatballs in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the broccoli until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('meatballs_with_couscous_green_beans','Gehaktballen met couscous & sperziebonen','Meatballs with couscous & green beans',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"meatballs_lean","g":140},{"slug":"couscous_dry","g":70},{"slug":"green_beans","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY[]::text[],'1. Kook de volkoren couscous (droog) volgens de verpakking.
2. Bak de magere gehaktballen in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok sperziebonen beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat couscous (dry) per the package.
2. Pan-fry the lean meatballs in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the green beans until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('meatballs_with_couscous_spinach','Gehaktballen met couscous & spinazie','Meatballs with couscous & spinach',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"meatballs_lean","g":140},{"slug":"couscous_dry","g":70},{"slug":"spinach","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY[]::text[],'1. Kook de volkoren couscous (droog) volgens de verpakking.
2. Bak de magere gehaktballen in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok spinazie beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat couscous (dry) per the package.
2. Pan-fry the lean meatballs in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the spinach until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('meatballs_with_couscous_asparagus','Gehaktballen met couscous & asperges','Meatballs with couscous & asparagus',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"meatballs_lean","g":140},{"slug":"couscous_dry","g":70},{"slug":"asparagus","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY[]::text[],'1. Kook de volkoren couscous (droog) volgens de verpakking.
2. Bak de magere gehaktballen in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok asperges beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat couscous (dry) per the package.
2. Pan-fry the lean meatballs in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the asparagus until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('meatballs_with_couscous_zucchini','Gehaktballen met couscous & courgette','Meatballs with couscous & zucchini',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"meatballs_lean","g":140},{"slug":"couscous_dry","g":70},{"slug":"zucchini","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY[]::text[],'1. Kook de volkoren couscous (droog) volgens de verpakking.
2. Bak de magere gehaktballen in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok courgette beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat couscous (dry) per the package.
2. Pan-fry the lean meatballs in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the zucchini until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('meatballs_with_couscous_stir_fry_veg','Gehaktballen met couscous & wokgroente','Meatballs with couscous & stir-fry veg',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"meatballs_lean","g":140},{"slug":"couscous_dry","g":70},{"slug":"mixed_veg","g":150},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY[]::text[],'1. Kook de volkoren couscous (droog) volgens de verpakking.
2. Bak de magere gehaktballen in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok wokgroente beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat couscous (dry) per the package.
2. Pan-fry the lean meatballs in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the stir-fry veg until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('meatballs_with_couscous_mushrooms','Gehaktballen met couscous & champignons','Meatballs with couscous & mushrooms',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"meatballs_lean","g":140},{"slug":"couscous_dry","g":70},{"slug":"mushroom","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY[]::text[],'1. Kook de volkoren couscous (droog) volgens de verpakking.
2. Bak de magere gehaktballen in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok champignons beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat couscous (dry) per the package.
2. Pan-fry the lean meatballs in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the mushrooms until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('meatballs_with_couscous_carrot','Gehaktballen met couscous & wortel','Meatballs with couscous & carrot',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"meatballs_lean","g":140},{"slug":"couscous_dry","g":70},{"slug":"carrot","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY[]::text[],'1. Kook de volkoren couscous (droog) volgens de verpakking.
2. Bak de magere gehaktballen in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok wortel beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat couscous (dry) per the package.
2. Pan-fry the lean meatballs in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the carrot until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('meatballs_with_couscous_peas','Gehaktballen met couscous & doperwten','Meatballs with couscous & peas',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"meatballs_lean","g":140},{"slug":"couscous_dry","g":70},{"slug":"peas","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY[]::text[],'1. Kook de volkoren couscous (droog) volgens de verpakking.
2. Bak de magere gehaktballen in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok doperwten beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat couscous (dry) per the package.
2. Pan-fry the lean meatballs in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the peas until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('meatballs_with_couscous_cauliflower','Gehaktballen met couscous & bloemkool','Meatballs with couscous & cauliflower',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"meatballs_lean","g":140},{"slug":"couscous_dry","g":70},{"slug":"cauliflower","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY[]::text[],'1. Kook de volkoren couscous (droog) volgens de verpakking.
2. Bak de magere gehaktballen in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok bloemkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat couscous (dry) per the package.
2. Pan-fry the lean meatballs in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the cauliflower until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('meatballs_with_couscous_kale','Gehaktballen met couscous & boerenkool','Meatballs with couscous & kale',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"meatballs_lean","g":140},{"slug":"couscous_dry","g":70},{"slug":"kale","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY[]::text[],'1. Kook de volkoren couscous (droog) volgens de verpakking.
2. Bak de magere gehaktballen in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok boerenkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat couscous (dry) per the package.
2. Pan-fry the lean meatballs in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the kale until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('meatballs_with_couscous_bok_choy','Gehaktballen met couscous & paksoi','Meatballs with couscous & bok choy',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"meatballs_lean","g":140},{"slug":"couscous_dry","g":70},{"slug":"bok_choy","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY[]::text[],'1. Kook de volkoren couscous (droog) volgens de verpakking.
2. Bak de magere gehaktballen in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok paksoi beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat couscous (dry) per the package.
2. Pan-fry the lean meatballs in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the bok choy until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('meatballs_with_bulgur_broccoli','Gehaktballen met bulgur & broccoli','Meatballs with bulgur & broccoli',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"meatballs_lean","g":140},{"slug":"bulgur_dry","g":70},{"slug":"broccoli","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY[]::text[],'1. Kook de bulgur (droog) volgens de verpakking.
2. Bak de magere gehaktballen in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok broccoli beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the bulgur (dry) per the package.
2. Pan-fry the lean meatballs in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the broccoli until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('meatballs_with_bulgur_green_beans','Gehaktballen met bulgur & sperziebonen','Meatballs with bulgur & green beans',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"meatballs_lean","g":140},{"slug":"bulgur_dry","g":70},{"slug":"green_beans","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY[]::text[],'1. Kook de bulgur (droog) volgens de verpakking.
2. Bak de magere gehaktballen in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok sperziebonen beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the bulgur (dry) per the package.
2. Pan-fry the lean meatballs in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the green beans until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('meatballs_with_bulgur_spinach','Gehaktballen met bulgur & spinazie','Meatballs with bulgur & spinach',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"meatballs_lean","g":140},{"slug":"bulgur_dry","g":70},{"slug":"spinach","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY[]::text[],'1. Kook de bulgur (droog) volgens de verpakking.
2. Bak de magere gehaktballen in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok spinazie beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the bulgur (dry) per the package.
2. Pan-fry the lean meatballs in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the spinach until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('meatballs_with_bulgur_asparagus','Gehaktballen met bulgur & asperges','Meatballs with bulgur & asparagus',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"meatballs_lean","g":140},{"slug":"bulgur_dry","g":70},{"slug":"asparagus","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY[]::text[],'1. Kook de bulgur (droog) volgens de verpakking.
2. Bak de magere gehaktballen in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok asperges beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the bulgur (dry) per the package.
2. Pan-fry the lean meatballs in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the asparagus until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('meatballs_with_bulgur_zucchini','Gehaktballen met bulgur & courgette','Meatballs with bulgur & zucchini',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"meatballs_lean","g":140},{"slug":"bulgur_dry","g":70},{"slug":"zucchini","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY[]::text[],'1. Kook de bulgur (droog) volgens de verpakking.
2. Bak de magere gehaktballen in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok courgette beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the bulgur (dry) per the package.
2. Pan-fry the lean meatballs in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the zucchini until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('meatballs_with_bulgur_stir_fry_veg','Gehaktballen met bulgur & wokgroente','Meatballs with bulgur & stir-fry veg',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"meatballs_lean","g":140},{"slug":"bulgur_dry","g":70},{"slug":"mixed_veg","g":150},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY[]::text[],'1. Kook de bulgur (droog) volgens de verpakking.
2. Bak de magere gehaktballen in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok wokgroente beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the bulgur (dry) per the package.
2. Pan-fry the lean meatballs in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the stir-fry veg until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('meatballs_with_bulgur_mushrooms','Gehaktballen met bulgur & champignons','Meatballs with bulgur & mushrooms',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"meatballs_lean","g":140},{"slug":"bulgur_dry","g":70},{"slug":"mushroom","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY[]::text[],'1. Kook de bulgur (droog) volgens de verpakking.
2. Bak de magere gehaktballen in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok champignons beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the bulgur (dry) per the package.
2. Pan-fry the lean meatballs in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the mushrooms until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('meatballs_with_bulgur_carrot','Gehaktballen met bulgur & wortel','Meatballs with bulgur & carrot',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"meatballs_lean","g":140},{"slug":"bulgur_dry","g":70},{"slug":"carrot","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY[]::text[],'1. Kook de bulgur (droog) volgens de verpakking.
2. Bak de magere gehaktballen in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok wortel beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the bulgur (dry) per the package.
2. Pan-fry the lean meatballs in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the carrot until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('meatballs_with_bulgur_peas','Gehaktballen met bulgur & doperwten','Meatballs with bulgur & peas',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"meatballs_lean","g":140},{"slug":"bulgur_dry","g":70},{"slug":"peas","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY[]::text[],'1. Kook de bulgur (droog) volgens de verpakking.
2. Bak de magere gehaktballen in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok doperwten beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the bulgur (dry) per the package.
2. Pan-fry the lean meatballs in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the peas until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('meatballs_with_bulgur_cauliflower','Gehaktballen met bulgur & bloemkool','Meatballs with bulgur & cauliflower',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"meatballs_lean","g":140},{"slug":"bulgur_dry","g":70},{"slug":"cauliflower","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY[]::text[],'1. Kook de bulgur (droog) volgens de verpakking.
2. Bak de magere gehaktballen in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok bloemkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the bulgur (dry) per the package.
2. Pan-fry the lean meatballs in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the cauliflower until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('meatballs_with_bulgur_kale','Gehaktballen met bulgur & boerenkool','Meatballs with bulgur & kale',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"meatballs_lean","g":140},{"slug":"bulgur_dry","g":70},{"slug":"kale","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY[]::text[],'1. Kook de bulgur (droog) volgens de verpakking.
2. Bak de magere gehaktballen in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok boerenkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the bulgur (dry) per the package.
2. Pan-fry the lean meatballs in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the kale until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('meatballs_with_bulgur_bok_choy','Gehaktballen met bulgur & paksoi','Meatballs with bulgur & bok choy',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"meatballs_lean","g":140},{"slug":"bulgur_dry","g":70},{"slug":"bok_choy","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY[]::text[],'1. Kook de bulgur (droog) volgens de verpakking.
2. Bak de magere gehaktballen in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok paksoi beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the bulgur (dry) per the package.
2. Pan-fry the lean meatballs in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the bok choy until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('meatballs_with_basmati_rice_broccoli','Gehaktballen met basmatirijst & broccoli','Meatballs with basmati rice & broccoli',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"meatballs_lean","g":140},{"slug":"basmati_dry","g":70},{"slug":"broccoli","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY[]::text[],'1. Kook de basmatirijst (droog) volgens de verpakking.
2. Bak de magere gehaktballen in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok broccoli beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the basmati rice (dry) per the package.
2. Pan-fry the lean meatballs in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the broccoli until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('meatballs_with_basmati_rice_green_beans','Gehaktballen met basmatirijst & sperziebonen','Meatballs with basmati rice & green beans',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"meatballs_lean","g":140},{"slug":"basmati_dry","g":70},{"slug":"green_beans","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY[]::text[],'1. Kook de basmatirijst (droog) volgens de verpakking.
2. Bak de magere gehaktballen in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok sperziebonen beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the basmati rice (dry) per the package.
2. Pan-fry the lean meatballs in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the green beans until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('meatballs_with_basmati_rice_spinach','Gehaktballen met basmatirijst & spinazie','Meatballs with basmati rice & spinach',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"meatballs_lean","g":140},{"slug":"basmati_dry","g":70},{"slug":"spinach","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY[]::text[],'1. Kook de basmatirijst (droog) volgens de verpakking.
2. Bak de magere gehaktballen in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok spinazie beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the basmati rice (dry) per the package.
2. Pan-fry the lean meatballs in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the spinach until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('meatballs_with_basmati_rice_asparagus','Gehaktballen met basmatirijst & asperges','Meatballs with basmati rice & asparagus',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"meatballs_lean","g":140},{"slug":"basmati_dry","g":70},{"slug":"asparagus","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY[]::text[],'1. Kook de basmatirijst (droog) volgens de verpakking.
2. Bak de magere gehaktballen in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok asperges beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the basmati rice (dry) per the package.
2. Pan-fry the lean meatballs in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the asparagus until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('meatballs_with_basmati_rice_zucchini','Gehaktballen met basmatirijst & courgette','Meatballs with basmati rice & zucchini',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"meatballs_lean","g":140},{"slug":"basmati_dry","g":70},{"slug":"zucchini","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY[]::text[],'1. Kook de basmatirijst (droog) volgens de verpakking.
2. Bak de magere gehaktballen in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok courgette beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the basmati rice (dry) per the package.
2. Pan-fry the lean meatballs in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the zucchini until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('meatballs_with_basmati_rice_stir_fry_veg','Gehaktballen met basmatirijst & wokgroente','Meatballs with basmati rice & stir-fry veg',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"meatballs_lean","g":140},{"slug":"basmati_dry","g":70},{"slug":"mixed_veg","g":150},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY[]::text[],'1. Kook de basmatirijst (droog) volgens de verpakking.
2. Bak de magere gehaktballen in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok wokgroente beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the basmati rice (dry) per the package.
2. Pan-fry the lean meatballs in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the stir-fry veg until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('meatballs_with_basmati_rice_mushrooms','Gehaktballen met basmatirijst & champignons','Meatballs with basmati rice & mushrooms',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"meatballs_lean","g":140},{"slug":"basmati_dry","g":70},{"slug":"mushroom","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY[]::text[],'1. Kook de basmatirijst (droog) volgens de verpakking.
2. Bak de magere gehaktballen in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok champignons beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the basmati rice (dry) per the package.
2. Pan-fry the lean meatballs in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the mushrooms until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('meatballs_with_basmati_rice_carrot','Gehaktballen met basmatirijst & wortel','Meatballs with basmati rice & carrot',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"meatballs_lean","g":140},{"slug":"basmati_dry","g":70},{"slug":"carrot","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY[]::text[],'1. Kook de basmatirijst (droog) volgens de verpakking.
2. Bak de magere gehaktballen in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok wortel beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the basmati rice (dry) per the package.
2. Pan-fry the lean meatballs in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the carrot until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('meatballs_with_basmati_rice_peas','Gehaktballen met basmatirijst & doperwten','Meatballs with basmati rice & peas',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"meatballs_lean","g":140},{"slug":"basmati_dry","g":70},{"slug":"peas","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY[]::text[],'1. Kook de basmatirijst (droog) volgens de verpakking.
2. Bak de magere gehaktballen in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok doperwten beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the basmati rice (dry) per the package.
2. Pan-fry the lean meatballs in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the peas until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('meatballs_with_basmati_rice_cauliflower','Gehaktballen met basmatirijst & bloemkool','Meatballs with basmati rice & cauliflower',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"meatballs_lean","g":140},{"slug":"basmati_dry","g":70},{"slug":"cauliflower","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY[]::text[],'1. Kook de basmatirijst (droog) volgens de verpakking.
2. Bak de magere gehaktballen in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok bloemkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the basmati rice (dry) per the package.
2. Pan-fry the lean meatballs in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the cauliflower until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('meatballs_with_basmati_rice_kale','Gehaktballen met basmatirijst & boerenkool','Meatballs with basmati rice & kale',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"meatballs_lean","g":140},{"slug":"basmati_dry","g":70},{"slug":"kale","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY[]::text[],'1. Kook de basmatirijst (droog) volgens de verpakking.
2. Bak de magere gehaktballen in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok boerenkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the basmati rice (dry) per the package.
2. Pan-fry the lean meatballs in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the kale until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('meatballs_with_basmati_rice_bok_choy','Gehaktballen met basmatirijst & paksoi','Meatballs with basmati rice & bok choy',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"meatballs_lean","g":140},{"slug":"basmati_dry","g":70},{"slug":"bok_choy","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY[]::text[],'1. Kook de basmatirijst (droog) volgens de verpakking.
2. Bak de magere gehaktballen in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok paksoi beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the basmati rice (dry) per the package.
2. Pan-fry the lean meatballs in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the bok choy until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('seitan_with_rice_broccoli','Seitan met rijst & broccoli','Seitan with rice & broccoli',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"seitan","g":130},{"slug":"rice_dry","g":70},{"slug":"broccoli","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Kook de witte rijst (droog) volgens de verpakking.
2. Bak de seitan in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok broccoli beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the white rice (dry) per the package.
2. Pan-fry the seitan in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the broccoli until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('seitan_with_rice_green_beans','Seitan met rijst & sperziebonen','Seitan with rice & green beans',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"seitan","g":130},{"slug":"rice_dry","g":70},{"slug":"green_beans","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Kook de witte rijst (droog) volgens de verpakking.
2. Bak de seitan in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok sperziebonen beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the white rice (dry) per the package.
2. Pan-fry the seitan in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the green beans until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('seitan_with_rice_spinach','Seitan met rijst & spinazie','Seitan with rice & spinach',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"seitan","g":130},{"slug":"rice_dry","g":70},{"slug":"spinach","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Kook de witte rijst (droog) volgens de verpakking.
2. Bak de seitan in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok spinazie beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the white rice (dry) per the package.
2. Pan-fry the seitan in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the spinach until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('seitan_with_rice_asparagus','Seitan met rijst & asperges','Seitan with rice & asparagus',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"seitan","g":130},{"slug":"rice_dry","g":70},{"slug":"asparagus","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Kook de witte rijst (droog) volgens de verpakking.
2. Bak de seitan in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok asperges beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the white rice (dry) per the package.
2. Pan-fry the seitan in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the asparagus until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('seitan_with_rice_zucchini','Seitan met rijst & courgette','Seitan with rice & zucchini',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"seitan","g":130},{"slug":"rice_dry","g":70},{"slug":"zucchini","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Kook de witte rijst (droog) volgens de verpakking.
2. Bak de seitan in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok courgette beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the white rice (dry) per the package.
2. Pan-fry the seitan in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the zucchini until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('seitan_with_rice_stir_fry_veg','Seitan met rijst & wokgroente','Seitan with rice & stir-fry veg',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"seitan","g":130},{"slug":"rice_dry","g":70},{"slug":"mixed_veg","g":150},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Kook de witte rijst (droog) volgens de verpakking.
2. Bak de seitan in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok wokgroente beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the white rice (dry) per the package.
2. Pan-fry the seitan in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the stir-fry veg until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('seitan_with_rice_mushrooms','Seitan met rijst & champignons','Seitan with rice & mushrooms',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"seitan","g":130},{"slug":"rice_dry","g":70},{"slug":"mushroom","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Kook de witte rijst (droog) volgens de verpakking.
2. Bak de seitan in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok champignons beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the white rice (dry) per the package.
2. Pan-fry the seitan in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the mushrooms until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('seitan_with_rice_carrot','Seitan met rijst & wortel','Seitan with rice & carrot',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"seitan","g":130},{"slug":"rice_dry","g":70},{"slug":"carrot","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Kook de witte rijst (droog) volgens de verpakking.
2. Bak de seitan in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok wortel beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the white rice (dry) per the package.
2. Pan-fry the seitan in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the carrot until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('seitan_with_rice_peas','Seitan met rijst & doperwten','Seitan with rice & peas',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"seitan","g":130},{"slug":"rice_dry","g":70},{"slug":"peas","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Kook de witte rijst (droog) volgens de verpakking.
2. Bak de seitan in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok doperwten beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the white rice (dry) per the package.
2. Pan-fry the seitan in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the peas until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('seitan_with_rice_cauliflower','Seitan met rijst & bloemkool','Seitan with rice & cauliflower',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"seitan","g":130},{"slug":"rice_dry","g":70},{"slug":"cauliflower","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Kook de witte rijst (droog) volgens de verpakking.
2. Bak de seitan in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok bloemkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the white rice (dry) per the package.
2. Pan-fry the seitan in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the cauliflower until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('seitan_with_rice_kale','Seitan met rijst & boerenkool','Seitan with rice & kale',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"seitan","g":130},{"slug":"rice_dry","g":70},{"slug":"kale","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Kook de witte rijst (droog) volgens de verpakking.
2. Bak de seitan in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok boerenkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the white rice (dry) per the package.
2. Pan-fry the seitan in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the kale until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('seitan_with_rice_bok_choy','Seitan met rijst & paksoi','Seitan with rice & bok choy',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"seitan","g":130},{"slug":"rice_dry","g":70},{"slug":"bok_choy","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Kook de witte rijst (droog) volgens de verpakking.
2. Bak de seitan in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok paksoi beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the white rice (dry) per the package.
2. Pan-fry the seitan in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the bok choy until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('seitan_with_sweet_potato_broccoli','Seitan met zoete aardappel & broccoli','Seitan with sweet potato & broccoli',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"seitan","g":130},{"slug":"sweet_potato","g":200},{"slug":"broccoli","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de zoete aardappel volgens de verpakking.
2. Bak de seitan in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok broccoli beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the sweet potato per the package.
2. Pan-fry the seitan in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the broccoli until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('seitan_with_sweet_potato_green_beans','Seitan met zoete aardappel & sperziebonen','Seitan with sweet potato & green beans',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"seitan","g":130},{"slug":"sweet_potato","g":200},{"slug":"green_beans","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de zoete aardappel volgens de verpakking.
2. Bak de seitan in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok sperziebonen beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the sweet potato per the package.
2. Pan-fry the seitan in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the green beans until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('seitan_with_sweet_potato_spinach','Seitan met zoete aardappel & spinazie','Seitan with sweet potato & spinach',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"seitan","g":130},{"slug":"sweet_potato","g":200},{"slug":"spinach","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de zoete aardappel volgens de verpakking.
2. Bak de seitan in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok spinazie beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the sweet potato per the package.
2. Pan-fry the seitan in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the spinach until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('seitan_with_sweet_potato_asparagus','Seitan met zoete aardappel & asperges','Seitan with sweet potato & asparagus',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"seitan","g":130},{"slug":"sweet_potato","g":200},{"slug":"asparagus","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de zoete aardappel volgens de verpakking.
2. Bak de seitan in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok asperges beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the sweet potato per the package.
2. Pan-fry the seitan in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the asparagus until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('seitan_with_sweet_potato_zucchini','Seitan met zoete aardappel & courgette','Seitan with sweet potato & zucchini',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"seitan","g":130},{"slug":"sweet_potato","g":200},{"slug":"zucchini","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de zoete aardappel volgens de verpakking.
2. Bak de seitan in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok courgette beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the sweet potato per the package.
2. Pan-fry the seitan in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the zucchini until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('seitan_with_sweet_potato_stir_fry_veg','Seitan met zoete aardappel & wokgroente','Seitan with sweet potato & stir-fry veg',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"seitan","g":130},{"slug":"sweet_potato","g":200},{"slug":"mixed_veg","g":150},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de zoete aardappel volgens de verpakking.
2. Bak de seitan in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok wokgroente beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the sweet potato per the package.
2. Pan-fry the seitan in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the stir-fry veg until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('seitan_with_sweet_potato_mushrooms','Seitan met zoete aardappel & champignons','Seitan with sweet potato & mushrooms',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"seitan","g":130},{"slug":"sweet_potato","g":200},{"slug":"mushroom","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de zoete aardappel volgens de verpakking.
2. Bak de seitan in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok champignons beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the sweet potato per the package.
2. Pan-fry the seitan in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the mushrooms until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('seitan_with_sweet_potato_carrot','Seitan met zoete aardappel & wortel','Seitan with sweet potato & carrot',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"seitan","g":130},{"slug":"sweet_potato","g":200},{"slug":"carrot","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY[]::text[],'1. Kook de zoete aardappel volgens de verpakking.
2. Bak de seitan in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok wortel beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the sweet potato per the package.
2. Pan-fry the seitan in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the carrot until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('seitan_with_sweet_potato_peas','Seitan met zoete aardappel & doperwten','Seitan with sweet potato & peas',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"seitan","g":130},{"slug":"sweet_potato","g":200},{"slug":"peas","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de zoete aardappel volgens de verpakking.
2. Bak de seitan in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok doperwten beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the sweet potato per the package.
2. Pan-fry the seitan in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the peas until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('seitan_with_sweet_potato_cauliflower','Seitan met zoete aardappel & bloemkool','Seitan with sweet potato & cauliflower',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"seitan","g":130},{"slug":"sweet_potato","g":200},{"slug":"cauliflower","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de zoete aardappel volgens de verpakking.
2. Bak de seitan in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok bloemkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the sweet potato per the package.
2. Pan-fry the seitan in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the cauliflower until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('seitan_with_sweet_potato_kale','Seitan met zoete aardappel & boerenkool','Seitan with sweet potato & kale',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"seitan","g":130},{"slug":"sweet_potato","g":200},{"slug":"kale","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de zoete aardappel volgens de verpakking.
2. Bak de seitan in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok boerenkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the sweet potato per the package.
2. Pan-fry the seitan in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the kale until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('seitan_with_sweet_potato_bok_choy','Seitan met zoete aardappel & paksoi','Seitan with sweet potato & bok choy',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"seitan","g":130},{"slug":"sweet_potato","g":200},{"slug":"bok_choy","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de zoete aardappel volgens de verpakking.
2. Bak de seitan in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok paksoi beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the sweet potato per the package.
2. Pan-fry the seitan in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the bok choy until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('seitan_with_potato_broccoli','Seitan met aardappel & broccoli','Seitan with potato & broccoli',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"seitan","g":130},{"slug":"potato","g":250},{"slug":"broccoli","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['steakpotato']::text[],'1. Kook de aardappel volgens de verpakking.
2. Bak de seitan in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok broccoli beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the potato per the package.
2. Pan-fry the seitan in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the broccoli until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('seitan_with_potato_green_beans','Seitan met aardappel & sperziebonen','Seitan with potato & green beans',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"seitan","g":130},{"slug":"potato","g":250},{"slug":"green_beans","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['steakpotato']::text[],'1. Kook de aardappel volgens de verpakking.
2. Bak de seitan in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok sperziebonen beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the potato per the package.
2. Pan-fry the seitan in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the green beans until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('seitan_with_potato_spinach','Seitan met aardappel & spinazie','Seitan with potato & spinach',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"seitan","g":130},{"slug":"potato","g":250},{"slug":"spinach","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['steakpotato']::text[],'1. Kook de aardappel volgens de verpakking.
2. Bak de seitan in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok spinazie beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the potato per the package.
2. Pan-fry the seitan in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the spinach until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('seitan_with_potato_asparagus','Seitan met aardappel & asperges','Seitan with potato & asparagus',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"seitan","g":130},{"slug":"potato","g":250},{"slug":"asparagus","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['steakpotato']::text[],'1. Kook de aardappel volgens de verpakking.
2. Bak de seitan in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok asperges beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the potato per the package.
2. Pan-fry the seitan in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the asparagus until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('seitan_with_potato_zucchini','Seitan met aardappel & courgette','Seitan with potato & zucchini',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"seitan","g":130},{"slug":"potato","g":250},{"slug":"zucchini","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['steakpotato']::text[],'1. Kook de aardappel volgens de verpakking.
2. Bak de seitan in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok courgette beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the potato per the package.
2. Pan-fry the seitan in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the zucchini until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('seitan_with_potato_stir_fry_veg','Seitan met aardappel & wokgroente','Seitan with potato & stir-fry veg',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"seitan","g":130},{"slug":"potato","g":250},{"slug":"mixed_veg","g":150},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['steakpotato']::text[],'1. Kook de aardappel volgens de verpakking.
2. Bak de seitan in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok wokgroente beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the potato per the package.
2. Pan-fry the seitan in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the stir-fry veg until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('seitan_with_potato_mushrooms','Seitan met aardappel & champignons','Seitan with potato & mushrooms',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"seitan","g":130},{"slug":"potato","g":250},{"slug":"mushroom","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['steakpotato']::text[],'1. Kook de aardappel volgens de verpakking.
2. Bak de seitan in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok champignons beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the potato per the package.
2. Pan-fry the seitan in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the mushrooms until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('seitan_with_potato_carrot','Seitan met aardappel & wortel','Seitan with potato & carrot',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"seitan","g":130},{"slug":"potato","g":250},{"slug":"carrot","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['steakpotato']::text[],'1. Kook de aardappel volgens de verpakking.
2. Bak de seitan in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok wortel beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the potato per the package.
2. Pan-fry the seitan in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the carrot until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('seitan_with_potato_peas','Seitan met aardappel & doperwten','Seitan with potato & peas',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"seitan","g":130},{"slug":"potato","g":250},{"slug":"peas","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['steakpotato']::text[],'1. Kook de aardappel volgens de verpakking.
2. Bak de seitan in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok doperwten beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the potato per the package.
2. Pan-fry the seitan in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the peas until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('seitan_with_potato_cauliflower','Seitan met aardappel & bloemkool','Seitan with potato & cauliflower',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"seitan","g":130},{"slug":"potato","g":250},{"slug":"cauliflower","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['steakpotato']::text[],'1. Kook de aardappel volgens de verpakking.
2. Bak de seitan in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok bloemkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the potato per the package.
2. Pan-fry the seitan in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the cauliflower until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('seitan_with_potato_kale','Seitan met aardappel & boerenkool','Seitan with potato & kale',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"seitan","g":130},{"slug":"potato","g":250},{"slug":"kale","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['steakpotato']::text[],'1. Kook de aardappel volgens de verpakking.
2. Bak de seitan in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok boerenkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the potato per the package.
2. Pan-fry the seitan in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the kale until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('seitan_with_potato_bok_choy','Seitan met aardappel & paksoi','Seitan with potato & bok choy',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"seitan","g":130},{"slug":"potato","g":250},{"slug":"bok_choy","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['steakpotato']::text[],'1. Kook de aardappel volgens de verpakking.
2. Bak de seitan in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok paksoi beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the potato per the package.
2. Pan-fry the seitan in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the bok choy until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('seitan_with_pasta_broccoli','Seitan met pasta & broccoli','Seitan with pasta & broccoli',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"seitan","g":130},{"slug":"pasta_dry","g":80},{"slug":"broccoli","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['pastabol']::text[],'1. Kook de volkoren pasta (droog) volgens de verpakking.
2. Bak de seitan in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok broccoli beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat pasta (dry) per the package.
2. Pan-fry the seitan in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the broccoli until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('seitan_with_pasta_green_beans','Seitan met pasta & sperziebonen','Seitan with pasta & green beans',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"seitan","g":130},{"slug":"pasta_dry","g":80},{"slug":"green_beans","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['pastabol']::text[],'1. Kook de volkoren pasta (droog) volgens de verpakking.
2. Bak de seitan in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok sperziebonen beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat pasta (dry) per the package.
2. Pan-fry the seitan in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the green beans until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('seitan_with_pasta_spinach','Seitan met pasta & spinazie','Seitan with pasta & spinach',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"seitan","g":130},{"slug":"pasta_dry","g":80},{"slug":"spinach","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['pastabol']::text[],'1. Kook de volkoren pasta (droog) volgens de verpakking.
2. Bak de seitan in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok spinazie beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat pasta (dry) per the package.
2. Pan-fry the seitan in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the spinach until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('seitan_with_pasta_asparagus','Seitan met pasta & asperges','Seitan with pasta & asparagus',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"seitan","g":130},{"slug":"pasta_dry","g":80},{"slug":"asparagus","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['pastabol']::text[],'1. Kook de volkoren pasta (droog) volgens de verpakking.
2. Bak de seitan in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok asperges beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat pasta (dry) per the package.
2. Pan-fry the seitan in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the asparagus until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('seitan_with_pasta_zucchini','Seitan met pasta & courgette','Seitan with pasta & zucchini',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"seitan","g":130},{"slug":"pasta_dry","g":80},{"slug":"zucchini","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['pastabol']::text[],'1. Kook de volkoren pasta (droog) volgens de verpakking.
2. Bak de seitan in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok courgette beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat pasta (dry) per the package.
2. Pan-fry the seitan in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the zucchini until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('seitan_with_pasta_stir_fry_veg','Seitan met pasta & wokgroente','Seitan with pasta & stir-fry veg',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"seitan","g":130},{"slug":"pasta_dry","g":80},{"slug":"mixed_veg","g":150},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['pastabol']::text[],'1. Kook de volkoren pasta (droog) volgens de verpakking.
2. Bak de seitan in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok wokgroente beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat pasta (dry) per the package.
2. Pan-fry the seitan in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the stir-fry veg until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('seitan_with_pasta_mushrooms','Seitan met pasta & champignons','Seitan with pasta & mushrooms',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"seitan","g":130},{"slug":"pasta_dry","g":80},{"slug":"mushroom","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['pastabol']::text[],'1. Kook de volkoren pasta (droog) volgens de verpakking.
2. Bak de seitan in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok champignons beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat pasta (dry) per the package.
2. Pan-fry the seitan in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the mushrooms until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('seitan_with_pasta_carrot','Seitan met pasta & wortel','Seitan with pasta & carrot',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"seitan","g":130},{"slug":"pasta_dry","g":80},{"slug":"carrot","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['pastabol']::text[],'1. Kook de volkoren pasta (droog) volgens de verpakking.
2. Bak de seitan in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok wortel beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat pasta (dry) per the package.
2. Pan-fry the seitan in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the carrot until tender-crisp.
4. Plate up and finish.','pan',null,'core')
on conflict (slug) do update set name_nl=excluded.name_nl,name_en=excluded.name_en,moments=excluded.moments,goals=excluded.goals,items=excluded.items,tags=excluded.tags,prefs=excluded.prefs,steps=excluded.steps,steps_en=excluded.steps_en,technique=excluded.technique,temp=excluded.temp;
commit;
