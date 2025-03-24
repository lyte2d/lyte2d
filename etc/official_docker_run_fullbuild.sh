#!/bin/sh

docker run \
    --rm --name=builder \
    --mount type=bind,source=${PWD},target=/src \
    --workdir /src \
    -t more/builder:latest \
    bash etc/official_fullbuild.sh
