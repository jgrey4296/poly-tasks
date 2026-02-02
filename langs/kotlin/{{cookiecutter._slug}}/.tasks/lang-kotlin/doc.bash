#!/usr/bin/env bash
# doc.bash -*- mode: sh -*-
#set -o errexit
set -o nounset
set -o pipefail

# shellcheck disable=SC1091
source "$POLY_SRC/lib/lib-util.bash"
# shellcheck disable=SC1091
[[ -e "$POLYGLOT_ROOT/.tasks/task-util.bash" ]] && source "$POLYGLOT_ROOT/.tasks/task-util.bash"

function check () {
    [[ -e "$POLYGLOT_ROOT/dokka.json" ]] || fail "NOT FOUND: $POLYGLOT_ROOT/dokka.json"
}

tdot "kotlin" "Documenting with Dokka"
check
# https://kotlinlang.org/docs/dokka-cli.html
# java -jar dokka-cli-2.0.0.jar "$@" "$POLYGLOT_ROOT/dokka.json"
gradle dokkaGenerateHtml
