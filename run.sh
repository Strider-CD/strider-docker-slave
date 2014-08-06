#!/bin/bash

PASSWORD=$1
if [ -z $PASSWORD ]; then
  PASSWORD=$(cat /dev/urandom | env LC_CTYPE=C tr -dc 'a-zA-Z0-9' | fold -w 20 | head -n 1)
fi
echo Use this password to login by ssh: $PASSWORD

echo 'strider:'$PASSWORD | chpasswd

/usr/sbin/sshd -D

