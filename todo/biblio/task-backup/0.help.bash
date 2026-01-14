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
usage: polyglot task backup [args ...] [-h]

positional arguments:
args          :

options:
-h, --help    : show this help message and exit

"

function check-environment () {
    subhead "Checking Environment"
    has_failed=0
    if [[ -z "${BIBLIO_LIB:-}" ]]; then
        has_failed=1
        echo -e "!-- No BIBLIO_LIB has been defined"
    fi

    if [[ -z "${BIBLIO_BKUP:-}" ]]; then
        has_failed=1
        echo -e "!-- No BIBLIO_BKUP has been defined"
    fi

    if [[ "$has_failed" -gt 0 ]]; then
        fail "Missing EnvVars"
    fi
}

print-help "$HELP_TEXT" 0 "$@"
check-environment
