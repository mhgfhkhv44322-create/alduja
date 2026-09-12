alter table public.cities enable row level security;
alter table public.stories enable row level security;
alter table public.characters enable row level security;

drop policy if exists "authenticated users can read cities" on public.cities;
create policy "authenticated users can read cities"
on public.cities for select to authenticated
using (true);

drop policy if exists "authenticated users can read stories" on public.stories;
create policy "authenticated users can read stories"
on public.stories for select to authenticated
using (true);

drop policy if exists "authenticated users can read characters" on public.characters;
create policy "authenticated users can read characters"
on public.characters for select to authenticated
using (true);
