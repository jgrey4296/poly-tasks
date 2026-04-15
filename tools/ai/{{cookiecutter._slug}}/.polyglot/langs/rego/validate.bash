#!/usr/bin/env bash
# validate.bash -*- mode: sh -*-
#set -o errexit
set -o nounset
set -o pipefail

# shellcheck disable=SC1091
[[ -e "$POLY_SRC/lib/lib.bash" ]] && source "$POLY_SRC/lib/lib.bash"
# shellcheck disable=SC1091
[[ -e "$(poly-dir)/task-util.bash" ]] && source "$(poly-dir)/task-util.bash"

tdot "rego" "Validating"
pushd "$POLYGLOT_SRC/_ai_and_logic/rego" || fail "Failed to go to rego dir"
(
    opa eval \
        -d "main.rego" \
        "data.example.pi" \
        | jq .result[0].expression[0].value
) || fail "OPA failed"

popd || fail "Failed to return from rego dir"
