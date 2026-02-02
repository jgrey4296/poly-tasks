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
usage: polyglot task imgen [args ...] [-h]

positional arguments:
args          :

options:
-h, --help      : show this help message and exit
--window {int}  :
--collect       :
--template-dir  :
--output        :
--style         :

"


function check-environment () {
    tdot "imgen" "Checking Environment"
    if [[ -z "${POLYGLOT_TEMP:-}" ]]; then
        has_failed=1
        fail "No POLYGLOT_TEMP has been defined"
    fi
}

print-help "$HELP_TEXT" 0 "$@"
check-environment
