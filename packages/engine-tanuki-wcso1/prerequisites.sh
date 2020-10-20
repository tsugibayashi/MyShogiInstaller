#!/bin/bash

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

# g++
if ! (g++ --version >& /dev/null); then
    echo "NG" 1>&2
    exit 1
fi
