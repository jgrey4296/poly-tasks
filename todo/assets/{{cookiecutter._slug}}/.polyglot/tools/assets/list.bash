#!/usr/bin/env bash
# list.bash -*- mode: sh -*-
#set -o errexit
set -o nounset
set -o pipefail

# shellcheck disable=SC1091
[[ -e "$POLY_SRC/lib/lib.bash" ]] && source "$POLY_SRC/lib/lib.bash"
# shellcheck disable=SC1091
[[ -e "$(poly-dir)/task-util.bash" ]] && source "$(poly-dir)/task-util.bash"

subhead "[list]" "Asset Collections:"

result=$(fdfind --hidden "\.assets")

for val in $result
do
    echo "- " $(dirname "$val")
done
