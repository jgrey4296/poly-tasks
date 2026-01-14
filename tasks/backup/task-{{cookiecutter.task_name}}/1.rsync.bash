#!/usr/bin/env bash
set -euo pipefail

# shellcheck disable=SC1091
source "$POLY_SRC/lib/lib-util.bash"
# shellcheck disable=SC1091
[[ -e "$POLYGLOT_ROOT/.tasks/task-util.bash" ]] && source "$POLYGLOT_ROOT/.tasks/task-util.bash"

source="${1:-$BIBLIO_LIB}"
target="${2:-$BIBLIO_BKUP}"

tdot "backup" "rsync:"
tdot "backup" "Source: $source"
tdot "backup" "Target: $target"
rsync --archive --progress "$source" "$target"
