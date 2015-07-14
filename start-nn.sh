#!/bin/bash
docker run -d -t -v /tmp/hdfs/master:/home/hduser/hdfs --net=host -P --name namenode ferronrsmith/hadoop-namenode
