#!/usr/bin/env bash
# A Stub language command.
# Place in $root/.tasks/lang-{name}/{cmd}.bash
# and chmod +x it.
set -o nounset
set -o pipefail

# shellcheck disable=SC1091
[[ -e "$POLY_SRC/lib/lib.bash" ]] && source "$POLY_SRC/lib/lib.bash"
# shellcheck disable=SC1091
[[ -e "$(poly-dir)/task-util.bash" ]] && source "$(poly-dir)/task-util.bash"

DEFAULT_FILE="main.csd"

HELP_TEXT="
usage: polyglot lang csound run [-h] [packageName] [file|--]? [args...]

positional arguments:
packageName  : the package in root/src
file         : the file to  run
--           : Run the default file, $DEFAULT_FILE
args         : arguments to pass to csound

options:
-h, --help    : show this help message and exit

"

function run-csound () {
    target="$1"
    file="$2"
    shift 2
    tdot "csound" "Running: $target/$file ${*}"
    csound "$@" "$POLYGLOT_SRC/$target/$file"
    return "$?"
}

function main () {
    maybe-print-help "leaf" 0 "$HELP_TEXT" "$@"
    tdot "csound" "Parsing Args"
    shift
    target="$1"
    case "$2" in
        --) file="$DEFAULT_FILE" ;;
        *)  file="$2" ;;
    esac
    shift 2
    _ARGS=("$@")
    check-target "$target" "$file"
    run-csound "$target" "$file" "${_ARGS[@]}"
    exit "$?"
}

main "$@"
