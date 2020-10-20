#!/bin/bash
# URL: https://github.com/yaneurao/YaneuraOu/releases/

set -e

# variables
NAME=YaneuraOu_700t_book
URL="https://github.com/yaneurao/YaneuraOu/releases/download/BOOK-700T-Shock/700T-shock-book.zip"
FILENAME1=`echo $URL | sed -e 's/\// /g' | gawk '{print($NF)}'`
FILENAME1_WITHOUT_EXT=`basename $FILENAME1 .zip`
SHA256SUMS='0d14943c5e960fad35d554bea6700edcbd929e9cdb5fa048dc6c472a89cb90c3'
FILENAME2=user_book1.db
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

echo -n "やねうら王 700テラショック定跡をインストールしています ... "

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

    LC_ALL=C unzip $FILENAME 2>&1 >> ${LOGDIR}/${NAME}.install.log
    cp -pv $FILENAME2 ${DESTDIR}/book/ 2>&1 >> ${LOGDIR}/${NAME}.install.log
fi

echo "完了"

