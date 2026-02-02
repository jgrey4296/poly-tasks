#!/usr/bin/env bash
# check.bash -*- mode: sh -*-
#set -o errexit
set -o nounset
set -o pipefail

# shellcheck disable=SC1091
source "$POLY_SRC/lib/lib-util.bash"
# shellcheck disable=SC1091
[[ -e "$POLYGLOT_ROOT/.tasks/task-util.bash" ]] && source "$POLYGLOT_ROOT/.tasks/task-util.bash"

HELP_TEXT="
usage: polyglot tool assets check [-h] [args ...]

positional arguments:
args          :

options:
-h, --help    : show this help message and exit

"

print-help "$HELP_TEXT" 0 "$@"

# Check the asset metadata matches actual
[[ -d "$PWD/.assets" ]] || fail ".assets directory not found."

name=$(basename "$PWD")
integrity="$PWD/.assets/${name}.integrity"
[[ -e "$integrity" ]] || fail "Integrity list not found: ${integrity}"

temp=$( mktemp )
tdot "check" "Getting current files."
( fdfind \
    --hidden \
    --type f \
    --exclude ".assets" \
    --exec sha256sum > "${temp}"
)

count=$(cat < ${temp} | wc -l)
tdot "check" "Found $count current files."

tdot "check" "Checking current against integrity list."
( shasum \
    --algorithm 256 \
    --warn \
    --quiet \
    --check "${integrity}" "${temp}"
 )

if [[ "$?" = 0 ]]; then
    tdot "check" "Success"
else
    fail "Integrity check failed."
fi
