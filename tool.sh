#!/bin/bash

function create_destdir() {
    local DIRNAME=$1
    local dirname

    # MyShogiのインストール先ディレクトリを作成
    if [ ! -d $DIRNAME ]; then
        mkdir -pv $DIRNAME
    fi
    
    for dirname in engine eval book html image sound; do
        if [ ! -d $DIRNAME/$dirname ]; then
            mkdir -pv $DIRNAME/$dirname
        fi
    done
}

function create_dir() {
    local DIRNAME=$1
    if [ ! -d $DIRNAME ]; then
        mkdir -pv $DIRNAME
    fi
}

function create_dirs() {
    local DESTDIR=$1
    local WORKDIR=$2
    local LOGDIR=$3

    # インストール先ディレクトリの作成
    create_destdir $DESTDIR
    # 作業用ディレクトリの作成
    create_dir $WORKDIR
    # インストールログ出力ディレクトリの作成
    create_dir $LOGDIR
}

