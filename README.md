# MyShogiInstaller

## 概要

MyShogi (https://github.com/yaneurao/MyShogi) の独自インストーラーです。

GitHub - jnory/MyShogiInstaller (https://github.com/jnory/MyShogiInstaller) を全面的に改変して作成しました。

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
* fonts-noto (表示するフォントとして使用します)

monodevelopは[公式サイト](https://www.mono-project.com/download)
に書かれた手順を参考にしてインストールして下さい。

g++-9は[レポジトリ](ppa:ubuntu-toolchain-r/test)を使用してインストールします。

    $ sudo add-apt-repository ppa:ubuntu-toolchain-r/test
    $ sudo apt install build-essential g++-9 libomp-8-dev libopenblas-dev

## ビルド手順

(1) 下記から最新のファイル(zipまたはtar.gz)を取得します。

    https://github.com/tsugibayashi/MyShogiInstaller/tags

(2) 取得したファイルを展開し、作成されたディレクトリに移動します。

    $ unzip V1.4.zip
    $ cd MyShogiInstaller-1.4/

(3) ./configure.sh を開き、下記変数を修正します。

| 変数 | 説明 | デフォルト値 |
----|----|----
| DESTDIR | インストール先ディレクトリ | $HOME/MyShogi |
| WORKDIR | 作業用ディレクトリ | $HOME/MyShogi/work |
| LOGDIR | インストールログの出力先 | $HOME/MyShogi/log |

(4) 使用するPC上のCPUがサポートする拡張機能を確認します。

    $ grep flags /proc/cpuinfo | head -1 | grep -E '(avx2|sse4_2|sse4_1|sse2)'

(5) ./packages/engine-tanuki-mate/pkgfile.sh および ./packages/engine-tanuki-wcso1/pkgfile.sh を開き、下記変数を修正します。

| 変数 | 説明 | デフォルト値 |
----|----|----
| ARCHLIST | ビルドするCPU拡張機能の種類 | avx2 |

(6) 以下のコマンドを実行し、MyShogi、および、その関連ファイルをインストールします。

    $ ./myshogi_installer.sh all

## 使い方

    $ cd <インストール先ディレクトリ>
    $ ./myshogi.sh

## engine_define.xmlについて

同梱しているengine_define.xmlは、MyShogiの 設定->外部思考エンジンの利用 を使って生成したものです。
対象CPUには AVX2 のみ指定しています。

その他のCPU (SSE2, SSE4.1, SSE4.2 など) を使用したい場合は、下記手順に従って 独自のengine_define.xml を作成してください。

(1) MyShogiを起動します。

    $ cd <インストール先ディレクトリ>
    $ ./myshogi.sh

(2)  設定->外部思考エンジンの利用 を選択します。

(3) 外部思考エンジンの設定を行います。(対象CPU に使用したいCPUを指定します)

(4) [エンジン定義ファイルの書き出し]をクリックし、engine_define.xml を生成します。

(5) 生成した engine_define.xml を下記ディレクトリにコピーします。

    <インストール先ディレクトリ>/engine/<外部思考エンジン名>/

## ライセンス

GPL v3

## ありそうな質問

### どのようなソフトウェアがインストールされますか？

以下ソフトウェアおよびデータがインストールされます。

* MyShogi (https://github.com/yaneurao/MyShogi)
* やねうら王 NNUE型 思考エンジン (https://github.com/yaneurao/YaneuraOu)
* やねうら王 定跡ファイル (https://github.com/yaneurao/YaneuraOu)
* tanuki- 詰将棋エンジン (https://github.com/yaneurao/YaneuraOu)
* tanuki- WCSO1版 評価関数 (https://github.com/nodchip/tanuki-)
* MyShogiSoundPlayer (https://github.com/jnory/MyShogiSoundPlayer)
* フリーの画像データ (https://github.com/tsugibayashi/MyShogiImages)
* フリーの音声データ (https://github.com/matarillo/MyShogiSound)

また、オプションとして以下ソフトウェアもインストールできます。

* やねうら王 NNUE型(KP256) 思考エンジン (https://github.com/yaneurao/YaneuraOu)
* 魚沼産やねうら王 (https://github.com/yaneurao/YaneuraOu/releases/tag/20190212_k-p-256-32-32)
* Apery WCSC30版 (https://github.com/HiraokaTakuya/apery_rust)
* tanuki- WCSC29版 (https://github.com/nodchip/tanuki-)

### 商用ライセンスを持っているのですが、それらの画像を使用できますか？

MyShogiの画像データを"将棋神 やねうら王"の画像データに置き換えることができるはずです。

ただし、ライセンス的に問題ないかは判断できかねます。

### 不具合に気付きました

このリポジトリにIssueを立ててお知らせ下さい。
なお、このインストーラーはあくまで非公式なものですので、
本家様へのお問い合わせはご遠慮ください。

以上
