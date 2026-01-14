#!/usr/bin/env bash
# doc.bash -*- mode: sh -*-
#set -o errexit
set -o nounset
set -o pipefail

# shellcheck disable=SC1091
source "$POLY_SRC/lib/lib-util.bash"
# shellcheck disable=SC1091
[[ -e "$POLYGLOT_ROOT/.tasks/task-util.bash" ]] && source "$POLYGLOT_ROOT/.tasks/task-util.bash"

function check () {
    [[ -e "$POLYGLOT_ROOT/mix.exs" ]] || fail "NOT FOUND: $POLYGLOT_ROOT/mix.exs"
    [[ -x mix  ]] || fail "mix is not executable"
}

tdot "elixir" "Building ExDoc"
check
mix docs --output "$POLYGLOT_DOCS/elixir"
