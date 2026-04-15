#!/usr/bin/env bash
# install-fonts.bash -*- mode: sh -*-
#set -o errexit
set -o nounset
set -o pipefail

# shellcheck disable=SC1091
[[ -e "$POLY_SRC/lib/lib.bash" ]] && source "$POLY_SRC/lib/lib.bash"
# shellcheck disable=SC1091
[[ -e "$(poly-dir)/task-util.bash" ]] && source "$(poly-dir)/task-util.bash"

HELP_TEXT="
usage: polyglot tool assets install-fonts [-h] [args ...]

Install all .ttf fonts

positional arguments:
args          :

options:
-h, --help    : show this help message and exit

"

maybe-print-help "leaf" 0 "$HELP_TEXT" "$@"

tdot "fonts" "TODO: install fonts"

# cp *.ttf "$HOME/.local/share/fonts"
# fc-cache -f -v
