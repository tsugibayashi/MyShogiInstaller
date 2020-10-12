#!/bin/bash

### functions
# function check_prerequisites() {{{
function check_prerequisites() {
    echo "必要なコマンドがインストールされているか確認しています" 1>&2

    echo -n "mono ... " 1>&2
    if [[ ! `which mono` ]]; then
        echo "NG" 1>&2
	echo "下記手順を参考にして、monodevelopをインストールせよ:"
	echo "    https://www.monodevelop.com/download/"
        exit 1
    fi
    echo "ok" 1>&2

    echo -n "msbuild ... " 1>&2
    if [[ ! `which msbuild` ]]; then
        echo "NG" 1>&2
        exit 1
    fi
    echo "ok" 1>&2

    echo -n "cmake ... " 1>&2
    if ! (cmake --version >& /dev/null); then
        echo "NG" 1>&2
	echo "下記コマンドを実行して、cmakeをインストールせよ:"
	echo "    $ sudo apt install cmake"
        exit 1
    fi
    echo "ok" 1>&2

    echo -n "make ... " 1>&2
    if ! (make --version >& /dev/null); then
        echo "NG" 1>&2
        exit 1
    fi
    echo "ok" 1>&2

    echo -n "git ... " 1>&2
    if ! (git --version >& /dev/null); then
        echo "NG" 1>&2
        exit 1
    fi
    echo "ok" 1>&2

    echo -n "g++ ... " 1>&2
    if ! (g++ --version >& /dev/null); then
        echo "NG" 1>&2
        exit 1
    fi
    echo "ok" 1>&2

    echo -n "curl ... " 1>&2
    if ! (curl --version >& /dev/null); then
        echo "NG" 1>&2
        exit 1
    fi
    echo "ok" 1>&2

    echo -n "unzip ... " 1>&2
    if ! (unzip -v >& /dev/null); then
        echo "NG" 1>&2
        exit 1
    fi
    echo "ok" 1>&2

    echo -n "unar ... " 1>&2
    if ! (unar -v >& /dev/null); then
        echo "NG" 1>&2
	echo "下記コマンドを実行して、unarをインストールせよ:"
	echo "    $ sudo apt install unar"
        exit 1
    fi
    echo "ok" 1>&2

    echo -n "libpulse-dev ... " 1>&2
    if ! (dpkg -l | grep libpulse-dev >& /dev/null); then
        echo "NG" 1>&2
	echo "下記コマンドを実行して、libpulse-devをインストールせよ:"
	echo "    $ sudo apt install libpulse-dev"
        exit 1
    fi
    echo "ok" 1>&2

    echo -n "xclip ... " 1>&2
    if ! (xclip -version >& /dev/null); then
        echo "NG" 1>&2
	echo "下記コマンドを実行して、xclipをインストールせよ:"
	echo "    $ sudo apt install xclip"
        exit 1
    fi
    echo "ok" 1>&2

    echo "必要なコマンドは揃っているようです" 1>&2
}
# }}}
# function print_usage() {{{
function print_usage() {
    echo "使い方: " 1>&2
    echo "${0} <操作>" 1>&2
    echo "<操作>:" 1>&2
    echo "    0: 実行環境の確認" 1>&2
    echo "    1: MyShogiのビルド" 1>&2
    echo "    2: やねうら王のビルド" 1>&2
    echo "    3: SoundPlayerのビルド" 1>&2
    echo "    4: 画像データのダウンロード" 1>&2
    echo "    5: 音声データのダウンロード" 1>&2
    echo "    6: 評価関数のダウンロード" 1>&2
    echo "    7: 定跡データのダウンロード" 1>&2
}
# }}}

set -e

### variables
# 関数の読み込み
BASEDIR=$(cd `dirname $0`/..; pwd)
. ${BASEDIR}/common/configure.sh
. ${BASEDIR}/common/build.sh
. ${BASEDIR}/common/download.sh

# ACTION: 実行する作業 (0から8まで)
if [ ! $1 ]; then
    print_usage
    exit 1
fi
ACTION=$1

# MyShogi用のディレクトリの作成
if [ ! -d $DESTDIR ]; then
    mkdir -pv $DESTDIR
fi
for dirname in engine eval book html; do
    if [ ! -d $DESTDIR/$dirname ]; then
        mkdir -pv $DESTDIR/$dirname
    fi
done
# MyShogiの作業用ディレクトリの作成
if [ ! -d $WORKDIR ]; then
    mkdir -pv $WORKDIR
fi
# ファイルのコピー
if [ ! -f $DESTDIR/myshogi.sh ]; then
    cp -pv ${BASEDIR}/ubuntu_18.04/resource/myshogi.sh ${DESTDIR}
fi

# main routine
case $ACTION in
    # 実行環境の確認
    0)
        check_prerequisites
    ;;
    # MyShogiのビルド
    1)
        build_myshogi ${WORKDIR} ${MYSHOGI_REPOS} ${MYSHOGI_VERSION} Linux ${DESTDIR} ${BASEDIR}/common/${MYSHOGI_PATCH}
    ;;
    # やねうら王のビルド
    2)
        build_yaneuraou ${WORKDIR} ${YANEURAOU_REPOS} ${YANEURAOU_VERSION} ${YANEURAOU_ARCHLIST} ${DESTDIR} ${BASEDIR}/engine_defines
    ;;
    # SoundPlayerのビルド
    3)
        build_soundplayer ${WORKDIR} ${SOUNDPLAYER_REPOS} ${SOUNDPLAYER_VERSION} linux Linux ${DESTDIR} so
    ;;
    # 画像データのダウンロード
    4)
        download_images ${WORKDIR} ${IMAGES_REPOS} ${IMAGES_VERSION} ${DESTDIR}
    ;;
    # 音声データのダウンロード
    5)
        download_sounds ${WORKDIR} ${SOUND_REPOS} ${SOUND_VERSION} ${DESTDIR}
    ;;
    # 評価関数のダウンロード
    6)
        download_evals ${WORKDIR} ${URL_EVALUATION_FUNCTION} ${BASEDIR}/checksums ${DESTDIR}
    ;;
    # 定跡データのダウンロード
    7)
        download_books ${WORKDIR} ${URL_STANDARD_BOOK} ${BASEDIR}/checksums ${DESTDIR}
        download_books ${WORKDIR} ${URL_YANEURA_BOOK1} ${BASEDIR}/checksums ${DESTDIR}
        download_books ${WORKDIR} ${URL_YANEURA_BOOK3} ${BASEDIR}/checksums ${DESTDIR}
        download_books ${WORKDIR} ${URL_700T_SHOCK_BOOK} ${BASEDIR}/checksums ${DESTDIR}
    ;;
esac

