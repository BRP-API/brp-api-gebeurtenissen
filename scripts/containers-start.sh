#!/bin/bash

docker compose \
    -f ./.docker/axon-server.yml \
    -f ./.docker/db.yml \
    -f ./.docker/gebeurtenissen-publiceren-service.yml \
    -f ./.docker/gebeurtenissen-bevragen-service.yml \
    -f ./.docker/gebeurtenissen-mutatie-service.yml \
    -f ./.docker/gebeurtenissen-abonneren-service.yml \
    -f ./.docker/keycloak.yml \
    up -d
