# JRDB-data/converter

## このレポジトリについて

[JRDB](http://www.jrdb.com/) が提供する各種競馬データを、プログラムでも扱いやすい、文字コード UTF-8 の CSV 形式に変換するためのスクリプトを提供しています。

ファイルのダウンロードには JRDB のメンバーになる必要がありますのでご注意ください。

[JRDB 会員登録ページ](http://www.jrdb.com/order.html)

また、ファイルのダウンロード、解凍に使えるツールを別レポジトリで提供していますので、併せてご利用ください。

[JRDB-data/downloader](https://github.com/JRDB-data/downloader)

このスクリプトを使用すると、以下のような CSV が作成されます。

```
血統登録番号, 馬名, 性別コード, 毛色コード, 馬記号コード, 父馬名, 母馬名, 母父馬名, 生年月日, 父馬生年, 母馬生年, 母父馬生年, 馬主名, 馬主会コード, 生産者名, 産地名, 登録抹消フラグ, データ年月日, 父系統コード, 母父系統コード, 予備
19100151,キリシマミッチー　　　　　　　　　　,2,07,00,ザファクター　　　　　　　　　　　　,ウインヴァネッサ　　　　　　　　　　,アグネスタキオン　　　　　　　　　　,20190303,2008,2008,1998,茂木　道和氏　　　　　　　　　　　　　　,  ,川島牧場　　　　　　　　　　　　　　　　,新冠　　,0,20220320,1106,1206,      ,
19101631,ヴァルドマルヌ　　　　　　　　　　　,2,04,00,ブラックタイド　　　　　　　　　　　,ジャルディナージュ　　　　　　　　　,バーナーディニ　　　　　　　　　　　,20190401,2001,2011,2003,村野　康司氏　　　　　　　　　　　　　　,05,下河辺牧場　　　　　　　　　　　　　　　,日高　　,0,20220320,1206,1311,      ,
```

## 初期設定

### リポジトリのクローン

``` sh
git clone git@github.com:JRDB-data/converter.git
```

### 環境設定

環境変数の管理に `direnv` を使用しています。
お持ちでない方は以下を参考にインストールをお願い致します。

```sh
brew install direnv

## 以下 zsh, .zshrc は自分が使用しているシェルに合わせて適宜変更してください。
echo 'eval "$(direnv hook zsh)"' >> ~/.zshrc
soruce ~/.zshrc
```

.env ファイルを作成して環境変数を定義してください。
以下に必要な環境変数と記載例を示します。

```.env
INPUT_DIRECTORY=${HOME}/dev/JRDB-data/files/downloaded_files/
CONVERT_FILE_OUTPUT_DIRECTORY=${HOME}/dev/JRDB-data/files/converted_files/
```

`INPUT_DIRECTORY` には JRDB よりダウンロードしたテキストファイルの保存先を指定してください。

`CONVERT_FILE_OUTPUT_DIRECTORY` には作成される CSV の保存先をご指定ください。

上記の例のように入力した場合、以下のような形で変換された CSV が作成されます。

```
~/
└── dev
    └── JRDB-data
        └── files
            ├── downloaded_files
            │   └── Bac
            │       └── bac220319.txt <== 別途 JRDB からダウンロードしたファイル を配置してください。
            └── converted_files
                └── Bac
                    └── bac220319.csv <== 変換後のファイルが配置されます。
```

以下のコマンドで環境変数をロードします。

```sh
direnv allow .
```

## スクリプトの使用方法

### 単一のファイルを変換する

データタイプと日付を指定して、指定されたファイルの変換を行います。

データタイプと日付の指定は対話式で行います。

```sh
sh converter.sh
```

初めにデータタイプを入力します。

```sh
Filetype? (ex. Ks)

以下のファイルタイプが選択できます。
===================================
JRDB 騎手データ  : Ks
JRDB 番組データ  : Bac
JRDB 登録馬データ: Kta
JRDB 馬基本データ: Ukc
JRDB 競争馬データ: Kyi
===================================
Bac # <= データタイプを入力
```

次に変換したいファイルの日付を入力します。

```sh
Filedate? (ex. 220319)
yymmdd の形式で入力してください。
220319 # <= 日付を入力
```

指定したディレクトリに変換された CSV が作成されます。

``` sh
❯❯ !(git:main) ~/dev/JRDB-data/files/converted_files/Bac
❯ ls
bac220319.csv
```

なお、現在対応しているのは以下のデータタイプのみです。こちらは今後拡大していく予定です。

- JRDB 騎手データ  : Ks
- JRDB 番組データ  : Bac
- JRDB 登録馬データ: Kta
- JRDB 馬基本データ: Ukc
- JRDB 競争馬データ: Kyi

### 特定の日付のファイルを一括で変換する

``` sh
sh convert_all.sh
```

対話式で日付を指定します。

```sh
Filedate? (ex. 220319)
yymmdd の形式で入力してください。
220319 # <= 日付を入力
```

指定したディレクトリに変換された CSV が作成されます。

```sh
❯❯ !(git:main) ~/dev/JRDB-data/files/converted_files
❯ tree
.
├── Bac
│   └── bac220319.csv
├── Ks
│   └── kza220319.csv
├── Kta
│   └── kta220319.csv
├── Kyi
│   └── kyi220319.csv
└── Ukc
    └── ukc220319.csv
```

なお、現在一括で変換が行われるのは以下のデータタイプのものですが、今後拡張される予定です。

- JRDB 騎手データ  : Ks
- JRDB 番組データ  : Bac
- JRDB 登録馬データ: Kta
- JRDB 馬基本データ: Ukc
- JRDB 競争馬データ: Kyi

## トラブルシューティング

よくあるエラーとその対応方法を以下に記載しています。

[TROUBLESHOOTING.md](./TROUBLESHOOTING.md)

## おわりに

追加して欲しい機能、バグ報告等の issue, PR は常にお待ちしております！
使用方法の質問などもお気軽にお問合せください！
