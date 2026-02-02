#!/usr/bin/env bash
# install-fonts.bash -*- mode: sh -*-
#set -o errexit
set -o nounset
set -o pipefail

# shellcheck disable=SC1091
source "$POLY_SRC/lib/lib-util.bash"
# shellcheck disable=SC1091
[[ -e "$POLYGLOT_ROOT/.tasks/task-util.bash" ]] && source "$POLYGLOT_ROOT/.tasks/task-util.bash"

HELP_TEXT="
usage: polyglot tool assets install-fonts [-h] [args ...]

Install all .ttf fonts

positional arguments:
args          :

options:
-h, --help    : show this help message and exit

"

print-help "$HELP_TEXT" 0 "$@"

tdot "fonts" "TODO: install fonts"

# cp *.ttf "$HOME/.local/share/fonts"
# fc-cache -f -v
