#!/bin/bash
npx nswag openapi2csclient \
  /input:specificatie/resolved/openapi.json \
  /output:specificatie/BrpEventsDtos.cs \
  /GenerateClientClasses:false \
  /GenerateDtoTypes:true \
  /Namespace:Demo.BrpEvents

echo "DTO classes generated at specificatie/BrpEventsDtos.cs"