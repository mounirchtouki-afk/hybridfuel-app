-- ============================================================================
-- HARDENING (gym-editie) — alleen een eigenaar mag eigenaar-status zetten
-- ============================================================================
-- De policy "members write coach" laat een coach org_members in z'n eigen org
-- schrijven, inclusief z'n eigen rij. Zonder extra rem kan een coach dus
-- is_owner=true op zichzelf zetten (coach -> eigenaar escalatie).
--
-- Deze trigger blokkeert het wijzigen/zetten van is_owner tenzij de actor zelf al
-- eigenaar van die org is, of de server (service-role) de schrijfactie doet.
-- Idempotent en veilig. (Gym is nog geen live product; draai dit vóór de launch.)
--
-- Draaien: Supabase dashboard -> SQL Editor -> plak dit -> Run.
-- ============================================================================

create or replace function public.guard_org_member_owner()
returns trigger language plpgsql security definer set search_path = public as $$
begin
  if (tg_op = 'UPDATE' and new.is_owner is distinct from old.is_owner)
     or (tg_op = 'INSERT' and new.is_owner = true) then
    -- Server/webhook (service-role) mag alles.
    if auth.role() = 'service_role' then
      return new;
    end if;
    -- Anders: alleen een bestaande eigenaar van dezelfde org mag eigenaar-status zetten.
    if not exists (
      select 1 from public.org_members m
      where m.org_id = new.org_id
        and m.auth_user_id = auth.uid()
        and m.is_owner = true
    ) then
      raise exception 'only an owner can change owner status';
    end if;
  end if;
  return new;
end $$;

drop trigger if exists trg_guard_org_member_owner on public.org_members;
create trigger trg_guard_org_member_owner
  before insert or update on public.org_members
  for each row execute function public.guard_org_member_owner();

select 'owner-guard trigger geplaatst' as status;
