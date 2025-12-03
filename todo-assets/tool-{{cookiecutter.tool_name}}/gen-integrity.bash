#!/usr/bin/env bash
# gen-integrity.bash -*- mode: sh -*-
#set -o errexit
set -o nounset
set -o pipefail

# shellcheck disable=SC1091
source "$POLY_SRC/lib/lib-util.bash"
if [[ -e "$POLYGLOT_ROOT/.tasks/task-util.bash" ]]; then
    source "$POLYGLOT_ROOT/.tasks/task-util.bash"
fi

INTEGRITY_FILE=".integrity"

tdot "[assets]" "TODO: generate integrity list"

# generate the list of files with hashes
