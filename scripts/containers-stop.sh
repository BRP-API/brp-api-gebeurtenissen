#!/bin/bash

docker compose \
    -f ./.docker/axon-server.yml \
    -f ./.docker/gebeurtenissen-publiceren-service.yml \
    down
