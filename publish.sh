VERSION=2.6.5
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
#build_image hykpi_hive_db 2.6.0

#docker push hykpi/hykpi_hive_db:2.6.0
docker push hykpi/hykpi_backend:$VERSION
docker push hykpi/hykpi_pipeline:$VERSION
#docker push hykpi/hykpi_hive_db:latest
docker push hykpi/hykpi_pipeline:latest
docker push hykpi/hykpi_backend:latest
#docker push registry.cn-shanghai.aliyuncs.com/magicbean/hykpi_hive_db:2.6.0
docker push registry.cn-shanghai.aliyuncs.com/magicbean/hykpi_backend:$VERSION
docker push registry.cn-shanghai.aliyuncs.com/magicbean/hykpi_pipeline:$VERSION
#docker push registry.cn-shanghai.aliyuncs.com/magicbean/hykpi_hive_db:latest
docker push registry.cn-shanghai.aliyuncs.com/magicbean/hykpi_backend:latest
docker push registry.cn-shanghai.aliyuncs.com/magicbean/hykpi_pipeline:latest

echo ""
echo ""
echo "-------------"
docker image ls | grep hykpi
echo "-------------"
echo ""
echo ""
