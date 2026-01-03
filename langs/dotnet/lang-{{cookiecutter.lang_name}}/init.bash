#!/usr/bin/env bash
# init.bash -*- mode: sh -*-
#set -o errexit
set -o nounset
set -o pipefail


# shellcheck disable=SC1091
source "$POLY_SRC/lib/lib-util.bash"
if [[ -e "$POLYGLOT_ROOT/.tasks/task-util.bash" ]]; then
    source "$POLYGLOT_ROOT/.tasks/task-util.bash"
fi

function check () {
    if [[ -z "$DOTNET_ROOT" ]]; then
        fail "No DOTNET_ROOT defined"
    fi
}

tdot "dotnet" "initialising"
check
tdot "dotnet" "TODO: dotnet sdks/runtimes"

dotnet new sln --force
fdfind ".(cs|fs)proj" "$POLYGLOT_ROOT" --threads=1 --exec dotnet sln add

tdot "dotnet" "installing docfx"
dotnet tool update -g docfx
