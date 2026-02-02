#!/usr/bin/env bash
# run.bash -*- mode: sh -*-
#set -o errexit
set -o nounset
set -o pipefail

# shellcheck disable=SC1091
source "$POLY_SRC/lib/lib-util.bash"
# shellcheck disable=SC1091
[[ -e "$POLYGLOT_ROOT/.tasks/task-util.bash" ]] && source "$POLYGLOT_ROOT/.tasks/task-util.bash"

DEFAULT_FILE="main.scd"
DEFAULT_CONFIG="lib.yaml"

tdot "sclang" "Running"

pushd "$POLYGLOT_SRC/_music/sc" || fail "Failed to go to sclang dir"
(
    sclang \
        -l "$DEFAULT_CONFIG" \
        -r -s \
        -d "$DEFAULT_FILE"
) || fail "SCLang failed"
popd || fail "Failed to return from sclang dir"
