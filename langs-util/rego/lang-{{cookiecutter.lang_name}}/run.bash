#!/usr/bin/env bash
# A Stub language command.
# Place in $root/.tasks/lang-{name}/{cmd}.bash
# and chmod +x it.
set -o nounset
set -o pipefail

DEFAULT_FILE="main.rego"

# shellcheck disable=SC1091
source "$POLY_SRC/lib/lib-util.bash"
if [[ -e "$POLYGLOT_ROOT/.tasks/task-util.bash" ]]; then
    # shellcheck disable=SC1091
    source "$POLYGLOT_ROOT/.tasks/task-util.bash"
fi

function print-help () {
    case "${@: -1}" in
        -h|--help) ;;
        *) if [[ "$#" -gt 0 ]]; then
               return
           fi
           ;;
    esac
    echo -e "
usage: polyglot lang rego run [-h] [package] [filename|--] [data] [query] [args...]

run a rego file

positional arguments:
package   : The subdir of $POLYGLOT_SRC to target
filename  : the file of the package to use
data      : a .json file
query     :
args      : arguments to pass to the command

options:
-h, --help    : show this help message and exit

"
    exit "${PRINTED_HELP:-2}"
}

function handle-result () {
    result="$1"
    shift

    case "$result" in
        0) exit 0 ;;
        1) fail "Command Failed" ;;
        *) fail "Unknown result code: $result"
    esac
}

function run-program () {
    shift
    target="$1"
    file="$2"
    data="$3"
    shift 3
    _args="$@"

    tdot "[rego]" "Running: $target/$file"
    # tee redirects to a file and stdout
    pushd "$POLYGLOT_SRC/_ai_and_logic/rego" || fail "Failed to go to rego dir"
    opa eval -d "$file" -i "$data" "${_args}" | tee "$POLYGLOT_TEMP/rego/$target-$file.json"
    popd || fail "Failed to return from rego dir"

}

function main () {
    print-help "$@"
    tdot "[rego]" "Parsing Args"
    case "$1" in
        --) file="$DEFAULT_FILE" ;;
        *)  file="$2" ;;
    esac
    shift 2
    _ARGS=("$@")
    check-target "_ai_and_logic/rego" "$file"
    run-program 0 "$target" "$file" "${_ARGS[@]}"
    handle-result "$?"
    exit "$?"
}

shift
main "$@"
