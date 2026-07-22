#!/bin/sh
# Build the full LOCAL version of the materials: course book + slide decks
# + personal notes (via the 'local' Quarto profile). Nothing is published;
# open _book/index.html when done.
set -e
cd "$(dirname "$0")"

quarto render slides                                   # course decks
(cd personal && quarto render time-varying-beta.qmd)   # personal deck
QUARTO_PROFILE=local quarto render                     # book incl. personal chapter
