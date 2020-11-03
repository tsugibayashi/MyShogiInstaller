#!/bin/bash

### インストール先ディレクトリ
DESTDIR=$HOME/MyShogi

### 作業用ディレクトリ
WORKDIR=$HOME/MyShogi/work

### インストールログ出力ディレクトリ
LOGDIR=$HOME/MyShogi/work/log

### やねうら王のビルド対象のCPU拡張命令
ARCHLIST="avx2"
#ARCHLIST="avx2,sse42"
#ARCHLIST="avx2,sse42,sse41,sse2"
#ARCHLIST="avx2,sse42,sse41,ssse3,sse2"

### やねうら王のビルドで使用するコンパイラ
COMPILER=g++-9
#COMPILER=g++
#COMPILER=clang++

