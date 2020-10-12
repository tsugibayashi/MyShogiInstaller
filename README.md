# MyShogiInstaller

## 概要

MyShogi (https://github.com/yaneurao/MyShogi) の独自インストーラーです。

GitHub - jnory/MyShogiInstaller (https://github.com/jnory/MyShogiInstaller) を修正して作成しました。

## 対応環境

- Ubuntu 18.04

## 前提作業

MyShogiのビルドを行う前に、以下のパッケージをインストールして下さい。

* monodevelop
* msbuild
* cmake
* make
* git
* build-essential
* g++-9
* libomp-8-dev
* libopenblas-dev
* curl
* unzip
* unar (7zファイルの展開に使用します)
* libpulse-dev
* xclip (ビルドには不要ですが、読み筋のコピーのために必要です)

monodevelopは[公式サイト](https://www.mono-project.com/download)
に書かれた手順を参考にしてインストールして下さい。

g++-9は[レポジトリ](ppa:ubuntu-toolchain-r/test)を使用してインストールします。

    $ sudo add-apt-repository ppa:ubuntu-toolchain-r/test
    $ sudo apt install build-essential g++-9 libomp-8-dev libopenblas-dev

## ビルド手順

1. 使用するPC上のCPUがサポートする拡張機能を確認します。

    $ grep flags /proc/cpuinfo | head -1 | grep -E '(avx2|sse4_2|sse4_1|sse2)'

1. ./common/configure.sh を開き、下記変数を修正します。

  DESTDIR: インストール先ディレクトリ (デフォルト値は $HOME/MyShogi)

  WORKDIR: 作業用ディレクトリ (デフォルト値は $HOME/MyShogi/work)

  YANEURAOU_ARCHLIST: ビルドするCPU拡張機能の種類 (デフォルト値は avx2)

1. 以下の8つのコマンドを実行し、MyShogi、および、その関連ファイルをインストールします。

    $ ./ubuntu_18.04/install.sh 0
    $ ./ubuntu_18.04/install.sh 1
    $ ./ubuntu_18.04/install.sh 2
    $ ./ubuntu_18.04/install.sh 3
    $ ./ubuntu_18.04/install.sh 4
    $ ./ubuntu_18.04/install.sh 5
    $ ./ubuntu_18.04/install.sh 6
    $ ./ubuntu_18.04/install.sh 7

## 使い方

    $ cd <インストール先ディレクトリ>
    $ ./myshogi.sh

## engine_define.xmlについて

同梱しているengine_define.xmlは、MyShogiの 設定->外部思考エンジンの利用 を使って生成したものです。
対象CPUには AVX2 のみ指定しています。

その他のCPU (SSE2, SSE4.1, SSE4.2 など) を使用したい場合は、下記手順に従って 独自のengine_define.xml を作成してください。

1. MyShogiを起動します。

    $ cd <インストール先ディレクトリ>
    $ ./myshogi.sh

1.  設定->外部思考エンジンの利用 を選択します。

1. 外部思考エンジンの設定を行います。(対象CPU に使用したいCPUを指定します)

1. [エンジン定義ファイルの書き出し]をクリックし、engine_define.xml を生成します。

1. 生成した engine_define.xml を <インストール先ディレクトリ>/engine/<外部思考エンジン名>/ にコピーします。

## ライセンス

GPL v3

## ありそうな質問

### どのようなソフトウェアがインストールされますか？

以下ソフトウェアおよびデータがインストールされます。

* MyShogi (https://github.com/yaneurao/MyShogi)
* やねうら王 NNUE版 (https://github.com/yaneurao/YaneuraOu)
* MyShogiSoundPlayer (https://github.com/jnory/MyShogiSoundPlayer)
* フリーの画像データ (https://github.com/jnory/MyShogiImages)
* フリーの音声データ (https://github.com/matarillo/MyShogiSound)

### 商用ライセンスを持っているのですが、それらの画像を使用できますか？

MyShogiの画像データを"将棋神 やねうら王"の画像データに置き換えることができるはずです。
ただし、ライセンス的に問題ないかは判断できかねます。

### 不具合に気付きました

このリポジトリにIssueを立ててお知らせ下さい。
なお、このインストーラーはあくまで非公式なものですので、
本家様へのお問い合わせはご遠慮ください。

以上
