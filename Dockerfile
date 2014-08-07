# DOCKER-VERSION 1.0.0

from ubuntu:14.04
maintainer Jared Forsyth <jared@jaredforsyth.com>

# create strider user
run useradd -m strider

# update package cache and install some packages
run apt-get -y update
run apt-get -y install nodejs npm git make build-essential openssh-server libssl-dev python python-dev git default-jre-headless

# create a link to nodejs called node
run update-alternatives --install /usr/bin/node node /usr/bin/nodejs 10

# create the sshd directory
run mkdir -p /var/run/sshd

# turn off pam otherwise the ssh login will not work
run sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config
run sed -ri 's/#UsePAM no/UsePAM no/g' /etc/ssh/sshd_config

add run.sh /run.sh

# start ssh server on run
cmd "/run.sh"

run mkdir /data

run chown strider:strider /data

run locale-gen en_US.UTF-8

# 22 is ssh server
# You can find out what port it is mapped to on your host by running `docker ps`
expose 22
