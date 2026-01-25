#!/usr/bin/env bash
# sphinx.bash -*- mode: sh -*-
#set -o errexit
set -o nounset
set -o pipefail

# shellcheck disable=SC1091
source "$POLY_SRC/lib/lib-util.bash"
# shellcheck disable=SC1091
[[ -e "$POLYGLOT_ROOT/.tasks/task-util.bash" ]] && source "$POLYGLOT_ROOT/.tasks/task-util.bash"

function check () {
    [[ -e "$POLYGLOT_SPHINX_CONF_DIR/conf.py" ]] || fail "NOT FOUND: $POLYGLOT_SPHINX_CONF_DIR/conf.py"
    [[ -n "${POLYGLOT_DOCS:-}" ]] || fail "NOT DEFINED: POLYGLOT_DOCS"
}

subhead "{{cookiecutter.lang_name}}" "Building Sphinx"
check
