#!/usr/bin/env bash
# init.bash -*- mode: sh -*-
#set -o errexit
set -o nounset
set -o pipefail


# shellcheck disable=SC1091
source "$POLY_SRC/lib/lib-util.bash"
if [[ -e "$POLYGLOT_ROOT/.tasks/task-util.bash" ]]; then
    source "$POLYGLOT_ROOT/.tasks/task-util.bash"
fi

if [[ -f "$POLYGLOT_ROOT/tex.reqs" ]]; then
    tdot "[tex]" "Initialising"
    mkdir -p "$POLYGLOT_TEMP/tex"
    asdf cmd texlive deps "$POLYGLOT_ROOT/tex.reqs" > /dev/null || fail "tlmgr update failed"
fi
