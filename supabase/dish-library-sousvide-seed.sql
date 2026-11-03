-- SOUS-VIDE batch (core). Draai NA dish-library.sql (en mag na de hoofd-seed).
begin;
insert into public.ingredients (slug,name_nl,name_en,kcal,protein,carbs,fat,category,source) values
('chicken_breast','Kipfilet (gegrild)','Chicken breast',165,31,0,3.6,'vlees','core'),
('sweet_potato','Zoete aardappel','Sweet potato',86,1.6,20,0.1,'granen','core'),
('broccoli','Broccoli','Broccoli',34,2.8,7,0.4,'groente','core'),
('butter','Roomboter','Butter',717,0.9,0.1,81,'vet','core'),
('green_beans','Sperziebonen','Green beans',31,1.8,7,0.1,'groente','core'),
('asparagus','Asperges','Asparagus',20,2.2,3.9,0.1,'groente','core'),
('spinach','Spinazie','Spinach',23,2.9,3.6,0.4,'groente','core'),
('zucchini','Courgette','Zucchini',17,1.2,3.1,0.3,'groente','core'),
('potato','Aardappel','Potato',77,2,17,0.1,'granen','core'),
('rice_dry','Witte rijst (droog)','White rice (dry)',360,7,79,1,'granen','core'),
('quinoa_dry','Quinoa (droog)','Quinoa (dry)',368,14,64,6,'granen','core'),
('chicken_thigh','Kipdij','Chicken thigh',177,24,0,9,'vlees','core'),
('beef_steak','Biefstuk','Beef steak',187,27,0,8,'vlees','core'),
('flat_iron','Flat iron steak','Flat iron steak',191,23,0,11,'vlees','core'),
('lamb_fillet','Lamsfilet','Lamb fillet',201,25,0,11,'vlees','core'),
('pork_tenderloin','Varkenshaas','Pork tenderloin',143,26,0,4,'vlees','core'),
('duck_breast','Eendenborst (zonder vel)','Duck breast (skinless)',201,23.5,0,11,'vlees','core'),
('salmon','Zalmfilet','Salmon fillet',208,20,0,13,'vis','core'),
('olive_oil','Olijfolie','Olive oil',884,0,0,100,'vet','core'),
('white_fish','Kabeljauw','Cod',82,18,0,0.7,'vis','core'),
('shrimp','Garnalen','Shrimp',99,24,0.2,0.3,'vis','core'),
('egg','Ei','Egg',143,13,1,10,'overig','core')
on conflict (slug) do nothing;

