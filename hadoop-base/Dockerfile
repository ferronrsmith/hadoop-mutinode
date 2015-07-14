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

RUN wget http://apache.mirror.anlx.net/hadoop/core/hadoop-2.7.1/hadoop-2.7.1-src.tar.gz
RUN tar -xvf hadoop-2.7.1-src.tar.gz

RUN wget https://protobuf.googlecode.com/files/protobuf-2.5.0.tar.gz
RUN tar -xvf protobuf-2.5.0.tar.gz
RUN cd protobuf-2.5.0 && ./configure
RUN cd protobuf-2.5.0 && make
RUN cd protobuf-2.5.0 && make check
RUN cd protobuf-2.5.0 && make install
RUN cd protobuf-2.5.0 && ldconfig
RUN protoc --version
#ENV MAVEN_OPTS -Xms512m -XX:MaxPermSize=256 -Xmx512m
RUN cd hadoop-2.7.1-src && mvn package -Pdist,native -DskipTests -Dtar

RUN  cd hadoop-2.7.1-src && tar -xvf hadoop-dist/target/hadoop-2.7.1.tar.gz -C /usr/local/
RUN ln -s /usr/local/hadoop-2.7.1 /usr/local/hadoop
RUN chown -R hduser:hadoop /usr/local/hadoop-2.7.1

ADD config/bashrc /home/hduser/.bashrc

RUN rm -f /usr/local/hadoop/etc/hadoop/hadoop-env.sh
ADD config/hadoop-env.sh /usr/local/hadoop/etc/hadoop/hadoop-env.sh

EXPOSE 22
