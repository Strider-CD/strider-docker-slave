# Strider Docker Slave

This repo describes the base docker image for running strider jobs.

To test the slave,

```bash
./slave.js < lots.json
```

And look at the great output.

# Basing images off of this

If you want to add more packages, etc. here's how to do it:

```
# My java dockerfile
FROM strider/strider-docker-slave

USER root # so we have permission to install things
RUN apt-get install -y build-essential default-jre-headless
```

## Background services
You can also add Background services to the container.
This can be done by placing a supervisor config file (a text file
with the suffix '.conf') for the service into 
```/etc/supervisor/conf.d/```.

A config file may look like the following:
```
[program:dnsmasq]
command=/usr/sbin/dnsmasq -k
autostart=true
autorestart=true
user=root
```

### Full example for dnsmasq
```
FROM strider/strider-docker-slave

USER root
RUN apt-get install -y dnsmasq
# Note: supervisor-dnsmasq.conf is the supervisor config
# file shown above
ADD supervisor-dnsmasq.conf /etc/supervisor/conf.d/

# additional configuration of dnsmasq itself
# [...]
```
