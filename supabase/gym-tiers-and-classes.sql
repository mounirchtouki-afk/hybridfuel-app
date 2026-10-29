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
