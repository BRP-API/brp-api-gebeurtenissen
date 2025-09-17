#!/bin/bash

npx spectral lint ./specificatie/openapi.yaml
npx redocly bundle ./specificatie/openapi.yaml -o ./specificatie/resolved/openapi.json
