-- SOUS-VIDE seed deel 2/2 (51 gerechten). Draai NA dish-library.sql.
begin;
insert into public.dishes (slug,name_nl,name_en,moments,goals,items,tags,prefs,steps,steps_en,technique,temp,source) values
('sous_vide_salmon_50_c_with_rice_broccoli','Zalm sous-vide 50°C met rijst & broccoli','Sous-vide salmon 50°C with rice & broccoli',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"salmon","g":150},{"slug":"rice_dry","g":70},{"slug":"broccoli","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY['salmonveg']::text[],'1. Vacumeer de zalmfilet (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 50°C (30–45 min).
3. Dep droog en bak de velzijde heel kort aan — vis valt snel uit elkaar.
4. Kook de rijst volgens de verpakking.
5. Stoom of wok de broccoli beetgaar.
6. Snijd aan, breng op smaak en serveer.','1. Vacuum-seal the salmon fillet (add herbs and a little oil if you like).
2. Cook sous-vide at 50°C (30–45 min).
3. Pat dry and sear the skin side very briefly — fish falls apart easily.
4. Cook the rice per the package.
5. Steam or stir-fry the broccoli until tender-crisp.
6. Slice, season and serve.','sousvide','50°C','core'),
('sous_vide_salmon_50_c_with_rice_green_beans','Zalm sous-vide 50°C met rijst & sperziebonen','Sous-vide salmon 50°C with rice & green beans',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"salmon","g":150},{"slug":"rice_dry","g":70},{"slug":"green_beans","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY['salmonveg']::text[],'1. Vacumeer de zalmfilet (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 50°C (30–45 min).
3. Dep droog en bak de velzijde heel kort aan — vis valt snel uit elkaar.
4. Kook de rijst volgens de verpakking.
5. Stoom of wok de sperziebonen beetgaar.
6. Snijd aan, breng op smaak en serveer.','1. Vacuum-seal the salmon fillet (add herbs and a little oil if you like).
2. Cook sous-vide at 50°C (30–45 min).
3. Pat dry and sear the skin side very briefly — fish falls apart easily.
4. Cook the rice per the package.
5. Steam or stir-fry the green beans until tender-crisp.
6. Slice, season and serve.','sousvide','50°C','core'),
('sous_vide_salmon_50_c_with_rice_green_asparagus','Zalm sous-vide 50°C met rijst & groene asperges','Sous-vide salmon 50°C with rice & green asparagus',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"salmon","g":150},{"slug":"rice_dry","g":70},{"slug":"asparagus","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY['salmonveg']::text[],'1. Vacumeer de zalmfilet (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 50°C (30–45 min).
3. Dep droog en bak de velzijde heel kort aan — vis valt snel uit elkaar.
4. Kook de rijst volgens de verpakking.
5. Stoom of wok de groene asperges beetgaar.
6. Snijd aan, breng op smaak en serveer.','1. Vacuum-seal the salmon fillet (add herbs and a little oil if you like).
2. Cook sous-vide at 50°C (30–45 min).
3. Pat dry and sear the skin side very briefly — fish falls apart easily.
4. Cook the rice per the package.
5. Steam or stir-fry the green asparagus until tender-crisp.
6. Slice, season and serve.','sousvide','50°C','core'),
('sous_vide_salmon_50_c_with_rice_spinach','Zalm sous-vide 50°C met rijst & spinazie','Sous-vide salmon 50°C with rice & spinach',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"salmon","g":150},{"slug":"rice_dry","g":70},{"slug":"spinach","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY['salmonveg']::text[],'1. Vacumeer de zalmfilet (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 50°C (30–45 min).
3. Dep droog en bak de velzijde heel kort aan — vis valt snel uit elkaar.
4. Kook de rijst volgens de verpakking.
5. Stoom of wok de spinazie beetgaar.
6. Snijd aan, breng op smaak en serveer.','1. Vacuum-seal the salmon fillet (add herbs and a little oil if you like).
2. Cook sous-vide at 50°C (30–45 min).
3. Pat dry and sear the skin side very briefly — fish falls apart easily.
4. Cook the rice per the package.
5. Steam or stir-fry the spinach until tender-crisp.
6. Slice, season and serve.','sousvide','50°C','core'),
('sous_vide_salmon_50_c_with_rice_zucchini','Zalm sous-vide 50°C met rijst & courgette','Sous-vide salmon 50°C with rice & zucchini',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"salmon","g":150},{"slug":"rice_dry","g":70},{"slug":"zucchini","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY['salmonveg']::text[],'1. Vacumeer de zalmfilet (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 50°C (30–45 min).
3. Dep droog en bak de velzijde heel kort aan — vis valt snel uit elkaar.
4. Kook de rijst volgens de verpakking.
5. Stoom of wok de courgette beetgaar.
6. Snijd aan, breng op smaak en serveer.','1. Vacuum-seal the salmon fillet (add herbs and a little oil if you like).
2. Cook sous-vide at 50°C (30–45 min).
3. Pat dry and sear the skin side very briefly — fish falls apart easily.
4. Cook the rice per the package.
5. Steam or stir-fry the zucchini until tender-crisp.
6. Slice, season and serve.','sousvide','50°C','core'),
('sous_vide_salmon_50_c_with_quinoa_broccoli','Zalm sous-vide 50°C met quinoa & broccoli','Sous-vide salmon 50°C with quinoa & broccoli',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"salmon","g":150},{"slug":"quinoa_dry","g":70},{"slug":"broccoli","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY['salmonveg']::text[],'1. Vacumeer de zalmfilet (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 50°C (30–45 min).
3. Dep droog en bak de velzijde heel kort aan — vis valt snel uit elkaar.
4. Kook de quinoa volgens de verpakking.
5. Stoom of wok de broccoli beetgaar.
6. Snijd aan, breng op smaak en serveer.','1. Vacuum-seal the salmon fillet (add herbs and a little oil if you like).
2. Cook sous-vide at 50°C (30–45 min).
3. Pat dry and sear the skin side very briefly — fish falls apart easily.
4. Cook the quinoa per the package.
5. Steam or stir-fry the broccoli until tender-crisp.
6. Slice, season and serve.','sousvide','50°C','core'),
('sous_vide_salmon_50_c_with_quinoa_green_beans','Zalm sous-vide 50°C met quinoa & sperziebonen','Sous-vide salmon 50°C with quinoa & green beans',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"salmon","g":150},{"slug":"quinoa_dry","g":70},{"slug":"green_beans","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY['salmonveg']::text[],'1. Vacumeer de zalmfilet (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 50°C (30–45 min).
3. Dep droog en bak de velzijde heel kort aan — vis valt snel uit elkaar.
4. Kook de quinoa volgens de verpakking.
5. Stoom of wok de sperziebonen beetgaar.
6. Snijd aan, breng op smaak en serveer.','1. Vacuum-seal the salmon fillet (add herbs and a little oil if you like).
2. Cook sous-vide at 50°C (30–45 min).
3. Pat dry and sear the skin side very briefly — fish falls apart easily.
4. Cook the quinoa per the package.
5. Steam or stir-fry the green beans until tender-crisp.
6. Slice, season and serve.','sousvide','50°C','core'),
('sous_vide_salmon_50_c_with_quinoa_green_asparagus','Zalm sous-vide 50°C met quinoa & groene asperges','Sous-vide salmon 50°C with quinoa & green asparagus',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"salmon","g":150},{"slug":"quinoa_dry","g":70},{"slug":"asparagus","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY['salmonveg']::text[],'1. Vacumeer de zalmfilet (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 50°C (30–45 min).
3. Dep droog en bak de velzijde heel kort aan — vis valt snel uit elkaar.
4. Kook de quinoa volgens de verpakking.
5. Stoom of wok de groene asperges beetgaar.
6. Snijd aan, breng op smaak en serveer.','1. Vacuum-seal the salmon fillet (add herbs and a little oil if you like).
2. Cook sous-vide at 50°C (30–45 min).
3. Pat dry and sear the skin side very briefly — fish falls apart easily.
4. Cook the quinoa per the package.
5. Steam or stir-fry the green asparagus until tender-crisp.
6. Slice, season and serve.','sousvide','50°C','core'),
('sous_vide_salmon_50_c_with_quinoa_spinach','Zalm sous-vide 50°C met quinoa & spinazie','Sous-vide salmon 50°C with quinoa & spinach',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"salmon","g":150},{"slug":"quinoa_dry","g":70},{"slug":"spinach","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY['salmonveg']::text[],'1. Vacumeer de zalmfilet (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 50°C (30–45 min).
3. Dep droog en bak de velzijde heel kort aan — vis valt snel uit elkaar.
4. Kook de quinoa volgens de verpakking.
5. Stoom of wok de spinazie beetgaar.
6. Snijd aan, breng op smaak en serveer.','1. Vacuum-seal the salmon fillet (add herbs and a little oil if you like).
2. Cook sous-vide at 50°C (30–45 min).
3. Pat dry and sear the skin side very briefly — fish falls apart easily.
4. Cook the quinoa per the package.
5. Steam or stir-fry the spinach until tender-crisp.
6. Slice, season and serve.','sousvide','50°C','core'),
('sous_vide_salmon_50_c_with_quinoa_zucchini','Zalm sous-vide 50°C met quinoa & courgette','Sous-vide salmon 50°C with quinoa & zucchini',ARRAY['dinner','lunch'],ARRAY['gain','maintain'],'[{"slug":"salmon","g":150},{"slug":"quinoa_dry","g":70},{"slug":"zucchini","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY['salmonveg']::text[],'1. Vacumeer de zalmfilet (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 50°C (30–45 min).
3. Dep droog en bak de velzijde heel kort aan — vis valt snel uit elkaar.
4. Kook de quinoa volgens de verpakking.
5. Stoom of wok de courgette beetgaar.
6. Snijd aan, breng op smaak en serveer.','1. Vacuum-seal the salmon fillet (add herbs and a little oil if you like).
2. Cook sous-vide at 50°C (30–45 min).
3. Pat dry and sear the skin side very briefly — fish falls apart easily.
4. Cook the quinoa per the package.
5. Steam or stir-fry the zucchini until tender-crisp.
6. Slice, season and serve.','sousvide','50°C','core'),
('sous_vide_cod_52_c_with_sweet_potato_broccoli','Kabeljauw sous-vide 52°C met zoete aardappel & broccoli','Sous-vide cod 52°C with sweet potato & broccoli',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"white_fish","g":170},{"slug":"sweet_potato","g":200},{"slug":"broccoli","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY[]::text[],'1. Vacumeer de kabeljauw (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 52°C (30–45 min).
3. Dep droog en bak de velzijde heel kort aan — vis valt snel uit elkaar.
4. Kook de zoete aardappel volgens de verpakking.
5. Stoom of wok de broccoli beetgaar.
6. Snijd aan, breng op smaak en serveer.','1. Vacuum-seal the cod (add herbs and a little oil if you like).
2. Cook sous-vide at 52°C (30–45 min).
3. Pat dry and sear the skin side very briefly — fish falls apart easily.
4. Cook the sweet potato per the package.
5. Steam or stir-fry the broccoli until tender-crisp.
6. Slice, season and serve.','sousvide','52°C','core'),
('sous_vide_cod_52_c_with_sweet_potato_green_beans','Kabeljauw sous-vide 52°C met zoete aardappel & sperziebonen','Sous-vide cod 52°C with sweet potato & green beans',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"white_fish","g":170},{"slug":"sweet_potato","g":200},{"slug":"green_beans","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY[]::text[],'1. Vacumeer de kabeljauw (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 52°C (30–45 min).
3. Dep droog en bak de velzijde heel kort aan — vis valt snel uit elkaar.
4. Kook de zoete aardappel volgens de verpakking.
5. Stoom of wok de sperziebonen beetgaar.
6. Snijd aan, breng op smaak en serveer.','1. Vacuum-seal the cod (add herbs and a little oil if you like).
2. Cook sous-vide at 52°C (30–45 min).
3. Pat dry and sear the skin side very briefly — fish falls apart easily.
4. Cook the sweet potato per the package.
5. Steam or stir-fry the green beans until tender-crisp.
6. Slice, season and serve.','sousvide','52°C','core'),
('sous_vide_cod_52_c_with_sweet_potato_green_asparagus','Kabeljauw sous-vide 52°C met zoete aardappel & groene asperges','Sous-vide cod 52°C with sweet potato & green asparagus',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"white_fish","g":170},{"slug":"sweet_potato","g":200},{"slug":"asparagus","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY[]::text[],'1. Vacumeer de kabeljauw (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 52°C (30–45 min).
3. Dep droog en bak de velzijde heel kort aan — vis valt snel uit elkaar.
4. Kook de zoete aardappel volgens de verpakking.
5. Stoom of wok de groene asperges beetgaar.
6. Snijd aan, breng op smaak en serveer.','1. Vacuum-seal the cod (add herbs and a little oil if you like).
2. Cook sous-vide at 52°C (30–45 min).
3. Pat dry and sear the skin side very briefly — fish falls apart easily.
4. Cook the sweet potato per the package.
5. Steam or stir-fry the green asparagus until tender-crisp.
6. Slice, season and serve.','sousvide','52°C','core'),
('sous_vide_cod_52_c_with_sweet_potato_spinach','Kabeljauw sous-vide 52°C met zoete aardappel & spinazie','Sous-vide cod 52°C with sweet potato & spinach',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"white_fish","g":170},{"slug":"sweet_potato","g":200},{"slug":"spinach","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY[]::text[],'1. Vacumeer de kabeljauw (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 52°C (30–45 min).
3. Dep droog en bak de velzijde heel kort aan — vis valt snel uit elkaar.
4. Kook de zoete aardappel volgens de verpakking.
5. Stoom of wok de spinazie beetgaar.
6. Snijd aan, breng op smaak en serveer.','1. Vacuum-seal the cod (add herbs and a little oil if you like).
2. Cook sous-vide at 52°C (30–45 min).
3. Pat dry and sear the skin side very briefly — fish falls apart easily.
4. Cook the sweet potato per the package.
5. Steam or stir-fry the spinach until tender-crisp.
6. Slice, season and serve.','sousvide','52°C','core'),
('sous_vide_cod_52_c_with_sweet_potato_zucchini','Kabeljauw sous-vide 52°C met zoete aardappel & courgette','Sous-vide cod 52°C with sweet potato & zucchini',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"white_fish","g":170},{"slug":"sweet_potato","g":200},{"slug":"zucchini","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY[]::text[],'1. Vacumeer de kabeljauw (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 52°C (30–45 min).
3. Dep droog en bak de velzijde heel kort aan — vis valt snel uit elkaar.
4. Kook de zoete aardappel volgens de verpakking.
5. Stoom of wok de courgette beetgaar.
6. Snijd aan, breng op smaak en serveer.','1. Vacuum-seal the cod (add herbs and a little oil if you like).
2. Cook sous-vide at 52°C (30–45 min).
3. Pat dry and sear the skin side very briefly — fish falls apart easily.
4. Cook the sweet potato per the package.
5. Steam or stir-fry the zucchini until tender-crisp.
6. Slice, season and serve.','sousvide','52°C','core'),
('sous_vide_cod_52_c_with_potato_broccoli','Kabeljauw sous-vide 52°C met aardappel & broccoli','Sous-vide cod 52°C with potato & broccoli',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"white_fish","g":170},{"slug":"potato","g":250},{"slug":"broccoli","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY[]::text[],'1. Vacumeer de kabeljauw (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 52°C (30–45 min).
3. Dep droog en bak de velzijde heel kort aan — vis valt snel uit elkaar.
4. Kook de aardappel volgens de verpakking.
5. Stoom of wok de broccoli beetgaar.
6. Snijd aan, breng op smaak en serveer.','1. Vacuum-seal the cod (add herbs and a little oil if you like).
2. Cook sous-vide at 52°C (30–45 min).
3. Pat dry and sear the skin side very briefly — fish falls apart easily.
4. Cook the potato per the package.
5. Steam or stir-fry the broccoli until tender-crisp.
6. Slice, season and serve.','sousvide','52°C','core'),
('sous_vide_cod_52_c_with_potato_green_beans','Kabeljauw sous-vide 52°C met aardappel & sperziebonen','Sous-vide cod 52°C with potato & green beans',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"white_fish","g":170},{"slug":"potato","g":250},{"slug":"green_beans","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY[]::text[],'1. Vacumeer de kabeljauw (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 52°C (30–45 min).
3. Dep droog en bak de velzijde heel kort aan — vis valt snel uit elkaar.
4. Kook de aardappel volgens de verpakking.
5. Stoom of wok de sperziebonen beetgaar.
6. Snijd aan, breng op smaak en serveer.','1. Vacuum-seal the cod (add herbs and a little oil if you like).
2. Cook sous-vide at 52°C (30–45 min).
3. Pat dry and sear the skin side very briefly — fish falls apart easily.
4. Cook the potato per the package.
5. Steam or stir-fry the green beans until tender-crisp.
6. Slice, season and serve.','sousvide','52°C','core'),
('sous_vide_cod_52_c_with_potato_green_asparagus','Kabeljauw sous-vide 52°C met aardappel & groene asperges','Sous-vide cod 52°C with potato & green asparagus',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"white_fish","g":170},{"slug":"potato","g":250},{"slug":"asparagus","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY[]::text[],'1. Vacumeer de kabeljauw (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 52°C (30–45 min).
3. Dep droog en bak de velzijde heel kort aan — vis valt snel uit elkaar.
4. Kook de aardappel volgens de verpakking.
5. Stoom of wok de groene asperges beetgaar.
6. Snijd aan, breng op smaak en serveer.','1. Vacuum-seal the cod (add herbs and a little oil if you like).
2. Cook sous-vide at 52°C (30–45 min).
3. Pat dry and sear the skin side very briefly — fish falls apart easily.
4. Cook the potato per the package.
5. Steam or stir-fry the green asparagus until tender-crisp.
6. Slice, season and serve.','sousvide','52°C','core'),
('sous_vide_cod_52_c_with_potato_spinach','Kabeljauw sous-vide 52°C met aardappel & spinazie','Sous-vide cod 52°C with potato & spinach',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"white_fish","g":170},{"slug":"potato","g":250},{"slug":"spinach","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY[]::text[],'1. Vacumeer de kabeljauw (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 52°C (30–45 min).
3. Dep droog en bak de velzijde heel kort aan — vis valt snel uit elkaar.
4. Kook de aardappel volgens de verpakking.
5. Stoom of wok de spinazie beetgaar.
6. Snijd aan, breng op smaak en serveer.','1. Vacuum-seal the cod (add herbs and a little oil if you like).
2. Cook sous-vide at 52°C (30–45 min).
3. Pat dry and sear the skin side very briefly — fish falls apart easily.
4. Cook the potato per the package.
5. Steam or stir-fry the spinach until tender-crisp.
6. Slice, season and serve.','sousvide','52°C','core'),
('sous_vide_cod_52_c_with_potato_zucchini','Kabeljauw sous-vide 52°C met aardappel & courgette','Sous-vide cod 52°C with potato & zucchini',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"white_fish","g":170},{"slug":"potato","g":250},{"slug":"zucchini","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY[]::text[],'1. Vacumeer de kabeljauw (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 52°C (30–45 min).
3. Dep droog en bak de velzijde heel kort aan — vis valt snel uit elkaar.
4. Kook de aardappel volgens de verpakking.
5. Stoom of wok de courgette beetgaar.
6. Snijd aan, breng op smaak en serveer.','1. Vacuum-seal the cod (add herbs and a little oil if you like).
2. Cook sous-vide at 52°C (30–45 min).
3. Pat dry and sear the skin side very briefly — fish falls apart easily.
4. Cook the potato per the package.
5. Steam or stir-fry the zucchini until tender-crisp.
6. Slice, season and serve.','sousvide','52°C','core'),
('sous_vide_cod_52_c_with_rice_broccoli','Kabeljauw sous-vide 52°C met rijst & broccoli','Sous-vide cod 52°C with rice & broccoli',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"white_fish","g":170},{"slug":"rice_dry","g":70},{"slug":"broccoli","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY[]::text[],'1. Vacumeer de kabeljauw (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 52°C (30–45 min).
3. Dep droog en bak de velzijde heel kort aan — vis valt snel uit elkaar.
4. Kook de rijst volgens de verpakking.
5. Stoom of wok de broccoli beetgaar.
6. Snijd aan, breng op smaak en serveer.','1. Vacuum-seal the cod (add herbs and a little oil if you like).
2. Cook sous-vide at 52°C (30–45 min).
3. Pat dry and sear the skin side very briefly — fish falls apart easily.
4. Cook the rice per the package.
5. Steam or stir-fry the broccoli until tender-crisp.
6. Slice, season and serve.','sousvide','52°C','core'),
('sous_vide_cod_52_c_with_rice_green_beans','Kabeljauw sous-vide 52°C met rijst & sperziebonen','Sous-vide cod 52°C with rice & green beans',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"white_fish","g":170},{"slug":"rice_dry","g":70},{"slug":"green_beans","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY[]::text[],'1. Vacumeer de kabeljauw (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 52°C (30–45 min).
3. Dep droog en bak de velzijde heel kort aan — vis valt snel uit elkaar.
4. Kook de rijst volgens de verpakking.
5. Stoom of wok de sperziebonen beetgaar.
6. Snijd aan, breng op smaak en serveer.','1. Vacuum-seal the cod (add herbs and a little oil if you like).
2. Cook sous-vide at 52°C (30–45 min).
3. Pat dry and sear the skin side very briefly — fish falls apart easily.
4. Cook the rice per the package.
5. Steam or stir-fry the green beans until tender-crisp.
6. Slice, season and serve.','sousvide','52°C','core'),
('sous_vide_cod_52_c_with_rice_green_asparagus','Kabeljauw sous-vide 52°C met rijst & groene asperges','Sous-vide cod 52°C with rice & green asparagus',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"white_fish","g":170},{"slug":"rice_dry","g":70},{"slug":"asparagus","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY[]::text[],'1. Vacumeer de kabeljauw (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 52°C (30–45 min).
3. Dep droog en bak de velzijde heel kort aan — vis valt snel uit elkaar.
4. Kook de rijst volgens de verpakking.
5. Stoom of wok de groene asperges beetgaar.
6. Snijd aan, breng op smaak en serveer.','1. Vacuum-seal the cod (add herbs and a little oil if you like).
2. Cook sous-vide at 52°C (30–45 min).
3. Pat dry and sear the skin side very briefly — fish falls apart easily.
4. Cook the rice per the package.
5. Steam or stir-fry the green asparagus until tender-crisp.
6. Slice, season and serve.','sousvide','52°C','core'),
('sous_vide_cod_52_c_with_rice_spinach','Kabeljauw sous-vide 52°C met rijst & spinazie','Sous-vide cod 52°C with rice & spinach',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"white_fish","g":170},{"slug":"rice_dry","g":70},{"slug":"spinach","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY[]::text[],'1. Vacumeer de kabeljauw (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 52°C (30–45 min).
3. Dep droog en bak de velzijde heel kort aan — vis valt snel uit elkaar.
4. Kook de rijst volgens de verpakking.
5. Stoom of wok de spinazie beetgaar.
6. Snijd aan, breng op smaak en serveer.','1. Vacuum-seal the cod (add herbs and a little oil if you like).
2. Cook sous-vide at 52°C (30–45 min).
3. Pat dry and sear the skin side very briefly — fish falls apart easily.
4. Cook the rice per the package.
5. Steam or stir-fry the spinach until tender-crisp.
6. Slice, season and serve.','sousvide','52°C','core'),
('sous_vide_cod_52_c_with_rice_zucchini','Kabeljauw sous-vide 52°C met rijst & courgette','Sous-vide cod 52°C with rice & zucchini',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"white_fish","g":170},{"slug":"rice_dry","g":70},{"slug":"zucchini","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY[]::text[],'1. Vacumeer de kabeljauw (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 52°C (30–45 min).
3. Dep droog en bak de velzijde heel kort aan — vis valt snel uit elkaar.
4. Kook de rijst volgens de verpakking.
5. Stoom of wok de courgette beetgaar.
6. Snijd aan, breng op smaak en serveer.','1. Vacuum-seal the cod (add herbs and a little oil if you like).
2. Cook sous-vide at 52°C (30–45 min).
3. Pat dry and sear the skin side very briefly — fish falls apart easily.
4. Cook the rice per the package.
5. Steam or stir-fry the zucchini until tender-crisp.
6. Slice, season and serve.','sousvide','52°C','core'),
('sous_vide_cod_52_c_with_quinoa_broccoli','Kabeljauw sous-vide 52°C met quinoa & broccoli','Sous-vide cod 52°C with quinoa & broccoli',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"white_fish","g":170},{"slug":"quinoa_dry","g":70},{"slug":"broccoli","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY[]::text[],'1. Vacumeer de kabeljauw (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 52°C (30–45 min).
3. Dep droog en bak de velzijde heel kort aan — vis valt snel uit elkaar.
4. Kook de quinoa volgens de verpakking.
5. Stoom of wok de broccoli beetgaar.
6. Snijd aan, breng op smaak en serveer.','1. Vacuum-seal the cod (add herbs and a little oil if you like).
2. Cook sous-vide at 52°C (30–45 min).
3. Pat dry and sear the skin side very briefly — fish falls apart easily.
4. Cook the quinoa per the package.
5. Steam or stir-fry the broccoli until tender-crisp.
6. Slice, season and serve.','sousvide','52°C','core'),
('sous_vide_cod_52_c_with_quinoa_green_beans','Kabeljauw sous-vide 52°C met quinoa & sperziebonen','Sous-vide cod 52°C with quinoa & green beans',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"white_fish","g":170},{"slug":"quinoa_dry","g":70},{"slug":"green_beans","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY[]::text[],'1. Vacumeer de kabeljauw (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 52°C (30–45 min).
3. Dep droog en bak de velzijde heel kort aan — vis valt snel uit elkaar.
4. Kook de quinoa volgens de verpakking.
5. Stoom of wok de sperziebonen beetgaar.
6. Snijd aan, breng op smaak en serveer.','1. Vacuum-seal the cod (add herbs and a little oil if you like).
2. Cook sous-vide at 52°C (30–45 min).
3. Pat dry and sear the skin side very briefly — fish falls apart easily.
4. Cook the quinoa per the package.
5. Steam or stir-fry the green beans until tender-crisp.
6. Slice, season and serve.','sousvide','52°C','core'),
('sous_vide_cod_52_c_with_quinoa_green_asparagus','Kabeljauw sous-vide 52°C met quinoa & groene asperges','Sous-vide cod 52°C with quinoa & green asparagus',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"white_fish","g":170},{"slug":"quinoa_dry","g":70},{"slug":"asparagus","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY[]::text[],'1. Vacumeer de kabeljauw (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 52°C (30–45 min).
3. Dep droog en bak de velzijde heel kort aan — vis valt snel uit elkaar.
4. Kook de quinoa volgens de verpakking.
5. Stoom of wok de groene asperges beetgaar.
6. Snijd aan, breng op smaak en serveer.','1. Vacuum-seal the cod (add herbs and a little oil if you like).
2. Cook sous-vide at 52°C (30–45 min).
3. Pat dry and sear the skin side very briefly — fish falls apart easily.
4. Cook the quinoa per the package.
5. Steam or stir-fry the green asparagus until tender-crisp.
6. Slice, season and serve.','sousvide','52°C','core'),
('sous_vide_cod_52_c_with_quinoa_spinach','Kabeljauw sous-vide 52°C met quinoa & spinazie','Sous-vide cod 52°C with quinoa & spinach',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"white_fish","g":170},{"slug":"quinoa_dry","g":70},{"slug":"spinach","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY[]::text[],'1. Vacumeer de kabeljauw (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 52°C (30–45 min).
3. Dep droog en bak de velzijde heel kort aan — vis valt snel uit elkaar.
4. Kook de quinoa volgens de verpakking.
5. Stoom of wok de spinazie beetgaar.
6. Snijd aan, breng op smaak en serveer.','1. Vacuum-seal the cod (add herbs and a little oil if you like).
2. Cook sous-vide at 52°C (30–45 min).
3. Pat dry and sear the skin side very briefly — fish falls apart easily.
4. Cook the quinoa per the package.
5. Steam or stir-fry the spinach until tender-crisp.
6. Slice, season and serve.','sousvide','52°C','core'),
('sous_vide_cod_52_c_with_quinoa_zucchini','Kabeljauw sous-vide 52°C met quinoa & courgette','Sous-vide cod 52°C with quinoa & zucchini',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"white_fish","g":170},{"slug":"quinoa_dry","g":70},{"slug":"zucchini","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY[]::text[],'1. Vacumeer de kabeljauw (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 52°C (30–45 min).
3. Dep droog en bak de velzijde heel kort aan — vis valt snel uit elkaar.
4. Kook de quinoa volgens de verpakking.
5. Stoom of wok de courgette beetgaar.
6. Snijd aan, breng op smaak en serveer.','1. Vacuum-seal the cod (add herbs and a little oil if you like).
2. Cook sous-vide at 52°C (30–45 min).
3. Pat dry and sear the skin side very briefly — fish falls apart easily.
4. Cook the quinoa per the package.
5. Steam or stir-fry the zucchini until tender-crisp.
6. Slice, season and serve.','sousvide','52°C','core'),
('sous_vide_shrimp_57_c_with_sweet_potato_broccoli','Garnalen sous-vide 57°C met zoete aardappel & broccoli','Sous-vide shrimp 57°C with sweet potato & broccoli',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"shrimp","g":150},{"slug":"sweet_potato","g":200},{"slug":"broccoli","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY[]::text[],'1. Vacumeer de garnalen (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 57°C (30 min).
3. Dep droog en bak de velzijde heel kort aan — vis valt snel uit elkaar.
4. Kook de zoete aardappel volgens de verpakking.
5. Stoom of wok de broccoli beetgaar.
6. Snijd aan, breng op smaak en serveer.','1. Vacuum-seal the shrimp (add herbs and a little oil if you like).
2. Cook sous-vide at 57°C (30 min).
3. Pat dry and sear the skin side very briefly — fish falls apart easily.
4. Cook the sweet potato per the package.
5. Steam or stir-fry the broccoli until tender-crisp.
6. Slice, season and serve.','sousvide','57°C','core'),
('sous_vide_shrimp_57_c_with_sweet_potato_green_beans','Garnalen sous-vide 57°C met zoete aardappel & sperziebonen','Sous-vide shrimp 57°C with sweet potato & green beans',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"shrimp","g":150},{"slug":"sweet_potato","g":200},{"slug":"green_beans","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY[]::text[],'1. Vacumeer de garnalen (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 57°C (30 min).
3. Dep droog en bak de velzijde heel kort aan — vis valt snel uit elkaar.
4. Kook de zoete aardappel volgens de verpakking.
5. Stoom of wok de sperziebonen beetgaar.
6. Snijd aan, breng op smaak en serveer.','1. Vacuum-seal the shrimp (add herbs and a little oil if you like).
2. Cook sous-vide at 57°C (30 min).
3. Pat dry and sear the skin side very briefly — fish falls apart easily.
4. Cook the sweet potato per the package.
5. Steam or stir-fry the green beans until tender-crisp.
6. Slice, season and serve.','sousvide','57°C','core'),
('sous_vide_shrimp_57_c_with_sweet_potato_green_asparagus','Garnalen sous-vide 57°C met zoete aardappel & groene asperges','Sous-vide shrimp 57°C with sweet potato & green asparagus',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"shrimp","g":150},{"slug":"sweet_potato","g":200},{"slug":"asparagus","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY[]::text[],'1. Vacumeer de garnalen (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 57°C (30 min).
3. Dep droog en bak de velzijde heel kort aan — vis valt snel uit elkaar.
4. Kook de zoete aardappel volgens de verpakking.
5. Stoom of wok de groene asperges beetgaar.
6. Snijd aan, breng op smaak en serveer.','1. Vacuum-seal the shrimp (add herbs and a little oil if you like).
2. Cook sous-vide at 57°C (30 min).
3. Pat dry and sear the skin side very briefly — fish falls apart easily.
4. Cook the sweet potato per the package.
5. Steam or stir-fry the green asparagus until tender-crisp.
6. Slice, season and serve.','sousvide','57°C','core'),
('sous_vide_shrimp_57_c_with_sweet_potato_spinach','Garnalen sous-vide 57°C met zoete aardappel & spinazie','Sous-vide shrimp 57°C with sweet potato & spinach',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"shrimp","g":150},{"slug":"sweet_potato","g":200},{"slug":"spinach","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY[]::text[],'1. Vacumeer de garnalen (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 57°C (30 min).
3. Dep droog en bak de velzijde heel kort aan — vis valt snel uit elkaar.
4. Kook de zoete aardappel volgens de verpakking.
5. Stoom of wok de spinazie beetgaar.
6. Snijd aan, breng op smaak en serveer.','1. Vacuum-seal the shrimp (add herbs and a little oil if you like).
2. Cook sous-vide at 57°C (30 min).
3. Pat dry and sear the skin side very briefly — fish falls apart easily.
4. Cook the sweet potato per the package.
5. Steam or stir-fry the spinach until tender-crisp.
6. Slice, season and serve.','sousvide','57°C','core'),
('sous_vide_shrimp_57_c_with_sweet_potato_zucchini','Garnalen sous-vide 57°C met zoete aardappel & courgette','Sous-vide shrimp 57°C with sweet potato & zucchini',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"shrimp","g":150},{"slug":"sweet_potato","g":200},{"slug":"zucchini","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY[]::text[],'1. Vacumeer de garnalen (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 57°C (30 min).
3. Dep droog en bak de velzijde heel kort aan — vis valt snel uit elkaar.
4. Kook de zoete aardappel volgens de verpakking.
5. Stoom of wok de courgette beetgaar.
6. Snijd aan, breng op smaak en serveer.','1. Vacuum-seal the shrimp (add herbs and a little oil if you like).
2. Cook sous-vide at 57°C (30 min).
3. Pat dry and sear the skin side very briefly — fish falls apart easily.
4. Cook the sweet potato per the package.
5. Steam or stir-fry the zucchini until tender-crisp.
6. Slice, season and serve.','sousvide','57°C','core'),
('sous_vide_shrimp_57_c_with_potato_broccoli','Garnalen sous-vide 57°C met aardappel & broccoli','Sous-vide shrimp 57°C with potato & broccoli',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"shrimp","g":150},{"slug":"potato","g":250},{"slug":"broccoli","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY[]::text[],'1. Vacumeer de garnalen (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 57°C (30 min).
3. Dep droog en bak de velzijde heel kort aan — vis valt snel uit elkaar.
4. Kook de aardappel volgens de verpakking.
5. Stoom of wok de broccoli beetgaar.
6. Snijd aan, breng op smaak en serveer.','1. Vacuum-seal the shrimp (add herbs and a little oil if you like).
2. Cook sous-vide at 57°C (30 min).
3. Pat dry and sear the skin side very briefly — fish falls apart easily.
4. Cook the potato per the package.
5. Steam or stir-fry the broccoli until tender-crisp.
6. Slice, season and serve.','sousvide','57°C','core'),
('sous_vide_shrimp_57_c_with_potato_green_beans','Garnalen sous-vide 57°C met aardappel & sperziebonen','Sous-vide shrimp 57°C with potato & green beans',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"shrimp","g":150},{"slug":"potato","g":250},{"slug":"green_beans","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY[]::text[],'1. Vacumeer de garnalen (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 57°C (30 min).
3. Dep droog en bak de velzijde heel kort aan — vis valt snel uit elkaar.
4. Kook de aardappel volgens de verpakking.
5. Stoom of wok de sperziebonen beetgaar.
6. Snijd aan, breng op smaak en serveer.','1. Vacuum-seal the shrimp (add herbs and a little oil if you like).
2. Cook sous-vide at 57°C (30 min).
3. Pat dry and sear the skin side very briefly — fish falls apart easily.
4. Cook the potato per the package.
5. Steam or stir-fry the green beans until tender-crisp.
6. Slice, season and serve.','sousvide','57°C','core'),
('sous_vide_shrimp_57_c_with_potato_green_asparagus','Garnalen sous-vide 57°C met aardappel & groene asperges','Sous-vide shrimp 57°C with potato & green asparagus',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"shrimp","g":150},{"slug":"potato","g":250},{"slug":"asparagus","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY[]::text[],'1. Vacumeer de garnalen (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 57°C (30 min).
3. Dep droog en bak de velzijde heel kort aan — vis valt snel uit elkaar.
4. Kook de aardappel volgens de verpakking.
5. Stoom of wok de groene asperges beetgaar.
6. Snijd aan, breng op smaak en serveer.','1. Vacuum-seal the shrimp (add herbs and a little oil if you like).
2. Cook sous-vide at 57°C (30 min).
3. Pat dry and sear the skin side very briefly — fish falls apart easily.
4. Cook the potato per the package.
5. Steam or stir-fry the green asparagus until tender-crisp.
6. Slice, season and serve.','sousvide','57°C','core'),
('sous_vide_shrimp_57_c_with_potato_spinach','Garnalen sous-vide 57°C met aardappel & spinazie','Sous-vide shrimp 57°C with potato & spinach',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"shrimp","g":150},{"slug":"potato","g":250},{"slug":"spinach","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY[]::text[],'1. Vacumeer de garnalen (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 57°C (30 min).
3. Dep droog en bak de velzijde heel kort aan — vis valt snel uit elkaar.
4. Kook de aardappel volgens de verpakking.
5. Stoom of wok de spinazie beetgaar.
6. Snijd aan, breng op smaak en serveer.','1. Vacuum-seal the shrimp (add herbs and a little oil if you like).
2. Cook sous-vide at 57°C (30 min).
3. Pat dry and sear the skin side very briefly — fish falls apart easily.
4. Cook the potato per the package.
5. Steam or stir-fry the spinach until tender-crisp.
6. Slice, season and serve.','sousvide','57°C','core'),
('sous_vide_shrimp_57_c_with_potato_zucchini','Garnalen sous-vide 57°C met aardappel & courgette','Sous-vide shrimp 57°C with potato & zucchini',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"shrimp","g":150},{"slug":"potato","g":250},{"slug":"zucchini","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY[]::text[],'1. Vacumeer de garnalen (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 57°C (30 min).
3. Dep droog en bak de velzijde heel kort aan — vis valt snel uit elkaar.
4. Kook de aardappel volgens de verpakking.
5. Stoom of wok de courgette beetgaar.
6. Snijd aan, breng op smaak en serveer.','1. Vacuum-seal the shrimp (add herbs and a little oil if you like).
2. Cook sous-vide at 57°C (30 min).
3. Pat dry and sear the skin side very briefly — fish falls apart easily.
4. Cook the potato per the package.
5. Steam or stir-fry the zucchini until tender-crisp.
6. Slice, season and serve.','sousvide','57°C','core'),
('sous_vide_shrimp_57_c_with_rice_broccoli','Garnalen sous-vide 57°C met rijst & broccoli','Sous-vide shrimp 57°C with rice & broccoli',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"shrimp","g":150},{"slug":"rice_dry","g":70},{"slug":"broccoli","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY[]::text[],'1. Vacumeer de garnalen (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 57°C (30 min).
3. Dep droog en bak de velzijde heel kort aan — vis valt snel uit elkaar.
4. Kook de rijst volgens de verpakking.
5. Stoom of wok de broccoli beetgaar.
6. Snijd aan, breng op smaak en serveer.','1. Vacuum-seal the shrimp (add herbs and a little oil if you like).
2. Cook sous-vide at 57°C (30 min).
3. Pat dry and sear the skin side very briefly — fish falls apart easily.
4. Cook the rice per the package.
5. Steam or stir-fry the broccoli until tender-crisp.
6. Slice, season and serve.','sousvide','57°C','core'),
('sous_vide_shrimp_57_c_with_rice_green_beans','Garnalen sous-vide 57°C met rijst & sperziebonen','Sous-vide shrimp 57°C with rice & green beans',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"shrimp","g":150},{"slug":"rice_dry","g":70},{"slug":"green_beans","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY[]::text[],'1. Vacumeer de garnalen (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 57°C (30 min).
3. Dep droog en bak de velzijde heel kort aan — vis valt snel uit elkaar.
4. Kook de rijst volgens de verpakking.
5. Stoom of wok de sperziebonen beetgaar.
6. Snijd aan, breng op smaak en serveer.','1. Vacuum-seal the shrimp (add herbs and a little oil if you like).
2. Cook sous-vide at 57°C (30 min).
3. Pat dry and sear the skin side very briefly — fish falls apart easily.
4. Cook the rice per the package.
5. Steam or stir-fry the green beans until tender-crisp.
6. Slice, season and serve.','sousvide','57°C','core'),
('sous_vide_shrimp_57_c_with_rice_green_asparagus','Garnalen sous-vide 57°C met rijst & groene asperges','Sous-vide shrimp 57°C with rice & green asparagus',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"shrimp","g":150},{"slug":"rice_dry","g":70},{"slug":"asparagus","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY[]::text[],'1. Vacumeer de garnalen (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 57°C (30 min).
3. Dep droog en bak de velzijde heel kort aan — vis valt snel uit elkaar.
4. Kook de rijst volgens de verpakking.
5. Stoom of wok de groene asperges beetgaar.
6. Snijd aan, breng op smaak en serveer.','1. Vacuum-seal the shrimp (add herbs and a little oil if you like).
2. Cook sous-vide at 57°C (30 min).
3. Pat dry and sear the skin side very briefly — fish falls apart easily.
4. Cook the rice per the package.
5. Steam or stir-fry the green asparagus until tender-crisp.
6. Slice, season and serve.','sousvide','57°C','core'),
('sous_vide_shrimp_57_c_with_rice_spinach','Garnalen sous-vide 57°C met rijst & spinazie','Sous-vide shrimp 57°C with rice & spinach',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"shrimp","g":150},{"slug":"rice_dry","g":70},{"slug":"spinach","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY[]::text[],'1. Vacumeer de garnalen (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 57°C (30 min).
3. Dep droog en bak de velzijde heel kort aan — vis valt snel uit elkaar.
4. Kook de rijst volgens de verpakking.
5. Stoom of wok de spinazie beetgaar.
6. Snijd aan, breng op smaak en serveer.','1. Vacuum-seal the shrimp (add herbs and a little oil if you like).
2. Cook sous-vide at 57°C (30 min).
3. Pat dry and sear the skin side very briefly — fish falls apart easily.
4. Cook the rice per the package.
5. Steam or stir-fry the spinach until tender-crisp.
6. Slice, season and serve.','sousvide','57°C','core'),
('sous_vide_shrimp_57_c_with_rice_zucchini','Garnalen sous-vide 57°C met rijst & courgette','Sous-vide shrimp 57°C with rice & zucchini',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"shrimp","g":150},{"slug":"rice_dry","g":70},{"slug":"zucchini","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY[]::text[],'1. Vacumeer de garnalen (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 57°C (30 min).
3. Dep droog en bak de velzijde heel kort aan — vis valt snel uit elkaar.
4. Kook de rijst volgens de verpakking.
5. Stoom of wok de courgette beetgaar.
6. Snijd aan, breng op smaak en serveer.','1. Vacuum-seal the shrimp (add herbs and a little oil if you like).
2. Cook sous-vide at 57°C (30 min).
3. Pat dry and sear the skin side very briefly — fish falls apart easily.
4. Cook the rice per the package.
5. Steam or stir-fry the zucchini until tender-crisp.
6. Slice, season and serve.','sousvide','57°C','core'),
('sous_vide_shrimp_57_c_with_quinoa_broccoli','Garnalen sous-vide 57°C met quinoa & broccoli','Sous-vide shrimp 57°C with quinoa & broccoli',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"shrimp","g":150},{"slug":"quinoa_dry","g":70},{"slug":"broccoli","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY[]::text[],'1. Vacumeer de garnalen (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 57°C (30 min).
3. Dep droog en bak de velzijde heel kort aan — vis valt snel uit elkaar.
4. Kook de quinoa volgens de verpakking.
5. Stoom of wok de broccoli beetgaar.
6. Snijd aan, breng op smaak en serveer.','1. Vacuum-seal the shrimp (add herbs and a little oil if you like).
2. Cook sous-vide at 57°C (30 min).
3. Pat dry and sear the skin side very briefly — fish falls apart easily.
4. Cook the quinoa per the package.
5. Steam or stir-fry the broccoli until tender-crisp.
6. Slice, season and serve.','sousvide','57°C','core'),
('sous_vide_shrimp_57_c_with_quinoa_green_beans','Garnalen sous-vide 57°C met quinoa & sperziebonen','Sous-vide shrimp 57°C with quinoa & green beans',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"shrimp","g":150},{"slug":"quinoa_dry","g":70},{"slug":"green_beans","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY[]::text[],'1. Vacumeer de garnalen (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 57°C (30 min).
3. Dep droog en bak de velzijde heel kort aan — vis valt snel uit elkaar.
4. Kook de quinoa volgens de verpakking.
5. Stoom of wok de sperziebonen beetgaar.
6. Snijd aan, breng op smaak en serveer.','1. Vacuum-seal the shrimp (add herbs and a little oil if you like).
2. Cook sous-vide at 57°C (30 min).
3. Pat dry and sear the skin side very briefly — fish falls apart easily.
4. Cook the quinoa per the package.
5. Steam or stir-fry the green beans until tender-crisp.
6. Slice, season and serve.','sousvide','57°C','core'),
('sous_vide_shrimp_57_c_with_quinoa_green_asparagus','Garnalen sous-vide 57°C met quinoa & groene asperges','Sous-vide shrimp 57°C with quinoa & green asparagus',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"shrimp","g":150},{"slug":"quinoa_dry","g":70},{"slug":"asparagus","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY[]::text[],'1. Vacumeer de garnalen (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 57°C (30 min).
3. Dep droog en bak de velzijde heel kort aan — vis valt snel uit elkaar.
4. Kook de quinoa volgens de verpakking.
5. Stoom of wok de groene asperges beetgaar.
6. Snijd aan, breng op smaak en serveer.','1. Vacuum-seal the shrimp (add herbs and a little oil if you like).
2. Cook sous-vide at 57°C (30 min).
3. Pat dry and sear the skin side very briefly — fish falls apart easily.
4. Cook the quinoa per the package.
5. Steam or stir-fry the green asparagus until tender-crisp.
6. Slice, season and serve.','sousvide','57°C','core'),
('sous_vide_shrimp_57_c_with_quinoa_spinach','Garnalen sous-vide 57°C met quinoa & spinazie','Sous-vide shrimp 57°C with quinoa & spinach',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"shrimp","g":150},{"slug":"quinoa_dry","g":70},{"slug":"spinach","g":100},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY[]::text[],'1. Vacumeer de garnalen (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 57°C (30 min).
3. Dep droog en bak de velzijde heel kort aan — vis valt snel uit elkaar.
4. Kook de quinoa volgens de verpakking.
5. Stoom of wok de spinazie beetgaar.
6. Snijd aan, breng op smaak en serveer.','1. Vacuum-seal the shrimp (add herbs and a little oil if you like).
2. Cook sous-vide at 57°C (30 min).
3. Pat dry and sear the skin side very briefly — fish falls apart easily.
4. Cook the quinoa per the package.
5. Steam or stir-fry the spinach until tender-crisp.
6. Slice, season and serve.','sousvide','57°C','core'),
('sous_vide_shrimp_57_c_with_quinoa_zucchini','Garnalen sous-vide 57°C met quinoa & courgette','Sous-vide shrimp 57°C with quinoa & zucchini',ARRAY['dinner','lunch'],ARRAY['cut','maintain'],'[{"slug":"shrimp","g":150},{"slug":"quinoa_dry","g":70},{"slug":"zucchini","g":120},{"slug":"olive_oil","g":7}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY[]::text[],'1. Vacumeer de garnalen (eventueel met een takje kruiden en wat olie).
2. Gaar sous-vide op 57°C (30 min).
3. Dep droog en bak de velzijde heel kort aan — vis valt snel uit elkaar.
4. Kook de quinoa volgens de verpakking.
5. Stoom of wok de courgette beetgaar.
6. Snijd aan, breng op smaak en serveer.','1. Vacuum-seal the shrimp (add herbs and a little oil if you like).
2. Cook sous-vide at 57°C (30 min).
3. Pat dry and sear the skin side very briefly — fish falls apart easily.
4. Cook the quinoa per the package.
5. Steam or stir-fry the zucchini until tender-crisp.
6. Slice, season and serve.','sousvide','57°C','core'),
('soft_cooked_egg_63_c_with_spinach','Zachtgekookt ei (63°C) met spinazie','Soft-cooked egg (63°C) with spinach',ARRAY['breakfast','lunch'],ARRAY['cut','maintain'],'[{"slug":"egg","g":120},{"slug":"spinach","g":60},{"slug":"olive_oil","g":3}]'::jsonb,ARRAY['sousvide','high_protein']::text[],ARRAY[]::text[],'1. Gaar de eieren sous-vide op 63°C (45–60 min) voor een romige dooier.
2. Wok of slink de spinazie kort in de olijfolie.
3. Pel de eieren voorzichtig en leg ze op de spinazie.
4. Breng op smaak met peper en zout.','1. Cook the eggs sous-vide at 63°C (45–60 min) for a creamy yolk.
2. Wilt the spinach briefly in the olive oil.
3. Peel the eggs carefully and set them on the spinach.
4. Season with salt and pepper.','sousvide','63°C','core')
on conflict (slug) do update set name_nl=excluded.name_nl,name_en=excluded.name_en,moments=excluded.moments,goals=excluded.goals,items=excluded.items,tags=excluded.tags,prefs=excluded.prefs,steps=excluded.steps,steps_en=excluded.steps_en,technique=excluded.technique,temp=excluded.temp;
commit;
