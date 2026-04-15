#!/usr/bin/env bash
set -euo pipefail

# shellcheck disable=SC1091
[[ -e "$POLY_SRC/lib/lib.bash" ]] && source "$POLY_SRC/lib/lib.bash"
# shellcheck disable=SC1091
[[ -e "$(poly-dir)/task-util.bash" ]] && source "$(poly-dir)/task-util.bash"

tdot "release" "Checking Git status"

[[ -z $(git --no-pager diff) ]] || fail "There are unstaged changes."
