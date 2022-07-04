#!/bin/bash 

HYKPI_VERSION="$1"
docker-compose --env-file prod.env stop
docker-compose --env-file prod.env down
CURRENT_DIR=$(pwd)
WORKING_DIR=$CURRENT_DIR
ALIYUN_COMPOSE_FILE="https://hykpi-release.oss-cn-hongkong.aliyuncs.com/hykpi-compose/docker-compose.aliyun.$HYKPI_VERSION.yaml"
DOCKERHUB_COMPOSE_FILE="https://hykpi-release.oss-cn-hongkong.aliyuncs.com/hykpi-compose/docker-compose.dockerhub.$HYKPI_VERSION.yaml"
ENV_FILE="https://hykpi-release.oss-cn-hongkong.aliyuncs.com/hykpi-compose/prod.$HYKPI_VERSION.env"
COMPOSE_FILE_NAME="docker-compose.yml"
ENV_FILE_NAME="prod.env"
export DOCKER_CLIENT_TIMEOUT=120
export COMPOSE_HTTP_TIMEOUT=120

function curl_downloader() {
    output_path=$1
    output_file_name=$2
    target_url=$3
    echo curl --create-dirs -o $output_path/$output_file_name $target_url
    curl --create-dirs -o $output_path/$output_file_name $target_url
}

function get_compose_file() {
    if [ $(date +'%Z') = "CST" ]; 
    then
        echo "Download Aliyun compose file"
        curl_downloader $WORKING_DIR $COMPOSE_FILE_NAME $ALIYUN_COMPOSE_FILE
    else
        echo "Download Dockerhub compose file"
        curl_downloader $WORKING_DIR $COMPOSE_FILE_NAME $DOCKERHUB_COMPOSE_FILE
    fi
    curl_downloader $WORKING_DIR $ENV_FILE_NAME $ENV_FILE
}

function main() {
    cd $CURRENT_DIR
    rm $COMPOSE_FILE_NAME
    rm $ENV_FILE_NAME
    get_compose_file
}

main