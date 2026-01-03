#!/usr/bin/env bash
# A Stub language command.
# Place in $root/.tasks/lang-{name}/{cmd}.bash
# and chmod +x it.
set -o nounset
set -o pipefail

DEFAULT_FILE="main.z3"
PGLANG="F*"

# shellcheck disable=SC1091
source "$POLY_SRC/lib/lib-util.bash"
if [[ -e "$POLYGLOT_ROOT/.tasks/task-util.bash" ]]; then
    # shellcheck disable=SC1091
    source "$POLYGLOT_ROOT/.tasks/task-util.bash"
fi

function print-help () {
    case "${@: -1}" in
        -h|--help) ;;
        *) if [[ "$#" -gt 0 ]]; then
               return
           fi
           ;;
    esac
    echo -e "
usage: polyglot lang $PGLANG run [-h] [package] [filename|--] [args...]

run a $PGLANG file

positional arguments:
package   : The subdir of $POLYGLOT_SRC to target
filename  : the file of the package to use
args      : arguments to pass to the command

options:
-h, --help    : show this help message and exit

"
    exit "${PRINTED_HELP:-2}"
}

function handle-result () {
    result="$1"
    shift

    case "$result" in
        0) exit 0 ;;
        1) fail "Command Failed" ;;
        *) fail "Unknown result code: $result"
    esac
}

function run-program () {
    file="$1"
    shift
    _ARGS=(
        "-T:10" # timeout in ten seconds
        "$@"
        )

    mkdir -p "$POLYGLOT_TEMP/fstar"
    tdot "$PGLANG" "Running: $file"
    fail "TODO"
}

function main () {
    print-help "$@"
    tdot "$PGLANG" "Parsing Args"
    shift
    case "$1" in
        --) file="$DEFAULT_FILE" ;;
        *)  file="$2" ;;
    esac
    shift 2
    _ARGS=("$@")
    check-target "_ai_and_logic/fstar" "$file"
    run-program "$file" "${_ARGS[@]}"
    handle-result "$?"
    exit "$?"
}

main "$@"
