#!/usr/bin/env bash
# validate.bash -*- mode: sh -*-
#set -o errexit
set -o nounset
set -o pipefail

# shellcheck disable=SC1091
source "$POLY_SRC/lib/lib-util.bash"
if [[ -e "$POLYGLOT_ROOT/.tasks/task-util.bash" ]]; then
    source "$POLYGLOT_ROOT/.tasks/task-util.bash"
fi

DEFAULT_FILE="main.scd"
DEFAULT_CONFIG="lib.yaml"

tdot "sclang" "Validating"
pushd "$POLYGLOT_SRC/_music/sc" || fail "Failed to go to sclang dir"
(
    sclang \
        -l "$DEFAULT_CONFIG" \
        -r \
        -s "$DEFAULT_FILE"
) || fail "SCLang failed"
popd || fail "Failed to return from sclang dir"
