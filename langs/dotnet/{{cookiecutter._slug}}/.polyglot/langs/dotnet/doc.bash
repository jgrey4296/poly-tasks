#!/usr/bin/env bash
# doc.bash -*- mode: sh -*-
#set -o errexit
set -o nounset
set -o pipefail

# shellcheck disable=SC1091
[[ -e "$POLY_SRC/lib/lib.bash" ]] && source "$POLY_SRC/lib/lib.bash"
# shellcheck disable=SC1091
[[ -e "$(poly-dir)/task-util.bash" ]] && source "$(poly-dir)/task-util.bash"

function check () {
    [[ -e "$POLYGLOT_ROOT/docfx.json" ]] || fail "NOT FOUND: $POLYGLOT_ROOT/docfx.json"
}

tdot "dotnet" "Running docfx"
check
docfx "$POLYGLOT_ROOT/docfx.json"
