#!/bin/bash

# create and format namenode if absent
if [ ! -d /home/hduser/hdfs/namenode ]; then
    mkdir -p /home/hduser/hdfs/namenode
    chown -R hduser:hadoop /home/hduser/hdfs/namenode
    chmod 700 /home/hduser/hdfs/namenode
    su hduser -c "$HADOOP_INSTALL/bin/hdfs namenode -format"
fi

su hduser -c "$HADOOP_INSTALL/sbin/hadoop-daemon.sh start namenode"

tail -f $HADOOP_INSTALL/logs/*
