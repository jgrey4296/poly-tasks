#!/usr/bin/env bash
# rustdoc.bash -*- mode: sh -*-
#set -o errexit
set -o nounset
set -o pipefail

# shellcheck disable=SC1091
source "$POLY_SRC/lib/lib-util.bash"
# shellcheck disable=SC1091
[[ -e "$POLYGLOT_ROOT/.tasks/task-util.bash" ]] && source "$POLYGLOT_ROOT/.tasks/task-util.bash"

function check () {
    [[  -e "$POLYGLOT_ROOT/Cargo.toml" ]] || fail "NOT FOUND: $POLYGLOT_ROOT/Cargo.toml"
    [[  -d "$POLYGLOT_DOCS" ]] || fail "NOT FOUND: $POLYGLOT_DOCS"
}

tdot "rust" "doc"
check
( cargo doc \
    --workspace \
    --target-dir "$POLYGLOT_DOCS/rustdoc"
  ) || fail "cargo doc failed"
