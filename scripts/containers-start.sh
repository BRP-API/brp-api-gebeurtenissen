#!/bin/bash

docker compose \
    -f ./.docker/axon-server.yml \
    -f ./.docker/gebeurtenissen-publiceren-service.yml \
    -f ./.docker/gebeurtenissen-bevragen-service.yml \
    up -d
