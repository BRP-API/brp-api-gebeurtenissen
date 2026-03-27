#!/bin/bash

docker compose \
    -f ./.docker/gebeurtenissen-mutatie-service.yml \
    -f ./.docker/gebeurtenissen.yml \
    up -d
