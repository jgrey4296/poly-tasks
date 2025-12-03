#!/usr/bin/env bash
# init.bash -*- mode: sh -*-
#set -o errexit
# set -o nounset # disabled because sdkman has an unset var
set -o pipefail


# shellcheck disable=SC1091
source "$POLY_SRC/lib/lib-util.bash"
if [[ -e "$POLYGLOT_ROOT/.tasks/task-util.bash" ]]; then
    source "$POLYGLOT_ROOT/.tasks/task-util.bash"
fi

# https://sdkman.io/install/
if [[ -n "$SDKMAN_DIR" ]] && [[ -d  "$SDKMAN_DIR" ]]; then
    tdot "[kotlin]" "sdkman installed, activating"
    # shellcheck disable=SC1091
    source "$SDKMAN_DIR/bin/sdkman-init.sh"
else
    tdot "[kotlin]" "Installing SDKMAN"
    curl -s "https://get.sdkman.io" | bash
    # shellcheck disable=SC1091
    source "$SDKMAN_DIR/bin/sdkman-init.sh"
    sep
fi
