#!/bin/bash

### Working directory must be the directory of this script
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$SCRIPT_DIR"

### Variables
. services-versions.sh
. services-list.sh

### Ensure .env.local files exist
find . -type f -name "*.env" -exec touch {}.local \;

### Start services
docker-compose -p $DOCKER_DEVSVC_PROJECT $DOCKER_DEVSVC_COMPOSE_FILES up -d
