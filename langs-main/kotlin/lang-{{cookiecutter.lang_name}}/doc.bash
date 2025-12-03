#!/usr/bin/env bash
# doc.bash -*- mode: sh -*-
#set -o errexit
set -o nounset
set -o pipefail


# shellcheck disable=SC1091
source "$POLY_SRC/lib/lib-util.bash"
if [[ -e "$POLYGLOT_ROOT/.tasks/task-util.bash" ]]; then
    source "$POLYGLOT_ROOT/.tasks/task-util.bash"
fi

function check () {
    if [[ ! -e "$POLYGLOT_ROOT/dokka.json" ]]; then
        fail "NOT FOUND: $POLYGLOT_ROOT/dokka.json"
    fi
}

tdot "[kotlin]" "Documenting with Dokka"
check
# https://kotlinlang.org/docs/dokka-cli.html
# java -jar dokka-cli-2.0.0.jar "$@" "$POLYGLOT_ROOT/dokka.json"
gradle dokkaGenerateHtml
