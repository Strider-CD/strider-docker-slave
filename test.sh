#!/bin/sh

cat <<EOF | node
require('fs').writeFileSync('./test.json', JSON.stringify({
  command: "sh",
  args: ["-x", "-c", "echo 'hello'"]
}))
EOF


docker run \
  -i -a stdout \
  --name testing-strider-docker-slave \
  keyvanfatehi/strider-docker-slave SpawnJSON.js < test.json

docker rm testing-strider-docker-slave 2>&1 > /dev/null
