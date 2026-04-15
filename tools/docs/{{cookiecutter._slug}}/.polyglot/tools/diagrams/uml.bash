#!/usr/bin/env bash
# uml.bash -*- mode: sh -*-
#set -o errexit
set -o nounset
set -o pipefail

# shellcheck disable=SC1091
[[ -e "$POLY_SRC/lib/lib.bash" ]] && source "$POLY_SRC/lib/lib.bash"
# shellcheck disable=SC1091
[[ -e "$(poly-dir)/task-util.bash" ]] && source "$(poly-dir)/task-util.bash"

HELP_TEXT="
usage: polyglot tool diagrams uml [-h] [file] [fmt]

positional arguments:
file : the .pu file in the _utilities/uml dir to process
fmt  : the output format for src/_data/images, or 'print'

options:
-h, --help    : show this help message and exit


"

maybe-print-help "leaf" 0 "$HELP_TEXT" "$@"

tdot "diagrams" "uml"

shift
file="$1"
shift 1

pushd "$POLYGLOT_SRC/_utilities/uml" || fail "Failed to go to uml dir"

if [[ ! -e "$file.pu" ]]; then
    fail "target file does not exist: $file.pu"
fi

case "${1:-txt}" in
    print)
        cat "$file.pu" | plantuml "-ttxt" -pipe
        ;;
    *)
        plantuml "-t$1" "-output" "$POLYGLOT_SRC/_data/images" "$file.pu"
        ;;
esac


popd || fail "Failed to return from uml dir"
