# CineWave 🎬

A Netflix-style streaming website UI built with **only HTML, CSS and vanilla JavaScript**, in a single file (`index.html`). No frameworks, no build tools, no installation.

> Learning / portfolio project. CineWave is an original brand and is not affiliated with any streaming service. All titles are fictional demo data.

**Live demo:** https://YOUR-USERNAME.github.io/cinewave/

## Features

- Cinematic hero banner that changes automatically
- 16 horizontal content rows with hover cards (play, add to list, info)
- Live search with suggestions, plus genre / language / year / rating filters
- Details popup for every title
- Working HTML5 video player: speed, skip, volume, fullscreen, picture-in-picture, keyboard shortcuts (Space, ← →, M, F)
- My List and Continue Watching saved in `localStorage` (resumes where you stopped)
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

- **What I asked it:** I wrote a detailed brief (one file, only HTML, CSS and JavaScript, plus a long feature list) and asked it to generate the first full version of `index.html`. Later I asked it to add poster photos, to explain how to publish on GitHub Pages, to draft this README, and to explain how parts of the code work.
- **What I changed myself:** [fill in after your commits, for example: I added the title "..." to the data and added the "Top Rated 8.5+" row, each as its own commit.]

## Tech

HTML5 · CSS3 · Vanilla JavaScript · localStorage

## Credits

- Demo videos: Blender Foundation open movies (CC-BY)
- Demo photos: [Picsum Photos](https://picsum.photos/) (Unsplash)
