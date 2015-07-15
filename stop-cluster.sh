#!/bin/bash

hadoop_cluster_names=( `docker ps|grep -i hadoop|sed "s/ \{3,\}/#/g"|cut -d '#' -f 7|sed "s/#/\t/g"` )
for name in ${hadoop_cluster_names[@]}; do
    docker stop ${name} && docker rm ${name}
done