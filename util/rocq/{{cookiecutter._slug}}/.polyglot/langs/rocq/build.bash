#!/usr/bin/env bash
# build.bash -*- mode: sh -*-
#set -o errexit
set -o nounset
set -o pipefail

# shellcheck disable=SC1091
[[ -e "$POLY_SRC/lib/lib.bash" ]] && source "$POLY_SRC/lib/lib.bash"
# shellcheck disable=SC1091
[[ -e "$(poly-dir)/task-util.bash" ]] && source "$(poly-dir)/task-util.bash"

tdot "rocq" "build"
mkdir "$POLYGLOT_TEMP/rocq"

shift
rocq compile -o "$POLYGLOT_TEMP/rocq/main.vo" "$1/main.v"
