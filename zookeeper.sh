#!/bin/bash
docker rm -f zookeeper
docker run -d \
  --name zookeeper \
  -e ZOOKEEPER_CLIENT_PORT=2181 \
  -e ZOOKEEPER_TICK_TIME=2000 \
  -p 2181:2181 \
  -p 2888:2888 \
  -p 3888:3888 \
  -v zookeeper_data:/data \
  confluentinc/cp-zookeeper
