#!/usr/bin/env bash
# sphinx.bash -*- mode: sh -*-
#set -o errexit
set -o nounset
set -o pipefail

# shellcheck disable=SC1091
[[ -e "$POLY_SRC/lib/lib.bash" ]] && source "$POLY_SRC/lib/lib.bash"
# shellcheck disable=SC1091
[[ -e "$(poly-dir)/task-util.bash" ]] && source "$(poly-dir)/task-util.bash"

function check () {
    [[ -e "$POLYGLOT_SPHINX_CONF_DIR/conf.py" ]] || fail "NOT FOUND: $POLYGLOT_SPHINX_CONF_DIR/conf.py"
    [[ -n "${POLYGLOT_DOCS:-}" ]] || fail "NOT DEFINED: POLYGLOT_DOCS"
}

subhead "{{cookiecutter.lang_name}}" "Building Sphinx"
check
