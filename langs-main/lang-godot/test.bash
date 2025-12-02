#!/usr/bin/env bash
# A Stub language command.
# Place in $root/.tasks/lang-{name}/{cmd}.bash
# and chmod +x it.
set -o nounset
set -o pipefail

DEFAULT_FILE="TODO.txt"

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
usage: polyglot lang godot test [-h] [package] [filename|--] [args...]

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
    target="$1"
    shift
    _ARGS=("--headless"
           "--debug"
           "--upwards"
           "--script"
           "--path" "$POLYGLOT_SRC/$target"
           "addons/gut/gut_cmdln.gd"
           "-gexit"
    )
    godot "${_ARGS[@]}"
}

function main () {
    print-help "$@"
    subhead "Parsing Args"
    shift
    target="$1"
    shift 1
    _ARGS=("$@")
    run-program 0 "$target" "${_ARGS[@]}"
    handle-result "$?" "$target" "${_ARGS[@]}"
    exit "$?"
}

main "$@"
