#!/usr/bin/env bash
# list.bash -*- mode: sh -*-
#set -o errexit
set -o nounset
set -o pipefail

# shellcheck disable=SC1091
source "$POLY_SRC/lib/lib-util.bash"
# shellcheck disable=SC1091
[[ -e "$POLYGLOT_ROOT/.tasks/task-util.bash" ]] && source "$POLYGLOT_ROOT/.tasks/task-util.bash"

subhead "[list]" "Asset Collections:"

result=$(fdfind --hidden "\.assets")

for val in $result
do
    echo "- " $(dirname "$val")
done
