#!/usr/bin/env bash
#  polyglot-manage -*- mode: sh -*-
#set -o errexit
set -o nounset
set -o pipefail

# shellcheck disable=SC1091
source "$POLY_SRC/lib/lib-util.bash"
if [[ -e "$POLYGLOT_ROOT/.tasks/task-util.bash" ]]; then
    # shellcheck disable=SC1091
    source "$POLYGLOT_ROOT/.tasks/task-util.bash"
fi

current_script_path="${BASH_SOURCE[0]}"
toml_template=$(realpath "$(dirname "$current_script_path")")/polyglot.template

function pg_manage_locate () {
    echo "TODO: look up to find a polyglot.toml file"

}
