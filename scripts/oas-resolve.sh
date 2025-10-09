#!/bin/bash

npx redocly bundle ./specificaties/gebeurtenissen-publiceren-service/openapi.yaml -o ./specificaties/gebeurtenissen-publiceren-service/resolved/openapi.yaml
npx redocly bundle ./specificaties/gebeurtenissen-bevragen-service/openapi.yaml -o ./specificaties/gebeurtenissen-bevragen-service/resolved/openapi.yaml