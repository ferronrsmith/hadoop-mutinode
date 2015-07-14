FROM ferronrsmith/hadoop-base
MAINTAINER Ferron Hanse

RUN apt-get install -y iputils-ping

ENV HADOOP_INSTALL /usr/local/hadoop

ADD config/hdfs-site.xml $HADOOP_INSTALL/etc/hadoop/hdfs-site.xml
ADD config/core-site.xml $HADOOP_INSTALL/etc/hadoop/core-site.xml

RUN mkdir $HADOOP_INSTALL/logs
RUN chown -R hduser:hadoop $HADOOP_INSTALL/logs

ADD config/start-datanode.sh $HADOOP_INSTALL/bin/start-datanode.sh
RUN chmod 755 $HADOOP_INSTALL/bin/start-datanode.sh

EXPOSE 9000 50010 50020 50070 50075 50090 50470 50475

ENTRYPOINT ["/bin/bash", "/usr/local/hadoop/bin/start-datanode.sh"]
