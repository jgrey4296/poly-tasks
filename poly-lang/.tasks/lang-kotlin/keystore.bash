#!/usr/bin/env bash
#set -o errexit
set -o nounset
set -o pipefail

# shellcheck disable=SC1091
source "$POLY_SRC/lib/lib-util.bash"
if [[ -e "$POLYGLOT_ROOT/.tasks/task-util.bash" ]]; then
    # shellcheck disable=SC1091
    source "$POLYGLOT_ROOT/.tasks/task-util.bash"
fi
# up to 2 args. 'new' and the name of the keystore file
case $1 in
    new)
        KEYSTORE_NAME="${2:-polyglot}"
        header "[Android] Generating Keystore File: $KEYSTORE_NAME"
        keytool \
            -v \
            -genkey \
            -keystore "${POLYGLOT_ROOT}/${KEYSTORE_NAME}.keystore" \
            -alias "${KEYSTORE_NAME}" \
            -keyalg RSA \
            -validity 10000
    ;;
    *) ;;
esac
