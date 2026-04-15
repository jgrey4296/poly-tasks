#!/usr/bin/env bash
# make-django.bash -*- mode: sh -*-
#set -o errexit
set -o nounset
set -o pipefail

uv run django-admin startproject biblio "${POLYGLOT_ROOT}"

echo "## ---- For Django:\n\n## ----" >> "${POLYGLOT_ROOT}/.envrc"
