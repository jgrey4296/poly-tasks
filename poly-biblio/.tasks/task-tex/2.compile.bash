#!/usr/bin/env bash
#set -o errexit
set -o nounset
set -o pipefail

# shellcheck disable=SC1091
source "$POLY_SRC/lib/lib-util.bash"

output="$POLYGLOT_TEMP/tex"

# compile each chapter
lualatex --interaction=nonstopmode --output-directory="$output" "$output"/*.tex > /dev/null
BIBINPUT="$output:${BIBINPUTS:-}" bibtex --terse "$output"/*.tex > /dev/null
lualatex --interaction=nonstopmode --output-directory="$output" "$output"/*.tex /dev/null
lualatex --interaction=nonstopmode --output-directory="$output" "$output"/*.tex /dev/null

