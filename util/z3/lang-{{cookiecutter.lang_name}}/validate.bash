#!/usr/bin/env bash
# validate.bash -*- mode: sh -*-
#set -o errexit
set -o nounset
set -o pipefail

# shellcheck disable=SC1091
source "$POLY_SRC/lib/lib-util.bash"
# shellcheck disable=SC1091
[[ -e "$POLYGLOT_ROOT/.tasks/task-util.bash" ]] && source "$POLYGLOT_ROOT/.tasks/task-util.bash"

tdot "z3" "Validating"
z3 "$POLYGLOT_SRC/_ai_and_logic/z3/main.z3" || fail "Z3 failed"
