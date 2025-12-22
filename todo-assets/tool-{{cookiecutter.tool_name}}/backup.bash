#!/usr/bin/env bash
# backup.bash -*- mode: sh -*-
#set -o errexit
set -o nounset
set -o pipefail

# shellcheck disable=SC1091
source "$POLY_SRC/lib/lib-util.bash"
if [[ -e "$POLYGLOT_ROOT/.tasks/task-util.bash" ]]; then
   # shellcheck disable=SC1091
    source "$POLYGLOT_ROOT/.tasks/task-util.bash"
fi

function print-help () {
    # test args, if the last one is -h or --help
    # print help and exit
    case "${@: -1}" in
        -h|--help) ;;
        *) if [[ "$#" -gt 0 ]]; then
               return
           fi
           ;;
    esac
    echo -e "
usage: polyglot tool assets backup [-h] [args ...]

positional arguments:
args          :

options:
-h, --help    : show this help message and exit


"
    exit "${PRINTED_HELP:-2}"
}


[[ -z "${POLYGLOT_BACKUP_TARGET:-}" ]] || fail "No POLYGLOT_BACKUP_TARGET set"

tdot "[assets]" "TODO: backup assets"
rsync --archive --progress "$POLYGLOT_ROOT" "$POLYGLOT_BACKUP_TARGET"


tdot "[assets]" "TODO: test zips/gzips
# zip --test ?
# gzip --test ?

