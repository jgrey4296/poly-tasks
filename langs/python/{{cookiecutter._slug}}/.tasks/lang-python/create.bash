#!/usr/bin/env bash
# create.bash -*- mode: sh -*-
#set -o errexit
set -o nounset
set -o pipefail

# shellcheck disable=SC1091
source "$POLY_SRC/lib/lib-util.bash"
# shellcheck disable=SC1091
[[ -e "$POLYGLOT_ROOT/.tasks/task-util.bash" ]] && source "$POLYGLOT_ROOT/.tasks/task-util.bash"

# handle py lib/exe/bridge
PGLANG="python"
TARGET="$POLYGLOT_SRC/py_lib"

tdot "$PGLANG" "creating a workspace member in $TARGET"

[[ -d "$TARGET" ]] && exit 0

dname=$(dirname "${BASH_SOURCE[0]}")
cp -r "$dname/_base" "$TARGET"

# TODO update pyproject.toml
