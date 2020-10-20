#!/bin/bash
# URL: https://github.com/Tama4649/Kristallweizen/

set -e

# variables
NAME=eval-Kristallweizen-kaiV0.4
DIRNAME=Kristallweizen-kaiV0.4
URL="https://github.com/Tama4649/Kristallweizen/raw/master/Kristallweizen_kaiV0.4.zip"
FILENAME=`echo $URL | sed -e 's/\// /g' | gawk '{print($NF)}'`
SHA256SUMS='f949f49ee2601cef8b156aaac1bfda8a61f95f7372274b784c847da9326b5d36'
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

echo -n "評価関数 (Kristallweizen改 V0.4) をインストールしています ... "

# 作業用ディレクトリに移動する
cd ${WORKDIR} >& /dev/null

# $FILENAME が存在しないとき、ダウンロードを実行する
if [ ! -f $FILENAME ]; then
    wget $URL >& /dev/null

    if ! (echo "$SHA256SUMS $FILENAME" | sha256sum -c); then
        echo "ダウンロードしたファイル("$FILENAME")が壊れています" 1>&2
        exit 1
    fi

    # eval ディレクトリを削除する
    if [ -d eval ]; then
        rm -rf eval/
    fi

    # 評価関数をインストールする
    unzip $FILENAME 2>&1 >> ${LOGDIR}/${NAME}.install.log
    mkdir -pv ${DESTDIR}/eval/${DIRNAME} 2>&1 >> ${LOGDIR}/${NAME}.install.log
    cp -pv eval/nn.bin ${DESTDIR}/eval/${DIRNAME} 2>&1 >> ${LOGDIR}/${NAME}.install.log
fi

echo "完了"

