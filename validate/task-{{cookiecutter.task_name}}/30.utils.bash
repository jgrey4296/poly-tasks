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

function validate-asp () {
    subhead "Validating ASP"
    clingo src/_utilities/asp/main.lp
    # TODO handle the return code
}

function validate-csd () {
    subhead "Validating Csound"
    csound \
        -o .temp/csound/blah.wav \
        src/_utilities/csd/main.csd \
        || fail "Csound Failed"
}

function validate-octave () {
    subhead "Validating Octave"
    pushd "$POLYGLOT_SRC/_utilities/oct"
    octave -qf "main.m" || fail "Failed octave"
    popd
}

function validate-opa () {
    subhead "Validating OPA"
    opa eval \
        -d src/_utilities/opa/main.rego \
        "data.example.pi" \
        | jq .result[0].expression[0].value \
        || fail "OPA failed"
    }

function validate-swipl () {
    subhead "Validating Prolog"
    swipl -t halt src/_utilities/pl/main.pl london || fail "Prolog Failed"
}

function validate-soar () {
    subhead "Validating Soar"
    # soar -s src/_utilities/soar/main.soar run || fail "Soar Failed"
}

function validate-z3 () {
    subhead "Validating Z3"
    z3 src/_utilities/z3/main.z3 || fail "Z3 failed"
}

function validate-sclang () {
    subhead "Validating sclang"
    pushd "$POLYGLOT_SRC/_utilities/sc"
    sclang -l lib.yaml -r -s main.scd || fail "SCLang failed"
    popd
}

function main() {
    validate-asp
    validate-csd
    validate-octave
    validate-opa
    validate-swipl
    validate-soar
    validate-z3
    validate-sclang
}

main
