#!/usr/bin/env bash
set -euo pipefail

# shellcheck disable=SC1091
source "$POLY_SRC/lib/lib-util.bash"
if [[ -e "$POLYGLOT_ROOT/.tasks/task-util.bash" ]]; then
    # shellcheck disable=SC1091
    source "$POLYGLOT_ROOT/.tasks/task-util.bash"
fi

subhead "Calculating Version Number"
CURR_VERSION=$(version version)
version "$LEVEL" "set" "+"
version file update-all
NEW_VERSION=$(version version)
subhead "Project Version $CURR_VERSION -> $NEW_VERSION"
