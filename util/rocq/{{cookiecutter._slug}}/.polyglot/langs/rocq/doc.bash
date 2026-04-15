#!/usr/bin/env bash
# doc.bash -*- mode: sh -*-
#set -o errexit
set -o nounset
set -o pipefail

# shellcheck disable=SC1091
[[ -e "$POLY_SRC/lib/lib.bash" ]] && source "$POLY_SRC/lib/lib.bash"
# shellcheck disable=SC1091
[[ -e "$(poly-dir)/task-util.bash" ]] && source "$(poly-dir)/task-util.bash"

function check () {
    [[ -e "$POLYGLOT_ROOT/_CoqProject" ]] || fail "NOT FOUND: $POLYGLOT_ROOT/_CoqProject"
}

tdot "rocq" "TODO: Doc"
check

[[ -d "$POLYGLOT_DOCS/rocq" ]] || mkdir "$POLYGLOT_DOCS/rocq"
# https://rocq-prover.org/doc/V9.0.0/refman/using/tools/coqdoc.html
( rocq doc \
    --HTML \
    --LaTeX \
    -d "$POLYGLOT_DOCS/rocq"
  ) || fail "rocq doc failed"
