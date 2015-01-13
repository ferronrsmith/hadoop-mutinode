#!/bin/bash

# Persistent locations on host
host_data_dir_m=/tmp/hdfs/master
host_data_dir_s=/tmp/hdfs/slave

# Taken from dfs.datanode.data.dir in hdfs-site.xml
hdfs_container_dir=/home/hduser/hdfs

docker run -d -t --dns 127.0.0.1 -v $host_data_dir_s:$hdfs_container_dir -P --name slave1 -h slave1.mycorp.kom mesosphere/hadoop-dn

FIRST_IP=$(docker inspect --format="{{.NetworkSettings.IPAddress}}" slave1)

docker run -d -t --dns 127.0.0.1 -v $host_data_dir_m:$hdfs_container_dir -e JOIN_IP=$FIRST_IP -P --name master -h master.mycorp.kom mesosphere/hadoop-nn-dn
