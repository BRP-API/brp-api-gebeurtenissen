#!/bin/bash

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../../.." && pwd)"
INPUT_SPEC="specificaties/abonnementen-en-bevragen/resolved/openapi.yaml"
OUTPUT_DIR="src/clients/go/generated"
IMAGE="openapitools/openapi-generator-cli:v7.22.0"
GENERATOR="go"
ADDITIONAL_PROPERTIES="disallowAdditionalPropertiesIfNotPresent=false"

rm -rf "$REPO_ROOT/$OUTPUT_DIR"

docker run --rm \
  --volume "$REPO_ROOT:/local" \
  -w /local \
  "$IMAGE" generate \
  -i "/local/$INPUT_SPEC" \
  -g "$GENERATOR" \
  --additional-properties "$ADDITIONAL_PROPERTIES" \
  -o "/local/$OUTPUT_DIR"
