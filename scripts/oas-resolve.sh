#!/bin/bash

npx redocly bundle ./specificaties/abonnementen-service/openapi.yaml -o ./specificaties/abonnementen-service/resolved/openapi.yaml
npx redocly bundle ./specificaties/mutatie-service/openapi.yaml -o ./specificaties/mutatie-service/resolved/openapi.yaml
