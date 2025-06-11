#!/bin/bash

docker run -d \
  --name elasticsearch \
  -p 9200:9200 \
  -e discovery.type=single-node \
  -e xpack.security.enabled=false \
  -e xpack.security.transport.ssl.enabled=false \
  -e bootstrap.memory_lock=true \
  -e ES_JAVA_OPTS="-Xms512m -Xmx512m" \
  --ulimit memlock=-1:-1 \
  -v elasticsearch_data:/usr/share/elasticsearch/data \
  docker.elastic.co/elasticsearch/elasticsearch:8.13.4
