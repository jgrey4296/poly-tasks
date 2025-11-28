#!/usr/bin/env bash
# place in $root/.tasks/task-{name}/0.help.bash
# and chmod +x it.
set -o nounset
set -o pipefail

# shellcheck disable=SC1091
source "$POLY_SRC/lib/lib-util.bash"
if [[ -e "$POLYGLOT_ROOT/.tasks/task-util.bash" ]]; then
    source "$POLYGLOT_ROOT/.tasks/task-util.bash"
fi

function print-help () {
    # test args, if the last one is -h or --help
    # print help and exit
    case "${@: -1}" in
        -h|--help) ;;
    #     *) if [[ "$#" -gt 0 ]]; then
    #            return
    #        fi
    #        ;;
        *) return ;;
    esac
    echo -e "
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
    exit "${PRINTED_HELP:-2}"
}

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

print-help "$@"
check-environment
