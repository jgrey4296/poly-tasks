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

tdot "[godot]" "Validating"
godot \
    --headless \
    --script src/gd/scripts/cli_access.gd \
    || fail "Godot Failed"
