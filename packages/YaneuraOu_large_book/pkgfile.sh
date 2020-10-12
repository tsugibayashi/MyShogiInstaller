#!/bin/bash
# URL: https://github.com/yaneurao/YaneuraOu/releases/

set -e

# variables
NAME=YaneuraOu_large_book
URL="https://github.com/yaneurao/YaneuraOu/releases/download/v4.73_book/yaneura_book1_V101.zip"
FILENAME=`echo $URL | sed -e 's/\// /g' | gawk '{print($NF)}'`
FILENAME_WITHOUT_EXT=`basename $FILENAME .zip`
SHA256SUMS='9c3a72777326ce6172d02dcd9fcba0d69be629f758f5da3b6f275cee5c826996'

# 変数(DESTDIR, WORKDIR) の読み込み
BASEDIR=$(cd `dirname $0`/../..; pwd)
. ${BASEDIR}/configure.sh
# 関数の読み込み
. ${BASEDIR}/tool.sh

# インストール先ディレクトリの作成
create_destdir
# 作業用ディレクトリの作成
create_workdir

echo -n "やねうら王 大定跡をインストールしています ... "

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
    cp -pv yaneura_book1.db ${DESTDIR}/book/ 2>&1 >> ${NAME}.install.log
fi

echo "完了"

