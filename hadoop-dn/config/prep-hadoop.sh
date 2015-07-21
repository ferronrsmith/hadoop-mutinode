#!/bin/bash

if [[ -n $TUTUM_SERVICE_HOSTNAME ]]; then
    sed 's/###INTERFACE###/ethwe/' -i "$HADOOP_INSTALL/etc/hadoop/hdfs-site.xml"

    if [ -z "$(grep "nameserver 0.0.0.1" /etc/resolv.conf)" ]; then
        echo 'nameserver 0.0.0.0' | cat - /etc/resolv.conf > temp && cp temp /etc/resolv.conf
    fi

else
    sed 's/###INTERFACE###/eth0/' -i "$HADOOP_INSTALL/etc/hadoop/hdfs-site.xml"
fi

if [ ! -d /home/hduser/hdfs/datanode ]; then
    mkdir -p /home/hduser/hdfs/datanode
    chown -R hduser:hadoop /home/hduser/hdfs/datanode
    chmod 700 /home/hduser/hdfs/datanode
fi

/usr/bin/svscan /etc/service/
