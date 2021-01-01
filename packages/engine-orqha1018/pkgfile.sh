#!/bin/bash
# URL: https://github.com/yaneurao/YaneuraOu

set -e

# variables
NAME=engine-orqha1018
DIRNAME=orqha1018
URL=https://github.com/yaneurao/YaneuraOu.git
COMMIT_HASH=68146b93ce98bd826691b90fd22e7f2742c285d8     #Jan  1, 2021 (V6.00)
#COMMIT_HASH=a47daa6c6e91fbb7bae1db370ee3c203258e2e1d    #Nov 16, 2020 (V5.32)
#COMMIT_HASH=aad2c9a381c7d3a18d8ad37c7b1107d76a9b0dde    #Nov  3, 2020 (V5.01)
#COMMIT_HASH=e69d268ca7cb65b376d83fc800cea4a04c9e1730    #Jun  1, 2020 (V4.91)
#COMMIT_HASH=42de5c6cbbfb6bca55a4d7e3d91a8620a4596466    #May 28, 2020 (V4.90)
#COMMIT_HASH=e99d2fc7c05489935badeb066de514a1ae2bcb1e    #Feb 28, 2020 (V4.89)
#COMMIT_HASH=8a56754f48776bb487942f8e283de334bd4e9888    #Jun 25, 2019 (V4.88)
EDITION=YANEURAOU_ENGINE_NNUE
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
. $PREREQUISITES $COMPILER

# engine_define.xml を作業用ディレクトリにコピーする
cp -p engine_define.xml ${WORKDIR}
# engine_options.txt を作業用ディレクトリにコピーする
cp -p engine_options.txt ${WORKDIR}
# banner.png を作業用ディレクトリにコピーする
cp -p banner.png ${WORKDIR}

echo -n "外部思考エンジン (やねうら王NNUE) をインストールしています(少し時間がかかります) ... "

# 作業用ディレクトリに移動する
cd ${WORKDIR} >& /dev/null

# $NAME ディレクトリが存在しないとき、ビルドを実行する
if [ ! -d $NAME ]; then
    git clone $URL $NAME >& ${LOGDIR}/${NAME}.install.log

    cd $NAME
    (git checkout ${COMMIT_HASH} 2>&1) >> ${LOGDIR}/${NAME}.install.log

    # やねうら王のスレッド起動に pthread を使うようにする野良パッチ
    # https://note.com/jnory/n/n76c31464e26b
    #patch -p1 < ${PATCH}

    echo -n "${EDITION}( "

    cd source
    #for ARCH in avx2 sse42 sse41 sse2; do
    for ARCH in `echo $ARCHLIST | sed -e 's/,/ /g'`; do
        echo -n "${ARCH} " 1>&2

        (make clean YANEURAOU_EDITION=$EDITION 2>&1) >> ${LOGDIR}/${NAME}.install.log
        (make -j1 normal TARGET_CPU=`echo $ARCH | tr '[a-z]' '[A-Z]'` COMPILER=${COMPILER} YANEURAOU_EDITION=${EDITION} 2>&1) >> ${LOGDIR}/${NAME}.install.log

        mkdir -pv ${DESTDIR}/engine/${DIRNAME} 2>&1 >> ${LOGDIR}/${NAME}.install.log
        install -m 755 YaneuraOu-by-gcc ${DESTDIR}/engine/${DIRNAME}/${DIRNAME}_${ARCH}.exe 2>&1 >> ${LOGDIR}/${NAME}.install.log
    done

    # engine_define.xml をインストールする
    cp -pv ${WORKDIR}/engine_define.xml ${DESTDIR}/engine/$DIRNAME 2>&1 >> ${LOGDIR}/${NAME}.install.log
    # engine_options.txt をインストールする
    cp -pv ${WORKDIR}/engine_options.txt ${DESTDIR}/engine/$DIRNAME 2>&1 >> ${LOGDIR}/${NAME}.install.log
    # 画像ファイルをインストールする
    cp -pv ${WORKDIR}/banner.png ${DESTDIR}/engine/$DIRNAME 2>&1 >> ${LOGDIR}/${NAME}.install.log

    echo -n ") "
fi

echo "完了"

