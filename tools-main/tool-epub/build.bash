#!/usr/bin/env bash
# A Stub tool command.
# Place in $root/.tasks/tool-{name}/{cmd}.bash
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
usage: polyglot tool epub build [-h] [args...]

Build a .epub from its components

positional arguments:
args      : arguments to pass to the tool

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

function run-tool () {
    if [[ ! -d "$POLYGLOT_SRC/_epub" ]]; then
        subhead "Skipping Epub build, no src/_epub dir."
        exit 0
    fi

    header "Building Epub"
    TEMPDIR="$POLYGLOT_TEMP/epub"
    mkdir -p "$TEMPDIR"
    zip -r "$TEMPDIR/test.zip" "$POLYGLOT_ROOT/src/_epub"/*
    ebook-convert "$TEMPDIR/test.zip" "$TEMPDIR/test.epub"
    rm "$TEMPDIR/test.zip"
}

function main () {
    print-help "$@"
    subhead "Parsing Args"
    shift
    _ARGS=("$@")
    run-tool "$target" "$file" "${_ARGS[@]}"
    handle-result "$?" "$target" "$file" "${_ARGS[@]}"
    exit "$?"
}

main "$@"
