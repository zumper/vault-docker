#!/bin/bash
VAULT_TOKEN="s.7o7wcens6w6MzYElNhvywacy"
for VAULT_HOST in 1 2 3; do
  docker-compose exec "vault${VAULT_HOST}" /bin/sh -c "export VAULT_TOKEN=${VAULT_TOKEN}" 2>/dev/null
done
VAULT_LEADER=$(docker-compose exec vault1 vault status | grep "HA Cluster" | sed -e 's/.*\(vault[123]\).*/\1/')

while true; do
  docker-compose stop "$VAULT_LEADER"
  sleep 10
  docker-compose start "$VAULT_LEADER"
  VAULT_LEADER=$(docker-compose exec vault2 vault status | grep "HA Cluster" | sed -e 's/.*\(vault[123]\).*/\1/')
  sleep 5
done
