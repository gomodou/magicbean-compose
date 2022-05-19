function build_image() {
    cd $1 && ./build-image.sh && cd ..
}
build_image backend
build_image pipline
build_image modou_hive_db

echo ""
echo ""
echo "-------------"
docker image ls | grep modou |grep -v latest