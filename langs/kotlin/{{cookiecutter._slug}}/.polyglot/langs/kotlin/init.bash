#!/usr/bin/env bash
# init.bash -*- mode: sh -*-
#set -o errexit
# set -o nounset # disabled because sdkman has an unset var
set -o pipefail

# shellcheck disable=SC1091
[[ -e "$POLY_SRC/lib/lib.bash" ]] && source "$POLY_SRC/lib/lib.bash"
# shellcheck disable=SC1091
[[ -e "$(poly-dir)/task-util.bash" ]] && source "$(poly-dir)/task-util.bash"

# https://sdkman.io/install/
if [[ -n "$SDKMAN_DIR" ]] && [[ -d  "$SDKMAN_DIR" ]]; then
    tdot "kotlin" "sdkman installed, activating"
    # shellcheck disable=SC1091
    source "$SDKMAN_DIR/bin/sdkman-init.sh"
else
    tdot "kotlin" "Installing SDKMAN"
    curl -s "https://get.sdkman.io" | bash
    # shellcheck disable=SC1091
    source "$SDKMAN_DIR/bin/sdkman-init.sh"
    sep
fi
