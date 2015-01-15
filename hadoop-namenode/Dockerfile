FROM mesosphere/hadoop-base

MAINTAINER Mesosphere

RUN apt-get install -y iputils-ping runit

ENV HADOOP_INSTALL /usr/local/hadoop

ADD config/hdfs-site.xml $HADOOP_INSTALL/etc/hadoop/hdfs-site.xml
ADD config/core-site.xml $HADOOP_INSTALL/etc/hadoop/core-site.xml

RUN mkdir $HADOOP_INSTALL/logs
RUN chown -R hduser:hadoop $HADOOP_INSTALL/logs
RUN chmod 1777 /tmp

ADD config/start-namenode.sh $HADOOP_INSTALL/bin/start-namenode.sh
RUN chmod 755 $HADOOP_INSTALL/bin/start-namenode.sh

EXPOSE 9000 50010 50020 50070 50075 50090 50475

ENTRYPOINT ["/bin/bash", "$HADOOP_INSTALL/bin/start-namenode.sh"]
