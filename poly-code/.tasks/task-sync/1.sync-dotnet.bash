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

subhead "Syncing Dotnet"
# must be run sequentially
fdfind ".(cs|fs)proj" "$POLYGLOT_ROOT" --threads=1 --exec dotnet sln add
