#!/usr/bin/env bash
# run.bash -*- mode: sh -*-
#set -o errexit
set -o nounset
set -o pipefail

# shellcheck disable=SC1091
source "$POLY_SRC/lib/lib-util.bash"
if [[ -e "$POLYGLOT_ROOT/.tasks/task-util.bash" ]]; then
    source "$POLYGLOT_ROOT/.tasks/task-util.bash"
fi

sclang \
    -l "$POLYGLOT_SRC/sc/lib.yaml" \
    -r -s \
    -d "$POLYGLOT_SRC/sc main.scd" || fail "SCLang failed"
