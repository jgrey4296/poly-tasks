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

subhead "Validating Utility Languages"

if (polyglot check lang-clingo ); then
    polyglot lang clingo validate "$@"
fi
if (polyglot check lang-csound ); then
    polyglot lang csound validate "$@"
fi
if (polyglot check lang-octave ); then
    polyglot lang octave validate "$@"
fi
if (polyglot check lang-rego ); then
    polyglot lang rego validate "$@"
fi
if (polyglot check lang-prolog ); then
    polyglot lang prolog validate "$@"
fi
if (polyglot check lang-soar ); then
    polyglot lang soar validate "$@"
fi
if (polyglot check lang-z3 ); then
    polyglot lang z3 validate "$@"
fi
if (polyglot check lang-sclang ); then
    polyglot lang sclang validate "$@"
fi
