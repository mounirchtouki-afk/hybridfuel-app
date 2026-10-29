-- ============================================================================
-- HybridFuel — Sportschool/B2B pilot: datamodel + RLS (fase 1, fundering)
-- Additief: raakt de bestaande consumenten-app niet. Gewone gebruikers hebben
-- geen org_members-rij en gedragen zich exact zoals nu.
-- Toepassen via de Supabase SQL-editor. Eerst reviewen, dan draaien + testen.
-- ============================================================================

-- gen_random_uuid()
create extension if not exists pgcrypto;

-- ---------------------------------------------------------------------------
-- 1. Organisaties (sportscholen)
-- ---------------------------------------------------------------------------
create table if not exists public.orgs (
  id         uuid primary key default gen_random_uuid(),
  slug       text unique not null,          -- join-link: /join/<slug>
  name       text not null,
  created_at timestamptz default now()
);

-- Per-org config: white-label + rekenprofiel + juridisch akkoord
create table if not exists public.org_config (
  org_id            uuid primary key references public.orgs(id) on delete cascade,
  brand_color       text default '#E11D48',
  logo_url          text,
  -- rekenprofiel, bv. {"bmr":"mifflin","activity":{...},"macros":{...},"goal":{...}}
  calc_profile      jsonb default '{}'::jsonb,
  terms_accepted_at timestamptz,            -- sportschool tekent voor eigen verantwoordelijkheid
  terms_accepted_by uuid references auth.users(id),
  updated_at        timestamptz default now()
);

-- ---------------------------------------------------------------------------
-- 2. Leden + coaches van een org, gekoppeld aan een auth-user
-- ---------------------------------------------------------------------------
create table if not exists public.org_members (
  id            uuid primary key default gen_random_uuid(),
  org_id        uuid not null references public.orgs(id) on delete cascade,
  auth_user_id  uuid not null references auth.users(id) on delete cascade,
  role          text not null check (role in ('coach','member')),
  display_name  text,
  code_hash     text,                       -- gehashte login-code (alleen leden); nooit de kale code opslaan
  active        boolean default true,
  created_at    timestamptz default now(),
  unique (auth_user_id)                      -- 1 user = 1 org-rol (voor de pilot)
);
create index if not exists org_members_org_idx on public.org_members (org_id);

-- ---------------------------------------------------------------------------
-- 3. Doorzoekbare voortgangssamenvatting per lid (door de app weggeschreven,
--    zodat het coach-dashboard snel is zonder de app_kv-blobs te hoeven lezen)
-- ---------------------------------------------------------------------------
create table if not exists public.member_progress (
  user_id      uuid primary key references auth.users(id) on delete cascade,
  org_id       uuid references public.orgs(id) on delete cascade,
  adherence    numeric,                      -- 0-100, 7-daags (maaltijden/trainingen gevolgd)
  weight       numeric,
  weight_trend numeric,                       -- verschil t.o.v. vorige meting
  last_active  timestamptz,
  updated_at   timestamptz default now()
);
create index if not exists member_progress_org_idx on public.member_progress (org_id);

-- ---------------------------------------------------------------------------
-- 4. Helper-functies (SECURITY DEFINER) om RLS-recursie op org_members te
--    vermijden. Ze draaien met verhoogde rechten maar lezen alleen o.b.v.
--    auth.uid() van de aanroeper.
-- ---------------------------------------------------------------------------
create or replace function public.current_org_id()
returns uuid language sql security definer stable set search_path = public as $$
  select org_id from public.org_members where auth_user_id = auth.uid() limit 1;
$$;

create or replace function public.is_coach()
returns boolean language sql security definer stable set search_path = public as $$
  select exists (
    select 1 from public.org_members
    where auth_user_id = auth.uid() and role = 'coach' and active
  );
$$;

-- ---------------------------------------------------------------------------
-- 5. RLS aanzetten + policies
--    Kern: een lid ziet alleen zichzelf; een coach ziet alles van ZIJN org,
--    nooit daarbuiten. Schrijven naar config/leden mag alleen de coach.
-- ---------------------------------------------------------------------------
alter table public.orgs            enable row level security;
alter table public.org_config      enable row level security;
alter table public.org_members     enable row level security;
alter table public.member_progress enable row level security;

-- orgs: leden/coaches lezen hun eigen org (branding van de join-pagina gaat
-- vóór login via een aparte publieke functie, niet via deze policy).
drop policy if exists "org read own" on public.orgs;
create policy "org read own" on public.orgs
  for select using (id = public.current_org_id());

-- org_config: lezen door de org; wijzigen alleen door de coach van die org.
drop policy if exists "config read own" on public.org_config;
create policy "config read own" on public.org_config
  for select using (org_id = public.current_org_id());

drop policy if exists "config write coach" on public.org_config;
create policy "config write coach" on public.org_config
  for update using (public.is_coach() and org_id = public.current_org_id())
  with check (public.is_coach() and org_id = public.current_org_id());

-- org_members: een lid ziet alleen zijn eigen rij; een coach ziet alle leden
-- van zijn org. Aanmaken/wijzigen van leden doet de coach (of server-functie).
drop policy if exists "members read" on public.org_members;
create policy "members read" on public.org_members
  for select using (
    auth_user_id = auth.uid()
    or (public.is_coach() and org_id = public.current_org_id())
  );

drop policy if exists "members write coach" on public.org_members;
create policy "members write coach" on public.org_members
  for all using (public.is_coach() and org_id = public.current_org_id())
  with check (public.is_coach() and org_id = public.current_org_id());

-- member_progress: lid leest + schrijft zijn eigen samenvatting; coach leest
-- (alleen-lezen) alle leden van zijn org.
drop policy if exists "progress read" on public.member_progress;
create policy "progress read" on public.member_progress
  for select using (
    user_id = auth.uid()
    or (public.is_coach() and org_id = public.current_org_id())
  );

drop policy if exists "progress upsert own" on public.member_progress;
create policy "progress insert own" on public.member_progress
  for insert with check (user_id = auth.uid());
create policy "progress update own" on public.member_progress
  for update using (user_id = auth.uid()) with check (user_id = auth.uid());

-- ---------------------------------------------------------------------------
-- Let op: het AANMAKEN van orgs en van de auth-users per lid gebeurt
-- server-side met de service-role (coach-flow / edge-functie), niet via deze
-- client-policies. De bestaande app_kv-tabel blijft "eigen rijen only" — de
-- coach leest NIET de ruwe app_kv-blobs, alleen member_progress.
-- ============================================================================
