#!/usr/bin/env bash
# init.bash -*- mode: sh -*-
#set -o errexit
set -o nounset
set -o pipefail

# shellcheck disable=SC1091
source "$POLY_SRC/lib/lib-util.bash"
if [[ -e "$POLYGLOT_ROOT/.tasks/task-util.bash" ]]; then
    # shellcheck disable=SC1091
    source "$POLYGLOT_ROOT/.tasks/task-util.bash"
fi

tdot "venv" "init"
[[ -d "$POLYGLOT_TEMP/venv" ]] || uv venv
tdot "venv" "sync"
uv sync --all-groups >/dev/null

tdot "sphinx" "TODO"

if [[ -e "$POLYGLOT_ROOT/.pre-commit-config.yaml" ]]; then
    tdot "precommit"  "Installing pre-commit hooks"
    pre-commit install
fi
