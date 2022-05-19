#!/bin/bash 

CURRENT_DIR=$(pwd)
ALIYUN_COMPOSE_FILE="https://raw.githubusercontent.com/gomodou/magicbean-compose/main/docker-compose.aliyun.yaml"
DOCKERHUB_COMPOSE_FILE="https://raw.githubusercontent.com/gomodou/magicbean-compose/main/docker-compose.dockerhub.yaml"
WORKING_DIR=$CURRENT_DIR/magicbean-compose
COMPOSE_FILE_NAME="docker-compose.yml"
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
}

function workdir() {
    cd $WORKING_DIR
}

function compose_up() {
    workdir
    docker-compose down
    docker-compose up -d
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
    echo "$ docker-compose stop"
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