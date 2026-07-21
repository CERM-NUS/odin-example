#!/bin/sh
# Publish the session materials to GitHub Pages
# (https://cerm-nus.github.io/odin-example/):
# renders the slides and book, bundles the decks into the book site, and
# force-pushes the result to the gh-pages branch of CERM-NUS/odin-example.
#
# Uses the PAT stored in ~/.cerm-nus-odin-pat for git pushes (so the
# GH_TOKEN in your shell is untouched).
set -e
cd "$(dirname "$0")"

REPO="https://github.com/CERM-NUS/odin-example.git"
TOKEN_FILE="$HOME/.cerm-nus-odin-pat"
[ -f "$TOKEN_FILE" ] || { echo "missing $TOKEN_FILE"; exit 1; }
TOKEN=$(tr -d '[:space:]' < "$TOKEN_FILE")
AUTH="Authorization: Basic $(printf 'x-access-token:%s' "$TOKEN" | base64)"

quarto render slides          # self-contained HTML decks
quarto render                 # book; slides/*.html copied in via 'resources'

TMP=$(mktemp -d)
trap 'rm -rf "$TMP"' EXIT
cp -R _book/. "$TMP/"
git -C "$TMP" init -qb gh-pages
git -C "$TMP" add -A
git -C "$TMP" -c user.name="$(git config user.name)" \
            -c user.email="$(git config user.email)" \
            commit -qm "Publish site: book + slides"
git -C "$TMP" -c http.extraHeader="$AUTH" push -f "$REPO" gh-pages
