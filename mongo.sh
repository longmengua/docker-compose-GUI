#!/bin/bash

docker run -d \
  --name mongo \
  -p 27017:27017 \
  -v mongo_data:/data/db \
  mongo:6
