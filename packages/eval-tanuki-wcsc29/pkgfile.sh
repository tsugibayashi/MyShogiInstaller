#!/bin/bash
# URL: https://github.com/nodchip/tanuki-

set -e

# variables
NAME=eval-tanuki-wcsc29
DIRNAME=tanuki-wcsc29
URL="https://github.com/nodchip/tanuki-/releases/download/tanuki-wcsc29-2019-05-06/tanuki-wcsc29-2019-05-06.7z"
FILENAME1=`echo $URL | sed -e 's/\// /g' | gawk '{print($NF)}'`
DIRNAME1=`basename $FILENAME1 .7z`
SHA256SUMS='1b42c081a8c5931aa04facf8d1764bce18c1411c4e06e989d52b068becde3f7a'
FILENAME2=user_book2.db

# 変数(DESTDIR, WORKDIR, LOGDIR) の読み込み
BASEDIR=$(cd `dirname $0`/../..; pwd)
. ${BASEDIR}/configure.sh
# 関数の読み込み
. ${BASEDIR}/tool.sh
PREREQUISITES=prerequisites.sh

# 前提条件の確認
. $PREREQUISITES

# インストール先ディレクトリなどを作成
create_dirs $DESTDIR $WORKDIR $LOGDIR

echo -n "評価関数 (tanuki- WCSC29版) をインストールしています ... "

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

    unar $FILENAME1 2>&1 >> ${LOGDIR}/${NAME}.install.log
    mkdir -pv ${DESTDIR}/eval/${DIRNAME} 2>&1 >> ${LOGDIR}/${NAME}.install.log
    cp -pv ${DIRNAME1}/eval/*.bin ${DESTDIR}/eval/${DIRNAME} 2>&1 >> ${LOGDIR}/${NAME}.install.log
    cp -pv ${DIRNAME1}/book/$FILENAME2 ${DESTDIR}/book/ 2>&1 >> ${LOGDIR}/${NAME}.install.log
fi

echo "完了"

