-- ============================================================================
-- HybridFuel gerechten-bibliotheek (software-first plan-bouw, AI als vangnet)
-- Twee tabellen: ingredients (macro-referentie) + dishes (recepten).
-- Macro's van een gerecht worden berekend uit de ingrediënten (view dish_macros).
-- ============================================================================

-- 1) INGREDIËNTEN — macro's per 100 g/ml. De referentie waar alles op rekent.
create table if not exists public.ingredients (
  id          bigint generated always as identity primary key,
  slug        text unique not null,              -- stabiele sleutel, bv. 'chicken_breast'
  name_nl     text not null,
  name_en     text not null,
  kcal        numeric not null,                  -- per 100 g/ml
  protein     numeric not null default 0,
  carbs       numeric not null default 0,
  fat         numeric not null default 0,
  unit        text not null default 'g',         -- g | ml
  category    text,                              -- vlees/zuivel/granen/groente/...
  source      text not null default 'core',      -- core | user
  created_by  uuid references auth.users(id) on delete set null,
  created_at  timestamptz not null default now()
);

-- 2) GERECHTEN — een recept = naam + eetmoment(en) + doel-fit + ingrediënten (grammen).
create table if not exists public.dishes (
  id          bigint generated always as identity primary key,
  slug        text unique,
  name_nl     text not null,
  name_en     text not null,
  moments     text[] not null default '{}',      -- breakfast | lunch | dinner | snack
  goals       text[] not null default '{all}',   -- all | cut | maintain | gain
  items       jsonb not null default '[]',        -- [{ "slug":"chicken_breast", "g":150 }, ...]
  tags        text[] not null default '{}',       -- high_protein | vegetarian | vegan | quick | lactosefree | ...
  prefs       text[] not null default '{}',       -- koppeling met onboarding-chips, bv. {'chickenwrap'}
  source      text not null default 'core',       -- core | user | gym
  org_id      uuid,                               -- gevuld als een gym 'm deelt (gym-bibliotheek)
  created_by  uuid references auth.users(id) on delete set null,
  active      boolean not null default true,
  created_at  timestamptz not null default now()
);
create index if not exists dishes_moments_idx on public.dishes using gin (moments);
create index if not exists dishes_prefs_idx   on public.dishes using gin (prefs);
create index if not exists dishes_source_idx  on public.dishes (source);

-- 3) BEREKENDE MACRO'S — som over de ingrediënten (geen handmatig cijfer meer).
create or replace view public.dish_macros as
select d.id,
       round(sum(i.kcal    * (it->>'g')::numeric / 100.0))      as kcal,
       round(sum(i.protein * (it->>'g')::numeric / 100.0))      as protein,
       round(sum(i.carbs   * (it->>'g')::numeric / 100.0))      as carbs,
       round(sum(i.fat     * (it->>'g')::numeric / 100.0))      as fat
from public.dishes d
cross join lateral jsonb_array_elements(d.items) it
join public.ingredients i on i.slug = it->>'slug'
group by d.id;

-- 4) RLS — iedereen leest de 'core'-set; een lid leest zijn gym-set; eigen rijen leest/schrijft de maker.
alter table public.ingredients enable row level security;
alter table public.dishes      enable row level security;

drop policy if exists "ingredients read" on public.ingredients;
create policy "ingredients read" on public.ingredients for select
  using (source = 'core' or created_by = auth.uid());
drop policy if exists "ingredients write own" on public.ingredients;
create policy "ingredients write own" on public.ingredients for all
  using (created_by = auth.uid()) with check (created_by = auth.uid());

drop policy if exists "dishes read" on public.dishes;
create policy "dishes read" on public.dishes for select
  using (source = 'core' or created_by = auth.uid()
         or (source = 'gym' and org_id = public.current_org_id()));
drop policy if exists "dishes write own" on public.dishes;
create policy "dishes write own" on public.dishes for all
  using (created_by = auth.uid()) with check (created_by = auth.uid());

-- Leesrechten voor de app (anon = uitgelogd/plan-endpoint, authenticated = ingelogd).
grant select on public.ingredients to anon, authenticated;
grant select on public.dishes      to anon, authenticated;
grant select on public.dish_macros to anon, authenticated;

-- De 'core'-set (door ons gevuld) en gym-gedeelde gerechten worden server-side
-- (service-role) geschreven; die omzeilt RLS. Leden zien ze via de read-policy's.
