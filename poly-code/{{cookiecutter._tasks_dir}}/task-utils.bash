#!/usr/bin/env bash
# task-utils.bash -*- mode: sh -*-
#set -o errexit
set -o nounset
set -o pipefail

function check-target () {
    if [[ ! -d "$POLYGLOT_SRC/$1" ]]; then
        fail "Target Does not exist: $1"
    fi

    if [[ ! -e "$POLYGLOT_SRC/$1/$2" ]]; then
        fail "Target does not have a file to run: $2"
    fi
}
