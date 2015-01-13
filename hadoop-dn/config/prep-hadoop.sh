#!/bin/bash

if [ ! -d /home/hduser/hdfs/datanode ]; then
    mkdir -p /home/hduser/hdfs/datanode
    chown -R hduser:hadoop /home/hduser/hdfs/datanode
    chmod 700 /home/hduser/hdfs/datanode
fi

/usr/bin/svscan /etc/service/
