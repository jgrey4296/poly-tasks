#!/usr/bin/env bash
# rustdoc.bash -*- mode: sh -*-
#set -o errexit
set -o nounset
set -o pipefail


# shellcheck disable=SC1091
source "$POLY_SRC/lib/lib-util.bash"
if [[ -e "$POLYGLOT_ROOT/.tasks/task-util.bash" ]]; then
    source "$POLYGLOT_ROOT/.tasks/task-util.bash"
fi

function check () {
    if [[ ! -e "$POLYGLOT_ROOT/Cargo.toml" ]]; then
        fail "NOT FOUND: $POLYGLOT_ROOT/Cargo.toml"
    fi
    if [[ ! -d "$POLYGLOT_DOCS" ]]; then
        fail "NOT FOUND: $POLYGLOT_DOCS"
    fi
}

tdot "[rust] Building Rustdoc"
check
cargo doc \
    --workspace \
    --target-dir "$POLYGLOT_DOCS/rustdoc"
