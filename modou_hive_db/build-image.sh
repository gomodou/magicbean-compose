#!/bin/bash

set -o pipefail
IMAGE=hykpi/modou_backend
VERSION=2.6.0
docker build -t ${IMAGE}:${VERSION} . 
ID=$(docker image ls | grep $IMAGE | grep $VERSION | awk '{print $3}')
docker tag $ID ${IMAGE}:latest
docker images | grep ${IMAGE}