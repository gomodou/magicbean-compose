FROM domblack/oracle-jdk8

ENV MAGICBEAN_VERSION=2.7.0
ENV OSS_URL=https://hykpi-release.oss-accelerate.aliyuncs.com
ENV MB_SYSTEM_KEY=MagicBean
ENV MB_HOME='file:///modou/workspace'
ENV MB_MQ_HOST=rabbitmq
ENV MB_MQ_PORT=5672
ENV MB_MQ_USER=guest
ENV MB_MQ_PWD=guest
ENV MB_REDIS_HOST=127.0.0.1
ENV MB_REDIS_PORT=6379
ENV MB_REDIS_PWD=
ENV MB_REDIS_DB='3'
ENV MB_POSTGRES_URL='jdbc:postgresql://db:5432/modou'
ENV MB_POSTGRES_USER=postgres
ENV MB_POSTGRES_PWD='123456'
ENV MB_SERVER_PORT=80
ENV MB_SESSION_TIMEOUT=24h
ENV MB_PERSISTENT_HOME='file:///modou/workspace'
ENV MB_PIPELINE_MODE=local
ENV MB_PIPELINE_SERVER='http://pipeline:80/api'
ENV MB_CUSTOM_SPARK_SERVER=
ENV MB_GITHUB_CLIENT_ID=''
ENV MB_GITHUB_CLIENT_SECRET=''
ENV MB_GROWINGIO_CLIENT_ID=''
ENV MB_GROWINGIO_CLIENT_SECRET=''
ENV MB_GROWINGIO_API_PREFIX=''
ENV MB_DATA_EXPORT_TOKENS='modou-export-token1,modou-export-token2'
ENV MB_EXECUTOR_MEMORY=2G
ENV MB_EXECUTOR_CORES=1
ENV MB_EXECUTOR_INSTANCES=1
ENV MB_EXECUTOR_MAX_CORES=2
ENV MB_EXECUTOR_DRIVER_MEMORY=1G
ENV MB_EXECUTOR_NETWORK_TIMEOUT=150000
ENV MB_EXECUTOR_HEARTBEAT_INTERVAL=180000
ENV MB_EXECUTOR_SQL_WAREHOUSE='file:///modou/workspace'
ENV MB_EXECUTOR_PIPELINE_JAR='/modou/pipeline/cache/pipeline-core-spark-2.4.jar'
ENV MB_PIPELINE_WORKSPACE='file:///modou/workspace'
ENV MB_EXECUTOR_SQL_SPARK_HADOOP_FS_DEFAULT_NAME='file:///tmp/modou/'
ENV MB_HIVE_THRIFT_PORT=11004
ENV MB_HIVE_THRIFT_URL='jdbc:postgresql://hykpi_hive_db:5432/modou_hive'
ENV MB_HIVE_THRIFT_USERNAME=postgres
ENV MB_HIVE_THRIFT_PASSWORD='123456'

RUN mkdir -p /modou/backend \
  && mkdir -p ~/.magicbean/templates \
  && cd /modou/backend \
  && curl --create-dirs -o ./stem.jar $OSS_URL/backend/stem-$MAGICBEAN_VERSION.jar

WORKDIR /modou/backend
EXPOSE 80
ENTRYPOINT ["java","-jar","stem.jar"]
