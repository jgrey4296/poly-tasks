#!/usr/bin/env bash
# export.bash -*- mode: sh -*-
#set -o errexit
set -o nounset
set -o pipefail

# shellcheck disable=SC1091
source "$POLY_SRC/lib/lib-util.bash"
if [[ -e "$POLYGLOT_ROOT/.tasks/task-util.bash" ]]; then
    source "$POLYGLOT_ROOT/.tasks/task-util.bash"
fi


tdot "asdf" "Exporting"
asdf plugin list --urls > "$POLYGLOT_ROOT/.asdf.plugins"
