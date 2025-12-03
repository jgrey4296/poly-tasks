#!/usr/bin/env bash
# run.bash -*- mode: sh -*-
#set -o errexit
set -o nounset
set -o pipefail

# shellcheck disable=SC1091
source "$POLY_SRC/lib/lib-util.bash"
if [[ -e "$POLYGLOT_ROOT/.tasks/task-util.bash" ]]; then
   # shellcheck disable=SC1091
    source "$POLYGLOT_ROOT/.tasks/task-util.bash"
fi

DEFAULT_FILE="main.cep"
shift
tdot "[ceptre]" "TODO: run"
pushd "$POLYGLOT_SRC/_utilities/cep" || fail "Failed to go to dir"
ceptre "${1:-$DEFAULT_FILE}"
popd || fail "Failed to return from dir"
