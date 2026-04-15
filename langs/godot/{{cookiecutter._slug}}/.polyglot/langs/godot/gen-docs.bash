#!/usr/bin/env bash
# gen-docs.bash -*- mode: sh -*-
#set -o errexit
set -o nounset
set -o pipefail

Godot --doctool ./.temp/gdscript
