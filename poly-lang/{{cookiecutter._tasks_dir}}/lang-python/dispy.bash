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

# 1 or 2 args: target, and out
# https://docs.python.org/3/library/dis.html#command-line-interface
header "Python Disassembly"
DIS_TARGET="$1"
shift
DIS_OUT="$1"

[[ -e "$DIS_TARGET" ]] || fail "Python Disassembly Target doesn't exist: $DIS_TARGET"

if [[ -n "$DIS_OUT" ]]; then
    python -m dis "$DIS_TARGET"
else
    python -m dis "$DIS_TARGET" > "$DIS_OUT"
fi
