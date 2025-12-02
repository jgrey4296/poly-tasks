#!/usr/bin/env bash
set -euo pipefail

source "$POLY_SRC/lib/lib-util.bash"

header "rsync"

source="${1:-$BIBLIO_LIB}"
target="${2:-$BIBLIO_BKUP}"

subhead "Source: $source"
echo "->"
subhead "Target: $target"
rsync --archive --progress "$source" "$target"
