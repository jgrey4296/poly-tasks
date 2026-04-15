#!/usr/bin/env bash
# sphinx.bash -*- mode: sh -*-
#set -o errexit
set -o nounset
set -o pipefail

# shellcheck disable=SC1091
[[ -e "$POLY_SRC/lib/lib.bash" ]] && source "$POLY_SRC/lib/lib.bash"
# shellcheck disable=SC1091
[[ -e "$(poly-dir)/task-util.bash" ]] && source "$(poly-dir)/task-util.bash"

function check () {
    [[ -e "$POLYGLOT_SPHINX_CONF_DIR/conf.py" ]] || fail "NOT FOUND: $POLYGLOT_SPHINX_CONF_DIR/conf.py"
    [[ -n "${POLYGLOT_DOCS:-}" ]] || fail "NOT DEFINED: POLYGLOT_DOCS"
}

subhead "[python]" "Building Sphinx"
check

function main () {
    declare -a sphinx_args=()
    builder="${ POLYGLOT_SPHINX_BUILDER:-html}"
    conf="$POLYGLOT_SPHINX_CONF_DIR"
    out="$POLYGLOT_TEMP/site"
    doctrees="$POLYGLOT_TEMP/doctrees"
    logs="$POLYGLOT_TEMP/logs"
    src="$POLYGLOT_SRC"

    fname=$(basename "${BASH_SOURCE[0]}")

    # Parse args:
    while [[ $# -gt 0 ]]; do
        case $1 in
            --fresh)
                echo "- using a fresh environment for sphinx"
                sphinx_args+=("--fresh-env")
                ;;
            --all)
                echo "- writing all files"
                sphinx_args+=("--write-all")
                ;;
            --builder=*)
                IFS="=" read -ra KEYVAL <<< "$1"
                builder="${KEYVAL[1]}"
                ;;
            *) ;;
        esac
        shift
    done

    sphinx_args+=("--builder" "$builder")

    uv run sphinx-build "${sphinx_args[@]}" \
        --conf-dir "$conf" \
        --doctree-dir "$doctrees" \
        --warning-file "$logs/sphinx.log" \
        "$src" "$out"
}

main "$@"
