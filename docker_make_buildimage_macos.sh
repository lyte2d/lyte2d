#!/bin/sh

DOCKER_DEFAULT_PLATFORM=linux/amd64 docker build -t more/builder:0.1 -f ./Dockerfile .
docker tag more/builder:0.1 more/builder:latest
