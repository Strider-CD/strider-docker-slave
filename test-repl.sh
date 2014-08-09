#!/bin/sh

docker run \
  -a stdout \
  -a stderr \
  -a stdin \
  -it --rm \
  --name testing-strider-docker-slave \
  keyvanfatehi/strider-docker-slave StriderSlave

docker rm -f testing-strider-docker-slave 2>&1 > /dev/null
