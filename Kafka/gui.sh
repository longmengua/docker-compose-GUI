#!/bin/bash

# 建立 Docker network（如尚未存在）
docker network inspect kafka-net >/dev/null 2>&1 || docker network create kafka-net

# 停止並移除已存在容器
docker rm -f kafka-ui >/dev/null 2>&1

# 啟動 Kafka UI 容器，並設定 Raft 模式的 cluster（無需 Zookeeper）
docker run -d \
  --name kafka-ui \
  --network kafka-net \
  -p 8080:8080 \
  -e KAFKA_CLUSTERS_0_NAME="local-kafka" \
  -e KAFKA_CLUSTERS_0_BOOTSTRAPSERVERS="broker1:19092,broker2:19093,broker3:19094" \
  provectuslabs/kafka-ui:latest

echo "✅ Kafka UI is running"
