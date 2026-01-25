#!/usr/bin/env bash
#set -o errexit
set -o nounset
set -o pipefail

# shellcheck disable=SC1091
source "$POLY_SRC/lib/lib-util.bash"
# shellcheck disable=SC1091
[[ -e "$POLYGLOT_ROOT/.tasks/task-util.bash" ]] && source "$POLYGLOT_ROOT/.tasks/task-util.bash"

NEW_VERSION=$(version version)
tdot "release" "Committing as release: $NEW_VERSION"
git add --all
pre-commit run || fail "Pre-commit failed"
git commit -m "[Release]: ${NEW_VERSION}" || fail "Failed to commit"

tdot "release" "Tagging release: $NEW_VERSION"
git tag "${NEW_VERSION}"

tdot "release" "Finished"
