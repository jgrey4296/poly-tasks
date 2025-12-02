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

shift
case "$1" in
    -a|--all)
        fail "TODO"
        ;;
    *)
        dot \
            -T svg \
            -o "$POLYGLOT_SRC/_data/images/$1.svg" \
            "$POLYGLOT_SRC/_utilities/statemachines/dots/$1.dot"
        ;;
esac
