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

Open `index.html` in a text editor and find the section marked `EDIT THIS PART!`. Each line is one title:

```
[id, type, title, year, genre, language, rating, duration, colour1, colour2, cast, description]
```

Video links are in the `VIDEOS` list. Poster and backdrop image links are set in the `items` list just below it.

## Tech

HTML5 · CSS3 · Vanilla JavaScript · localStorage

## Credits

- Demo videos: Blender Foundation open movies (CC-BY)
- Demo photos: [Picsum Photos](https://picsum.photos/) (Unsplash)
