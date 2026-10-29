-- HybridFuel — ALLE openstaande migraties (gym-editie + #3).
-- Plak dit HELE bestand in de Supabase SQL-editor en klik Run.
-- Alles is idempotent: veilig om (opnieuw) te draaien. Volgorde klopt.


-- ============================================================
-- gym-sessions-and-theme.sql
-- ============================================================
-- ÉÉN KEER DRAAIEN in de Supabase SQL-editor. Additief, RLS-beveiligd, onzichtbaar voor de live-app.
-- 1) PT-agenda-tabel  2) thema-kolom op org_config  3) test-gym op een licht thema (demo).

-- 1) PT-agenda
create table if not exists public.org_sessions (
  id uuid primary key default gen_random_uuid(),
  org_id uuid not null references public.orgs(id) on delete cascade,
  member_id uuid null,                       -- NULL = hele groep; anders auth_user_id van het lid
  title text not null,
  starts_at timestamptz not null,
  duration_min int null,
  note text null,
  created_by uuid not null,
  created_at timestamptz not null default now()
);
create index if not exists org_sessions_org_time_idx on public.org_sessions (org_id, starts_at);
alter table public.org_sessions enable row level security;

drop policy if exists "sessions read" on public.org_sessions;
create policy "sessions read" on public.org_sessions for select using (
  org_id = public.current_org_id() and (public.is_coach() or member_id is null or member_id = auth.uid())
);
drop policy if exists "sessions write coach" on public.org_sessions;
create policy "sessions write coach" on public.org_sessions for all
  using (public.is_coach() and org_id = public.current_org_id())
  with check (public.is_coach() and org_id = public.current_org_id());

-- 2) Thema-kolom (volledige white-label: template + accentkleur + eventuele losse overrides)
alter table public.org_config add column if not exists theme jsonb;

-- 3) Demo: zet de test-sportschool op een LICHT thema met groen accent (achtergrond niet meer zwart)
update public.org_config
  set theme = '{"template":"light","accent":"#16A34A"}'::jsonb
  where org_id = (select id from public.orgs where slug = 'testgym');

select 'agenda + theme ok' as status;


-- ============================================================
-- gym-tiers-and-classes.sql
-- ============================================================
-- ÉÉN KEER DRAAIEN in de Supabase SQL-editor. Additief, RLS-beveiligd, onzichtbaar voor de live-app.
-- Tiers (basis/pro) + per-lid lestoegang + groepsrooster-tabel.

-- Tier + lestoegang op leden
alter table public.org_members add column if not exists member_tier text not null default 'pro';
alter table public.org_members add column if not exists class_access uuid[] null;  -- null = alle lessen toegestaan

-- Groepsrooster (lessen)
create table if not exists public.org_classes (
  id uuid primary key default gen_random_uuid(),
  org_id uuid not null references public.orgs(id) on delete cascade,
  name text not null,
  day_of_week int not null,            -- 0=zo .. 6=za
  start_time text not null,            -- "19:00"
  duration_min int null,
  created_by uuid not null,
  created_at timestamptz not null default now()
);
create index if not exists org_classes_org_idx on public.org_classes (org_id, day_of_week);
alter table public.org_classes enable row level security;

drop policy if exists "classes read" on public.org_classes;
create policy "classes read" on public.org_classes for select using (org_id = public.current_org_id());
drop policy if exists "classes write coach" on public.org_classes;
create policy "classes write coach" on public.org_classes for all
  using (public.is_coach() and org_id = public.current_org_id())
  with check (public.is_coach() and org_id = public.current_org_id());

select 'tiers + classes ok' as status;


-- ============================================================
-- gym-roles.sql
-- ============================================================
-- ÉÉN KEER DRAAIEN. Rollen & rechten: eigenaar (volledig) + coaches met per-module rechten.
-- Modules zijn datagedreven/uitbreidbaar (superuser zet 'beschikbare modules' per org; bv. later 'billing').

-- Eigenaar-vlag + per-coach rechten op org_members (coaches zijn role='coach'; eigenaar = is_owner=true).
alter table public.org_members add column if not exists is_owner boolean not null default false;
alter table public.org_members add column if not exists perms text[] null;  -- null = (coach) niets; eigenaar negeert dit

-- Beschikbare modules per org (superuser-gestuurd). null = standaardset in de app.
alter table public.org_config add column if not exists enabled_modules text[] null;

