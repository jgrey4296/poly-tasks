#!/usr/bin/env bash
# A Stub language command.
# Place in $root/.tasks/lang-{name}/{cmd}.bash
# and chmod +x it.
set -o nounset
set -o pipefail

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
usage: polyglot lang dotnet sync [-h]

Sync the sln file for dotnet.

positional arguments:

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
    dotnet new sln --force
    fdfind ".(cs|fs)proj" "$POLYGLOT_ROOT" --threads=1 --exec dotnet sln add
}

function main () {
    print-help "$@"
    run-program
    handle-result "$?"
    exit "$?"
}

main "$@"
