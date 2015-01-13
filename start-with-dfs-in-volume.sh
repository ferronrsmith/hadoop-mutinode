#!/bin/bash

# Persistent locations on host
host_data_dir_m=/tmp/hdfs/master
host_data_dir_s1=/tmp/hdfs/slave1
host_data_dir_s2=/tmp/hdfs/slave2

# Taken from dfs.datanode.data.dir in hdfs-site.xml
hdfs_container_dir=/home/hduser/hdfs

docker run -d -t --dns 127.0.0.1 -v $host_data_dir_s1:$hdfs_container_dir -P --name slave1 -h slave1.hdfs.local mesosphere/hadoop-dn

FIRST_IP=$(docker inspect --format="{{.NetworkSettings.IPAddress}}" slave1)

docker run -d -t --dns 127.0.0.1 -v $host_data_dir_s2:$hdfs_container_dir -e JOIN_IP=$FIRST_IP -P --name slave2 -h slave2.hdfs.local mesosphere/hadoop-dn

docker run -d -t --dns 127.0.0.1 -v $host_data_dir_m:$hdfs_container_dir -e JOIN_IP=$FIRST_IP -P --name master -h master.hdfs.local mesosphere/hadoop-nn-dn
