-- ===========================================================================
-- Admin: volledige sportschool-administratie + licentiebeheer
-- Draai dit één keer in Supabase → SQL Editor. Veilig opnieuw te draaien
-- (alles met "if not exists"). Niets wordt verwijderd.
-- ===========================================================================

-- Eén eigenaar-account kan meerdere sportscholen (locaties) beheren.
alter table public.orgs add column if not exists owner_user_id uuid references auth.users(id) on delete set null;

-- Administratiegegevens per sportschool (voor jouw eigen administratie).
alter table public.orgs add column if not exists address       text;
alter table public.orgs add column if not exists postal_code   text;
alter table public.orgs add column if not exists city          text;
alter table public.orgs add column if not exists country       text default 'NL';
alter table public.orgs add column if not exists contact_name  text;
alter table public.orgs add column if not exists contact_email text;
alter table public.orgs add column if not exists contact_phone text;
alter table public.orgs add column if not exists kvk           text;
alter table public.orgs add column if not exists vat           text;
alter table public.orgs add column if not exists admin_note    text;

-- Licentie per sportschool: pakket, status en looptijd (1 jaar).
alter table public.orgs add column if not exists license_tier   text default 'basis';   -- pro | basis | gratis
alter table public.orgs add column if not exists license_status text default 'active';  -- active | stopped
alter table public.orgs add column if not exists license_start  date;
alter table public.orgs add column if not exists license_end    date;

create index if not exists orgs_owner_idx on public.orgs (owner_user_id);
create index if not exists orgs_license_end_idx on public.orgs (license_end);
