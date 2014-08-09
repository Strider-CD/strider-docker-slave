# DOCKER-VERSION 1.0.0

FROM ubuntu:14.04
MAINTAINER Keyvan Fatehi <keyvanfatehi@gmail.com>

RUN apt-get -y update

# Node.js and Git are required
RUN apt-get -y install nodejs npm git
RUN update-alternatives --install /usr/bin/node node /usr/bin/nodejs 10

# git wants this
RUN locale-gen en_US.UTF-8

# Setup workspace and user
RUN mkdir /workspace
RUN adduser --home /workspace --gecos "" strider
RUN chown strider /workspace

# Get the slave
RUN npm install -g strider-docker-slave@1.*.*
CMD strider-docker-slave

# So strider can install packages & use the cache
RUN chown strider /.npm

WORKDIR /workspace
USER strider

# Other packages that people might want:
# - make
# - build-essential
# - python-dev
# - default-jre-headless
# - ruby

