-- Prullenbak: soft-delete voor sportscholen. Draai één keer in Supabase → SQL Editor.
-- Een verwijderde sportschool krijgt deleted_at; herstellen zet 'm weer op null.
-- Members gebruiken de ingebouwde "ban" van Supabase (geen kolom nodig).
alter table public.orgs add column if not exists deleted_at timestamptz;
create index if not exists orgs_deleted_idx on public.orgs (deleted_at);
