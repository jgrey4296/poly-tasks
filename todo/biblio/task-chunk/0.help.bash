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
usage: polyglot task chunk [args ...] [-h]

Chunk larger bibtex files into smaller ones.

positional arguments:
args          :

options:
-h, --help    : show this help message and exit
--size {int}  :
--collect     :
--failures    :

"
    exit "${PRINTED_HELP:-2}"
}

function check-environment () {
    subhead "Checking Environment"
    has_failed=0

    if [[ "$has_failed" -gt 0 ]]; then
        fail "Missing EnvVars"
    fi
}

print-help "$@"
check-environment
