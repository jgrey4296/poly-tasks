#!/usr/bin/env bash
# build.bash -*- mode: sh -*-
#set -o errexit
set -o nounset
set -o pipefail

# shellcheck disable=SC1091
[[ -e "$POLY_SRC/lib/lib.bash" ]] && source "$POLY_SRC/lib/lib.bash"
# shellcheck disable=SC1091
[[ -e "$(poly-dir)/task-util.bash" ]] && source "$(poly-dir)/task-util.bash"

shift
tdot "diagrams" "Compiling"
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
