#!/bin/bash
# URL: https://github.com/qhapaq-49/qhapaq-bin

set -e

# variables
NAME=eval-Sylwi-wcso1
DIRNAME=Sylwi-wcso1
URL='https://github.com/mizar/YaneuraOu/releases/download/sylwi_wcsoc2020/Sylwi_WCSOC2020_windows.7z'
FILENAME=`echo $URL | sed -e 's/\// /g' | gawk '{print($NF)}'`
SHA256SUMS='5f0979f8e034d06136837e60f094337a2d7acb2add87bd3e5593a874540dd00a'
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

echo -n "評価関数 (Sylwi WCSO1版) をインストールしています ... "

# 作業用ディレクトリに移動する
cd ${WORKDIR} >& /dev/null

# $FILENAME が存在しないとき、ダウンロードを実行する
if [ ! -f $FILENAME ]; then
    wget $URL >& /dev/null

    if ! (echo "$SHA256SUMS $FILENAME" | sha256sum -c); then
        echo "ダウンロードしたファイル("$FILENAME")が壊れています" 1>&2
        exit 1
    fi

    # Sylwi_WCSOC2020_windows ディレクトリを削除する
    if [ -d Sylwi_WCSOC2020_windows ]; then
        rm -rf Sylwi_WCSOC2020_windows/
    fi

    unar $FILENAME 2>&1 >> ${LOGDIR}/${NAME}.install.log
    mkdir -pv ${DESTDIR}/eval/${DIRNAME} 2>&1 >> ${LOGDIR}/${NAME}.install.log
    cp -pv Sylwi_WCSOC2020_windows/windows/eval/nn.bin ${DESTDIR}/eval/${DIRNAME} 2>&1 >> ${LOGDIR}/${NAME}.install.log
fi

echo "完了"

