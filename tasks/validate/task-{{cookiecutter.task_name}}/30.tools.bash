#!/usr/bin/env bash
# 30.tools.bash -*- mode: sh -*-
#set -o errexit
set -o nounset
set -o pipefail

# shellcheck disable=SC1091
source "$POLY_SRC/lib/lib-util.bash"
if [[ -e "$POLYGLOT_ROOT/.tasks/task-util.bash" ]]; then
    source "$POLYGLOT_ROOT/.tasks/task-util.bash"
fi

subhead "Validating Tools"

for key in "$POLYGLOT_ROOT/.tasks/tool-"*
do
    polyglot check tool "${key/tool-//}" validate || continue
    polyglot tool "${key/tool-//}" validate "$@"
done
