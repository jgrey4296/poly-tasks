#!/usr/bin/env bash
set -euo pipefail

source "$POLY_SRC/lib/lib-util.bash"

source="${1:-$BIBLIO_LIB}"
target="${2:-$BIBLIO_BKUP}"

tdot "[backup]" "rsync:"
tdot "[backup]" "Source: $source"
tdot "[backup]" "Target: $target"
rsync --archive --progress "$source" "$target"
