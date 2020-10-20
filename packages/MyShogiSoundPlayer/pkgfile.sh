#!/bin/bash
# URL: https://github.com/jnory/MyShogiSoundPlayer

set -e

# variables
NAME=MyShogiSoundPlayer
URL=https://github.com/jnory/MyShogiSoundPlayer.git
COMMIT_HASH=2d3c08ef33a9f951aaef366aaa3cc7d5094aa8d7
OS=Linux
MAKE_TARGET=linux
EXT=so
PREREQUISITES=prerequisites.sh

# 前提条件の確認
. $PREREQUISITES

# 変数(DESTDIR, WORKDIR, LOGDIR) の読み込み
BASEDIR=$(cd `dirname $0`/../..; pwd)
. ${BASEDIR}/configure.sh
# 関数の読み込み
. ${BASEDIR}/tool.sh

# インストール先ディレクトリなどを作成
create_dirs $DESTDIR $WORKDIR $LOGDIR

echo -n "SoundPlayerをインストールしています ... "

# 作業用ディレクトリに移動する
cd ${WORKDIR} >& /dev/null

# $NAME ディレクトリが存在しないとき、ビルドを実行する
if [ ! -d $NAME ]; then
    git clone --recursive $URL $NAME >& ${LOGDIR}/${NAME}.install.log

    cd $NAME >& /dev/null
    (git checkout ${COMMIT_HASH} 2>&1) >> ${LOGDIR}/${NAME}.install.log

    (make ${MAKE_TARGET} 2>&1) >> ${LOGDIR}/${DIRNAME}.build.log
    cp -pv SoundPlayer/bin/${OS}/SoundPlayer.exe ${DESTDIR} 2>&1 >> ${LOGDIR}/${NAME}.install.log
    cp -pv SoundPlayer/bin/${OS}/libwplay.${EXT} ${DESTDIR} 2>&1 >> ${LOGDIR}/${NAME}.install.log
fi

echo "完了"

