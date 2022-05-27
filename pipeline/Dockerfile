FROM domblack/oracle-jdk8

ENV MAGICBEAN_VERSION=2.6.5
ENV MB_PIPELINE_PORT=80
ENV SPARK_OPTS="-Dspark.dynamicAllocation.enabled=false -Dspark.shuffle.service.enabled=false"
ENV SPARK_HOME="/modou/spark"
ENV OSS_URL=https://hykpi-release.oss-accelerate.aliyuncs.com
ENV MODOU_HIVE_PORT=5432
ENV MODOU_HIVE_USER=postgres
ENV MODOU_HIVE_PASSWORD=123456
ENV PYSPARK_PYTHON=/modou/pipeline/conda/envs/py36/bin/python
ENV PYSPARK_DRIVER_PYTHON=/modou/pipeline/conda/envs/py36/bin/python
ENV MODOU_PYTHON_PATH=/modou/pipeline/conda/envs/py36/bin/python
ENV MODOU_PYTHON_WORKSPACE=/modou/pipeline/python
ENV OS=Linux
ENV CONDA_HOME=/modou/pipeline/conda

RUN mkdir -p /modou/workspace && mkdir -p /tmp/modou
WORKDIR /modou/
RUN curl --create-dirs -o ./magicbean-$MAGICBEAN_VERSION.tar.gz $OSS_URL/magicbean/magicbean-$MAGICBEAN_VERSION.tar.gz \
    && tar -zxvf magicbean-$MAGICBEAN_VERSION.tar.gz \
    && mv ./magicbean ./pipeline \
    && rm ./pipeline/stem*.jar \
    && rm ./magicbean-$MAGICBEAN_VERSION.tar.gz \
    && curl --create-dirs -o ./spark-2.4.8-bin-hadoop2.7.tgz https://magicbean-release.oss-cn-hongkong.aliyuncs.com/apachespark/spark-2.4.8-bin-hadoop2.7.tgz \
    && tar -zxvf spark-2.4.8-bin-hadoop2.7.tgz  \
    && mv spark-2.4.8-bin-hadoop2.7 spark \
    && rm spark-2.4.8-bin-hadoop2.7.tgz \
    && echo "<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"no\"?>" >> $SPARK_HOME/conf/hive-site.xml \
    && echo "<?xml-stylesheet type=\"text/xsl\" href=\"configuration.xsl\"?>" >> $SPARK_HOME/conf/hive-site.xml \
    && echo "<configuration>" >> $SPARK_HOME/conf/hive-site.xml \
    && echo "  <property>" >> $SPARK_HOME/conf/hive-site.xml \
    && echo "    <name>javax.jdo.option.ConnectionURL</name>" >> $SPARK_HOME/conf/hive-site.xml \
    && echo "    <value>jdbc:postgresql://hykpi_hive_db:$MODOU_HIVE_PORT/modou_hive</value>" >> $SPARK_HOME/conf/hive-site.xml \
    && echo "  </property>" >> $SPARK_HOME/conf/hive-site.xml \
    && echo "  <property>" >> $SPARK_HOME/conf/hive-site.xml \
    && echo "    <name>javax.jdo.option.ConnectionDriverName</name>" >> $SPARK_HOME/conf/hive-site.xml \
    && echo "    <value>org.postgresql.Driver</value>" >> $SPARK_HOME/conf/hive-site.xml \
    && echo "  </property>" >> $SPARK_HOME/conf/hive-site.xml \
    && echo "  <property>" >> $SPARK_HOME/conf/hive-site.xml \
    && echo "    <name>javax.jdo.option.ConnectionUserName</name>" >> $SPARK_HOME/conf/hive-site.xml \
    && echo "    <value>$MODOU_HIVE_USER</value>" >> $SPARK_HOME/conf/hive-site.xml \
    && echo "  </property>" >> $SPARK_HOME/conf/hive-site.xml \
    && echo "  <property>" >> $SPARK_HOME/conf/hive-site.xml \
    && echo "    <name>javax.jdo.option.ConnectionPassword</name>" >> $SPARK_HOME/conf/hive-site.xml \
    && echo "    <value>$MODOU_HIVE_PASSWORD</value>" >> $SPARK_HOME/conf/hive-site.xml \
    && echo "  </property>" >> $SPARK_HOME/conf/hive-site.xml \
    && echo "</configuration>" >> $SPARK_HOME/conf/hive-site.xml

# RUN mkdir -p /modou/pipeline/conda \
#     && curl --create-dirs -o /modou/pipeline/conda/Miniconda3-latest-$OS-x86_64.sh $OSS_URL/conda/Miniconda3-latest-$OS-x86_64.sh \
#     && /bin/bash /modou/pipeline/conda/Miniconda3-latest-$OS-x86_64.sh -bfup $CONDA_HOME \
#     && rm /modou/pipeline/conda/Miniconda3-latest-$OS-x86_64.sh
# RUN $CONDA_HOME/bin/conda create -y -n py36 python=3.6 \
#     && $CONDA_HOME/envs/py36/bin/pip install findspark \
#     && $CONDA_HOME/envs/py36/bin/pip install numpy \
#     && $CONDA_HOME/envs/py36/bin/pip install scipy \
#     && $CONDA_HOME/envs/py36/bin/pip install pandas \
#     && $CONDA_HOME/envs/py36/bin/pip install hdfs3 \
#     && $CONDA_HOME/envs/py36/bin/pip install pyarrow==0.13.0 \
#     && $CONDA_HOME/envs/py36/bin/pip install lifetimes \
#     && $CONDA_HOME/envs/py36/bin/pip install datatile
# RUN mkdir -p $MODOU_PYTHON_WORKSPACE \
#     && curl --create-dirs -o $MODOU_PYTHON_WORKSPACE/clv.py $OSS_URL/pipeline-python-scripts/clv.py \
#     && curl --create-dirs -o $MODOU_PYTHON_WORKSPACE/user_script.py $OSS_URL/pipeline-python-scripts/user_script.py \
#     && curl --create-dirs -o $MODOU_PYTHON_WORKSPACE/wrapper.py $OSS_URL/pipeline-python-scripts/wrapper.py \
#     && curl --create-dirs -o $MODOU_PYTHON_WORKSPACE/entry.py $OSS_URL/pipeline-python-scripts/entry.py 

WORKDIR /modou/pipeline
EXPOSE 80
ENTRYPOINT ["java","-classpath","libs/*:.","ai.magicbean.pipeline.MdServer"]
