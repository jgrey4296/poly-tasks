#!/usr/bin/env bash
# A Stub tool command.
# Place in $root/.tasks/tool-{name}/{cmd}.bash
# and chmod +x it.
set -o nounset
set -o pipefail

# shellcheck disable=SC1091
[[ -e "$POLY_SRC/lib/lib.bash" ]] && source "$POLY_SRC/lib/lib.bash"
# shellcheck disable=SC1091
[[ -e "$(poly-dir)/task-util.bash" ]] && source "$(poly-dir)/task-util.bash"

TEMPDIR="$POLYGLOT_TEMP/epub"

HELP_TEXT="
usage: polyglot tool epub build [-h] [args...]

Build a .epub from its components

positional arguments:
args      : arguments to pass to the tool

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

function run-tool () {
    if [[ ! -d "$POLYGLOT_SRC/_epub" ]]; then
        tdot "epub" "Skipping Epub build, no src/_epub dir."
        exit 0
    fi

    tdot "epub" "Building"
    mkdir -p "$TEMPDIR"
    zip -r "$TEMPDIR/test.zip" "$POLYGLOT_ROOT/src/_epub"/*
    ebook-convert "$TEMPDIR/test.zip" "$TEMPDIR/test.epub"
    rm "$TEMPDIR/test.zip"
}

function main () {
    maybe-print-help "leaf" 0 "$HELP_TEXT" "$@"
    tdot "epub" "Parsing Args"
    shift
    _ARGS=("$@")
    run-tool "$target" "$file" "${_ARGS[@]}"
    handle-result "$?" "$target" "$file" "${_ARGS[@]}"
    exit "$?"
}

main "$@"
