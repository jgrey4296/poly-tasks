#!/usr/bin/env bash
#set -o errexit
set -o nounset
set -o pipefail

# shellcheck disable=SC1091
[[ -e "$POLY_SRC/lib/lib.bash" ]] && source "$POLY_SRC/lib/lib.bash"
# shellcheck disable=SC1091
[[ -e "$(poly-dir)/task-util.bash" ]] && source "$(poly-dir)/task-util.bash"

tdot "rocq" "TODO: run"
# https://rocq-prover.org/doc/V9.0.0/refman/practical-tools/utilities.html

# rocq makefile -f _CoqProject -o CoqMakefile
# make -f CoqMakefile
