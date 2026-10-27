-- app_kv: cloud-sync voor data die voorheen localStorage-only was
-- (kalender-afwijkingen hf_dayover_*, trainingslogs hf_workouts_* / hf_trainover_*,
--  trainingsweekschema hf_trainplan, geplande dagen hf_planned).
-- Draai dit één keer in de Supabase SQL-editor.

create table if not exists public.app_kv (
  user_id    uuid not null references auth.users(id) on delete cascade,
  k          text not null,
  v          jsonb,
  updated_at timestamptz not null default now(),
  primary key (user_id, k)
);

alter table public.app_kv enable row level security;

-- Elke gebruiker ziet en beheert alleen zijn eigen rijen.
drop policy if exists "app_kv own rows" on public.app_kv;
create policy "app_kv own rows" on public.app_kv
  for all
  using (auth.uid() = user_id)
  with check (auth.uid() = user_id);
