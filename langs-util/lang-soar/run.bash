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

DEFAULT_FILE="main.soar"
shift
target="$1"
file="${2:-$DEFAULT_FILE}"
shift 2
soar -s "$POLYGLOT_SRC/$target/$file" "${@:-}"
