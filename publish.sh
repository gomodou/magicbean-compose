VERSION=2.6.0
CURRENT_DIR=$(pwd)
function build_image() {
    cd $CURRENT_DIR/$1 && ./build-image.sh $VERSION && cd ..
    cd $CURRENT_DIR
}
build_image backend
build_image pipeline
build_image modou_hive_db

docker push hykpi/modou_hive_db:$VERSION
docker push hykpi/modou_backend:$VERSION
docker push hykpi/modou_pipeline:$VERSION
docker push hykpi/modou_hive_db:latest
docker push hykpi/modou_pipeline:latest
docker push hykpi/modou_backend:latest
docker push registry.cn-shanghai.aliyuncs.com/magicbean/modou_hive_db:$VERSION
docker push registry.cn-shanghai.aliyuncs.com/magicbean/modou_backend:$VERSION
docker push registry.cn-shanghai.aliyuncs.com/magicbean/modou_pipeline:$VERSION
docker push registry.cn-shanghai.aliyuncs.com/magicbean/modou_hive_db:latest
docker push registry.cn-shanghai.aliyuncs.com/magicbean/modou_backend:latest
docker push registry.cn-shanghai.aliyuncs.com/magicbean/modou_pipeline:latest

echo ""
echo ""
echo "-------------"
docker image ls | grep modou 
echo "-------------"
echo ""
echo ""
