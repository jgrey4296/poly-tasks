#!/usr/bin/env bash
# export.bash -*- mode: sh -*-
#set -o errexit
set -o nounset
set -o pipefail

# shellcheck disable=SC1091
source "$POLY_SRC/lib/lib-util.bash"
# shellcheck disable=SC1091
[[ -e "$POLYGLOT_ROOT/.tasks/task-util.bash" ]] && source "$POLYGLOT_ROOT/.tasks/task-util.bash"

tdot "asdf" "Exporting"
asdf plugin list --urls | sed -E 'N; s/\n//; s/\t//' > "$POLYGLOT_ROOT/.asdf.plugins"
