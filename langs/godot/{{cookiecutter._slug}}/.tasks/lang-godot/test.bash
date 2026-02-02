#!/usr/bin/env bash
# A Stub language command.
# Place in $root/.tasks/lang-{name}/{cmd}.bash
# and chmod +x it.
set -o nounset
set -o pipefail

# shellcheck disable=SC1091
source "$POLY_SRC/lib/lib-util.bash"
# shellcheck disable=SC1091
[[ -e "$POLYGLOT_ROOT/.tasks/task-util.bash" ]] && source "$POLYGLOT_ROOT/.tasks/task-util.bash"

HELP_TEXT="
usage: polyglot lang godot test [-h] [package] [filename|--] [args...]

positional arguments:
package   : The subdir of $POLYGLOT_SRC to target
filename  : the file of the package to use
args      : arguments to pass to the command

options:
-h, --help    : show this help message and exit


"

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
    tdot "godot" "test"
    godot "${_ARGS[@]}"
}

function main () {
    print-help "$HELP_TEXT" 0 "$@"
    shift
    target="$1"
    shift 1
    _ARGS=("$@")
    run-program 0 "$target" "${_ARGS[@]}"
    handle-result "$?" "$target" "${_ARGS[@]}"
    exit "$?"
}

main "$@"
