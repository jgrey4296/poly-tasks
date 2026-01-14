#!/usr/bin/env bash
# extract-file.bash -*- mode: sh -*-
#set -o errexit
set -o nounset
set -o pipefail

# shellcheck disable=SC1091
source "$POLY_SRC/lib/lib-util.bash"
# shellcheck disable=SC1091
[[ -e "$POLYGLOT_ROOT/.tasks/task-util.bash" ]] && source "$POLYGLOT_ROOT/.tasks/task-util.bash"

tdot "assets" "TODO: extracting selection"

# get the zip, extract:
# - the toml metadatga
# - the integrity list
# - a selection of files
