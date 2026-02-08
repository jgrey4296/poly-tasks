#!/usr/bin/env bash
# place in $root/.tasks/task-{name}/0.help.bash
# and chmod +x it.
set -o nounset
set -o pipefail

# shellcheck disable=SC1091
source "$POLY_SRC/lib/lib-util.bash"
# shellcheck disable=SC1091
[[ -e "$POLYGLOT_ROOT/.tasks/task-util.bash" ]] && source "$POLYGLOT_ROOT/.tasks/task-util.bash"

HELP_TEXT="
usage: polyglot task release [args ...] --[major|minor|patch] [-h]

run release tasks. ie: increment version number, generate changelog...

If no level is specified, will read input

positional arguments:
args          :

options:
-h, --help    : show this help message and exit
--major : bump the major number.
--minor : bump the minor number.
--patch : bump the patch number.

"
print-help "$HELP_TEXT" 0 "$@"
