# Docker FIWARE Family

[![test build](https://github.com/ushios/docker-fiware-family/actions/workflows/test_build.yml/badge.svg)](https://github.com/ushios/docker-fiware-family/actions/workflows/test_build.yml)

# 構成図

<img src="docs/images/MoC_docker_fiware_family.drawio.png" width="700">

編集は [こちら](https://app.diagrams.net/?src=about#G1i-GU5GV1pVsDwISIoY4XM0AxO07Kz9Od) 。編集・閲覧権限は管理者に問い合わせください。

# Getting Started

## ブラウザからアクセス可能な GUI ツール

| name          | URL                   | description                     |
| :------------ | :-------------------- | :------------------------------ |
| Konga         | http://localhost:8080 | kong を管理するためのコンソール |
| mongo-express | http://localhost:8081 | mongodb のデータを見るツール    |

# 開始

## Docker を利用して開始する

### 1. 事前準備

データベースの初期化を以下のコマンドで行う。
これは一度行ったら、初期化などを行わない限り再実行する必要はありません。

```console
$ make build
```

### 2. 各種サービス起動

```console
$ make serve
```

### 3. konga の設定

konga の管理画面にアクセスして admin ユーザーを作成する。
http://localhost:8080

#### 3-1. コネクションを作成

ユーザー作成後に再度ログインを行うと、konga が kong に接続するために必要なコネクションを作成させられるので、以下の情報を入れる。

| name           | value            | description                          |
| :------------- | :--------------- | :----------------------------------- |
| Name           | kong             | 作成するコネクションの名前。任意の値 |
| Kong Admin URL | http://kong:8001 | kong の管理 API の URL               |

### 4. konga での upstream の作成

#### 4-1. サービスを作成

| name | value        | description                      |
| :--- | :----------- | :------------------------------- |
| Name | FIWARE ORION | 作成するサービスの名前。任意の値 |
| Host | orion        | kong の upstream のホスト名      |
| Port | 1026         | orion が listen してるポート     |

#### 4-2. ルートを作成

作成したサービスからルートを追加する

| name      | value                         | description                                                          |
| :-------- | :---------------------------- | :------------------------------------------------------------------- |
| Name / ID | OrionRoot                     | 追加するルートの名前。任意の値                                       |
| Paths     | /orion                        | upstream であるサービスの Orion をどのパスの下に追加するかを指定する |
| Protocols | http, https                   |                                                                      |
| Methods   | GET, POST, PUT, PATCH, DELETE | upstream に通す HTTP Methods を指定する。                            |

以上の設定で、 `/orion` 以下は Orion にリクエストが流されるようになります。

#### 参考

- https://qiita.com/nsuhara/items/a0de75e6767f98cc8fec)
- https://qiita.com/popy1017/items/0c5a135c852766330973

### 5. orion の確認

```console
$ curl http://localhost:8000/orion/version
HTTP/1.1 200 OK
Content-Type: application/json
Content-Length: 740
Connection: close
Fiware-Correlator: 4ce76cb8-4ef5-11ed-9799-0242ac1f0004
Date: Tue, 18 Oct 2022 14:58:18 GMT
X-Kong-Upstream-Latency: 18
X-Kong-Proxy-Latency: 53
Via: kong/3.0.0

{
"orion" : {
  "version" : "3.7.0",
  "uptime" : "0 d, 8 h, 19 m, 31 s",
  "git_hash" : "8b19705a8ec645ba1452cb97847a5615f0b2d3ca",
  "compile_time" : "Thu May 26 11:45:49 UTC 2022",
  "compiled_by" : "root",
  "compiled_in" : "025d96e1419a",
  "release_date" : "Thu May 26 11:45:49 UTC 2022",
  "machine" : "x86_64",
  "doc" : "https://fiware-orion.rtfd.io/en/3.7.0/",
  "libversions": {
     "boost": "1_74",
     "libcurl": "libcurl/7.74.0 OpenSSL/1.1.1n zlib/1.2.11 brotli/1.0.9 libidn2/2.3.0 libpsl/0.21.0 (+libidn2/2.3.0) libssh2/1.9.0 nghttp2/1.43.0 librtmp/2.3",
     "libmosquitto": "2.0.12",
     "libmicrohttpd": "0.9.70",
     "openssl": "1.1",
     "rapidjson": "1.1.0",
     "mongoc": "1.17.4",
     "bson": "1.17.4"
  }
}
}
```

# その他コマンド

```console
# 起動済みのpostgresqlのコンソールに入る。
$  docker compose exec postgresql psql kong
```
