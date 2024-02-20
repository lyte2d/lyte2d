#!/bin/sh

docker build -t more/builder:0.1 -f ./Dockerfile .
docker tag more/builder:0.1 more/builder:latest
