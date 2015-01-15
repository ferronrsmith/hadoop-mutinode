# HDFS Multinode Cluster with Docker.

The purpose of this project is to start a multinode HDFS cluster, with one NameNode and one or more DataNodes, either on the same host (e.g. laptop) or across hosts.

The first docker container **hadoop-base** provisions ubuntu with java and hadoop and does most of the leg work to setup the master and slave containter.

The second container image **hadoop-namenode** extends from hadoop-base and installs the namenode specific hadoop configuration and starts the namenode daemon.

The third container image **hadoop-datanode** extends from hadoop-base and installs the datanode specific hadoop configuration and starts the datanode daemon, connecting to the specified namenode IP.


Prerequisite
------------

1. Docker must be installed on the host computer / laptop.
 
Build Multinode Hadoop Cluster
------------------------------
 
* Clone github repo
  * `git clone https://github.com/mesosphere/hadoop-mutinode`
  * `cd hadoop-mutinode`

* Build hadoop-base container (only if modified)
  * Run `docker build -t mesosphere/hadoop-base hadoop-base`
  * This will take a while to build the container go grab a cup of coffee or whatever drink you like :)
 
* Build hadoop-namenode container
  * Run `docker build -t mesosphere/hadoop-namenode hadoop-namenode`  
  
* Build hadoop-datanode container
  * Run `docker build -t mesosphere/hadoop-datanode hadoop-datanode`

** Start the containers **

 * On the host where you want the NameNode, run `./start-namenode.sh`
 * To start a DataNode on the same host, run `./start-datanode.sh`
 * From other hosts, start a DataNode with `./start-datanode.sh <namenode_ip>`

** Verify HDFS is running **

 * View the HDFS NameNode Web UI on `<namenode_ip>:50070`
 * View the HDFS DataNode Web UI on any `<datanode_ip>:50075`
 * Inside either container, run `su - hduser -c "hdfs dfs -ls /"` to verify HDFS is running
  
