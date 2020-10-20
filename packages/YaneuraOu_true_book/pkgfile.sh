#!/bin/bash
# URL: https://github.com/yaneurao/YaneuraOu/releases/

set -e

# variables
NAME=YaneuraOu_true_book
URL="https://github.com/yaneurao/YaneuraOu/releases/download/v4.73_book/yaneura_book3.zip"
FILENAME=`echo $URL | sed -e 's/\// /g' | gawk '{print($NF)}'`
FILENAME_WITHOUT_EXT=`basename $FILENAME .zip`
SHA256SUMS='b613e1b59801f5e8f43096cb2498d30360464932365ee4d34346b63c8698e0e0'
PREREQUISITES=prerequisites.sh

# 前提条件の確認
. $PREREQUISITES

# 変数(DESTDIR, WORKDIR, LOGDIR) の読み込み
BASEDIR=$(cd `dirname $0`/../..; pwd)
. ${BASEDIR}/configure.sh
# 関数の読み込み
. ${BASEDIR}/tool.sh

# インストール先ディレクトリなどを作成
create_dirs $DESTDIR $WORKDIR $LOGDIR

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

    unzip $FILENAME 2>&1 >> ${LOGDIR}/${NAME}.install.log
    cp -pv ${FILENAME_WITHOUT_EXT}.db ${DESTDIR}/book/ 2>&1 >> ${LOGDIR}/${NAME}.install.log
fi

echo "完了"

