#!/usr/bin/env bash
# 5.check-env.bash -*- mode: sh -*-
#set -o errexit
set -o nounset
set -o pipefail

# shellcheck disable=SC1091
[[ -e "$POLY_SRC/lib/lib.bash" ]] && source "$POLY_SRC/lib/lib.bash"
# shellcheck disable=SC1091
[[ -e "$(poly-dir)/task-util.bash" ]] && source "$(poly-dir)/task-util.bash"

tdot "release" "Checking Environment"
has_failed=()

# [[ -n "${BIBLIO_LIB:-}" ]] || has_failed+=("BIBLIO_LIB")

print-env-failures "${has_failed[@]}"
