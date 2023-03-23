#!/bin/bash
set -e

BASEDIR=$(realpath "$(dirname "$0")")
cd "$BASEDIR" || exit

IMAGE_TAG=${IMAGE_TAG:-v1.0.0}
IMAGE_NAME=${IMAGE_NAME:-awx-ee}
DOCKER_REGISTRY=${DOCKER_REGISTRY:-docker.io}

LOCAL_IMAGE=${IMAGE_NAME}:${IMAGE_TAG}
VERB=${1:-""}

cd $IMAGE_NAME

if [ "$VERB" == "" ]; then
    echo "you must specify 'build', 'push' or 'all'"
    exit 1
fi

if [ "$VERB" == "build" ] || [ "$VERB" == "all" ]; then
    docker build -t "${LOCAL_IMAGE}" -f debian.Dockerfile .
fi

if [ "$VERB" == "push" ] || [ "$VERB" == "all" ]; then
    DESTINATION_IMAGE="${DOCKER_REGISTRY}/${LOCAL_IMAGE}"
    docker tag "$LOCAL_IMAGE" "$DESTINATION_IMAGE"
    docker push "${DESTINATION_IMAGE}"
fi

echo "Done"
