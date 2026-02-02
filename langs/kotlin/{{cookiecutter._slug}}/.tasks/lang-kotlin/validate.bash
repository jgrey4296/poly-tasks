#!/usr/bin/env bash
# validate.bash -*- mode: sh -*-
#set -o errexit
set -o nounset
set -o pipefail

# shellcheck disable=SC1091
source "$POLY_SRC/lib/lib-util.bash"
# shellcheck disable=SC1091
[[ -e "$POLYGLOT_ROOT/.tasks/task-util.bash" ]] && source "$POLYGLOT_ROOT/.tasks/task-util.bash"

tdot "kotlin" "Validating Basic"
gradle --no-daemon :kt_basic:build  || fail "Gradle Failed"

tdot "kotlin" "Validating Jacamo"
gradle --no-daemon :kt_jacamo:build || fail "Jacamo Failed"


tdot "kotlin" "TODO: validate dokka"
