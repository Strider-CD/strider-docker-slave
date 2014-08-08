# DOCKER-VERSION 1.0.0

FROM ubuntu:14.04
MAINTAINER Keyvan Fatehi <keyvanfatehi@gmail.com>

RUN useradd -m strider

RUN apt-get -y update

RUN apt-get -y install nodejs npm git make build-essential libssl-dev python python-dev git default-jre-headless

RUN npm install -g mocha istanbul

RUN locale-gen en_US.UTF-8

RUN update-alternatives --install /usr/bin/node node /usr/bin/nodejs 10

RUN mkdir /workspace

RUN chown strider:strider /workspace

USER strider

WORKDIR /data

ADD SpawnJSON.js /usr/bin/SpawnJSON.js

# go kick ass
