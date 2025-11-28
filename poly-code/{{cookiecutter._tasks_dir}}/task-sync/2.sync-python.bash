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

function main () {

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

    fail "TODO: hook implementation"
}

main "$@"
