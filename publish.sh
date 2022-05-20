VERSION=2.6.0
CURRENT_DIR=$(pwd)
function build_image() {
    cd $CURRENT_DIR/$1 && ./build-image.sh $VERSION && cd ..
    cd $CURRENT_DIR
}
build_image backend
build_image pipeline
build_image modou_hive_db

echo ""
echo ""
echo "-------------"
docker image ls | grep modou |grep -v latest
