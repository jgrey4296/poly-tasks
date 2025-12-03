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

tdot "[rego]" "Validating"
pushd "$POLYGLOT_SRC/_utilities/rego" || fail "Failed to go to rego dir"
opa eval \
    -d "main.rego" \
    "data.example.pi" \
    | jq .result[0].expression[0].value \
    || fail "OPA failed"
popd || fail "Failed to return from rego dir"
