#!/usr/bin/env bash
# environment.bash -*- mode: sh -*-
#set -o errexit
set -o nounset
set -o pipefail

# shellcheck disable=SC1091
source "$POLY_SRC/lib/lib-util.bash"
# shellcheck disable=SC1091
[[ -e "$POLYGLOT_ROOT/.tasks/task-util.bash" ]] && source "$POLYGLOT_ROOT/.tasks/task-util.bash"

POLY_CTX=$(pushctx "env")
tdot "TODO" "set any python env vars"

tdot "sphinx" "Adding sphinx env vars"

ENV_TEXT="
# -- polyglot python env vars
export POLYGLOT_SPHINX_BUILDER=\"bibhtml\"
export POLYGLOT_SPHINX_CONF_DIR=\"\$PWD/src/_sphinx\"
# --
"

echo -e "$ENV_TEXT" > "$POLYGLOT_ROOT/.envrc"
