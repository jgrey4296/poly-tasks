#!/usr/bin/env bash
# create.bash -*- mode: sh -*-
#set -o errexit
set -o nounset
set -o pipefail

# shellcheck disable=SC1091
[[ -e "$POLY_SRC/lib/lib.bash" ]] && source "$POLY_SRC/lib/lib.bash"
# shellcheck disable=SC1091
[[ -e "$(poly-dir)/task-util.bash" ]] && source "$(poly-dir)/task-util.bash"

PGLANG="prolog"
TARGET="$POLYGLOT_SRC/_ai_and_logic/pl"

tdot "$PGLANG" "creating a workspace member in $TARGET"

if [[ -d "$TARGET" ]]; then
    exit 0
fi

dname=$(dirname "${BASH_SOURCE[0]}")
cp -r "$dname/_base" "$TARGET"
