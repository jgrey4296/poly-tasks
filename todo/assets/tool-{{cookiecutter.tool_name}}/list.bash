#!/usr/bin/env bash
# list.bash -*- mode: sh -*-
#set -o errexit
set -o nounset
set -o pipefail

# shellcheck disable=SC1091
source "$POLY_SRC/lib/lib-util.bash"
if [[ -e "$POLYGLOT_ROOT/.tasks/task-util.bash" ]]; then
   # shellcheck disable=SC1091
    source "$POLYGLOT_ROOT/.tasks/task-util.bash"
fi

subhead "[list]" "Asset Collections:"

result=$(fdfind --hidden "\.assets")

for val in $result
do
    echo "- " $(dirname "$val")
done
