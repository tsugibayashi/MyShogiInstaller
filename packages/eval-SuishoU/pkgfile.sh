#!/bin/bash
# URL: https://drive.google.com/drive/folders/19Al69YMkJ_cXSBhtn8df9yfxhn8QFCYo

set -e

# variables
NAME=eval-SuishoU
DIRNAME=SuishoU
FILEID='1zNZDetdgjrKaay7vvoMfXiF0XpeXdzMJ'
FILENAME1='水匠U(二枚落ち特化）.zip'
DIRNAME1=''$'\220\205\217\240''U'
SHA256SUMS='b9ef64d53f38bf749f20a0ad1d687c839d2221b63df8af3c2d755d0c7dc64583'
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

echo -n "評価関数 (水匠U(二枚落ち特化)) をインストールしています ... "

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

    LC_ALL=C unzip $FILENAME1 2>&1 >> ${LOGDIR}/${NAME}.install.log
    mkdir -pv ${DESTDIR}/eval/${DIRNAME} 2>&1 >> ${LOGDIR}/${NAME}.install.log
    cp -pv ${DIRNAME1}/eval/*.bin ${DESTDIR}/eval/${DIRNAME} 2>&1 >> ${LOGDIR}/${NAME}.install.log
fi

echo "完了"

