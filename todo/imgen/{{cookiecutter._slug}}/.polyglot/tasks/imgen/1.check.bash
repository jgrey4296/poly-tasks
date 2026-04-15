#!/usr/bin/env bash
# 1.check.bash -*- mode: sh -*-
#set -o errexit
set -o nounset
set -o pipefail

# shellcheck disable=SC1091
[[ -e "$POLY_SRC/lib/lib.bash" ]] && source "$POLY_SRC/lib/lib.bash"
# shellcheck disable=SC1091
[[ -e "$(poly-dir)/task-util.bash" ]] && source "$(poly-dir)/task-util.bash"

function check-environment () {
    tdot "imgen" "Checking Environment"
    if [[ -z "${POLYGLOT_TEMP:-}" ]]; then
        has_failed=1
        fail "No POLYGLOT_TEMP has been defined"
    fi
}

check-environment
