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
    echo "    engine_tanuki_wcsc29 : 外部思考エンジン(tanuki- WCSC29版) のインストール (やねうら王NNUEを使用)" 1>&2
    echo "    eval_tanuki_wcsc29   : 評価関数(tanuki- WCSC29版) のインストール" 1>&2
    echo "    YaneuraOu_std_book   : やねうら王 標準定跡のインストール" 1>&2
    echo "    YaneuraOu_large_book : やねうら王 大定跡のインストール" 1>&2
    echo "    YaneuraOu_true_book  : 真やねうら王 定跡のインストール" 1>&2
    echo "    YaneuraOu_700t_book  : やねうら王 700テラショック定跡のインストール" 1>&2
    echo "    engine_tanuki_mate   : tanuki-詰将棋エンジンのインストール" 1>&2
    echo "    MyShogiSoundPlayer   : SoundPlayerのインストール" 1>&2
    echo "    MyShogiImages        : 画像データのインストール" 1>&2
    echo "    MyShogiSound         : 音声データのインストール" 1>&2
}
# }}}

set -e

### variables
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
        for i in prerequisites MyShogi engine_tanuki_wcsc29 eval_tanuki_wcsc29 YaneuraOu_std_book YaneuraOu_large_book YaneuraOu_true_book YaneuraOu_700t_book engine_tanuki_mate MyShogiSoundPlayer MyShogiImages MyShogiSound ; do
            ${BASEDIR}/packages/$i/pkgfile.sh
        done
    ;;
    # 特定のソフトウェアまたは特定のデータをインストールする
    *)
        ${BASEDIR}/packages/${ACTION}/pkgfile.sh
    ;;
esac

