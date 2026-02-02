#!/usr/bin/env bash
set -euo pipefail

# shellcheck disable=SC1091
source "$POLY_SRC/lib/lib-util.bash"
# shellcheck disable=SC1091
[[ -e "$POLYGLOT_ROOT/.tasks/task-util.bash" ]] && source "$POLYGLOT_ROOT/.tasks/task-util.bash"

# TODO: have a file of backup targets?
tdot "biblio" "backup [aisb]"

source="${1:-$BIBLIO_LIB}/../aisb"
target="${2:-$BIBLIO_BKUP}"

subhead "Source: $source"
echo "->"
subhead "Target: $target"

if [[ -z "$source" ]] || [[ -z "$target" ]]; then
    exit 1
fi

rsync --archive --progress "$source" "$target"

# TODO sync to media
