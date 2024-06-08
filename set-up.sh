#!/bin/bash

DELAY=5

echo "Stopping containers"
docker stop $(docker ps -aqf name=mongo-rs)

echo "Clean docker data"
docker system prune -af --volumes

echo "Up infrastructure"
docker compose up -d

echo "****** Waiting for ${DELAY} seconds for containers to go up ******"
PRIMARY_REPLICA_CONTAINER_ID=$(docker ps -qf name=rs1$)
echo "Primary replica container id: $PRIMARY_REPLICA_CONTAINER_ID"

sleep $DELAY
echo "Set up replicas config"
docker exec $PRIMARY_REPLICA_CONTAINER_ID sh -c "mongosh < /scripts/init-replicas.js"

sleep 10
echo "Create admin user"
docker exec $PRIMARY_REPLICA_CONTAINER_ID sh -c "mongosh < /scripts/init-admin-user.js"
