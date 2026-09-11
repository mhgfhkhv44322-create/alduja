create table if not exists public.villages (
  id uuid primary key default gen_random_uuid(),
  city_id uuid not null references public.cities(id) on delete cascade,
  name text not null,
  description text,
  created_at timestamptz not null default now()
);

create table if not exists public.village_dialogues (
  id uuid primary key default gen_random_uuid(),
  village_id uuid not null references public.villages(id) on delete cascade,
  speaker_name text not null,
  dialogue text not null,
  order_index integer not null default 0,
  created_at timestamptz not null default now()
);

create index if not exists villages_city_id_idx
on public.villages(city_id);

create index if not exists village_dialogues_village_id_idx
on public.village_dialogues(village_id);

alter table public.villages enable row level security;
alter table public.village_dialogues enable row level security;

create policy "authenticated users can read villages"
on public.villages
for select
to authenticated
using (true);

create policy "authenticated users can read village dialogues"
on public.village_dialogues
for select
to authenticated
using (true);
