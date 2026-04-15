#!/usr/bin/env bash
# run.bash -*- mode: sh -*-
#set -o errexit
set -o nounset
set -o pipefail

# shellcheck disable=SC1091
[[ -e "$POLY_SRC/lib/lib.bash" ]] && source "$POLY_SRC/lib/lib.bash"
# shellcheck disable=SC1091
[[ -e "$(poly-dir)/task-util.bash" ]] && source "$(poly-dir)/task-util.bash"

DEFAULT_FILE="main.cep"
shift
tdot "ceptre" "TODO: run"
pushd "$POLYGLOT_SRC/_ai_and_logic/cep" || fail "Failed to go to dir"
ceptre "${1:-$DEFAULT_FILE}"
popd || fail "Failed to return from dir"
