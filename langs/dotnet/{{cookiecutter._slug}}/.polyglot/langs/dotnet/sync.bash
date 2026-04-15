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
    maybe-print-help "leaf" 0 "$HELP_TEXT" "$@"
    run-program
    handle-result "$?"
    exit "$?"
}

main "$@"
