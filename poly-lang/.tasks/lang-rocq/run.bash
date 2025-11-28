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

fail "TODO: run rocq"
# https://rocq-prover.org/doc/V9.0.0/refman/practical-tools/utilities.html

# rocq makefile -f _CoqProject -o CoqMakefile
# make -f CoqMakefile
