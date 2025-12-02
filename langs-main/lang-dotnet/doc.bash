#!/usr/bin/env bash
# doc.bash -*- mode: sh -*-
#set -o errexit
set -o nounset
set -o pipefail


# shellcheck disable=SC1091
source "$POLY_SRC/lib/lib-util.bash"
if [[ -e "$POLYGLOT_ROOT/.tasks/task-util.bash" ]]; then
    source "$POLYGLOT_ROOT/.tasks/task-util.bash"
fi

function check () {
    if [[ ! -e "$POLYGLOT_ROOT/docfx.json" ]]; then
        fail "NOT FOUND: $POLYGLOT_ROOT/docfx.json"
    fi
}

subhead "[dotnet] Running docfx"
check
docfx "$POLYGLOT_ROOT/docfx.json"
