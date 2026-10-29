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
