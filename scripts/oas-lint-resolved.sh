#!/bin/bash

npx redocly lint ./specificaties/abonnementen-service/resolved/openapi.yaml
npx redocly lint ./specificaties/gebeurtenissen-bevragen-service/resolved/openapi.yaml
npx redocly lint ./specificaties/gebeurtenissen-publiceren-service/resolved/openapi.yaml
npx redocly lint ./specificaties/mutatie-service/resolved/openapi.yaml