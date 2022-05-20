#!/bin/bash

set -o pipefail
IMAGE=hykpi/modou_hive_db
VERSION=$1
docker build -t ${IMAGE}:${VERSION} . 
ID=$(docker image ls | grep $IMAGE | grep $VERSION | awk '{print $3}')
docker tag $ID ${IMAGE}:latest
docker tag $ID registry.cn-shanghai.aliyuncs.com/magicbean/modou_hive_db:latest
docker tag $ID registry.cn-shanghai.aliyuncs.com/magicbean/modou_hive_db:$VERSION
docker images | grep ${IMAGE}
