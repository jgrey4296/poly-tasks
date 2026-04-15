#!/usr/bin/env bash
# init.bash -*- mode: sh -*-
#set -o errexit
set -o nounset
set -o pipefail

# shellcheck disable=SC1091
[[ -e "$POLY_SRC/lib/lib.bash" ]] && source "$POLY_SRC/lib/lib.bash"
# shellcheck disable=SC1091
[[ -e "$(poly-dir)/task-util.bash" ]] && source "$(poly-dir)/task-util.bash"

if [[ -f "$POLYGLOT_ROOT/tex.reqs" ]]; then
    tdot "tex" "Initialising"
    mkdir -p "$POLYGLOT_TEMP/tex"
    asdf cmd texlive deps "$POLYGLOT_ROOT/tex.reqs" > /dev/null || fail "tlmgr update failed"
fi
