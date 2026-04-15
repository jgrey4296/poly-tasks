#!/usr/bin/env bash
# build-plugin.bash -*- mode: sh -*-
#set -o errexit
set -o nounset
set -o pipefail

dune build
