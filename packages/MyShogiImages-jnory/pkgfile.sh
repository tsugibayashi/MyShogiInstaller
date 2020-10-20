#!/bin/bash
# URL: https://github.com/jnory/MyShogiImages

set -e

# variables
NAME=MyShogiImages-jnory
URL=https://github.com/jnory/MyShogiImages.git
COMMIT_HASH=2b53ec8653509c97e9717d1bf485b7e9027ce163
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

echo -n "画像データ(jnory)をインストールしています ... "

# 作業用ディレクトリに移動する
cd ${WORKDIR} >& /dev/null

# $NAME ディレクトリが存在しないとき、ダウンロードを実行する
if [ ! -d $NAME ]; then
    git clone $URL $NAME >& ${LOGDIR}/${NAME}.install.log

    cd $NAME >& /dev/null
    (git checkout ${COMMIT_HASH} 2>&1) >> ${LOGDIR}/${NAME}.install.log

    # 画像データをコピーする
    # 注意事項: 既存画像は上書きされる
    cd ${WORKDIR} >& /dev/null
    cp -pv $NAME/*.png ${DESTDIR}/image/ 2>&1 >> ${LOGDIR}/${NAME}.install.log
fi

echo "完了"

