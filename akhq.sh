#!/bin/bash

# 建立網路 (如果還沒建立的話)
docker network inspect kafka-net >/dev/null 2>&1 || docker network create kafka-net

# 啟動 AKHQ container
docker run -d \
  --name akhq \
  --network kafka-net \
  -p 8080:8080 \
  -e AKHQ_CONFIGURATION='
    akhq:
      connections:
        local-kafka:
          properties:
            bootstrap.servers: "localhost:19092,localhost:19093,localhost:19094"
  ' \
  tchiotludo/akhq:0.24.0
