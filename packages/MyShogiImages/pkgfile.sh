#!/bin/bash
# URL: https://github.com/jnory/MyShogiImages

set -e

# variables
NAME=MyShogiImages
URL=https://github.com/jnory/MyShogiImages.git
COMMIT_HASH=2b53ec8653509c97e9717d1bf485b7e9027ce163

# 変数(DESTDIR, WORKDIR) の読み込み
BASEDIR=$(cd `dirname $0`/../..; pwd)
. ${BASEDIR}/configure.sh
# 関数の読み込み
. ${BASEDIR}/tool.sh

# インストール先ディレクトリの作成
create_destdir
# 作業用ディレクトリの作成
create_workdir

echo -n "画像データをダウンロードしています ... "

# 作業用ディレクトリに移動する
cd ${WORKDIR} >& /dev/null

# $NAME ディレクトリが存在しないとき、ダウンロードを実行する
if [ ! -d $NAME ]; then
    git clone $URL $NAME >& ${NAME}.install.log

    cd $NAME >& /dev/null
    (git checkout ${COMMIT_HASH} 2>&1) >> ../${NAME}.install.log

    # 画像データをコピーする
    cd ${WORKDIR} >& /dev/null
    cp -pv $NAME/*.png ${DESTDIR}/image/ 2>&1 >> ${NAME}.install.log
fi

echo "完了"

