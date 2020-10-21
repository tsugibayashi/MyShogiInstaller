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
PATCH1=MonoAPI.patch
PATCH2=EngineDefineEditDialog.Designer.cs.patch
PATCH3=DisplaySettingDialog.Designer.cs.patch
PATCH4=OperationSettingDialog.Designer.cs.patch
PATCH5=GameSettingDialog.Designer.cs.patch
PATCH6=TimeSettingControl.Designer.cs.patch
PATCH7=howto-use-external-engine.patch
PATCH8=ConsiderationEngineSettingDialog.Designer.patch
PATCH9=MainDialogMenuItem.cs.patch
OS=Linux
PREREQUISITES=prerequisites.sh

# 変数(DESTDIR, WORKDIR, LOGDIR) の読み込み
BASEDIR=$(cd `dirname $0`/../..; pwd)
. ${BASEDIR}/configure.sh
# 関数の読み込み
. ${BASEDIR}/tool.sh

# インストール先ディレクトリなどを作成
create_dirs $DESTDIR $WORKDIR $LOGDIR

# パッケージディレクトリに移動する
cd $BASEDIR/packages/$NAME

# 前提条件の確認
. $PREREQUISITES

# myshogi.sh を作業用ディレクトリにコピーする
cp -p myshogi.sh ${WORKDIR}

# パッチファイルを作業用ディレクトリにコピーする
cp -p $PATCH1 ${WORKDIR}
cp -p $PATCH2 ${WORKDIR}
cp -p $PATCH3 ${WORKDIR}
cp -p $PATCH4 ${WORKDIR}
cp -p $PATCH5 ${WORKDIR}
cp -p $PATCH6 ${WORKDIR}
cp -p $PATCH7 ${WORKDIR}
cp -p $PATCH8 ${WORKDIR}
cp -p $PATCH9 ${WORKDIR}

echo -n "MyShogiをインストールしています ... "

# 作業用ディレクトリに移動する
cd ${WORKDIR} >& /dev/null

# $NAME ディレクトリが存在しないとき、ビルドを実行する
if [ ! -d $NAME ]; then
    git clone $URL $NAME >& ${LOGDIR}/${NAME}.install.log

    cd $NAME >& /dev/null
    (git checkout ${COMMIT_HASH} 2>&1) >> ${LOGDIR}/${NAME}.install.log

    # htmlをブラウザで開く箇所を修正
    patch -p1 < ${WORKDIR}/$PATCH1 2>&1 >> ${LOGDIR}/${NAME}.install.log
    # 設定->外部思考エンジンの利用 のStep 4の文章を修正
    patch -p1 < ${WORKDIR}/$PATCH2 2>&1 >> ${LOGDIR}/${NAME}.install.log
    # 設定->表示設定 の枠サイズを修正
    patch -p1 < ${WORKDIR}/$PATCH3 2>&1 >> ${LOGDIR}/${NAME}.install.log
    # 設定->操作設定 の枠サイズを修正
    patch -p1 < ${WORKDIR}/$PATCH4 2>&1 >> ${LOGDIR}/${NAME}.install.log
    # 対局->通常対局 の枠サイズを修正
    patch -p1 < ${WORKDIR}/$PATCH5 2>&1 >> ${LOGDIR}/${NAME}.install.log
    # 対局->通常対局 の文字の位置を調整
    patch -p1 < ${WORKDIR}/$PATCH6 2>&1 >> ${LOGDIR}/${NAME}.install.log
    # howto-use-external-engine.html: 文章を修正
    # howto-use-external-engine.md: 文章を修正
    patch -p1 < ${WORKDIR}/$PATCH7 2>&1 >> ${LOGDIR}/${NAME}.install.log
    # 対局->検討エンジン設定 の文字の位置を修正
    patch -p1 < ${WORKDIR}/$PATCH8 2>&1 >> ${LOGDIR}/${NAME}.install.log
    # ファイル->棋譜に名前を付けて保存 のKIF形式の拡張子を .kif に修正
    patch -p1 < ${WORKDIR}/$PATCH9 2>&1 >> ${LOGDIR}/${NAME}.install.log

    msbuild ./${NAME}.sln /p:Configuration=${OS} 2>&1 >> ${LOGDIR}/${NAME}.install.log
    # MyShogi.exe をインストールする
    cp -pv ./${NAME}/bin/${OS}/${NAME}.exe ${DESTDIR} 2>&1 >> ${LOGDIR}/${NAME}.install.log
    # ヘルプファイル をインストールする
    cp -pv ./${NAME}/html/howto-use-external-engine.html ${DESTDIR}/html/ 2>&1 >> ${LOGDIR}/${NAME}.install.log
    # myshogi.sh をインストールする
    cp -pv ${WORKDIR}/myshogi.sh ${DESTDIR} 2>&1 >> ${LOGDIR}/${NAME}.install.log
fi

echo "完了"

