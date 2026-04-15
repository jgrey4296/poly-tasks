#!/usr/bin/env bash
# 10.validate.bash -*- mode: sh -*-
#set -o errexit
set -o nounset
set -o pipefail

# shellcheck disable=SC1091
[[ -e "$POLY_SRC/lib/lib.bash" ]] && source "$POLY_SRC/lib/lib.bash"
# shellcheck disable=SC1091
[[ -e "$(poly-dir)/task-util.bash" ]] && source "$(poly-dir)/task-util.bash"

subhead "Validating Languages"

for key in "$POLYGLOT_ROOT/.tasks/lang-"*
do
    polyglot check lang "${key/*lang-/}" validate || continue
    polyglot lang "${key/*lang-/}" validate "$@"
done
