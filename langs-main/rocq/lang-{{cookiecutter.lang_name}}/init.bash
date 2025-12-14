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

switchname=$(basename "$POLYGLOT_ROOT")
ocaml_version="${OCAML_VERSION:-5.4.0}"
tdot "[rocq]" "Initialising Opam Switch: $switchname with ocaml ${ocaml_version}"
opam switch create "$switchname" "$ocaml_version"
eval $(opam env)

if [[ -e "$POLYGLOT_ROOT/.opam" ]]; then
    tdot "[rocq]" "Installing dependencies from .opam"
    opam switch import "$POLYGLOT_ROOT/.opam"
else
    tdot "[rocq]" "No dependency .opam file found"
    opam install ocaml-lsp-server odoc ocamlformat utop dune
    opam pin rocq-prover 9.0.0
    # https://rocq-prover.org/docs/using-opam#platform
    opam repo add rocq-released https://rocq-prover.org/opam/released
fi