insert into public.dishes (slug,name_nl,name_en,moments,goals,items,tags,prefs,steps,source) values
('sous_vide_chicken_63_c_with_sweet_potato_broccoli','Kip sous-vide 63°C met zoete aardappel & broccoli','Sous-vide chicken 63°C with sweet potato & broccoli',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"chicken_breast","g":160},{"slug":"sweet_potato","g":200},{"slug":"broccoli","g":120},{"slug":"butter","g":8}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Vacumeer de kipfilet (gegrild) (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 63°C (1,5–4 u).
3. Dep droog en schroei rondom kort dicht in een gloeiend hete pan of met de brander, voor een korst.
4. Kook de zoete aardappel volgens de verpakking.
5. Stoom of wok de broccoli beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_chicken_63_c_with_sweet_potato_green_beans','Kip sous-vide 63°C met zoete aardappel & sperziebonen','Sous-vide chicken 63°C with sweet potato & green beans',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"chicken_breast","g":160},{"slug":"sweet_potato","g":200},{"slug":"green_beans","g":120},{"slug":"butter","g":8}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Vacumeer de kipfilet (gegrild) (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 63°C (1,5–4 u).
3. Dep droog en schroei rondom kort dicht in een gloeiend hete pan of met de brander, voor een korst.
4. Kook de zoete aardappel volgens de verpakking.
5. Stoom of wok de sperziebonen beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_chicken_63_c_with_sweet_potato_green_asparagus','Kip sous-vide 63°C met zoete aardappel & groene asperges','Sous-vide chicken 63°C with sweet potato & green asparagus',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"chicken_breast","g":160},{"slug":"sweet_potato","g":200},{"slug":"asparagus","g":120},{"slug":"butter","g":8}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Vacumeer de kipfilet (gegrild) (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 63°C (1,5–4 u).
3. Dep droog en schroei rondom kort dicht in een gloeiend hete pan of met de brander, voor een korst.
4. Kook de zoete aardappel volgens de verpakking.
5. Stoom of wok de groene asperges beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_chicken_63_c_with_sweet_potato_spinach','Kip sous-vide 63°C met zoete aardappel & spinazie','Sous-vide chicken 63°C with sweet potato & spinach',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"chicken_breast","g":160},{"slug":"sweet_potato","g":200},{"slug":"spinach","g":100},{"slug":"butter","g":8}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Vacumeer de kipfilet (gegrild) (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 63°C (1,5–4 u).
3. Dep droog en schroei rondom kort dicht in een gloeiend hete pan of met de brander, voor een korst.
4. Kook de zoete aardappel volgens de verpakking.
5. Stoom of wok de spinazie beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_chicken_63_c_with_sweet_potato_zucchini','Kip sous-vide 63°C met zoete aardappel & courgette','Sous-vide chicken 63°C with sweet potato & zucchini',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"chicken_breast","g":160},{"slug":"sweet_potato","g":200},{"slug":"zucchini","g":120},{"slug":"butter","g":8}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Vacumeer de kipfilet (gegrild) (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 63°C (1,5–4 u).
3. Dep droog en schroei rondom kort dicht in een gloeiend hete pan of met de brander, voor een korst.
4. Kook de zoete aardappel volgens de verpakking.
5. Stoom of wok de courgette beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_chicken_63_c_with_potato_broccoli','Kip sous-vide 63°C met aardappel & broccoli','Sous-vide chicken 63°C with potato & broccoli',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"chicken_breast","g":160},{"slug":"potato","g":250},{"slug":"broccoli","g":120},{"slug":"butter","g":8}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Vacumeer de kipfilet (gegrild) (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 63°C (1,5–4 u).
3. Dep droog en schroei rondom kort dicht in een gloeiend hete pan of met de brander, voor een korst.
4. Kook de aardappel volgens de verpakking.
5. Stoom of wok de broccoli beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_chicken_63_c_with_potato_green_beans','Kip sous-vide 63°C met aardappel & sperziebonen','Sous-vide chicken 63°C with potato & green beans',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"chicken_breast","g":160},{"slug":"potato","g":250},{"slug":"green_beans","g":120},{"slug":"butter","g":8}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Vacumeer de kipfilet (gegrild) (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 63°C (1,5–4 u).
3. Dep droog en schroei rondom kort dicht in een gloeiend hete pan of met de brander, voor een korst.
4. Kook de aardappel volgens de verpakking.
5. Stoom of wok de sperziebonen beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_chicken_63_c_with_potato_green_asparagus','Kip sous-vide 63°C met aardappel & groene asperges','Sous-vide chicken 63°C with potato & green asparagus',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"chicken_breast","g":160},{"slug":"potato","g":250},{"slug":"asparagus","g":120},{"slug":"butter","g":8}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Vacumeer de kipfilet (gegrild) (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 63°C (1,5–4 u).
3. Dep droog en schroei rondom kort dicht in een gloeiend hete pan of met de brander, voor een korst.
4. Kook de aardappel volgens de verpakking.
5. Stoom of wok de groene asperges beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_chicken_63_c_with_potato_spinach','Kip sous-vide 63°C met aardappel & spinazie','Sous-vide chicken 63°C with potato & spinach',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"chicken_breast","g":160},{"slug":"potato","g":250},{"slug":"spinach","g":100},{"slug":"butter","g":8}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Vacumeer de kipfilet (gegrild) (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 63°C (1,5–4 u).
3. Dep droog en schroei rondom kort dicht in een gloeiend hete pan of met de brander, voor een korst.
4. Kook de aardappel volgens de verpakking.
5. Stoom of wok de spinazie beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_chicken_63_c_with_potato_zucchini','Kip sous-vide 63°C met aardappel & courgette','Sous-vide chicken 63°C with potato & zucchini',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"chicken_breast","g":160},{"slug":"potato","g":250},{"slug":"zucchini","g":120},{"slug":"butter","g":8}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Vacumeer de kipfilet (gegrild) (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 63°C (1,5–4 u).
3. Dep droog en schroei rondom kort dicht in een gloeiend hete pan of met de brander, voor een korst.
4. Kook de aardappel volgens de verpakking.
5. Stoom of wok de courgette beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_chicken_63_c_with_rice_broccoli','Kip sous-vide 63°C met rijst & broccoli','Sous-vide chicken 63°C with rice & broccoli',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"chicken_breast","g":160},{"slug":"rice_dry","g":70},{"slug":"broccoli","g":120},{"slug":"butter","g":8}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Vacumeer de kipfilet (gegrild) (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 63°C (1,5–4 u).
3. Dep droog en schroei rondom kort dicht in een gloeiend hete pan of met de brander, voor een korst.
4. Kook de rijst volgens de verpakking.
5. Stoom of wok de broccoli beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_chicken_63_c_with_rice_green_beans','Kip sous-vide 63°C met rijst & sperziebonen','Sous-vide chicken 63°C with rice & green beans',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"chicken_breast","g":160},{"slug":"rice_dry","g":70},{"slug":"green_beans","g":120},{"slug":"butter","g":8}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Vacumeer de kipfilet (gegrild) (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 63°C (1,5–4 u).
3. Dep droog en schroei rondom kort dicht in een gloeiend hete pan of met de brander, voor een korst.
4. Kook de rijst volgens de verpakking.
5. Stoom of wok de sperziebonen beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_chicken_63_c_with_rice_green_asparagus','Kip sous-vide 63°C met rijst & groene asperges','Sous-vide chicken 63°C with rice & green asparagus',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"chicken_breast","g":160},{"slug":"rice_dry","g":70},{"slug":"asparagus","g":120},{"slug":"butter","g":8}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Vacumeer de kipfilet (gegrild) (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 63°C (1,5–4 u).
3. Dep droog en schroei rondom kort dicht in een gloeiend hete pan of met de brander, voor een korst.
4. Kook de rijst volgens de verpakking.
5. Stoom of wok de groene asperges beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_chicken_63_c_with_rice_spinach','Kip sous-vide 63°C met rijst & spinazie','Sous-vide chicken 63°C with rice & spinach',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"chicken_breast","g":160},{"slug":"rice_dry","g":70},{"slug":"spinach","g":100},{"slug":"butter","g":8}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Vacumeer de kipfilet (gegrild) (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 63°C (1,5–4 u).
3. Dep droog en schroei rondom kort dicht in een gloeiend hete pan of met de brander, voor een korst.
4. Kook de rijst volgens de verpakking.
5. Stoom of wok de spinazie beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_chicken_63_c_with_rice_zucchini','Kip sous-vide 63°C met rijst & courgette','Sous-vide chicken 63°C with rice & zucchini',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"chicken_breast","g":160},{"slug":"rice_dry","g":70},{"slug":"zucchini","g":120},{"slug":"butter","g":8}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Vacumeer de kipfilet (gegrild) (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 63°C (1,5–4 u).
3. Dep droog en schroei rondom kort dicht in een gloeiend hete pan of met de brander, voor een korst.
4. Kook de rijst volgens de verpakking.
5. Stoom of wok de courgette beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_chicken_63_c_with_quinoa_broccoli','Kip sous-vide 63°C met quinoa & broccoli','Sous-vide chicken 63°C with quinoa & broccoli',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"chicken_breast","g":160},{"slug":"quinoa_dry","g":70},{"slug":"broccoli","g":120},{"slug":"butter","g":8}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Vacumeer de kipfilet (gegrild) (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 63°C (1,5–4 u).
3. Dep droog en schroei rondom kort dicht in een gloeiend hete pan of met de brander, voor een korst.
4. Kook de quinoa volgens de verpakking.
5. Stoom of wok de broccoli beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_chicken_63_c_with_quinoa_green_beans','Kip sous-vide 63°C met quinoa & sperziebonen','Sous-vide chicken 63°C with quinoa & green beans',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"chicken_breast","g":160},{"slug":"quinoa_dry","g":70},{"slug":"green_beans","g":120},{"slug":"butter","g":8}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Vacumeer de kipfilet (gegrild) (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 63°C (1,5–4 u).
3. Dep droog en schroei rondom kort dicht in een gloeiend hete pan of met de brander, voor een korst.
4. Kook de quinoa volgens de verpakking.
5. Stoom of wok de sperziebonen beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_chicken_63_c_with_quinoa_green_asparagus','Kip sous-vide 63°C met quinoa & groene asperges','Sous-vide chicken 63°C with quinoa & green asparagus',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"chicken_breast","g":160},{"slug":"quinoa_dry","g":70},{"slug":"asparagus","g":120},{"slug":"butter","g":8}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Vacumeer de kipfilet (gegrild) (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 63°C (1,5–4 u).
3. Dep droog en schroei rondom kort dicht in een gloeiend hete pan of met de brander, voor een korst.
4. Kook de quinoa volgens de verpakking.
5. Stoom of wok de groene asperges beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_chicken_63_c_with_quinoa_spinach','Kip sous-vide 63°C met quinoa & spinazie','Sous-vide chicken 63°C with quinoa & spinach',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"chicken_breast","g":160},{"slug":"quinoa_dry","g":70},{"slug":"spinach","g":100},{"slug":"butter","g":8}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Vacumeer de kipfilet (gegrild) (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 63°C (1,5–4 u).
3. Dep droog en schroei rondom kort dicht in een gloeiend hete pan of met de brander, voor een korst.
4. Kook de quinoa volgens de verpakking.
5. Stoom of wok de spinazie beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_chicken_63_c_with_quinoa_zucchini','Kip sous-vide 63°C met quinoa & courgette','Sous-vide chicken 63°C with quinoa & zucchini',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"chicken_breast","g":160},{"slug":"quinoa_dry","g":70},{"slug":"zucchini","g":120},{"slug":"butter","g":8}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY['chickenrice','ricechicken']::text[],'1. Vacumeer de kipfilet (gegrild) (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 63°C (1,5–4 u).
3. Dep droog en schroei rondom kort dicht in een gloeiend hete pan of met de brander, voor een korst.
4. Kook de quinoa volgens de verpakking.
5. Stoom of wok de courgette beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_chicken_thigh_74_c_with_sweet_potato_broccoli','Kipdij sous-vide 74°C met zoete aardappel & broccoli','Sous-vide chicken thigh 74°C with sweet potato & broccoli',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"chicken_thigh","g":150},{"slug":"sweet_potato","g":200},{"slug":"broccoli","g":120},{"slug":"butter","g":8}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY[]::text[],'1. Vacumeer de kipdij (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 74°C (1–4 u).
3. Dep droog en schroei rondom kort dicht in een gloeiend hete pan of met de brander, voor een korst.
4. Kook de zoete aardappel volgens de verpakking.
5. Stoom of wok de broccoli beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_chicken_thigh_74_c_with_sweet_potato_green_beans','Kipdij sous-vide 74°C met zoete aardappel & sperziebonen','Sous-vide chicken thigh 74°C with sweet potato & green beans',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"chicken_thigh","g":150},{"slug":"sweet_potato","g":200},{"slug":"green_beans","g":120},{"slug":"butter","g":8}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY[]::text[],'1. Vacumeer de kipdij (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 74°C (1–4 u).
3. Dep droog en schroei rondom kort dicht in een gloeiend hete pan of met de brander, voor een korst.
4. Kook de zoete aardappel volgens de verpakking.
5. Stoom of wok de sperziebonen beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_chicken_thigh_74_c_with_sweet_potato_green_asparagus','Kipdij sous-vide 74°C met zoete aardappel & groene asperges','Sous-vide chicken thigh 74°C with sweet potato & green asparagus',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"chicken_thigh","g":150},{"slug":"sweet_potato","g":200},{"slug":"asparagus","g":120},{"slug":"butter","g":8}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY[]::text[],'1. Vacumeer de kipdij (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 74°C (1–4 u).
3. Dep droog en schroei rondom kort dicht in een gloeiend hete pan of met de brander, voor een korst.
4. Kook de zoete aardappel volgens de verpakking.
5. Stoom of wok de groene asperges beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_chicken_thigh_74_c_with_sweet_potato_spinach','Kipdij sous-vide 74°C met zoete aardappel & spinazie','Sous-vide chicken thigh 74°C with sweet potato & spinach',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"chicken_thigh","g":150},{"slug":"sweet_potato","g":200},{"slug":"spinach","g":100},{"slug":"butter","g":8}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY[]::text[],'1. Vacumeer de kipdij (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 74°C (1–4 u).
3. Dep droog en schroei rondom kort dicht in een gloeiend hete pan of met de brander, voor een korst.
4. Kook de zoete aardappel volgens de verpakking.
5. Stoom of wok de spinazie beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_chicken_thigh_74_c_with_sweet_potato_zucchini','Kipdij sous-vide 74°C met zoete aardappel & courgette','Sous-vide chicken thigh 74°C with sweet potato & zucchini',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"chicken_thigh","g":150},{"slug":"sweet_potato","g":200},{"slug":"zucchini","g":120},{"slug":"butter","g":8}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY[]::text[],'1. Vacumeer de kipdij (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 74°C (1–4 u).
3. Dep droog en schroei rondom kort dicht in een gloeiend hete pan of met de brander, voor een korst.
4. Kook de zoete aardappel volgens de verpakking.
5. Stoom of wok de courgette beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_chicken_thigh_74_c_with_potato_broccoli','Kipdij sous-vide 74°C met aardappel & broccoli','Sous-vide chicken thigh 74°C with potato & broccoli',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"chicken_thigh","g":150},{"slug":"potato","g":250},{"slug":"broccoli","g":120},{"slug":"butter","g":8}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY[]::text[],'1. Vacumeer de kipdij (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 74°C (1–4 u).
3. Dep droog en schroei rondom kort dicht in een gloeiend hete pan of met de brander, voor een korst.
4. Kook de aardappel volgens de verpakking.
5. Stoom of wok de broccoli beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_chicken_thigh_74_c_with_potato_green_beans','Kipdij sous-vide 74°C met aardappel & sperziebonen','Sous-vide chicken thigh 74°C with potato & green beans',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"chicken_thigh","g":150},{"slug":"potato","g":250},{"slug":"green_beans","g":120},{"slug":"butter","g":8}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY[]::text[],'1. Vacumeer de kipdij (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 74°C (1–4 u).
3. Dep droog en schroei rondom kort dicht in een gloeiend hete pan of met de brander, voor een korst.
4. Kook de aardappel volgens de verpakking.
5. Stoom of wok de sperziebonen beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_chicken_thigh_74_c_with_potato_green_asparagus','Kipdij sous-vide 74°C met aardappel & groene asperges','Sous-vide chicken thigh 74°C with potato & green asparagus',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"chicken_thigh","g":150},{"slug":"potato","g":250},{"slug":"asparagus","g":120},{"slug":"butter","g":8}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY[]::text[],'1. Vacumeer de kipdij (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 74°C (1–4 u).
3. Dep droog en schroei rondom kort dicht in een gloeiend hete pan of met de brander, voor een korst.
4. Kook de aardappel volgens de verpakking.
5. Stoom of wok de groene asperges beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_chicken_thigh_74_c_with_potato_spinach','Kipdij sous-vide 74°C met aardappel & spinazie','Sous-vide chicken thigh 74°C with potato & spinach',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"chicken_thigh","g":150},{"slug":"potato","g":250},{"slug":"spinach","g":100},{"slug":"butter","g":8}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY[]::text[],'1. Vacumeer de kipdij (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 74°C (1–4 u).
3. Dep droog en schroei rondom kort dicht in een gloeiend hete pan of met de brander, voor een korst.
4. Kook de aardappel volgens de verpakking.
5. Stoom of wok de spinazie beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_chicken_thigh_74_c_with_potato_zucchini','Kipdij sous-vide 74°C met aardappel & courgette','Sous-vide chicken thigh 74°C with potato & zucchini',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"chicken_thigh","g":150},{"slug":"potato","g":250},{"slug":"zucchini","g":120},{"slug":"butter","g":8}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY[]::text[],'1. Vacumeer de kipdij (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 74°C (1–4 u).
3. Dep droog en schroei rondom kort dicht in een gloeiend hete pan of met de brander, voor een korst.
4. Kook de aardappel volgens de verpakking.
5. Stoom of wok de courgette beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_chicken_thigh_74_c_with_rice_broccoli','Kipdij sous-vide 74°C met rijst & broccoli','Sous-vide chicken thigh 74°C with rice & broccoli',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"chicken_thigh","g":150},{"slug":"rice_dry","g":70},{"slug":"broccoli","g":120},{"slug":"butter","g":8}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY[]::text[],'1. Vacumeer de kipdij (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 74°C (1–4 u).
3. Dep droog en schroei rondom kort dicht in een gloeiend hete pan of met de brander, voor een korst.
4. Kook de rijst volgens de verpakking.
5. Stoom of wok de broccoli beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_chicken_thigh_74_c_with_rice_green_beans','Kipdij sous-vide 74°C met rijst & sperziebonen','Sous-vide chicken thigh 74°C with rice & green beans',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"chicken_thigh","g":150},{"slug":"rice_dry","g":70},{"slug":"green_beans","g":120},{"slug":"butter","g":8}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY[]::text[],'1. Vacumeer de kipdij (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 74°C (1–4 u).
3. Dep droog en schroei rondom kort dicht in een gloeiend hete pan of met de brander, voor een korst.
4. Kook de rijst volgens de verpakking.
5. Stoom of wok de sperziebonen beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_chicken_thigh_74_c_with_rice_green_asparagus','Kipdij sous-vide 74°C met rijst & groene asperges','Sous-vide chicken thigh 74°C with rice & green asparagus',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"chicken_thigh","g":150},{"slug":"rice_dry","g":70},{"slug":"asparagus","g":120},{"slug":"butter","g":8}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY[]::text[],'1. Vacumeer de kipdij (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 74°C (1–4 u).
3. Dep droog en schroei rondom kort dicht in een gloeiend hete pan of met de brander, voor een korst.
4. Kook de rijst volgens de verpakking.
5. Stoom of wok de groene asperges beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_chicken_thigh_74_c_with_rice_spinach','Kipdij sous-vide 74°C met rijst & spinazie','Sous-vide chicken thigh 74°C with rice & spinach',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"chicken_thigh","g":150},{"slug":"rice_dry","g":70},{"slug":"spinach","g":100},{"slug":"butter","g":8}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY[]::text[],'1. Vacumeer de kipdij (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 74°C (1–4 u).
3. Dep droog en schroei rondom kort dicht in een gloeiend hete pan of met de brander, voor een korst.
4. Kook de rijst volgens de verpakking.
5. Stoom of wok de spinazie beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_chicken_thigh_74_c_with_rice_zucchini','Kipdij sous-vide 74°C met rijst & courgette','Sous-vide chicken thigh 74°C with rice & zucchini',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"chicken_thigh","g":150},{"slug":"rice_dry","g":70},{"slug":"zucchini","g":120},{"slug":"butter","g":8}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY[]::text[],'1. Vacumeer de kipdij (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 74°C (1–4 u).
3. Dep droog en schroei rondom kort dicht in een gloeiend hete pan of met de brander, voor een korst.
4. Kook de rijst volgens de verpakking.
5. Stoom of wok de courgette beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_chicken_thigh_74_c_with_quinoa_broccoli','Kipdij sous-vide 74°C met quinoa & broccoli','Sous-vide chicken thigh 74°C with quinoa & broccoli',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"chicken_thigh","g":150},{"slug":"quinoa_dry","g":70},{"slug":"broccoli","g":120},{"slug":"butter","g":8}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY[]::text[],'1. Vacumeer de kipdij (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 74°C (1–4 u).
3. Dep droog en schroei rondom kort dicht in een gloeiend hete pan of met de brander, voor een korst.
4. Kook de quinoa volgens de verpakking.
5. Stoom of wok de broccoli beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_chicken_thigh_74_c_with_quinoa_green_beans','Kipdij sous-vide 74°C met quinoa & sperziebonen','Sous-vide chicken thigh 74°C with quinoa & green beans',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"chicken_thigh","g":150},{"slug":"quinoa_dry","g":70},{"slug":"green_beans","g":120},{"slug":"butter","g":8}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY[]::text[],'1. Vacumeer de kipdij (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 74°C (1–4 u).
3. Dep droog en schroei rondom kort dicht in een gloeiend hete pan of met de brander, voor een korst.
4. Kook de quinoa volgens de verpakking.
5. Stoom of wok de sperziebonen beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_chicken_thigh_74_c_with_quinoa_green_asparagus','Kipdij sous-vide 74°C met quinoa & groene asperges','Sous-vide chicken thigh 74°C with quinoa & green asparagus',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"chicken_thigh","g":150},{"slug":"quinoa_dry","g":70},{"slug":"asparagus","g":120},{"slug":"butter","g":8}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY[]::text[],'1. Vacumeer de kipdij (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 74°C (1–4 u).
3. Dep droog en schroei rondom kort dicht in een gloeiend hete pan of met de brander, voor een korst.
4. Kook de quinoa volgens de verpakking.
5. Stoom of wok de groene asperges beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_chicken_thigh_74_c_with_quinoa_spinach','Kipdij sous-vide 74°C met quinoa & spinazie','Sous-vide chicken thigh 74°C with quinoa & spinach',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"chicken_thigh","g":150},{"slug":"quinoa_dry","g":70},{"slug":"spinach","g":100},{"slug":"butter","g":8}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY[]::text[],'1. Vacumeer de kipdij (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 74°C (1–4 u).
3. Dep droog en schroei rondom kort dicht in een gloeiend hete pan of met de brander, voor een korst.
4. Kook de quinoa volgens de verpakking.
5. Stoom of wok de spinazie beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_chicken_thigh_74_c_with_quinoa_zucchini','Kipdij sous-vide 74°C met quinoa & courgette','Sous-vide chicken thigh 74°C with quinoa & zucchini',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"chicken_thigh","g":150},{"slug":"quinoa_dry","g":70},{"slug":"zucchini","g":120},{"slug":"butter","g":8}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY[]::text[],'1. Vacumeer de kipdij (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 74°C (1–4 u).
3. Dep droog en schroei rondom kort dicht in een gloeiend hete pan of met de brander, voor een korst.
4. Kook de quinoa volgens de verpakking.
5. Stoom of wok de courgette beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_steak_54_c_medium_rare_with_sweet_potato_broccoli','Biefstuk sous-vide 54°C (medium-rare) met zoete aardappel & broccoli','Sous-vide steak 54°C (medium-rare) with sweet potato & broccoli',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"beef_steak","g":150},{"slug":"sweet_potato","g":200},{"slug":"broccoli","g":120},{"slug":"butter","g":8}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY['steakpotato']::text[],'1. Vacumeer de biefstuk (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 54°C (1,5–4 u).
3. Dep droog en schroei rondom kort dicht in een gloeiend hete pan of met de brander, voor een korst.
4. Kook de zoete aardappel volgens de verpakking.
5. Stoom of wok de broccoli beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_steak_54_c_medium_rare_with_sweet_potato_green_beans','Biefstuk sous-vide 54°C (medium-rare) met zoete aardappel & sperziebonen','Sous-vide steak 54°C (medium-rare) with sweet potato & green beans',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"beef_steak","g":150},{"slug":"sweet_potato","g":200},{"slug":"green_beans","g":120},{"slug":"butter","g":8}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY['steakpotato']::text[],'1. Vacumeer de biefstuk (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 54°C (1,5–4 u).
3. Dep droog en schroei rondom kort dicht in een gloeiend hete pan of met de brander, voor een korst.
4. Kook de zoete aardappel volgens de verpakking.
5. Stoom of wok de sperziebonen beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_steak_54_c_medium_rare_with_sweet_potato_green_asparagus','Biefstuk sous-vide 54°C (medium-rare) met zoete aardappel & groene asperges','Sous-vide steak 54°C (medium-rare) with sweet potato & green asparagus',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"beef_steak","g":150},{"slug":"sweet_potato","g":200},{"slug":"asparagus","g":120},{"slug":"butter","g":8}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY['steakpotato']::text[],'1. Vacumeer de biefstuk (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 54°C (1,5–4 u).
3. Dep droog en schroei rondom kort dicht in een gloeiend hete pan of met de brander, voor een korst.
4. Kook de zoete aardappel volgens de verpakking.
5. Stoom of wok de groene asperges beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_steak_54_c_medium_rare_with_sweet_potato_spinach','Biefstuk sous-vide 54°C (medium-rare) met zoete aardappel & spinazie','Sous-vide steak 54°C (medium-rare) with sweet potato & spinach',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"beef_steak","g":150},{"slug":"sweet_potato","g":200},{"slug":"spinach","g":100},{"slug":"butter","g":8}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY['steakpotato']::text[],'1. Vacumeer de biefstuk (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 54°C (1,5–4 u).
3. Dep droog en schroei rondom kort dicht in een gloeiend hete pan of met de brander, voor een korst.
4. Kook de zoete aardappel volgens de verpakking.
5. Stoom of wok de spinazie beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_steak_54_c_medium_rare_with_sweet_potato_zucchini','Biefstuk sous-vide 54°C (medium-rare) met zoete aardappel & courgette','Sous-vide steak 54°C (medium-rare) with sweet potato & zucchini',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"beef_steak","g":150},{"slug":"sweet_potato","g":200},{"slug":"zucchini","g":120},{"slug":"butter","g":8}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY['steakpotato']::text[],'1. Vacumeer de biefstuk (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 54°C (1,5–4 u).
3. Dep droog en schroei rondom kort dicht in een gloeiend hete pan of met de brander, voor een korst.
4. Kook de zoete aardappel volgens de verpakking.
5. Stoom of wok de courgette beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_steak_54_c_medium_rare_with_potato_broccoli','Biefstuk sous-vide 54°C (medium-rare) met aardappel & broccoli','Sous-vide steak 54°C (medium-rare) with potato & broccoli',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"beef_steak","g":150},{"slug":"potato","g":250},{"slug":"broccoli","g":120},{"slug":"butter","g":8}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY['steakpotato']::text[],'1. Vacumeer de biefstuk (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 54°C (1,5–4 u).
3. Dep droog en schroei rondom kort dicht in een gloeiend hete pan of met de brander, voor een korst.
4. Kook de aardappel volgens de verpakking.
5. Stoom of wok de broccoli beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_steak_54_c_medium_rare_with_potato_green_beans','Biefstuk sous-vide 54°C (medium-rare) met aardappel & sperziebonen','Sous-vide steak 54°C (medium-rare) with potato & green beans',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"beef_steak","g":150},{"slug":"potato","g":250},{"slug":"green_beans","g":120},{"slug":"butter","g":8}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY['steakpotato']::text[],'1. Vacumeer de biefstuk (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 54°C (1,5–4 u).
3. Dep droog en schroei rondom kort dicht in een gloeiend hete pan of met de brander, voor een korst.
4. Kook de aardappel volgens de verpakking.
5. Stoom of wok de sperziebonen beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_steak_54_c_medium_rare_with_potato_green_asparagus','Biefstuk sous-vide 54°C (medium-rare) met aardappel & groene asperges','Sous-vide steak 54°C (medium-rare) with potato & green asparagus',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"beef_steak","g":150},{"slug":"potato","g":250},{"slug":"asparagus","g":120},{"slug":"butter","g":8}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY['steakpotato']::text[],'1. Vacumeer de biefstuk (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 54°C (1,5–4 u).
3. Dep droog en schroei rondom kort dicht in een gloeiend hete pan of met de brander, voor een korst.
4. Kook de aardappel volgens de verpakking.
5. Stoom of wok de groene asperges beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_steak_54_c_medium_rare_with_potato_spinach','Biefstuk sous-vide 54°C (medium-rare) met aardappel & spinazie','Sous-vide steak 54°C (medium-rare) with potato & spinach',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"beef_steak","g":150},{"slug":"potato","g":250},{"slug":"spinach","g":100},{"slug":"butter","g":8}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY['steakpotato']::text[],'1. Vacumeer de biefstuk (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 54°C (1,5–4 u).
3. Dep droog en schroei rondom kort dicht in een gloeiend hete pan of met de brander, voor een korst.
4. Kook de aardappel volgens de verpakking.
5. Stoom of wok de spinazie beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_steak_54_c_medium_rare_with_potato_zucchini','Biefstuk sous-vide 54°C (medium-rare) met aardappel & courgette','Sous-vide steak 54°C (medium-rare) with potato & zucchini',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"beef_steak","g":150},{"slug":"potato","g":250},{"slug":"zucchini","g":120},{"slug":"butter","g":8}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY['steakpotato']::text[],'1. Vacumeer de biefstuk (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 54°C (1,5–4 u).
3. Dep droog en schroei rondom kort dicht in een gloeiend hete pan of met de brander, voor een korst.
4. Kook de aardappel volgens de verpakking.
5. Stoom of wok de courgette beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_steak_54_c_medium_rare_with_rice_broccoli','Biefstuk sous-vide 54°C (medium-rare) met rijst & broccoli','Sous-vide steak 54°C (medium-rare) with rice & broccoli',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"beef_steak","g":150},{"slug":"rice_dry","g":70},{"slug":"broccoli","g":120},{"slug":"butter","g":8}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY['steakpotato']::text[],'1. Vacumeer de biefstuk (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 54°C (1,5–4 u).
3. Dep droog en schroei rondom kort dicht in een gloeiend hete pan of met de brander, voor een korst.
4. Kook de rijst volgens de verpakking.
5. Stoom of wok de broccoli beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_steak_54_c_medium_rare_with_rice_green_beans','Biefstuk sous-vide 54°C (medium-rare) met rijst & sperziebonen','Sous-vide steak 54°C (medium-rare) with rice & green beans',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"beef_steak","g":150},{"slug":"rice_dry","g":70},{"slug":"green_beans","g":120},{"slug":"butter","g":8}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY['steakpotato']::text[],'1. Vacumeer de biefstuk (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 54°C (1,5–4 u).
3. Dep droog en schroei rondom kort dicht in een gloeiend hete pan of met de brander, voor een korst.
4. Kook de rijst volgens de verpakking.
5. Stoom of wok de sperziebonen beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_steak_54_c_medium_rare_with_rice_green_asparagus','Biefstuk sous-vide 54°C (medium-rare) met rijst & groene asperges','Sous-vide steak 54°C (medium-rare) with rice & green asparagus',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"beef_steak","g":150},{"slug":"rice_dry","g":70},{"slug":"asparagus","g":120},{"slug":"butter","g":8}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY['steakpotato']::text[],'1. Vacumeer de biefstuk (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 54°C (1,5–4 u).
3. Dep droog en schroei rondom kort dicht in een gloeiend hete pan of met de brander, voor een korst.
4. Kook de rijst volgens de verpakking.
5. Stoom of wok de groene asperges beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_steak_54_c_medium_rare_with_rice_spinach','Biefstuk sous-vide 54°C (medium-rare) met rijst & spinazie','Sous-vide steak 54°C (medium-rare) with rice & spinach',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"beef_steak","g":150},{"slug":"rice_dry","g":70},{"slug":"spinach","g":100},{"slug":"butter","g":8}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY['steakpotato']::text[],'1. Vacumeer de biefstuk (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 54°C (1,5–4 u).
3. Dep droog en schroei rondom kort dicht in een gloeiend hete pan of met de brander, voor een korst.
4. Kook de rijst volgens de verpakking.
5. Stoom of wok de spinazie beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_steak_54_c_medium_rare_with_rice_zucchini','Biefstuk sous-vide 54°C (medium-rare) met rijst & courgette','Sous-vide steak 54°C (medium-rare) with rice & zucchini',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"beef_steak","g":150},{"slug":"rice_dry","g":70},{"slug":"zucchini","g":120},{"slug":"butter","g":8}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY['steakpotato']::text[],'1. Vacumeer de biefstuk (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 54°C (1,5–4 u).
3. Dep droog en schroei rondom kort dicht in een gloeiend hete pan of met de brander, voor een korst.
4. Kook de rijst volgens de verpakking.
5. Stoom of wok de courgette beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_steak_54_c_medium_rare_with_quinoa_broccoli','Biefstuk sous-vide 54°C (medium-rare) met quinoa & broccoli','Sous-vide steak 54°C (medium-rare) with quinoa & broccoli',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"beef_steak","g":150},{"slug":"quinoa_dry","g":70},{"slug":"broccoli","g":120},{"slug":"butter","g":8}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY['steakpotato']::text[],'1. Vacumeer de biefstuk (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 54°C (1,5–4 u).
3. Dep droog en schroei rondom kort dicht in een gloeiend hete pan of met de brander, voor een korst.
4. Kook de quinoa volgens de verpakking.
5. Stoom of wok de broccoli beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_steak_54_c_medium_rare_with_quinoa_green_beans','Biefstuk sous-vide 54°C (medium-rare) met quinoa & sperziebonen','Sous-vide steak 54°C (medium-rare) with quinoa & green beans',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"beef_steak","g":150},{"slug":"quinoa_dry","g":70},{"slug":"green_beans","g":120},{"slug":"butter","g":8}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY['steakpotato']::text[],'1. Vacumeer de biefstuk (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 54°C (1,5–4 u).
3. Dep droog en schroei rondom kort dicht in een gloeiend hete pan of met de brander, voor een korst.
4. Kook de quinoa volgens de verpakking.
5. Stoom of wok de sperziebonen beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_steak_54_c_medium_rare_with_quinoa_green_asparagus','Biefstuk sous-vide 54°C (medium-rare) met quinoa & groene asperges','Sous-vide steak 54°C (medium-rare) with quinoa & green asparagus',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"beef_steak","g":150},{"slug":"quinoa_dry","g":70},{"slug":"asparagus","g":120},{"slug":"butter","g":8}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY['steakpotato']::text[],'1. Vacumeer de biefstuk (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 54°C (1,5–4 u).
3. Dep droog en schroei rondom kort dicht in een gloeiend hete pan of met de brander, voor een korst.
4. Kook de quinoa volgens de verpakking.
5. Stoom of wok de groene asperges beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_steak_54_c_medium_rare_with_quinoa_spinach','Biefstuk sous-vide 54°C (medium-rare) met quinoa & spinazie','Sous-vide steak 54°C (medium-rare) with quinoa & spinach',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"beef_steak","g":150},{"slug":"quinoa_dry","g":70},{"slug":"spinach","g":100},{"slug":"butter","g":8}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY['steakpotato']::text[],'1. Vacumeer de biefstuk (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 54°C (1,5–4 u).
3. Dep droog en schroei rondom kort dicht in een gloeiend hete pan of met de brander, voor een korst.
4. Kook de quinoa volgens de verpakking.
5. Stoom of wok de spinazie beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_steak_54_c_medium_rare_with_quinoa_zucchini','Biefstuk sous-vide 54°C (medium-rare) met quinoa & courgette','Sous-vide steak 54°C (medium-rare) with quinoa & zucchini',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"beef_steak","g":150},{"slug":"quinoa_dry","g":70},{"slug":"zucchini","g":120},{"slug":"butter","g":8}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY['steakpotato']::text[],'1. Vacumeer de biefstuk (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 54°C (1,5–4 u).
3. Dep droog en schroei rondom kort dicht in een gloeiend hete pan of met de brander, voor een korst.
4. Kook de quinoa volgens de verpakking.
5. Stoom of wok de courgette beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_flat_iron_steak_54_c_with_sweet_potato_broccoli','Flat iron steak sous-vide 54°C met zoete aardappel & broccoli','Sous-vide flat iron steak 54°C with sweet potato & broccoli',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"flat_iron","g":150},{"slug":"sweet_potato","g":200},{"slug":"broccoli","g":120},{"slug":"butter","g":8}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY['steakpotato']::text[],'1. Vacumeer de flat iron steak (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 54°C (1,5–4 u).
3. Dep droog en schroei rondom kort dicht in een gloeiend hete pan of met de brander, voor een korst.
4. Kook de zoete aardappel volgens de verpakking.
5. Stoom of wok de broccoli beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_flat_iron_steak_54_c_with_sweet_potato_green_beans','Flat iron steak sous-vide 54°C met zoete aardappel & sperziebonen','Sous-vide flat iron steak 54°C with sweet potato & green beans',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"flat_iron","g":150},{"slug":"sweet_potato","g":200},{"slug":"green_beans","g":120},{"slug":"butter","g":8}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY['steakpotato']::text[],'1. Vacumeer de flat iron steak (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 54°C (1,5–4 u).
3. Dep droog en schroei rondom kort dicht in een gloeiend hete pan of met de brander, voor een korst.
4. Kook de zoete aardappel volgens de verpakking.
5. Stoom of wok de sperziebonen beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_flat_iron_steak_54_c_with_sweet_potato_green_asparagus','Flat iron steak sous-vide 54°C met zoete aardappel & groene asperges','Sous-vide flat iron steak 54°C with sweet potato & green asparagus',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"flat_iron","g":150},{"slug":"sweet_potato","g":200},{"slug":"asparagus","g":120},{"slug":"butter","g":8}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY['steakpotato']::text[],'1. Vacumeer de flat iron steak (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 54°C (1,5–4 u).
3. Dep droog en schroei rondom kort dicht in een gloeiend hete pan of met de brander, voor een korst.
4. Kook de zoete aardappel volgens de verpakking.
5. Stoom of wok de groene asperges beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_flat_iron_steak_54_c_with_sweet_potato_spinach','Flat iron steak sous-vide 54°C met zoete aardappel & spinazie','Sous-vide flat iron steak 54°C with sweet potato & spinach',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"flat_iron","g":150},{"slug":"sweet_potato","g":200},{"slug":"spinach","g":100},{"slug":"butter","g":8}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY['steakpotato']::text[],'1. Vacumeer de flat iron steak (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 54°C (1,5–4 u).
3. Dep droog en schroei rondom kort dicht in een gloeiend hete pan of met de brander, voor een korst.
4. Kook de zoete aardappel volgens de verpakking.
5. Stoom of wok de spinazie beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_flat_iron_steak_54_c_with_sweet_potato_zucchini','Flat iron steak sous-vide 54°C met zoete aardappel & courgette','Sous-vide flat iron steak 54°C with sweet potato & zucchini',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"flat_iron","g":150},{"slug":"sweet_potato","g":200},{"slug":"zucchini","g":120},{"slug":"butter","g":8}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY['steakpotato']::text[],'1. Vacumeer de flat iron steak (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 54°C (1,5–4 u).
3. Dep droog en schroei rondom kort dicht in een gloeiend hete pan of met de brander, voor een korst.
4. Kook de zoete aardappel volgens de verpakking.
5. Stoom of wok de courgette beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_flat_iron_steak_54_c_with_potato_broccoli','Flat iron steak sous-vide 54°C met aardappel & broccoli','Sous-vide flat iron steak 54°C with potato & broccoli',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"flat_iron","g":150},{"slug":"potato","g":250},{"slug":"broccoli","g":120},{"slug":"butter","g":8}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY['steakpotato']::text[],'1. Vacumeer de flat iron steak (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 54°C (1,5–4 u).
3. Dep droog en schroei rondom kort dicht in een gloeiend hete pan of met de brander, voor een korst.
4. Kook de aardappel volgens de verpakking.
5. Stoom of wok de broccoli beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_flat_iron_steak_54_c_with_potato_green_beans','Flat iron steak sous-vide 54°C met aardappel & sperziebonen','Sous-vide flat iron steak 54°C with potato & green beans',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"flat_iron","g":150},{"slug":"potato","g":250},{"slug":"green_beans","g":120},{"slug":"butter","g":8}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY['steakpotato']::text[],'1. Vacumeer de flat iron steak (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 54°C (1,5–4 u).
3. Dep droog en schroei rondom kort dicht in een gloeiend hete pan of met de brander, voor een korst.
4. Kook de aardappel volgens de verpakking.
5. Stoom of wok de sperziebonen beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_flat_iron_steak_54_c_with_potato_green_asparagus','Flat iron steak sous-vide 54°C met aardappel & groene asperges','Sous-vide flat iron steak 54°C with potato & green asparagus',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"flat_iron","g":150},{"slug":"potato","g":250},{"slug":"asparagus","g":120},{"slug":"butter","g":8}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY['steakpotato']::text[],'1. Vacumeer de flat iron steak (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 54°C (1,5–4 u).
3. Dep droog en schroei rondom kort dicht in een gloeiend hete pan of met de brander, voor een korst.
4. Kook de aardappel volgens de verpakking.
5. Stoom of wok de groene asperges beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_flat_iron_steak_54_c_with_potato_spinach','Flat iron steak sous-vide 54°C met aardappel & spinazie','Sous-vide flat iron steak 54°C with potato & spinach',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"flat_iron","g":150},{"slug":"potato","g":250},{"slug":"spinach","g":100},{"slug":"butter","g":8}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY['steakpotato']::text[],'1. Vacumeer de flat iron steak (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 54°C (1,5–4 u).
3. Dep droog en schroei rondom kort dicht in een gloeiend hete pan of met de brander, voor een korst.
4. Kook de aardappel volgens de verpakking.
5. Stoom of wok de spinazie beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_flat_iron_steak_54_c_with_potato_zucchini','Flat iron steak sous-vide 54°C met aardappel & courgette','Sous-vide flat iron steak 54°C with potato & zucchini',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"flat_iron","g":150},{"slug":"potato","g":250},{"slug":"zucchini","g":120},{"slug":"butter","g":8}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY['steakpotato']::text[],'1. Vacumeer de flat iron steak (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 54°C (1,5–4 u).
3. Dep droog en schroei rondom kort dicht in een gloeiend hete pan of met de brander, voor een korst.
4. Kook de aardappel volgens de verpakking.
5. Stoom of wok de courgette beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_flat_iron_steak_54_c_with_rice_broccoli','Flat iron steak sous-vide 54°C met rijst & broccoli','Sous-vide flat iron steak 54°C with rice & broccoli',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"flat_iron","g":150},{"slug":"rice_dry","g":70},{"slug":"broccoli","g":120},{"slug":"butter","g":8}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY['steakpotato']::text[],'1. Vacumeer de flat iron steak (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 54°C (1,5–4 u).
3. Dep droog en schroei rondom kort dicht in een gloeiend hete pan of met de brander, voor een korst.
4. Kook de rijst volgens de verpakking.
5. Stoom of wok de broccoli beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_flat_iron_steak_54_c_with_rice_green_beans','Flat iron steak sous-vide 54°C met rijst & sperziebonen','Sous-vide flat iron steak 54°C with rice & green beans',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"flat_iron","g":150},{"slug":"rice_dry","g":70},{"slug":"green_beans","g":120},{"slug":"butter","g":8}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY['steakpotato']::text[],'1. Vacumeer de flat iron steak (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 54°C (1,5–4 u).
3. Dep droog en schroei rondom kort dicht in een gloeiend hete pan of met de brander, voor een korst.
4. Kook de rijst volgens de verpakking.
5. Stoom of wok de sperziebonen beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_flat_iron_steak_54_c_with_rice_green_asparagus','Flat iron steak sous-vide 54°C met rijst & groene asperges','Sous-vide flat iron steak 54°C with rice & green asparagus',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"flat_iron","g":150},{"slug":"rice_dry","g":70},{"slug":"asparagus","g":120},{"slug":"butter","g":8}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY['steakpotato']::text[],'1. Vacumeer de flat iron steak (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 54°C (1,5–4 u).
3. Dep droog en schroei rondom kort dicht in een gloeiend hete pan of met de brander, voor een korst.
4. Kook de rijst volgens de verpakking.
5. Stoom of wok de groene asperges beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_flat_iron_steak_54_c_with_rice_spinach','Flat iron steak sous-vide 54°C met rijst & spinazie','Sous-vide flat iron steak 54°C with rice & spinach',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"flat_iron","g":150},{"slug":"rice_dry","g":70},{"slug":"spinach","g":100},{"slug":"butter","g":8}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY['steakpotato']::text[],'1. Vacumeer de flat iron steak (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 54°C (1,5–4 u).
3. Dep droog en schroei rondom kort dicht in een gloeiend hete pan of met de brander, voor een korst.
4. Kook de rijst volgens de verpakking.
5. Stoom of wok de spinazie beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_flat_iron_steak_54_c_with_rice_zucchini','Flat iron steak sous-vide 54°C met rijst & courgette','Sous-vide flat iron steak 54°C with rice & zucchini',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"flat_iron","g":150},{"slug":"rice_dry","g":70},{"slug":"zucchini","g":120},{"slug":"butter","g":8}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY['steakpotato']::text[],'1. Vacumeer de flat iron steak (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 54°C (1,5–4 u).
3. Dep droog en schroei rondom kort dicht in een gloeiend hete pan of met de brander, voor een korst.
4. Kook de rijst volgens de verpakking.
5. Stoom of wok de courgette beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_flat_iron_steak_54_c_with_quinoa_broccoli','Flat iron steak sous-vide 54°C met quinoa & broccoli','Sous-vide flat iron steak 54°C with quinoa & broccoli',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"flat_iron","g":150},{"slug":"quinoa_dry","g":70},{"slug":"broccoli","g":120},{"slug":"butter","g":8}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY['steakpotato']::text[],'1. Vacumeer de flat iron steak (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 54°C (1,5–4 u).
3. Dep droog en schroei rondom kort dicht in een gloeiend hete pan of met de brander, voor een korst.
4. Kook de quinoa volgens de verpakking.
5. Stoom of wok de broccoli beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_flat_iron_steak_54_c_with_quinoa_green_beans','Flat iron steak sous-vide 54°C met quinoa & sperziebonen','Sous-vide flat iron steak 54°C with quinoa & green beans',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"flat_iron","g":150},{"slug":"quinoa_dry","g":70},{"slug":"green_beans","g":120},{"slug":"butter","g":8}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY['steakpotato']::text[],'1. Vacumeer de flat iron steak (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 54°C (1,5–4 u).
3. Dep droog en schroei rondom kort dicht in een gloeiend hete pan of met de brander, voor een korst.
4. Kook de quinoa volgens de verpakking.
5. Stoom of wok de sperziebonen beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_flat_iron_steak_54_c_with_quinoa_green_asparagus','Flat iron steak sous-vide 54°C met quinoa & groene asperges','Sous-vide flat iron steak 54°C with quinoa & green asparagus',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"flat_iron","g":150},{"slug":"quinoa_dry","g":70},{"slug":"asparagus","g":120},{"slug":"butter","g":8}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY['steakpotato']::text[],'1. Vacumeer de flat iron steak (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 54°C (1,5–4 u).
3. Dep droog en schroei rondom kort dicht in een gloeiend hete pan of met de brander, voor een korst.
4. Kook de quinoa volgens de verpakking.
5. Stoom of wok de groene asperges beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_flat_iron_steak_54_c_with_quinoa_spinach','Flat iron steak sous-vide 54°C met quinoa & spinazie','Sous-vide flat iron steak 54°C with quinoa & spinach',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"flat_iron","g":150},{"slug":"quinoa_dry","g":70},{"slug":"spinach","g":100},{"slug":"butter","g":8}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY['steakpotato']::text[],'1. Vacumeer de flat iron steak (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 54°C (1,5–4 u).
3. Dep droog en schroei rondom kort dicht in een gloeiend hete pan of met de brander, voor een korst.
4. Kook de quinoa volgens de verpakking.
5. Stoom of wok de spinazie beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_flat_iron_steak_54_c_with_quinoa_zucchini','Flat iron steak sous-vide 54°C met quinoa & courgette','Sous-vide flat iron steak 54°C with quinoa & zucchini',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"flat_iron","g":150},{"slug":"quinoa_dry","g":70},{"slug":"zucchini","g":120},{"slug":"butter","g":8}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY['steakpotato']::text[],'1. Vacumeer de flat iron steak (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 54°C (1,5–4 u).
3. Dep droog en schroei rondom kort dicht in een gloeiend hete pan of met de brander, voor een korst.
4. Kook de quinoa volgens de verpakking.
5. Stoom of wok de courgette beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_lamb_fillet_54_c_with_sweet_potato_broccoli','Lamsfilet sous-vide 54°C met zoete aardappel & broccoli','Sous-vide lamb fillet 54°C with sweet potato & broccoli',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"lamb_fillet","g":150},{"slug":"sweet_potato","g":200},{"slug":"broccoli","g":120},{"slug":"butter","g":8}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY[]::text[],'1. Vacumeer de lamsfilet (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 54°C (1,5–3 u).
3. Dep droog en schroei rondom kort dicht in een gloeiend hete pan of met de brander, voor een korst.
4. Kook de zoete aardappel volgens de verpakking.
5. Stoom of wok de broccoli beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_lamb_fillet_54_c_with_sweet_potato_green_beans','Lamsfilet sous-vide 54°C met zoete aardappel & sperziebonen','Sous-vide lamb fillet 54°C with sweet potato & green beans',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"lamb_fillet","g":150},{"slug":"sweet_potato","g":200},{"slug":"green_beans","g":120},{"slug":"butter","g":8}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY[]::text[],'1. Vacumeer de lamsfilet (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 54°C (1,5–3 u).
3. Dep droog en schroei rondom kort dicht in een gloeiend hete pan of met de brander, voor een korst.
4. Kook de zoete aardappel volgens de verpakking.
5. Stoom of wok de sperziebonen beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_lamb_fillet_54_c_with_sweet_potato_green_asparagus','Lamsfilet sous-vide 54°C met zoete aardappel & groene asperges','Sous-vide lamb fillet 54°C with sweet potato & green asparagus',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"lamb_fillet","g":150},{"slug":"sweet_potato","g":200},{"slug":"asparagus","g":120},{"slug":"butter","g":8}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY[]::text[],'1. Vacumeer de lamsfilet (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 54°C (1,5–3 u).
3. Dep droog en schroei rondom kort dicht in een gloeiend hete pan of met de brander, voor een korst.
4. Kook de zoete aardappel volgens de verpakking.
5. Stoom of wok de groene asperges beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_lamb_fillet_54_c_with_sweet_potato_spinach','Lamsfilet sous-vide 54°C met zoete aardappel & spinazie','Sous-vide lamb fillet 54°C with sweet potato & spinach',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"lamb_fillet","g":150},{"slug":"sweet_potato","g":200},{"slug":"spinach","g":100},{"slug":"butter","g":8}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY[]::text[],'1. Vacumeer de lamsfilet (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 54°C (1,5–3 u).
3. Dep droog en schroei rondom kort dicht in een gloeiend hete pan of met de brander, voor een korst.
4. Kook de zoete aardappel volgens de verpakking.
5. Stoom of wok de spinazie beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_lamb_fillet_54_c_with_sweet_potato_zucchini','Lamsfilet sous-vide 54°C met zoete aardappel & courgette','Sous-vide lamb fillet 54°C with sweet potato & zucchini',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"lamb_fillet","g":150},{"slug":"sweet_potato","g":200},{"slug":"zucchini","g":120},{"slug":"butter","g":8}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY[]::text[],'1. Vacumeer de lamsfilet (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 54°C (1,5–3 u).
3. Dep droog en schroei rondom kort dicht in een gloeiend hete pan of met de brander, voor een korst.
4. Kook de zoete aardappel volgens de verpakking.
5. Stoom of wok de courgette beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_lamb_fillet_54_c_with_potato_broccoli','Lamsfilet sous-vide 54°C met aardappel & broccoli','Sous-vide lamb fillet 54°C with potato & broccoli',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"lamb_fillet","g":150},{"slug":"potato","g":250},{"slug":"broccoli","g":120},{"slug":"butter","g":8}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY[]::text[],'1. Vacumeer de lamsfilet (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 54°C (1,5–3 u).
3. Dep droog en schroei rondom kort dicht in een gloeiend hete pan of met de brander, voor een korst.
4. Kook de aardappel volgens de verpakking.
5. Stoom of wok de broccoli beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_lamb_fillet_54_c_with_potato_green_beans','Lamsfilet sous-vide 54°C met aardappel & sperziebonen','Sous-vide lamb fillet 54°C with potato & green beans',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"lamb_fillet","g":150},{"slug":"potato","g":250},{"slug":"green_beans","g":120},{"slug":"butter","g":8}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY[]::text[],'1. Vacumeer de lamsfilet (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 54°C (1,5–3 u).
3. Dep droog en schroei rondom kort dicht in een gloeiend hete pan of met de brander, voor een korst.
4. Kook de aardappel volgens de verpakking.
5. Stoom of wok de sperziebonen beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_lamb_fillet_54_c_with_potato_green_asparagus','Lamsfilet sous-vide 54°C met aardappel & groene asperges','Sous-vide lamb fillet 54°C with potato & green asparagus',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"lamb_fillet","g":150},{"slug":"potato","g":250},{"slug":"asparagus","g":120},{"slug":"butter","g":8}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY[]::text[],'1. Vacumeer de lamsfilet (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 54°C (1,5–3 u).
3. Dep droog en schroei rondom kort dicht in een gloeiend hete pan of met de brander, voor een korst.
4. Kook de aardappel volgens de verpakking.
5. Stoom of wok de groene asperges beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_lamb_fillet_54_c_with_potato_spinach','Lamsfilet sous-vide 54°C met aardappel & spinazie','Sous-vide lamb fillet 54°C with potato & spinach',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"lamb_fillet","g":150},{"slug":"potato","g":250},{"slug":"spinach","g":100},{"slug":"butter","g":8}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY[]::text[],'1. Vacumeer de lamsfilet (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 54°C (1,5–3 u).
3. Dep droog en schroei rondom kort dicht in een gloeiend hete pan of met de brander, voor een korst.
4. Kook de aardappel volgens de verpakking.
5. Stoom of wok de spinazie beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_lamb_fillet_54_c_with_potato_zucchini','Lamsfilet sous-vide 54°C met aardappel & courgette','Sous-vide lamb fillet 54°C with potato & zucchini',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"lamb_fillet","g":150},{"slug":"potato","g":250},{"slug":"zucchini","g":120},{"slug":"butter","g":8}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY[]::text[],'1. Vacumeer de lamsfilet (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 54°C (1,5–3 u).
3. Dep droog en schroei rondom kort dicht in een gloeiend hete pan of met de brander, voor een korst.
4. Kook de aardappel volgens de verpakking.
5. Stoom of wok de courgette beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_lamb_fillet_54_c_with_rice_broccoli','Lamsfilet sous-vide 54°C met rijst & broccoli','Sous-vide lamb fillet 54°C with rice & broccoli',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"lamb_fillet","g":150},{"slug":"rice_dry","g":70},{"slug":"broccoli","g":120},{"slug":"butter","g":8}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY[]::text[],'1. Vacumeer de lamsfilet (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 54°C (1,5–3 u).
3. Dep droog en schroei rondom kort dicht in een gloeiend hete pan of met de brander, voor een korst.
4. Kook de rijst volgens de verpakking.
5. Stoom of wok de broccoli beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_lamb_fillet_54_c_with_rice_green_beans','Lamsfilet sous-vide 54°C met rijst & sperziebonen','Sous-vide lamb fillet 54°C with rice & green beans',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"lamb_fillet","g":150},{"slug":"rice_dry","g":70},{"slug":"green_beans","g":120},{"slug":"butter","g":8}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY[]::text[],'1. Vacumeer de lamsfilet (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 54°C (1,5–3 u).
3. Dep droog en schroei rondom kort dicht in een gloeiend hete pan of met de brander, voor een korst.
4. Kook de rijst volgens de verpakking.
5. Stoom of wok de sperziebonen beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_lamb_fillet_54_c_with_rice_green_asparagus','Lamsfilet sous-vide 54°C met rijst & groene asperges','Sous-vide lamb fillet 54°C with rice & green asparagus',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"lamb_fillet","g":150},{"slug":"rice_dry","g":70},{"slug":"asparagus","g":120},{"slug":"butter","g":8}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY[]::text[],'1. Vacumeer de lamsfilet (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 54°C (1,5–3 u).
3. Dep droog en schroei rondom kort dicht in een gloeiend hete pan of met de brander, voor een korst.
4. Kook de rijst volgens de verpakking.
5. Stoom of wok de groene asperges beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_lamb_fillet_54_c_with_rice_spinach','Lamsfilet sous-vide 54°C met rijst & spinazie','Sous-vide lamb fillet 54°C with rice & spinach',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"lamb_fillet","g":150},{"slug":"rice_dry","g":70},{"slug":"spinach","g":100},{"slug":"butter","g":8}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY[]::text[],'1. Vacumeer de lamsfilet (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 54°C (1,5–3 u).
3. Dep droog en schroei rondom kort dicht in een gloeiend hete pan of met de brander, voor een korst.
4. Kook de rijst volgens de verpakking.
5. Stoom of wok de spinazie beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_lamb_fillet_54_c_with_rice_zucchini','Lamsfilet sous-vide 54°C met rijst & courgette','Sous-vide lamb fillet 54°C with rice & zucchini',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"lamb_fillet","g":150},{"slug":"rice_dry","g":70},{"slug":"zucchini","g":120},{"slug":"butter","g":8}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY[]::text[],'1. Vacumeer de lamsfilet (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 54°C (1,5–3 u).
3. Dep droog en schroei rondom kort dicht in een gloeiend hete pan of met de brander, voor een korst.
4. Kook de rijst volgens de verpakking.
5. Stoom of wok de courgette beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_lamb_fillet_54_c_with_quinoa_broccoli','Lamsfilet sous-vide 54°C met quinoa & broccoli','Sous-vide lamb fillet 54°C with quinoa & broccoli',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"lamb_fillet","g":150},{"slug":"quinoa_dry","g":70},{"slug":"broccoli","g":120},{"slug":"butter","g":8}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY[]::text[],'1. Vacumeer de lamsfilet (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 54°C (1,5–3 u).
3. Dep droog en schroei rondom kort dicht in een gloeiend hete pan of met de brander, voor een korst.
4. Kook de quinoa volgens de verpakking.
5. Stoom of wok de broccoli beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_lamb_fillet_54_c_with_quinoa_green_beans','Lamsfilet sous-vide 54°C met quinoa & sperziebonen','Sous-vide lamb fillet 54°C with quinoa & green beans',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"lamb_fillet","g":150},{"slug":"quinoa_dry","g":70},{"slug":"green_beans","g":120},{"slug":"butter","g":8}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY[]::text[],'1. Vacumeer de lamsfilet (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 54°C (1,5–3 u).
3. Dep droog en schroei rondom kort dicht in een gloeiend hete pan of met de brander, voor een korst.
4. Kook de quinoa volgens de verpakking.
5. Stoom of wok de sperziebonen beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_lamb_fillet_54_c_with_quinoa_green_asparagus','Lamsfilet sous-vide 54°C met quinoa & groene asperges','Sous-vide lamb fillet 54°C with quinoa & green asparagus',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"lamb_fillet","g":150},{"slug":"quinoa_dry","g":70},{"slug":"asparagus","g":120},{"slug":"butter","g":8}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY[]::text[],'1. Vacumeer de lamsfilet (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 54°C (1,5–3 u).
3. Dep droog en schroei rondom kort dicht in een gloeiend hete pan of met de brander, voor een korst.
4. Kook de quinoa volgens de verpakking.
5. Stoom of wok de groene asperges beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_lamb_fillet_54_c_with_quinoa_spinach','Lamsfilet sous-vide 54°C met quinoa & spinazie','Sous-vide lamb fillet 54°C with quinoa & spinach',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"lamb_fillet","g":150},{"slug":"quinoa_dry","g":70},{"slug":"spinach","g":100},{"slug":"butter","g":8}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY[]::text[],'1. Vacumeer de lamsfilet (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 54°C (1,5–3 u).
3. Dep droog en schroei rondom kort dicht in een gloeiend hete pan of met de brander, voor een korst.
4. Kook de quinoa volgens de verpakking.
5. Stoom of wok de spinazie beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_lamb_fillet_54_c_with_quinoa_zucchini','Lamsfilet sous-vide 54°C met quinoa & courgette','Sous-vide lamb fillet 54°C with quinoa & zucchini',ARRAY['dinner','lunch'],ARRAY['cut','gain','maintain'],'[{"slug":"lamb_fillet","g":150},{"slug":"quinoa_dry","g":70},{"slug":"zucchini","g":120},{"slug":"butter","g":8}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY[]::text[],'1. Vacumeer de lamsfilet (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 54°C (1,5–3 u).
3. Dep droog en schroei rondom kort dicht in een gloeiend hete pan of met de brander, voor een korst.
4. Kook de quinoa volgens de verpakking.
5. Stoom of wok de courgette beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_pork_tenderloin_58_c_with_sweet_potato_broccoli','Varkenshaas sous-vide 58°C met zoete aardappel & broccoli','Sous-vide pork tenderloin 58°C with sweet potato & broccoli',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"pork_tenderloin","g":150},{"slug":"sweet_potato","g":200},{"slug":"broccoli","g":120},{"slug":"butter","g":8}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY[]::text[],'1. Vacumeer de varkenshaas (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 58°C (1–4 u).
3. Dep droog en schroei rondom kort dicht in een gloeiend hete pan of met de brander, voor een korst.
4. Kook de zoete aardappel volgens de verpakking.
5. Stoom of wok de broccoli beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_pork_tenderloin_58_c_with_sweet_potato_green_beans','Varkenshaas sous-vide 58°C met zoete aardappel & sperziebonen','Sous-vide pork tenderloin 58°C with sweet potato & green beans',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"pork_tenderloin","g":150},{"slug":"sweet_potato","g":200},{"slug":"green_beans","g":120},{"slug":"butter","g":8}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY[]::text[],'1. Vacumeer de varkenshaas (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 58°C (1–4 u).
3. Dep droog en schroei rondom kort dicht in een gloeiend hete pan of met de brander, voor een korst.
4. Kook de zoete aardappel volgens de verpakking.
5. Stoom of wok de sperziebonen beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_pork_tenderloin_58_c_with_sweet_potato_green_asparagus','Varkenshaas sous-vide 58°C met zoete aardappel & groene asperges','Sous-vide pork tenderloin 58°C with sweet potato & green asparagus',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"pork_tenderloin","g":150},{"slug":"sweet_potato","g":200},{"slug":"asparagus","g":120},{"slug":"butter","g":8}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY[]::text[],'1. Vacumeer de varkenshaas (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 58°C (1–4 u).
3. Dep droog en schroei rondom kort dicht in een gloeiend hete pan of met de brander, voor een korst.
4. Kook de zoete aardappel volgens de verpakking.
5. Stoom of wok de groene asperges beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_pork_tenderloin_58_c_with_sweet_potato_spinach','Varkenshaas sous-vide 58°C met zoete aardappel & spinazie','Sous-vide pork tenderloin 58°C with sweet potato & spinach',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"pork_tenderloin","g":150},{"slug":"sweet_potato","g":200},{"slug":"spinach","g":100},{"slug":"butter","g":8}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY[]::text[],'1. Vacumeer de varkenshaas (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 58°C (1–4 u).
3. Dep droog en schroei rondom kort dicht in een gloeiend hete pan of met de brander, voor een korst.
4. Kook de zoete aardappel volgens de verpakking.
5. Stoom of wok de spinazie beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_pork_tenderloin_58_c_with_sweet_potato_zucchini','Varkenshaas sous-vide 58°C met zoete aardappel & courgette','Sous-vide pork tenderloin 58°C with sweet potato & zucchini',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"pork_tenderloin","g":150},{"slug":"sweet_potato","g":200},{"slug":"zucchini","g":120},{"slug":"butter","g":8}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY[]::text[],'1. Vacumeer de varkenshaas (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 58°C (1–4 u).
3. Dep droog en schroei rondom kort dicht in een gloeiend hete pan of met de brander, voor een korst.
4. Kook de zoete aardappel volgens de verpakking.
5. Stoom of wok de courgette beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_pork_tenderloin_58_c_with_potato_broccoli','Varkenshaas sous-vide 58°C met aardappel & broccoli','Sous-vide pork tenderloin 58°C with potato & broccoli',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"pork_tenderloin","g":150},{"slug":"potato","g":250},{"slug":"broccoli","g":120},{"slug":"butter","g":8}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY[]::text[],'1. Vacumeer de varkenshaas (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 58°C (1–4 u).
3. Dep droog en schroei rondom kort dicht in een gloeiend hete pan of met de brander, voor een korst.
4. Kook de aardappel volgens de verpakking.
5. Stoom of wok de broccoli beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_pork_tenderloin_58_c_with_potato_green_beans','Varkenshaas sous-vide 58°C met aardappel & sperziebonen','Sous-vide pork tenderloin 58°C with potato & green beans',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"pork_tenderloin","g":150},{"slug":"potato","g":250},{"slug":"green_beans","g":120},{"slug":"butter","g":8}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY[]::text[],'1. Vacumeer de varkenshaas (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 58°C (1–4 u).
3. Dep droog en schroei rondom kort dicht in een gloeiend hete pan of met de brander, voor een korst.
4. Kook de aardappel volgens de verpakking.
5. Stoom of wok de sperziebonen beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_pork_tenderloin_58_c_with_potato_green_asparagus','Varkenshaas sous-vide 58°C met aardappel & groene asperges','Sous-vide pork tenderloin 58°C with potato & green asparagus',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"pork_tenderloin","g":150},{"slug":"potato","g":250},{"slug":"asparagus","g":120},{"slug":"butter","g":8}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY[]::text[],'1. Vacumeer de varkenshaas (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 58°C (1–4 u).
3. Dep droog en schroei rondom kort dicht in een gloeiend hete pan of met de brander, voor een korst.
4. Kook de aardappel volgens de verpakking.
5. Stoom of wok de groene asperges beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_pork_tenderloin_58_c_with_potato_spinach','Varkenshaas sous-vide 58°C met aardappel & spinazie','Sous-vide pork tenderloin 58°C with potato & spinach',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"pork_tenderloin","g":150},{"slug":"potato","g":250},{"slug":"spinach","g":100},{"slug":"butter","g":8}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY[]::text[],'1. Vacumeer de varkenshaas (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 58°C (1–4 u).
3. Dep droog en schroei rondom kort dicht in een gloeiend hete pan of met de brander, voor een korst.
4. Kook de aardappel volgens de verpakking.
5. Stoom of wok de spinazie beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_pork_tenderloin_58_c_with_potato_zucchini','Varkenshaas sous-vide 58°C met aardappel & courgette','Sous-vide pork tenderloin 58°C with potato & zucchini',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"pork_tenderloin","g":150},{"slug":"potato","g":250},{"slug":"zucchini","g":120},{"slug":"butter","g":8}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY[]::text[],'1. Vacumeer de varkenshaas (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 58°C (1–4 u).
3. Dep droog en schroei rondom kort dicht in een gloeiend hete pan of met de brander, voor een korst.
4. Kook de aardappel volgens de verpakking.
5. Stoom of wok de courgette beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_pork_tenderloin_58_c_with_rice_broccoli','Varkenshaas sous-vide 58°C met rijst & broccoli','Sous-vide pork tenderloin 58°C with rice & broccoli',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"pork_tenderloin","g":150},{"slug":"rice_dry","g":70},{"slug":"broccoli","g":120},{"slug":"butter","g":8}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY[]::text[],'1. Vacumeer de varkenshaas (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 58°C (1–4 u).
3. Dep droog en schroei rondom kort dicht in een gloeiend hete pan of met de brander, voor een korst.
4. Kook de rijst volgens de verpakking.
5. Stoom of wok de broccoli beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_pork_tenderloin_58_c_with_rice_green_beans','Varkenshaas sous-vide 58°C met rijst & sperziebonen','Sous-vide pork tenderloin 58°C with rice & green beans',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"pork_tenderloin","g":150},{"slug":"rice_dry","g":70},{"slug":"green_beans","g":120},{"slug":"butter","g":8}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY[]::text[],'1. Vacumeer de varkenshaas (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 58°C (1–4 u).
3. Dep droog en schroei rondom kort dicht in een gloeiend hete pan of met de brander, voor een korst.
4. Kook de rijst volgens de verpakking.
5. Stoom of wok de sperziebonen beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_pork_tenderloin_58_c_with_rice_green_asparagus','Varkenshaas sous-vide 58°C met rijst & groene asperges','Sous-vide pork tenderloin 58°C with rice & green asparagus',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"pork_tenderloin","g":150},{"slug":"rice_dry","g":70},{"slug":"asparagus","g":120},{"slug":"butter","g":8}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY[]::text[],'1. Vacumeer de varkenshaas (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 58°C (1–4 u).
3. Dep droog en schroei rondom kort dicht in een gloeiend hete pan of met de brander, voor een korst.
4. Kook de rijst volgens de verpakking.
5. Stoom of wok de groene asperges beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_pork_tenderloin_58_c_with_rice_spinach','Varkenshaas sous-vide 58°C met rijst & spinazie','Sous-vide pork tenderloin 58°C with rice & spinach',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"pork_tenderloin","g":150},{"slug":"rice_dry","g":70},{"slug":"spinach","g":100},{"slug":"butter","g":8}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY[]::text[],'1. Vacumeer de varkenshaas (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 58°C (1–4 u).
3. Dep droog en schroei rondom kort dicht in een gloeiend hete pan of met de brander, voor een korst.
4. Kook de rijst volgens de verpakking.
5. Stoom of wok de spinazie beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_pork_tenderloin_58_c_with_rice_zucchini','Varkenshaas sous-vide 58°C met rijst & courgette','Sous-vide pork tenderloin 58°C with rice & zucchini',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"pork_tenderloin","g":150},{"slug":"rice_dry","g":70},{"slug":"zucchini","g":120},{"slug":"butter","g":8}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY[]::text[],'1. Vacumeer de varkenshaas (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 58°C (1–4 u).
3. Dep droog en schroei rondom kort dicht in een gloeiend hete pan of met de brander, voor een korst.
4. Kook de rijst volgens de verpakking.
5. Stoom of wok de courgette beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_pork_tenderloin_58_c_with_quinoa_broccoli','Varkenshaas sous-vide 58°C met quinoa & broccoli','Sous-vide pork tenderloin 58°C with quinoa & broccoli',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"pork_tenderloin","g":150},{"slug":"quinoa_dry","g":70},{"slug":"broccoli","g":120},{"slug":"butter","g":8}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY[]::text[],'1. Vacumeer de varkenshaas (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 58°C (1–4 u).
3. Dep droog en schroei rondom kort dicht in een gloeiend hete pan of met de brander, voor een korst.
4. Kook de quinoa volgens de verpakking.
5. Stoom of wok de broccoli beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_pork_tenderloin_58_c_with_quinoa_green_beans','Varkenshaas sous-vide 58°C met quinoa & sperziebonen','Sous-vide pork tenderloin 58°C with quinoa & green beans',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"pork_tenderloin","g":150},{"slug":"quinoa_dry","g":70},{"slug":"green_beans","g":120},{"slug":"butter","g":8}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY[]::text[],'1. Vacumeer de varkenshaas (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 58°C (1–4 u).
3. Dep droog en schroei rondom kort dicht in een gloeiend hete pan of met de brander, voor een korst.
4. Kook de quinoa volgens de verpakking.
5. Stoom of wok de sperziebonen beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_pork_tenderloin_58_c_with_quinoa_green_asparagus','Varkenshaas sous-vide 58°C met quinoa & groene asperges','Sous-vide pork tenderloin 58°C with quinoa & green asparagus',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"pork_tenderloin","g":150},{"slug":"quinoa_dry","g":70},{"slug":"asparagus","g":120},{"slug":"butter","g":8}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY[]::text[],'1. Vacumeer de varkenshaas (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 58°C (1–4 u).
3. Dep droog en schroei rondom kort dicht in een gloeiend hete pan of met de brander, voor een korst.
4. Kook de quinoa volgens de verpakking.
5. Stoom of wok de groene asperges beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_pork_tenderloin_58_c_with_quinoa_spinach','Varkenshaas sous-vide 58°C met quinoa & spinazie','Sous-vide pork tenderloin 58°C with quinoa & spinach',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"pork_tenderloin","g":150},{"slug":"quinoa_dry","g":70},{"slug":"spinach","g":100},{"slug":"butter","g":8}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY[]::text[],'1. Vacumeer de varkenshaas (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 58°C (1–4 u).
3. Dep droog en schroei rondom kort dicht in een gloeiend hete pan of met de brander, voor een korst.
4. Kook de quinoa volgens de verpakking.
5. Stoom of wok de spinazie beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_pork_tenderloin_58_c_with_quinoa_zucchini','Varkenshaas sous-vide 58°C met quinoa & courgette','Sous-vide pork tenderloin 58°C with quinoa & zucchini',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"pork_tenderloin","g":150},{"slug":"quinoa_dry","g":70},{"slug":"zucchini","g":120},{"slug":"butter","g":8}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY[]::text[],'1. Vacumeer de varkenshaas (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 58°C (1–4 u).
3. Dep droog en schroei rondom kort dicht in een gloeiend hete pan of met de brander, voor een korst.
4. Kook de quinoa volgens de verpakking.
5. Stoom of wok de courgette beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_duck_breast_56_c_with_sweet_potato_broccoli','Eendenborst sous-vide 56°C met zoete aardappel & broccoli','Sous-vide duck breast 56°C with sweet potato & broccoli',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"duck_breast","g":140},{"slug":"sweet_potato","g":200},{"slug":"broccoli","g":120},{"slug":"butter","g":8}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY[]::text[],'1. Vacumeer de eendenborst (zonder vel) (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 56°C (1,5–3 u).
3. Dep droog en schroei rondom kort dicht in een gloeiend hete pan of met de brander, voor een korst.
4. Kook de zoete aardappel volgens de verpakking.
5. Stoom of wok de broccoli beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_duck_breast_56_c_with_sweet_potato_green_beans','Eendenborst sous-vide 56°C met zoete aardappel & sperziebonen','Sous-vide duck breast 56°C with sweet potato & green beans',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"duck_breast","g":140},{"slug":"sweet_potato","g":200},{"slug":"green_beans","g":120},{"slug":"butter","g":8}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY[]::text[],'1. Vacumeer de eendenborst (zonder vel) (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 56°C (1,5–3 u).
3. Dep droog en schroei rondom kort dicht in een gloeiend hete pan of met de brander, voor een korst.
4. Kook de zoete aardappel volgens de verpakking.
5. Stoom of wok de sperziebonen beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_duck_breast_56_c_with_sweet_potato_green_asparagus','Eendenborst sous-vide 56°C met zoete aardappel & groene asperges','Sous-vide duck breast 56°C with sweet potato & green asparagus',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"duck_breast","g":140},{"slug":"sweet_potato","g":200},{"slug":"asparagus","g":120},{"slug":"butter","g":8}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY[]::text[],'1. Vacumeer de eendenborst (zonder vel) (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 56°C (1,5–3 u).
3. Dep droog en schroei rondom kort dicht in een gloeiend hete pan of met de brander, voor een korst.
4. Kook de zoete aardappel volgens de verpakking.
5. Stoom of wok de groene asperges beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_duck_breast_56_c_with_sweet_potato_spinach','Eendenborst sous-vide 56°C met zoete aardappel & spinazie','Sous-vide duck breast 56°C with sweet potato & spinach',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"duck_breast","g":140},{"slug":"sweet_potato","g":200},{"slug":"spinach","g":100},{"slug":"butter","g":8}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY[]::text[],'1. Vacumeer de eendenborst (zonder vel) (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 56°C (1,5–3 u).
3. Dep droog en schroei rondom kort dicht in een gloeiend hete pan of met de brander, voor een korst.
4. Kook de zoete aardappel volgens de verpakking.
5. Stoom of wok de spinazie beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_duck_breast_56_c_with_sweet_potato_zucchini','Eendenborst sous-vide 56°C met zoete aardappel & courgette','Sous-vide duck breast 56°C with sweet potato & zucchini',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"duck_breast","g":140},{"slug":"sweet_potato","g":200},{"slug":"zucchini","g":120},{"slug":"butter","g":8}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY[]::text[],'1. Vacumeer de eendenborst (zonder vel) (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 56°C (1,5–3 u).
3. Dep droog en schroei rondom kort dicht in een gloeiend hete pan of met de brander, voor een korst.
4. Kook de zoete aardappel volgens de verpakking.
5. Stoom of wok de courgette beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_duck_breast_56_c_with_potato_broccoli','Eendenborst sous-vide 56°C met aardappel & broccoli','Sous-vide duck breast 56°C with potato & broccoli',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"duck_breast","g":140},{"slug":"potato","g":250},{"slug":"broccoli","g":120},{"slug":"butter","g":8}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY[]::text[],'1. Vacumeer de eendenborst (zonder vel) (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 56°C (1,5–3 u).
3. Dep droog en schroei rondom kort dicht in een gloeiend hete pan of met de brander, voor een korst.
4. Kook de aardappel volgens de verpakking.
5. Stoom of wok de broccoli beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_duck_breast_56_c_with_potato_green_beans','Eendenborst sous-vide 56°C met aardappel & sperziebonen','Sous-vide duck breast 56°C with potato & green beans',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"duck_breast","g":140},{"slug":"potato","g":250},{"slug":"green_beans","g":120},{"slug":"butter","g":8}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY[]::text[],'1. Vacumeer de eendenborst (zonder vel) (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 56°C (1,5–3 u).
3. Dep droog en schroei rondom kort dicht in een gloeiend hete pan of met de brander, voor een korst.
4. Kook de aardappel volgens de verpakking.
5. Stoom of wok de sperziebonen beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_duck_breast_56_c_with_potato_green_asparagus','Eendenborst sous-vide 56°C met aardappel & groene asperges','Sous-vide duck breast 56°C with potato & green asparagus',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"duck_breast","g":140},{"slug":"potato","g":250},{"slug":"asparagus","g":120},{"slug":"butter","g":8}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY[]::text[],'1. Vacumeer de eendenborst (zonder vel) (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 56°C (1,5–3 u).
3. Dep droog en schroei rondom kort dicht in een gloeiend hete pan of met de brander, voor een korst.
4. Kook de aardappel volgens de verpakking.
5. Stoom of wok de groene asperges beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_duck_breast_56_c_with_potato_spinach','Eendenborst sous-vide 56°C met aardappel & spinazie','Sous-vide duck breast 56°C with potato & spinach',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"duck_breast","g":140},{"slug":"potato","g":250},{"slug":"spinach","g":100},{"slug":"butter","g":8}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY[]::text[],'1. Vacumeer de eendenborst (zonder vel) (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 56°C (1,5–3 u).
3. Dep droog en schroei rondom kort dicht in een gloeiend hete pan of met de brander, voor een korst.
4. Kook de aardappel volgens de verpakking.
5. Stoom of wok de spinazie beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_duck_breast_56_c_with_potato_zucchini','Eendenborst sous-vide 56°C met aardappel & courgette','Sous-vide duck breast 56°C with potato & zucchini',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"duck_breast","g":140},{"slug":"potato","g":250},{"slug":"zucchini","g":120},{"slug":"butter","g":8}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY[]::text[],'1. Vacumeer de eendenborst (zonder vel) (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 56°C (1,5–3 u).
3. Dep droog en schroei rondom kort dicht in een gloeiend hete pan of met de brander, voor een korst.
4. Kook de aardappel volgens de verpakking.
5. Stoom of wok de courgette beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_duck_breast_56_c_with_rice_broccoli','Eendenborst sous-vide 56°C met rijst & broccoli','Sous-vide duck breast 56°C with rice & broccoli',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"duck_breast","g":140},{"slug":"rice_dry","g":70},{"slug":"broccoli","g":120},{"slug":"butter","g":8}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY[]::text[],'1. Vacumeer de eendenborst (zonder vel) (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 56°C (1,5–3 u).
3. Dep droog en schroei rondom kort dicht in een gloeiend hete pan of met de brander, voor een korst.
4. Kook de rijst volgens de verpakking.
5. Stoom of wok de broccoli beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_duck_breast_56_c_with_rice_green_beans','Eendenborst sous-vide 56°C met rijst & sperziebonen','Sous-vide duck breast 56°C with rice & green beans',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"duck_breast","g":140},{"slug":"rice_dry","g":70},{"slug":"green_beans","g":120},{"slug":"butter","g":8}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY[]::text[],'1. Vacumeer de eendenborst (zonder vel) (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 56°C (1,5–3 u).
3. Dep droog en schroei rondom kort dicht in een gloeiend hete pan of met de brander, voor een korst.
4. Kook de rijst volgens de verpakking.
5. Stoom of wok de sperziebonen beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_duck_breast_56_c_with_rice_green_asparagus','Eendenborst sous-vide 56°C met rijst & groene asperges','Sous-vide duck breast 56°C with rice & green asparagus',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"duck_breast","g":140},{"slug":"rice_dry","g":70},{"slug":"asparagus","g":120},{"slug":"butter","g":8}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY[]::text[],'1. Vacumeer de eendenborst (zonder vel) (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 56°C (1,5–3 u).
3. Dep droog en schroei rondom kort dicht in een gloeiend hete pan of met de brander, voor een korst.
4. Kook de rijst volgens de verpakking.
5. Stoom of wok de groene asperges beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_duck_breast_56_c_with_rice_spinach','Eendenborst sous-vide 56°C met rijst & spinazie','Sous-vide duck breast 56°C with rice & spinach',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"duck_breast","g":140},{"slug":"rice_dry","g":70},{"slug":"spinach","g":100},{"slug":"butter","g":8}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY[]::text[],'1. Vacumeer de eendenborst (zonder vel) (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 56°C (1,5–3 u).
3. Dep droog en schroei rondom kort dicht in een gloeiend hete pan of met de brander, voor een korst.
4. Kook de rijst volgens de verpakking.
5. Stoom of wok de spinazie beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_duck_breast_56_c_with_rice_zucchini','Eendenborst sous-vide 56°C met rijst & courgette','Sous-vide duck breast 56°C with rice & zucchini',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"duck_breast","g":140},{"slug":"rice_dry","g":70},{"slug":"zucchini","g":120},{"slug":"butter","g":8}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY[]::text[],'1. Vacumeer de eendenborst (zonder vel) (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 56°C (1,5–3 u).
3. Dep droog en schroei rondom kort dicht in een gloeiend hete pan of met de brander, voor een korst.
4. Kook de rijst volgens de verpakking.
5. Stoom of wok de courgette beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_duck_breast_56_c_with_quinoa_broccoli','Eendenborst sous-vide 56°C met quinoa & broccoli','Sous-vide duck breast 56°C with quinoa & broccoli',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"duck_breast","g":140},{"slug":"quinoa_dry","g":70},{"slug":"broccoli","g":120},{"slug":"butter","g":8}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY[]::text[],'1. Vacumeer de eendenborst (zonder vel) (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 56°C (1,5–3 u).
3. Dep droog en schroei rondom kort dicht in een gloeiend hete pan of met de brander, voor een korst.
4. Kook de quinoa volgens de verpakking.
5. Stoom of wok de broccoli beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_duck_breast_56_c_with_quinoa_green_beans','Eendenborst sous-vide 56°C met quinoa & sperziebonen','Sous-vide duck breast 56°C with quinoa & green beans',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"duck_breast","g":140},{"slug":"quinoa_dry","g":70},{"slug":"green_beans","g":120},{"slug":"butter","g":8}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY[]::text[],'1. Vacumeer de eendenborst (zonder vel) (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 56°C (1,5–3 u).
3. Dep droog en schroei rondom kort dicht in een gloeiend hete pan of met de brander, voor een korst.
4. Kook de quinoa volgens de verpakking.
5. Stoom of wok de sperziebonen beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_duck_breast_56_c_with_quinoa_green_asparagus','Eendenborst sous-vide 56°C met quinoa & groene asperges','Sous-vide duck breast 56°C with quinoa & green asparagus',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"duck_breast","g":140},{"slug":"quinoa_dry","g":70},{"slug":"asparagus","g":120},{"slug":"butter","g":8}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY[]::text[],'1. Vacumeer de eendenborst (zonder vel) (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 56°C (1,5–3 u).
3. Dep droog en schroei rondom kort dicht in een gloeiend hete pan of met de brander, voor een korst.
4. Kook de quinoa volgens de verpakking.
5. Stoom of wok de groene asperges beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_duck_breast_56_c_with_quinoa_spinach','Eendenborst sous-vide 56°C met quinoa & spinazie','Sous-vide duck breast 56°C with quinoa & spinach',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"duck_breast","g":140},{"slug":"quinoa_dry","g":70},{"slug":"spinach","g":100},{"slug":"butter","g":8}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY[]::text[],'1. Vacumeer de eendenborst (zonder vel) (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 56°C (1,5–3 u).
3. Dep droog en schroei rondom kort dicht in een gloeiend hete pan of met de brander, voor een korst.
4. Kook de quinoa volgens de verpakking.
5. Stoom of wok de spinazie beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_duck_breast_56_c_with_quinoa_zucchini','Eendenborst sous-vide 56°C met quinoa & courgette','Sous-vide duck breast 56°C with quinoa & zucchini',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"duck_breast","g":140},{"slug":"quinoa_dry","g":70},{"slug":"zucchini","g":120},{"slug":"butter","g":8}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY[]::text[],'1. Vacumeer de eendenborst (zonder vel) (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 56°C (1,5–3 u).
3. Dep droog en schroei rondom kort dicht in een gloeiend hete pan of met de brander, voor een korst.
4. Kook de quinoa volgens de verpakking.
5. Stoom of wok de courgette beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_salmon_50_c_with_sweet_potato_broccoli','Zalm sous-vide 50°C met zoete aardappel & broccoli','Sous-vide salmon 50°C with sweet potato & broccoli',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"salmon","g":150},{"slug":"sweet_potato","g":200},{"slug":"broccoli","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY['salmonveg']::text[],'1. Vacumeer de zalmfilet (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 50°C (30–45 min).
3. Dep droog en bak de velzijde heel kort aan — vis valt snel uit elkaar.
4. Kook de zoete aardappel volgens de verpakking.
5. Stoom of wok de broccoli beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_salmon_50_c_with_sweet_potato_green_beans','Zalm sous-vide 50°C met zoete aardappel & sperziebonen','Sous-vide salmon 50°C with sweet potato & green beans',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"salmon","g":150},{"slug":"sweet_potato","g":200},{"slug":"green_beans","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY['salmonveg']::text[],'1. Vacumeer de zalmfilet (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 50°C (30–45 min).
3. Dep droog en bak de velzijde heel kort aan — vis valt snel uit elkaar.
4. Kook de zoete aardappel volgens de verpakking.
5. Stoom of wok de sperziebonen beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_salmon_50_c_with_sweet_potato_green_asparagus','Zalm sous-vide 50°C met zoete aardappel & groene asperges','Sous-vide salmon 50°C with sweet potato & green asparagus',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"salmon","g":150},{"slug":"sweet_potato","g":200},{"slug":"asparagus","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY['salmonveg']::text[],'1. Vacumeer de zalmfilet (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 50°C (30–45 min).
3. Dep droog en bak de velzijde heel kort aan — vis valt snel uit elkaar.
4. Kook de zoete aardappel volgens de verpakking.
5. Stoom of wok de groene asperges beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_salmon_50_c_with_sweet_potato_spinach','Zalm sous-vide 50°C met zoete aardappel & spinazie','Sous-vide salmon 50°C with sweet potato & spinach',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"salmon","g":150},{"slug":"sweet_potato","g":200},{"slug":"spinach","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY['salmonveg']::text[],'1. Vacumeer de zalmfilet (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 50°C (30–45 min).
3. Dep droog en bak de velzijde heel kort aan — vis valt snel uit elkaar.
4. Kook de zoete aardappel volgens de verpakking.
5. Stoom of wok de spinazie beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_salmon_50_c_with_sweet_potato_zucchini','Zalm sous-vide 50°C met zoete aardappel & courgette','Sous-vide salmon 50°C with sweet potato & zucchini',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"salmon","g":150},{"slug":"sweet_potato","g":200},{"slug":"zucchini","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY['salmonveg']::text[],'1. Vacumeer de zalmfilet (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 50°C (30–45 min).
3. Dep droog en bak de velzijde heel kort aan — vis valt snel uit elkaar.
4. Kook de zoete aardappel volgens de verpakking.
5. Stoom of wok de courgette beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_salmon_50_c_with_potato_broccoli','Zalm sous-vide 50°C met aardappel & broccoli','Sous-vide salmon 50°C with potato & broccoli',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"salmon","g":150},{"slug":"potato","g":250},{"slug":"broccoli","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY['salmonveg']::text[],'1. Vacumeer de zalmfilet (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 50°C (30–45 min).
3. Dep droog en bak de velzijde heel kort aan — vis valt snel uit elkaar.
4. Kook de aardappel volgens de verpakking.
5. Stoom of wok de broccoli beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_salmon_50_c_with_potato_green_beans','Zalm sous-vide 50°C met aardappel & sperziebonen','Sous-vide salmon 50°C with potato & green beans',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"salmon","g":150},{"slug":"potato","g":250},{"slug":"green_beans","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY['salmonveg']::text[],'1. Vacumeer de zalmfilet (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 50°C (30–45 min).
3. Dep droog en bak de velzijde heel kort aan — vis valt snel uit elkaar.
4. Kook de aardappel volgens de verpakking.
5. Stoom of wok de sperziebonen beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_salmon_50_c_with_potato_green_asparagus','Zalm sous-vide 50°C met aardappel & groene asperges','Sous-vide salmon 50°C with potato & green asparagus',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"salmon","g":150},{"slug":"potato","g":250},{"slug":"asparagus","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY['salmonveg']::text[],'1. Vacumeer de zalmfilet (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 50°C (30–45 min).
3. Dep droog en bak de velzijde heel kort aan — vis valt snel uit elkaar.
4. Kook de aardappel volgens de verpakking.
5. Stoom of wok de groene asperges beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_salmon_50_c_with_potato_spinach','Zalm sous-vide 50°C met aardappel & spinazie','Sous-vide salmon 50°C with potato & spinach',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"salmon","g":150},{"slug":"potato","g":250},{"slug":"spinach","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY['salmonveg']::text[],'1. Vacumeer de zalmfilet (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 50°C (30–45 min).
3. Dep droog en bak de velzijde heel kort aan — vis valt snel uit elkaar.
4. Kook de aardappel volgens de verpakking.
5. Stoom of wok de spinazie beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_salmon_50_c_with_potato_zucchini','Zalm sous-vide 50°C met aardappel & courgette','Sous-vide salmon 50°C with potato & zucchini',ARRAY['dinner','lunch'],ARRAY['maintain'],'[{"slug":"salmon","g":150},{"slug":"potato","g":250},{"slug":"zucchini","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY['salmonveg']::text[],'1. Vacumeer de zalmfilet (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 50°C (30–45 min).
3. Dep droog en bak de velzijde heel kort aan — vis valt snel uit elkaar.
4. Kook de aardappel volgens de verpakking.
5. Stoom of wok de courgette beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_salmon_50_c_with_rice_broccoli','Zalm sous-vide 50°C met rijst & broccoli','Sous-vide salmon 50°C with rice & broccoli',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"salmon","g":150},{"slug":"rice_dry","g":70},{"slug":"broccoli","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY['salmonveg']::text[],'1. Vacumeer de zalmfilet (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 50°C (30–45 min).
3. Dep droog en bak de velzijde heel kort aan — vis valt snel uit elkaar.
4. Kook de rijst volgens de verpakking.
5. Stoom of wok de broccoli beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_salmon_50_c_with_rice_green_beans','Zalm sous-vide 50°C met rijst & sperziebonen','Sous-vide salmon 50°C with rice & green beans',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"salmon","g":150},{"slug":"rice_dry","g":70},{"slug":"green_beans","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY['salmonveg']::text[],'1. Vacumeer de zalmfilet (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 50°C (30–45 min).
3. Dep droog en bak de velzijde heel kort aan — vis valt snel uit elkaar.
4. Kook de rijst volgens de verpakking.
5. Stoom of wok de sperziebonen beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_salmon_50_c_with_rice_green_asparagus','Zalm sous-vide 50°C met rijst & groene asperges','Sous-vide salmon 50°C with rice & green asparagus',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"salmon","g":150},{"slug":"rice_dry","g":70},{"slug":"asparagus","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY['salmonveg']::text[],'1. Vacumeer de zalmfilet (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 50°C (30–45 min).
3. Dep droog en bak de velzijde heel kort aan — vis valt snel uit elkaar.
4. Kook de rijst volgens de verpakking.
5. Stoom of wok de groene asperges beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_salmon_50_c_with_rice_spinach','Zalm sous-vide 50°C met rijst & spinazie','Sous-vide salmon 50°C with rice & spinach',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"salmon","g":150},{"slug":"rice_dry","g":70},{"slug":"spinach","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY['salmonveg']::text[],'1. Vacumeer de zalmfilet (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 50°C (30–45 min).
3. Dep droog en bak de velzijde heel kort aan — vis valt snel uit elkaar.
4. Kook de rijst volgens de verpakking.
5. Stoom of wok de spinazie beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_salmon_50_c_with_rice_zucchini','Zalm sous-vide 50°C met rijst & courgette','Sous-vide salmon 50°C with rice & zucchini',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"salmon","g":150},{"slug":"rice_dry","g":70},{"slug":"zucchini","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY['salmonveg']::text[],'1. Vacumeer de zalmfilet (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 50°C (30–45 min).
3. Dep droog en bak de velzijde heel kort aan — vis valt snel uit elkaar.
4. Kook de rijst volgens de verpakking.
5. Stoom of wok de courgette beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_salmon_50_c_with_quinoa_broccoli','Zalm sous-vide 50°C met quinoa & broccoli','Sous-vide salmon 50°C with quinoa & broccoli',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"salmon","g":150},{"slug":"quinoa_dry","g":70},{"slug":"broccoli","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY['salmonveg']::text[],'1. Vacumeer de zalmfilet (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 50°C (30–45 min).
3. Dep droog en bak de velzijde heel kort aan — vis valt snel uit elkaar.
4. Kook de quinoa volgens de verpakking.
5. Stoom of wok de broccoli beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_salmon_50_c_with_quinoa_green_beans','Zalm sous-vide 50°C met quinoa & sperziebonen','Sous-vide salmon 50°C with quinoa & green beans',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"salmon","g":150},{"slug":"quinoa_dry","g":70},{"slug":"green_beans","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY['salmonveg']::text[],'1. Vacumeer de zalmfilet (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 50°C (30–45 min).
3. Dep droog en bak de velzijde heel kort aan — vis valt snel uit elkaar.
4. Kook de quinoa volgens de verpakking.
5. Stoom of wok de sperziebonen beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_salmon_50_c_with_quinoa_green_asparagus','Zalm sous-vide 50°C met quinoa & groene asperges','Sous-vide salmon 50°C with quinoa & green asparagus',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"salmon","g":150},{"slug":"quinoa_dry","g":70},{"slug":"asparagus","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY['salmonveg']::text[],'1. Vacumeer de zalmfilet (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 50°C (30–45 min).
3. Dep droog en bak de velzijde heel kort aan — vis valt snel uit elkaar.
4. Kook de quinoa volgens de verpakking.
5. Stoom of wok de groene asperges beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_salmon_50_c_with_quinoa_spinach','Zalm sous-vide 50°C met quinoa & spinazie','Sous-vide salmon 50°C with quinoa & spinach',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"salmon","g":150},{"slug":"quinoa_dry","g":70},{"slug":"spinach","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY['salmonveg']::text[],'1. Vacumeer de zalmfilet (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 50°C (30–45 min).
3. Dep droog en bak de velzijde heel kort aan — vis valt snel uit elkaar.
4. Kook de quinoa volgens de verpakking.
5. Stoom of wok de spinazie beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_salmon_50_c_with_quinoa_zucchini','Zalm sous-vide 50°C met quinoa & courgette','Sous-vide salmon 50°C with quinoa & zucchini',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"salmon","g":150},{"slug":"quinoa_dry","g":70},{"slug":"zucchini","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY['salmonveg']::text[],'1. Vacumeer de zalmfilet (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 50°C (30–45 min).
3. Dep droog en bak de velzijde heel kort aan — vis valt snel uit elkaar.
4. Kook de quinoa volgens de verpakking.
5. Stoom of wok de courgette beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_cod_52_c_with_sweet_potato_broccoli','Kabeljauw sous-vide 52°C met zoete aardappel & broccoli','Sous-vide cod 52°C with sweet potato & broccoli',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"white_fish","g":170},{"slug":"sweet_potato","g":200},{"slug":"broccoli","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY[]::text[],'1. Vacumeer de kabeljauw (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 52°C (30–45 min).
3. Dep droog en bak de velzijde heel kort aan — vis valt snel uit elkaar.
4. Kook de zoete aardappel volgens de verpakking.
5. Stoom of wok de broccoli beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_cod_52_c_with_sweet_potato_green_beans','Kabeljauw sous-vide 52°C met zoete aardappel & sperziebonen','Sous-vide cod 52°C with sweet potato & green beans',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"white_fish","g":170},{"slug":"sweet_potato","g":200},{"slug":"green_beans","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY[]::text[],'1. Vacumeer de kabeljauw (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 52°C (30–45 min).
3. Dep droog en bak de velzijde heel kort aan — vis valt snel uit elkaar.
4. Kook de zoete aardappel volgens de verpakking.
5. Stoom of wok de sperziebonen beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_cod_52_c_with_sweet_potato_green_asparagus','Kabeljauw sous-vide 52°C met zoete aardappel & groene asperges','Sous-vide cod 52°C with sweet potato & green asparagus',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"white_fish","g":170},{"slug":"sweet_potato","g":200},{"slug":"asparagus","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY[]::text[],'1. Vacumeer de kabeljauw (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 52°C (30–45 min).
3. Dep droog en bak de velzijde heel kort aan — vis valt snel uit elkaar.
4. Kook de zoete aardappel volgens de verpakking.
5. Stoom of wok de groene asperges beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_cod_52_c_with_sweet_potato_spinach','Kabeljauw sous-vide 52°C met zoete aardappel & spinazie','Sous-vide cod 52°C with sweet potato & spinach',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"white_fish","g":170},{"slug":"sweet_potato","g":200},{"slug":"spinach","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY[]::text[],'1. Vacumeer de kabeljauw (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 52°C (30–45 min).
3. Dep droog en bak de velzijde heel kort aan — vis valt snel uit elkaar.
4. Kook de zoete aardappel volgens de verpakking.
5. Stoom of wok de spinazie beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_cod_52_c_with_sweet_potato_zucchini','Kabeljauw sous-vide 52°C met zoete aardappel & courgette','Sous-vide cod 52°C with sweet potato & zucchini',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"white_fish","g":170},{"slug":"sweet_potato","g":200},{"slug":"zucchini","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY[]::text[],'1. Vacumeer de kabeljauw (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 52°C (30–45 min).
3. Dep droog en bak de velzijde heel kort aan — vis valt snel uit elkaar.
4. Kook de zoete aardappel volgens de verpakking.
5. Stoom of wok de courgette beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_cod_52_c_with_potato_broccoli','Kabeljauw sous-vide 52°C met aardappel & broccoli','Sous-vide cod 52°C with potato & broccoli',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"white_fish","g":170},{"slug":"potato","g":250},{"slug":"broccoli","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY[]::text[],'1. Vacumeer de kabeljauw (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 52°C (30–45 min).
3. Dep droog en bak de velzijde heel kort aan — vis valt snel uit elkaar.
4. Kook de aardappel volgens de verpakking.
5. Stoom of wok de broccoli beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_cod_52_c_with_potato_green_beans','Kabeljauw sous-vide 52°C met aardappel & sperziebonen','Sous-vide cod 52°C with potato & green beans',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"white_fish","g":170},{"slug":"potato","g":250},{"slug":"green_beans","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY[]::text[],'1. Vacumeer de kabeljauw (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 52°C (30–45 min).
3. Dep droog en bak de velzijde heel kort aan — vis valt snel uit elkaar.
4. Kook de aardappel volgens de verpakking.
5. Stoom of wok de sperziebonen beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_cod_52_c_with_potato_green_asparagus','Kabeljauw sous-vide 52°C met aardappel & groene asperges','Sous-vide cod 52°C with potato & green asparagus',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"white_fish","g":170},{"slug":"potato","g":250},{"slug":"asparagus","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY[]::text[],'1. Vacumeer de kabeljauw (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 52°C (30–45 min).
3. Dep droog en bak de velzijde heel kort aan — vis valt snel uit elkaar.
4. Kook de aardappel volgens de verpakking.
5. Stoom of wok de groene asperges beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_cod_52_c_with_potato_spinach','Kabeljauw sous-vide 52°C met aardappel & spinazie','Sous-vide cod 52°C with potato & spinach',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"white_fish","g":170},{"slug":"potato","g":250},{"slug":"spinach","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY[]::text[],'1. Vacumeer de kabeljauw (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 52°C (30–45 min).
3. Dep droog en bak de velzijde heel kort aan — vis valt snel uit elkaar.
4. Kook de aardappel volgens de verpakking.
5. Stoom of wok de spinazie beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_cod_52_c_with_potato_zucchini','Kabeljauw sous-vide 52°C met aardappel & courgette','Sous-vide cod 52°C with potato & zucchini',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"white_fish","g":170},{"slug":"potato","g":250},{"slug":"zucchini","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY[]::text[],'1. Vacumeer de kabeljauw (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 52°C (30–45 min).
3. Dep droog en bak de velzijde heel kort aan — vis valt snel uit elkaar.
4. Kook de aardappel volgens de verpakking.
5. Stoom of wok de courgette beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_cod_52_c_with_rice_broccoli','Kabeljauw sous-vide 52°C met rijst & broccoli','Sous-vide cod 52°C with rice & broccoli',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"white_fish","g":170},{"slug":"rice_dry","g":70},{"slug":"broccoli","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY[]::text[],'1. Vacumeer de kabeljauw (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 52°C (30–45 min).
3. Dep droog en bak de velzijde heel kort aan — vis valt snel uit elkaar.
4. Kook de rijst volgens de verpakking.
5. Stoom of wok de broccoli beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_cod_52_c_with_rice_green_beans','Kabeljauw sous-vide 52°C met rijst & sperziebonen','Sous-vide cod 52°C with rice & green beans',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"white_fish","g":170},{"slug":"rice_dry","g":70},{"slug":"green_beans","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY[]::text[],'1. Vacumeer de kabeljauw (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 52°C (30–45 min).
3. Dep droog en bak de velzijde heel kort aan — vis valt snel uit elkaar.
4. Kook de rijst volgens de verpakking.
5. Stoom of wok de sperziebonen beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_cod_52_c_with_rice_green_asparagus','Kabeljauw sous-vide 52°C met rijst & groene asperges','Sous-vide cod 52°C with rice & green asparagus',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"white_fish","g":170},{"slug":"rice_dry","g":70},{"slug":"asparagus","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY[]::text[],'1. Vacumeer de kabeljauw (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 52°C (30–45 min).
3. Dep droog en bak de velzijde heel kort aan — vis valt snel uit elkaar.
4. Kook de rijst volgens de verpakking.
5. Stoom of wok de groene asperges beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_cod_52_c_with_rice_spinach','Kabeljauw sous-vide 52°C met rijst & spinazie','Sous-vide cod 52°C with rice & spinach',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"white_fish","g":170},{"slug":"rice_dry","g":70},{"slug":"spinach","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY[]::text[],'1. Vacumeer de kabeljauw (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 52°C (30–45 min).
3. Dep droog en bak de velzijde heel kort aan — vis valt snel uit elkaar.
4. Kook de rijst volgens de verpakking.
5. Stoom of wok de spinazie beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_cod_52_c_with_rice_zucchini','Kabeljauw sous-vide 52°C met rijst & courgette','Sous-vide cod 52°C with rice & zucchini',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"white_fish","g":170},{"slug":"rice_dry","g":70},{"slug":"zucchini","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY[]::text[],'1. Vacumeer de kabeljauw (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 52°C (30–45 min).
3. Dep droog en bak de velzijde heel kort aan — vis valt snel uit elkaar.
4. Kook de rijst volgens de verpakking.
5. Stoom of wok de courgette beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_cod_52_c_with_quinoa_broccoli','Kabeljauw sous-vide 52°C met quinoa & broccoli','Sous-vide cod 52°C with quinoa & broccoli',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"white_fish","g":170},{"slug":"quinoa_dry","g":70},{"slug":"broccoli","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY[]::text[],'1. Vacumeer de kabeljauw (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 52°C (30–45 min).
3. Dep droog en bak de velzijde heel kort aan — vis valt snel uit elkaar.
4. Kook de quinoa volgens de verpakking.
5. Stoom of wok de broccoli beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_cod_52_c_with_quinoa_green_beans','Kabeljauw sous-vide 52°C met quinoa & sperziebonen','Sous-vide cod 52°C with quinoa & green beans',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"white_fish","g":170},{"slug":"quinoa_dry","g":70},{"slug":"green_beans","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY[]::text[],'1. Vacumeer de kabeljauw (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 52°C (30–45 min).
3. Dep droog en bak de velzijde heel kort aan — vis valt snel uit elkaar.
4. Kook de quinoa volgens de verpakking.
5. Stoom of wok de sperziebonen beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_cod_52_c_with_quinoa_green_asparagus','Kabeljauw sous-vide 52°C met quinoa & groene asperges','Sous-vide cod 52°C with quinoa & green asparagus',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"white_fish","g":170},{"slug":"quinoa_dry","g":70},{"slug":"asparagus","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY[]::text[],'1. Vacumeer de kabeljauw (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 52°C (30–45 min).
3. Dep droog en bak de velzijde heel kort aan — vis valt snel uit elkaar.
4. Kook de quinoa volgens de verpakking.
5. Stoom of wok de groene asperges beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_cod_52_c_with_quinoa_spinach','Kabeljauw sous-vide 52°C met quinoa & spinazie','Sous-vide cod 52°C with quinoa & spinach',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"white_fish","g":170},{"slug":"quinoa_dry","g":70},{"slug":"spinach","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY[]::text[],'1. Vacumeer de kabeljauw (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 52°C (30–45 min).
3. Dep droog en bak de velzijde heel kort aan — vis valt snel uit elkaar.
4. Kook de quinoa volgens de verpakking.
5. Stoom of wok de spinazie beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_cod_52_c_with_quinoa_zucchini','Kabeljauw sous-vide 52°C met quinoa & courgette','Sous-vide cod 52°C with quinoa & zucchini',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"white_fish","g":170},{"slug":"quinoa_dry","g":70},{"slug":"zucchini","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY[]::text[],'1. Vacumeer de kabeljauw (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 52°C (30–45 min).
3. Dep droog en bak de velzijde heel kort aan — vis valt snel uit elkaar.
4. Kook de quinoa volgens de verpakking.
5. Stoom of wok de courgette beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_shrimp_57_c_with_sweet_potato_broccoli','Garnalen sous-vide 57°C met zoete aardappel & broccoli','Sous-vide shrimp 57°C with sweet potato & broccoli',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"shrimp","g":150},{"slug":"sweet_potato","g":200},{"slug":"broccoli","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY[]::text[],'1. Vacumeer de garnalen (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 57°C (30 min).
3. Dep droog en bak de velzijde heel kort aan — vis valt snel uit elkaar.
4. Kook de zoete aardappel volgens de verpakking.
5. Stoom of wok de broccoli beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_shrimp_57_c_with_sweet_potato_green_beans','Garnalen sous-vide 57°C met zoete aardappel & sperziebonen','Sous-vide shrimp 57°C with sweet potato & green beans',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"shrimp","g":150},{"slug":"sweet_potato","g":200},{"slug":"green_beans","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY[]::text[],'1. Vacumeer de garnalen (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 57°C (30 min).
3. Dep droog en bak de velzijde heel kort aan — vis valt snel uit elkaar.
4. Kook de zoete aardappel volgens de verpakking.
5. Stoom of wok de sperziebonen beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_shrimp_57_c_with_sweet_potato_green_asparagus','Garnalen sous-vide 57°C met zoete aardappel & groene asperges','Sous-vide shrimp 57°C with sweet potato & green asparagus',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"shrimp","g":150},{"slug":"sweet_potato","g":200},{"slug":"asparagus","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY[]::text[],'1. Vacumeer de garnalen (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 57°C (30 min).
3. Dep droog en bak de velzijde heel kort aan — vis valt snel uit elkaar.
4. Kook de zoete aardappel volgens de verpakking.
5. Stoom of wok de groene asperges beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_shrimp_57_c_with_sweet_potato_spinach','Garnalen sous-vide 57°C met zoete aardappel & spinazie','Sous-vide shrimp 57°C with sweet potato & spinach',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"shrimp","g":150},{"slug":"sweet_potato","g":200},{"slug":"spinach","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY[]::text[],'1. Vacumeer de garnalen (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 57°C (30 min).
3. Dep droog en bak de velzijde heel kort aan — vis valt snel uit elkaar.
4. Kook de zoete aardappel volgens de verpakking.
5. Stoom of wok de spinazie beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_shrimp_57_c_with_sweet_potato_zucchini','Garnalen sous-vide 57°C met zoete aardappel & courgette','Sous-vide shrimp 57°C with sweet potato & zucchini',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"shrimp","g":150},{"slug":"sweet_potato","g":200},{"slug":"zucchini","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY[]::text[],'1. Vacumeer de garnalen (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 57°C (30 min).
3. Dep droog en bak de velzijde heel kort aan — vis valt snel uit elkaar.
4. Kook de zoete aardappel volgens de verpakking.
5. Stoom of wok de courgette beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_shrimp_57_c_with_potato_broccoli','Garnalen sous-vide 57°C met aardappel & broccoli','Sous-vide shrimp 57°C with potato & broccoli',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"shrimp","g":150},{"slug":"potato","g":250},{"slug":"broccoli","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY[]::text[],'1. Vacumeer de garnalen (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 57°C (30 min).
3. Dep droog en bak de velzijde heel kort aan — vis valt snel uit elkaar.
4. Kook de aardappel volgens de verpakking.
5. Stoom of wok de broccoli beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_shrimp_57_c_with_potato_green_beans','Garnalen sous-vide 57°C met aardappel & sperziebonen','Sous-vide shrimp 57°C with potato & green beans',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"shrimp","g":150},{"slug":"potato","g":250},{"slug":"green_beans","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY[]::text[],'1. Vacumeer de garnalen (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 57°C (30 min).
3. Dep droog en bak de velzijde heel kort aan — vis valt snel uit elkaar.
4. Kook de aardappel volgens de verpakking.
5. Stoom of wok de sperziebonen beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_shrimp_57_c_with_potato_green_asparagus','Garnalen sous-vide 57°C met aardappel & groene asperges','Sous-vide shrimp 57°C with potato & green asparagus',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"shrimp","g":150},{"slug":"potato","g":250},{"slug":"asparagus","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY[]::text[],'1. Vacumeer de garnalen (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 57°C (30 min).
3. Dep droog en bak de velzijde heel kort aan — vis valt snel uit elkaar.
4. Kook de aardappel volgens de verpakking.
5. Stoom of wok de groene asperges beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_shrimp_57_c_with_potato_spinach','Garnalen sous-vide 57°C met aardappel & spinazie','Sous-vide shrimp 57°C with potato & spinach',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"shrimp","g":150},{"slug":"potato","g":250},{"slug":"spinach","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY[]::text[],'1. Vacumeer de garnalen (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 57°C (30 min).
3. Dep droog en bak de velzijde heel kort aan — vis valt snel uit elkaar.
4. Kook de aardappel volgens de verpakking.
5. Stoom of wok de spinazie beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_shrimp_57_c_with_potato_zucchini','Garnalen sous-vide 57°C met aardappel & courgette','Sous-vide shrimp 57°C with potato & zucchini',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"shrimp","g":150},{"slug":"potato","g":250},{"slug":"zucchini","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY[]::text[],'1. Vacumeer de garnalen (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 57°C (30 min).
3. Dep droog en bak de velzijde heel kort aan — vis valt snel uit elkaar.
4. Kook de aardappel volgens de verpakking.
5. Stoom of wok de courgette beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_shrimp_57_c_with_rice_broccoli','Garnalen sous-vide 57°C met rijst & broccoli','Sous-vide shrimp 57°C with rice & broccoli',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"shrimp","g":150},{"slug":"rice_dry","g":70},{"slug":"broccoli","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY[]::text[],'1. Vacumeer de garnalen (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 57°C (30 min).
3. Dep droog en bak de velzijde heel kort aan — vis valt snel uit elkaar.
4. Kook de rijst volgens de verpakking.
5. Stoom of wok de broccoli beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_shrimp_57_c_with_rice_green_beans','Garnalen sous-vide 57°C met rijst & sperziebonen','Sous-vide shrimp 57°C with rice & green beans',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"shrimp","g":150},{"slug":"rice_dry","g":70},{"slug":"green_beans","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY[]::text[],'1. Vacumeer de garnalen (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 57°C (30 min).
3. Dep droog en bak de velzijde heel kort aan — vis valt snel uit elkaar.
4. Kook de rijst volgens de verpakking.
5. Stoom of wok de sperziebonen beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_shrimp_57_c_with_rice_green_asparagus','Garnalen sous-vide 57°C met rijst & groene asperges','Sous-vide shrimp 57°C with rice & green asparagus',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"shrimp","g":150},{"slug":"rice_dry","g":70},{"slug":"asparagus","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY[]::text[],'1. Vacumeer de garnalen (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 57°C (30 min).
3. Dep droog en bak de velzijde heel kort aan — vis valt snel uit elkaar.
4. Kook de rijst volgens de verpakking.
5. Stoom of wok de groene asperges beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_shrimp_57_c_with_rice_spinach','Garnalen sous-vide 57°C met rijst & spinazie','Sous-vide shrimp 57°C with rice & spinach',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"shrimp","g":150},{"slug":"rice_dry","g":70},{"slug":"spinach","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY[]::text[],'1. Vacumeer de garnalen (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 57°C (30 min).
3. Dep droog en bak de velzijde heel kort aan — vis valt snel uit elkaar.
4. Kook de rijst volgens de verpakking.
5. Stoom of wok de spinazie beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_shrimp_57_c_with_rice_zucchini','Garnalen sous-vide 57°C met rijst & courgette','Sous-vide shrimp 57°C with rice & zucchini',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"shrimp","g":150},{"slug":"rice_dry","g":70},{"slug":"zucchini","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY[]::text[],'1. Vacumeer de garnalen (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 57°C (30 min).
3. Dep droog en bak de velzijde heel kort aan — vis valt snel uit elkaar.
4. Kook de rijst volgens de verpakking.
5. Stoom of wok de courgette beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_shrimp_57_c_with_quinoa_broccoli','Garnalen sous-vide 57°C met quinoa & broccoli','Sous-vide shrimp 57°C with quinoa & broccoli',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"shrimp","g":150},{"slug":"quinoa_dry","g":70},{"slug":"broccoli","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY[]::text[],'1. Vacumeer de garnalen (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 57°C (30 min).
3. Dep droog en bak de velzijde heel kort aan — vis valt snel uit elkaar.
4. Kook de quinoa volgens de verpakking.
5. Stoom of wok de broccoli beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_shrimp_57_c_with_quinoa_green_beans','Garnalen sous-vide 57°C met quinoa & sperziebonen','Sous-vide shrimp 57°C with quinoa & green beans',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"shrimp","g":150},{"slug":"quinoa_dry","g":70},{"slug":"green_beans","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY[]::text[],'1. Vacumeer de garnalen (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 57°C (30 min).
3. Dep droog en bak de velzijde heel kort aan — vis valt snel uit elkaar.
4. Kook de quinoa volgens de verpakking.
5. Stoom of wok de sperziebonen beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_shrimp_57_c_with_quinoa_green_asparagus','Garnalen sous-vide 57°C met quinoa & groene asperges','Sous-vide shrimp 57°C with quinoa & green asparagus',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"shrimp","g":150},{"slug":"quinoa_dry","g":70},{"slug":"asparagus","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY[]::text[],'1. Vacumeer de garnalen (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 57°C (30 min).
3. Dep droog en bak de velzijde heel kort aan — vis valt snel uit elkaar.
4. Kook de quinoa volgens de verpakking.
5. Stoom of wok de groene asperges beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_shrimp_57_c_with_quinoa_spinach','Garnalen sous-vide 57°C met quinoa & spinazie','Sous-vide shrimp 57°C with quinoa & spinach',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"shrimp","g":150},{"slug":"quinoa_dry","g":70},{"slug":"spinach","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY[]::text[],'1. Vacumeer de garnalen (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 57°C (30 min).
3. Dep droog en bak de velzijde heel kort aan — vis valt snel uit elkaar.
4. Kook de quinoa volgens de verpakking.
5. Stoom of wok de spinazie beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('sous_vide_shrimp_57_c_with_quinoa_zucchini','Garnalen sous-vide 57°C met quinoa & courgette','Sous-vide shrimp 57°C with quinoa & zucchini',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"shrimp","g":150},{"slug":"quinoa_dry","g":70},{"slug":"zucchini","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY[]::text[],'1. Vacumeer de garnalen (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 57°C (30 min).
3. Dep droog en bak de velzijde heel kort aan — vis valt snel uit elkaar.
4. Kook de quinoa volgens de verpakking.
5. Stoom of wok de courgette beetgaar.
6. Snijd aan, breng op smaak en serveer.','core'),
('onsen_egg_63_c_with_spinach','Onsen-ei 63°C met spinazie','Onsen egg 63°C with spinach',ARRAY['breakfast','lunch'],ARRAY['cut','maintain'],'[{"slug":"egg","g":120},{"slug":"spinach","g":60},{"slug":"olive_oil","g":3}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY[]::text[],'1. Gaar de eieren sous-vide op 63°C (45–60 min) voor een romige dooier.
2. Wok of slink de spinazie kort in de olijfolie.
3. Pel de onsen-eieren voorzichtig en leg ze op de spinazie.
4. Breng op smaak met peper en zout.','core')
on conflict (slug) do update set name_nl=excluded.name_nl,name_en=excluded.name_en,moments=excluded.moments,goals=excluded.goals,items=excluded.items,tags=excluded.tags,prefs=excluded.prefs,steps=excluded.steps;
commit;
