# MyShogiInstaller

## 概要

MyShogi (https://github.com/yaneurao/MyShogi) の独自インストーラーです。

GitHub - jnory/MyShogiInstaller (https://github.com/jnory/MyShogiInstaller) を全面的に改変して作成しました。

## 対応環境

- Ubuntu 20.04

## 前提作業

MyShogiのビルドを行う前に、以下のパッケージをインストールして下さい。

* mono-devel
* msbuild
* cmake
* make
* git
* build-essential
* コンパイラ (g++, g++-9, clang++ など)
* curl
* unzip
* unar (7zファイルの展開に使用します)
* libpulse-dev
* xclip (ビルドには不要ですが、読み筋のコピーのために必要です)
* fonts-noto (表示するフォントとして使用します)

mono-develは[公式サイト](https://www.mono-project.com/download)や
下記手順を参考にしてインストールして下さい。

(1) 前提パッケージをインストールします。

    $ sudo apt install gnupg ca-certificates

(2) Mono(Stable) のレポジトリを追加します。

    $ sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
    $ echo "deb [arch=amd64] https://download.mono-project.com/repo/ubuntu stable-focal main" | sudo tee /etc/apt/sources.list.d/mono-official-stable.list

(3) レポジトリを更新します。

    $ sudo apt update

(4) mono-devel をインストールします。

    $ sudo apt install mono-devel


## ビルド手順

(1) 下記から最新のファイル(zipまたはtar.gz)を取得します。

    https://github.com/tsugibayashi/MyShogiInstaller/tags

(2) 取得したファイルを展開し、作成されたディレクトリに移動します。

    $ unzip V1.6.zip
    $ cd MyShogiInstaller-1.6/

(3) 使用するPC上のCPUがサポートする拡張機能を確認します。

    $ grep flags /proc/cpuinfo | head -1 | grep -E '(avx512|avx2|sse4_2|sse4_1|ssse3|sse2)'

(4) ./configure.sh を開き、下記変数を修正します。

| 変数 | 説明 | デフォルト値 |
----|----|----
| DESTDIR | インストール先ディレクトリ | $HOME/MyShogi |
| WORKDIR | 作業用ディレクトリ | $HOME/MyShogi/work |
| LOGDIR | インストールログの出力先 | $HOME/MyShogi/log |
| ARCHLIST | ビルドするCPU拡張機能の種類 | avx2 |
| COMPILER | やねうら王のビルドに使用するコンパイラ | g++9 |

(5) 以下のコマンドを実行し、MyShogi、および、その関連ファイルをインストールします。

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

* 水匠3 (https://drive.google.com/u/0/open?id=1GhFMz785Jjb8mUmUD9T7frBHhEM\_7llD)
* やねうら王 NNUE-HalfKPE9型 思考エンジン (https://github.com/tttak/YaneuraOu/)
* Qhapaq WCSO1版 (https://github.com/qhapaq-49/qhapaq-bin)
* 名人コブラ WCSO1版 (https://drive.google.com/file/d/11AlHhwujgSxEoc1yk8wyTFJXQrh9LZ9q/view)
* Sylwi WCSO1版 (https://github.com/mizar/YaneuraOu)
* Apery WCSC30版 (https://github.com/HiraokaTakuya/apery\_rust)
* orqha1018 (https://www.qhapaq.org/shogi/kifdb/)
* shinderella Version:Cute (https://www.qhapaq.org/shogi/kifdb/)
* shinderella Version:Cool (https://www.qhapaq.org/shogi/kifdb/)
* やねうら王 NNUE型(KP256) 思考エンジン (https://github.com/yaneurao/YaneuraOu)
* Kristallweizen改 V0.4 (https://github.com/Tama4649/Kristallweizen/)
* 水匠U(二枚落ち特化) (https://drive.google.com/drive/folders/19Al69YMkJ\_cXSBhtn8df9yfxhn8QFCYo)
* 魚沼産やねうら王 (https://github.com/yaneurao/YaneuraOu/releases/tag/20190212\_k-p-256-32-32)
* やねうら王 MATERIAL型 思考エンジン (https://github.com/yaneurao/YaneuraOu)
* tanuki- WCSC29版 (https://github.com/nodchip/tanuki-)

### 商用ライセンスを持っているのですが、それらの画像を使用できますか？

MyShogiの画像データを"将棋神 やねうら王"の画像データに置き換えることができるはずです。

ただし、ライセンス的に問題ないかは判断できかねます。

### 不具合に気付きました

このリポジトリにIssueを立ててお知らせ下さい。
なお、このインストーラーはあくまで非公式なものですので、
本家様へのお問い合わせはご遠慮ください。

以上
