#!/usr/bin/env bash
# add_env.bash -*- mode: sh -*-
#set -o errexit
set -o nounset
set -o pipefail

# shellcheck disable=SC1091
[[ -e "$POLY_SRC/lib/lib.bash" ]] && source "$POLY_SRC/lib/lib.bash"
# shellcheck disable=SC1091
[[ -e "$(poly-dir)/task-util.bash" ]] && source "$(poly-dir)/task-util.bash"

POLY_CTX=$(pushctx "env")
tdot "TODO" "set any sql env vars"


echo -e "
# polyglot sql env vars

" > "$POLYGLOT_ROOT/.envrc"
