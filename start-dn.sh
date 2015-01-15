#!/bin/bash
docker run -d -t -v /tmp/hdfs/slave:/home/hduser/hdfs --net=host -P --name datanode mesosphere/hadoop-datanode
