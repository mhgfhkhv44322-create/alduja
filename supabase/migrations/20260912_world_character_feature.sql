create table if not exists public.world_features (
  id uuid primary key default gen_random_uuid(),
  feature_key text unique not null,
  enabled boolean not null default false,
  title text,
  description text,
  updated_at timestamptz not null default now()
);

insert into public.world_features
  (feature_key, enabled, title, description)
values
  (
    'world_character_creation',
    false,
    'إنشاء شخصيتك في عالم الدجى',
    'اصنع شخصيتك وتجسّد داخل عالم الدجى'
  )
on conflict (feature_key) do nothing;

alter table public.world_features enable row level security;

drop policy if exists "authenticated users can read world features"
on public.world_features;

create policy "authenticated users can read world features"
on public.world_features
for select
to authenticated
using (true);
