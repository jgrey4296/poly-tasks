#!/usr/bin/env bash
# place in $root/.tasks/task-{name}/0.help.bash
# and chmod +x it.
set -o nounset
set -o pipefail

# shellcheck disable=SC1091
[[ -e "$POLY_SRC/lib/lib.bash" ]] && source "$POLY_SRC/lib/lib.bash"
# shellcheck disable=SC1091
[[ -e "$(poly-dir)/task-util.bash" ]] && source "$(poly-dir)/task-util.bash"

HELP_TEXT="
usage: polyglot task meta [args ...] [-h]

Apply metadata to library files.

positional arguments:
args          :

options:
-h, --help     : show this help message and exit
--window {int} :
--collect      :

"

maybe-print-help "leaf" 0 "$HELP_TEXT" "$@"
