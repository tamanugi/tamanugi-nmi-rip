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
git remote add hugo https://${GH_TOKEN}@github.com/tamanugi/tamanugi-nmi.git
git push hugo master
echo "Successfully deployed."
