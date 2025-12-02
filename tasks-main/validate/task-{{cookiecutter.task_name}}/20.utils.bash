#!/usr/bin/env bash
# 20.docs.bash -*- mode: sh -*-
#set -o errexit
set -o nounset
set -o pipefail

# shellcheck disable=SC1091
source "$POLY_SRC/lib/lib-util.bash"
if [[ -e "$POLYGLOT_ROOT/.tasks/task-util.bash" ]]; then
    source "$POLYGLOT_ROOT/.tasks/task-util.bash"
fi

polyglot lang clingo validate "$@"
polyglot lang csound validate "$@"
polyglot lang octave validate "$@"
polyglot lang rego validate "$@"
polyglot lang prolog validate "$@"
polyglot lang soar validate "$@"
polyglot lang z3 validate "$@"
polyglot lang sclang validate "$@"
