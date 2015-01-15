#!/bin/bash

if [ ! -d /home/hduser/hdfs/datanode ]; then
    mkdir -p /home/hduser/hdfs/datanode
    chown -R hduser:hadoop /home/hduser/hdfs/datanode
    chmod 700 /home/hduser/hdfs/datanode
fi

su hduser -c "$HADOOP_INSTALL/sbin/hadoop-daemon.sh start datanode"

tail -f $HADOOP_INSTALL/logs/*
