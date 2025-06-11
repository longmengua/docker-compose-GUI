#!/bin/bash

docker run -d \
  --name mysql \
  -e MYSQL_ROOT_PASSWORD=root \
  -e MYSQL_DATABASE=testdb \
  -p 3306:3306 \
  -v mysql_data:/var/lib/mysql \
  mysql:8
