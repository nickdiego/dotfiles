#!/usr/bin/env bash

set -e

proj_query=$1;

for id in $(docker ps -q); do
    if docker inspect $id | jq '.[0].Config.Env' | grep "CI_PROJECT_PATH=.*$proj_query" >/dev/null; then
        docker logs --follow $id
        exit 0
    fi
done

echo "Container for project '$proj_query'!"
