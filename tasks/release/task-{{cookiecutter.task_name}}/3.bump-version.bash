#!/usr/bin/env bash
set -euo pipefail

# shellcheck disable=SC1091
source "$POLY_SRC/lib/lib-util.bash"
# shellcheck disable=SC1091
[[ -e "$POLYGLOT_ROOT/.tasks/task-util.bash" ]] && source "$POLYGLOT_ROOT/.tasks/task-util.bash"

tdot "release" "Calculating Version Number"
CURR_VERSION=$(version version)
tdot "release" "Current version: $CURR_VERSION"

read -p "Choose Bump Level (major, minor, patch): " LEVEL
case "$LEVEL" in
    major|minor|patch) ;;
    *)
        fail "Unknown bump level: $LEVEL"
    ;;
esac


tdot "release" "Bumping Version Number"
version "$LEVEL" "set" "+"
version file update-all
NEW_VERSION=$(version version)
tdot "release" "Project Version $CURR_VERSION -> $NEW_VERSION"
