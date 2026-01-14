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
usage: polyglot task stub [args ...] [-h]

positional arguments:
args          :

options:
-h, --help      : show this help message and exit
--window {int}  :
--collect       :

"

function check-environment () {
    subhead "Checking Environment"
    has_failed=0

    if [[ -z "${BIBLIO_DROPBOX:-}" ]]; then
        has_failed=1
        echo -e "!-- No BIBLIO_DROPBOX has been defined"
    fi
    if [[ -z "${BIBLIO_TODO:-}" ]]; then
        has_failed=1
        echo -e "!-- No BIBLIO_TODO has been defined"
    fi
    if [[ -z "${BIBLIO_STUB_FILE:-}" ]]; then
        has_failed=1
        echo -e "!-- No BIBLIO_STUB_FILE has been defined"
    fi

    [[ "$has_failed" -eq 0 ]] || fail "Missing EnvVars"

}

print-help "$HELP_TEXT" 0 "$@"
check-environment
