#!/usr/bin/env bash
# environment.bash -*- mode: sh -*-
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
tdot "TODO" "set any python env vars"

tdot "sphinx" "Adding sphinx env vars"
echo -e "
# polyglot python env vars
export POLYGLOT_SPHINX_BUILDER=\"bibhtml\"
export POLYGLOT_SPHINX_CONF_DIR=\"\$PWD/src/_sphinx\"
" > "$POLYGLOT_ROOT/.envrc"
