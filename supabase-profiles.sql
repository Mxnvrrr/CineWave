-- CineWave: saves the details people enter when they create an account.
-- Run this ONCE in Supabase (SQL Editor > New query > Run), after supabase-setup.sql.

create table public.profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  full_name text,
  date_of_birth date,
  country text,
  preferred_language text,
  favourite_genres text[] not null default '{}',
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

-- Security: each person can only read and change their own profile
alter table public.profiles enable row level security;

create policy "read own profile" on public.profiles
  for select to authenticated using (id = (select auth.uid()));
create policy "add own profile" on public.profiles
  for insert to authenticated with check (id = (select auth.uid()));
create policy "update own profile" on public.profiles
  for update to authenticated
  using (id = (select auth.uid())) with check (id = (select auth.uid()));

-- When a new account is created, copy the sign-up details into the profiles table automatically
create function public.handle_new_user() returns trigger
language plpgsql security definer set search_path = '' as $$
begin
  insert into public.profiles (id, full_name, date_of_birth, country, preferred_language, favourite_genres)
  values (
    new.id,
    new.raw_user_meta_data->>'full_name',
    nullif(new.raw_user_meta_data->>'date_of_birth', '')::date,
    new.raw_user_meta_data->>'country',
    new.raw_user_meta_data->>'preferred_language',
    coalesce(array(select jsonb_array_elements_text(new.raw_user_meta_data->'favourite_genres')), '{}')
  );
  return new;
end;
$$;

create trigger on_auth_user_created
  after insert on auth.users
  for each row execute function public.handle_new_user();
