#!/bin/bash

# 建立 redisinsight volume（若尚未存在）
docker volume create redisinsight_data

# 啟動 redisinsight container
docker run -d \
  --name redisinsight \
  -p 5540:5540 \
  -v redisinsight_data:/db \
  redislabs/redisinsight:latest
