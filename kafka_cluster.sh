#!/bin/bash

# 檢查 zookeeper 是否存在並啟動中
if ! docker ps --format '{{.Names}}' | grep -q '^zookeeper$'; then
  echo "[❌] Zookeeper container not running. Please start it first."
  exit 1
fi

start_kafka() {
  name=$1
  id=$2
  port1=$3
  port2=$4
  volume=$5

  if docker ps -a --format '{{.Names}}' | grep -q "^$name$"; then
    echo "[⚠️ ] Kafka broker '$name' already exists. Skipping..."
    return
  fi

  echo "[🚀] Starting Kafka broker $name (ID=$id)..."

  docker run -d \
    --name $name \
    --link zookeeper \
    -e KAFKA_BROKER_ID=$id \
    -e KAFKA_ZOOKEEPER_CONNECT=localhost:2181 \
    -e KAFKA_LISTENER_SECURITY_PROTOCOL_MAP=PLAINTEXT:PLAINTEXT,PLAINTEXT_HOST:PLAINTEXT \
    -e KAFKA_LISTENERS=PLAINTEXT://0.0.0.0:$port1,PLAINTEXT_HOST://0.0.0.0:$port2 \
    -e KAFKA_ADVERTISED_LISTENERS=PLAINTEXT://$name:$port1,PLAINTEXT_HOST://localhost:$port2 \
    -e KAFKA_OFFSETS_TOPIC_REPLICATION_FACTOR=1 \
    -p $port1:$port1 \
    -p $port2:$port2 \
    -v $volume:/data \
    confluentinc/cp-kafka
}

# 啟動三個 Kafka brokers
docker rm -f kafka1 kafka2 kafka3
start_kafka kafka1 1 19093 29093 kafka1_data
start_kafka kafka2 2 19094 29094 kafka2_data
start_kafka kafka3 3 19095 29095 kafka3_data

echo "[✅] All Kafka brokers launched (if not already running)."
