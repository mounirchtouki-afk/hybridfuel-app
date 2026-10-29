-- ÉÉN KEER DRAAIEN. Coach-notitie per lid (voor de coach zelf).
alter table public.org_members add column if not exists coach_note text;
select 'coach_note ok' as status;
