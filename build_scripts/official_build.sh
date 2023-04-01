#!//bin/sh

## Note: Run this script from the root of the project.

## This script requires the Docker image 'more/builder:latest' to be available.
## 'Dockerfile' to build this image is available next to this script.

CURRDIR=$(pwd)

VERSION=$(cat lyte/version.txt)

## Docker run helper. Notice no "-it" because this is to run in CI
DO_RUN="docker run --rm --name=builder \
    	--mount type=bind,source=${PWD},target=/src \
		--workdir /src \
    	-t more/builder:latest"

echo "Starting: official build @ $(date)"
echo "Current dir: $CURRDIR"

echo "Version: $VERSION"

echo "Config @ $(date)"
${DO_RUN} bash build_scripts/do_config.sh

echo "Build @ $(date)"
${DO_RUN} bash build_scripts/do_build.sh

echo "Copy @ $(date)"
${DO_RUN} bash build_scripts/do_copy.sh

echo "Pack @ $(date)"
${DO_RUN} bash build_scripts/do_pack.sh ${VERSION}

echo "Done: Official build @ $(date)"
