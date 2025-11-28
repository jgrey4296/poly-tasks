#!/usr/bin/env bash
#set -o errexit
set -o nounset
set -o pipefail

# shellcheck disable=SC1091
source "$POLY_SRC/lib/lib-util.bash"
if [[ -e "$POLYGLOT_ROOT/.tasks/task-util.bash" ]]; then
    # shellcheck disable=SC1091
    source "$POLYGLOT_ROOT/.tasks/task-util.bash"
fi

fail "TODO: python test"
# uv run pytest

# uv run pytest \
#     "--cov=$SRC_DIR" \
#     "--cov-report=json" \
#     "--cov-report=term" \
#     "--cov-report=xml" \
#     "--cov-report=html" \
#     "--no-cov-on-fail" \
