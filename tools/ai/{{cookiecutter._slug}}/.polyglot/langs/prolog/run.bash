#!/usr/bin/env bash
# A Stub language command.
# Place in $root/.tasks/lang-{name}/{cmd}.bash
# and chmod +x it.
# https://www.swi-prolog.org/pldoc/man?section=cmdline
set -o nounset
set -o pipefail

DEFAULT_FILE="main.pl"

# shellcheck disable=SC1091
[[ -e "$POLY_SRC/lib/lib.bash" ]] && source "$POLY_SRC/lib/lib.bash"
# shellcheck disable=SC1091
[[ -e "$(poly-dir)/task-util.bash" ]] && source "$(poly-dir)/task-util.bash"

HELP_TEXT="
usage: polyglot lang prolog run [package] [filename|--] [args...] [-h]

Run Swipl

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
    file="$2"
    shift 2
    tdot "prolog" "Running: $target/$file"
    swipl "$POLYGLOT_SRC/$target/$file" | tee "$POLYGLOT_TEMP/$target-$file.result" "$@"
}

function main () {
    maybe-print-help "leaf" 0 "$HELP_TEXT" "$@"
    tdot "prolog" "Parsing Args"
    shift
    target="$1"
    case "$2" in
        --) file="$DEFAULT_FILE" ;;
        *)  file="$2" ;;
    esac
    shift 2
    _ARGS=("$@")
    check-target "$target" "$file"
    mkdir -p "$POLYGLOT_TEMP/prolog"
    run-program 0 "$target" "$file" "${_ARGS[@]}"
    handle-result "$?" "$target" "$file" "${_ARGS[@]}"
    exit "$?"
}

main "$@"
