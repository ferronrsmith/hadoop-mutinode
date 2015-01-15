#!/bin/bash

if [ ! -d /home/hduser/hdfs/datanode ]; then
    mkdir -p /home/hduser/hdfs/datanode
    chown -R hduser:hadoop /home/hduser/hdfs/datanode
    chmod 700 /home/hduser/hdfs/datanode
fi

if [ -n $NN_IP ]; then
    sed -i "s/0.0.0.0/$NN_IP/" $HADOOP_INSTALL/etc/hadoop/core-site.xml
fi

su hduser -c "$HADOOP_INSTALL/sbin/hadoop-daemon.sh start datanode"

tail -f $HADOOP_INSTALL/logs/*
