#!/usr/bin/env bash
# init.bash -*- mode: sh -*-
#set -o errexit
set -o nounset
set -o pipefail

# shellcheck disable=SC1091
[[ -e "$POLY_SRC/lib/lib.bash" ]] && source "$POLY_SRC/lib/lib.bash"
# shellcheck disable=SC1091
[[ -e "$(poly-dir)/task-util.bash" ]] && source "$(poly-dir)/task-util.bash"

function check () {
    [[ -n "${DOTNET_ROOT:-}" ]] || fail "No DOTNET_ROOT defined"
    [[ -x dotnet  ]]            || fail "dotnet is not executable"
}

tdot "dotnet" "initialising"
check
tdot "dotnet" "TODO: dotnet sdks/runtimes"

dotnet new sln --force
fdfind ".(cs|fs)proj" "$POLYGLOT_ROOT" --threads=1 --exec dotnet sln add

tdot "dotnet" "installing docfx"
dotnet tool update -g docfx
