-- CineWave: run this once in Supabase (SQL Editor > New query > Run)

-- One row per saved title, per user
create table public.my_list (
  user_id uuid not null default auth.uid() references auth.users(id) on delete cascade,
  title_id integer not null,
  added_at timestamptz not null default now(),
  primary key (user_id, title_id)
);

-- One row per watched title, per user
create table public.watch_progress (
  user_id uuid not null default auth.uid() references auth.users(id) on delete cascade,
  title_id integer not null,
  position_seconds real not null,
  duration_seconds real not null,
  updated_at timestamptz not null default now(),
  primary key (user_id, title_id)
);

-- Security: each logged-in user can only see and change their own rows
alter table public.my_list enable row level security;
alter table public.watch_progress enable row level security;

create policy "own list" on public.my_list
  for all to authenticated
  using (user_id = (select auth.uid()))
  with check (user_id = (select auth.uid()));

create policy "own progress" on public.watch_progress
  for all to authenticated
  using (user_id = (select auth.uid()))
  with check (user_id = (select auth.uid()));
