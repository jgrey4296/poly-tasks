#!/usr/bin/env bash
# backup.bash -*- mode: sh -*-
#set -o errexit
set -o nounset
set -o pipefail

# shellcheck disable=SC1091
[[ -e "$POLY_SRC/lib/lib.bash" ]] && source "$POLY_SRC/lib/lib.bash"
# shellcheck disable=SC1091
[[ -e "$(poly-dir)/task-util.bash" ]] && source "$(poly-dir)/task-util.bash"

PRINTED_HELP="${PRINTED_HELP:-2}"
HELP_TEXT="
usage: polyglot tool assets backup [-h] [args ...]

positional arguments:
args          :

options:
-h, --help    : show this help message and exit

"

maybe-print-help "leaf" 0 "$HELP_TEXT" "$@"

[[ -z "${POLYGLOT_BACKUP_TARGET:-}" ]] || fail "No POLYGLOT_BACKUP_TARGET set"

tdot "assets" "TODO: backup assets"
rsync --archive --progress "$POLYGLOT_ROOT" "$POLYGLOT_BACKUP_TARGET"

tdot "assets" "TODO: test zips/gzips"
# zip --test ?
# gzip --test ?

