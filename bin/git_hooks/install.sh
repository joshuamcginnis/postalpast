#!/usr/bin/env bash

GIT_DIR=$(git rev-parse --git-dir)

echo "Installing hooks..."
# make sure it works with relative paths
# ln -s ./pre_push.sh $GIT_DIR/hooks/pre-push
echo "Done!"
