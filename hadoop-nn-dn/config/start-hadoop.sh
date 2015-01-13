#!/bin/bash

# create and format namenode if absent
if [ ! -d /home/hduser/hdfs/namenode ]; then
    mkdir -p /home/hduser/hdfs/namenode
    chown -R hduser:hadoop /home/hduser/hdfs/namenode
    chmod 700 /home/hduser/hdfs/namenode
    su hduser -c "/usr/local/hadoop/bin/hdfs namenode -format"
    #sudo -u hdfs hdfs namenode -format -clusterId $CLUSTER_ID # always format with the same cluster id?
fi

if [ ! -d /home/hduser/hdfs/datanode ]; then
    mkdir -p /home/hduser/hdfs/datanode
    chown -R hduser:hadoop /home/hduser/hdfs/datanode
    chmod 700 /home/hduser/hdfs/datanode
fi

/usr/bin/svscan /etc/service/ &
sleep 4

su hduser -c "$HADOOP_INSTALL/sbin/start-dfs.sh"
#su hduser -c "$HADOOP_INSTALL/sbin/start-yarn.sh"

tail -f $HADOOP_INSTALL/logs/*
