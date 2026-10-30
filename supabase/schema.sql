-- HybridFuelCo — databaseschema (Supabase / Postgres)
-- Fase 1, fundament. Draai dit in Supabase → SQL Editor → New query → Run.
-- Veilig opnieuw te draaien (IF NOT EXISTS). RLS staat aan: elke gebruiker ziet
-- ALLEEN zijn eigen rijen. Systeemrijen (user_id IS NULL) zijn voor iedereen leesbaar
-- (onze recepten, barcode-cache).

-- ============ PROFIELEN (1 per account) ============
create table if not exists public.profiles (
  id          uuid primary key references auth.users(id) on delete cascade,
  email       text,
  lang        text default 'en',
  sex         text,                 -- 'male' | 'female'
  age         int,
  height_cm   numeric,
  goal        text,                 -- 'cut' | 'maintain' | 'gain'
  activity    text,                 -- 'light' | 'moderate' | 'high' | 'athlete'
  diet        text,
  created_at  timestamptz default now(),
  updated_at  timestamptz default now()
);

-- ============ ABONNEMENTEN (Stripe) ============
create table if not exists public.subscriptions (
  id                      uuid primary key default gen_random_uuid(),
  user_id                 uuid not null references auth.users(id) on delete cascade,
  stripe_customer_id      text,
  stripe_subscription_id  text,
  tier                    text not null default 'free',   -- 'free' | 'basis' | 'pro' | 'plus'
  status                  text not null default 'inactive',-- 'active' | 'trialing' | 'past_due' | 'canceled' | 'inactive'
  interval                text,                            -- 'month' | 'year'
  current_period_end      timestamptz,
  cancel_at_period_end    boolean default false,
  created_at              timestamptz default now(),
  updated_at              timestamptz default now(),
  unique (user_id)
);

-- ============ GEWICHT (tracker) ============
create table if not exists public.weights (
  id          uuid primary key default gen_random_uuid(),
  user_id     uuid not null references auth.users(id) on delete cascade,
  date        date not null,
  kg          numeric not null,
  created_at  timestamptz default now(),
  unique (user_id, date)
);

-- ============ PLANNEN (gegenereerd/bewerkt weekplan) ============
create table if not exists public.plans (
  id          uuid primary key default gen_random_uuid(),
  user_id     uuid not null references auth.users(id) on delete cascade,
  name        text,
  targets     jsonb,                -- { kcal, protein, carbs, fat, bmi, train, rest, ... }
  week        jsonb,                -- { days: [ { d, train, m:[...] } ] }
  is_active   boolean default true,
  created_at  timestamptz default now(),
  updated_at  timestamptz default now()
);

-- ============ RECEPTEN (onze + eigen) ============
create table if not exists public.recipes (
  id          uuid primary key default gen_random_uuid(),
  user_id     uuid references auth.users(id) on delete cascade,  -- NULL = systeemrecept (van ons)
  name        text not null,
  type        text,                 -- 'breakfast' | 'lunch' | 'dinner' | 'snack'
  goal        text,
  ingredients jsonb,                -- [ { name, grams, kcal, p, c, f } ]
  macros      jsonb,                -- { kcal, p, c, f, fiber }
  image_url   text,
  steps       text,
  is_system   boolean default false,
  created_at  timestamptz default now(),
  updated_at  timestamptz default now()
);

-- ============ PRODUCTEN (eigen + barcode/Open Food Facts) ============
create table if not exists public.products (
  id            uuid primary key default gen_random_uuid(),
  user_id       uuid references auth.users(id) on delete cascade, -- NULL = gedeeld/cache
  name          text not null,
  brand         text,
  barcode       text,
  per_100       jsonb,              -- { kcal, p, c, f, fiber } per 100 g/ml
  category      text,               -- NULL = auto op naam (catOf), anders handmatig gekozen
  unit          text default 'g',
  created_at    timestamptz default now()
);
create index if not exists products_barcode_idx on public.products(barcode);

