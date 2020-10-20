#!/bin/bash
# URL: https://github.com/qhapaq-49/qhapaq-bin

set -e

# variables
NAME=eval-Qhapaq-wcso1
DIRNAME=Qhapaq-wcso1
URL="https://github.com/qhapaq-49/qhapaq-bin/releases/download/tagtest/qns-halfkpe9.7z"
FILENAME=`echo $URL | sed -e 's/\// /g' | gawk '{print($NF)}'`
SHA256SUMS='dc41c49a51f71cc5ed278863d883ede9000d3d5412b6394b4b6e75b88f904916'
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

echo -n "評価関数 (Qhapaq WCSO1版) をインストールしています ... "

# 作業用ディレクトリに移動する
cd ${WORKDIR} >& /dev/null

# $FILENAME が存在しないとき、ダウンロードを実行する
if [ ! -f $FILENAME ]; then
    wget $URL >& /dev/null

    if ! (echo "$SHA256SUMS $FILENAME" | sha256sum -c); then
        echo "ダウンロードしたファイル("$FILENAME")が壊れています" 1>&2
        exit 1
    fi

    # qns-halfkpe9 ディレクトリを削除する
    if [ -d qns-halfkpe9 ]; then
        rm -rf eval/
    fi

    unar $FILENAME 2>&1 >> ${LOGDIR}/${NAME}.install.log
    mkdir -pv ${DESTDIR}/eval/${DIRNAME} 2>&1 >> ${LOGDIR}/${NAME}.install.log
    cp -pv qns-halfkpe9/nn.bin ${DESTDIR}/eval/${DIRNAME} 2>&1 >> ${LOGDIR}/${NAME}.install.log
fi

echo "完了"

