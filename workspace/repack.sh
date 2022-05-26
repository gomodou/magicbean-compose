version=$1
tar -zxvf magicbean-$1.tar.gz
rm -rf magicbean/spark-2.4.7-bin-hadoop2.7 magicbean/*.sh
rm magicbean-$1.tar.gz
tar -zcvf magicbean-$1.tar.gz ./magicbean/*
cp ./magicbean/stem*.jar ./stem-$1.jar
./ossutil64 cp magicbean-2.6.4.tar.gz oss://hykpi-release/hykpi-release