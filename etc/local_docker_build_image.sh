#!/bin/sh

# run this from root

docker build -t more/builder:0.1 -f ./etc/Dockerfile .
docker tag more/builder:0.1 more/builder:latest
