# CineWave 🎬

A Netflix-style streaming website UI built with **only HTML, CSS and vanilla JavaScript**, in a single file (`index.html`). No frameworks, no build tools, no installation.

> Learning / portfolio project. CineWave is an original brand and is not affiliated with any streaming service. All titles are fictional demo data.

**Live demo:** https://mxnvrrr.github.io/CineWave/

## Features

- Cinematic hero banner that changes automatically
- 17 horizontal content rows with hover cards (play, add to list, info)
- Live search with suggestions, plus genre / language / year / rating filters
- Details popup for every title
- Working HTML5 video player: speed, skip, volume, fullscreen, picture-in-picture, keyboard shortcuts (Space, ← →, M, F)
- My List and Continue Watching saved in `localStorage` (resumes where you stopped)
- Login wall: visitors must sign in or create an account; sign-up details (name, date of birth, country, language, favourite genres) are saved, can be edited under Profile, and My List and Continue Watching follow the account (Supabase)
- Real, legally free films: public domain and Creative Commons titles from the Internet Archive and the Blender Foundation, with the licence shown on each title
- Dark / light theme, responsive layout, loading skeletons, friendly error states, keyboard-accessible

## Run it locally

Download `index.html` and double-click it. It opens in Chrome. Nothing to install.

## Change the content

Open `index.html` in a text editor and look at the data section at the top of the script (the `RAW` list). Each line is one title:

```
[id, type, title, year, genre, language, rating, duration, colour1, colour2, cast, description]
```

Video links are in the `VIDEOS` list. Poster and backdrop image links are set in the `items` list just below it. The rows on the home page are defined in the `ROWS` list further down.

## How it works

1. All titles live in one list, `RAW`, in `index.html`. A `map` turns every row into an object and adds a poster, backdrop and video address.
2. The current choices are kept in two small objects: `state` (which page is open and what was searched) and `F` (the genre, language, year and rating filters).
3. `render()` starts from all titles, keeps the ones that pass the filters, then applies the current page or search text.
4. On the home page each entry in `ROWS` picks its titles from that filtered list. Empty rows are skipped and the rest are turned into HTML by `card()`.
5. The HTML is written into the page in one go. One click listener handles play buttons, My List buttons and card clicks, and My List, Continue Watching and the theme are saved in `localStorage`.

## AI use

I used Claude (an AI assistant made by Anthropic) on this project.

- **What I asked it:** I wrote a detailed brief (one file, only HTML, CSS and JavaScript, plus a long feature list) and asked it to generate the first full version of `index.html`. Later I asked it to add poster photos, to explain how to publish on GitHub Pages, to draft this README, to explain how parts of the code work, and to add the Supabase login wall, saved profile details, cloud sync of My List and watch progress, and the real free films.
- **What I changed myself:** [fill in after your commits, for example: I added the title "..." to the data and added the "Top Rated 8.5+" row, each as its own commit.]

## Accounts, profile and sync (Supabase)

When Supabase is set up, nobody can use the site until they sign in or create an account. (If you leave the Supabase values empty, the site stays open as a guest demo.) The login wall is a front-end gate: it controls the interface, while the database rules protect each person's saved data.

1. Create a free project at supabase.com. In its SQL Editor run `supabase-setup.sql` (tables `my_list` and `watch_progress`), then `supabase-profiles.sql` (table `profiles` and the automatic copy of sign-up details). Both use Row Level Security, so each user can only read and change their own rows.
2. Put your Project URL and public (anon / publishable) key in the `BACKEND SETTINGS` section at the top of the script in `index.html`. These two values are meant to be public. Never put the secret / service_role key in the file.
3. In Supabase, set Authentication > URL Configuration > Site URL to your live link.

Passwords are handled by Supabase Auth and are never stored by this project. The profile holds only what the sign-up form asks for. Collect only what you need, and tell users what is stored.

When someone signs in, anything saved in that browser as a guest is merged into their account (the newer watch position wins), and from then on My List and Continue Watching are read from and written to the database.

## Free films

Real titles are the ones with a video link in the data list (they appear in the "Free Classics & Open Films" row). Each one shows its licence in the details popup. Public domain status can differ by country, so check the licence before reusing a film elsewhere.

## Tech

HTML5 · CSS3 · Vanilla JavaScript · localStorage · Supabase (Auth + Postgres)

## Credits

- Free films: Nosferatu (1922), A Trip to the Moon (1902), The Cabinet of Dr. Caligari (1920), Raja Harishchandra (1913) and Sita Sings the Blues (2008) from the [Internet Archive](https://archive.org/) (public domain / CC0)
- Blender Foundation open movies: Big Buck Bunny, Sintel, Tears of Steel, Elephants Dream (Creative Commons Attribution)
- Fictional demo titles use placeholder videos from the Blender movies above
- Demo photos: [Picsum Photos](https://picsum.photos/) (Unsplash)
