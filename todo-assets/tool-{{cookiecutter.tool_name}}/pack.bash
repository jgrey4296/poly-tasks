#!/usr/bin/env bash
# gen-zip.bash -*- mode: sh -*-
#set -o errexit
set -o nounset
set -o pipefail

# shellcheck disable=SC1091
source "$POLY_SRC/lib/lib-util.bash"
if [[ -e "$POLYGLOT_ROOT/.tasks/task-util.bash" ]]; then
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
usage: polyglot tool assets pack [-h] [args ...]

positional arguments:
args          :

options:
-h, --help    : show this help message and exit


"
    exit "${PRINTED_HELP:-2}"
}

shift
target="$1"
shift
mkdir -p "$POLYGLOT_ROOT/.temp"
name=$(basename "$target")
tdot "pack" "packing $target into zip file: .temp/$name.zip"
zip -r "$POLYGLOT_ROOT/.temp/$name.zip" "$POLYGLOT_ROOT/$target"
tdot "pack" "Complete."
