#!/usr/bin/env bash
# check.bash -*- mode: sh -*-
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
usage: polyglot tool assets check [-h] [args ...]

positional arguments:
args          :

options:
-h, --help    : show this help message and exit


"
    exit "${PRINTED_HELP:-2}"
}

print-help "$@"

# Check the asset metadata matches actual
if [[ ! -d "$PWD/.assets" ]]; then
    fail ".assets directory not found."
fi

name=$(basename "$PWD")
integrity="$PWD/.assets/${name}.integrity"
if [[ ! -e "$integrity" ]]; then
    fail "Integrity list not found: ${integrity}"
fi

temp=$( mktemp )
tdot "[check]" "Getting current files."
fdfind \
    --hidden \
    --type f \
    --exclude ".assets" \
    --exec sha256sum > "${temp}"

count=$(cat < ${temp} | wc -l)
tdot "[check]" "Found $count current files."

tdot "[check]" "Checking current against integrity list."
shasum \
    --algorithm 256 \
    --warn \
    --quiet \
    --check "${integrity}" "${temp}"

if [[ "$?" = 0 ]]; then
    tdot "[check]" "Success"
else
    fail "Integrity check failed."
fi
