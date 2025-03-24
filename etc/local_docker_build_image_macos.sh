#!/bin/sh

# run this from root

DOCKER_DEFAULT_PLATFORM=linux/amd64 docker build -t more/builder:0.1 -f ./etc/Dockerfile .
docker tag more/builder:0.1 more/builder:latest
