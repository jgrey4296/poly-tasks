#!/usr/bin/env bash
# gen-zip.bash -*- mode: sh -*-
#set -o errexit
set -o nounset
set -o pipefail

# shellcheck disable=SC1091
source "$POLY_SRC/lib/lib-util.bash"
if [[ -e "$POLYGLOT_ROOT/.tasks/task-util.bash" ]]; then
    source "$POLYGLOT_ROOT/.tasks/task-util.bash"
fi


tdot "[assets]" "TODO: generate zip of assets"

# get the (short)name from the toml
# zip the files with the toml and integrity
