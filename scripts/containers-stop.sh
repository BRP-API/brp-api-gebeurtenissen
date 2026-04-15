#!/bin/bash

docker compose \
    -f ./.docker/axon.yml \
    -f ./.docker/db.yml \
    -f ./.docker/keycloak.yml \
    -f ./.docker/projecties-db.yml \
    -f ./.docker/gebeurtenissen-mutatie-service.yml \
    -f ./.docker/gebeurtenissen.yml \
    down --volumes
