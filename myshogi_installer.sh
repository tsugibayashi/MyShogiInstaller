#!/bin/bash

### functions
# function print_usage() {{{
function print_usage() {
    echo "使い方: " 1>&2
    echo "${0} <操作>" 1>&2
    echo "<操作>:" 1>&2
    echo "    all                  : 全てインストールする (思考エンジンはtanuki-のみインストールする)" 1>&2
    echo "    option               : 追加インストール可能な思考エンジンを表示" 1>&2
    echo "    MyShogi              : MyShogiのインストール" 1>&2
    echo "    engine-tanuki-wcso1  : 外部思考エンジン(tanuki- WCSO1版) のインストール (やねうら王NNUEを使用)" 1>&2
    echo "    eval-tanuki-wcso1    : 評価関数(tanuki- WCSO1版) のインストール" 1>&2
    echo "    engine-YaneuraOu-mate: やねうら王 詰将棋エンジンのインストール" 1>&2
    echo "    YaneuraOu_std_book   : やねうら王 標準定跡のインストール" 1>&2
    echo "    YaneuraOu_large_book : やねうら王 大定跡のインストール" 1>&2
    echo "    YaneuraOu_true_book  : 真やねうら王 定跡のインストール" 1>&2
    echo "    MyShogiSoundPlayer   : SoundPlayerのインストール" 1>&2
    echo "    MyShogiImages-ts     : 画像データ(tsugibayashi)のインストール" 1>&2
    echo "    MyShogiSound         : 音声データのインストール" 1>&2
}
# }}}
# function print_option () {{{
function print_option () {
    echo "下記ソフトウェアはオプション" 1>&2
    echo "[水匠3]" 1>&2
    echo "      engine-Suisho3 : 外部思考エンジン(水匠3) のインストール (やねうら王NNUEを使用)" 1>&2
    echo "      eval-Suisho3   : 評価関数(水匠3) のインストール" 1>&2
    echo "[Qhapaq WCSO1版]" 1>&2
    echo "      engine-Qhapaq-wcso1 : 外部思考エンジン(Qhapaq WCSO1版) のインストール (やねうら王NNUE-HalfKPE9を使用)" 1>&2
    echo "      eval-Qhapaq-wcso1   : 評価関数(Qhapaq WCSO1版) のインストール" 1>&2
    echo "[名人コブラ WCSO1版]" 1>&2
    echo "      engine-meijin_cobra-wcso1 : 外部思考エンジン(名人コブラ WCSO1版) のインストール (やねうら王NNUEを使用)" 1>&2
    echo "      eval-meijin_cobra-wcso1   : 評価関数(名人コブラ WCSO1版) のインストール" 1>&2
    echo "[Sylwi WCSO1版]" 1>&2
    echo "      engine-Sylwi-wcso1  : 外部思考エンジン(Sylwi WCSO1版) のインストール (やねうら王NNUE-HalfKPE9を使用)" 1>&2
    echo "      eval-Sylwi-wcso1    : 評価関数(Sylwi WCSO1版) のインストール" 1>&2
    echo "[Apery WCSC30版]" 1>&2
    echo "      Apery-wcsc30 : Apery WCSC30版 の思考エンジンと評価関数のインストール" 1>&2
    echo "[orqha1018]" 1>&2
    echo "      engine-orqha1018 : 外部思考エンジン(orqha1018) のインストール (やねうら王NNUEを使用)" 1>&2
    echo "      eval-orqha1018   : 評価関数(orqha1018) のインストール" 1>&2
    echo "[shinderella Version:Cute]" 1>&2
    echo "      engine-shinderella-Cute : 外部思考エンジン(shinderella Version:Cute) のインストール (やねうら王NNUEを使用)" 1>&2
    echo "      eval-shinderella-Cute   : 評価関数(shinderella Version:Cute) のインストール" 1>&2
    echo "[shinderella Version:Cool]" 1>&2
    echo "      engine-shinderella-Cool : 外部思考エンジン(shinderella Version:Cool) のインストール (やねうら王NNUEを使用)" 1>&2
    echo "      eval-shinderella-Cool   : 評価関数(shinderella Version:Cool) のインストール" 1>&2
    echo "[tanuki- WCSC29版]" 1>&2
    echo "      engine-tanuki-wcsc29 : 外部思考エンジン(tanuki- WCSC29版) のインストール (やねうら王NNUEを使用)" 1>&2
    echo "      eval-tanuki-wcsc29   : 評価関数(tanuki- WCSC29版) のインストール" 1>&2
    echo "[Kristallweizen改 V0.4]" 1>&2
    echo "      engine-Kristallweizen-kaiV0.4 : 外部思考エンジン(Kristallweizen改V0.4) のインストール (やねうら王NNUEを使用)" 1>&2
    echo "      eval-Kristallweizen-kaiV0.4   : 評価関数(Kristallweizen改V0.4) のインストール" 1>&2
    echo "[水匠U(二枚落ち特化)]" 1>&2
    echo "      engine-SuishoU : 外部思考エンジン(水匠U) のインストール (やねうら王NNUEを使用)" 1>&2
    echo "      eval-SuishoU   : 評価関数(水匠U) のインストール" 1>&2
    echo "[やねうら王NNUE(KP256)]" 1>&2
    echo "      engine-YaneuraOu-nnue-kp256 : 外部思考エンジン(やねうら王NNUE(KP256)) のインストール" 1>&2
    echo "      eval-YaneuraOu-nnue-kp256   : 評価関数(やねうら王NNUE(KP256)) のインストール" 1>&2
    echo "[やねうら王MATERIAL(Level1)]" 1>&2
    echo "      engine-YaneuraOu-material1  : 外部思考エンジン(やねうら王MATERIAL Level1) のインストール" 1>&2
    echo "----------------------------------------------------------------" 1>&2
    echo "以降のソフトウェアは不要 (旧バージョンで使用していたもの)" 1>&2
    echo "    YaneuraOu_700t_book  : やねうら王 700テラショック定跡のインストール" 1>&2
    echo "    MyShogiImages-jnory  : 画像データ(jnory)のインストール" 1>&2
    echo "    engine-Suisho2-wcso1 : 外部思考エンジン(水匠2 WCSO1版) のインストール (やねうら王NNUEを使用)" 1>&2
    echo "    eval-Suisho2-wcso1   : 評価関数(水匠2 WCSO1版) のインストール" 1>&2
    echo "    engine-tanuki-mate   : tanuki-詰将棋エンジンのインストール" 1>&2
}
# }}}

