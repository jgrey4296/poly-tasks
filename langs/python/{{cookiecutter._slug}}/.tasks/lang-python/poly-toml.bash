#!/usr/bin/env bash
#set -o errexit
set -o nounset
set -o pipefail

# shellcheck disable=SC1091
source "$POLY_SRC/lib/lib-util.bash"
# shellcheck disable=SC1091
[[ -e "$POLYGLOT_ROOT/.tasks/task-util.bash" ]] && source "$POLYGLOT_ROOT/.tasks/task-util.bash"

echo '
[polyglot.python]
suffixes  = [".py"]
config    = ["pyproject.toml", "ruff.toml", "uv.lock"]
prefix    = "py_"
active    = []

'
