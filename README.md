# ugm-modelling-course

Teaching materials for a hands-on introduction to coding compartmental models
in R with [odin](https://mrc-ide.github.io/odin/).

## Contents

A 90-minute session, "Coding compartmental models with R and odin", in two
parts (B3_1 and B3_2), available both as a Quarto book (for
self-study / following along) and as revealjs slide decks (for presenting):

| | Book chapter | Slides |
|---|---|---|
| B3_1: odin basics & the SIR model | `lectures/01-odin-basics-sir.qmd` | `slides/slides-01-odin-basics-sir.qmd` |
| B3_2: SEIR, demography & time-varying parameters | `lectures/02-extending-models.qmd` | `slides/slides-02-extending-models.qmd` |

The file `modelling-interventions-odin.R` is an earlier standalone example
kept for reference; the lectures above are the maintained teaching material.

## Prerequisites

- R (≥ 4.1) with a C compiler (macOS: `xcode-select --install`; Windows: Rtools)
- `install.packages("odin")` — the only modelling package used
- Check your setup with `odin::can_compile()`

## Rendering

The project uses [renv](https://rstudio.github.io/renv/) to pin its R
dependencies (odin + rmarkdown). On a fresh clone, restore the environment
once from within R:

```r
renv::restore()
```

After that, rendering needs no special setup — the project `.Rprofile`
activates the environment automatically (including for the slides, via
`slides/.Rprofile`):

```sh
quarto render          # renders the book to _book/
quarto render slides   # renders the slide decks to slides/*.html
quarto preview         # live preview of the book while editing
```

## Publishing

The materials are published to [Quarto Pub](https://quartopub.com) as a
single site — the book at the site root and the slide decks under
`/slides/`, cross-linked (the book has a "Slide decks" page in the sidebar;
each deck's title slide links back to the book). To publish or update:

```sh
./publish.sh
```

This renders the slides, renders the book (which bundles the decks via the
`resources` key in `_quarto.yml`) and runs `quarto publish quarto-pub
--no-render`. The first run asks for a site name and Quarto Pub
authorisation; afterwards `_publish.yml` makes it non-interactive.

Note: the decks link back to `../index.html`, which resolves correctly on
the published site but not when opening the local files directly.
