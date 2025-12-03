#!/usr/bin/env bash
# build.bash -*- mode: sh -*-
#set -o errexit
set -o nounset
set -o pipefail


# shellcheck disable=SC1091
source "$POLY_SRC/lib/lib-util.bash"
if [[ -e "$POLYGLOT_ROOT/.tasks/task-util.bash" ]]; then
    source "$POLYGLOT_ROOT/.tasks/task-util.bash"
fi

tdot "[rocq]" "build"
mkdir "$POLYGLOT_TEMP/rocq"

shift
rocq compile -o "$POLYGLOT_TEMP/rocq/main.vo" "$1/main.v"
