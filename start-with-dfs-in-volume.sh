#!/bin/bash

host_data_dir=/tmp/slave1_hdfs

# Taken from dfs.datanode.data.dir in hdfs-site.xml - I confirmed that HDFS data lands here
hdfs_container_dir=/home/hduser/hdfs

docker run -d -t --dns 127.0.0.1 -v $host_data_dir:$hdfs_container_dir -e NODE_TYPE=s -P --name slave1 -h slave1.mycorp.kom mesosphere/hadoop-dn

FIRST_IP=$(docker inspect --format="{{.NetworkSettings.IPAddress}}" slave1)

docker run -i -t --dns 127.0.0.1 -e NODE_TYPE=m -e JOIN_IP=$FIRST_IP -P --name master -h master.mycorp.kom mesosphere/hadoop-nn-dn
