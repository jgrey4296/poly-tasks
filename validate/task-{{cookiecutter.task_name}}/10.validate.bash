#!/usr/bin/env bash
# 10.validate.bash -*- mode: sh -*-
#set -o errexit
set -o nounset
set -o pipefail

# shellcheck disable=SC1091
source "$POLY_SRC/lib/lib-util.bash"
if [[ -e "$POLYGLOT_ROOT/.tasks/task-util.bash" ]]; then
    source "$POLYGLOT_ROOT/.tasks/task-util.bash"
fi

function validate-py () {
    subhead "Validating Python"
    uv sync || fail "Python failed"
}

function validate-rs () {
    subhead "Validating Rust"
    cargo build || fail "Rust failed"
}

function validate-dotnet () {
    subhead "Validating Dotnet"
    if [[ -e "$POLYGLOT_ROOT/blah.sln" ]]; then
        rm "$POLYGLOT_ROOT/blah.sln"
    fi
    dotnet new sln                 || fail "Dotnet Failed"
    dotnet solution add src/cs_exe || fail "Dotnet Failed"
    dotnet solution add src/cs_lib || fail "Dotnet Failed"
    dotnet solution add src/fs_exe || fail "Dotnet Failed"
    dotnet build                   || fail "Dotnet Failed"
}

function validate-elixir () {
    subhead "Validating Elixir"
    mix deps.get || fail "Elixir Failed"
    mix compile  || fail "Elixir Failed"
}

function validate-lisp () {
    subhead "Validating Lisp"
    ## pushd src/el
    ## eask files
    ## popd src/el
}

function validate-gd () {
    subhead "Validating Godot"
    godot \
        --headless \
        --script src/gd/scripts/cli_access.gd \
        || fail "Godot Failed"
}

function validate-kotlin () {
    subhead "Validating Kotlin"
    gradle --no-daemon :kt_basic:build  || fail "Gradle Failed"
}

function validate-jacamo () {
    subhead "Validating Jacamo"
    gradle --no-daemon :kt_jacamo:build || fail "Jacamo Failed"
}

function validate-rocq () {
    subhead "Validating Rocq"
}

function main () {
    validate-py
    validate-rs
    validate-dotnet
    validate-elixir
    validate-kotlin
    validate-jacamo
    validate-gd
    validate-lisp
}

main
