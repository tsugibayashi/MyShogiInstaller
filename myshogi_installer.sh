#!/bin/bash

### functions
# function print_usage() {{{
function print_usage() {
    echo "使い方: " 1>&2
    echo "${0} <操作>" 1>&2
    echo "<操作>:" 1>&2
    echo "    all                  : 全てインストールする" 1>&2
    echo "    prerequisites        : 実行環境の確認" 1>&2
    echo "    MyShogi              : MyShogiのインストール" 1>&2
    echo "    engine-tanuki-wcso1  : 外部思考エンジン(tanuki- WCSO1版) のインストール (やねうら王NNUEを使用)" 1>&2
    echo "    eval-tanuki-wcso1    : 評価関数(tanuki- WCSO1版) のインストール" 1>&2
    echo "    YaneuraOu_std_book   : やねうら王 標準定跡のインストール" 1>&2
    echo "    YaneuraOu_large_book : やねうら王 大定跡のインストール" 1>&2
    echo "    YaneuraOu_true_book  : 真やねうら王 定跡のインストール" 1>&2
    echo "    engine-tanuki-mate   : tanuki-詰将棋エンジンのインストール" 1>&2
    echo "    MyShogiSoundPlayer   : SoundPlayerのインストール" 1>&2
    echo "    MyShogiImages-ts     : 画像データ(tsugibayashi)のインストール" 1>&2
    echo "    MyShogiSound         : 音声データのインストール" 1>&2
    echo "    ----------------------------------------------------------------" 1>&2
    echo "    下記ソフトウェアはオプション" 1>&2
    echo "    engine-YaneuraOu-nnue-kp256 : 外部思考エンジン(やねうら王NNUE(KP256)) のインストール" 1>&2
    echo "    eval-YaneuraOu-nnue-kp256   : 評価関数(やねうら王NNUE(KP256)) のインストール" 1>&2
    echo "    ----------------------------------------------------------------" 1>&2
    echo "    以降のソフトウェアは不要 (旧バージョンで使用していたもの)" 1>&2
    echo "    engine-tanuki-wcsc29 : 外部思考エンジン(tanuki- WCSC29版) のインストール (やねうら王NNUEを使用)" 1>&2
    echo "    eval-tanuki-wcsc29   : 評価関数(tanuki- WCSC29版) のインストール" 1>&2
    echo "    YaneuraOu_700t_book  : やねうら王 700テラショック定跡のインストール" 1>&2
    echo "    MyShogiImages-jnory  : 画像データ(jnory)のインストール" 1>&2
}
# }}}

set -e

### variables
#INSTALL_PACKAGES="prerequisites MyShogi engine-tanuki-wcsc29 eval-tanuki-wcsc29 YaneuraOu_std_book YaneuraOu_large_book YaneuraOu_true_book YaneuraOu_700t_book engine-tanuki-mate MyShogiSoundPlayer MyShogiImages-jnory MyShogiSound"
#INSTALL_PACKAGES="prerequisites MyShogi engine-tanuki-wcso1 eval-tanuki-wcso1 YaneuraOu_std_book YaneuraOu_large_book YaneuraOu_true_book engine-tanuki-mate MyShogiSoundPlayer MyShogiImages-jnory MyShogiImages-ts MyShogiSound"
INSTALL_PACKAGES="prerequisites MyShogi engine-tanuki-wcso1 eval-tanuki-wcso1 YaneuraOu_std_book YaneuraOu_large_book YaneuraOu_true_book engine-tanuki-mate MyShogiSoundPlayer MyShogiImages-ts MyShogiSound"

# $BASEDIR の設定
BASEDIR=$(cd `dirname $0`; pwd)

# ACTION: 実行する作業
if [ ! $1 ]; then
    print_usage
    exit 1
fi
ACTION=$1

# main routine
case $ACTION in
    # 全てインストールする
    all)
        for i in ${INSTALL_PACKAGES}; do
            ${BASEDIR}/packages/$i/pkgfile.sh
        done
    ;;
    # 特定のソフトウェアまたは特定のデータをインストールする
    *)
        ${BASEDIR}/packages/${ACTION}/pkgfile.sh
    ;;
esac

