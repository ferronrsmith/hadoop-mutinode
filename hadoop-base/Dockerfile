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
  maven llvm-gcc build-essential zlib1g-dev make cmake pkg-config libssl-dev automake autoconf software-properties-common oracle-java7-installer openssh-server

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

# hadoop
#RUN curl -s http://www.eu.apache.org/dist/hadoop/common/hadoop-2.7.0/hadoop-2.7.0.tar.gz | tar -xz -C /usr/local/
RUN curl -s https://archive.apache.org/dist/hadoop/common/hadoop-2.7.0/hadoop-2.7.0.tar.gz | tar -xz -C /usr/local/
RUN cd /usr/local && ln -s ./hadoop-2.7.0 hadoop
#RUN ln -s /usr/local/hadoop-2.7.0 /usr/local/hadoop

# fixing the libhadoop.so like a boss
RUN rm  /usr/local/hadoop/lib/native/*
RUN curl -Ls http://dl.bintray.com/sequenceiq/sequenceiq-bin/hadoop-native-64-2.7.0.tar | tar -x -C /usr/local/hadoop/lib/native/

ENV HADOOP_PREFIX /usr/local/hadoop

RUN mkdir $HADOOP_PREFIX/input
RUN cp $HADOOP_PREFIX/etc/hadoop/*.xml $HADOOP_PREFIX/input

RUN chown -R hduser:hadoop /usr/local/hadoop-2.7.0

ADD config/bashrc /home/hduser/.bashrc

# fix the 254 error code
RUN sed  -i "/^[^#]*UsePAM/ s/.*/#&/"  /etc/ssh/sshd_config
RUN echo "UsePAM no" >> /etc/ssh/sshd_config
RUN echo "Port 2122" >> /etc/ssh/sshd_config

RUN rm -f /usr/local/hadoop/etc/hadoop/hadoop-env.sh
ADD config/hadoop-env.sh /usr/local/hadoop/etc/hadoop/hadoop-env.sh

# working around docker.io build error
RUN ls -la /usr/local/hadoop/etc/hadoop/*-env.sh
RUN chmod +x /usr/local/hadoop/etc/hadoop/*-env.sh
RUN ls -la /usr/local/hadoop/etc/hadoop/*-env.sh

EXPOSE 22
