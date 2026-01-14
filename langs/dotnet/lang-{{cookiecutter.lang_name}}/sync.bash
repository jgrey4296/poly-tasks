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

PRINTED_HELP="${PRINTED_HELP:-2}"
HELP_TEXT="
usage: polyglot lang dotnet sync [-h]

Sync the sln file for dotnet.

positional arguments:

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
    dotnet new sln --force
    fdfind ".(cs|fs)proj" "$POLYGLOT_ROOT" --threads=1 --exec dotnet sln add
}

function main () {
    print-help "$HELP_TEXT" 0 "$@"
    run-program
    handle-result "$?"
    exit "$?"
}

main "$@"
