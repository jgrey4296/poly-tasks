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

tdot "[dotnet]" "Validating"
if [[ -e "$POLYGLOT_ROOT/blah.sln" ]]; then
    rm "$POLYGLOT_ROOT/blah.sln"
fi

dotnet new sln                 || fail "Dotnet Failed"
dotnet solution add src/cs_exe || fail "Dotnet Failed"
dotnet solution add src/cs_lib || fail "Dotnet Failed"
dotnet solution add src/fs_exe || fail "Dotnet Failed"
dotnet build                   || fail "Dotnet Failed"

tdot "[dotnet]" "TODO validate docfx"
