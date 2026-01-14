#!/usr/bin/env bash
# add_env.bash -*- mode: sh -*-
#set -o errexit
set -o nounset
set -o pipefail

# shellcheck disable=SC1091
source "$POLY_SRC/lib/lib-util.bash"
# shellcheck disable=SC1091
[[ -e "$POLYGLOT_ROOT/.tasks/task-util.bash" ]] && source "$POLYGLOT_ROOT/.tasks/task-util.bash"

POLY_CTX=$(pushctx "env")
tdot "TODO" "set any godot env vars"

ENV_TEXT="
# -- polyglot godot env vars

# --
"

echo -e "$ENV_TEXT" > "$POLYGLOT_ROOT/.envrc"
