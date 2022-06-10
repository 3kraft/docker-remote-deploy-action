#!/usr/bin/env bash
set -e

ssh -o StrictHostKeyChecking=no -i $PRIVATE_KEY_FILE $DOCKER_HOST_USER@$DOCKER_HOST "docker login $REGISTRY -u $REGISTRY_USER -p $REGISTRY_TOKEN"
ssh -o StrictHostKeyChecking=no -i $PRIVATE_KEY_FILE $DOCKER_HOST_USER@$DOCKER_HOST "docker stop $CONTAINER_NAME"
ssh -o StrictHostKeyChecking=no -i $PRIVATE_KEY_FILE $DOCKER_HOST_USER@$DOCKER_HOST "docker rm $CONTAINER_NAME"
ssh -o StrictHostKeyChecking=no -i $PRIVATE_KEY_FILE $DOCKER_HOST_USER@$DOCKER_HOST "docker pull $IMAGE_NAME:$TAG_NAME"
ssh -o StrictHostKeyChecking=no -i $PRIVATE_KEY_FILE $DOCKER_HOST_USER@$DOCKER_HOST "docker run -d --name $CONTAINER_NAME -p $CONTAINER_PORTS -e DD_ENV=${DD_ENV} -e DD_SERVICE=${DD_SERVICE} -e DD_VERSION=${DD_VERSION} -l com.datadoghq.tags.env=${DD_ENV} -l com.datadoghq.tags.service=${DD_SERVICE} -l com.datadoghq.tags.version=${DD_VERSION} $CONTAINER_ARGS $IMAGE_NAME:$TAG_NAME"
ssh -o StrictHostKeyChecking=no -i $PRIVATE_KEY_FILE $DOCKER_HOST_USER@$DOCKER_HOST "docker image prune -af"
