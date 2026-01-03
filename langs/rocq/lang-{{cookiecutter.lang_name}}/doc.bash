#!/usr/bin/env bash
# doc.bash -*- mode: sh -*-
#set -o errexit
set -o nounset
set -o pipefail


# shellcheck disable=SC1091
source "$POLY_SRC/lib/lib-util.bash"
if [[ -e "$POLYGLOT_ROOT/.tasks/task-util.bash" ]]; then
    source "$POLYGLOT_ROOT/.tasks/task-util.bash"
fi

function check () {
    if [[ ! -e "$POLYGLOT_ROOT/_CoqProject" ]]; then
        fail "NOT FOUND: $POLYGLOT_ROOT/_CoqProject"
    fi
}

tdot "rocq" "TODO: Doc"
check

mkdir "$POLYGLOT_DOCS/rocq"
# https://rocq-prover.org/doc/V9.0.0/refman/using/tools/coqdoc.html
rocq doc --HTML --LaTeX -d "$POLYGLOT_DOCS/rocq"
