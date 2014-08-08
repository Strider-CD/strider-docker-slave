#!/bin/sh

cat <<EOF | node
require('fs').writeFileSync('./test.json', JSON.stringify({
  command: "sh",
  args: ["-x", "-c", "echo 'hello'"]
}))
EOF

echo "local test"
cat ./test.json | ./SpawnJSON.js
echo "local test over"

#docker run keyvanfatehi/strider
