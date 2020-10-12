#!/bin/bash
# URL: https://github.com/yaneurao/YaneuraOu/releases/

set -e

# variables
NAME=YaneuraOu_true_book
URL="https://github.com/yaneurao/YaneuraOu/releases/download/v4.73_book/yaneura_book3.zip"
FILENAME=`echo $URL | sed -e 's/\// /g' | gawk '{print($NF)}'`
FILENAME_WITHOUT_EXT=`basename $FILENAME .zip`
SHA256SUMS='b613e1b59801f5e8f43096cb2498d30360464932365ee4d34346b63c8698e0e0'

# 変数(DESTDIR, WORKDIR) の読み込み
BASEDIR=$(cd `dirname $0`/../..; pwd)
. ${BASEDIR}/configure.sh
# 関数の読み込み
. ${BASEDIR}/tool.sh

# インストール先ディレクトリの作成
create_destdir
# 作業用ディレクトリの作成
create_workdir

echo -n "真やねうら王 定跡をインストールしています ... "

# 作業用ディレクトリに移動する
cd ${WORKDIR} >& /dev/null

# $FILENAME が存在しないとき、ダウンロードを実行する
if [ ! -f $FILENAME ]; then
    curl -L ${URL} -O >& /dev/null

    #echo "$SHA256SUMS $FILENAME" | sha256sum -c
    if ! (echo "$SHA256SUMS $FILENAME" | sha256sum -c); then
        echo "ダウンロードしたファイル("$FILENAME")が壊れています" 1>&2
        exit 1
    fi

    unzip $FILENAME 2>&1 >> ${NAME}.install.log
    cp -pv ${FILENAME_WITHOUT_EXT}.db ${DESTDIR}/book/ 2>&1 >> ${NAME}.install.log
fi

echo "完了"

