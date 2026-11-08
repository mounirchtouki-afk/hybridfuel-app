-- AI-tegoed per account (kostenteller + zichtbaar tegoed).
-- Draai dit één keer in de Supabase SQL Editor.
-- De server schrijft hierin met de service-role key; clients hebben GEEN toegang (RLS aan, geen policy).

create table if not exists public.ai_usage (
  user_id      uuid primary key references auth.users(id) on delete cascade,
  period_start timestamptz not null default now(),
  mealplans    integer     not null default 0,
  scans        integer     not null default 0,
  reviews      integer     not null default 0,
  cost_cents   integer     not null default 0,
  updated_at   timestamptz not null default now()
);

alter table public.ai_usage enable row level security;
-- Bewust GEEN policies: alleen de service-role (server) leest/schrijft. Clients zien niks direct;
-- de app krijgt het saldo via het /api/plan-antwoord.

-- Index niet nodig (primary key op user_id volstaat).
