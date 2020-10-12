#!/bin/bash
# URL: https://github.com/yaneurao/YaneuraOu/releases/

set -e

# variables
NAME=YaneuraOu_700t_book
URL="https://github.com/yaneurao/YaneuraOu/releases/download/BOOK-700T-Shock/700T-shock-book.zip"
FILENAME=`echo $URL | sed -e 's/\// /g' | gawk '{print($NF)}'`
FILENAME_WITHOUT_EXT=`basename $FILENAME .zip`
SHA256SUMS='0d14943c5e960fad35d554bea6700edcbd929e9cdb5fa048dc6c472a89cb90c3'

# 変数(DESTDIR, WORKDIR) の読み込み
BASEDIR=$(cd `dirname $0`/../..; pwd)
. ${BASEDIR}/configure.sh
# 関数の読み込み
. ${BASEDIR}/tool.sh

# インストール先ディレクトリの作成
create_destdir
# 作業用ディレクトリの作成
create_workdir

echo -n "やねうら王 700テラショック定跡をインストールしています ... "

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

    LC_ALL=C unzip $FILENAME 2>&1 >> ${NAME}.install.log
    cp -pv user_book1.db ${DESTDIR}/book/ 2>&1 >> ${NAME}.install.log
fi

echo "完了"

