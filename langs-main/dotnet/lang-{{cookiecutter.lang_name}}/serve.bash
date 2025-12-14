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

tdot "[dotnet]" "Serving"
if [[ -e "$POLYGLOT_ROOT/blah.sln" ]]; then
    rm "$POLYGLOT_ROOT/blah.sln"
fi

dotnet build-server || fail "Dotnet Failed"
