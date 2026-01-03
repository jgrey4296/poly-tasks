#!/usr/bin/env bash
# init.bash -*- mode: sh -*-
#set -o errexit
set -o nounset
set -o pipefail

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
usage: polyglot tool assets init [-h] [args ...]

positional arguments:
args          :

options:
-h, --help    : show this help message and exit


"
    exit "${PRINTED_HELP:-2}"
}

function make_assets_file () {
    local exts
    tdot "init" "Creating ${1}.toml"
    if [[ -e "${ASSETDIR}/${1}.toml" ]]; then
        fail "Assets data already exists."
    fi

    touch    "${ASSETDIR}/${1}.toml"
    exts=$(fdfind -E .assets -H -t f | sed -rn 's|.*[^/]+\.([^/.]+)$|.\1|p' | sort -u | sed -r '{:q;N;s/\n/, /g;t q}')
    # TODO get size of directory
    tdot "init" "Extensions: $exts"

    echo -e "# ${1}.toml -*- mode: Toml -*-
format_version = '0.1'

[[asset]]
version     = '0.1'
name        = \"${1}\"
author      = \"\"
source      = \"\"
license     = \"\"
extensions  = [\"${exts}\"]
date        = \"\"
" > "${ASSETDIR}/${1}.toml"

}

function make_integrity_file () {
    tdot "init" "Creating ${1}.integrity"
    touch    "${ASSETDIR}/${1}.integrity"

    ( fdfind \
        --hidden \
        --type f \
        --exclude ".assets" \
        --exec sha256sum > "${ASSETDIR}/${1}.integrity"
    )

    count=$(cat < "${ASSETDIR}/${1}.integrity" | wc -l)
    tdot "init" "Saved ${count} files' sha256sum's."
}

function make_tree_file () {
    tdot "init" "Creating ${1}.tree"
    touch "${ASSETDIR}/${1}.tree"

    ( fdfind \
        --hidden \
        --type f \
        --exclude ".assets" \
        | tree --fromfile > "$ASSETDIR/${1}.tree"
    )
}

function make_notes_file () {
    tdot "init" "Making Notes file."
    touch "${ASSETDIR}/${1}.notes"

}

# TODO: check args:
# TODO --force flag.

# Create the toml file, license file etc
ASSETDIR="$PWD/.assets"
name=$(basename "$PWD")

print-help "$@"
mkdir -p "${ASSETDIR}"
make_assets_file "$name"
make_integrity_file "$name"
make_tree_file "$name"
make_notes_file "$name"
