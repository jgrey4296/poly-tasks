#!/usr/bin/env bash
#set -o errexit
set -o nounset
set -o pipefail

# shellcheck disable=SC1091
[[ -e "$POLY_SRC/lib/lib.bash" ]] && source "$POLY_SRC/lib/lib.bash"
# shellcheck disable=SC1091
[[ -e "$(poly-dir)/task-util.bash" ]] && source "$(poly-dir)/task-util.bash"

echo '
[polyglot.python]
suffixes  = [".py"]
config    = ["pyproject.toml", "ruff.toml", "uv.lock"]
prefix    = "py_"
active    = []

'
