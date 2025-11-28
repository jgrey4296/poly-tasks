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
usage: polyglot lang {lang} {cmd} [-h] [package] [filename|--] [args...]

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
    fail "TODO: godot build"
    _ARGS=(
        "--headless"
        "--verbose"
        "--export-release" "android"
        "$POLYGLOT_TEMP/godot/android/"
        )
    godot "${_ARGS[@]}"
}

function main () {
    print-help "$@"
    subhead "Parsing Args"
    shift
    target="$1"
    case "$2" in
        --) file="$DEFAULT_FILE" ;;
        *)  file="$2" ;;
    esac
    shift 2
    _ARGS=("$@")
    check-target "$target" "$file"
    run-program 0 "$target" "$file" "${_ARGS[@]}"
    handle-result "$?" "$target" "$file" "${_ARGS[@]}"
    exit "$?"
}

main "$@"
