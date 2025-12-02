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

tdot "validating octave"
pushd "$POLYGLOT_SRC/_utilities/oct" || fail "Failed to go to octave dir"
octave -qf "main.m" || fail "Failed octave"
popd || fail "Failed to return from octave dir"
