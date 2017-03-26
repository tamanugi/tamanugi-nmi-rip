#!/bin/bash

set -eu

DIST_DIR=docs

# git config
git config --global user.email "example@example.com"
git config --global user.name "tamanugi"

# 変更があったらcommit
cd ${DIST_DIR}
echo `git diff --name-only`
git add .
d=`date +"%Y/%m/%d %k:%M:%S"`
git diff --cached --exit-code --quiet || git commit -m "Update blog at ${d}"

# GitHubにpush
echo "Push to GitHub"
git push origin master > /dev/null 2>&1
echo "Successfully deployed."
