#!/usr/bin/env bash
# 10.init.bash -*- mode: sh -*-
#set -o errexit
set -o nounset
set -o pipefail

# shellcheck disable=SC1091
source "$POLY_SRC/lib/lib-util.bash"
if [[ -e "$POLYGLOT_ROOT/.tasks/task-util.bash" ]]; then
   # shellcheck disable=SC1091
    source "$POLYGLOT_ROOT/.tasks/task-util.bash"
fi

tdot "environment" "Adding default environment vars to .envrc"

echo -e "
##-- polyglot defaults
# Polyglot Environment Variables for .envrc
export POLYGLOT_ROOT="$PWD"
export POLYGLOT_PROJ_SRC="$PWD/src"
export POLYGLOT_SRC="$PWD/src"
export POLYGLOT_TEMP="$PWD/.temp"
export POLYGLOT_SEED="23523"

# Sphinx documentation:
export POLYGLOT_SPHINX_BUILDER="bibhtml"
export POLYGLOT_SPHINX_CONF_DIR="$PWD/src/_sphinx"

# For task-local python utilities:
# export PYTHONPATH="$PWD/.tasks:$PYTHONPATH"
##-- end polyglot defaults
" >> "$POLYGLOT_ROOT/.envrc"
