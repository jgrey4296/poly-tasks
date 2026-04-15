#!/usr/bin/env bash
#set -o errexit
set -o nounset
set -o pipefail

# shellcheck disable=SC1091
[[ -e "$POLY_SRC/lib/lib.bash" ]] && source "$POLY_SRC/lib/lib.bash"
# shellcheck disable=SC1091
[[ -e "$(poly-dir)/task-util.bash" ]] && source "$(poly-dir)/task-util.bash"

shift
DEFAULT_FILE="main.clips"
target="_ai_and_logic/clips"
file="${1:-$DEFAULT_FILE}"
shift 1

tdot "clips" "Running: $target/$file"
clips -f "$POLYGLOT_SRC/$target/$file" "${@:-}"