-- ============ WATER (per dag) ============
create table if not exists public.water_logs (
  id          uuid primary key default gen_random_uuid(),
  user_id     uuid not null references auth.users(id) on delete cascade,
  date        date not null,
  ml          int not null default 0,
  created_at  timestamptz default now(),
  unique (user_id, date)
);

-- ============ EETLOGBOEK (diary) ============
create table if not exists public.food_logs (
  id          uuid primary key default gen_random_uuid(),
  user_id     uuid not null references auth.users(id) on delete cascade,
  date        date not null,
  meal_type   text,                 -- 'breakfast' | 'lunch' | 'dinner' | 'snack'
  item        text,
  grams       numeric,
  kcal        numeric, p numeric, c numeric, f numeric,
  source      text,                 -- 'recipe' | 'product' | 'manual'
  ref_id      uuid,
  created_at  timestamptz default now()
);
create index if not exists food_logs_user_date_idx on public.food_logs(user_id, date);

-- ============ SLAAP (fase 'slaap bijhouden') ============
create table if not exists public.sleep_logs (
  id          uuid primary key default gen_random_uuid(),
  user_id     uuid not null references auth.users(id) on delete cascade,
  date        date not null,
  hours       numeric,
  quality     int,                  -- 1..5
  created_at  timestamptz default now(),
  unique (user_id, date)
);

-- ================= RLS (row level security) =================
alter table public.profiles       enable row level security;
alter table public.subscriptions  enable row level security;
alter table public.weights        enable row level security;
alter table public.plans          enable row level security;
alter table public.recipes        enable row level security;
alter table public.products       enable row level security;
alter table public.water_logs     enable row level security;
alter table public.food_logs      enable row level security;
alter table public.sleep_logs     enable row level security;

-- Eigen-data tabellen: alleen je eigen rijen (alles).
do $$
declare t text;
begin
  foreach t in array array['profiles','weights','plans','water_logs','food_logs','sleep_logs']
  loop
    execute format('drop policy if exists own_all on public.%I;', t);
    execute format($f$create policy own_all on public.%I
      for all using (auth.uid() = %s) with check (auth.uid() = %s);$f$,
      t,
      case when t = 'profiles' then 'id' else 'user_id' end,
      case when t = 'profiles' then 'id' else 'user_id' end);
  end loop;
end $$;

-- Abonnementen: gebruikers mogen hun eigen rij ALLEEN LEZEN, nooit schrijven.
-- Schrijven gebeurt uitsluitend server-side door de Stripe-webhook met de
-- service-role key (die RLS omzeilt). Zonder deze restrictie kan een ingelogde
-- gebruiker zijn eigen tier op 'pro' zetten en de betaalde app gratis ontgrendelen.
drop policy if exists own_all on public.subscriptions;
drop policy if exists subscriptions_read_own on public.subscriptions;
create policy subscriptions_read_own on public.subscriptions
  for select using (auth.uid() = user_id);

-- Recepten & producten: eigen rijen volledig; systeem/gedeelde rijen (user_id NULL) leesbaar.
drop policy if exists recipes_read on public.recipes;
create policy recipes_read on public.recipes for select
  using (user_id is null or auth.uid() = user_id);
drop policy if exists recipes_write on public.recipes;
create policy recipes_write on public.recipes for all
  using (auth.uid() = user_id) with check (auth.uid() = user_id);

drop policy if exists products_read on public.products;
create policy products_read on public.products for select
  using (user_id is null or auth.uid() = user_id);
drop policy if exists products_write on public.products;
create policy products_write on public.products for all
  using (auth.uid() = user_id) with check (auth.uid() = user_id);

-- ================= Nieuw profiel automatisch bij registratie =================
create or replace function public.handle_new_user()
returns trigger language plpgsql security definer set search_path = public as $$
begin
  insert into public.profiles (id, email) values (new.id, new.email)
  on conflict (id) do nothing;
  insert into public.subscriptions (user_id, tier, status) values (new.id, 'free', 'inactive')
  on conflict (user_id) do nothing;
  return new;
end $$;

drop trigger if exists on_auth_user_created on auth.users;
create trigger on_auth_user_created
  after insert on auth.users
  for each row execute function public.handle_new_user();
