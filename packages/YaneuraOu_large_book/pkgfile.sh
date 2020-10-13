#!/bin/bash
# URL: https://github.com/yaneurao/YaneuraOu/releases/

set -e

# variables
NAME=YaneuraOu_large_book
URL="https://github.com/yaneurao/YaneuraOu/releases/download/v4.73_book/yaneura_book1_V101.zip"
FILENAME1=`echo $URL | sed -e 's/\// /g' | gawk '{print($NF)}'`
FILENAME1_WITHOUT_EXT=`basename $FILENAME1 .zip`
SHA256SUMS='9c3a72777326ce6172d02dcd9fcba0d69be629f758f5da3b6f275cee5c826996'
FILENAME2=yaneura_book1.db

# 変数(DESTDIR, WORKDIR, LOGDIR) の読み込み
BASEDIR=$(cd `dirname $0`/../..; pwd)
. ${BASEDIR}/configure.sh
# 関数の読み込み
. ${BASEDIR}/tool.sh

# インストール先ディレクトリなどを作成
create_dirs $DESTDIR $WORKDIR $LOGDIR

echo -n "やねうら王 大定跡をインストールしています ... "

# 作業用ディレクトリに移動する
cd ${WORKDIR} >& /dev/null

# $FILENAME1 が存在しないとき、ダウンロードを実行する
if [ ! -f $FILENAME1 ]; then
    curl -L ${URL} -O >& /dev/null

    #echo "$SHA256SUMS $FILENAME1" | sha256sum -c
    if ! (echo "$SHA256SUMS $FILENAME1" | sha256sum -c); then
        echo "ダウンロードしたファイル("$FILENAME1")が壊れています" 1>&2
        exit 1
    fi

    unzip $FILENAME1 2>&1 >> ${LOGDIR}/${NAME}.install.log
    cp -pv $FILENAME2 ${DESTDIR}/book/ 2>&1 >> ${LOGDIR}/${NAME}.install.log
fi

echo "完了"

