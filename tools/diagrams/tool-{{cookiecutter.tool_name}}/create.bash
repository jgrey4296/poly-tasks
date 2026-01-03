#!/usr/bin/env bash
# create.bash -*- mode: sh -*-
#set -o errexit
set -o nounset
set -o pipefail

# shellcheck disable=SC1091
source "$POLY_SRC/lib/lib-util.bash"
if [[ -e "$POLYGLOT_ROOT/.tasks/task-util.bash" ]]; then
   # shellcheck disable=SC1091
    source "$POLYGLOT_ROOT/.tasks/task-util.bash"
fi

# TODO make statemachines/uml
PGLANG="diagams"
TARGET="$POLYGLOT_SRC/_utilities"
dname=$(dirname "${BASH_SOURCE[0]}")

tdot "$PGLANG" "creating fsm workspace member in $TARGET/statemachines"

if [[ ! -d "$TARGET/statemachines" ]]; then
    cp -r "$dname/_fsm" "$TARGET/statemachines"
fi

tdot "$PGLANG" "creating uml workspace member in $TARGET/statemachines"
if [[ ! -d "$TARGET/uml" ]]; then
    cp -r "$dname/_uml" "$TARGET/uml"
fi
