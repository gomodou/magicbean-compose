#!/bin/bash 

MAGICBEAN_VERSION="2.6.2"
CURRENT_DIR=$(pwd)
ALIYUN_COMPOSE_FILE="https://magicbean-release.oss-cn-hongkong.aliyuncs.com/magicbean-compose/docker-compose.aliyun.$MAGICBEAN_VERSION.yaml"
DOCKERHUB_COMPOSE_FILE="https://magicbean-release.oss-cn-hongkong.aliyuncs.com/magicbean-compose/docker-compose.dockerhub.$MAGICBEAN_VERSION.yaml"
ENV_FILE="https://magicbean-release.oss-cn-hongkong.aliyuncs.com/magicbean-compose/prod.$MAGICBEAN_VERSION.env"
WORKING_DIR=$CURRENT_DIR/magicbean-compose
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

function workdir() {
    cd $WORKING_DIR
}

function compose_up() {
    workdir
    echo docker-compose --env-file $ENV_FILE_NAME -f $COMPOSE_FILE_NAME down
    docker-compose --env-file $ENV_FILE_NAME -f $COMPOSE_FILE_NAME down
    echo docker-compose --env-file $ENV_FILE_NAME -f $COMPOSE_FILE_NAME up -d
    docker-compose --env-file $ENV_FILE_NAME -f $COMPOSE_FILE_NAME up -d
}

function finished_banner() {
    echo -ne '##########                     (33%)\r'
    sleep 4
    echo -ne '############                   (50%)\r'
    sleep 1
    echo -ne '##################             (66%)\r'
    sleep 6
    echo -ne '############################   (100%)\r'
    echo -ne '\n'
    echo ""
    echo ""
    echo "========================================"
    echo "open http://localhost:9010/login (default user/password: admin / 123456)"
    echo ""
    echo ""
    echo "Magicbean deployed in $WORKING_DIR"
    echo "How to stop the service ?"
    echo "$ cd $WORKING_DIR"
    echo "$ docker-compose --env-file $ENV_FILE_NAME -f $COMPOSE_FILE_NAME down"
    echo "========================================"
    echo ""
    echo ""
}

function main() {
    mkdir -p $WORKING_DIR
    workdir
    get_compose_file
    compose_up
    finished_banner
    cd $CURRENT_DIR
}

main