#!/usr/bin/env bash
#set -o errexit
set -o nounset
set -o pipefail

# shellcheck disable=SC1091
source "$POLY_SRC/lib/lib-util.bash"
# shellcheck disable=SC1091
[[ -e "$POLYGLOT_ROOT/.tasks/task-util.bash" ]] && source "$POLYGLOT_ROOT/.tasks/task-util.bash"

tdot "python" "TODO: test"
# uv run pytest

# uv run pytest \
#     "--cov=$SRC_DIR" \
#     "--cov-report=json" \
#     "--cov-report=term" \
#     "--cov-report=xml" \
#     "--cov-report=html" \
#     "--no-cov-on-fail" \
