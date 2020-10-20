#!/bin/bash

# rust
if ! (dpkg -l | grep rustc >& /dev/null); then
    echo "NG" 1>&2
    echo "下記コマンドを実行して、rustc をインストールしてください:"
    echo "    $ sudo apt install rustc"
    exit 1
fi

# git
echo -n "git ... " 1>&2
if ! (git --version >& /dev/null); then
    echo "NG" 1>&2
    exit 1
fi

