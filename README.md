# Hadoop (YARN) Multinode Cluster with Docker.

The purpose of this project is to help developers quickly start a multinode Hadoop cluster with docker containers on their laptop.

The first docker container **hadoop-base** provisions ubuntu with java and hadoop and does most of the leg work to setup the master and slave containter.The **hadoop-base** is extending from **docker-serf**. See [DNSMASQ/SERF](https://github.com/mesosphere/docker-serf)


The second container image **hadoop-dn** extends from hadoop-base and installs the slave specific hadoop configuaration and it also installs daemontools to run the sshd , serf and dnsmasq so when we start the docker container in daemon mode it keep running instead of exiting immediatley after startup.


The third docker container **hadoop-nn-dn** extends from hadoop-base and install the master specific hadoop configuaration and it also installs daemontools to run the sshd , serf and dnsmasq.

The example for demonstration is using 2 node cluster. The master node is also configured as slave node so we have 2 slave nodes and 1 master node.


Prerequisite
------------

1. Docker must be installed on the host computer / laptop.
2. For debugging, we recommend [nsenter](https://github.com/jpetazzo/nsenter)
 
Build Multinode Hadoop Cluster
------------------------------
 
`git clone https://github.com/mesosphere/hadoop-mutinode`

* Build hadoop-base container (only if modified)
  * Change directory to hadoop-mutinode/hadoop-base.
  * Run `docker build -t mesosphere/hadoop-base .`
  * This will take a while to build the container go grab a cup of coffee or whatever drink you like :)
 
  
* Build hadoop-dn Slave container (DataNode / NodeManager)
  * Change directory to hadoop-mutinode/hadoop-dn.
  * Run `docker build -t mesosphere/hadoop-dn .`  

* Build hadoop-nn-dn Master container (NameNode / DataNode / Resource Manager / NodeManager)
  * Change directory to hadoop-mutinode/hadoop-nn-dn.
  * Run `docker build -t mesosphere/hadoop-nn-dn .`  

**Start the containers.**

 * Change directory to hadoop-mutinode.
 * Run `./start-cluster.sh`, it will print the containerIDs
 * Run `sudo docker-enter {containerID}` to attach to a container
 * Inside that container, run `su - hduser -c "hdfs dfs -ls /"` to verify HDFS is running
  
