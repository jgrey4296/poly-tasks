#!/usr/bin/env bash
set -euo pipefail

# shellcheck disable=SC1091
[[ -e "$POLY_SRC/lib/lib.bash" ]] && source "$POLY_SRC/lib/lib.bash"
# shellcheck disable=SC1091
[[ -e "$(poly-dir)/task-util.bash" ]] && source "$(poly-dir)/task-util.bash"

source="${1:-$BIBLIO_LIB}"
target="${2:-$BIBLIO_BKUP}"

tdot "backup" "rsync:"
tdot "backup" "Source: $source"
tdot "backup" "Target: $target"
rsync --archive --progress "$source" "$target"
