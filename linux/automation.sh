#!/bin/bash

set -e
set -u

DOCKER_IMAGE="golang-app"
IMAGE_TAG="$(date +%Y%m%d%H%M%S)"

echo "Building Docker image"
docker build -t $DOCKER_IMAGE:$IMAGE_TAG ../dockerize

echo "Creating new-app.yaml by replacing MY_NEW_IMAGE with $DOCKER_IMAGE:$IMAGE_TAG"
sed "s|MY_NEW_IMAGE|$DOCKER_IMAGE:$IMAGE_TAG|g" script.yml > new-app.yaml

echo "Showing the difference between the current state and new-app.yaml"
kubectl diff -f new-app.yaml --namespace=applications

