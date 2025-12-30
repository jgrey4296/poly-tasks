#!/usr/bin/env bash
# init.bash -*- mode: sh -*-
#set -o errexit
set -o nounset
set -o pipefail

# shellcheck disable=SC1091
source "$POLY_SRC/lib/lib-util.bash"
if [[ -e "$POLYGLOT_ROOT/.tasks/task-util.bash" ]]; then
    source "$POLYGLOT_ROOT/.tasks/task-util.bash"
fi

ASDF_PLUGIN_LIST="$POLYGLOT_ROOT/.asdf.plugins"

# asdf plugin add
if [[ -e "${ASDF_PLUGIN_LIST:-}" ]]; then
    tdot "[asdf]" "Initialising extra plugins"
    while read -r pname url; do
        if [[ -n "$pname" ]]; then
            asdf plugin add "${pname}" "${url}" 2> /dev/null
        fi
    done < "$ASDF_PLUGIN_LIST"
fi

tdot "[asdf]" "Installing tools"
asdf install 2> /dev/null
