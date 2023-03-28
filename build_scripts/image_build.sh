VERSION=$1
echo "@@@ BUILDING DOCKER IMAGE VERSION $VERSION"
echo "  datetime: " $(date)

docker build -t more/builder:$VERSION -f ./build_scripts/Dockerfile .

echo "... tagging the image as latest"

docker tag more/builder:$VERSION more/builder:latest

echo "@@@ DONE: BUILDING DOCKER IMAGE VERSION $VERSION"
echo "  datetime: " $(date)
