#!/bin/bash

npx redocly lint ./specificaties/abonnementen-service/openapi.yaml
npx redocly lint ./specificaties/gebeurtenissen-bevragen-service/openapi.yaml
npx redocly lint ./specificaties/gebeurtenissen-publiceren-service/openapi.yaml
npx redocly lint ./specificaties/mutatie-service/openapi.yaml