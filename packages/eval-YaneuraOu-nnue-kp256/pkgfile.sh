#!/bin/bash
# URL: https://github.com/yaneurao/YaneuraOu

set -e

# variables
NAME=eval-YaneuraOu-nnue-kp256
DIRNAME=YaneuraOu-nnue-kp256
URL="https://github.com/yaneurao/YaneuraOu/releases/download/20190212_k-p-256-32-32/20190212_k-p-256-32-32.zip"
FILENAME=`echo $URL | sed -e 's/\// /g' | gawk '{print($NF)}'`
SHA256SUMS='e8d7359a8648acfadfba6ef87ff129e4466091643e6094a1b1a82c91e640eebb'
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

echo -n "評価関数 (やねうら王 NNUE(KP256)) をインストールしています ... "

# 作業用ディレクトリに移動する
cd ${WORKDIR} >& /dev/null

# $FILENAME が存在しないとき、ダウンロードを実行する
if [ ! -f $FILENAME ]; then
    wget $URL >& /dev/null

    if ! (echo "$SHA256SUMS $FILENAME" | sha256sum -c); then
        echo "ダウンロードしたファイル("$FILENAME")が壊れています" 1>&2
        exit 1
    fi

    unzip $FILENAME 2>&1 >> ${LOGDIR}/${NAME}.install.log
    mkdir -pv ${DESTDIR}/eval/${DIRNAME} 2>&1 >> ${LOGDIR}/${NAME}.install.log
    cp -pv nn.bin ${DESTDIR}/eval/${DIRNAME} 2>&1 >> ${LOGDIR}/${NAME}.install.log
fi

echo "完了"

