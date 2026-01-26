#!/usr/bin/env bash
# 5.check-env.bash -*- mode: sh -*-
#set -o errexit
set -o nounset
set -o pipefail

# shellcheck disable=SC1091
source "$POLY_SRC/lib/lib-util.bash"
# shellcheck disable=SC1091
[[ -e "$POLYGLOT_ROOT/.tasks/task-util.bash" ]] && source "$POLYGLOT_ROOT/.tasks/task-util.bash"

tdot "release" "Checking Environment"
has_failed=()

# [[ -n "${POLYGLOT_TEMP:-}" ]] || has_failed+=("POLYGLOT_TEMP")
# [[ -n "${BIBLIO_TEMPLATE_DIR:-}" ]] || has_failed+=("BIBLIO_TEMPLATE_DIR")

print-env-failures "${has_failed[@]}"
