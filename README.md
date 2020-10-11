# MyShogiInstaller

## これは何？

MyShogi (https://github.com/yaneurao/MyShogi) の私家版インストーラーです。

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

(1)使用するPC上のCPUがサポートする拡張機能を確認します。

    $ grep flags /proc/cpuinfo | head -1 | grep -E '(avx2|sse4_2|sse4_1|sse2)'

(2)./common/configure.sh を開き、下記変数を修正します。

  DESTDIR: インストール先ディレクトリ (デフォルト値は $HOME/MyShogi)

  WORKDIR: 作業用ディレクトリ (デフォルト値は $HOME/MyShogi/work)

  YANEURAOU_ARCHLIST: ビルドするCPUの種類 (デフォルト値は avx2)

(3)以下の7つのコマンドを実行し、MyShogiの実行ファイル $DESTDIR/myshogi.sh を生成します。

    $ ./ubuntu/install.sh 0
    $ ./ubuntu/install.sh 1
    $ ./ubuntu/install.sh 2
    $ ./ubuntu/install.sh 3
    $ ./ubuntu/install.sh 4
    $ ./ubuntu/install.sh 5
    $ ./ubuntu/install.sh 6
    $ ./ubuntu/install.sh 7

## 使い方

    $ cd <インストール先ディレクトリ>
    $ ./myshogi.sh

## engine_define.xmlについて

同梱してあるengine_define.xmlは、MyShogiのバイナリから生成させたサンプルXMLを元に改変しています。
生成コードは[ここ](https://github.com/yaneurao/MyShogi/blob/master/MyShogi/Model/Shogi/EngineDefine/Sample/EngineDefineSample.cs)にあります。
棋力設定の名前に段位がありますが、本家様と区別するため先頭に `F` をつけてあります(FreeのF)。
このファイルに記載の段位については実際の棋力と関係ありません。

## ライセンス

GPL v3

## ありそうな質問

### どんな環境ができますか？

以下のものがインストールされます。

* MyShogi ( https://github.com/yaneurao/MyShogi )
* やねうら王 KPP_KKPT版 ( https://github.com/yaneurao/YaneuraOu )
* MyShogiSoundPlayer ( https://github.com/jnory/MyShogiSoundPlayer )
* フリーの画像データ ( https://github.com/jnory/MyShogiImages )
* フリーの音声データ ( https://github.com/matarillo/MyShogiSound )

### 商用ライセンスを持っているのですが、画像などはそちらを使えますか？

Windows版からそれらしきものをご自分でコピーして差し替えて下さい。
(差し替えの手間を考えるとこのインストーラーを使うメリットがどれほどあるかは微妙)

### 不具合に気付きました

このリポジトリにIssueを立ててお知らせ下さい。
なお、このインストーラーはあくまで非公式なものですので、
本家様へのお問い合わせはご遠慮ください。

以上
