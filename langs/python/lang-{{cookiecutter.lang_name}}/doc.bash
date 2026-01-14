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

subhead "[python]" "Building Sphinx"
check

SPHINX_OUT="$POLYGLOT_DOCS/sphinx"

echo -e "
- config location  : ${POLYGLOT_SPHINX_CONF_DIR}
- out location     : ${SPHINX_OUT}
- builder          : ${SPHINX_BUILDER:-html}
"

[[ -d "${SPHINX_OUT}" ]] && rm -r "${SPHINX_OUT}"

( uv run --frozen sphinx-build \
    --verbose \
    --write-all \
    --fresh-env \
    --conf-dir "$POLYGLOT_SPHINX_CONF_DIR" \
    --doctree-dir "$SPHINX_OUT/.doctrees" \
    --warning-file "$LOG_DIR/sphinx.log" \
    --builder "${SPHINX_BUILDER:-html}" \
    "$SRC_DIR" \
    "$SPHINX_OUT"
  ) || fail "Sphinx Failed"
