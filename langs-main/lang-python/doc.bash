#!/usr/bin/env bash
# sphinx.bash -*- mode: sh -*-
#set -o errexit
set -o nounset
set -o pipefail

# shellcheck disable=SC1091
source "$POLY_SRC/lib/lib-util.bash"
if [[ -e "$POLYGLOT_ROOT/.tasks/task-util.bash" ]]; then
    source "$POLYGLOT_ROOT/.tasks/task-util.bash"
fi

function check () {
    if [[ ! -e "$POLYGLOT_SPHINX_CONF_DIR/conf.py" ]]; then
        fail "NOT FOUND: $POLYGLOT_SPHINX_CONF_DIR/conf.py"
    fi
}

SPHINX_OUT="$POLYGLOT_DOCS/sphinx"
fname=$(basename "${BASH_SOURCE[0]}")
subhead "[python] Building Sphinx"
check

echo -e "
- config location  : ${POLYGLOT_SPHINX_CONF_DIR}
- out location     : ${SPHINX_OUT}
- builder          : ${SPHINX_BUILDER:-html}
"

if [[ -d "${SPHINX_OUT}" ]]; then
    rm -r "${SPHINX_OUT}"
fi
uv run --frozen sphinx-build \
    --verbose \
    --write-all \
    --fresh-env \
    --conf-dir "$POLYGLOT_SPHINX_CONF_DIR" \
    --doctree-dir "$SPHINX_OUT/.doctrees" \
    --warning-file "$LOG_DIR/sphinx.log" \
    --builder "${SPHINX_BUILDER:-html}" \
    "$SRC_DIR" \
    "$SPHINX_OUT"
    # || fail "Sphinx Failed"
