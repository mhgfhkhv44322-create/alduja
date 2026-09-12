create table if not exists public.skill_definitions (
  id uuid primary key default gen_random_uuid(),
  skill_key text unique not null,
  name text not null,
  category text not null,
  description text,
  required_level integer not null default 1,
  required_attribute text,
  required_attribute_value integer not null default 1,
  parent_skill_id uuid references public.skill_definitions(id) on delete set null,
  max_rank integer not null default 1,
  effects jsonb not null default '{}'::jsonb,
  is_active boolean not null default true,
  created_at timestamptz not null default now()
);

create table if not exists public.player_skills (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  skill_id uuid not null references public.skill_definitions(id) on delete cascade,
  rank integer not null default 1,
  unlocked_at timestamptz not null default now(),
  unique(user_id, skill_id)
);

create index if not exists skill_definitions_category_idx
on public.skill_definitions(category);

create index if not exists player_skills_user_idx
on public.player_skills(user_id);

alter table public.skill_definitions enable row level security;
alter table public.player_skills enable row level security;

create policy "authenticated users can read active skills"
on public.skill_definitions
for select to authenticated
using (is_active = true);

create policy "users can read own skills"
on public.player_skills
for select to authenticated
using (user_id = auth.uid());

create policy "users can unlock own skills"
on public.player_skills
for insert to authenticated
with check (user_id = auth.uid());
