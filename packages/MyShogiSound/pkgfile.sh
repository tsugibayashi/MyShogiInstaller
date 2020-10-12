#!/bin/bash
# URL: https://github.com/matarillo/MyShogiSound

set -e

# variables
NAME=MyShogiSound
URL=https://github.com/matarillo/MyShogiSound.git
COMMIT_HASH=3b192b0c6797e217ae3472196570071c19a25550

# 変数(DESTDIR, WORKDIR) の読み込み
BASEDIR=$(cd `dirname $0`/../..; pwd)
. ${BASEDIR}/configure.sh
# 関数の読み込み
. ${BASEDIR}/tool.sh

# インストール先ディレクトリの作成
create_destdir
# 作業用ディレクトリの作成
create_workdir

echo -n "音声データをダウンロードしています ... "

# 作業用ディレクトリに移動する
cd ${WORKDIR} >& /dev/null

# $NAME ディレクトリが存在しないとき、ダウンロードを実行する
if [ ! -d $NAME ]; then
    git clone $URL $NAME >& ${NAME}.install.log

    cd $NAME >& /dev/null
    (git checkout ${COMMIT_HASH} 2>&1) >> ../${NAME}.install.log

    # 音声データをコピーする
    cp -prv Amazon_Polly_Mizuki_YouTube_AudioLibrary_SoundEffects/sound/* ${DESTDIR}/sound/ 2>&1 >> ../${NAME}.install.log
fi

echo "完了"

