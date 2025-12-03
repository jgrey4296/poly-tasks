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
    if [[ ! -e "$POLYGLOT_ROOT/mix.exs" ]]; then
        fail "NOT FOUND: $POLYGLOT_ROOT/mix.exs"
    fi
}

tdot "[elixir]" "Building ExDoc"
check
mix docs --output "$POLYGLOT_DOCS/elixir"
