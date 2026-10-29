-- PT-agenda voor sportscholen: een coach plant sessies; leden zien hun sessies.
-- Additief, RLS-beveiligd, onzichtbaar voor de consumenten-app. Geen credits/boeking-economie.
-- member_id = auth-user-uuid van het lid; NULL = hele groep (alle leden van de org).

create table if not exists public.org_sessions (
  id uuid primary key default gen_random_uuid(),
  org_id uuid not null references public.orgs(id) on delete cascade,
  member_id uuid null,                       -- NULL = hele groep; anders auth_user_id van het lid
  title text not null,
  starts_at timestamptz not null,
  duration_min int null,
  note text null,
  created_by uuid not null,                  -- auth_user_id van de coach
  created_at timestamptz not null default now()
);

create index if not exists org_sessions_org_time_idx on public.org_sessions (org_id, starts_at);
create index if not exists org_sessions_member_idx on public.org_sessions (member_id);

alter table public.org_sessions enable row level security;

-- Lezen: coach ziet alle sessies van zijn org; lid ziet groeps-sessies + eigen sessies.
drop policy if exists "sessions read" on public.org_sessions;
create policy "sessions read" on public.org_sessions
  for select using (
    org_id = public.current_org_id()
    and (public.is_coach() or member_id is null or member_id = auth.uid())
  );

-- Schrijven (aanmaken/wijzigen/verwijderen): alleen de coach van de org.
drop policy if exists "sessions write coach" on public.org_sessions;
create policy "sessions write coach" on public.org_sessions
  for all using (public.is_coach() and org_id = public.current_org_id())
  with check (public.is_coach() and org_id = public.current_org_id());
