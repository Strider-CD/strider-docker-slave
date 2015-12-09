#!/bin/sh

exec ssh -i /home/strider/keyfile -o StrictHostKeyChecking=no "$@"
