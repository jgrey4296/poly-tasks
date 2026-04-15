#!/usr/bin/env bash
# create.bash -*- mode: sh -*-
#set -o errexit
set -o nounset
set -o pipefail

# shellcheck disable=SC1091
[[ -e "$POLY_SRC/lib/lib.bash" ]] && source "$POLY_SRC/lib/lib.bash"
# shellcheck disable=SC1091
[[ -e "$(poly-dir)/task-util.bash" ]] && source "$(poly-dir)/task-util.bash"

# TODO: handle exe, lib, macros
PGLANG="rust"
TARGET="$POLYGLOT_SRC/rs_lib"

tdot "$PGLANG" "creating a workspace member in $TARGET"

[[ -d "$TARGET" ]] && exit 0

dname=$(dirname "${BASH_SOURCE[0]}")
cp -r "$dname/_base" "$TARGET"

# TODO: update cargo
