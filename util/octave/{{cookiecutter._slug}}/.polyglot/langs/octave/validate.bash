#!/usr/bin/env bash
# validate.bash -*- mode: sh -*-
#set -o errexit
set -o nounset
set -o pipefail

# shellcheck disable=SC1091
[[ -e "$POLY_SRC/lib/lib.bash" ]] && source "$POLY_SRC/lib/lib.bash"
# shellcheck disable=SC1091
[[ -e "$(poly-dir)/task-util.bash" ]] && source "$(poly-dir)/task-util.bash"

tdot "octave" "validating octave"
pushd "$POLYGLOT_SRC/_utilities/oct" || fail "Failed to go to octave dir"
octave -qf "main.m" || fail "Failed octave"
popd || fail "Failed to return from octave dir"
