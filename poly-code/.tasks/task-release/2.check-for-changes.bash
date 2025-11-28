#!/usr/bin/env bash
set -euo pipefail

# shellcheck disable=SC1091
source "$POLY_SRC/lib/lib-util.bash"
if [[ -e "$POLYGLOT_ROOT/.tasks/task-util.bash" ]]; then
    # shellcheck disable=SC1091
    source "$POLYGLOT_ROOT/.tasks/task-util.bash"
fi

if [[ -n "$TOWNCRIER_CHANGE_DIR" ]]; then
    [[ -n $(fdfind . "$TOWNCRIER_CHANGE_DIR") ]] || fail "There are no fragment changes. Add descriptions of this release."
else
    towncrier check || fail "There are no fragment changes. Add descriptions of this release."
fi
