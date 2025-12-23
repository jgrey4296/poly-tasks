#!/usr/bin/env bash
#set -o errexit
set -o nounset
set -o pipefail

# shellcheck disable=SC1091
source "$POLY_SRC/lib/lib-util.bash"

out="${POLYGLOT_TEMP}"
site_out="$out/site"
do_clean=1
while [[ $# -gt 0 ]]; do
    case $1 in
        -nc|--no-clean)
            do_clean=0
            ;;
        --out)
            shift
            echo "Out: $1"
            site_out=$(realpath "$site_out/$1")
            ;;
        *) # Positional
            ;;
    esac
    shift
done

if [[ "$do_clean" -gt 0 ]] && [[ -d "${site_out}" ]]; then
    echo -e "-- Removing old output directory"
    rm -r "${site_out}"
fi
