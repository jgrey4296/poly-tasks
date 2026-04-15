#!/usr/bin/env bash
#set -o errexit
set -o nounset
set -o pipefail

# shellcheck disable=SC1091
[[ -e "$POLY_SRC/lib/lib.bash" ]] && source "$POLY_SRC/lib/lib.bash"
# shellcheck disable=SC1091
[[ -e "$(poly-dir)/task-util.bash" ]] && source "$(poly-dir)/task-util.bash"

tdot "android" "Generating android keystore"
# up to 2 args. 'new' and the name of the keystore file
case $1 in
    new)
        KEYSTORE_NAME="${2:-polyglot}"
        tdot "android" "Keystore File: $KEYSTORE_NAME"
        (
            keytool \
                -v \
                -genkey \
                -keystore "${POLYGLOT_ROOT}/${KEYSTORE_NAME}.keystore" \
                -alias "${KEYSTORE_NAME}" \
                -keyalg RSA \
                -validity 10000
        )
    ;;
    *) ;;
esac
