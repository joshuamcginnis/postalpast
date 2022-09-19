#!/usr/bin/env bash

echo "Running pre-push hook"
./scripts/rubocop.sh

# $? stores exit value of the last command
if [ $? -ne 0 ]; then
 echo "Rubocop must pass before pushing!"
 exit 1
fi
