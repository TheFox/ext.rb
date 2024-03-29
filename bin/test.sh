#!/usr/bin/env bash

# Run Tests.

SCRIPT_BASEDIR=$(dirname "$0")
RUBYOPT=-w
TZ=Europe/Vienna

which bundler &> /dev/null || { echo 'ERROR: bundler not found in PATH'; exit 1; }

cd "${SCRIPT_BASEDIR}/.."

echo 'run tests'
bundler exec ./test/suite_all.rb $*
