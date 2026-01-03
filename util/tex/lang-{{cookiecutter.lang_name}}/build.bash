#!/usr/bin/env bash
#set -o errexit
set -o nounset
set -o pipefail

DEFAULT_FILE="main"
TEX_PASSES="${TEX_PASSES:-3}"
TEX_USE_BIBTEX="${TEX_USE_BIBTEX:-1}"
TEX_OUT="$POLYGLOT_TEMP/tex"
LUA_FILE="$TEX_LUA_FILE"

# shellcheck disable=SC1091
source "$POLY_SRC/lib/lib-util.bash"
if [[ -e "$POLYGLOT_ROOT/.tasks/task-util.bash" ]]; then
    # shellcheck disable=SC1091
    source "$POLYGLOT_ROOT/.tasks/task-util.bash"
fi

function print-help () {
    # test args, if the last one is -h or --help
    # print help and exit
    case "${@: -1}" in
        -h|--help) ;;
        *) if [[ "$#" -gt 0 ]]; then
               return
           fi
           ;;
    esac
    echo -e "
usage: polyglot lang tex build [file] [args ...] [-h]

positional arguments:
file          : the .tex file to build
args          :

options:
-h, --help    : show this help message and exit


"
    return "${PRINTED_HELP:-2}"
    # exit "${PRINTED_HELP:-2}"
}

function luatex-pass () {
    pass="$1"
    localdir="$2"
    file="$3"
    shift 3

    # Takes 1 arg: The pass number. the rest arg global args
    tdot "tex" "Pass $pass: LuaLaTeX Compiling $file in $localdir"
    pushd "$localdir" || fail "lualatex pass failed to pushd"
    _ARGS=(
        "--lua=$LUA_FILE"
        "-interaction=nonstopmode"
        "--output-directory=$TEX_OUT"
    )

    case "${VERBOSE:-0}" in
        0)
            echo "..."
            lualatex "${_ARGS[@]}" "${file}.tex" > /dev/null || echo "Pass Exit Value: $?"
            ;;
        *)
            lualatex "${_ARGS[@]}" "${file}.tex" || echo "Pass Exit Value: $?"
            ;;
    esac
    popd || fail "lualatex pass failed to popd"
}

function bibtex-pass () {
    pass="$1"
    localdir="$2"
    file="$3"
    tdot "tex" "Pass $pass: Bibtex $file in $TEX_OUT"
    pushd "$TEX_OUT" || fail "bibtex pass failed to pushd"
    case "${VERBOSE:-0}" in
        0)
            BIBINPUTS="$TEX_OUT:$localdir:${POLYGLOT_DATA:-}:${BIBINPUTS:-}" bibtex "$file" > /dev/null
            ;;
        *)
            BIBINPUTS="$TEX_OUT:$localdir:${BIBINPUTS:-}" bibtex "$file"
            ;;
    esac
    popd || fail "bibtex pass failed to popd"
}

function main () {
    print-help "$@"
    shift
    target="$POLYGLOT_SRC/_tex"
    file="${1:-$DEFAULT_FILE}"
    check-target

    tdot "tex" "build lua-latex"
    tdot "tex" "Target: $TEX_OUT"
    for i in $(seq 1 "$TEX_PASSES"); do
        luatex-pass "$i" "$target" "$file"
    done
    case "$TEX_USE_BIBTEX" in
        1)
            bibtex-pass $((++i)) "$target" "$file"
            luatex-pass $((++i)) "$target" "$file"
            luatex-pass $((++i)) "$target" "$file"
            ;;
        *)
            luatex-pass $((++i)) "$target" "$file"
            ;;

    esac
    tdot "tex" "Finished."
    exit 0
}

main "$@"
