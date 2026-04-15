#!/usr/bin/env bash
#set -o errexit
set -o nounset
set -o pipefail

# shellcheck disable=SC1091
[[ -e "$POLY_SRC/lib/lib.bash" ]] && source "$POLY_SRC/lib/lib.bash"
# shellcheck disable=SC1091
[[ -e "$(poly-dir)/task-util.bash" ]] && source "$(poly-dir)/task-util.bash"

# 1 or 2 args: target, and out
# https://docs.python.org/3/library/dis.html#command-line-interface
DIS_TARGET="$1"
shift
DIS_OUT="$1"

[[ -e "$DIS_TARGET" ]] || fail "Python Disassembly Target doesn't exist: $DIS_TARGET"

tdot "python" "Disassembing: $DIS_TARGET"
if [[ -n "$DIS_OUT" ]]; then
    python -m dis "$DIS_TARGET"
else
    python -m dis "$DIS_TARGET" > "$DIS_OUT"
    tdot "python" "Disassembled to: $DIS_OUT"
fi
