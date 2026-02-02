#!/usr/bin/env bash
# gen-zip.bash -*- mode: sh -*-
#set -o errexit
set -o nounset
set -o pipefail

# shellcheck disable=SC1091
source "$POLY_SRC/lib/lib-util.bash"
# shellcheck disable=SC1091
[[ -e "$POLYGLOT_ROOT/.tasks/task-util.bash" ]] && source "$POLYGLOT_ROOT/.tasks/task-util.bash"

HELP_TEXT="
usage: polyglot tool assets pack [-h] [args ...]

positional arguments:
args          :

options:
-h, --help    : show this help message and exit

"

print-help "$HELP_TEXT" 0 "$@"
shift
target="$1"
shift
mkdir -p "$POLYGLOT_ROOT/.temp"
name=$(basename "$target")
tdot "pack" "packing $target into zip file: .temp/$name.zip"
zip -r "$POLYGLOT_ROOT/.temp/$name.zip" "$POLYGLOT_ROOT/$target"
tdot "pack" "Complete."