-- De bestaande coach van de test-sportschool tot eigenaar maken.
update public.org_members set is_owner = true
  where role = 'coach' and org_id = (select id from public.orgs where slug = 'testgym');

select 'roles ok' as status;


-- ============================================================
-- gym-coach-note.sql
-- ============================================================
-- ÉÉN KEER DRAAIEN. Coach-notitie per lid (voor de coach zelf).
alter table public.org_members add column if not exists coach_note text;
select 'coach_note ok' as status;


-- ============================================================
-- gym-roles-notes-override.sql
-- ============================================================
-- ÉÉN KEER DRAAIEN. Bundelt: coach-notitie, rollen & rechten, per-lid formule-override.

-- Coach-notitie per lid
alter table public.org_members add column if not exists coach_note text;

-- Rollen & rechten (eigenaar + per-coach modules) + beschikbare modules per org (superuser)
alter table public.org_members add column if not exists is_owner boolean not null default false;
alter table public.org_members add column if not exists perms text[] null;
alter table public.org_config  add column if not exists enabled_modules text[] null;

-- Per-lid formule-override (leeg = standaard van de sportschool)
alter table public.org_members add column if not exists calc_override jsonb null;

-- De bestaande coach van de test-sportschool tot eigenaar maken
update public.org_members set is_owner = true
  where role = 'coach' and org_id = (select id from public.orgs where slug = 'testgym');

select 'roles + notes + override ok' as status;


-- ============================================================
-- gym-plans-enrollments.sql
-- ============================================================
-- ÉÉN KEER DRAAIEN. Abonnementen (gym-defined) + lescapaciteit + inschrijvingen.

-- Abonnementen: de sportschool maakt ze zelf (eigen naam), koppelt welke lessen erin zitten
-- en of persoonlijke PT is inbegrepen.
create table if not exists public.org_plans (
  id uuid primary key default gen_random_uuid(),
  org_id uuid not null references public.orgs(id) on delete cascade,
  name text not null,
  pt_included boolean not null default false,
  class_ids uuid[] null,                 -- welke lessen in dit abo zitten (null = alle)
  created_at timestamptz not null default now()
);
create index if not exists org_plans_org_idx on public.org_plans (org_id);
alter table public.org_plans enable row level security;
drop policy if exists "plans read" on public.org_plans;
create policy "plans read" on public.org_plans for select using (org_id = public.current_org_id());
drop policy if exists "plans write coach" on public.org_plans;
create policy "plans write coach" on public.org_plans for all
  using (public.is_coach() and org_id = public.current_org_id())
  with check (public.is_coach() and org_id = public.current_org_id());

-- Lid -> abo
alter table public.org_members add column if not exists plan_id uuid null;

-- Lescapaciteit (null = onbeperkt)
alter table public.org_classes add column if not exists capacity int null;

-- Inschrijvingen per lesmoment (datum). Capaciteit wordt in de app geteld.
create table if not exists public.class_enrollments (
  id uuid primary key default gen_random_uuid(),
  org_id uuid not null references public.orgs(id) on delete cascade,
  class_id uuid not null references public.org_classes(id) on delete cascade,
  occur_date date not null,
  member_user_id uuid not null,
  created_at timestamptz not null default now(),
  unique (class_id, occur_date, member_user_id)
);
create index if not exists class_enroll_idx on public.class_enrollments (class_id, occur_date);
alter table public.class_enrollments enable row level security;
drop policy if exists "enroll read" on public.class_enrollments;
create policy "enroll read" on public.class_enrollments for select using (org_id = public.current_org_id());
drop policy if exists "enroll write" on public.class_enrollments;
create policy "enroll write" on public.class_enrollments for all
  using (org_id = public.current_org_id() and (member_user_id = auth.uid() or public.is_coach()))
  with check (org_id = public.current_org_id() and (member_user_id = auth.uid() or public.is_coach()));

select 'plans + enrollments ok' as status;


-- ============================================================
-- products-meal-types.sql
-- ============================================================
-- #3 — maaltijdplan uit eigen producten: tag producten per maaltijdtype.
-- Lege/ontbrekende lijst = product is in elke maaltijd bruikbaar.
-- Idempotent: veilig om opnieuw te draaien.

alter table public.products
  add column if not exists meal_types text[] not null default '{}';

-- Optioneel: snelle filtering op maaltijdtype (GIN-index op de array).
create index if not exists products_meal_types_idx
  on public.products using gin (meal_types);

