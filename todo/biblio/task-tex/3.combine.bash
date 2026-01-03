#!/usr/bin/env bash
# 3.combine.bash -*- mode: sh -*-
#set -o errexit
set -o nounset
set -o pipefail

# shellcheck disable=SC1091
source "$POLY_SRC/lib/lib-util.bash"

output="$POLYGLOT_TEMP/tex"

# join separate pdfs together together
pdftk cat "$output"/*.pdf output "$output/library.pdf"
