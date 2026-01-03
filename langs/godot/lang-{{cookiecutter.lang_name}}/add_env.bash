#!/usr/bin/env bash
# add_env.bash -*- mode: sh -*-
#set -o errexit
set -o nounset
set -o pipefail

# shellcheck disable=SC1091
source "$POLY_SRC/lib/lib-util.bash"
if [[ -e "$POLYGLOT_ROOT/.tasks/task-util.bash" ]]; then
   # shellcheck disable=SC1091
    source "$POLYGLOT_ROOT/.tasks/task-util.bash"
fi

POLY_CTX=$(pushctx "env")
tdot "TODO" "set any godot env vars"


echo -e "
# polyglot godot env vars

" > "$POLYGLOT_ROOT/.envrc"
