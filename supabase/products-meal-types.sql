-- #3 — maaltijdplan uit eigen producten: tag producten per maaltijdtype.
-- Lege/ontbrekende lijst = product is in elke maaltijd bruikbaar.
-- Idempotent: veilig om opnieuw te draaien.

alter table public.products
  add column if not exists meal_types text[] not null default '{}';

-- Optioneel: snelle filtering op maaltijdtype (GIN-index op de array).
create index if not exists products_meal_types_idx
  on public.products using gin (meal_types);
