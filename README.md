# Docker FIWARE Family

# Getting Started

## Using Docker

### 1. 事前準備

データベースの初期化を以下のコマンドで行う。

```console
$ docker compose up -d postgresql # postgresql の起動を待ってください
...

$ docker compose run --rm kong kong migrations bootstrap # kongに必要な情報の作成
```

### 2. 各種サービス起動

```console
$ make serve
```

### 3. kongaの設定

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

| name      | value                         | description                                                       |
| :-------- | :---------------------------- | :---------------------------------------------------------------- |
| Name / ID | OrionRoot                     | 追加するルートの名前。任意の値                                    |
| Paths     | /orion                        | upstreamであるサービスのOrionをどのパスの下に追加するかを指定する |
| Protocols | http, https                   |                                                                   |
| Methods   | GET, POST, PUT, PATCH, DELETE | upstreamに通すHTTP Methods を指定する。                           |

以上の設定で、 `/orion` 以下は Orionにリクエストが流されるようになります。

#### 参考
- https://qiita.com/nsuhara/items/a0de75e6767f98cc8fec)
- https://qiita.com/popy1017/items/0c5a135c852766330973

### orionの確認

```console
$ curl http://localhost:18000/orion/version
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
