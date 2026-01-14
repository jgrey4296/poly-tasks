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

DEFAULT_FILE="main.z3"
HELP_TEXT="
usage: polyglot lang z3 run [-h] [package] [filename|--] [args...]

run a z3 file

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
    file="$1"
    shift
    _ARGS=(
        "-T:10" # timeout in ten seconds
        "$@"
        )

    mkdir -p "$POLYGLOT_TEMP/z3"
    tdot "z3" "Running: $file"
    z3 "${_ARGS[@]}" "$POLYGLOT_SRC/_ai_and_logic/z3/$file" | tee "$POLYGLOT_TEMP/z3/z3-$file.result"
}

function main () {
    print-help "$HELP_TEXT" 0 "$@"
    tdot "z3" "Parsing Args"
    shift
    case "$1" in
        --) file="$DEFAULT_FILE" ;;
        *)  file="$2" ;;
    esac
    shift 2
    _ARGS=("$@")
    check-target "_utilities/z3" "$file"
    run-program "$file" "${_ARGS[@]}"
    handle-result "$?"
    exit "$?"
}

main "$@"
