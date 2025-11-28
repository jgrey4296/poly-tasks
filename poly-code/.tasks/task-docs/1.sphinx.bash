#!/usr/bin/env bash
# Stub shell script for a task hook.
# Place in $root/.tasks/task-{name}/[0-9]+[a-z].{desc}.bash
# then make it executable with chmod +x
# Return Codes:
# - 0 : success
# - 1 : failure
# - 2 | $PRINTED_HELP
set -o nounset
set -o pipefail

# shellcheck disable=SC1091
source "$POLY_SRC/lib/lib-util.bash"
if [[ -e "$POLYGLOT_ROOT/.tasks/task-util.bash" ]]; then
    # shellcheck disable=SC1091
    source "$POLYGLOT_ROOT/.tasks/task-util.bash"
fi

function check () {
    if [[ ! -e "$SPHINX_CONF_DIR/conf.py" ]]; then
        fail "NOT FOUND: $SPHINX_CONF_DIR/conf.py"
    fi
}

function main () {
    SPHINX_OUT="$POLYGLOT_DOCS/sphinx"

    # Parse args:
    while [[ $# -gt 0 ]]; do
        case $1 in
            -t|--target)
                echo "Target: $2"
                ;;
            --bloo=*)
                echo "Assignment: $1"
                IFS="=" read -ra KEYVAL <<< "$1"
                echo "Key: ${KEYVAL[0]/--/}"
                echo "Val: ${KEYVAL[1]}"
                ;;
            *) # Positional
                echo "Positional: $1"
                ;;
        esac
        shift
    done

    fname=$(basename "${BASH_SOURCE[0]}")
    header "($HOOK_NUM): $fname.\n* Args: " "$@"
    subhead "[python] Building Sphinx"
    echo "- config location: ${SPHINX_CONF_DIR}"
    echo "- out location: ${SPHINX_OUT}"
    echo "- builder: ${SPHINX_BUILDER}"
    echo ""

    check
    if [[ -d "${SPHINX_OUT}" ]]; then
        rm -r "${SPHINX_OUT}"
    fi
    uv run --frozen sphinx-build \
        --verbose \
        --write-all \
        --fresh-env \
        --conf-dir "$SPHINX_CONF_DIR" \
        --doctree-dir "$SPHINX_OUT/.doctrees" \
        --warning-file "$LOG_DIR/sphinx.log" \
        --builder "$SPHINX_BUILDER" \
        "$SRC_DIR" \
        "$SPHINX_OUT"
        # || fail "Sphinx Failed"
}

main "$@"
