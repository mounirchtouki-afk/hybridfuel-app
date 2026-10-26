-- Draai dit eenmalig in Supabase → SQL Editor (bereidingswijze in eigen recepten):
alter table public.recipes add column if not exists steps text;
