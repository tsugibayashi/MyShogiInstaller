#!/bin/bash
# URL: https://www.qhapaq.org/shogi/kifdb/

set -e

# variables
NAME=eval-orqha1018
DIRNAME=orqha1018
URL="https://www.qhapaq.org/static/media/bin/orqha1018.7z"
FILENAME1=`echo $URL | sed -e 's/\// /g' | gawk '{print($NF)}'`
DIRNAME1=`basename $FILENAME1 .7z`
SHA256SUMS='dfc38cf78310372413bd8cf05b017352b7e9113509415560530913eade6783ee'
PREREQUISITES=prerequisites.sh

# 変数(DESTDIR, WORKDIR, LOGDIR) の読み込み
BASEDIR=$(cd `dirname $0`/../..; pwd)
. ${BASEDIR}/configure.sh
# 関数の読み込み
. ${BASEDIR}/tool.sh

# インストール先ディレクトリなどを作成
create_dirs $DESTDIR $WORKDIR $LOGDIR

# 前提条件の確認
. $BASEDIR/packages/$NAME/$PREREQUISITES

echo -n "評価関数 (orqha1018) をインストールしています ... "

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
    cp -pv orqha-1018/nn.bin ${DESTDIR}/eval/${DIRNAME} 2>&1 >> ${LOGDIR}/${NAME}.install.log
fi

echo "完了"

