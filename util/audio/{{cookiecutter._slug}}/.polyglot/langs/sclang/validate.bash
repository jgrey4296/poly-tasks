#!/usr/bin/env bash
# validate.bash -*- mode: sh -*-
#set -o errexit
set -o nounset
set -o pipefail

# shellcheck disable=SC1091
[[ -e "$POLY_SRC/lib/lib.bash" ]] && source "$POLY_SRC/lib/lib.bash"
# shellcheck disable=SC1091
[[ -e "$(poly-dir)/task-util.bash" ]] && source "$(poly-dir)/task-util.bash"

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
