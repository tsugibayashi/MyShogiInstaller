#!/bin/bash

# curl
if ! (curl --version >& /dev/null); then
    echo "NG" 1>&2
    exit 1
fi

# unar
if ! (unar -v >& /dev/null); then
    echo "NG" 1>&2
    echo "下記コマンドを実行して、unar をインストールしてください:"
    echo "    $ sudo apt install unar"
    exit 1
fi

