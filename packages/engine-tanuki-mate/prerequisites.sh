#!/bin/bash

# 変数の読み込み
COMPILER=$1

# cmake
if ! (cmake --version >& /dev/null); then
    echo "NG" 1>&2
    echo "下記コマンドを実行して、cmake をインストールしてください:"
    echo "    $ sudo apt install cmake"
    exit 1
fi

# make
if ! (make --version >& /dev/null); then
    echo "NG" 1>&2
    exit 1
fi

# git
if ! (git --version >& /dev/null); then
    echo "NG" 1>&2
    exit 1
fi

# compiler
if ! ($COMPILER --version >& /dev/null); then
    echo "NG" 1>&2
    case $COMPILER in
        g++-9)
            echo "下記コマンドを実行して、g++-9 をインストールしてください:"
            echo "    $ sudo add-apt-repository ppa:ubuntu-toolchain-r/test"
            echo "    $ sudo apt install build-essential g++-9 libomp-8-dev libopenblas-dev"
        ;;
        clang++)
            echo "下記コマンドを実行して、clang をインストールしてください:"
            echo "    $ sudo apt install clang"
        ;;
    esac
    exit 1
fi

