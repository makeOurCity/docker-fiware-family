# STH-Comet の動作確認

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
  "name": {
    "type": "String",
    "value": "store-name"
  },
  "id": "urn:ngsild:Store:001",
  "type": "Store",
  "location": {
    "type": "geo:json",
    "value": {
      "type": "Point",
      "coordinates": [
        13.3986,
        52.5547
      ]
    }
  },
  "address": {
    "type": "PostalAddress",
    "value": {
      "addressLocality": "Prenzlauer Berg",
      "addressRegion": "Berlin",
      "streetAddress": "Bornholmer Straße 65",
      "postalCode": "10439"
    },
    "metadata": {
      "verified": {
        "value": true,
        "type": "Boolean"
      }
    }
  }
}'
```

```console
$ curl -X "PUT" "http://localhost:1026/v2/entities/urn:ngsild:Store:001/attrs/name" \
     -H 'Authorization: ' \
     -H 'Fiware-Service: ushio_test' \
     -H 'Content-Type: application/json; charset=utf-8' \
     -d $'{
  "value": "updated store name1",
  "type": "String"
}'
```
