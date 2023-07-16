#!//bin/sh

docker run \
    -it --rm --name=builder \
    --mount type=bind,source=./,target=/src \
    --workdir /src \
    -t more/builder:latest \
    bash
