#!/usr/bin/env bash
# validate.bash -*- mode: sh -*-
#set -o errexit
set -o nounset
set -o pipefail


# shellcheck disable=SC1091
source "$POLY_SRC/lib/lib-util.bash"
if [[ -e "$POLYGLOT_ROOT/.tasks/task-util.bash" ]]; then
    source "$POLYGLOT_ROOT/.tasks/task-util.bash"
fi


tdot "Validating Kotlin"
gradle --no-daemon :kt_basic:build  || fail "Gradle Failed"

tdot "Validating Jacamo"
gradle --no-daemon :kt_jacamo:build || fail "Jacamo Failed"


tdot "TODO validate dokka"
