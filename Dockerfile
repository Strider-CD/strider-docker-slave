# DOCKER-VERSION 1.0.0

FROM ubuntu:14.04
MAINTAINER Keyvan Fatehi <keyvanfatehi@gmail.com>

RUN apt-get -y update

# Todo split this up - not all containers need/want all this
RUN apt-get -y install nodejs npm git make build-essential libssl-dev python python-dev git default-jre-headless

RUN locale-gen en_US.UTF-8

RUN update-alternatives --install /usr/bin/node node /usr/bin/nodejs 10

RUN mkdir /workspace

RUN adduser --home /workspace --gecos "" strider

RUN chown strider /workspace

RUN mkdir /loader && cd /loader && mkdir node_modules && npm install event-stream
ADD SpawnJSON.js /loader/SpawnJSON.js
RUN ln -s /loader/SpawnJSON.js /usr/bin/

WORKDIR /workspace

RUN chown strider /.npm

USER strider
