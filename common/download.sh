#!/bin/bash

function download_file() {
    local URL=$1
    local CHECKSUMS_DIR=$2
    local FILENAME=`echo $URL | sed -e 's/\// /g' | gawk '{print($NF)}'`
    local SHA256=${FILENAME}.sha256

    curl -L ${URL} -O >& /dev/null
    if ! (shasum -a 256 -c ${CHECKSUMS_DIR}/$SHA256 >& /dev/null); then
        echo "ダウンロードしたファイル("$FILENAME")が壊れています" 1>&2
        exit 1
    fi
}

function download_images() {
    local BUILD_DIR=$1
    local REPOS=$2
    local VERSION=$3
    local TARGET_DIR=$4
    local DIRNAME=images

    echo -n "画像データをダウンロードしています ... " 1>&2
    pushd ${BUILD_DIR} >& /dev/null

    # $DIRNAME が存在しないとき、ダウンロードを実行する
    if [ ! -d $DIRNAME ]; then
        git clone ${REPOS} $DIRNAME >& ${DIRNAME}.download.log

        pushd $DIRNAME >& /dev/null
        (git checkout ${VERSION} 2>&1) >> ../${DIRNAME}.download.log

        popd >& /dev/null
        cp -pr $DIRNAME ${TARGET_DIR}/image
    fi

    popd >& /dev/null
    echo "完了" 1>&2
}

function download_sounds() {
    local BUILD_DIR=$1
    local REPOS=$2
    local VERSION=$3
    local TARGET_DIR=$4
    local DIRNAME=Sound

    echo -n "音声データをダウンロードしています ... " 1>&2
    pushd ${BUILD_DIR} >& /dev/null

    # $DIRNAME が存在しないとき、ダウンロードを実行する
    if [ ! -d $DIRNAME ]; then
        git clone ${REPOS} $DIRNAME >& ${DIRNAME}.download.log

        pushd $DIRNAME >& /dev/null
        (git checkout ${VERSION} 2>&1) >> ../${DIRNAME}.download.log
        cp -pr Amazon_Polly_Mizuki_YouTube_AudioLibrary_SoundEffects/sound ${TARGET_DIR}/sound

        popd >& /dev/null
    fi

    popd >& /dev/null
    echo "完了" 1>&2
}

function download_evals() {
    local BUILD_DIR=$1
    local URL=$2
    local CHECKSUMS_DIR=$3
    local TARGET_DIR=$4
    local FILENAME=`echo $URL | sed -e 's/\// /g' | gawk '{print($NF)}'`
    local DIRNAME=`basename $FILENAME .7z`

    echo -n "評価関数ファイルをダウンロードしています ... " 1>&2
    pushd ${BUILD_DIR} >& /dev/null

    # $FILENAME が存在しないとき、ダウンロードを実行する
    if [ ! -f $FILENAME ]; then
        download_file $URL ${CHECKSUMS_DIR}

        unar $FILENAME >& /dev/null
        mkdir -p ${TARGET_DIR}/eval/tanuki_wcsc29
        cp -p ${DIRNAME}/eval/*.bin ${TARGET_DIR}/eval/tanuki_wcsc29
        cp -p ${DIRNAME}/book/user_book2.db ${TARGET_DIR}/book/user_book2.db
    fi

    popd >& /dev/null
    echo "完了" 1>&2
}

function download_books() {
    local BUILD_DIR=$1
    local URL=$2
    local CHECKSUMS_DIR=$3
    local TARGET_DIR=$4
    local FILENAME=`echo $URL | sed -e 's/\// /g' | gawk '{print($NF)}'`
    local FILENAME_WITHOUT_EXT=`basename $FILENAME .zip`

    echo -n "定跡ファイルをダウンロードしています ... " 1>&2
    echo -n $FILENAME' '
    pushd ${BUILD_DIR} >& /dev/null

    # $FILENAME が存在しないとき、ダウンロードを実行する
    if [ ! -f $FILENAME ]; then
        download_file $URL ${CHECKSUMS_DIR}

        case $FILENAME in
            yaneura_book1_V101.zip)
                unzip $FILENAME >& /dev/null
                cp -p yaneura_book1.db ${TARGET_DIR}/book
            ;;
            700T-shock-book.zip)
                LC_ALL=C unzip $FILENAME >& /dev/null
                cp -p user_book1.db ${TARGET_DIR}/book/user_book1.db
            ;;
            *)
                unzip $FILENAME >& /dev/null
                cp -p ${FILENAME_WITHOUT_EXT}.db ${TARGET_DIR}/book
            ;;
        esac
    fi

    popd >& /dev/null
    echo "完了" 1>&2
}

