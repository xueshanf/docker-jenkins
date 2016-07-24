FROM jenkins:latest
MAINTAINER Xueshan Feng <sfeng@stanford.edu>

# Install Docker - the version needs to match the version on host if using bind mount /var/run/docker.sock
VERSION=1.10.3-0~jessie
USER root
RUN DEBIAN_FRONTEND=noninteractive apt-get -y update && apt-get -qqy install \
    apt-transport-https ca-certificates \
    && apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D \
    && echo "deb https://apt.dockerproject.org/repo debian-jessie main" >> /etc/apt/sources.list.d/docker.list \
    && apt-get update -y \
    && apt-get install -y docker-engine=${VERSION} \
    && rm -rf /var/lib/apt/lists/*
    
# Group id on /var/run/docker.sock. Give permission to Jenkins to allow jenkins to run docker command
# On CoreOS host is, the id is 233 (ls -l /var/run/docker.sock). Create a new group docker1 with the id because 'docker' group already exits. 
GROUP_ID=233
RUN groupadd -g $GROUP_ID docker1 && usermod -a -G docker1 jenkins 
USER jenkins
