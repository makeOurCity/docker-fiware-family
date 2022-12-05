# STH-Comet の動作確認

https://fiwaretourguide.letsfiware.jp/generating-historical-context-information-sth-comet/how-to-generate-the-history-of-Context-Information-using-STH-Comet/

## サブスクリプションの登録

```console
$ curl -X "POST" "http://localhost:1026/v2/subscriptions" \
     -H 'Fiware-Service: ushio_test' \
     -H 'Authorization: ' \
     -H 'Content-Type: application/json; charset=utf-8' \
     -d $'{
  "subject": {
    "entities": [
      {
        "idPattern": ".*"
      }
    ]
  },
  "notification": {
    "http": {
      "url": "http://sth-comet:8666/notify"
    },
    "attrsFormat": "legacy"
  },
  "description": "STH-Comet"
}'


HTTP/1.1 201 Created
Connection: close
Content-Length: 0
Location: /v2/subscriptions/634fc1568e6a0466f21d45c3
Fiware-Correlator: 422f2f8c-4f8f-11ed-8429-0242ac1f0007
Date: Wed, 19 Oct 2022 09:20:22 GMT
```

Orionでentityを操作

```console
$ curl -X "POST" "http://localhost:1026/v2/entities" \
     -H 'Authorization: ' \
     -H 'Fiware-Service: ushio_test' \
     -H 'Content-Type: application/json; charset=utf-8' \
     -d $'{
  "id": "Car1",
  "speed": {
    "type": "Number",
    "value": "1"
  },
  "type": "Car",
  "name": {
    "type": "String",
    "value": "store-name"
  }
}'

```

```console
$ curl -X "PUT" "http://localhost:1026/v2/entities/Car1/attrs/speed/value" \
     -H 'Authorization: ' \
     -H 'Fiware-Service: ushio_test' \
     -H 'Content-Type: text/plain; charset=utf-8' \
     -d "200"
```
