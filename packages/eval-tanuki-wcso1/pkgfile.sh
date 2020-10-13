#!/bin/bash
# URL: https://github.com/nodchip/tanuki-

set -e

# variables
NAME=eval-tanuki-wcso1
DIRNAME=tanuki-wcso1
URL="https://github.com/nodchip/tanuki-/releases/download/tanuki-wcso1/tanuki-wcso1-2020-05-05.7z"
FILENAME1=`echo $URL | sed -e 's/\// /g' | gawk '{print($NF)}'`
DIRNAME1=`basename $FILENAME1 .7z`
SHA256SUMS='d203dcc0b5d165e0171ce52a2b394a61a23eea32cebaabac63f40b6aa7581dea'
FILENAME2=user_book1.db   #注意: YaneuraOu_700t_book でインストールされるファイルと同名
FILENAME3=user_book2.db   #注意: eval-tanuki-wcsc29 でインストールされるファイルと同名

# 変数(DESTDIR, WORKDIR, LOGDIR) の読み込み
BASEDIR=$(cd `dirname $0`/../..; pwd)
. ${BASEDIR}/configure.sh
# 関数の読み込み
. ${BASEDIR}/tool.sh

# インストール先ディレクトリなどを作成
create_dirs $DESTDIR $WORKDIR $LOGDIR

echo -n "評価関数 (tanuki- WCSO1版) をインストールしています ... "

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
    cp -pv ${DIRNAME1}/book/$FILENAME3 ${DESTDIR}/book/ 2>&1 >> ${LOGDIR}/${NAME}.install.log
fi

echo "完了"

