#!/usr/bin/env bash
# 10.validate.bash -*- mode: sh -*-
#set -o errexit
set -o nounset
set -o pipefail

# shellcheck disable=SC1091
source "$POLY_SRC/lib/lib-util.bash"
# shellcheck disable=SC1091
[[ -e "$POLYGLOT_ROOT/.tasks/task-util.bash" ]] && source "$POLYGLOT_ROOT/.tasks/task-util.bash"

subhead "Validating Languages"

for key in "$POLYGLOT_ROOT/.tasks/lang-"*
do
    polyglot check lang "${key/*lang-/}" validate || continue
    polyglot lang "${key/*lang-/}" validate "$@"
done
