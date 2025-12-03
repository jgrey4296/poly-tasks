#!/usr/bin/env bash
# 10.validate.bash -*- mode: sh -*-
#set -o errexit
set -o nounset
set -o pipefail

# shellcheck disable=SC1091
source "$POLY_SRC/lib/lib-util.bash"
if [[ -e "$POLYGLOT_ROOT/.tasks/task-util.bash" ]]; then
    source "$POLYGLOT_ROOT/.tasks/task-util.bash"
fi

subhead "Validating Main Languages"

polyglot lang python validate "$@"
polyglot lang rust validate "$@"
polyglot lang dotnet validate "$@"
polyglot lang elixir validate "$@"
polyglot lang kotlin validate "$@"
polyglot lang godot validate "$@"
polyglot land lisp validate "$@"
