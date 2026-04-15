#!/usr/bin/env bash
set -euo pipefail

# shellcheck disable=SC1091
[[ -e "$POLY_SRC/lib/lib.bash" ]] && source "$POLY_SRC/lib/lib.bash"
# shellcheck disable=SC1091
[[ -e "$(poly-dir)/task-util.bash" ]] && source "$(poly-dir)/task-util.bash"

tdot "release" "Checking for queued change fragments"

if [[ -n "$TOWNCRIER_CHANGE_DIR" ]]; then
    [[ -n $(fdfind . "$TOWNCRIER_CHANGE_DIR") ]] || fail "There are no fragment changes. Add descriptions of this release."
else
    towncrier check || fail "There are no fragment changes. Add descriptions of this release."
fi
