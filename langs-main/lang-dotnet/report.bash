#!/usr/bin/env bash
# report.bash -*- mode: sh -*-
#set -o errexit
set -o nounset
set -o pipefail

# shellcheck disable=SC1091
source "$POLY_SRC/lib/lib-util.bash"
if [[ -e "$POLYGLOT_ROOT/.tasks/task-util.bash" ]]; then
    source "$POLYGLOT_ROOT/.tasks/task-util.bash"
fi

tdot "reporting on dotnet"
touch "$POLYGLOT_TEMP/report/dotnet"
dotnet --info > "$POLYGLOT_TEMP/report/dotnet"
