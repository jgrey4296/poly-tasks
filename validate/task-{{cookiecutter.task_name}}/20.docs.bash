#!/usr/bin/env bash
# 20.docs.bash -*- mode: sh -*-
#set -o errexit
set -o nounset
set -o pipefail

# shellcheck disable=SC1091
source "$POLY_SRC/lib/lib-util.bash"
if [[ -e "$POLYGLOT_ROOT/.tasks/task-util.bash" ]]; then
    source "$POLYGLOT_ROOT/.tasks/task-util.bash"
fi

function validate-sphinx () {
    subhead "Validating Sphinx"

}

function validate-rustdoc () {
    subhead "Validating Rustdoc"

}

function validate-docfx () {
    subhead "Validating Docfx"

}

function validate-dokka () {
    subhead "Validating dokka"

}

function validate-epub () {
    subhead "Validating Epub"

}

function validate-tex () {
    subhead "Validating Tex"

}

function validate-rocqdoc () {
    subhead "Validating Rocqdoc"

}


function main () {
    subhead "Validating Docs"



}

main
