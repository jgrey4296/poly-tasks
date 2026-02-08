#!/usr/bin/env bash
set -euo pipefail

# shellcheck disable=SC1091
source "$POLY_SRC/lib/lib-util.bash"
# shellcheck disable=SC1091
[[ -e "$POLYGLOT_ROOT/.tasks/task-util.bash" ]] && source "$POLYGLOT_ROOT/.tasks/task-util.bash"

tdot "release" "Calculating Version Number"
CURR_VERSION=$(version version)
tdot "release" "Current version: $CURR_VERSION"

LEVEL=""
while [[ $# -gt 0 ]]; do
    case $1 in
        --major) LEVEL="major" ;;
        --minor) LEVEL="minor" ;;
        --patch) LEVEL="patch" ;;
        *) ;;
    esac
    shift
done

[[ -n "$LEVEL" ]] || read -p "Choose Bump Level (major, minor, patch): " LEVEL
case "$LEVEL" in
    major|minor)
        version "$LEVEL" set +
        version "$LEVEL" reset
        ;;
    patch)
        version "$LEVEL" set +
        ;;
    *)
        fail "Unknown bump level: $LEVEL"
    ;;
esac


NEW_VERSION=$(version version)
if ( git --no-pager describe --tag "$NEW_VERSION" ); then
    git restore *
    fail "Tag $NEW_VERSION already exists"
else
    version file update-all
    tdot "release" "Project Version $CURR_VERSION -> $NEW_VERSION"
fi
