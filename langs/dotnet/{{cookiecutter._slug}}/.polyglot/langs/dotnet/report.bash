#!/usr/bin/env bash
# report.bash -*- mode: sh -*-
#set -o errexit
set -o nounset
set -o pipefail

# shellcheck disable=SC1091
[[ -e "$POLY_SRC/lib/lib.bash" ]] && source "$POLY_SRC/lib/lib.bash"
# shellcheck disable=SC1091
[[ -e "$(poly-dir)/task-util.bash" ]] && source "$(poly-dir)/task-util.bash"

tdot "dotnet" "reporting"
touch "$POLYGLOT_TEMP/report/dotnet"
dotnet --info > "$POLYGLOT_TEMP/report/dotnet"
