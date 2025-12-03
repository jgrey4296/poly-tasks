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
usage: polyglot task {{cookiecutter.task_name}} [args ...] [-h]

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
    exit "${PRINTED_HELP:-2}"
}

function check-environment () {
    tdot "[imgen]" "Checking Environment"
    if [[ -z "${POLYGLOT_TEMP:-}" ]]; then
        has_failed=1
        fail "No POLYGLOT_TEMP has been defined"
    fi
}

print-help "$@"
check-environment
