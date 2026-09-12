create table if not exists public.item_definitions (
  id uuid primary key default gen_random_uuid(),
  item_key text unique not null,
  name text not null,
  item_type text not null,
  rarity text not null default 'common',
  description text,
  effects jsonb not null default '{}'::jsonb,
  requirements jsonb not null default '{}'::jsonb,
  lore_text text,
  is_magical boolean not null default false,
  is_tradeable boolean not null default true,
  created_at timestamptz not null default now()
);

create table if not exists public.player_inventory (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  item_id uuid not null references public.item_definitions(id) on delete cascade,
  quantity integer not null default 1,
  equipped boolean not null default false,
  durability integer,
  custom_data jsonb not null default '{}'::jsonb,
  acquired_at timestamptz not null default now(),
  unique(user_id, item_id)
);

create table if not exists public.player_effects (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  effect_key text not null,
  source_item_id uuid references public.item_definitions(id) on delete set null,
  magnitude numeric not null default 0,
  duration_seconds integer,
  expires_at timestamptz,
  stacks integer not null default 1,
  metadata jsonb not null default '{}'::jsonb,
  created_at timestamptz not null default now()
);

create index if not exists player_inventory_user_idx
on public.player_inventory(user_id);

create index if not exists player_effects_user_idx
on public.player_effects(user_id);

alter table public.item_definitions enable row level security;
alter table public.player_inventory enable row level security;
alter table public.player_effects enable row level security;

create policy "authenticated users can read item definitions"
on public.item_definitions
for select to authenticated using (true);

create policy "users can read own inventory"
on public.player_inventory
for select to authenticated
using (user_id = auth.uid());

create policy "users can read own effects"
on public.player_effects
for select to authenticated
using (user_id = auth.uid());