set -e

### variables
#INSTALL_PACKAGES="MyShogi engine-tanuki-wcsc29 eval-tanuki-wcsc29 YaneuraOu_std_book YaneuraOu_large_book YaneuraOu_true_book YaneuraOu_700t_book engine-tanuki-mate MyShogiSoundPlayer MyShogiImages-jnory MyShogiSound"
#INSTALL_PACKAGES="MyShogi engine-tanuki-wcso1 eval-tanuki-wcso1 YaneuraOu_std_book YaneuraOu_large_book YaneuraOu_true_book engine-tanuki-mate MyShogiSoundPlayer MyShogiImages-jnory MyShogiImages-ts MyShogiSound"
#INSTALL_PACKAGES="MyShogi engine-tanuki-wcso1 eval-tanuki-wcso1 YaneuraOu_std_book YaneuraOu_large_book YaneuraOu_true_book engine-tanuki-mate MyShogiSoundPlayer MyShogiImages-ts MyShogiSound"
INSTALL_PACKAGES="MyShogi engine-tanuki-wcso1 eval-tanuki-wcso1 YaneuraOu_std_book YaneuraOu_large_book YaneuraOu_true_book engine-YaneuraOu-mate MyShogiSoundPlayer MyShogiImages-ts MyShogiSound"

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
    # オプションのソフトウェアを表示
    option)
        print_option
    ;;
    # 特定のソフトウェアまたは特定のデータをインストールする
    *)
        ${BASEDIR}/packages/${ACTION}/pkgfile.sh
    ;;
esac

