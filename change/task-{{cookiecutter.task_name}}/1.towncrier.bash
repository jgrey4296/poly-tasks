#!/usr/bin/env bash

towncrier create --no-edit "+.${1:-feature}"
