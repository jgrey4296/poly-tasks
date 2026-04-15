#!/usr/bin/env bash
# run.bash -*- mode: sh -*-
#set -o errexit
set -o nounset
set -o pipefail


uv run python manage.py runserver
