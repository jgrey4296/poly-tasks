#!/usr/bin/env bash
# A clingo run command
set -o nounset
set -o pipefail

# shellcheck disable=SC1091
source "$POLY_SRC/lib/lib-util.bash"
if [[ -e "$POLYGLOT_ROOT/.tasks/task-util.bash" ]]; then
    source "$POLYGLOT_ROOT/.tasks/task-util.bash"
fi

DEFAULT_FILE="basic.lp"

function print-help () {
    case "${@: -1}" in
        -h|--help) ;;
        *) if [[ "$#" -gt 0 ]]; then
               return
           fi
           ;;
    esac
    echo -e "
usage: polyglot lang clingo run [-h] [packageName] [file|--]? [args...]

positional arguments:
packageName  : the package in root/src
file         : the file to  run
--           : Run the default file, $DEFAULT_FILE
args         : arguments to pass to clingo

options:
-h, --help    : show this help message and exit


"
    exit "${PRINTED_HELP:-2}"
}

function check-target () {
    if [[ ! -d "$POLYGLOT_SRC/$1" ]]; then
        fail "Target Does not exist: $1"
    fi

    if [[ ! -e "$POLYGLOT_SRC/$1/$2" ]]; then
        fail "Target does not have a file to run: $2"
    fi
}

function handle-result () {
    result="$1"
    shift

    # parse the result code according to: https://www.mat.unical.it/aspcomp2013/files/aspoutput.txt
    # |-----------+-------------------------------------------------------------------------------------------|
    # | Exit code | Meaning                                                                                   |
    # |-----------+-------------------------------------------------------------------------------------------|
    # |         1 | Run interrupted: No solution has been found so far                                        |
    # |-----------+-------------------------------------------------------------------------------------------|
    # |        10 | Program is consistent / some consequences exist / query is true                           |
    # |-----------+-------------------------------------------------------------------------------------------|
    # |        11 | Run interrupted: Program is consistent / some consequences exist                          |
    # |-----------+-------------------------------------------------------------------------------------------|
    # |        20 | Program is inconsistent / query is false                                                  |
    # |-----------+-------------------------------------------------------------------------------------------|
    # |        30 | Program is consistent, all possible solutions/consequences enumerated / some optima found |
    # |-----------+-------------------------------------------------------------------------------------------|
    # |        31 | Run interrupted: Program is consistent / some optima found                                |
    # |-----------+-------------------------------------------------------------------------------------------|
    # |        62 | Program is consistent / all possible optima found                                         |
    # |-----------+-------------------------------------------------------------------------------------------|
    # |       128 | Syntax error / command line arguments error                                               |
    # |-----------+-------------------------------------------------------------------------------------------|
    case "$result" in
        1)
            subhead "Interrupted, no solution found yet."
            exit 0
            ;;
        10) # rerun, output as json
            run-program 1 "$@"
            exit 0 ;;
        11) subhead "Interrupted but consistent"
            exit 0
            ;;
        20) fail "No solution found" ;;
        30) exit 0 ;;
        31) subhead "Interrupted but consistent"
            exit 0
            ;;
        62) exit 0 ;;
        65|128) fail "Syntax Error" ;;
        *) fail "Unknown result code: $result" ;;
    esac
}

function run-program () {
    out_switch="$1"
    target="$2"
    file="$3"
    shift 3
    result=""
    if [[ "$out_switch" = 0 ]]; then
        subhead "Running clingo ${CLINGO_ARGS[*]} $target/$file\n"
        clingo "$@" "$POLYGLOT_SRC/$target/$file"
        result="$?"
        sep
    else
        subhead "Saving results as json"
        mkdir -p "$POLYGLOT_TEMP/clingo"
        clingo "$@" "--outf=2" "$POLYGLOT_SRC/$target/$file" > "$POLYGLOT_TEMP/clingo/$target-$file.json"
        result="$?"
    fi
    return "$result"
}

function main () {
    print-help "$@"
    subhead "Parsing Args"
    shift
    target="$1"
    case "$2" in
        --) file="$DEFAULT_FILE" ;;
        *)  file="$2" ;;
    esac
    shift 2
    CLINGO_ARGS=("-Wall"
                "--keep-facts"
                "${POLYGLOT_SEED:+--seed=}${POLYGLOT_SEED:-}"
                "$@"
                )

    check-target "$target" "$file"
    run-program 0 "$target" "$file" "${CLINGO_ARGS[@]}"
    handle-result "$?" "$target" "$file" "${CLINGO_ARGS[@]}"
    exit "$?"
}

main "$@"
