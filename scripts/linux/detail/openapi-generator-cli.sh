#!/bin/bash

source_path="$1"
shift
target_path="$1"
shift
echo
docker run --rm -v $source_path:$target_path openapitools/openapi-generator-cli "$@"
