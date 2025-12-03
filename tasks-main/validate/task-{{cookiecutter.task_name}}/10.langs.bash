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

subhead "Validating Main Languages"

if (polyglot check lang-python ); then
    polyglot lang python validate "$@"
fi
if (polyglot check lang-rust ); then
    polyglot lang rust validate "$@"
fi
if (polyglot check lang-dotnet ); then
    polyglot lang dotnet validate "$@"
fi
if (polyglot check lang-elixir ); then
    polyglot lang elixir validate "$@"
fi
if (polyglot check lang-kotlin ); then
    polyglot lang kotlin validate "$@"
fi
if (polyglot check lang-godot ); then
    polyglot lang godot validate "$@"
fi
if (polyglot check lang-lisp ); then
    polyglot land lisp validate "$@"
fi
