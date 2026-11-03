-- AUTO-GEGENEREERD core-seed deel 8/9 (200 gerechten). Draai NA dish-library.sql.
-- Draai de delen op volgorde (01, 02, ...). Elk deel is los veilig (upsert).
begin;
insert into public.dishes (slug,name_nl,name_en,moments,goals,items,tags,prefs,steps,steps_en,technique,temp,source) values
('seitan_with_pasta_peas','Seitan met pasta & doperwten','Seitan with pasta & peas',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"seitan","g":130},{"slug":"pasta_dry","g":80},{"slug":"peas","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['pastabol']::text[],'1. Kook de volkoren pasta (droog) volgens de verpakking.
2. Bak de seitan in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok doperwten beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat pasta (dry) per the package.
2. Pan-fry the seitan in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the peas until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('seitan_with_pasta_cauliflower','Seitan met pasta & bloemkool','Seitan with pasta & cauliflower',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"seitan","g":130},{"slug":"pasta_dry","g":80},{"slug":"cauliflower","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['pastabol']::text[],'1. Kook de volkoren pasta (droog) volgens de verpakking.
2. Bak de seitan in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok bloemkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat pasta (dry) per the package.
2. Pan-fry the seitan in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the cauliflower until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('seitan_with_pasta_kale','Seitan met pasta & boerenkool','Seitan with pasta & kale',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"seitan","g":130},{"slug":"pasta_dry","g":80},{"slug":"kale","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['pastabol']::text[],'1. Kook de volkoren pasta (droog) volgens de verpakking.
2. Bak de seitan in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok boerenkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat pasta (dry) per the package.
2. Pan-fry the seitan in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the kale until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('seitan_with_pasta_bok_choy','Seitan met pasta & paksoi','Seitan with pasta & bok choy',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"seitan","g":130},{"slug":"pasta_dry","g":80},{"slug":"bok_choy","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['pastabol']::text[],'1. Kook de volkoren pasta (droog) volgens de verpakking.
2. Bak de seitan in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok paksoi beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat pasta (dry) per the package.
2. Pan-fry the seitan in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the bok choy until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('seitan_with_quinoa_broccoli','Seitan met quinoa & broccoli','Seitan with quinoa & broccoli',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"seitan","g":130},{"slug":"quinoa_dry","g":70},{"slug":"broccoli","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de quinoa (droog) volgens de verpakking.
2. Bak de seitan in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok broccoli beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the quinoa (dry) per the package.
2. Pan-fry the seitan in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the broccoli until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('seitan_with_quinoa_green_beans','Seitan met quinoa & sperziebonen','Seitan with quinoa & green beans',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"seitan","g":130},{"slug":"quinoa_dry","g":70},{"slug":"green_beans","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de quinoa (droog) volgens de verpakking.
2. Bak de seitan in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok sperziebonen beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the quinoa (dry) per the package.
2. Pan-fry the seitan in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the green beans until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('seitan_with_quinoa_spinach','Seitan met quinoa & spinazie','Seitan with quinoa & spinach',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"seitan","g":130},{"slug":"quinoa_dry","g":70},{"slug":"spinach","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de quinoa (droog) volgens de verpakking.
2. Bak de seitan in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok spinazie beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the quinoa (dry) per the package.
2. Pan-fry the seitan in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the spinach until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('seitan_with_quinoa_asparagus','Seitan met quinoa & asperges','Seitan with quinoa & asparagus',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"seitan","g":130},{"slug":"quinoa_dry","g":70},{"slug":"asparagus","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de quinoa (droog) volgens de verpakking.
2. Bak de seitan in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok asperges beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the quinoa (dry) per the package.
2. Pan-fry the seitan in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the asparagus until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('seitan_with_quinoa_zucchini','Seitan met quinoa & courgette','Seitan with quinoa & zucchini',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"seitan","g":130},{"slug":"quinoa_dry","g":70},{"slug":"zucchini","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de quinoa (droog) volgens de verpakking.
2. Bak de seitan in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok courgette beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the quinoa (dry) per the package.
2. Pan-fry the seitan in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the zucchini until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('seitan_with_quinoa_stir_fry_veg','Seitan met quinoa & wokgroente','Seitan with quinoa & stir-fry veg',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"seitan","g":130},{"slug":"quinoa_dry","g":70},{"slug":"mixed_veg","g":150},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY[]::text[],'1. Kook de quinoa (droog) volgens de verpakking.
2. Bak de seitan in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok wokgroente beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the quinoa (dry) per the package.
2. Pan-fry the seitan in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the stir-fry veg until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('seitan_with_quinoa_mushrooms','Seitan met quinoa & champignons','Seitan with quinoa & mushrooms',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"seitan","g":130},{"slug":"quinoa_dry","g":70},{"slug":"mushroom","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de quinoa (droog) volgens de verpakking.
2. Bak de seitan in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok champignons beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the quinoa (dry) per the package.
2. Pan-fry the seitan in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the mushrooms until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('seitan_with_quinoa_carrot','Seitan met quinoa & wortel','Seitan with quinoa & carrot',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"seitan","g":130},{"slug":"quinoa_dry","g":70},{"slug":"carrot","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY[]::text[],'1. Kook de quinoa (droog) volgens de verpakking.
2. Bak de seitan in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok wortel beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the quinoa (dry) per the package.
2. Pan-fry the seitan in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the carrot until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('seitan_with_quinoa_peas','Seitan met quinoa & doperwten','Seitan with quinoa & peas',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"seitan","g":130},{"slug":"quinoa_dry","g":70},{"slug":"peas","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de quinoa (droog) volgens de verpakking.
2. Bak de seitan in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok doperwten beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the quinoa (dry) per the package.
2. Pan-fry the seitan in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the peas until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('seitan_with_quinoa_cauliflower','Seitan met quinoa & bloemkool','Seitan with quinoa & cauliflower',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"seitan","g":130},{"slug":"quinoa_dry","g":70},{"slug":"cauliflower","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de quinoa (droog) volgens de verpakking.
2. Bak de seitan in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok bloemkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the quinoa (dry) per the package.
2. Pan-fry the seitan in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the cauliflower until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('seitan_with_quinoa_kale','Seitan met quinoa & boerenkool','Seitan with quinoa & kale',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"seitan","g":130},{"slug":"quinoa_dry","g":70},{"slug":"kale","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de quinoa (droog) volgens de verpakking.
2. Bak de seitan in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok boerenkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the quinoa (dry) per the package.
2. Pan-fry the seitan in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the kale until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('seitan_with_quinoa_bok_choy','Seitan met quinoa & paksoi','Seitan with quinoa & bok choy',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"seitan","g":130},{"slug":"quinoa_dry","g":70},{"slug":"bok_choy","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de quinoa (droog) volgens de verpakking.
2. Bak de seitan in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok paksoi beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the quinoa (dry) per the package.
2. Pan-fry the seitan in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the bok choy until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('seitan_with_noodles_broccoli','Seitan met noedels & broccoli','Seitan with noodles & broccoli',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"seitan","g":130},{"slug":"noodles_dry","g":80},{"slug":"broccoli","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['woknoodles']::text[],'1. Kook de volkoren noedels (droog) volgens de verpakking.
2. Bak de seitan in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok broccoli beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat noodles (dry) per the package.
2. Pan-fry the seitan in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the broccoli until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('seitan_with_noodles_green_beans','Seitan met noedels & sperziebonen','Seitan with noodles & green beans',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"seitan","g":130},{"slug":"noodles_dry","g":80},{"slug":"green_beans","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['woknoodles']::text[],'1. Kook de volkoren noedels (droog) volgens de verpakking.
2. Bak de seitan in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok sperziebonen beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat noodles (dry) per the package.
2. Pan-fry the seitan in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the green beans until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('seitan_with_noodles_spinach','Seitan met noedels & spinazie','Seitan with noodles & spinach',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"seitan","g":130},{"slug":"noodles_dry","g":80},{"slug":"spinach","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['woknoodles']::text[],'1. Kook de volkoren noedels (droog) volgens de verpakking.
2. Bak de seitan in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok spinazie beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat noodles (dry) per the package.
2. Pan-fry the seitan in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the spinach until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('seitan_with_noodles_asparagus','Seitan met noedels & asperges','Seitan with noodles & asparagus',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"seitan","g":130},{"slug":"noodles_dry","g":80},{"slug":"asparagus","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['woknoodles']::text[],'1. Kook de volkoren noedels (droog) volgens de verpakking.
2. Bak de seitan in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok asperges beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat noodles (dry) per the package.
2. Pan-fry the seitan in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the asparagus until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('seitan_with_noodles_zucchini','Seitan met noedels & courgette','Seitan with noodles & zucchini',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"seitan","g":130},{"slug":"noodles_dry","g":80},{"slug":"zucchini","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['woknoodles']::text[],'1. Kook de volkoren noedels (droog) volgens de verpakking.
2. Bak de seitan in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok courgette beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat noodles (dry) per the package.
2. Pan-fry the seitan in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the zucchini until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('seitan_with_noodles_stir_fry_veg','Seitan met noedels & wokgroente','Seitan with noodles & stir-fry veg',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"seitan","g":130},{"slug":"noodles_dry","g":80},{"slug":"mixed_veg","g":150},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['woknoodles']::text[],'1. Kook de volkoren noedels (droog) volgens de verpakking.
2. Bak de seitan in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok wokgroente beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat noodles (dry) per the package.
2. Pan-fry the seitan in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the stir-fry veg until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('seitan_with_noodles_mushrooms','Seitan met noedels & champignons','Seitan with noodles & mushrooms',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"seitan","g":130},{"slug":"noodles_dry","g":80},{"slug":"mushroom","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['woknoodles']::text[],'1. Kook de volkoren noedels (droog) volgens de verpakking.
2. Bak de seitan in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok champignons beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat noodles (dry) per the package.
2. Pan-fry the seitan in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the mushrooms until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('seitan_with_noodles_carrot','Seitan met noedels & wortel','Seitan with noodles & carrot',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"seitan","g":130},{"slug":"noodles_dry","g":80},{"slug":"carrot","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['woknoodles']::text[],'1. Kook de volkoren noedels (droog) volgens de verpakking.
2. Bak de seitan in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok wortel beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat noodles (dry) per the package.
2. Pan-fry the seitan in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the carrot until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('seitan_with_noodles_peas','Seitan met noedels & doperwten','Seitan with noodles & peas',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"seitan","g":130},{"slug":"noodles_dry","g":80},{"slug":"peas","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY['woknoodles']::text[],'1. Kook de volkoren noedels (droog) volgens de verpakking.
2. Bak de seitan in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok doperwten beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat noodles (dry) per the package.
2. Pan-fry the seitan in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the peas until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('seitan_with_noodles_cauliflower','Seitan met noedels & bloemkool','Seitan with noodles & cauliflower',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"seitan","g":130},{"slug":"noodles_dry","g":80},{"slug":"cauliflower","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['woknoodles']::text[],'1. Kook de volkoren noedels (droog) volgens de verpakking.
2. Bak de seitan in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok bloemkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat noodles (dry) per the package.
2. Pan-fry the seitan in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the cauliflower until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('seitan_with_noodles_kale','Seitan met noedels & boerenkool','Seitan with noodles & kale',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"seitan","g":130},{"slug":"noodles_dry","g":80},{"slug":"kale","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['woknoodles']::text[],'1. Kook de volkoren noedels (droog) volgens de verpakking.
2. Bak de seitan in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok boerenkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat noodles (dry) per the package.
2. Pan-fry the seitan in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the kale until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('seitan_with_noodles_bok_choy','Seitan met noedels & paksoi','Seitan with noodles & bok choy',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"seitan","g":130},{"slug":"noodles_dry","g":80},{"slug":"bok_choy","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['woknoodles']::text[],'1. Kook de volkoren noedels (droog) volgens de verpakking.
2. Bak de seitan in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok paksoi beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat noodles (dry) per the package.
2. Pan-fry the seitan in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the bok choy until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('seitan_with_couscous_broccoli','Seitan met couscous & broccoli','Seitan with couscous & broccoli',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"seitan","g":130},{"slug":"couscous_dry","g":70},{"slug":"broccoli","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de volkoren couscous (droog) volgens de verpakking.
2. Bak de seitan in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok broccoli beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat couscous (dry) per the package.
2. Pan-fry the seitan in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the broccoli until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('seitan_with_couscous_green_beans','Seitan met couscous & sperziebonen','Seitan with couscous & green beans',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"seitan","g":130},{"slug":"couscous_dry","g":70},{"slug":"green_beans","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de volkoren couscous (droog) volgens de verpakking.
2. Bak de seitan in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok sperziebonen beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat couscous (dry) per the package.
2. Pan-fry the seitan in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the green beans until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('seitan_with_couscous_spinach','Seitan met couscous & spinazie','Seitan with couscous & spinach',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"seitan","g":130},{"slug":"couscous_dry","g":70},{"slug":"spinach","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de volkoren couscous (droog) volgens de verpakking.
2. Bak de seitan in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok spinazie beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat couscous (dry) per the package.
2. Pan-fry the seitan in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the spinach until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('seitan_with_couscous_asparagus','Seitan met couscous & asperges','Seitan with couscous & asparagus',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"seitan","g":130},{"slug":"couscous_dry","g":70},{"slug":"asparagus","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de volkoren couscous (droog) volgens de verpakking.
2. Bak de seitan in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok asperges beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat couscous (dry) per the package.
2. Pan-fry the seitan in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the asparagus until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('seitan_with_couscous_zucchini','Seitan met couscous & courgette','Seitan with couscous & zucchini',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"seitan","g":130},{"slug":"couscous_dry","g":70},{"slug":"zucchini","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de volkoren couscous (droog) volgens de verpakking.
2. Bak de seitan in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok courgette beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat couscous (dry) per the package.
2. Pan-fry the seitan in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the zucchini until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('seitan_with_couscous_stir_fry_veg','Seitan met couscous & wokgroente','Seitan with couscous & stir-fry veg',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"seitan","g":130},{"slug":"couscous_dry","g":70},{"slug":"mixed_veg","g":150},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY[]::text[],'1. Kook de volkoren couscous (droog) volgens de verpakking.
2. Bak de seitan in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok wokgroente beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat couscous (dry) per the package.
2. Pan-fry the seitan in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the stir-fry veg until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('seitan_with_couscous_mushrooms','Seitan met couscous & champignons','Seitan with couscous & mushrooms',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"seitan","g":130},{"slug":"couscous_dry","g":70},{"slug":"mushroom","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de volkoren couscous (droog) volgens de verpakking.
2. Bak de seitan in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok champignons beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat couscous (dry) per the package.
2. Pan-fry the seitan in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the mushrooms until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('seitan_with_couscous_carrot','Seitan met couscous & wortel','Seitan with couscous & carrot',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"seitan","g":130},{"slug":"couscous_dry","g":70},{"slug":"carrot","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY[]::text[],'1. Kook de volkoren couscous (droog) volgens de verpakking.
2. Bak de seitan in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok wortel beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat couscous (dry) per the package.
2. Pan-fry the seitan in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the carrot until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('seitan_with_couscous_peas','Seitan met couscous & doperwten','Seitan with couscous & peas',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"seitan","g":130},{"slug":"couscous_dry","g":70},{"slug":"peas","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY[]::text[],'1. Kook de volkoren couscous (droog) volgens de verpakking.
2. Bak de seitan in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok doperwten beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat couscous (dry) per the package.
2. Pan-fry the seitan in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the peas until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('seitan_with_couscous_cauliflower','Seitan met couscous & bloemkool','Seitan with couscous & cauliflower',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"seitan","g":130},{"slug":"couscous_dry","g":70},{"slug":"cauliflower","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de volkoren couscous (droog) volgens de verpakking.
2. Bak de seitan in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok bloemkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat couscous (dry) per the package.
2. Pan-fry the seitan in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the cauliflower until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('seitan_with_couscous_kale','Seitan met couscous & boerenkool','Seitan with couscous & kale',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"seitan","g":130},{"slug":"couscous_dry","g":70},{"slug":"kale","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de volkoren couscous (droog) volgens de verpakking.
2. Bak de seitan in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok boerenkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat couscous (dry) per the package.
2. Pan-fry the seitan in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the kale until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('seitan_with_couscous_bok_choy','Seitan met couscous & paksoi','Seitan with couscous & bok choy',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"seitan","g":130},{"slug":"couscous_dry","g":70},{"slug":"bok_choy","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de volkoren couscous (droog) volgens de verpakking.
2. Bak de seitan in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok paksoi beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the wholewheat couscous (dry) per the package.
2. Pan-fry the seitan in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the bok choy until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('seitan_with_bulgur_broccoli','Seitan met bulgur & broccoli','Seitan with bulgur & broccoli',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"seitan","g":130},{"slug":"bulgur_dry","g":70},{"slug":"broccoli","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de bulgur (droog) volgens de verpakking.
2. Bak de seitan in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok broccoli beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the bulgur (dry) per the package.
2. Pan-fry the seitan in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the broccoli until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('seitan_with_bulgur_green_beans','Seitan met bulgur & sperziebonen','Seitan with bulgur & green beans',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"seitan","g":130},{"slug":"bulgur_dry","g":70},{"slug":"green_beans","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de bulgur (droog) volgens de verpakking.
2. Bak de seitan in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok sperziebonen beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the bulgur (dry) per the package.
2. Pan-fry the seitan in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the green beans until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('seitan_with_bulgur_spinach','Seitan met bulgur & spinazie','Seitan with bulgur & spinach',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"seitan","g":130},{"slug":"bulgur_dry","g":70},{"slug":"spinach","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de bulgur (droog) volgens de verpakking.
2. Bak de seitan in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok spinazie beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the bulgur (dry) per the package.
2. Pan-fry the seitan in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the spinach until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('seitan_with_bulgur_asparagus','Seitan met bulgur & asperges','Seitan with bulgur & asparagus',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"seitan","g":130},{"slug":"bulgur_dry","g":70},{"slug":"asparagus","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de bulgur (droog) volgens de verpakking.
2. Bak de seitan in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok asperges beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the bulgur (dry) per the package.
2. Pan-fry the seitan in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the asparagus until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('seitan_with_bulgur_zucchini','Seitan met bulgur & courgette','Seitan with bulgur & zucchini',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"seitan","g":130},{"slug":"bulgur_dry","g":70},{"slug":"zucchini","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de bulgur (droog) volgens de verpakking.
2. Bak de seitan in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok courgette beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the bulgur (dry) per the package.
2. Pan-fry the seitan in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the zucchini until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('seitan_with_bulgur_stir_fry_veg','Seitan met bulgur & wokgroente','Seitan with bulgur & stir-fry veg',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"seitan","g":130},{"slug":"bulgur_dry","g":70},{"slug":"mixed_veg","g":150},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de bulgur (droog) volgens de verpakking.
2. Bak de seitan in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok wokgroente beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the bulgur (dry) per the package.
2. Pan-fry the seitan in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the stir-fry veg until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('seitan_with_bulgur_mushrooms','Seitan met bulgur & champignons','Seitan with bulgur & mushrooms',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"seitan","g":130},{"slug":"bulgur_dry","g":70},{"slug":"mushroom","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de bulgur (droog) volgens de verpakking.
2. Bak de seitan in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok champignons beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the bulgur (dry) per the package.
2. Pan-fry the seitan in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the mushrooms until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('seitan_with_bulgur_carrot','Seitan met bulgur & wortel','Seitan with bulgur & carrot',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"seitan","g":130},{"slug":"bulgur_dry","g":70},{"slug":"carrot","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY[]::text[],'1. Kook de bulgur (droog) volgens de verpakking.
2. Bak de seitan in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok wortel beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the bulgur (dry) per the package.
2. Pan-fry the seitan in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the carrot until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('seitan_with_bulgur_peas','Seitan met bulgur & doperwten','Seitan with bulgur & peas',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"seitan","g":130},{"slug":"bulgur_dry","g":70},{"slug":"peas","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de bulgur (droog) volgens de verpakking.
2. Bak de seitan in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok doperwten beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the bulgur (dry) per the package.
2. Pan-fry the seitan in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the peas until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('seitan_with_bulgur_cauliflower','Seitan met bulgur & bloemkool','Seitan with bulgur & cauliflower',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"seitan","g":130},{"slug":"bulgur_dry","g":70},{"slug":"cauliflower","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de bulgur (droog) volgens de verpakking.
2. Bak de seitan in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok bloemkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the bulgur (dry) per the package.
2. Pan-fry the seitan in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the cauliflower until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('seitan_with_bulgur_kale','Seitan met bulgur & boerenkool','Seitan with bulgur & kale',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"seitan","g":130},{"slug":"bulgur_dry","g":70},{"slug":"kale","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de bulgur (droog) volgens de verpakking.
2. Bak de seitan in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok boerenkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the bulgur (dry) per the package.
2. Pan-fry the seitan in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the kale until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('seitan_with_bulgur_bok_choy','Seitan met bulgur & paksoi','Seitan with bulgur & bok choy',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"seitan","g":130},{"slug":"bulgur_dry","g":70},{"slug":"bok_choy","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de bulgur (droog) volgens de verpakking.
2. Bak de seitan in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok paksoi beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the bulgur (dry) per the package.
2. Pan-fry the seitan in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the bok choy until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('seitan_with_basmati_rice_broccoli','Seitan met basmatirijst & broccoli','Seitan with basmati rice & broccoli',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"seitan","g":130},{"slug":"basmati_dry","g":70},{"slug":"broccoli","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY[]::text[],'1. Kook de basmatirijst (droog) volgens de verpakking.
2. Bak de seitan in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok broccoli beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the basmati rice (dry) per the package.
2. Pan-fry the seitan in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the broccoli until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('seitan_with_basmati_rice_green_beans','Seitan met basmatirijst & sperziebonen','Seitan with basmati rice & green beans',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"seitan","g":130},{"slug":"basmati_dry","g":70},{"slug":"green_beans","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY[]::text[],'1. Kook de basmatirijst (droog) volgens de verpakking.
2. Bak de seitan in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok sperziebonen beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the basmati rice (dry) per the package.
2. Pan-fry the seitan in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the green beans until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('seitan_with_basmati_rice_spinach','Seitan met basmatirijst & spinazie','Seitan with basmati rice & spinach',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"seitan","g":130},{"slug":"basmati_dry","g":70},{"slug":"spinach","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY[]::text[],'1. Kook de basmatirijst (droog) volgens de verpakking.
2. Bak de seitan in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok spinazie beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the basmati rice (dry) per the package.
2. Pan-fry the seitan in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the spinach until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('seitan_with_basmati_rice_asparagus','Seitan met basmatirijst & asperges','Seitan with basmati rice & asparagus',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"seitan","g":130},{"slug":"basmati_dry","g":70},{"slug":"asparagus","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY[]::text[],'1. Kook de basmatirijst (droog) volgens de verpakking.
2. Bak de seitan in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok asperges beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the basmati rice (dry) per the package.
2. Pan-fry the seitan in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the asparagus until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('seitan_with_basmati_rice_zucchini','Seitan met basmatirijst & courgette','Seitan with basmati rice & zucchini',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"seitan","g":130},{"slug":"basmati_dry","g":70},{"slug":"zucchini","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY[]::text[],'1. Kook de basmatirijst (droog) volgens de verpakking.
2. Bak de seitan in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok courgette beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the basmati rice (dry) per the package.
2. Pan-fry the seitan in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the zucchini until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('seitan_with_basmati_rice_stir_fry_veg','Seitan met basmatirijst & wokgroente','Seitan with basmati rice & stir-fry veg',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"seitan","g":130},{"slug":"basmati_dry","g":70},{"slug":"mixed_veg","g":150},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY[]::text[],'1. Kook de basmatirijst (droog) volgens de verpakking.
2. Bak de seitan in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok wokgroente beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the basmati rice (dry) per the package.
2. Pan-fry the seitan in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the stir-fry veg until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('seitan_with_basmati_rice_mushrooms','Seitan met basmatirijst & champignons','Seitan with basmati rice & mushrooms',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"seitan","g":130},{"slug":"basmati_dry","g":70},{"slug":"mushroom","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY[]::text[],'1. Kook de basmatirijst (droog) volgens de verpakking.
2. Bak de seitan in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok champignons beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the basmati rice (dry) per the package.
2. Pan-fry the seitan in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the mushrooms until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('seitan_with_basmati_rice_carrot','Seitan met basmatirijst & wortel','Seitan with basmati rice & carrot',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"seitan","g":130},{"slug":"basmati_dry","g":70},{"slug":"carrot","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY[]::text[],'1. Kook de basmatirijst (droog) volgens de verpakking.
2. Bak de seitan in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok wortel beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the basmati rice (dry) per the package.
2. Pan-fry the seitan in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the carrot until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('seitan_with_basmati_rice_peas','Seitan met basmatirijst & doperwten','Seitan with basmati rice & peas',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"seitan","g":130},{"slug":"basmati_dry","g":70},{"slug":"peas","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY[]::text[],'1. Kook de basmatirijst (droog) volgens de verpakking.
2. Bak de seitan in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok doperwten beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the basmati rice (dry) per the package.
2. Pan-fry the seitan in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the peas until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('seitan_with_basmati_rice_cauliflower','Seitan met basmatirijst & bloemkool','Seitan with basmati rice & cauliflower',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"seitan","g":130},{"slug":"basmati_dry","g":70},{"slug":"cauliflower","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY[]::text[],'1. Kook de basmatirijst (droog) volgens de verpakking.
2. Bak de seitan in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok bloemkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the basmati rice (dry) per the package.
2. Pan-fry the seitan in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the cauliflower until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('seitan_with_basmati_rice_kale','Seitan met basmatirijst & boerenkool','Seitan with basmati rice & kale',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"seitan","g":130},{"slug":"basmati_dry","g":70},{"slug":"kale","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY[]::text[],'1. Kook de basmatirijst (droog) volgens de verpakking.
2. Bak de seitan in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok boerenkool beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the basmati rice (dry) per the package.
2. Pan-fry the seitan in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the kale until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('seitan_with_basmati_rice_bok_choy','Seitan met basmatirijst & paksoi','Seitan with basmati rice & bok choy',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"seitan","g":130},{"slug":"basmati_dry","g":70},{"slug":"bok_choy","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY[]::text[],ARRAY[]::text[],'1. Kook de basmatirijst (droog) volgens de verpakking.
2. Bak de seitan in een pan met olijfolie rondom gaar; kruid met peper en zout.
3. Stoom of wok paksoi beetgaar.
4. Verdeel over het bord en werk af.','1. Cook the basmati rice (dry) per the package.
2. Pan-fry the seitan in olive oil until done; season with salt and pepper.
3. Steam or stir-fry the bok choy until tender-crisp.
4. Plate up and finish.','pan',null,'core'),
('chicken_teriyaki_with_rice','Kip-teriyaki met rijst','Chicken teriyaki with rice',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"chicken_breast","g":160},{"slug":"rice_dry","g":70},{"slug":"mixed_veg","g":140},{"slug":"teriyaki","g":35}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de witte rijst (droog) volgens de verpakking.
2. Bak de kipfilet (gegrild) in een pan rondom gaar; kruid met peper en zout.
3. Stoom of wok wokgroente beetgaar.
4. Roer de teriyakisaus erdoor of serveer ernaast.
5. Verdeel over het bord en werk af.','1. Cook the white rice (dry) per the package.
2. Pan-fry the grilled chicken breast until done; season with salt and pepper.
3. Steam or stir-fry the stir-fry veg until tender-crisp.
4. Stir in the teriyaki sauce or serve on the side.
5. Plate up and finish.','pan',null,'core'),
('chicken_teriyaki_with_noodles','Kip-teriyaki met noedels','Chicken teriyaki with noodles',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"chicken_breast","g":160},{"slug":"noodles_dry","g":80},{"slug":"mixed_veg","g":140},{"slug":"teriyaki","g":35}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de volkoren noedels (droog) volgens de verpakking.
2. Bak de kipfilet (gegrild) in een pan rondom gaar; kruid met peper en zout.
3. Stoom of wok wokgroente beetgaar.
4. Roer de teriyakisaus erdoor of serveer ernaast.
5. Verdeel over het bord en werk af.','1. Cook the wholewheat noodles (dry) per the package.
2. Pan-fry the grilled chicken breast until done; season with salt and pepper.
3. Steam or stir-fry the stir-fry veg until tender-crisp.
4. Stir in the teriyaki sauce or serve on the side.
5. Plate up and finish.','pan',null,'core'),
('shrimp_teriyaki_with_rice','Garnalen-teriyaki met rijst','Shrimp teriyaki with rice',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"shrimp","g":150},{"slug":"rice_dry","g":70},{"slug":"mixed_veg","g":140},{"slug":"teriyaki","g":35}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de witte rijst (droog) volgens de verpakking.
2. Bak of pocheer de garnalen kort tot net gaar; kruid met peper en zout.
3. Stoom of wok wokgroente beetgaar.
4. Roer de teriyakisaus erdoor of serveer ernaast.
5. Verdeel over het bord en werk af.','1. Cook the white rice (dry) per the package.
2. Sear or poach the shrimp until just done; season with salt and pepper.
3. Steam or stir-fry the stir-fry veg until tender-crisp.
4. Stir in the teriyaki sauce or serve on the side.
5. Plate up and finish.','pan',null,'core'),
('shrimp_teriyaki_with_noodles','Garnalen-teriyaki met noedels','Shrimp teriyaki with noodles',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"shrimp","g":150},{"slug":"noodles_dry","g":80},{"slug":"mixed_veg","g":140},{"slug":"teriyaki","g":35}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de volkoren noedels (droog) volgens de verpakking.
2. Bak of pocheer de garnalen kort tot net gaar; kruid met peper en zout.
3. Stoom of wok wokgroente beetgaar.
4. Roer de teriyakisaus erdoor of serveer ernaast.
5. Verdeel over het bord en werk af.','1. Cook the wholewheat noodles (dry) per the package.
2. Sear or poach the shrimp until just done; season with salt and pepper.
3. Steam or stir-fry the stir-fry veg until tender-crisp.
4. Stir in the teriyaki sauce or serve on the side.
5. Plate up and finish.','pan',null,'core'),
('tofu_teriyaki_with_rice','Tofu-teriyaki met rijst','Tofu teriyaki with rice',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"tofu","g":150},{"slug":"rice_dry","g":70},{"slug":"mixed_veg","g":140},{"slug":"teriyaki","g":35}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY[]::text[],'1. Kook de witte rijst (droog) volgens de verpakking.
2. Bak de tofu in een pan rondom gaar; kruid met peper en zout.
3. Stoom of wok wokgroente beetgaar.
4. Roer de teriyakisaus erdoor of serveer ernaast.
5. Verdeel over het bord en werk af.','1. Cook the white rice (dry) per the package.
2. Pan-fry the tofu until done; season with salt and pepper.
3. Steam or stir-fry the stir-fry veg until tender-crisp.
4. Stir in the teriyaki sauce or serve on the side.
5. Plate up and finish.','pan',null,'core'),
('tofu_teriyaki_with_noodles','Tofu-teriyaki met noedels','Tofu teriyaki with noodles',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"tofu","g":150},{"slug":"noodles_dry","g":80},{"slug":"mixed_veg","g":140},{"slug":"teriyaki","g":35}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY[]::text[],'1. Kook de volkoren noedels (droog) volgens de verpakking.
2. Bak de tofu in een pan rondom gaar; kruid met peper en zout.
3. Stoom of wok wokgroente beetgaar.
4. Roer de teriyakisaus erdoor of serveer ernaast.
5. Verdeel over het bord en werk af.','1. Cook the wholewheat noodles (dry) per the package.
2. Pan-fry the tofu until done; season with salt and pepper.
3. Steam or stir-fry the stir-fry veg until tender-crisp.
4. Stir in the teriyaki sauce or serve on the side.
5. Plate up and finish.','pan',null,'core'),
('chicken_curry_with_rice','Kip-curry met rijst','Chicken curry with rice',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"chicken_breast","g":160},{"slug":"rice_dry","g":70},{"slug":"mixed_veg","g":140},{"slug":"curry_sauce","g":60}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['curryrice']::text[],'1. Kook de witte rijst (droog) volgens de verpakking.
2. Bak de kipfilet (gegrild) in een pan rondom gaar; kruid met peper en zout.
3. Stoom of wok wokgroente beetgaar.
4. Roer de currysaus (light) erdoor of serveer ernaast.
5. Verdeel over het bord en werk af.','1. Cook the white rice (dry) per the package.
2. Pan-fry the grilled chicken breast until done; season with salt and pepper.
3. Steam or stir-fry the stir-fry veg until tender-crisp.
4. Stir in the curry sauce (light) or serve on the side.
5. Plate up and finish.','pan',null,'core'),
('chicken_curry_with_noodles','Kip-curry met noedels','Chicken curry with noodles',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"chicken_breast","g":160},{"slug":"noodles_dry","g":80},{"slug":"mixed_veg","g":140},{"slug":"curry_sauce","g":60}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['curryrice']::text[],'1. Kook de volkoren noedels (droog) volgens de verpakking.
2. Bak de kipfilet (gegrild) in een pan rondom gaar; kruid met peper en zout.
3. Stoom of wok wokgroente beetgaar.
4. Roer de currysaus (light) erdoor of serveer ernaast.
5. Verdeel over het bord en werk af.','1. Cook the wholewheat noodles (dry) per the package.
2. Pan-fry the grilled chicken breast until done; season with salt and pepper.
3. Steam or stir-fry the stir-fry veg until tender-crisp.
4. Stir in the curry sauce (light) or serve on the side.
5. Plate up and finish.','pan',null,'core'),
('shrimp_curry_with_rice','Garnalen-curry met rijst','Shrimp curry with rice',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"shrimp","g":150},{"slug":"rice_dry","g":70},{"slug":"mixed_veg","g":140},{"slug":"curry_sauce","g":60}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['curryrice']::text[],'1. Kook de witte rijst (droog) volgens de verpakking.
2. Bak of pocheer de garnalen kort tot net gaar; kruid met peper en zout.
3. Stoom of wok wokgroente beetgaar.
4. Roer de currysaus (light) erdoor of serveer ernaast.
5. Verdeel over het bord en werk af.','1. Cook the white rice (dry) per the package.
2. Sear or poach the shrimp until just done; season with salt and pepper.
3. Steam or stir-fry the stir-fry veg until tender-crisp.
4. Stir in the curry sauce (light) or serve on the side.
5. Plate up and finish.','pan',null,'core'),
('shrimp_curry_with_noodles','Garnalen-curry met noedels','Shrimp curry with noodles',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"shrimp","g":150},{"slug":"noodles_dry","g":80},{"slug":"mixed_veg","g":140},{"slug":"curry_sauce","g":60}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['curryrice']::text[],'1. Kook de volkoren noedels (droog) volgens de verpakking.
2. Bak of pocheer de garnalen kort tot net gaar; kruid met peper en zout.
3. Stoom of wok wokgroente beetgaar.
4. Roer de currysaus (light) erdoor of serveer ernaast.
5. Verdeel over het bord en werk af.','1. Cook the wholewheat noodles (dry) per the package.
2. Sear or poach the shrimp until just done; season with salt and pepper.
3. Steam or stir-fry the stir-fry veg until tender-crisp.
4. Stir in the curry sauce (light) or serve on the side.
5. Plate up and finish.','pan',null,'core'),
('tofu_curry_with_rice','Tofu-curry met rijst','Tofu curry with rice',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"tofu","g":150},{"slug":"rice_dry","g":70},{"slug":"mixed_veg","g":140},{"slug":"curry_sauce","g":60}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY['curryrice']::text[],'1. Kook de witte rijst (droog) volgens de verpakking.
2. Bak de tofu in een pan rondom gaar; kruid met peper en zout.
3. Stoom of wok wokgroente beetgaar.
4. Roer de currysaus (light) erdoor of serveer ernaast.
5. Verdeel over het bord en werk af.','1. Cook the white rice (dry) per the package.
2. Pan-fry the tofu until done; season with salt and pepper.
3. Steam or stir-fry the stir-fry veg until tender-crisp.
4. Stir in the curry sauce (light) or serve on the side.
5. Plate up and finish.','pan',null,'core'),
('tofu_curry_with_noodles','Tofu-curry met noedels','Tofu curry with noodles',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"tofu","g":150},{"slug":"noodles_dry","g":80},{"slug":"mixed_veg","g":140},{"slug":"curry_sauce","g":60}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY['curryrice']::text[],'1. Kook de volkoren noedels (droog) volgens de verpakking.
2. Bak de tofu in een pan rondom gaar; kruid met peper en zout.
3. Stoom of wok wokgroente beetgaar.
4. Roer de currysaus (light) erdoor of serveer ernaast.
5. Verdeel over het bord en werk af.','1. Cook the wholewheat noodles (dry) per the package.
2. Pan-fry the tofu until done; season with salt and pepper.
3. Steam or stir-fry the stir-fry veg until tender-crisp.
4. Stir in the curry sauce (light) or serve on the side.
5. Plate up and finish.','pan',null,'core'),
('chicken_tomato_with_rice','Kip-tomaten met rijst','Chicken tomato with rice',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"chicken_breast","g":160},{"slug":"rice_dry","g":70},{"slug":"mixed_veg","g":140},{"slug":"tomato_sauce","g":80}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de witte rijst (droog) volgens de verpakking.
2. Bak de kipfilet (gegrild) in een pan rondom gaar; kruid met peper en zout.
3. Stoom of wok wokgroente beetgaar.
4. Roer de tomatensaus erdoor of serveer ernaast.
5. Verdeel over het bord en werk af.','1. Cook the white rice (dry) per the package.
2. Pan-fry the grilled chicken breast until done; season with salt and pepper.
3. Steam or stir-fry the stir-fry veg until tender-crisp.
4. Stir in the tomato sauce or serve on the side.
5. Plate up and finish.','pan',null,'core'),
('chicken_tomato_with_noodles','Kip-tomaten met noedels','Chicken tomato with noodles',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"chicken_breast","g":160},{"slug":"noodles_dry","g":80},{"slug":"mixed_veg","g":140},{"slug":"tomato_sauce","g":80}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de volkoren noedels (droog) volgens de verpakking.
2. Bak de kipfilet (gegrild) in een pan rondom gaar; kruid met peper en zout.
3. Stoom of wok wokgroente beetgaar.
4. Roer de tomatensaus erdoor of serveer ernaast.
5. Verdeel over het bord en werk af.','1. Cook the wholewheat noodles (dry) per the package.
2. Pan-fry the grilled chicken breast until done; season with salt and pepper.
3. Steam or stir-fry the stir-fry veg until tender-crisp.
4. Stir in the tomato sauce or serve on the side.
5. Plate up and finish.','pan',null,'core'),
('shrimp_tomato_with_rice','Garnalen-tomaten met rijst','Shrimp tomato with rice',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"shrimp","g":150},{"slug":"rice_dry","g":70},{"slug":"mixed_veg","g":140},{"slug":"tomato_sauce","g":80}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de witte rijst (droog) volgens de verpakking.
2. Bak of pocheer de garnalen kort tot net gaar; kruid met peper en zout.
3. Stoom of wok wokgroente beetgaar.
4. Roer de tomatensaus erdoor of serveer ernaast.
5. Verdeel over het bord en werk af.','1. Cook the white rice (dry) per the package.
2. Sear or poach the shrimp until just done; season with salt and pepper.
3. Steam or stir-fry the stir-fry veg until tender-crisp.
4. Stir in the tomato sauce or serve on the side.
5. Plate up and finish.','pan',null,'core'),
('shrimp_tomato_with_noodles','Garnalen-tomaten met noedels','Shrimp tomato with noodles',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"shrimp","g":150},{"slug":"noodles_dry","g":80},{"slug":"mixed_veg","g":140},{"slug":"tomato_sauce","g":80}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de volkoren noedels (droog) volgens de verpakking.
2. Bak of pocheer de garnalen kort tot net gaar; kruid met peper en zout.
3. Stoom of wok wokgroente beetgaar.
4. Roer de tomatensaus erdoor of serveer ernaast.
5. Verdeel over het bord en werk af.','1. Cook the wholewheat noodles (dry) per the package.
2. Sear or poach the shrimp until just done; season with salt and pepper.
3. Steam or stir-fry the stir-fry veg until tender-crisp.
4. Stir in the tomato sauce or serve on the side.
5. Plate up and finish.','pan',null,'core'),
('tofu_tomato_with_rice','Tofu-tomaten met rijst','Tofu tomato with rice',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"tofu","g":150},{"slug":"rice_dry","g":70},{"slug":"mixed_veg","g":140},{"slug":"tomato_sauce","g":80}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY[]::text[],'1. Kook de witte rijst (droog) volgens de verpakking.
2. Bak de tofu in een pan rondom gaar; kruid met peper en zout.
3. Stoom of wok wokgroente beetgaar.
4. Roer de tomatensaus erdoor of serveer ernaast.
5. Verdeel over het bord en werk af.','1. Cook the white rice (dry) per the package.
2. Pan-fry the tofu until done; season with salt and pepper.
3. Steam or stir-fry the stir-fry veg until tender-crisp.
4. Stir in the tomato sauce or serve on the side.
5. Plate up and finish.','pan',null,'core'),
('tofu_tomato_with_noodles','Tofu-tomaten met noedels','Tofu tomato with noodles',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"tofu","g":150},{"slug":"noodles_dry","g":80},{"slug":"mixed_veg","g":140},{"slug":"tomato_sauce","g":80}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY[]::text[],'1. Kook de volkoren noedels (droog) volgens de verpakking.
2. Bak de tofu in een pan rondom gaar; kruid met peper en zout.
3. Stoom of wok wokgroente beetgaar.
4. Roer de tomatensaus erdoor of serveer ernaast.
5. Verdeel over het bord en werk af.','1. Cook the wholewheat noodles (dry) per the package.
2. Pan-fry the tofu until done; season with salt and pepper.
3. Steam or stir-fry the stir-fry veg until tender-crisp.
4. Stir in the tomato sauce or serve on the side.
5. Plate up and finish.','pan',null,'core'),
('bolognese_pasta_beef','Pasta bolognese (rundergehakt)','Bolognese pasta (beef)',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"pasta_dry","g":80},{"slug":"lean_beef_5","g":120},{"slug":"tomato_sauce","g":120},{"slug":"mushroom","g":60}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['pastabol']::text[],'1. Kook de volkoren pasta (droog) volgens de verpakking.
2. Bak de rundergehakt 5% in een pan rondom gaar; kruid met peper en zout.
3. Stoom of wok champignons beetgaar.
4. Roer de tomatensaus erdoor of serveer ernaast.
5. Verdeel over het bord en werk af.','1. Cook the wholewheat pasta (dry) per the package.
2. Pan-fry the lean beef mince 5% until done; season with salt and pepper.
3. Steam or stir-fry the mushrooms until tender-crisp.
4. Stir in the tomato sauce or serve on the side.
5. Plate up and finish.','pan',null,'core'),
('bolognese_pasta_turkey','Pasta bolognese (kalkoen)','Bolognese pasta (turkey)',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"pasta_dry","g":80},{"slug":"turkey_breast","g":120},{"slug":"tomato_sauce","g":120},{"slug":"mushroom","g":60}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['pastabol']::text[],'1. Kook de volkoren pasta (droog) volgens de verpakking.
2. Bak de kalkoenfilet in een pan rondom gaar; kruid met peper en zout.
3. Stoom of wok champignons beetgaar.
4. Roer de tomatensaus erdoor of serveer ernaast.
5. Verdeel over het bord en werk af.','1. Cook the wholewheat pasta (dry) per the package.
2. Pan-fry the turkey breast until done; season with salt and pepper.
3. Steam or stir-fry the mushrooms until tender-crisp.
4. Stir in the tomato sauce or serve on the side.
5. Plate up and finish.','pan',null,'core'),
('bolognese_pasta_tofu','Pasta bolognese (tofu)','Bolognese pasta (tofu)',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"pasta_dry","g":80},{"slug":"tofu","g":120},{"slug":"tomato_sauce","g":120},{"slug":"mushroom","g":60}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY['pastabol']::text[],'1. Kook de volkoren pasta (droog) volgens de verpakking.
2. Bak de tofu in een pan rondom gaar; kruid met peper en zout.
3. Stoom of wok champignons beetgaar.
4. Roer de tomatensaus erdoor of serveer ernaast.
5. Verdeel over het bord en werk af.','1. Cook the wholewheat pasta (dry) per the package.
2. Pan-fry the tofu until done; season with salt and pepper.
3. Steam or stir-fry the mushrooms until tender-crisp.
4. Stir in the tomato sauce or serve on the side.
5. Plate up and finish.','pan',null,'core'),
('chicken_wrap','Kipfilet-wrap','Chicken wrap',ARRAY['lunch'],ARRAY['cut','maintain'],'[{"slug":"chicken_breast","g":120},{"slug":"wrap_whole","g":60},{"slug":"bell_pepper","g":60},{"slug":"low_yoghurt","g":30}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['chickenwrap']::text[],'1. Warm de wrap kort op.
2. Beleg met kipfilet (gegrild), paprika en magere yoghurt.
3. Rol strak op en snijd doormidden.','1. Warm the wrap briefly.
2. Fill with grilled chicken breast, bell pepper and low-fat yoghurt.
3. Roll up tightly and halve.','assembly',null,'core'),
('chicken_salad','Salade met kipfilet','Chicken salad',ARRAY['lunch'],ARRAY['cut','maintain'],'[{"slug":"chicken_breast","g":120},{"slug":"romaine","g":80},{"slug":"cucumber","g":70},{"slug":"tomato","g":70},{"slug":"olive_oil","g":8}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Meng de sla met romaine sla en komkommer en tomaat.
2. Voeg kipfilet (gegrild) toe.
3. Besprenkel met olijfolie en breng op smaak.','1. Toss the lettuce with the romaine lettuce and cucumber and tomato.
2. Add the grilled chicken breast.
3. Drizzle with olive oil and season.','assembly',null,'core'),
('wholegrain_sandwich_with_chicken','Volkoren brood met kipfilet','Wholegrain sandwich with chicken',ARRAY['lunch'],ARRAY['cut','maintain'],'[{"slug":"chicken_breast","g":120},{"slug":"bread_whole","g":80},{"slug":"cucumber","g":50},{"slug":"low_yoghurt","g":20}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['sandwich']::text[],'1. Rooster of snijd het brood.
2. Beleg met kipfilet (gegrild) en komkommer.
3. Breng op smaak met peper en zout.','1. Toast or slice the bread.
2. Top with grilled chicken breast and cucumber.
3. Season with salt and pepper.','assembly',null,'core'),
('tuna_wrap','Tonijn-wrap','Tuna wrap',ARRAY['lunch'],ARRAY['cut','maintain'],'[{"slug":"tuna_water","g":100},{"slug":"wrap_whole","g":60},{"slug":"bell_pepper","g":60},{"slug":"low_yoghurt","g":30}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Warm de wrap kort op.
2. Beleg met tonijn in water, paprika en magere yoghurt.
3. Rol strak op en snijd doormidden.','1. Warm the wrap briefly.
2. Fill with tuna in water, bell pepper and low-fat yoghurt.
3. Roll up tightly and halve.','assembly',null,'core'),
('tuna_salad','Salade met tonijn','Tuna salad',ARRAY['lunch'],ARRAY['cut','maintain'],'[{"slug":"tuna_water","g":100},{"slug":"romaine","g":80},{"slug":"cucumber","g":70},{"slug":"tomato","g":70},{"slug":"olive_oil","g":8}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['tunasalad']::text[],'1. Meng de sla met romaine sla en komkommer en tomaat.
2. Voeg tonijn in water toe.
3. Besprenkel met olijfolie en breng op smaak.','1. Toss the lettuce with the romaine lettuce and cucumber and tomato.
2. Add the tuna in water.
3. Drizzle with olive oil and season.','assembly',null,'core'),
('wholegrain_sandwich_with_tuna','Volkoren brood met tonijn','Wholegrain sandwich with tuna',ARRAY['lunch'],ARRAY['cut','maintain'],'[{"slug":"tuna_water","g":100},{"slug":"bread_whole","g":80},{"slug":"cucumber","g":50},{"slug":"low_yoghurt","g":20}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['sandwich']::text[],'1. Rooster of snijd het brood.
2. Beleg met tonijn in water en komkommer.
3. Breng op smaak met peper en zout.','1. Toast or slice the bread.
2. Top with tuna in water and cucumber.
3. Season with salt and pepper.','assembly',null,'core'),
('egg_wrap','Ei-wrap','Egg wrap',ARRAY['lunch'],ARRAY['maintain'],'[{"slug":"egg","g":100},{"slug":"wrap_whole","g":60},{"slug":"bell_pepper","g":60},{"slug":"low_yoghurt","g":30}]'::jsonb,ARRAY['vegetarian']::text[],ARRAY[]::text[],'1. Warm de wrap kort op.
2. Beleg met ei, paprika en magere yoghurt.
3. Rol strak op en snijd doormidden.','1. Warm the wrap briefly.
2. Fill with egg, bell pepper and low-fat yoghurt.
3. Roll up tightly and halve.','assembly',null,'core'),
('egg_salad','Salade met ei','Egg salad',ARRAY['lunch'],ARRAY['maintain'],'[{"slug":"egg","g":100},{"slug":"romaine","g":80},{"slug":"cucumber","g":70},{"slug":"tomato","g":70},{"slug":"olive_oil","g":8}]'::jsonb,ARRAY['vegetarian']::text[],ARRAY['saladegg']::text[],'1. Meng de sla met romaine sla en komkommer en tomaat.
2. Voeg ei toe.
3. Besprenkel met olijfolie en breng op smaak.','1. Toss the lettuce with the romaine lettuce and cucumber and tomato.
2. Add the egg.
3. Drizzle with olive oil and season.','assembly',null,'core'),
('wholegrain_sandwich_with_egg','Volkoren brood met ei','Wholegrain sandwich with egg',ARRAY['lunch'],ARRAY['maintain'],'[{"slug":"egg","g":100},{"slug":"bread_whole","g":80},{"slug":"cucumber","g":50},{"slug":"low_yoghurt","g":20}]'::jsonb,ARRAY['vegetarian']::text[],ARRAY['sandwich']::text[],'1. Rooster of snijd het brood.
2. Beleg met ei en komkommer.
3. Breng op smaak met peper en zout.','1. Toast or slice the bread.
2. Top with egg and cucumber.
3. Season with salt and pepper.','assembly',null,'core'),
('feta_wrap','Feta-wrap','Feta wrap',ARRAY['lunch'],ARRAY['maintain'],'[{"slug":"feta","g":40},{"slug":"wrap_whole","g":60},{"slug":"bell_pepper","g":60},{"slug":"low_yoghurt","g":30}]'::jsonb,ARRAY['vegetarian']::text[],ARRAY[]::text[],'1. Warm de wrap kort op.
2. Beleg met vulling, paprika en magere yoghurt.
3. Rol strak op en snijd doormidden.','1. Warm the wrap briefly.
2. Fill with filling, bell pepper and low-fat yoghurt.
3. Roll up tightly and halve.','assembly',null,'core'),
('feta_salad','Salade met feta','Feta salad',ARRAY['lunch'],ARRAY['maintain'],'[{"slug":"feta","g":40},{"slug":"romaine","g":80},{"slug":"cucumber","g":70},{"slug":"tomato","g":70},{"slug":"olive_oil","g":8}]'::jsonb,ARRAY['vegetarian']::text[],ARRAY[]::text[],'1. Meng de sla met romaine sla en komkommer en tomaat.
2. Voeg eiwit toe.
3. Besprenkel met olijfolie en breng op smaak.','1. Toss the lettuce with the romaine lettuce and cucumber and tomato.
2. Add the protein.
3. Drizzle with olive oil and season.','assembly',null,'core'),
('wholegrain_sandwich_with_feta','Volkoren brood met feta','Wholegrain sandwich with feta',ARRAY['lunch'],ARRAY['maintain'],'[{"slug":"feta","g":40},{"slug":"bread_whole","g":80},{"slug":"cucumber","g":50},{"slug":"low_yoghurt","g":20}]'::jsonb,ARRAY['vegetarian']::text[],ARRAY['sandwich']::text[],'1. Rooster of snijd het brood.
2. Beleg met je topping en komkommer.
3. Breng op smaak met peper en zout.','1. Toast or slice the bread.
2. Top with your topping and cucumber.
3. Season with salt and pepper.','assembly',null,'core'),
('shrimp_wrap','Garnalen-wrap','Shrimp wrap',ARRAY['lunch'],ARRAY['cut','maintain'],'[{"slug":"shrimp","g":100},{"slug":"wrap_whole","g":60},{"slug":"bell_pepper","g":60},{"slug":"low_yoghurt","g":30}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Warm de wrap kort op.
2. Beleg met garnalen, paprika en magere yoghurt.
3. Rol strak op en snijd doormidden.','1. Warm the wrap briefly.
2. Fill with shrimp, bell pepper and low-fat yoghurt.
3. Roll up tightly and halve.','assembly',null,'core'),
('shrimp_salad','Salade met garnalen','Shrimp salad',ARRAY['lunch'],ARRAY['cut','maintain'],'[{"slug":"shrimp","g":100},{"slug":"romaine","g":80},{"slug":"cucumber","g":70},{"slug":"tomato","g":70},{"slug":"olive_oil","g":8}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Meng de sla met romaine sla en komkommer en tomaat.
2. Voeg garnalen toe.
3. Besprenkel met olijfolie en breng op smaak.','1. Toss the lettuce with the romaine lettuce and cucumber and tomato.
2. Add the shrimp.
3. Drizzle with olive oil and season.','assembly',null,'core'),
('wholegrain_sandwich_with_shrimp','Volkoren brood met garnalen','Wholegrain sandwich with shrimp',ARRAY['lunch'],ARRAY['cut','maintain'],'[{"slug":"shrimp","g":100},{"slug":"bread_whole","g":80},{"slug":"cucumber","g":50},{"slug":"low_yoghurt","g":20}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['sandwich']::text[],'1. Rooster of snijd het brood.
2. Beleg met garnalen en komkommer.
3. Breng op smaak met peper en zout.','1. Toast or slice the bread.
2. Top with shrimp and cucumber.
3. Season with salt and pepper.','assembly',null,'core'),
('tofu_wrap','Tofu-wrap','Tofu wrap',ARRAY['lunch'],ARRAY['maintain'],'[{"slug":"tofu","g":120},{"slug":"wrap_whole","g":60},{"slug":"bell_pepper","g":60},{"slug":"low_yoghurt","g":30}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY[]::text[],'1. Warm de wrap kort op.
2. Beleg met tofu, paprika en magere yoghurt.
3. Rol strak op en snijd doormidden.','1. Warm the wrap briefly.
2. Fill with tofu, bell pepper and low-fat yoghurt.
3. Roll up tightly and halve.','assembly',null,'core'),
('tofu_salad','Salade met tofu','Tofu salad',ARRAY['lunch'],ARRAY['maintain'],'[{"slug":"tofu","g":120},{"slug":"romaine","g":80},{"slug":"cucumber","g":70},{"slug":"tomato","g":70},{"slug":"olive_oil","g":8}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY[]::text[],'1. Meng de sla met romaine sla en komkommer en tomaat.
2. Voeg tofu toe.
3. Besprenkel met olijfolie en breng op smaak.','1. Toss the lettuce with the romaine lettuce and cucumber and tomato.
2. Add the tofu.
3. Drizzle with olive oil and season.','assembly',null,'core'),
('wholegrain_sandwich_with_tofu','Volkoren brood met tofu','Wholegrain sandwich with tofu',ARRAY['lunch'],ARRAY['maintain'],'[{"slug":"tofu","g":120},{"slug":"bread_whole","g":80},{"slug":"cucumber","g":50},{"slug":"low_yoghurt","g":20}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY['sandwich']::text[],'1. Rooster of snijd het brood.
2. Beleg met tofu en komkommer.
3. Breng op smaak met peper en zout.','1. Toast or slice the bread.
2. Top with tofu and cucumber.
3. Season with salt and pepper.','assembly',null,'core'),
('skyr_with_oats_blueberries','Skyr met havermout & blauwe bessen','Skyr with oats & blueberries',ARRAY['breakfast','snack'],ARRAY['cut','maintain'],'[{"slug":"skyr","g":200},{"slug":"oats","g":50},{"slug":"blueberries","g":60}]'::jsonb,ARRAY['vegetarian','high_protein']::text[],ARRAY['gyoghurt','quarkfruit']::text[],'1. Doe de skyr in een kom.
2. Roer de havermout erdoor.
3. Top met blauwe bessen.','1. Spoon the skyr into a bowl.
2. Stir in the oats.
3. Top with blueberries.','assembly',null,'core'),
('skyr_with_oats_strawberries','Skyr met havermout & aardbeien','Skyr with oats & strawberries',ARRAY['breakfast','snack'],ARRAY['cut','maintain'],'[{"slug":"skyr","g":200},{"slug":"oats","g":50},{"slug":"strawberries","g":60}]'::jsonb,ARRAY['vegetarian','high_protein']::text[],ARRAY['gyoghurt','quarkfruit']::text[],'1. Doe de skyr in een kom.
2. Roer de havermout erdoor.
3. Top met aardbeien.','1. Spoon the skyr into a bowl.
2. Stir in the oats.
3. Top with strawberries.','assembly',null,'core'),
('skyr_with_oats_banana','Skyr met havermout & banaan','Skyr with oats & banana',ARRAY['breakfast','snack'],ARRAY['cut','maintain'],'[{"slug":"skyr","g":200},{"slug":"oats","g":50},{"slug":"banana","g":60}]'::jsonb,ARRAY['vegetarian']::text[],ARRAY['gyoghurt','quarkfruit']::text[],'1. Doe de skyr in een kom.
2. Roer de havermout erdoor.
3. Top met banaan.','1. Spoon the skyr into a bowl.
2. Stir in the oats.
3. Top with banana.','assembly',null,'core'),
('skyr_with_oats_mango','Skyr met havermout & mango','Skyr with oats & mango',ARRAY['breakfast','snack'],ARRAY['cut','maintain'],'[{"slug":"skyr","g":200},{"slug":"oats","g":50},{"slug":"mango","g":60}]'::jsonb,ARRAY['vegetarian','high_protein']::text[],ARRAY['gyoghurt','quarkfruit']::text[],'1. Doe de skyr in een kom.
2. Roer de havermout erdoor.
3. Top met mango.','1. Spoon the skyr into a bowl.
2. Stir in the oats.
3. Top with mango.','assembly',null,'core'),
('skyr_with_oats_apple','Skyr met havermout & appel','Skyr with oats & apple',ARRAY['breakfast','snack'],ARRAY['cut','maintain'],'[{"slug":"skyr","g":200},{"slug":"oats","g":50},{"slug":"apple","g":60}]'::jsonb,ARRAY['vegetarian','high_protein']::text[],ARRAY['gyoghurt','quarkfruit']::text[],'1. Doe de skyr in een kom.
2. Roer de havermout erdoor.
3. Top met appel.','1. Spoon the skyr into a bowl.
2. Stir in the oats.
3. Top with apple.','assembly',null,'core'),
('quark_with_oats_blueberries','Kwark met havermout & blauwe bessen','Quark with oats & blueberries',ARRAY['breakfast','snack'],ARRAY['cut','maintain'],'[{"slug":"quark_low","g":200},{"slug":"oats","g":50},{"slug":"blueberries","g":60}]'::jsonb,ARRAY['vegetarian']::text[],ARRAY['gyoghurt','quarkfruit']::text[],'1. Doe de magere kwark in een kom.
2. Roer de havermout erdoor.
3. Top met blauwe bessen.','1. Spoon the low-fat quark into a bowl.
2. Stir in the oats.
3. Top with blueberries.','assembly',null,'core'),
('quark_with_oats_strawberries','Kwark met havermout & aardbeien','Quark with oats & strawberries',ARRAY['breakfast','snack'],ARRAY['cut','maintain'],'[{"slug":"quark_low","g":200},{"slug":"oats","g":50},{"slug":"strawberries","g":60}]'::jsonb,ARRAY['vegetarian','high_protein']::text[],ARRAY['gyoghurt','quarkfruit']::text[],'1. Doe de magere kwark in een kom.
2. Roer de havermout erdoor.
3. Top met aardbeien.','1. Spoon the low-fat quark into a bowl.
2. Stir in the oats.
3. Top with strawberries.','assembly',null,'core'),
('quark_with_oats_banana','Kwark met havermout & banaan','Quark with oats & banana',ARRAY['breakfast','snack'],ARRAY['cut','maintain'],'[{"slug":"quark_low","g":200},{"slug":"oats","g":50},{"slug":"banana","g":60}]'::jsonb,ARRAY['vegetarian']::text[],ARRAY['gyoghurt','quarkfruit']::text[],'1. Doe de magere kwark in een kom.
2. Roer de havermout erdoor.
3. Top met banaan.','1. Spoon the low-fat quark into a bowl.
2. Stir in the oats.
3. Top with banana.','assembly',null,'core'),
('quark_with_oats_mango','Kwark met havermout & mango','Quark with oats & mango',ARRAY['breakfast','snack'],ARRAY['cut','maintain'],'[{"slug":"quark_low","g":200},{"slug":"oats","g":50},{"slug":"mango","g":60}]'::jsonb,ARRAY['vegetarian']::text[],ARRAY['gyoghurt','quarkfruit']::text[],'1. Doe de magere kwark in een kom.
2. Roer de havermout erdoor.
3. Top met mango.','1. Spoon the low-fat quark into a bowl.
2. Stir in the oats.
3. Top with mango.','assembly',null,'core'),
('quark_with_oats_apple','Kwark met havermout & appel','Quark with oats & apple',ARRAY['breakfast','snack'],ARRAY['cut','maintain'],'[{"slug":"quark_low","g":200},{"slug":"oats","g":50},{"slug":"apple","g":60}]'::jsonb,ARRAY['vegetarian','high_protein']::text[],ARRAY['gyoghurt','quarkfruit']::text[],'1. Doe de magere kwark in een kom.
2. Roer de havermout erdoor.
3. Top met appel.','1. Spoon the low-fat quark into a bowl.
2. Stir in the oats.
3. Top with apple.','assembly',null,'core'),
('greek_yoghurt_with_oats_blueberries','Griekse yoghurt met havermout & blauwe bessen','Greek yoghurt with oats & blueberries',ARRAY['breakfast','snack'],ARRAY['maintain'],'[{"slug":"greek_yoghurt","g":200},{"slug":"oats","g":50},{"slug":"blueberries","g":60}]'::jsonb,ARRAY['vegetarian']::text[],ARRAY['gyoghurt','quarkfruit']::text[],'1. Doe de griekse yoghurt 2% in een kom.
2. Roer de havermout erdoor.
3. Top met blauwe bessen.','1. Spoon the greek yoghurt 2% into a bowl.
2. Stir in the oats.
3. Top with blueberries.','assembly',null,'core'),
('greek_yoghurt_with_oats_strawberries','Griekse yoghurt met havermout & aardbeien','Greek yoghurt with oats & strawberries',ARRAY['breakfast','snack'],ARRAY['maintain'],'[{"slug":"greek_yoghurt","g":200},{"slug":"oats","g":50},{"slug":"strawberries","g":60}]'::jsonb,ARRAY['vegetarian']::text[],ARRAY['gyoghurt','quarkfruit']::text[],'1. Doe de griekse yoghurt 2% in een kom.
2. Roer de havermout erdoor.
3. Top met aardbeien.','1. Spoon the greek yoghurt 2% into a bowl.
2. Stir in the oats.
3. Top with strawberries.','assembly',null,'core'),
('greek_yoghurt_with_oats_banana','Griekse yoghurt met havermout & banaan','Greek yoghurt with oats & banana',ARRAY['breakfast','snack'],ARRAY['maintain'],'[{"slug":"greek_yoghurt","g":200},{"slug":"oats","g":50},{"slug":"banana","g":60}]'::jsonb,ARRAY['vegetarian']::text[],ARRAY['gyoghurt','quarkfruit']::text[],'1. Doe de griekse yoghurt 2% in een kom.
2. Roer de havermout erdoor.
3. Top met banaan.','1. Spoon the greek yoghurt 2% into a bowl.
2. Stir in the oats.
3. Top with banana.','assembly',null,'core'),
('greek_yoghurt_with_oats_mango','Griekse yoghurt met havermout & mango','Greek yoghurt with oats & mango',ARRAY['breakfast','snack'],ARRAY['maintain'],'[{"slug":"greek_yoghurt","g":200},{"slug":"oats","g":50},{"slug":"mango","g":60}]'::jsonb,ARRAY['vegetarian']::text[],ARRAY['gyoghurt','quarkfruit']::text[],'1. Doe de griekse yoghurt 2% in een kom.
2. Roer de havermout erdoor.
3. Top met mango.','1. Spoon the greek yoghurt 2% into a bowl.
2. Stir in the oats.
3. Top with mango.','assembly',null,'core'),
('greek_yoghurt_with_oats_apple','Griekse yoghurt met havermout & appel','Greek yoghurt with oats & apple',ARRAY['breakfast','snack'],ARRAY['maintain'],'[{"slug":"greek_yoghurt","g":200},{"slug":"oats","g":50},{"slug":"apple","g":60}]'::jsonb,ARRAY['vegetarian']::text[],ARRAY['gyoghurt','quarkfruit']::text[],'1. Doe de griekse yoghurt 2% in een kom.
2. Roer de havermout erdoor.
3. Top met appel.','1. Spoon the greek yoghurt 2% into a bowl.
2. Stir in the oats.
3. Top with apple.','assembly',null,'core'),
('oats_with_blueberries_whey','Havermout met blauwe bessen & whey','Oats with blueberries & whey',ARRAY['breakfast'],ARRAY['cut','maintain'],'[{"slug":"oats","g":60},{"slug":"skim_milk","g":200},{"slug":"whey","g":25},{"slug":"blueberries","g":60}]'::jsonb,ARRAY['vegetarian','high_protein']::text[],ARRAY['oats']::text[],'1. Kook de havermout volgens de verpakking.
2. Verdeel over het bord en werk af.','1. Cook the oats per the package.
2. Plate up and finish.','pan',null,'core'),
('oats_with_strawberries_whey','Havermout met aardbeien & whey','Oats with strawberries & whey',ARRAY['breakfast'],ARRAY['cut','maintain'],'[{"slug":"oats","g":60},{"slug":"skim_milk","g":200},{"slug":"whey","g":25},{"slug":"strawberries","g":60}]'::jsonb,ARRAY['vegetarian','high_protein']::text[],ARRAY['oats']::text[],'1. Kook de havermout volgens de verpakking.
2. Verdeel over het bord en werk af.','1. Cook the oats per the package.
2. Plate up and finish.','pan',null,'core'),
('oats_with_banana_whey','Havermout met banaan & whey','Oats with banana & whey',ARRAY['breakfast'],ARRAY['cut','maintain'],'[{"slug":"oats","g":60},{"slug":"skim_milk","g":200},{"slug":"whey","g":25},{"slug":"banana","g":60}]'::jsonb,ARRAY['vegetarian']::text[],ARRAY['oats']::text[],'1. Kook de havermout volgens de verpakking.
2. Verdeel over het bord en werk af.','1. Cook the oats per the package.
2. Plate up and finish.','pan',null,'core'),
('oats_with_mango_whey','Havermout met mango & whey','Oats with mango & whey',ARRAY['breakfast'],ARRAY['cut','maintain'],'[{"slug":"oats","g":60},{"slug":"skim_milk","g":200},{"slug":"whey","g":25},{"slug":"mango","g":60}]'::jsonb,ARRAY['vegetarian','high_protein']::text[],ARRAY['oats']::text[],'1. Kook de havermout volgens de verpakking.
2. Verdeel over het bord en werk af.','1. Cook the oats per the package.
2. Plate up and finish.','pan',null,'core'),
('oats_with_apple_whey','Havermout met appel & whey','Oats with apple & whey',ARRAY['breakfast'],ARRAY['cut','maintain'],'[{"slug":"oats","g":60},{"slug":"skim_milk","g":200},{"slug":"whey","g":25},{"slug":"apple","g":60}]'::jsonb,ARRAY['vegetarian','high_protein']::text[],ARRAY['oats']::text[],'1. Kook de havermout volgens de verpakking.
2. Verdeel over het bord en werk af.','1. Cook the oats per the package.
2. Plate up and finish.','pan',null,'core'),
('protein_pancake_with_banana','Proteïne-pannenkoek met banaan','Protein pancake with banana',ARRAY['breakfast'],ARRAY['cut','maintain'],'[{"slug":"oats","g":60},{"slug":"egg","g":50},{"slug":"whey","g":30},{"slug":"banana","g":60}]'::jsonb,ARRAY['vegetarian','high_protein']::text[],ARRAY['protpancake']::text[],'1. Blend de havermout, het ei en de whey tot een glad beslag.
2. Bak er kleine pannenkoeken van in een licht ingevette pan.
3. Top met banaan.','1. Blend the oats, egg and whey into a smooth batter.
2. Cook small pancakes in a lightly greased pan.
3. Top with banana.','pan',null,'core'),
('protein_pancake_with_blueberries','Proteïne-pannenkoek met blauwe bessen','Protein pancake with blueberries',ARRAY['breakfast'],ARRAY['cut','maintain'],'[{"slug":"oats","g":60},{"slug":"egg","g":50},{"slug":"whey","g":30},{"slug":"blueberries","g":60}]'::jsonb,ARRAY['vegetarian','high_protein']::text[],ARRAY['protpancake']::text[],'1. Blend de havermout, het ei en de whey tot een glad beslag.
2. Bak er kleine pannenkoeken van in een licht ingevette pan.
3. Top met blauwe bessen.','1. Blend the oats, egg and whey into a smooth batter.
2. Cook small pancakes in a lightly greased pan.
3. Top with blueberries.','pan',null,'core'),
('omelette_with_spinach_feta','Omelet met spinazie & feta','Omelette with spinach & feta',ARRAY['breakfast'],ARRAY['maintain'],'[{"slug":"egg","g":150},{"slug":"spinach","g":60},{"slug":"feta","g":30},{"slug":"olive_oil","g":5}]'::jsonb,ARRAY['vegetarian']::text[],ARRAY['omelet','eggs']::text[],'1. Klop de eieren los met peper en zout.
2. Bak spinazie kort in de pan, giet de eieren erover en laat stollen.
3. Verkruimel de feta erover.','1. Whisk the eggs with salt and pepper.
2. Sauté the spinach briefly, pour in the eggs and let set.
3. Crumble the feta on top.','pan',null,'core'),
('scrambled_eggs_with_spinach','Roerei met spinazie','Scrambled eggs with spinach',ARRAY['breakfast'],ARRAY['cut','maintain'],'[{"slug":"egg","g":150},{"slug":"spinach","g":70},{"slug":"bread_whole","g":40}]'::jsonb,ARRAY['vegetarian']::text[],ARRAY['eggs']::text[],'1. Klop de eieren los.
2. Roerbak ze met spinazie tot ze net gestold zijn.
3. Serveer met volkoren brood.','1. Whisk the eggs.
2. Scramble with the spinach until just set.
3. Serve with the wholegrain bread.','pan',null,'core'),
('omelette_with_mushrooms_feta','Omelet met champignons & feta','Omelette with mushrooms & feta',ARRAY['breakfast'],ARRAY['maintain'],'[{"slug":"egg","g":150},{"slug":"mushroom","g":60},{"slug":"feta","g":30},{"slug":"olive_oil","g":5}]'::jsonb,ARRAY['vegetarian']::text[],ARRAY['omelet','eggs']::text[],'1. Klop de eieren los met peper en zout.
2. Bak champignons kort in de pan, giet de eieren erover en laat stollen.
3. Verkruimel de feta erover.','1. Whisk the eggs with salt and pepper.
2. Sauté the mushrooms briefly, pour in the eggs and let set.
3. Crumble the feta on top.','pan',null,'core'),
('scrambled_eggs_with_mushrooms','Roerei met champignons','Scrambled eggs with mushrooms',ARRAY['breakfast'],ARRAY['cut','maintain'],'[{"slug":"egg","g":150},{"slug":"mushroom","g":70},{"slug":"bread_whole","g":40}]'::jsonb,ARRAY['vegetarian']::text[],ARRAY['eggs']::text[],'1. Klop de eieren los.
2. Roerbak ze met champignons tot ze net gestold zijn.
3. Serveer met volkoren brood.','1. Whisk the eggs.
2. Scramble with the mushrooms until just set.
3. Serve with the wholegrain bread.','pan',null,'core'),
('omelette_with_bell_pepper_feta','Omelet met paprika & feta','Omelette with bell pepper & feta',ARRAY['breakfast'],ARRAY['maintain'],'[{"slug":"egg","g":150},{"slug":"bell_pepper","g":60},{"slug":"feta","g":30},{"slug":"olive_oil","g":5}]'::jsonb,ARRAY['vegetarian']::text[],ARRAY['omelet','eggs']::text[],'1. Klop de eieren los met peper en zout.
2. Bak paprika kort in de pan, giet de eieren erover en laat stollen.
3. Verkruimel de feta erover.','1. Whisk the eggs with salt and pepper.
2. Sauté the bell pepper briefly, pour in the eggs and let set.
3. Crumble the feta on top.','pan',null,'core'),
('scrambled_eggs_with_bell_pepper','Roerei met paprika','Scrambled eggs with bell pepper',ARRAY['breakfast'],ARRAY['maintain'],'[{"slug":"egg","g":150},{"slug":"bell_pepper","g":70},{"slug":"bread_whole","g":40}]'::jsonb,ARRAY['vegetarian']::text[],ARRAY['eggs']::text[],'1. Klop de eieren los.
2. Roerbak ze met paprika tot ze net gestold zijn.
3. Serveer met volkoren brood.','1. Whisk the eggs.
2. Scramble with the bell pepper until just set.
3. Serve with the wholegrain bread.','pan',null,'core'),
('omelette_with_tomato_feta','Omelet met tomaat & feta','Omelette with tomato & feta',ARRAY['breakfast'],ARRAY['maintain'],'[{"slug":"egg","g":150},{"slug":"tomato","g":60},{"slug":"feta","g":30},{"slug":"olive_oil","g":5}]'::jsonb,ARRAY['vegetarian']::text[],ARRAY['omelet','eggs']::text[],'1. Klop de eieren los met peper en zout.
2. Bak tomaat kort in de pan, giet de eieren erover en laat stollen.
3. Verkruimel de feta erover.','1. Whisk the eggs with salt and pepper.
2. Sauté the tomato briefly, pour in the eggs and let set.
3. Crumble the feta on top.','pan',null,'core'),
('scrambled_eggs_with_tomato','Roerei met tomaat','Scrambled eggs with tomato',ARRAY['breakfast'],ARRAY['maintain'],'[{"slug":"egg","g":150},{"slug":"tomato","g":70},{"slug":"bread_whole","g":40}]'::jsonb,ARRAY['vegetarian']::text[],ARRAY['eggs']::text[],'1. Klop de eieren los.
2. Roerbak ze met tomaat tot ze net gestold zijn.
3. Serveer met volkoren brood.','1. Whisk the eggs.
2. Scramble with the tomato until just set.
3. Serve with the wholegrain bread.','pan',null,'core'),
('wholegrain_bread_with_cottage_cheese','Volkoren brood met hüttenkäse','Wholegrain bread with cottage cheese',ARRAY['breakfast'],ARRAY['maintain'],'[{"slug":"bread_whole","g":80},{"slug":"cottage","g":100},{"slug":"tomato","g":50}]'::jsonb,ARRAY['vegetarian']::text[],ARRAY['wholebread']::text[],'1. Rooster of snijd het brood.
2. Beleg met je topping en tomaat.
3. Breng op smaak met peper en zout.','1. Toast or slice the bread.
2. Top with your topping and tomato.
3. Season with salt and pepper.','assembly',null,'core'),
('protein_shake_with_banana','Eiwitshake met banaan','Protein shake with banana',ARRAY['snack'],ARRAY['cut','maintain'],'[{"slug":"whey","g":30},{"slug":"banana","g":80},{"slug":"skim_milk","g":200}]'::jsonb,ARRAY['vegetarian','high_protein']::text[],ARRAY['shake']::text[],'1. Doe alle ingrediënten in de blender.
2. Mix glad en schenk in een glas.','1. Add everything to the blender.
2. Blend smooth and pour into a glass.','blender',null,'core'),
('protein_shake_with_strawberry','Eiwitshake met aardbei','Protein shake with strawberry',ARRAY['snack'],ARRAY['cut','maintain'],'[{"slug":"whey","g":30},{"slug":"strawberries","g":100},{"slug":"skim_milk","g":200}]'::jsonb,ARRAY['vegetarian','high_protein']::text[],ARRAY['shake']::text[],'1. Doe alle ingrediënten in de blender.
2. Mix glad en schenk in een glas.','1. Add everything to the blender.
2. Blend smooth and pour into a glass.','blender',null,'core'),
('quark_with_blueberries','Kwark met blauwe bessen','Quark with blueberries',ARRAY['snack'],ARRAY['cut','maintain'],'[{"slug":"quark_low","g":150},{"slug":"blueberries","g":60}]'::jsonb,ARRAY['vegetarian','high_protein']::text[],ARRAY['quark']::text[],'1. Doe de magere kwark in een kom.
2. Meng of top met blauwe bessen.','1. Spoon the low-fat quark into a bowl.
2. Mix or top with blueberries.','assembly',null,'core'),
('quark_with_strawberries','Kwark met aardbeien','Quark with strawberries',ARRAY['snack'],ARRAY['cut','maintain'],'[{"slug":"quark_low","g":150},{"slug":"strawberries","g":60}]'::jsonb,ARRAY['vegetarian','high_protein']::text[],ARRAY['quark']::text[],'1. Doe de magere kwark in een kom.
2. Meng of top met aardbeien.','1. Spoon the low-fat quark into a bowl.
2. Mix or top with strawberries.','assembly',null,'core'),
('quark_with_banana','Kwark met banaan','Quark with banana',ARRAY['snack'],ARRAY['cut','maintain'],'[{"slug":"quark_low","g":150},{"slug":"banana","g":60}]'::jsonb,ARRAY['vegetarian','high_protein']::text[],ARRAY['quark']::text[],'1. Doe de magere kwark in een kom.
2. Meng of top met banaan.','1. Spoon the low-fat quark into a bowl.
2. Mix or top with banana.','assembly',null,'core'),
('quark_with_mango','Kwark met mango','Quark with mango',ARRAY['snack'],ARRAY['cut','maintain'],'[{"slug":"quark_low","g":150},{"slug":"mango","g":60}]'::jsonb,ARRAY['vegetarian','high_protein']::text[],ARRAY['quark']::text[],'1. Doe de magere kwark in een kom.
2. Meng of top met mango.','1. Spoon the low-fat quark into a bowl.
2. Mix or top with mango.','assembly',null,'core'),
('quark_with_apple','Kwark met appel','Quark with apple',ARRAY['snack'],ARRAY['cut','maintain'],'[{"slug":"quark_low","g":150},{"slug":"apple","g":60}]'::jsonb,ARRAY['vegetarian','high_protein']::text[],ARRAY['quark']::text[],'1. Doe de magere kwark in een kom.
2. Meng of top met appel.','1. Spoon the low-fat quark into a bowl.
2. Mix or top with apple.','assembly',null,'core'),
('skyr_with_honey','Skyr met honing','Skyr with honey',ARRAY['snack'],ARRAY['cut','maintain'],'[{"slug":"skyr","g":150},{"slug":"honey","g":15}]'::jsonb,ARRAY['vegetarian','high_protein']::text[],ARRAY['quark']::text[],'1. Roer de honing erdoor of serveer ernaast.
2. Verdeel over het bord en werk af.','1. Stir in the honey or serve on the side.
2. Plate up and finish.','pan',null,'core'),
('handful_of_almonds','Handje amandelen','Handful of almonds',ARRAY['snack'],ARRAY['maintain'],'[{"slug":"almonds","g":30}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY['nuts']::text[],'1. Weeg de portie af.
2. Serveer als snack tussendoor.','1. Weigh out the portion.
2. Enjoy as a snack.','assembly',null,'core'),
('handful_of_walnuts','Handje walnoten','Handful of walnuts',ARRAY['snack'],ARRAY['maintain'],'[{"slug":"walnuts","g":30}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY['nuts']::text[],'1. Weeg de portie af.
2. Serveer als snack tussendoor.','1. Weigh out the portion.
2. Enjoy as a snack.','assembly',null,'core'),
('rice_cakes_with_peanut_butter','Rijstwafels met pindakaas','Rice cakes with peanut butter',ARRAY['snack'],ARRAY['maintain'],'[{"slug":"rice_cakes","g":20},{"slug":"peanut_butter","g":20}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY['ricecakepb']::text[],'1. Beleg de rijstwafels met pindakaas.','1. Top the rice cakes with peanut butter.','assembly',null,'core'),
('rice_cakes_with_hummus','Rijstwafels met hummus','Rice cakes with hummus',ARRAY['snack'],ARRAY['maintain'],'[{"slug":"rice_cakes","g":20},{"slug":"hummus","g":40}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY['ricecakepb']::text[],'1. Beleg de rijstwafels met hummus.','1. Top the rice cakes with hummus.','assembly',null,'core'),
('apple_with_peanut_butter','Appel met pindakaas','Apple with peanut butter',ARRAY['snack'],ARRAY['maintain'],'[{"slug":"apple","g":150},{"slug":"peanut_butter","g":20}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY['fruit']::text[],'1. Snijd appel in partjes.
2. Serveer met pindakaas om in te dippen.','1. Slice the apple.
2. Serve with peanut butter to dip.','assembly',null,'core'),
('cottage_cheese_with_cucumber','Hüttenkäse met komkommer','Cottage cheese with cucumber',ARRAY['snack'],ARRAY['cut','maintain'],'[{"slug":"cottage","g":150},{"slug":"cucumber","g":80}]'::jsonb,ARRAY['vegetarian','high_protein']::text[],ARRAY['quark']::text[],'1. Doe de hüttenkäse in een kom.
2. Serveer met komkommer.','1. Spoon the cottage cheese into a bowl.
2. Serve with cucumber.','assembly',null,'core'),
('poke_bowl_with_salmon_cucumber','Poké bowl met zalm & komkommer','Poké bowl with salmon & cucumber',ARRAY['lunch','dinner'],ARRAY['maintain'],'[{"slug":"salmon","g":120},{"slug":"rice_dry","g":65},{"slug":"cucumber","g":80},{"slug":"edamame","g":50},{"slug":"teriyaki","g":20}]'::jsonb,ARRAY[]::text[],ARRAY['poke']::text[],'1. Kook de witte rijst (droog) en laat afkoelen.
2. Verdeel alles in een kom: zalmfilet, komkommer.
3. Werk af met teriyakisaus.','1. Cook the white rice (dry) and let it cool.
2. Arrange in a bowl: salmon fillet, cucumber.
3. Finish with teriyaki sauce.','assembly',null,'core'),
('poke_bowl_with_salmon_carrot','Poké bowl met zalm & wortel','Poké bowl with salmon & carrot',ARRAY['lunch','dinner'],ARRAY['maintain'],'[{"slug":"salmon","g":120},{"slug":"rice_dry","g":65},{"slug":"carrot","g":80},{"slug":"edamame","g":50},{"slug":"teriyaki","g":20}]'::jsonb,ARRAY[]::text[],ARRAY['poke']::text[],'1. Kook de witte rijst (droog) en laat afkoelen.
2. Verdeel alles in een kom: zalmfilet, wortel.
3. Werk af met teriyakisaus.','1. Cook the white rice (dry) and let it cool.
2. Arrange in a bowl: salmon fillet, carrot.
3. Finish with teriyaki sauce.','assembly',null,'core'),
('poke_bowl_with_salmon_edamame','Poké bowl met zalm & edamame','Poké bowl with salmon & edamame',ARRAY['lunch','dinner'],ARRAY['gain','maintain'],'[{"slug":"salmon","g":120},{"slug":"rice_dry","g":65},{"slug":"edamame","g":80},{"slug":"edamame","g":50},{"slug":"teriyaki","g":20}]'::jsonb,ARRAY[]::text[],ARRAY['poke']::text[],'1. Kook de witte rijst (droog) en laat afkoelen.
2. Verdeel alles in een kom: zalmfilet, wat groente.
3. Werk af met teriyakisaus.','1. Cook the white rice (dry) and let it cool.
2. Arrange in a bowl: salmon fillet, some veg.
3. Finish with teriyaki sauce.','assembly',null,'core'),
('poke_bowl_with_tuna_cucumber','Poké bowl met tonijn & komkommer','Poké bowl with tuna & cucumber',ARRAY['lunch','dinner'],ARRAY['cut','maintain'],'[{"slug":"tuna_water","g":100},{"slug":"rice_dry","g":65},{"slug":"cucumber","g":80},{"slug":"edamame","g":50},{"slug":"teriyaki","g":20}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['poke']::text[],'1. Kook de witte rijst (droog) en laat afkoelen.
2. Verdeel alles in een kom: tonijn in water, komkommer.
3. Werk af met teriyakisaus.','1. Cook the white rice (dry) and let it cool.
2. Arrange in a bowl: tuna in water, cucumber.
3. Finish with teriyaki sauce.','assembly',null,'core'),
('poke_bowl_with_tuna_carrot','Poké bowl met tonijn & wortel','Poké bowl with tuna & carrot',ARRAY['lunch','dinner'],ARRAY['cut','maintain'],'[{"slug":"tuna_water","g":100},{"slug":"rice_dry","g":65},{"slug":"carrot","g":80},{"slug":"edamame","g":50},{"slug":"teriyaki","g":20}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['poke']::text[],'1. Kook de witte rijst (droog) en laat afkoelen.
2. Verdeel alles in een kom: tonijn in water, wortel.
3. Werk af met teriyakisaus.','1. Cook the white rice (dry) and let it cool.
2. Arrange in a bowl: tuna in water, carrot.
3. Finish with teriyaki sauce.','assembly',null,'core'),
('poke_bowl_with_tuna_edamame','Poké bowl met tonijn & edamame','Poké bowl with tuna & edamame',ARRAY['lunch','dinner'],ARRAY['cut','maintain'],'[{"slug":"tuna_water","g":100},{"slug":"rice_dry","g":65},{"slug":"edamame","g":80},{"slug":"edamame","g":50},{"slug":"teriyaki","g":20}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['poke']::text[],'1. Kook de witte rijst (droog) en laat afkoelen.
2. Verdeel alles in een kom: tonijn in water, wat groente.
3. Werk af met teriyakisaus.','1. Cook the white rice (dry) and let it cool.
2. Arrange in a bowl: tuna in water, some veg.
3. Finish with teriyaki sauce.','assembly',null,'core'),
('poke_bowl_with_chicken_cucumber','Poké bowl met kip & komkommer','Poké bowl with chicken & cucumber',ARRAY['lunch','dinner'],ARRAY['cut','maintain'],'[{"slug":"chicken_breast","g":120},{"slug":"rice_dry","g":65},{"slug":"cucumber","g":80},{"slug":"edamame","g":50},{"slug":"teriyaki","g":20}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['poke']::text[],'1. Kook de witte rijst (droog) en laat afkoelen.
2. Verdeel alles in een kom: kipfilet (gegrild), komkommer.
3. Werk af met teriyakisaus.','1. Cook the white rice (dry) and let it cool.
2. Arrange in a bowl: grilled chicken breast, cucumber.
3. Finish with teriyaki sauce.','assembly',null,'core'),
('poke_bowl_with_chicken_carrot','Poké bowl met kip & wortel','Poké bowl with chicken & carrot',ARRAY['lunch','dinner'],ARRAY['cut','maintain'],'[{"slug":"chicken_breast","g":120},{"slug":"rice_dry","g":65},{"slug":"carrot","g":80},{"slug":"edamame","g":50},{"slug":"teriyaki","g":20}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['poke']::text[],'1. Kook de witte rijst (droog) en laat afkoelen.
2. Verdeel alles in een kom: kipfilet (gegrild), wortel.
3. Werk af met teriyakisaus.','1. Cook the white rice (dry) and let it cool.
2. Arrange in a bowl: grilled chicken breast, carrot.
3. Finish with teriyaki sauce.','assembly',null,'core'),
('poke_bowl_with_chicken_edamame','Poké bowl met kip & edamame','Poké bowl with chicken & edamame',ARRAY['lunch','dinner'],ARRAY['cut','gain','maintain'],'[{"slug":"chicken_breast","g":120},{"slug":"rice_dry","g":65},{"slug":"edamame","g":80},{"slug":"edamame","g":50},{"slug":"teriyaki","g":20}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['poke']::text[],'1. Kook de witte rijst (droog) en laat afkoelen.
2. Verdeel alles in een kom: kipfilet (gegrild), wat groente.
3. Werk af met teriyakisaus.','1. Cook the white rice (dry) and let it cool.
2. Arrange in a bowl: grilled chicken breast, some veg.
3. Finish with teriyaki sauce.','assembly',null,'core'),
('poke_bowl_with_tofu_cucumber','Poké bowl met tofu & komkommer','Poké bowl with tofu & cucumber',ARRAY['lunch','dinner'],ARRAY['maintain'],'[{"slug":"tofu","g":120},{"slug":"rice_dry","g":65},{"slug":"cucumber","g":80},{"slug":"edamame","g":50},{"slug":"teriyaki","g":20}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY['poke']::text[],'1. Kook de witte rijst (droog) en laat afkoelen.
2. Verdeel alles in een kom: tofu, komkommer.
3. Werk af met teriyakisaus.','1. Cook the white rice (dry) and let it cool.
2. Arrange in a bowl: tofu, cucumber.
3. Finish with teriyaki sauce.','assembly',null,'core'),
('poke_bowl_with_tofu_carrot','Poké bowl met tofu & wortel','Poké bowl with tofu & carrot',ARRAY['lunch','dinner'],ARRAY['maintain'],'[{"slug":"tofu","g":120},{"slug":"rice_dry","g":65},{"slug":"carrot","g":80},{"slug":"edamame","g":50},{"slug":"teriyaki","g":20}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY['poke']::text[],'1. Kook de witte rijst (droog) en laat afkoelen.
2. Verdeel alles in een kom: tofu, wortel.
3. Werk af met teriyakisaus.','1. Cook the white rice (dry) and let it cool.
2. Arrange in a bowl: tofu, carrot.
3. Finish with teriyaki sauce.','assembly',null,'core'),
('poke_bowl_with_tofu_edamame','Poké bowl met tofu & edamame','Poké bowl with tofu & edamame',ARRAY['lunch','dinner'],ARRAY['maintain'],'[{"slug":"tofu","g":120},{"slug":"rice_dry","g":65},{"slug":"edamame","g":80},{"slug":"edamame","g":50},{"slug":"teriyaki","g":20}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY['poke']::text[],'1. Kook de witte rijst (droog) en laat afkoelen.
2. Verdeel alles in een kom: tofu, wat groente.
3. Werk af met teriyakisaus.','1. Cook the white rice (dry) and let it cool.
2. Arrange in a bowl: tofu, some veg.
3. Finish with teriyaki sauce.','assembly',null,'core'),
('poke_bowl_with_shrimp_cucumber','Poké bowl met garnalen & komkommer','Poké bowl with shrimp & cucumber',ARRAY['lunch','dinner'],ARRAY['cut','maintain'],'[{"slug":"shrimp","g":110},{"slug":"rice_dry","g":65},{"slug":"cucumber","g":80},{"slug":"edamame","g":50},{"slug":"teriyaki","g":20}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['poke']::text[],'1. Kook de witte rijst (droog) en laat afkoelen.
2. Verdeel alles in een kom: garnalen, komkommer.
3. Werk af met teriyakisaus.','1. Cook the white rice (dry) and let it cool.
2. Arrange in a bowl: shrimp, cucumber.
3. Finish with teriyaki sauce.','assembly',null,'core'),
('poke_bowl_with_shrimp_carrot','Poké bowl met garnalen & wortel','Poké bowl with shrimp & carrot',ARRAY['lunch','dinner'],ARRAY['cut','maintain'],'[{"slug":"shrimp","g":110},{"slug":"rice_dry","g":65},{"slug":"carrot","g":80},{"slug":"edamame","g":50},{"slug":"teriyaki","g":20}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['poke']::text[],'1. Kook de witte rijst (droog) en laat afkoelen.
2. Verdeel alles in een kom: garnalen, wortel.
3. Werk af met teriyakisaus.','1. Cook the white rice (dry) and let it cool.
2. Arrange in a bowl: shrimp, carrot.
3. Finish with teriyaki sauce.','assembly',null,'core'),
('poke_bowl_with_shrimp_edamame','Poké bowl met garnalen & edamame','Poké bowl with shrimp & edamame',ARRAY['lunch','dinner'],ARRAY['cut','maintain'],'[{"slug":"shrimp","g":110},{"slug":"rice_dry","g":65},{"slug":"edamame","g":80},{"slug":"edamame","g":50},{"slug":"teriyaki","g":20}]'::jsonb,ARRAY['high_protein']::text[],ARRAY['poke']::text[],'1. Kook de witte rijst (droog) en laat afkoelen.
2. Verdeel alles in een kom: garnalen, wat groente.
3. Werk af met teriyakisaus.','1. Cook the white rice (dry) and let it cool.
2. Arrange in a bowl: shrimp, some veg.
3. Finish with teriyaki sauce.','assembly',null,'core'),
('buddha_bowl_with_chicken','Buddha bowl met kip','Buddha bowl with chicken',ARRAY['lunch','dinner'],ARRAY['cut','maintain'],'[{"slug":"chicken_breast","g":120},{"slug":"quinoa_dry","g":65},{"slug":"green_salad","g":80},{"slug":"bell_pepper","g":60},{"slug":"hummus","g":40}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de quinoa (droog) en laat afkoelen.
2. Verdeel alles in een kom: kipfilet (gegrild), gemengde salade en paprika.
3. Werk af met hummus.','1. Cook the quinoa (dry) and let it cool.
2. Arrange in a bowl: grilled chicken breast, mixed salad and bell pepper.
3. Finish with hummus.','assembly',null,'core'),
('burrito_bowl_with_chicken','Burrito bowl met kip','Burrito bowl with chicken',ARRAY['lunch','dinner'],ARRAY['cut','maintain'],'[{"slug":"chicken_breast","g":120},{"slug":"rice_dry","g":65},{"slug":"black_beans","g":60},{"slug":"tomato","g":60},{"slug":"avocado","g":40}]'::jsonb,ARRAY['high_protein']::text[],ARRAY[]::text[],'1. Kook de witte rijst (droog) en laat afkoelen.
2. Verdeel alles in een kom: kipfilet (gegrild), tomaat.
3. Werk af naar smaak.','1. Cook the white rice (dry) and let it cool.
2. Arrange in a bowl: grilled chicken breast, tomato.
3. Finish to taste.','assembly',null,'core'),
('buddha_bowl_with_chickpeas','Buddha bowl met kikkererwten','Buddha bowl with chickpeas',ARRAY['lunch','dinner'],ARRAY['maintain'],'[{"slug":"chickpeas","g":120},{"slug":"quinoa_dry","g":65},{"slug":"green_salad","g":80},{"slug":"bell_pepper","g":60},{"slug":"hummus","g":40}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY[]::text[],'1. Kook de quinoa (droog) en laat afkoelen.
2. Verdeel alles in een kom: kikkererwten, gemengde salade en paprika.
3. Werk af met hummus.','1. Cook the quinoa (dry) and let it cool.
2. Arrange in a bowl: chickpeas, mixed salad and bell pepper.
3. Finish with hummus.','assembly',null,'core'),
('burrito_bowl_with_chickpeas','Burrito bowl met kikkererwten','Burrito bowl with chickpeas',ARRAY['lunch','dinner'],ARRAY['maintain'],'[{"slug":"chickpeas","g":120},{"slug":"rice_dry","g":65},{"slug":"black_beans","g":60},{"slug":"tomato","g":60},{"slug":"avocado","g":40}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY[]::text[],'1. Kook de witte rijst (droog) en laat afkoelen.
2. Verdeel alles in een kom: kikkererwten, tomaat.
3. Werk af naar smaak.','1. Cook the white rice (dry) and let it cool.
2. Arrange in a bowl: chickpeas, tomato.
3. Finish to taste.','assembly',null,'core'),
('buddha_bowl_with_black_beans','Buddha bowl met zwarte bonen','Buddha bowl with black beans',ARRAY['lunch','dinner'],ARRAY['maintain'],'[{"slug":"black_beans","g":120},{"slug":"quinoa_dry","g":65},{"slug":"green_salad","g":80},{"slug":"bell_pepper","g":60},{"slug":"hummus","g":40}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY[]::text[],'1. Kook de quinoa (droog) en laat afkoelen.
2. Verdeel alles in een kom: zwarte bonen, gemengde salade en paprika.
3. Werk af met hummus.','1. Cook the quinoa (dry) and let it cool.
2. Arrange in a bowl: black beans, mixed salad and bell pepper.
3. Finish with hummus.','assembly',null,'core'),
('burrito_bowl_with_black_beans','Burrito bowl met zwarte bonen','Burrito bowl with black beans',ARRAY['lunch','dinner'],ARRAY['maintain'],'[{"slug":"black_beans","g":120},{"slug":"rice_dry","g":65},{"slug":"black_beans","g":60},{"slug":"tomato","g":60},{"slug":"avocado","g":40}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY[]::text[],'1. Kook de witte rijst (droog) en laat afkoelen.
2. Verdeel alles in een kom: zwarte bonen, tomaat.
3. Werk af naar smaak.','1. Cook the white rice (dry) and let it cool.
2. Arrange in a bowl: black beans, tomato.
3. Finish to taste.','assembly',null,'core'),
('buddha_bowl_with_seitan','Buddha bowl met seitan','Buddha bowl with seitan',ARRAY['lunch','dinner'],ARRAY['cut','maintain'],'[{"slug":"seitan","g":110},{"slug":"quinoa_dry","g":65},{"slug":"green_salad","g":80},{"slug":"bell_pepper","g":60},{"slug":"hummus","g":40}]'::jsonb,ARRAY['vegetarian','vegan','high_protein']::text[],ARRAY[]::text[],'1. Kook de quinoa (droog) en laat afkoelen.
2. Verdeel alles in een kom: seitan, gemengde salade en paprika.
3. Werk af met hummus.','1. Cook the quinoa (dry) and let it cool.
2. Arrange in a bowl: seitan, mixed salad and bell pepper.
3. Finish with hummus.','assembly',null,'core'),
('burrito_bowl_with_seitan','Burrito bowl met seitan','Burrito bowl with seitan',ARRAY['lunch','dinner'],ARRAY['maintain'],'[{"slug":"seitan","g":110},{"slug":"rice_dry","g":65},{"slug":"black_beans","g":60},{"slug":"tomato","g":60},{"slug":"avocado","g":40}]'::jsonb,ARRAY['vegetarian','vegan']::text[],ARRAY[]::text[],'1. Kook de witte rijst (droog) en laat afkoelen.
2. Verdeel alles in een kom: seitan, tomaat.
3. Werk af naar smaak.','1. Cook the white rice (dry) and let it cool.
2. Arrange in a bowl: seitan, tomato.
3. Finish to taste.','assembly',null,'core'),
('smoothie_with_banana_whey','Smoothie met banaan & whey','Smoothie with banana & whey',ARRAY['breakfast','snack'],ARRAY['cut','maintain'],'[{"slug":"skim_milk","g":250},{"slug":"banana","g":100},{"slug":"whey","g":25},{"slug":"oats","g":30}]'::jsonb,ARRAY['vegetarian','high_protein']::text[],ARRAY['smoothie']::text[],'1. Doe alle ingrediënten in de blender.
2. Mix glad en schenk in een glas.','1. Add everything to the blender.
2. Blend smooth and pour into a glass.','blender',null,'core'),
('overnight_oats_with_banana','Overnight oats met banaan','Overnight oats with banana',ARRAY['breakfast'],ARRAY['maintain'],'[{"slug":"oats","g":60},{"slug":"skim_milk","g":180},{"slug":"chia","g":12},{"slug":"banana","g":70}]'::jsonb,ARRAY['vegetarian']::text[],ARRAY['oats']::text[],'1. Meng de havermout, melk en chia in een pot.
2. Laat minimaal een nacht in de koelkast opstijven.
3. Top de volgende ochtend met banaan.','1. Mix the oats, milk and chia in a jar.
2. Chill overnight to set.
3. Top with banana in the morning.','assembly',null,'core'),
('muesli_with_yoghurt_banana','Muesli met yoghurt & banaan','Muesli with yoghurt & banana',ARRAY['breakfast'],ARRAY['maintain'],'[{"slug":"muesli","g":55},{"slug":"greek_yoghurt","g":150},{"slug":"banana","g":60}]'::jsonb,ARRAY['vegetarian']::text[],ARRAY[]::text[],'1. Doe de griekse yoghurt 2% in een kom.
2. Schep de muesli erover.
3. Top met banaan.','1. Spoon the greek yoghurt 2% into a bowl.
2. Add the muesli on top.
3. Top with banana.','assembly',null,'core'),
('granola_with_skyr_banana','Granola met skyr & banaan','Granola with skyr & banana',ARRAY['breakfast','snack'],ARRAY['maintain'],'[{"slug":"granola","g":45},{"slug":"skyr","g":150},{"slug":"banana","g":60}]'::jsonb,ARRAY['vegetarian']::text[],ARRAY[]::text[],'1. Doe de skyr in een kom.
2. Schep de granola erover.
3. Top met banaan.','1. Spoon the skyr into a bowl.
2. Add the granola on top.
3. Top with banana.','assembly',null,'core'),
('smoothie_with_blueberries_whey','Smoothie met blauwe bessen & whey','Smoothie with blueberries & whey',ARRAY['breakfast','snack'],ARRAY['cut','maintain'],'[{"slug":"skim_milk","g":250},{"slug":"blueberries","g":100},{"slug":"whey","g":25},{"slug":"oats","g":30}]'::jsonb,ARRAY['vegetarian','high_protein']::text[],ARRAY['smoothie']::text[],'1. Doe alle ingrediënten in de blender.
2. Mix glad en schenk in een glas.','1. Add everything to the blender.
2. Blend smooth and pour into a glass.','blender',null,'core'),
('overnight_oats_with_blueberries','Overnight oats met blauwe bessen','Overnight oats with blueberries',ARRAY['breakfast'],ARRAY['maintain'],'[{"slug":"oats","g":60},{"slug":"skim_milk","g":180},{"slug":"chia","g":12},{"slug":"blueberries","g":70}]'::jsonb,ARRAY['vegetarian']::text[],ARRAY['oats']::text[],'1. Meng de havermout, melk en chia in een pot.
2. Laat minimaal een nacht in de koelkast opstijven.
3. Top de volgende ochtend met blauwe bessen.','1. Mix the oats, milk and chia in a jar.
2. Chill overnight to set.
3. Top with blueberries in the morning.','assembly',null,'core'),
('muesli_with_yoghurt_blueberries','Muesli met yoghurt & blauwe bessen','Muesli with yoghurt & blueberries',ARRAY['breakfast'],ARRAY['maintain'],'[{"slug":"muesli","g":55},{"slug":"greek_yoghurt","g":150},{"slug":"blueberries","g":60}]'::jsonb,ARRAY['vegetarian']::text[],ARRAY[]::text[],'1. Doe de griekse yoghurt 2% in een kom.
2. Schep de muesli erover.
3. Top met blauwe bessen.','1. Spoon the greek yoghurt 2% into a bowl.
2. Add the muesli on top.
3. Top with blueberries.','assembly',null,'core'),
('granola_with_skyr_blueberries','Granola met skyr & blauwe bessen','Granola with skyr & blueberries',ARRAY['breakfast','snack'],ARRAY['maintain'],'[{"slug":"granola","g":45},{"slug":"skyr","g":150},{"slug":"blueberries","g":60}]'::jsonb,ARRAY['vegetarian']::text[],ARRAY[]::text[],'1. Doe de skyr in een kom.
2. Schep de granola erover.
3. Top met blauwe bessen.','1. Spoon the skyr into a bowl.
2. Add the granola on top.
3. Top with blueberries.','assembly',null,'core'),
('smoothie_with_strawberries_whey','Smoothie met aardbeien & whey','Smoothie with strawberries & whey',ARRAY['breakfast','snack'],ARRAY['cut','maintain'],'[{"slug":"skim_milk","g":250},{"slug":"strawberries","g":100},{"slug":"whey","g":25},{"slug":"oats","g":30}]'::jsonb,ARRAY['vegetarian','high_protein']::text[],ARRAY['smoothie']::text[],'1. Doe alle ingrediënten in de blender.
2. Mix glad en schenk in een glas.','1. Add everything to the blender.
2. Blend smooth and pour into a glass.','blender',null,'core'),
('overnight_oats_with_strawberries','Overnight oats met aardbeien','Overnight oats with strawberries',ARRAY['breakfast'],ARRAY['maintain'],'[{"slug":"oats","g":60},{"slug":"skim_milk","g":180},{"slug":"chia","g":12},{"slug":"strawberries","g":70}]'::jsonb,ARRAY['vegetarian']::text[],ARRAY['oats']::text[],'1. Meng de havermout, melk en chia in een pot.
2. Laat minimaal een nacht in de koelkast opstijven.
3. Top de volgende ochtend met aardbeien.','1. Mix the oats, milk and chia in a jar.
2. Chill overnight to set.
3. Top with strawberries in the morning.','assembly',null,'core'),
('muesli_with_yoghurt_strawberries','Muesli met yoghurt & aardbeien','Muesli with yoghurt & strawberries',ARRAY['breakfast'],ARRAY['maintain'],'[{"slug":"muesli","g":55},{"slug":"greek_yoghurt","g":150},{"slug":"strawberries","g":60}]'::jsonb,ARRAY['vegetarian']::text[],ARRAY[]::text[],'1. Doe de griekse yoghurt 2% in een kom.
2. Schep de muesli erover.
3. Top met aardbeien.','1. Spoon the greek yoghurt 2% into a bowl.
2. Add the muesli on top.
3. Top with strawberries.','assembly',null,'core'),
('granola_with_skyr_strawberries','Granola met skyr & aardbeien','Granola with skyr & strawberries',ARRAY['breakfast','snack'],ARRAY['maintain'],'[{"slug":"granola","g":45},{"slug":"skyr","g":150},{"slug":"strawberries","g":60}]'::jsonb,ARRAY['vegetarian']::text[],ARRAY[]::text[],'1. Doe de skyr in een kom.
2. Schep de granola erover.
3. Top met aardbeien.','1. Spoon the skyr into a bowl.
2. Add the granola on top.
3. Top with strawberries.','assembly',null,'core'),
('smoothie_with_mango_whey','Smoothie met mango & whey','Smoothie with mango & whey',ARRAY['breakfast','snack'],ARRAY['cut','maintain'],'[{"slug":"skim_milk","g":250},{"slug":"mango","g":100},{"slug":"whey","g":25},{"slug":"oats","g":30}]'::jsonb,ARRAY['vegetarian','high_protein']::text[],ARRAY['smoothie']::text[],'1. Doe alle ingrediënten in de blender.
2. Mix glad en schenk in een glas.','1. Add everything to the blender.
2. Blend smooth and pour into a glass.','blender',null,'core'),
('overnight_oats_with_mango','Overnight oats met mango','Overnight oats with mango',ARRAY['breakfast'],ARRAY['maintain'],'[{"slug":"oats","g":60},{"slug":"skim_milk","g":180},{"slug":"chia","g":12},{"slug":"mango","g":70}]'::jsonb,ARRAY['vegetarian']::text[],ARRAY['oats']::text[],'1. Meng de havermout, melk en chia in een pot.
2. Laat minimaal een nacht in de koelkast opstijven.
3. Top de volgende ochtend met mango.','1. Mix the oats, milk and chia in a jar.
2. Chill overnight to set.
3. Top with mango in the morning.','assembly',null,'core'),
('muesli_with_yoghurt_mango','Muesli met yoghurt & mango','Muesli with yoghurt & mango',ARRAY['breakfast'],ARRAY['maintain'],'[{"slug":"muesli","g":55},{"slug":"greek_yoghurt","g":150},{"slug":"mango","g":60}]'::jsonb,ARRAY['vegetarian']::text[],ARRAY[]::text[],'1. Doe de griekse yoghurt 2% in een kom.
2. Schep de muesli erover.
3. Top met mango.','1. Spoon the greek yoghurt 2% into a bowl.
2. Add the muesli on top.
3. Top with mango.','assembly',null,'core'),
('granola_with_skyr_mango','Granola met skyr & mango','Granola with skyr & mango',ARRAY['breakfast','snack'],ARRAY['maintain'],'[{"slug":"granola","g":45},{"slug":"skyr","g":150},{"slug":"mango","g":60}]'::jsonb,ARRAY['vegetarian']::text[],ARRAY[]::text[],'1. Doe de skyr in een kom.
2. Schep de granola erover.
3. Top met mango.','1. Spoon the skyr into a bowl.
2. Add the granola on top.
3. Top with mango.','assembly',null,'core'),
('smoothie_with_raspberries_whey','Smoothie met frambozen & whey','Smoothie with raspberries & whey',ARRAY['breakfast','snack'],ARRAY['cut','maintain'],'[{"slug":"skim_milk","g":250},{"slug":"raspberries","g":100},{"slug":"whey","g":25},{"slug":"oats","g":30}]'::jsonb,ARRAY['vegetarian','high_protein']::text[],ARRAY['smoothie']::text[],'1. Doe alle ingrediënten in de blender.
2. Mix glad en schenk in een glas.','1. Add everything to the blender.
2. Blend smooth and pour into a glass.','blender',null,'core'),
('overnight_oats_with_raspberries','Overnight oats met frambozen','Overnight oats with raspberries',ARRAY['breakfast'],ARRAY['maintain'],'[{"slug":"oats","g":60},{"slug":"skim_milk","g":180},{"slug":"chia","g":12},{"slug":"raspberries","g":70}]'::jsonb,ARRAY['vegetarian']::text[],ARRAY['oats']::text[],'1. Meng de havermout, melk en chia in een pot.
2. Laat minimaal een nacht in de koelkast opstijven.
3. Top de volgende ochtend met frambozen.','1. Mix the oats, milk and chia in a jar.
2. Chill overnight to set.
3. Top with raspberries in the morning.','assembly',null,'core'),
('muesli_with_yoghurt_raspberries','Muesli met yoghurt & frambozen','Muesli with yoghurt & raspberries',ARRAY['breakfast'],ARRAY['maintain'],'[{"slug":"muesli","g":55},{"slug":"greek_yoghurt","g":150},{"slug":"raspberries","g":60}]'::jsonb,ARRAY['vegetarian']::text[],ARRAY[]::text[],'1. Doe de griekse yoghurt 2% in een kom.
2. Schep de muesli erover.
3. Top met frambozen.','1. Spoon the greek yoghurt 2% into a bowl.
2. Add the muesli on top.
3. Top with raspberries.','assembly',null,'core'),
('granola_with_skyr_raspberries','Granola met skyr & frambozen','Granola with skyr & raspberries',ARRAY['breakfast','snack'],ARRAY['maintain'],'[{"slug":"granola","g":45},{"slug":"skyr","g":150},{"slug":"raspberries","g":60}]'::jsonb,ARRAY['vegetarian']::text[],ARRAY[]::text[],'1. Doe de skyr in een kom.
2. Schep de granola erover.
3. Top met frambozen.','1. Spoon the skyr into a bowl.
2. Add the granola on top.
3. Top with raspberries.','assembly',null,'core'),
('smoothie_with_kiwi_whey','Smoothie met kiwi & whey','Smoothie with kiwi & whey',ARRAY['breakfast','snack'],ARRAY['cut','maintain'],'[{"slug":"skim_milk","g":250},{"slug":"kiwi","g":100},{"slug":"whey","g":25},{"slug":"oats","g":30}]'::jsonb,ARRAY['vegetarian','high_protein']::text[],ARRAY['smoothie']::text[],'1. Doe alle ingrediënten in de blender.
2. Mix glad en schenk in een glas.','1. Add everything to the blender.
2. Blend smooth and pour into a glass.','blender',null,'core'),
('overnight_oats_with_kiwi','Overnight oats met kiwi','Overnight oats with kiwi',ARRAY['breakfast'],ARRAY['maintain'],'[{"slug":"oats","g":60},{"slug":"skim_milk","g":180},{"slug":"chia","g":12},{"slug":"kiwi","g":70}]'::jsonb,ARRAY['vegetarian']::text[],ARRAY['oats']::text[],'1. Meng de havermout, melk en chia in een pot.
2. Laat minimaal een nacht in de koelkast opstijven.
3. Top de volgende ochtend met kiwi.','1. Mix the oats, milk and chia in a jar.
2. Chill overnight to set.
3. Top with kiwi in the morning.','assembly',null,'core'),
('muesli_with_yoghurt_kiwi','Muesli met yoghurt & kiwi','Muesli with yoghurt & kiwi',ARRAY['breakfast'],ARRAY['maintain'],'[{"slug":"muesli","g":55},{"slug":"greek_yoghurt","g":150},{"slug":"kiwi","g":60}]'::jsonb,ARRAY['vegetarian']::text[],ARRAY[]::text[],'1. Doe de griekse yoghurt 2% in een kom.
2. Schep de muesli erover.
3. Top met kiwi.','1. Spoon the greek yoghurt 2% into a bowl.
2. Add the muesli on top.
3. Top with kiwi.','assembly',null,'core'),
('granola_with_skyr_kiwi','Granola met skyr & kiwi','Granola with skyr & kiwi',ARRAY['breakfast','snack'],ARRAY['maintain'],'[{"slug":"granola","g":45},{"slug":"skyr","g":150},{"slug":"kiwi","g":60}]'::jsonb,ARRAY['vegetarian']::text[],ARRAY[]::text[],'1. Doe de skyr in een kom.
2. Schep de granola erover.
3. Top met kiwi.','1. Spoon the skyr into a bowl.
2. Add the granola on top.
3. Top with kiwi.','assembly',null,'core'),
('smoothie_with_pineapple_whey','Smoothie met ananas & whey','Smoothie with pineapple & whey',ARRAY['breakfast','snack'],ARRAY['cut','maintain'],'[{"slug":"skim_milk","g":250},{"slug":"pineapple","g":100},{"slug":"whey","g":25},{"slug":"oats","g":30}]'::jsonb,ARRAY['vegetarian','high_protein']::text[],ARRAY['smoothie']::text[],'1. Doe alle ingrediënten in de blender.
2. Mix glad en schenk in een glas.','1. Add everything to the blender.
2. Blend smooth and pour into a glass.','blender',null,'core'),
('overnight_oats_with_pineapple','Overnight oats met ananas','Overnight oats with pineapple',ARRAY['breakfast'],ARRAY['maintain'],'[{"slug":"oats","g":60},{"slug":"skim_milk","g":180},{"slug":"chia","g":12},{"slug":"pineapple","g":70}]'::jsonb,ARRAY['vegetarian']::text[],ARRAY['oats']::text[],'1. Meng de havermout, melk en chia in een pot.
2. Laat minimaal een nacht in de koelkast opstijven.
3. Top de volgende ochtend met ananas.','1. Mix the oats, milk and chia in a jar.
2. Chill overnight to set.
3. Top with pineapple in the morning.','assembly',null,'core'),
('muesli_with_yoghurt_pineapple','Muesli met yoghurt & ananas','Muesli with yoghurt & pineapple',ARRAY['breakfast'],ARRAY['maintain'],'[{"slug":"muesli","g":55},{"slug":"greek_yoghurt","g":150},{"slug":"pineapple","g":60}]'::jsonb,ARRAY['vegetarian']::text[],ARRAY[]::text[],'1. Doe de griekse yoghurt 2% in een kom.
2. Schep de muesli erover.
3. Top met ananas.','1. Spoon the greek yoghurt 2% into a bowl.
2. Add the muesli on top.
3. Top with pineapple.','assembly',null,'core'),
('granola_with_skyr_pineapple','Granola met skyr & ananas','Granola with skyr & pineapple',ARRAY['breakfast','snack'],ARRAY['maintain'],'[{"slug":"granola","g":45},{"slug":"skyr","g":150},{"slug":"pineapple","g":60}]'::jsonb,ARRAY['vegetarian']::text[],ARRAY[]::text[],'1. Doe de skyr in een kom.
2. Schep de granola erover.
3. Top met ananas.','1. Spoon the skyr into a bowl.
2. Add the granola on top.
3. Top with pineapple.','assembly',null,'core'),
('wholegrain_toast_with_avocado_egg','Volkoren toast met avocado & ei','Wholegrain toast with avocado & egg',ARRAY['breakfast'],ARRAY['maintain'],'[{"slug":"bread_whole","g":70},{"slug":"avocado","g":60},{"slug":"egg","g":100}]'::jsonb,ARRAY['vegetarian']::text[],ARRAY['wholebread']::text[],'1. Rooster of snijd het brood.
2. Beleg met ei.
3. Breng op smaak met peper en zout.','1. Toast or slice the bread.
2. Top with egg.
3. Season with salt and pepper.','assembly',null,'core')
on conflict (slug) do update set name_nl=excluded.name_nl,name_en=excluded.name_en,moments=excluded.moments,goals=excluded.goals,items=excluded.items,tags=excluded.tags,prefs=excluded.prefs,steps=excluded.steps,steps_en=excluded.steps_en,technique=excluded.technique,temp=excluded.temp;
commit;
