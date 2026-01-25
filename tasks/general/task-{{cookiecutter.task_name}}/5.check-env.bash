#!/usr/bin/env bash
# 5.check-env.bash -*- mode: sh -*-
#set -o errexit
set -o nounset
set -o pipefail

# shellcheck disable=SC1091
source "$POLY_SRC/lib/lib-util.bash"
# shellcheck disable=SC1091
[[ -e "$POLYGLOT_ROOT/.tasks/task-util.bash" ]] && source "$POLYGLOT_ROOT/.tasks/task-util.bash"

tdot "{{cookiecutter.task_name}}" "Checking Environment"
fail "TODO"
has_failed=()

# [[ -n "${BIBLIO_LIB:-}" ]] || has_failed+=("BIBLIO_LIB")


if [[ "${#has_failed[@]}" -gt 0 ]]; then
    tdot "release" "Missing Env vars:"
    for val in "${has_failed[@]}"
    do
        echo "- $val"
    done
    fail "Environment Is Not Correct"
fi
