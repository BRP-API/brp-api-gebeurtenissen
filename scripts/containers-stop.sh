#!/bin/bash

docker compose \
    -f ./.docker/axon.yml \
    -f ./.docker/db.yml \
    -f ./.docker/keycloak.yml \
    down -v
