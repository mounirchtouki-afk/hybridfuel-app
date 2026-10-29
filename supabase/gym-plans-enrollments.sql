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
