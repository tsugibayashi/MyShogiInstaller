#!/bin/bash

function build_myshogi() {
    local BUILD_DIR=$1
    local REPOS=$2
    local VERSION=$3
    local OS=$4
    local TARGET_DIR=$5

    echo -n "MyShogiをビルドしています ... " 1>&2

    pushd ${BUILD_DIR} >& /dev/null
    git clone ${REPOS} MyShogi >& MyShogi.build.log
    pushd MyShogi >& /dev/null

    (git checkout ${VERSION} 2>&1) >> ../MyShogi.build.log
    msbuild ./MyShogi.sln /p:Configuration=${OS} 2>&1 >> ../MyShogi.build.log
    cp -p ./MyShogi/bin/${OS}/MyShogi.exe ${TARGET_DIR}
    popd >& /dev/null
    popd >& /dev/null

    echo "完了" 1>&2
}

function compile_yaneuraou() {
    # reference: https://github.com/yaneurao/MyShogi/blob/master/MyShogi/docs/Mac%E3%80%81Linux%E3%81%A7%E5%8B%95%E4%BD%9C%E3%81%95%E3%81%9B%E3%82%8B%E3%81%AB%E3%81%AF.md#%E6%80%9D%E8%80%83%E3%82%A8%E3%83%B3%E3%82%B8%E3%83%B3%E3%81%AE%E3%82%B3%E3%83%B3%E3%83%91%E3%82%A4%E3%83%AB%E6%89%8B%E9%A0%86
    local YANEURAOU_DIR=$1
    local PACKAGE_NAME=$2
    local YANEURAOU_EDITION=$3
    local BASE=$4
    local ARCHLIST=`echo $5 | sed -e 's/,/ /g'`
    local TARGET_DIR=$6
    local ENGINE_DEFINES=$7

    echo -n "${YANEURAOU_EDITION}( " 1>&2

    pushd ${YANEURAOU_DIR}/source >& /dev/null
    #for ARCH in avx2 sse42 sse41 sse2; do
    for ARCH in $ARCHLIST; do
        echo -n "${ARCH} " 1>&2

        (make clean YANEURAOU_EDITION=${YANEURAOU_EDITION} 2>&1) >> ../../YaneuraOu.build.log
        (make -j1 normal TARGET_CPU=`echo ${ARCH} | tr '[a-z]' '[A-Z]'` COMPILER=g++ YANEURAOU_EDITION=${YANEURAOU_EDITION} 2>&1) >> ../../YaneuraOu.build.log

        mkdir -p ${TARGET_DIR}/engine/${PACKAGE_NAME}
        OUT=${TARGET_DIR}/engine/${PACKAGE_NAME}/${BASE}_${ARCH}.exe
        cp YaneuraOu-by-gcc ${OUT}
        chmod 755 ${OUT}
    done
    popd >& /dev/null

    cp -p ${ENGINE_DEFINES}/${PACKAGE_NAME}/engine_define.xml ${TARGET_DIR}/engine/${PACKAGE_NAME}/
    if [ -e ${ENGINE_DEFINES}/${PACKAGE_NAME}/engine_options.txt ]; then
        cp -p ${ENGINE_DEFINES}/${PACKAGE_NAME}/engine_options.txt ${TARGET_DIR}/engine/${PACKAGE_NAME}/
    fi
    echo -n ") " 1>&2
}

function build_yaneuraou() {
    local BUILD_DIR=$1
    local REPOS=$2
    local VERSION=$3
    local ARCHLIST=$4
    local TARGET_DIR=$5
    local ENGINE_DEFINES=$6
    #local PATCH=$7

    echo -n "やねうら王をビルドしています(少し時間がかかります) ... " 1>&2
    pushd ${BUILD_DIR} >& /dev/null

    git clone ${REPOS} YaneuraOu >& YaneuraOu.build.log
    pushd YaneuraOu >& /dev/null
    (git checkout ${VERSION} 2>&1) >> ../YaneuraOu.build.log
    # やねうら王のスレッド起動に pthread を使うようにする野良パッチ
    # https://note.com/jnory/n/n76c31464e26b
    #patch -p1 < ${PATCH}
    popd >& /dev/null

    compile_yaneuraou YaneuraOu tanuki_wcsc29 YANEURAOU_ENGINE_NNUE YaneuraOuNNUE $ARCHLIST ${TARGET_DIR} ${ENGINE_DEFINES}
    # compile_yaneuraou YaneuraOu yomita2018 YANEURAOU_2018_OTAFUKU_ENGINE_KPPT YaneuraOu2018KPPT ${TARGET_DIR} ${ENGINE_DEFINES}
    # compile_yaneuraou YaneuraOu yaneuraou2018 YANEURAOU_2018_OTAFUKU_ENGINE_KPP_KKPT Yaneuraou2018_kpp_kkpt ${TARGET_DIR} ${ENGINE_DEFINES}
    compile_yaneuraou YaneuraOu tanuki_mate MATE_ENGINE tanuki_mate $ARCHLIST ${TARGET_DIR} ${ENGINE_DEFINES}

    echo "... 完了" 1>&2
    popd >& /dev/null
}

function build_soundplayer() {
    local BUILD_DIR=$1
    local REPOS=$2
    local VERSION=$3
    local MAKE_TARGET=$4
    local OS=$5
    local TARGET_DIR=$6
    local EXT=$7

    echo -n "SoundPlayerをビルドしています ... " 1>&2

    pushd ${BUILD_DIR} >& /dev/null

    git clone --recursive ${REPOS} SoundPlayer >& SoundPlayer.build.log
    pushd SoundPlayer >& /dev/null
    (git checkout ${VERSION} 2>&1) >> ../SoundPlayer.build.log
    (make ${MAKE_TARGET} 2>&1) >> ../SoundPlayer.build.log
    cp -p SoundPlayer/bin/${OS}/SoundPlayer.exe ${TARGET_DIR}
    cp -p SoundPlayer/bin/${OS}/libwplay.${EXT} ${TARGET_DIR}
    popd >& /dev/null

    popd >& /dev/null

    echo "完了" 1>&2
}

