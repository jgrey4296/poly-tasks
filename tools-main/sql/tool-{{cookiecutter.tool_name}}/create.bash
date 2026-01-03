#!/usr/bin/env bash
# create.bash -*- mode: sh -*-
#set -o errexit
set -o nounset
set -o pipefail

# shellcheck disable=SC1091
source "$POLY_SRC/lib/lib-util.bash"
if [[ -e "$POLYGLOT_ROOT/.tasks/task-util.bash" ]]; then
   # shellcheck disable=SC1091
    source "$POLYGLOT_ROOT/.tasks/task-util.bash"
fi

PGLANG="sql"
TARGET="$POLYGLOT_SRC/_utilties/sql"

tdot "$PGLANG" "creating a workspace member in $TARGET"

if [[ -d "$TARGET" ]]; then
    exit 0
fi

dname=$(dirname "${BASH_SOURCE[0]}")
cp -r "$dname/_base" "$TARGET"

