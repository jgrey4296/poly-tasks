#!/usr/bin/env bash
# 30.tools.bash -*- mode: sh -*-
#set -o errexit
set -o nounset
set -o pipefail

# shellcheck disable=SC1091
[[ -e "$POLY_SRC/lib/lib.bash" ]] && source "$POLY_SRC/lib/lib.bash"
# shellcheck disable=SC1091
[[ -e "$(poly-dir)/task-util.bash" ]] && source "$(poly-dir)/task-util.bash"

subhead "Validating Tools"

for key in "$POLYGLOT_ROOT/.tasks/tool-"*
do
    polyglot check tool "${key/*tool-/}" validate || continue
    polyglot tool "${key/*tool-/}" validate "$@"
done
