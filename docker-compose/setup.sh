#!/bin/bash
set -eu

ROOT_DIR="$( cd `dirname $0` ; cd .. ; pwd -P )"

# Load .env file function
# usage: _dotenv
function _dotenv () {
    # Make sure file '.env' be existed
    if [[ ! -f $ROOT_DIR/.env ]]; then
        echo "Please make '.env' file"
        exit 1;
    fi
    set -a
    source $ROOT_DIR/.env
    set +a
}

# Make sure to create a docker network function
# usage: _create_docker_network <network_name> [<driver=overlay>]
function _create_docker_network() {
    local name=$1
    local driver=${2:-overlay}

    # Make sure to create a network
    if [[ ! $(docker network ls | grep " $name " > /dev/null; echo $?) -eq "0" ]]; then
        docker network create --driver=$driver $name
    fi
}

# Create docker stack function
# usage: _create_docker_stack <stack_name> [<config_file>]
function _create_docker_stack() {
    local name=$1
    local default_config=$ROOT_DIR/stacks/$name.yml
    local config=${2:-$default_config}

    docker-compose -f $config up -d
}

# Load form .env
_dotenv

# Make sure HASHED_PASSWORD is not empty
if [[ -z "$HASHED_PASSWORD" ]]; then
    echo "Set password for '$USERNAME'"
    export HASHED_PASSWORD="$(openssl passwd -apr1)"
fi

# Create networks
_create_docker_network reverse-proxy

# Create stacks
_create_docker_stack traefik
_create_docker_stack whoami
