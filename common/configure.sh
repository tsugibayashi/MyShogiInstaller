#!/bin/bash

####### ディレクトリの設定 #######
# インストール先
DESTDIR=$HOME/MyShogi
# 作業用ディレクトリ
WORKDIR=$HOME/MyShogi/work

####### ダウンロード元の設定 #######
MYSHOGI_REPOS=https://github.com/yaneurao/MyShogi.git
MYSHOGI_VERSION=c3300bb1b8a92d22ed6549ac4179c1413911eb4f     #May 21, 2020
#MYSHOGI_VERSION=03f4c8c56546ac4685048bcdcf68f83440b1f3cb    #Feb  9, 2020
#MYSHOGI_VERSION=77ca6b71b65e1203dde9f17d124c40340c1f981f    #Jan 28, 2020
#MYSHOGI_VERSION=3a9e7b17b8a6daa809bfce391c68bec88c4302c4    #Nov 28, 2018
MYSHOGI_PATCH=MyShogi.patch

YANEURAOU_REPOS=https://github.com/yaneurao/YaneuraOu.git
YANEURAOU_VERSION=e69d268ca7cb65b376d83fc800cea4a04c9e1730   #Jun  1, 2020 (V4.91)
#YANEURAOU_VERSION=42de5c6cbbfb6bca55a4d7e3d91a8620a4596466  #May 28, 2020 (V4.90)
#YANEURAOU_VERSION=e99d2fc7c05489935badeb066de514a1ae2bcb1e  #Feb 28, 2020 (V4.89)
#YANEURAOU_VERSION=8a56754f48776bb487942f8e283de334bd4e9888  #Jun 25, 2019 (V4.88)
YANEURAOU_ARCHLIST="avx2"
#YANEURAOU_ARCHLIST="avx2,sse42"
#YANEURAOU_ARCHLIST="avx2,sse42,sse41,sse2"

SOUNDPLAYER_REPOS=https://github.com/jnory/MyShogiSoundPlayer.git
SOUNDPLAYER_VERSION=2d3c08ef33a9f951aaef366aaa3cc7d5094aa8d7

IMAGES_REPOS=https://github.com/jnory/MyShogiImages.git
IMAGES_VERSION=2b53ec8653509c97e9717d1bf485b7e9027ce163

SOUND_REPOS=https://github.com/matarillo/MyShogiSound.git
SOUND_VERSION=3b192b0c6797e217ae3472196570071c19a25550

URL_EVALUATION_FUNCTION="https://github.com/nodchip/tanuki-/releases/download/tanuki-wcsc29-2019-05-06/tanuki-wcsc29-2019-05-06.7z"
URL_STANDARD_BOOK="https://github.com/yaneurao/YaneuraOu/releases/download/v4.73_book/standard_book.zip"
URL_YANEURA_BOOK1="https://github.com/yaneurao/YaneuraOu/releases/download/v4.73_book/yaneura_book1_V101.zip"
URL_YANEURA_BOOK3="https://github.com/yaneurao/YaneuraOu/releases/download/v4.73_book/yaneura_book3.zip"
URL_700T_SHOCK_BOOK="https://github.com/yaneurao/YaneuraOu/releases/download/BOOK-700T-Shock/700T-shock-book.zip"

