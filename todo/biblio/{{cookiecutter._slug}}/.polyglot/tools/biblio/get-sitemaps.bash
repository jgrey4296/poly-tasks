#!/usr/bin/env bash
# get-sitemaps.bash -*- mode: sh -*-
#set -o errexit
set -o nounset
set -o pipefail

# shellcheck disable=SC1091
[[ -e "$POLY_SRC/lib/lib.bash" ]] && source "$POLY_SRC/lib/lib.bash"
# shellcheck disable=SC1091
[[ -e "$(poly-dir)/task-util.bash" ]] && source "$(poly-dir)/task-util.bash"

target="$1"
shift

tdot "Sitemaps" "Getting Sitemaps for: $1"

wget -O "./target.xml" "$1"

xml sel -t -v "//_:loc" -nl ./target.xml > "./urls"

wget -i "./urls"
