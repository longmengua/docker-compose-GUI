#!/bin/bash

# 先停止並移除舊容器（如果有的話）
docker rm -f redis-node1 redis-node2 redis-node3 2>/dev/null

# 啟動三個 Redis 節點
docker run -d --name redis-node1 -p 6379:6379 redis:7 redis-server --cluster-enabled yes --cluster-config-file nodes.conf --cluster-node-timeout 1000 --appendonly yes --maxmemory 128mb --maxmemory-policy allkeys-lru
docker run -d --name redis-node2 -p 6380:6379 redis:7 redis-server --cluster-enabled yes --cluster-config-file nodes.conf --cluster-node-timeout 1000 --appendonly yes --maxmemory 128mb --maxmemory-policy allkeys-lru
docker run -d --name redis-node3 -p 6381:6379 redis:7 redis-server --cluster-enabled yes --cluster-config-file nodes.conf --cluster-node-timeout 1000 --appendonly yes --maxmemory 128mb --maxmemory-policy allkeys-lru

echo "等待 Redis 節點啟動中..."
sleep 5

# 抓三個容器的 IP
ip1=$(docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' redis-node1)
ip2=$(docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' redis-node2)
ip3=$(docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' redis-node3)

echo "取得節點 IP:"
echo "redis-node1: $ip1"
echo "redis-node2: $ip2"
echo "redis-node3: $ip3"

# 建立 cluster（不帶複本）
echo "建立 Redis Cluster..."

echo "redis-cli --cluster create $ip1:6379 $ip2:6379 $ip3:6379 --cluster-replicas 0"
docker exec redis-node1 redis-cli --cluster create $ip1:6379 $ip2:6379 $ip3:6379 --cluster-replicas 0

echo "Redis Cluster 已建立"
