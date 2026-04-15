#!/usr/bin/env bash
# validate.bash -*- mode: sh -*-
#set -o errexit
set -o nounset
set -o pipefail

# shellcheck disable=SC1091
[[ -e "$POLY_SRC/lib/lib.bash" ]] && source "$POLY_SRC/lib/lib.bash"
# shellcheck disable=SC1091
[[ -e "$(poly-dir)/task-util.bash" ]] && source "$(poly-dir)/task-util.bash"

tdot "diagrams" "TODO: Validating FSMs"

tdot "diagrams" "TODO: Validating Plantuml"
plantuml --version >/dev/null || fail "Plantuml failed"
dot -V 2>/dev/null || fail "Dot failed"
