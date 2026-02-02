#!/usr/bin/env bash
# validate.bash -*- mode: sh -*-
#set -o errexit
set -o nounset
set -o pipefail

# shellcheck disable=SC1091
source "$POLY_SRC/lib/lib-util.bash"
# shellcheck disable=SC1091
[[ -e "$POLYGLOT_ROOT/.tasks/task-util.bash" ]] && source "$POLYGLOT_ROOT/.tasks/task-util.bash"

tdot "diagrams" "TODO: Validating FSMs"

tdot "diagrams" "TODO: Validating Plantuml"
plantuml --version >/dev/null || fail "Plantuml failed"
dot -V 2>/dev/null || fail "Dot failed"
