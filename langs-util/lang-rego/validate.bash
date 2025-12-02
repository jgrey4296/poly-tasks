#!/usr/bin/env bash
# validate.bash -*- mode: sh -*-
#set -o errexit
set -o nounset
set -o pipefail

# shellcheck disable=SC1091
source "$POLY_SRC/lib/lib-util.bash"
if [[ -e "$POLYGLOT_ROOT/.tasks/task-util.bash" ]]; then
    source "$POLYGLOT_ROOT/.tasks/task-util.bash"
fi

subhead "Validating rego"
opa eval \
    -d "$POLYGLOT_SRC/_utilities/rego/main.rego" \
    "data.example.pi" \
    | jq .result[0].expression[0].value \
    || fail "OPA failed"
