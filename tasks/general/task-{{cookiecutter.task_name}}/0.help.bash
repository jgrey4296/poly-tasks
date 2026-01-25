#!/usr/bin/env bash
# place in $root/.tasks/task-{name}/0.help.bash
# and chmod +x it.
set -o nounset
set -o pipefail

# shellcheck disable=SC1091
source "$POLY_SRC/lib/lib-util.bash"
# shellcheck disable=SC1091
[[ -e "$POLYGLOT_ROOT/.tasks/task-util.bash" ]] && source "$POLYGLOT_ROOT/.tasks/task-util.bash"

PRINTED_HELP="${PRINTED_HELP:-2}"
HELP_TEXT="
usage: polyglot task {{cookiecutter.task_name}} [args ...] [-h]


positional arguments:
args          :

options:
-h, --help    : show this help message and exit

"

fail "TODO"
print-help "$HELP_TEXT" 0 "$@"
