#!/bin/bash

set -eu

DIST_DIR=public

# 変更があったらcommit
cd ${DIST_DIR}
git add .
d=`date +"%Y/%m/%d %k:%M:%S"`
git diff --cached --exit-code --quiet || git commit -m "Update blog at ${d}"

# GitHubにpush
echo "Push to GitHub"
git push origin master > /dev/null 2>&1
echo "Successfully deployed."
