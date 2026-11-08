-- Recept-moment-koppeling: welke eetmomenten telt een recept mee in de mealplan.
-- Draai dit één keer in de Supabase SQL Editor.
--
-- Zonder deze kolom werkt de app gewoon door (hij valt terug op het bestaande
-- 'type'-veld); mét de kolom kun je een recept aan meerdere momenten hangen.

alter table public.recipes
  add column if not exists meal_types jsonb not null default '[]'::jsonb;

-- Backfill: bestaande recepten krijgen hun huidige type als startmoment,
-- zodat een "Diner"-recept meteen bij Diner meetelt. Niemand hoeft te hertaggen.
update public.recipes
   set meal_types = to_jsonb(array[type])
 where (meal_types is null or meal_types = '[]'::jsonb)
   and type is not null;
