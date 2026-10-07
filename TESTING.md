# TESTING: Community Top 10 (BACKEND-2)

How to check that the Community Top 10 row works on the **live site** with a **real database**.
You need two accounts, called **Account A** and **Account B** below. Use two different email addresses, and use a private (incognito) window for anything marked "logged out".

> Fill in the Result and Notes lines yourself while you test. Pick a film that nobody has reviewed yet, called **Film X** below (any title works, for example *Big Buck Bunny*).

## Setup (once)

1. In Supabase > SQL Editor, run `supabase-top10.sql` (after the earlier SQL files). It should say "Success".
2. Create Account A and Account B on the live site (confirm the emails if Supabase asks).
3. Sign in as A in your normal window, and keep a private window open for the logged-out checks.

## The 5 tests

### Test 1: A title needs at least 2 reviews
**Steps**
1. As A, open Film X and post a **5-star** review.
2. In the private window (logged out), refresh the login screen.
3. As B, open Film X and post a **3-star** review.
4. In the private window, refresh again.

**Expected**
- After step 2: Film X is **not** in the Community Top 10 (only 1 review).
- After step 4: Film X **is** there, showing **4.0 · 2 reviews**.

Result: ☐ Pass ☐ Fail   Notes: ______________________

### Test 2: The average is right and changes when reviews change
**Steps**
1. As A, change your Film X review to **1 star** and press Update review.
2. Check the strip or row: the average should now be (1 + 3) / 2 = **2.0**.
3. As B, delete your Film X review.
4. Check again.

**Expected**
- After step 2: **2.0 · 2 reviews**.
- After step 4: Film X **disappears** from the Top 10 (back to 1 review).

Result: ☐ Pass ☐ Fail   Notes: ______________________

### Test 3: A logged-out visitor sees no personal data
**Steps**
1. In the private window, look at the Community Top 10 strip on the login screen.
2. Press F12 > Network, refresh, and click the request named `community_top10`. Read its Response.
3. In the Console, type `await sb.from('reviews').select('*')` and press Enter.

**Expected**
- Step 1: each card has only a poster, a title, an average and a review count. No names, no review text, no buttons or links.
- Step 2: the response has only `title_id`, `avg_stars` and `review_count`. No `user_id`, no `author_name`, no `body`.
- Step 3: the result is an empty list (`data: []`) because Row Level Security blocks logged-out reads of the table.

Result: ☐ Pass ☐ Fail   Notes: ______________________

### Test 4: Ranking order and ties
**Steps**
1. Use three titles: **Film X**, **Film Y**, **Film Z**.
2. Film X: A gives 5 stars, B gives 4 stars (average 4.5).
3. Film Y: A gives 3 stars, B gives 3 stars (average 3.0).
4. Film Z: A gives 5 stars, B gives 4 stars (average 4.5, a tie with Film X).
5. Look at the Top 10 order.

**Expected**
- The two 4.5 titles come **before** Film Y (3.0).
- The two 4.5 titles have the same average and the same count, so the one with the **lower title id** comes first (the id is the first number in that film's line in `RAW`).
- Never more than 10 cards. (To check the limit, run `select count(*) from community_top10();` in the SQL Editor: it must be 10 or less.)

Result: ☐ Pass ☐ Fail   Notes: ______________________

### Test 5: The row after sign-in updates, and the strip comes back after sign-out
**Steps**
1. Sign in as A. Look for the **Community Top 10** row near the top of the home page (under Trending Now).
2. Check that each card shows a rank, an average and a review count (for example `#1 · ★ 4.5 · 2 reviews`), and that it matches what the logged-out strip showed.
3. Click a card: the details popup should open.
4. In the popup, change your rating and press Update review. Close the popup.
5. Sign out.

**Expected**
- Steps 1 to 3: the row is there, the numbers match, and the popup opens.
- Step 4: the row shows the new average **without** refreshing the page.
- Step 5: you land on the login screen and the strip is back.

Result: ☐ Pass ☐ Fail   Notes: ______________________

## Results summary

| Test | Pass / Fail | Date | What I noticed |
|------|-------------|------|----------------|
| 1 Minimum 2 reviews | | | |
| 2 Average + update/delete | | | |
| 3 Logged-out privacy | | | |
| 4 Order, ties, max 10 | | | |
| 5 Row after sign-in | | | |

## Known limits (honest list)

- **Fake accounts:** anyone can create many accounts and stuff reviews to push a title up. Email confirmation and the 2-review minimum slow this down but do not stop it. A bigger minimum or a "verified viewer" rule would be the next step.
- **The login wall:** the strip is the only thing a logged-out visitor can see, so it lives on the login screen.
- **Refresh time:** the page keeps the last answer for 60 seconds, except right after you post or delete a review (it refreshes at once). Other people's new reviews appear after a page refresh.
- **Demo titles:** the fictional demo titles can also be ranked, since they can be reviewed like any other title.

## Checks done before these tests (by the AI assistant, not a replacement for your tests)

- The SQL was run on a throwaway PostgreSQL 16 database with the same Row Level Security rules as `reviews`. As a logged-out role, a direct `select` on `reviews` returned 0 rows, while `community_top10()` returned the expected top 10. A normal function (without `security definer`) returned 0 rows for the same logged-out role.
- The page was run in a headless browser against a pretend Supabase: strip on the login screen, row after sign-in, order and ties, an empty list, a database error, junk data, and a phone-sized screen.
- These checks do **not** use your real Supabase project, which is why you still run the five tests above.
