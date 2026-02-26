#!/usr/bin/env bash
# init.bash -*- mode: sh -*-
#set -o errexit
set -o nounset
set -o pipefail

# shellcheck disable=SC1091
source "$POLY_SRC/lib/lib-util.bash"
# shellcheck disable=SC1091
[[ -e "$POLYGLOT_ROOT/.tasks/task-util.bash" ]] && source "$POLYGLOT_ROOT/.tasks/task-util.bash"

switchname="$PG_OPAM_SWITCH_NAME"
ocaml_version="${OCAML_VERSION:-5.4.0}"
tdot "rocq" "Initialising Opam Switch: $switchname with ocaml ${ocaml_version}"
opam switch create "$switchname" "$ocaml_version"
eval $(opam env)

OPAM_DEFAULT_INSTALLS=(ocaml-lsp-server odoc ocamlformat utop dune)
ROCQ_PIN="${ROCQ_PIN:-9.0.0}"
ROCQ_REPO="https://rocq-prover.org/opam/released"

if [[ -e "$POLYGLOT_ROOT/.opam" ]]; then
    tdot "rocq" "Installing dependencies from .opam"
    opam switch import "$POLYGLOT_ROOT/.opam"
else
    tdot "rocq" "No dependency .opam file found"
    opam install "${OPAM_DEFAULT_INSTALLS[@]}"
    opam pin rocq-prover "ROCQ_PIN"
    # https://rocq-prover.org/docs/using-opam#platform
    opam repo add rocq-released "$ROCQ_REPO"
fi
