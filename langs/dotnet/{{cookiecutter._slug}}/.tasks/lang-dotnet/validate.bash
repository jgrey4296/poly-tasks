#!/usr/bin/env bash
# validate.bash -*- mode: sh -*-
#set -o errexit
set -o nounset
set -o pipefail

# shellcheck disable=SC1091
source "$POLY_SRC/lib/lib-util.bash"
# shellcheck disable=SC1091
[[ -e "$POLYGLOT_ROOT/.tasks/task-util.bash" ]] && source "$POLYGLOT_ROOT/.tasks/task-util.bash"

tdot "dotnet" "Validating"
[[ -e "$POLYGLOT_ROOT/blah.sln" ]] && rm "$POLYGLOT_ROOT/blah.sln"

dotnet new sln                 || fail "Dotnet new sln Failed"
dotnet solution add src/cs_exe || fail "Dotnet add cs_exe Failed"
dotnet solution add src/cs_lib || fail "Dotnet add cs_lib Failed"
dotnet solution add src/fs_exe || fail "Dotnet add fs_exe Failed"
dotnet build                   || fail "Dotnet build Failed"

tdot "dotnet" "TODO validate docfx"
