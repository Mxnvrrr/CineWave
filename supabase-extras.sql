-- CineWave: ratings and reviews, plus the right to delete your own profile row.
-- Run this ONCE in Supabase (SQL Editor > New query > Run), after the other two SQL files.

create table public.reviews (
  user_id uuid not null default auth.uid() references auth.users(id) on delete cascade,
  title_id integer not null,
  stars smallint not null check (stars between 1 and 5),
  body text check (char_length(body) <= 500),
  author_name text not null default 'A viewer' check (char_length(author_name) <= 40),
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  primary key (user_id, title_id)
);

alter table public.reviews enable row level security;

-- Signed-in users can read everyone's reviews (that is the point of reviews)...
create policy "signed-in users read reviews" on public.reviews
  for select to authenticated using (true);
-- ...but can only add, change or delete their own.
create policy "add own review" on public.reviews
  for insert to authenticated with check (user_id = (select auth.uid()));
create policy "edit own review" on public.reviews
  for update to authenticated
  using (user_id = (select auth.uid())) with check (user_id = (select auth.uid()));
create policy "delete own review" on public.reviews
  for delete to authenticated using (user_id = (select auth.uid()));

-- Lets Settings > "Delete my profile details" remove your row in the profiles table
create policy "delete own profile" on public.profiles
  for delete to authenticated using (id = (select auth.uid()));
