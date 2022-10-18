# Docker FIWARE Family

# Getting Started

## Using Docker

### 1. 事前準備

データベースの初期化を以下のコマンドで行う。

```console
$ make build
```

### 2. 各種サービス起動

```console
$ make serve
```

### 3. kongaの設定

[参考](https://qiita.com/nsuhara/items/a0de75e6767f98cc8fec)

kongaの管理画面にアクセスしてadminユーザーを作成する。
http://localhost:28080

ユーザー作成後に再度ログインを行うと、コネクションを作成させられるので、以下の情報を入れる。

| name           | value            | description                          |
| :------------- | :--------------- | :----------------------------------- |
| Name           | kong             | 作成するコネクションの名前。任意の値 |
| Kong Admin URL | http://kong:8001 | kongの管理APIのURL                   |

### 4. kongaでのupstreamの作成

サービスを作成

| name | value        | description                      |
| :--- | :----------- | :------------------------------- |
| Name | FIWARE ORION | 作成するサービスの名前。任意の値 |
| Host | orion        | kongのupstreamのホスト名         |
| Port | 1026         | orionがlistenしてるポート        |

ルートを作成

作成したサービスからルートを追加する

| name | value | description |
| :--- | :---- | :---------- |
