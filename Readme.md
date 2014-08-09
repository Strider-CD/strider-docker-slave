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
USER strider # set the user back to strider at the end
```

