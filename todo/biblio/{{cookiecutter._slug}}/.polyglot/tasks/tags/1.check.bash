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
    subhead "Checking Environment"
    has_failed=0

    if [[ -z "${POLYGLOT_ROOT:-}" ]]; then
        has_failed=1
        echo -e "!-- No POLYGLOT_ROOT has been defined"
    fi
    if [[ -z "${POLYGLOT_TEMP:-}" ]]; then
        has_failed=1
        echo -e "!-- No POLYGLOT_TEMP has been defined"
    fi
    if [[ -z "${BIBLIO_TOTAL_BOOKMARKS:-}" ]]; then
        has_failed=1
        echo -e "!-- No BIBLIO_TOTAL_BOOKMARKS has been defined"
    fi
    if [[ -z "${BIBLIO_LIB:-}" ]]; then
        has_failed=1
        echo -e "!-- No BIBLIO_LIB has been defined"
    fi

    [[ "$has_failed" -eq 0 ]] || fail "Missing EnvVars"

}

check-environment
