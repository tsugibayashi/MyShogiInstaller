#!/bin/bash

# functions
# function check_prerequisites() {{{
function check_prerequisites() {
    echo "必要なコマンドがインストールされているか確認しています" 1>&2

    echo -n "mono ... " 1>&2
    if [[ ! `which mono` ]]; then
        echo "NG" 1>&2
        echo "下記手順を参考にして、monodevelopをインストールしてください:"
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
        echo "下記コマンドを実行して、cmakeをインストールしてください:"
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
        echo "下記コマンドを実行して、unarをインストールしてください:"
        echo "    $ sudo apt install unar"
        exit 1
    fi
    echo "ok" 1>&2
    echo -n "libpulse-dev ... " 1>&2
    if ! (dpkg -l | grep libpulse-dev >& /dev/null); then
        echo "NG" 1>&2
        echo "下記コマンドを実行して、libpulse-devをインストールしてください:"
        echo "    $ sudo apt install libpulse-dev"
        exit 1
    fi
    echo "ok" 1>&2

    echo -n "xclip ... " 1>&2
    if ! (xclip -version >& /dev/null); then
        echo "NG" 1>&2
        echo "下記コマンドを実行して、xclipをインストールしてください:"
        echo "    $ sudo apt install xclip"
        exit 1
    fi
    echo "ok" 1>&2

    echo "必要なコマンドは揃っているようです" 1>&2
}
# }}}

# main routine
check_prerequisites

