#!/bin/bash

set -o pipefail
IMAGE=hykpi/hykpi_backend
VERSION=$1
docker build -t ${IMAGE}:${VERSION} . 
ID=$(docker image ls | grep $IMAGE | grep $VERSION | awk '{print $3}')
docker tag $ID ${IMAGE}:latest
docker tag $ID registry.cn-shanghai.aliyuncs.com/magicbean/hykpi_backend:latest
docker tag $ID registry.cn-shanghai.aliyuncs.com/magicbean/hykpi_backend:$VERSION
docker images | grep ${IMAGE}