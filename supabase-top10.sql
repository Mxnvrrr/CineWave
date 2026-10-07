-- CineWave: Community Top 10 (BACKEND-2).
-- Run this ONCE in Supabase (SQL Editor > New query > Run), after supabase-extras.sql.
--
-- Why a function? The reviews table lets only signed-in users read rows, so a normal
-- query from a logged-out visitor returns nothing. This function runs with its owner's
-- rights (SECURITY DEFINER), does the maths inside the database, and hands back ONLY
-- title_id, average stars and review count. No user ids, names or review text leave it.

-- Makes the "group by title" query fast as the table grows
create index if not exists reviews_title_id_idx on public.reviews (title_id);

create or replace function public.community_top10()
returns table (title_id integer, avg_stars numeric, review_count bigint)
language sql
stable
security definer
set search_path = public      -- stops a hostile schema from hijacking table names
as $$
  select r.title_id,
         round(avg(r.stars)::numeric, 1) as avg_stars,
         count(*)                        as review_count
  from public.reviews r
  group by r.title_id
  having count(*) >= 2                                   -- at least 2 reviews
  order by avg_stars desc, review_count desc, r.title_id -- ties: more reviews first, then id
  limit 10;                                              -- top 10 only
$$;

-- Functions are executable by everyone by default. Remove that, then grant on purpose.
revoke all on function public.community_top10() from public;
grant execute on function public.community_top10() to anon, authenticated;
