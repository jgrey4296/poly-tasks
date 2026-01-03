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

DEFAULT_FILE="record.ledger"

shift
tdot "ledger" "run"
pushd "$POLYGLOT_SRC/_data/" || fail "Failed to go to dir"
ledger "${1:-$DEFAULT_FILE}"
popd || fail "Failed to return from dir"
