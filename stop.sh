#!/bin/bash

### Directory of this script
pushd . > /dev/null
SCRIPT_DIR="${BASH_SOURCE[0]}"
while([ -h "${SCRIPT_DIR}" ]); do
    cd "`dirname "${SCRIPT_DIR}"`"
    SCRIPT_DIR="$(readlink "`basename "${SCRIPT_DIR}"`")"
done
cd "`dirname "${SCRIPT_DIR}"`" > /dev/null
SCRIPT_DIR="`pwd`"
popd  > /dev/null

### Working directory
cd "$SCRIPT_DIR"

### Variables
. services-versions.sh
. services-list.sh

docker-compose -p $DOCKER_DEVSVC_PROJECT $DOCKER_DEVSVC_COMPOSE_FILES down
