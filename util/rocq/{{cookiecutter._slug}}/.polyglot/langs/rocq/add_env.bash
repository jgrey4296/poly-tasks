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
tdot "TODO" "set any rocq env vars"

ENV_TEXT='
# -- polyglot rocq env vars
PG_OPAM_SWITCH_NAME=$(basename $POLYGLOT_ROOT")
# --
'

echo -e "$ENV_TEXT" > "$POLYGLOT_ROOT/.envrc"
