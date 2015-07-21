#!/bin/bash

# launch slave
docker run -d -t --dns 127.0.0.1 -e NODE_TYPE=s -P --name slave1 -h slave1-hdfs-local-1 ferronrsmith/hadoop-dn

FIRST_IP=$(docker inspect --format="{{.NetworkSettings.IPAddress}}" slave1)

# launch master in interactive mode
docker run -i -t --dns 127.0.0.1 -e NODE_TYPE=m -e JOIN_IP=$FIRST_IP -P --name master -h master-hdfs-local-1 ferronrsmith/hadoop-nn-dn

# next steps, executed in master shell:
# /usr/local/hadoop/bin/start-hadoop.sh # all JVMs should come up successfully
# su - hduser
# hdfs dfs -ls /
