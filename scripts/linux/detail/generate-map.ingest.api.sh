#!/bin/bash

script_dir=$(realpath $(dirname $0))
project_dir=$(realpath ${script_dir}/../../..)
docker_dir="/input"
mkdir -p "$project_dir/gen/$1/stargazer-open-api/map-ingest"
params="generate -i $docker_dir/openapi/stargazer-open-api/map.ingest/map.ingest.yaml \
                 -g $1 \
                 -o $docker_dir/gen/$1/stargazer-open-api/map-ingest"

$script_dir/openapi-generator-cli.sh $project_dir $docker_dir $params
