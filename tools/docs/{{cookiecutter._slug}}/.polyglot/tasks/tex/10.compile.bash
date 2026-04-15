#!/usr/bin/env bash
#set -o errexit
set -o nounset
set -o pipefail

# shellcheck disable=SC1091
[[ -e "$POLY_SRC/lib/lib.bash" ]] && source "$POLY_SRC/lib/lib.bash"
# shellcheck disable=SC1091
[[ -e "$(poly-dir)/task-util.bash" ]] && source "$(poly-dir)/task-util.bash"

output="$POLYGLOT_TEMP/tex"

tdot "tex" "Compiling"
# compile each chapter
lualatex --interaction=nonstopmode --output-directory="$output" "$output"/*.tex > /dev/null
BIBINPUT="$output:${BIBINPUTS:-}" bibtex --terse "$output"/*.tex > /dev/null
lualatex --interaction=nonstopmode --output-directory="$output" "$output"/*.tex > /dev/null
lualatex --interaction=nonstopmode --output-directory="$output" "$output"/*.tex > /dev/null
