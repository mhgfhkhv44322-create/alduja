create table if not exists public.blacksmith_recipes (
  id uuid primary key default gen_random_uuid(),
  recipe_key text unique not null,
  name text not null,
  weapon_type text not null,
  description text,
  required_materials jsonb not null default '{}'::jsonb,
  gold_cost integer not null default 0,
  required_level integer not null default 1,
  required_reputation integer not null default 0,
  created_at timestamptz not null default now()
);

create table if not exists public.blacksmith_jobs (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  recipe_id uuid references public.blacksmith_recipes(id),
  job_type text not null check (job_type in ('repair','craft','upgrade','salvage')),
  item_id uuid references public.item_definitions(id),
  status text not null default 'pending',
  cost_gold integer not null default 0,
  result jsonb not null default '{}'::jsonb,
  created_at timestamptz not null default now(),
  completed_at timestamptz
);

alter table public.blacksmith_recipes enable row level security;
alter table public.blacksmith_jobs enable row level security;

create policy "blacksmith recipes readable"
on public.blacksmith_recipes for select
to authenticated using (true);

create policy "own blacksmith jobs"
on public.blacksmith_jobs for select
to authenticated
using (auth.uid() = user_id);

create policy "create own blacksmith jobs"
on public.blacksmith_jobs for insert
to authenticated
with check (auth.uid() = user_id);

insert into public.blacksmith_recipes
(recipe_key,name,weapon_type,description,required_materials,gold_cost,required_level)
values
('traveler_dagger','خنجر الرحّال','خنجر','خنجر سريع وخفيف مناسب للرحلات.','{"iron":2,"leather":1}',15,1),
('desert_sword','سيف بدوي','سيف','سيف متوازن لصحراء إرم.','{"iron":5,"wood":1,"leather":1}',35,1),
('caravan_axe','فأس القوافل','فأس','فأس ثقيل لضربات قوية.','{"iron":6,"wood":2}',45,2),
('desert_bow','قوس الصحراء','قوس','قوس خفيف للرماية من مسافة بعيدة.','{"wood":4,"leather":2}',30,2)
on conflict (recipe_key) do nothing;
