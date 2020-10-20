#!/bin/bash
# URL: https://github.com/tttak/YaneuraOu

set -e

# variables
NAME=engine-Sylwi-wcso1
DIRNAME=Sylwi-wcso1-nnue-halfkpe9
URL=https://github.com/tttak/YaneuraOu.git
COMMIT_HASH=d7a58b44e982f9608f9f0324d79f9ed101d17218     #Mar 26, 2020 (V4.89)
ARCHLIST="avx2"
#ARCHLIST="avx2,sse42"
#ARCHLIST="avx2,sse42,sse41,sse2"
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
. $PREREQUISITES

# engine_define.xml を作業用ディレクトリにコピーする
cp -p engine_define.xml ${WORKDIR}
# engine_options.txt を作業用ディレクトリにコピーする
cp -p engine_options.txt ${WORKDIR}
# banner.png を作業用ディレクトリにコピーする
cp -p banner.png ${WORKDIR}

echo -n "外部思考エンジン (やねうら王NNUE-HalfKPE9) をインストールしています(少し時間がかかります) ... "

# 作業用ディレクトリに移動する
cd ${WORKDIR} >& /dev/null

# $NAME ディレクトリが存在しないとき、ビルドを実行する
if [ ! -d $NAME ]; then
    git clone $URL $NAME >& ${LOGDIR}/${NAME}.install.log

    cd $NAME
    (git checkout ${COMMIT_HASH} 2>&1) >> ${LOGDIR}/${NAME}.install.log

    echo -n "${EDITION}( "

    cd source
    #for ARCH in avx2 sse42 sse41 sse2; do
    for ARCH in `echo $ARCHLIST | sed -e 's/,/ /g'`; do
        echo -n "${ARCH} " 1>&2

        (make clean YANEURAOU_EDITION=$EDITION 2>&1) >> ${LOGDIR}/${NAME}.install.log
        (make -j1 normal TARGET_CPU=`echo $ARCH | tr '[a-z]' '[A-Z]'` COMPILER=g++ YANEURAOU_EDITION=${EDITION} 2>&1) >> ${LOGDIR}/${NAME}.install.log

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

