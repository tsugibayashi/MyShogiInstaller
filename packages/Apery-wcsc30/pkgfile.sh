#!/bin/bash
# URL: https://github.com/HiraokaTakuya/apery_rust

set -e

# variables
NAME=Apery-wcsc30
DIRNAME=Apery-wcsc30
URL=https://github.com/HiraokaTakuya/apery_rust.git
COMMIT_HASH=09830dc4f1126b2ca1af0566cfcbb51bb5939b69
ARCH=avx2
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

# engine_define.xml を作業用ディレクトリにコピーする
cp -p engine_define.xml ${WORKDIR}
# banner.png を作業用ディレクトリにコピーする
cp -p banner.png ${WORKDIR}

echo -n "外部思考エンジン (Apery WCSC30版) をインストールしています(少し時間がかかります) ... "

# 作業用ディレクトリに移動する
cd ${WORKDIR} >& /dev/null

# $NAME ディレクトリが存在しないとき、ビルドを実行する
if [ ! -d $NAME ]; then
    git clone $URL $NAME >& ${LOGDIR}/${NAME}.install.log

    cd $NAME
    (git checkout ${COMMIT_HASH} 2>&1) >> ${LOGDIR}/${NAME}.install.log

    # 評価関数バイナリを取得する
    git submodule init 2>&1 >> ${LOGDIR}/${NAME}.install.log
    git submodule update 2>&1 >> ${LOGDIR}/${NAME}.install.log

    # ビルドする
    cargo build --release 2>&1 >> ${LOGDIR}/${NAME}.install.log

    mkdir -pv ${DESTDIR}/engine/${DIRNAME}/eval/20190617 2>&1 >> ${LOGDIR}/${NAME}.install.log

    # Apery をインストールする
    install -m 755 ./target/release/apery ${DESTDIR}/engine/${DIRNAME}/${DIRNAME}_${ARCH}.exe 2>&1 >> ${LOGDIR}/${NAME}.install.log
    # 評価関数をインストールする
    cp -pv ./eval/20190617/*.bin ${DESTDIR}/engine/${DIRNAME}/eval/20190617/ 2>&1 >> ${LOGDIR}/${NAME}.install.log

    # engine_define.xml をインストールする
    cp -pv ${WORKDIR}/engine_define.xml ${DESTDIR}/engine/$DIRNAME 2>&1 >> ${LOGDIR}/${NAME}.install.log
    # 画像ファイルをインストールする
    cp -pv ${WORKDIR}/banner.png ${DESTDIR}/engine/$DIRNAME 2>&1 >> ${LOGDIR}/${NAME}.install.log
fi

echo "完了"

