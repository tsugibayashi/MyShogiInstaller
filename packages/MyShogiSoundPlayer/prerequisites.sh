#!/bin/bash

# git
if ! (git --version >& /dev/null); then
    echo "NG" 1>&2
    exit 1
fi

# make
if ! (make --version >& /dev/null); then
    echo "NG" 1>&2
    exit 1
fi

# libpulse-dev
if ! (dpkg -l | grep libpulse-dev >& /dev/null); then
    echo "NG" 1>&2
    echo "下記コマンドを実行して、libpulse-dev をインストールしてください:"
    echo "    $ sudo apt install libpulse-dev"
    exit 1
fi

