#!/usr/bin/env bash
# environment.bash -*- mode: sh -*-
#set -o errexit
set -o nounset
set -o pipefail

# shellcheck disable=SC1091
[[ -e "$POLY_SRC/lib/lib.bash" ]] && source "$POLY_SRC/lib/lib.bash"
# shellcheck disable=SC1091
[[ -e "$(poly-dir)/task-util.bash" ]] && source "$(poly-dir)/task-util.bash"

POLY_CTX=$(pushctx "env")

tdot "{{cookiecutter.lang_name}}" "Adding env vars"
fail "TODO"

ENV_TEXT="
# -- polyglot {{cookiecutter.lang_name}} env vars

# --
"

echo -e "$ENV_TEXT" > "$POLYGLOT_ROOT/.envrc"
