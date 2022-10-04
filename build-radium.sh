#!/bin/bash
# This will build radium

# # Check if the radium container was already built
# if ! docker image list | grep -P '^radium-build '; then
   docker build -t radium-build .
# fi

docker create -ti --name radium_container radium-build bash
docker cp radium_container:/root/radium "$(dirname "$(realpath "$0")")"
docker rm -f radium_container
