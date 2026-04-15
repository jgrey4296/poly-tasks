#!/usr/bin/env bash
# export.bash -*- mode: sh -*-
#set -o errexit
set -o nounset
set -o pipefail

# shellcheck disable=SC1091
[[ -e "$POLY_SRC/lib/lib.bash" ]] && source "$POLY_SRC/lib/lib.bash"
# shellcheck disable=SC1091
[[ -e "$(poly-dir)/task-util.bash" ]] && source "$(poly-dir)/task-util.bash"

HELP_TEXT="
usage: polyglot tool assets export [-h] [args ...]

positional arguments:
args          :

options:
-h, --help    : show this help message and exit

"

maybe-print-help "leaf" 0 "$HELP_TEXT" "$@"
tdot "assets" "TODO: export a group of assets"
