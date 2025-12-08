#!/usr/bin/env bash
# init.bash -*- mode: sh -*-
#set -o errexit
set -o nounset
set -o pipefail

# shellcheck disable=SC1091
source "$POLY_SRC/lib/lib-util.bash"
if [[ -e "$POLYGLOT_ROOT/.tasks/task-util.bash" ]]; then
    source "$POLYGLOT_ROOT/.tasks/task-util.bash"
fi

tdot "[rocq]" "TODO: install ocaml"

tdot "[rocq]" "TODO: install opam"

if [[ -e "$POLYGLOT_ROOT/.opam" ]]; then
    tdot "[rocq]" "Initialising local opam switch"
    opam switch import "$POLYGLOT_ROOT/.opam"
else
    opam install ocaml-lsp-server odoc ocamlformat utop dune
    opam pin rocq-prover 9.0.0
    # https://rocq-prover.org/docs/using-opam#platform
    opam repo add rocq-released https://rocq-prover.org/opam/released
fi
