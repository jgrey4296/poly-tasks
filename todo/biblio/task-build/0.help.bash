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
usage: polyglot task {taskname} [args ...] [-h]

positional arguments:
args          :
{src dir}         : the dir of source .rst and .bib files

options:
-h, --help    : show this help message and exit
-nc | -no-clean   : don't delete existing site files
--conf {conf dir} : the dir for the conf.py
--out  {out dir}  : the subdir of .temp/site to build into

"

function check-environment () {
    subhead "Checking Environment"
    has_failed=0

    if [[ -z "${POLYGLOT_ROOT:-}" ]]; then
        has_failed=1
        echo -e "!-- No POLYGLOT_ROOT has been defined"
    fi

    if [[ "$has_failed" -gt 0 ]]; then
        fail "Missing EnvVars"
    fi
}

print-help "$HELP_TEXT" 0 "$@"
check-environment
