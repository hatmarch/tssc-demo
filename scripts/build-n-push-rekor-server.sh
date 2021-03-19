#!/bin/bash

set -euo pipefail


declare IMAGE_TAG=${1:-latest}
declare IMAGE_NAME=${2:-"rekor-server"}
declare DOCKERFILE=${3:-"Dockerfile"}
declare REGISTRY=${4:-"quay.io"}
declare ACCOUNT=${5:-"mhildenb"}

cd ${DEMO_HOME}/rekor
DOCKER_BUILDKIT=1 docker build -f ${DOCKERFILE} -t ${REGISTRY}/${ACCOUNT}/${IMAGE_NAME}:$IMAGE_TAG .

docker tag ${REGISTRY}/${ACCOUNT}/${IMAGE_NAME}:${IMAGE_TAG} ${REGISTRY}/${ACCOUNT}/${IMAGE_NAME}:latest

docker push ${REGISTRY}/${ACCOUNT}/${IMAGE_NAME}:${IMAGE_TAG}
docker push ${REGISTRY}/${ACCOUNT}/${IMAGE_NAME}:latest
