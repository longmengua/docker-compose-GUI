#!/bin/sh

# AdminMongo GUI port
ADMINMONGO_PORT=1234

# Remove existing AdminMongo container if it exists
docker rm -f adminmongo 2>/dev/null

# Run AdminMongo with explicit platform
docker run -d \
  --platform linux/amd64 \
  --name adminmongo \
  -p ${ADMINMONGO_PORT}:1234 \
  -e HOST=0.0.0.0 \
  --restart unless-stopped \
  mrvautin/adminmongo
