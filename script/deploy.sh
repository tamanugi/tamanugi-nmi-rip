#!/bin/bash

set -eu

# hugo関係のファイルを置く場所。
HUGO_DIR=./hugo
echo "HUGO_DIR : ${HUGO_DIR}"

# hugoのバイナリファイル
HUGO_BIN="${HUGO_DIR}/hugo"
echo "HUGO_BIN : ${HUGO_BIN}"

# サイトを生成するディレクトリ
DIST_DIR=./public
echo "DIST_DIR : ${DIST_DIR}"

# hugoのファイルがなかったらダウンロード
if [ ! -e "${HUGO_DIR}" ];then
  echo "Download hugo bin"

  HUGO_PACKAGE=hugo.tgz
  echo "HUGO_PACKAGE : ${HUGO_PACKAGE}"

  echo "Create '${HUGO_DIR}'"
  mkdir ${HUGO_DIR}

  cd ${HUGO_DIR}
  wget -O ${HUGO_PACKAGE} https://github.com/spf13/hugo/releases/download/v0.16/hugo_0.16_linux-64bit.tgz
  tar -xvf ${HUGO_PACKAGE}
  cd ..
fi

# サイトを生成
echo "Compile site"
${HUGO_BIN}

# 変更があったらcommit
cd ${DIST_DIR}
git add .
d=`date +"%Y/%m/%d %k:%M:%S"`
git diff --cached --exit-code --quiet || git commit -m "Update blog at ${d}"

# GitHubにpush
echo "Push to GitHub"
git push origin master > /dev/null 2>&1
echo "Successfully deployed."
