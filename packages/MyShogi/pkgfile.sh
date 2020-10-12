#!/bin/bash
# URL: https://github.com/yaneurao/MyShogi

set -e

# variables
NAME=MyShogi
URL=https://github.com/yaneurao/MyShogi.git
COMMIT_HASH=c3300bb1b8a92d22ed6549ac4179c1413911eb4f     #May 21, 2020
#COMMIT_HASH=03f4c8c56546ac4685048bcdcf68f83440b1f3cb    #Feb  9, 2020
#COMMIT_HASH=77ca6b71b65e1203dde9f17d124c40340c1f981f    #Jan 28, 2020
#COMMIT_HASH=3a9e7b17b8a6daa809bfce391c68bec88c4302c4    #Nov 28, 2018
PATCH=MyShogi.patch
OS=Linux

# 変数(DESTDIR, WORKDIR) の読み込み
BASEDIR=$(cd `dirname $0`/../..; pwd)
. ${BASEDIR}/configure.sh
# 関数の読み込み
. ${BASEDIR}/tool.sh

# インストール先ディレクトリの作成
create_destdir
# 作業用ディレクトリの作成
create_workdir

# パッケージディレクトリに移動する
cd $BASEDIR/packages/$NAME

# myshogi.sh を作業用ディレクトリにコピーする
cp -p myshogi.sh ${WORKDIR}

# $PATCH を作業用ディレクトリにコピーする
cp -p $PATCH ${WORKDIR}

echo -n "MyShogiをインストールしています ... "

# 作業用ディレクトリに移動する
cd ${WORKDIR} >& /dev/null

# $NAME ディレクトリが存在しないとき、ビルドを実行する
if [ ! -d $NAME ]; then
    git clone $URL $NAME >& ${NAME}.install.log

    cd $NAME >& /dev/null
    (git checkout ${COMMIT_HASH} 2>&1) >> ../${NAME}.install.log

    # MonoAPI.cs: htmlをブラウザで開く箇所を修正
    # EngineDefineEditDialog.Designer.cs: Step 4 の文章を修正
    # howto-use-external-engine.html: 文章を修正
    # howto-use-external-engine.md: 文章を修正
    patch -p1 < ${WORKDIR}/$PATCH 2>&1 >> ../${NAME}.install.log

    msbuild ./${NAME}.sln /p:Configuration=${OS} 2>&1 >> ../${NAME}.install.log
    # MyShogi.exe をインストールする
    cp -pv ./${NAME}/bin/${OS}/${NAME}.exe ${DESTDIR} 2>&1 >> ../${NAME}.install.log
    # ヘルプファイル をインストールする
    cp -pv ./${NAME}/html/howto-use-external-engine.html ${DESTDIR}/html/ 2>&1 >> ../${NAME}.install.log
    # myshogi.sh をインストールする
    cp -pv ${WORKDIR}/myshogi.sh ${DESTDIR} 2>&1 >> ../${NAME}.install.log
fi

echo "完了"

