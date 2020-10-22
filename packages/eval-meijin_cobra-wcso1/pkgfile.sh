#!/bin/bash
# URL: https://drive.google.com/file/d/11AlHhwujgSxEoc1yk8wyTFJXQrh9LZ9q/view

set -e

# variables
NAME=eval-meijin_cobra-wcso1
DIRNAME=meijin_cobra-wcso1
FILEID='11AlHhwujgSxEoc1yk8wyTFJXQrh9LZ9q'
FILENAME1='meijin_cobra_wcsoc2020.zip'
SHA256SUMS='f16fde7f3277b50f0dbdb9c65c32ba5ca5c9a21386315390b59cbac1bc734c69'
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

echo -n "評価関数 (名人コブラ WCSO1版) をインストールしています ... "

# 作業用ディレクトリに移動する
cd ${WORKDIR} >& /dev/null

# $FILENAME1 が存在しないとき、ダウンロードを実行する
if [ ! -f $FILENAME1 ]; then
    # HTTPクッキーファイルを取得
    curl -sc ${WORKDIR}/cookie.txt "https://drive.google.com/uc?export=download&id=${FILEID}" > /dev/null

    # 4文字のパスを取得
    CODE=`cat ${WORKDIR}/cookie.txt | grep _warning_ | gawk '{print($NF)}'`

    # ファイルをダウンロード
    curl -Lb ${WORKDIR}/cookie.txt "https://drive.google.com/uc?export=download&confirm=${CODE}&id=${FILEID}" -o ${FILENAME1}

    #echo "$SHA256SUMS $FILENAME1" | sha256sum -c
    if ! (echo "$SHA256SUMS $FILENAME1" | sha256sum -c); then
        echo "ダウンロードしたファイル("$FILENAME1")が壊れています" 1>&2
        exit 1
    fi

    # 既存の nn.bin を削除する
    if [ -f nn.bin ]; then
        rm -v nn.bin
    fi

    unzip $FILENAME1 2>&1 >> ${LOGDIR}/${NAME}.install.log
    mkdir -pv ${DESTDIR}/eval/${DIRNAME} 2>&1 >> ${LOGDIR}/${NAME}.install.log
    cp -pv nn.bin ${DESTDIR}/eval/${DIRNAME} 2>&1 >> ${LOGDIR}/${NAME}.install.log
fi

echo "完了"

