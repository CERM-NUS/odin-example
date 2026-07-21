#!/bin/sh
# Publish the session materials to Quarto Pub as a single site:
# the book at the site root and the slide decks under /slides/.
#
# First run: quarto will ask for a site name and confirm your Quarto Pub
# account (browser login if not yet authorised). Afterwards it is
# non-interactive via _publish.yml.
set -e
cd "$(dirname "$0")"

quarto render slides          # self-contained HTML decks
quarto render                 # book; slides/*.html copied in via 'resources'
quarto publish quarto-pub --no-render "$@"
