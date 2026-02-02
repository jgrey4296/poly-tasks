#!/usr/bin/env bash
# A Stub language command.
# Place in $root/.tasks/lang-{name}/{cmd}.bash
# and chmod +x it.
# java -cp tla2tools.jar tla2sany.SANY -help  # The TLA⁺ parser
# java -cp tla2tools.jar tlc2.TLC -help       # The TLA⁺ model checker
# java -cp tla2tools.jar tlc2.REPL            # Enter the TLA⁺ REPL
# java -cp tla2tools.jar pcal.trans -help     # The PlusCal-to-TLA⁺ translator
# java -cp tla2tools.jar tla2tex.TLA -help    # The TLA⁺-to-LaTeX translator
set -o nounset
set -o pipefail


# shellcheck disable=SC1091
source "$POLY_SRC/lib/lib-util.bash"
# shellcheck disable=SC1091
[[ -e "$POLYGLOT_ROOT/.tasks/task-util.bash" ]] && source "$POLYGLOT_ROOT/.tasks/task-util.bash"

DEFAULT_FILE="main.tla"
PGLANG="tla+"
HELP_TEXT="
usage: polyglot lang tla run [-h] [package] [filename|--] [args...]

run a $PGLANG file

positional arguments:
package   : The subdir of $POLYGLOT_SRC to target
filename  : the file of the package to use
args      : arguments to pass to the command

options:
-h, --help    : show this help message and exit

"

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
    file="$1"
    shift
    _ARGS=(
        "-T:10" # timeout in ten seconds
        "$@"
        )

    mkdir -p "$POLYGLOT_TEMP/z3"
    tdot "$PGLANG" "Running: $file"
    fail "TODO"
}

function main () {
    print-help "$HELP_TEXT" 0 "$@"
    tdot "$PGLANG" "Parsing Args"
    shift
    case "$1" in
        --) file="$DEFAULT_FILE" ;;
        *)  file="$2" ;;
    esac
    shift 2
    _ARGS=("$@")
    check-target "_ai_and_logic/tla" "$file"
    run-program "$file" "${_ARGS[@]}"
    handle-result "$?"
    exit "$?"
}

main "$@"
