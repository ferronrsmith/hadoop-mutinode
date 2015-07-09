# Serf/Dnsmasq on Docker

This image aims to provide resolvable fully qualified domain names,
between dynamically created docker containers on ubuntu.

## The problem

By default **/etc/hosts** is readonly in docker containers. The usual
solution is to start a DNS server (probably as a docker container) and pass
a reference when starting docker instances: `docker run -dns <IP_OF_DNS>`

## Reference
The guys at sequenceiq have done the fantastic job to solve this problem full credit to them.

Visit here for more details [Serf/Dnsmaq](https://github.com/sequenceiq/docker-serf)

Visit here for presentation [Hadoop Summit](http://www.slideshare.net/JanosMatyas/docker-based-hadoop-provisioning)


