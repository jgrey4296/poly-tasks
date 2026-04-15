#!/usr/bin/env bash
set -euo pipefail

# shellcheck disable=SC1091
[[ -e "$POLY_SRC/lib/lib.bash" ]] && source "$POLY_SRC/lib/lib.bash"
# shellcheck disable=SC1091
[[ -e "$(poly-dir)/task-util.bash" ]] && source "$(poly-dir)/task-util.bash"

# TODO: have a file of backup targets?
header "biblio --backup"

source="${1:-$BIBLIO_LIB}"
target="${2:-$BIBLIO_BKUP}"

subhead "Source: $source"
echo "->"
subhead "Target: $target"

if [[ -z "$source" ]] || [[ -z "$target" ]]; then
    exit 1
fi

rsync --archive --progress "$source" "$target"

# TODO sync to media
