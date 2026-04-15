#!/usr/bin/env bash
#  polyglot-manage -*- mode: sh -*-
#set -o errexit
set -o nounset
set -o pipefail

# shellcheck disable=SC1091
[[ -e "$POLY_SRC/lib/lib.bash" ]] && source "$POLY_SRC/lib/lib.bash"
# shellcheck disable=SC1091
[[ -e "$(poly-dir)/task-util.bash" ]] && source "$(poly-dir)/task-util.bash"

current_script_path="${BASH_SOURCE[0]}"
toml_template=$(realpath "$(dirname "$current_script_path")")/polyglot.template

function pg_manage_locate () {
    echo "TODO: look up to find a polyglot.toml file"

}
