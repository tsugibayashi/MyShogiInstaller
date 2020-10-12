#!/bin/bash

function create_destdir() {
    local dirname

    # MyShogi用のディレクトリの作成
    if [ ! -d $DESTDIR ]; then
        mkdir -pv $DESTDIR
    fi
    
    for dirname in engine eval book html image sound; do
        if [ ! -d $DESTDIR/$dirname ]; then
            mkdir -pv $DESTDIR/$dirname
        fi
    done
}

function create_workdir() {
    # MyShogiの作業用ディレクトリの作成
    if [ ! -d $WORKDIR ]; then
        mkdir -pv $WORKDIR
    fi
}

