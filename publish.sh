VERSION=2.6.4
CURRENT_DIR=$(pwd)
function build_image() {
    DOCKER_DIR=$1
    TAG=$2
    echo Runing in $CURRENT_DIR/$DOCKER_DIR
    cd $CURRENT_DIR/$DOCKER_DIR && ./build-image.sh $TAG && cd ..
    cd $CURRENT_DIR
}
build_image "backend" $VERSION
build_image pipeline $VERSION
#build_image modou_hive_db 2.6.0

#docker push hykpi/modou_hive_db:2.6.0
docker push hykpi/modou_backend:$VERSION
docker push hykpi/modou_pipeline:$VERSION
#docker push hykpi/modou_hive_db:latest
docker push hykpi/modou_pipeline:latest
docker push hykpi/modou_backend:latest
#docker push registry.cn-shanghai.aliyuncs.com/magicbean/modou_hive_db:2.6.0
docker push registry.cn-shanghai.aliyuncs.com/magicbean/modou_backend:$VERSION
docker push registry.cn-shanghai.aliyuncs.com/magicbean/modou_pipeline:$VERSION
#docker push registry.cn-shanghai.aliyuncs.com/magicbean/modou_hive_db:latest
docker push registry.cn-shanghai.aliyuncs.com/magicbean/modou_backend:latest
docker push registry.cn-shanghai.aliyuncs.com/magicbean/modou_pipeline:latest

echo ""
echo ""
echo "-------------"
docker image ls | grep modou 
echo "-------------"
echo ""
echo ""
