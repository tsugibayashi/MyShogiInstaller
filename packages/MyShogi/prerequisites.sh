#!/bin/bash

# mono
if [[ ! `which mono` ]]; then
    echo "NG" 1>&2
    echo "下記手順を参考にして mono-devel をインストールしてください:"
    echo "    https://www.mono-project.com/download"
    exit 1
fi

# msbuild
if [[ ! `which msbuild` ]]; then
    echo "NG" 1>&2
    exit 1
fi

# git
if ! (git --version >& /dev/null); then
    echo "NG" 1>&2
    exit 1
fi

# xclip
if ! (xclip -version >& /dev/null); then
    echo "NG" 1>&2
    echo "下記コマンドを実行して、xclip をインストールしてください:"
    echo "    $ sudo apt install xclip"
    exit 1
fi

# fonts-noto
if ! (dpkg -l | grep fonts-noto >& /dev/null); then
    echo "NG" 1>&2
    echo "下記コマンドを実行して、fonts-noto をインストールしてください:"
    echo "    $ sudo apt install fonts-noto"
    exit 1
fi

