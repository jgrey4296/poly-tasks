#!/usr/bin/env bash
# uml.bash -*- mode: sh -*-
#set -o errexit
set -o nounset
set -o pipefail

# shellcheck disable=SC1091
source "$POLY_SRC/lib/lib-util.bash"
if [[ -e "$POLYGLOT_ROOT/.tasks/task-util.bash" ]]; then
    # shellcheck disable=SC1091
    source "$POLYGLOT_ROOT/.tasks/task-util.bash"
fi

function print-help () {
    # test args, if the last one is -h or --help
    # print help and exit
    case "${@: -1}" in
        -h|--help) ;;
        *) if [[ "$#" -gt 0 ]]; then
               return
           fi
           ;;
    esac
    echo -e "
usage: polyglot tool diagrams uml [-h] [file] [fmt]

positional arguments:
file : the .pu file in the _utilities/uml dir to process
fmt  : the output format for src/_data/images, or 'print'

options:
-h, --help    : show this help message and exit


"
    exit "${PRINTED_HELP:-2}"
}


tdot "diagrams" "uml"
print-help "$@"

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
