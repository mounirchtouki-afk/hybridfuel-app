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
