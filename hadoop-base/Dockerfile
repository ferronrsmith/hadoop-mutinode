FROM ferronrsmith/serf
MAINTAINER Ferron Hanse

# Accept the Oracle Java license
RUN echo "oracle-java7-installer shared/accepted-oracle-license-v1-1 boolean true" | debconf-set-selections

# Update Ubuntu
RUN apt-get update \
 && apt-get install -y software-properties-common
RUN add-apt-repository ppa:webupd8team/java

RUN apt-get update \
 && apt-get install -y \
  iputils-ping daemontools dnsutils vim oracle-java7-installer openssh-server

RUN update-alternatives --display java

ENV JAVA_HOME /usr/lib/jvm/java-7-oracle/
ENV PATH $PATH:$JAVA_HOME/bin

RUN addgroup hadoop
RUN useradd -d /home/hduser -m -s /bin/bash -G hadoop hduser

RUN mkdir /var/run/sshd
RUN su hduser -c "ssh-keygen -t rsa -f ~/.ssh/id_rsa -P ''"
RUN su hduser -c "cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys"
ADD config/ssh_config ./ssh_config
RUN mv ./ssh_config /home/hduser/.ssh/config
# fix permission:
RUN chown hduser:hduser /home/hduser/.ssh/config

RUN curl -s https://archive.apache.org/dist/hadoop/common/hadoop-2.7.1/hadoop-2.7.1.tar.gz | tar -xz -C /usr/local/
RUN cd /usr/local && ln -s ./hadoop-2.7.1 hadoop

RUN rm  /usr/local/hadoop/lib/native/*
RUN curl -Ls https://storage.googleapis.com/hdfs-bucket/hadoop/hadoop-native-64-2.7.1.tar | tar -x -C /usr/local/hadoop/lib/native/

RUN ln -s /usr/local/hadoop-2.7.1 /usr/local/hadoop
RUN chown -R hduser:hadoop /usr/local/hadoop-2.7.1

ADD config/bashrc /home/hduser/.bashrc

RUN rm -f /usr/local/hadoop/etc/hadoop/hadoop-env.sh
ADD config/hadoop-env.sh /usr/local/hadoop/etc/hadoop/hadoop-env.sh

EXPOSE 22