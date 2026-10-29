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
