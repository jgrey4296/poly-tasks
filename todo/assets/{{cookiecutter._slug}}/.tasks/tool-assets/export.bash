#!/usr/bin/env bash
# export.bash -*- mode: sh -*-
#set -o errexit
set -o nounset
set -o pipefail

# shellcheck disable=SC1091
source "$POLY_SRC/lib/lib-util.bash"
# shellcheck disable=SC1091
[[ -e "$POLYGLOT_ROOT/.tasks/task-util.bash" ]] && source "$POLYGLOT_ROOT/.tasks/task-util.bash"

HELP_TEXT="
usage: polyglot tool assets export [-h] [args ...]

positional arguments:
args          :

options:
-h, --help    : show this help message and exit

"

print-help "$HELP_TEXT" 0 "$@"
tdot "assets" "TODO: export a group of assets"
