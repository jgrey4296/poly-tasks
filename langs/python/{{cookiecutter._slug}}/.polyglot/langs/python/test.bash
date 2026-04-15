#!/usr/bin/env bash
#set -o errexit
set -o nounset
set -o pipefail

# shellcheck disable=SC1091
[[ -e "$POLY_SRC/lib/lib.bash" ]] && source "$POLY_SRC/lib/lib.bash"
# shellcheck disable=SC1091
[[ -e "$(poly-dir)/task-util.bash" ]] && source "$(poly-dir)/task-util.bash"

tdot "python" "TODO: test"
# uv run pytest

# uv run pytest \
#     "--cov=$SRC_DIR" \
#     "--cov-report=json" \
#     "--cov-report=term" \
#     "--cov-report=xml" \
#     "--cov-report=html" \
#     "--no-cov-on-fail" \
