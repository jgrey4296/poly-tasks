#!/usr/bin/env bash
# A Stub language command.
# Place in $root/.tasks/lang-{name}/{cmd}.bash
# and chmod +x it.
set -o nounset
set -o pipefail

# shellcheck disable=SC1091
source "$POLY_SRC/lib/lib-util.bash"
source "$POLYGLOT_ROOT/.tasks/task-utils.bash"

DEFAULT_FILE="main.csd"

function print-help () {
    case "${@: -1}" in
        -h|--help) ;;
        *) if [[ "$#" -gt 0 ]]; then
               return
           fi
           ;;
    esac
    echo -e "
usage: polyglot lang csound run [-h] [packageName] [file|--]? [args...]

positional arguments:
packageName  : the package in root/src
file         : the file to  run
--           : Run the default file, $DEFAULT_FILE
args         : arguments to pass to csound

options:
-h, --help    : show this help message and exit

"
    exit "${PRINTED_HELP:-2}"
}

function run-csound () {
    target="$1"
    file="$2"
    shift 2
    subhead "Running Csound: $target/$file $@"
    csound "$@" "$POLYGLOT_SRC/$target/$file"
    return "$?"
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
    run-csound "$target" "$file" "${_ARGS[@]}"
    exit "$?"
}

main "$@"
