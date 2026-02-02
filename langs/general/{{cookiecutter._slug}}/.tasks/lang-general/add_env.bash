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

tdot "{{cookiecutter.lang_name}}" "Adding env vars"
fail "TODO"

ENV_TEXT="
# -- polyglot {{cookiecutter.lang_name}} env vars

# --
"

echo -e "$ENV_TEXT" > "$POLYGLOT_ROOT/.envrc"
