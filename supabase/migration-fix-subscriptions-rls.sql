-- ============================================================================
-- SECURITY FIX (KRITIEK) — subscriptions mag door gebruikers NIET geschreven worden
-- ============================================================================
-- Probleem: de policy own_all stond met "for all" op public.subscriptions, dus een
-- ingelogde gebruiker kon met de publieke anon-key + z'n eigen token zijn eigen
-- subscriptions-rij updaten naar tier='pro' en de betaalde app GRATIS ontgrendelen
-- (inclusief AI-plannen en Race Protocol).
--
-- Oplossing: gebruikers mogen hun eigen rij alleen LEZEN. Schrijven doet alleen de
-- Stripe-webhook server-side met de service-role key (die RLS omzeilt).
--
-- Veilig om te draaien: de app schrijft nergens client-side naar subscriptions,
-- dus dit breekt geen functionaliteit. Idempotent: meermaals draaien mag.
--
-- Draaien: Supabase dashboard -> SQL Editor -> plak dit -> Run.
-- ============================================================================

alter table public.subscriptions enable row level security;

drop policy if exists own_all on public.subscriptions;
drop policy if exists subscriptions_read_own on public.subscriptions;

create policy subscriptions_read_own on public.subscriptions
  for select using (auth.uid() = user_id);

-- Controle: er hoort nu precies één policy op subscriptions te staan (SELECT, eigen rij).
select policyname, cmd, qual
from pg_policies
where schemaname = 'public' and tablename = 'subscriptions';
