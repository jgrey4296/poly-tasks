#!/usr/bin/env bash
#set -o errexit
set -o nounset
set -o pipefail

# shellcheck disable=SC1091
source "$POLY_SRC/lib/lib-util.bash"
if [[ -e "$POLYGLOT_ROOT/.tasks/task-util.bash" ]]; then
    # shellcheck disable=SC1091
    source "$POLYGLOT_ROOT/.tasks/task-util.bash"
fi

shift
DEFAULT_FILE="main.clips"
target="_ai_and_logic/clips"
file="${1:-$DEFAULT_FILE}"
shift 1

tdot "clips" "Running: $target/$file"
clips -f "$POLYGLOT_SRC/$target/$file" "${@:-}"
