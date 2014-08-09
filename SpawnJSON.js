#!/usr/bin/env node
/* Run the command -- execute one 
 * {"command":"sh","args":["-x","-c","echo 'hello'"]}
 */
var spawn = require('child_process').spawn
  , JSONStream = require('JSONStream')
  , json = ""

process.stdin.resume();
process.stdin.setEncoding('utf8');
process.stdin.on('data', function(chunk) {
  json+=chunk.toString()
});

process.stdin.on('finish', function(chunk) {
  var workload = JSON.parse(json)
  var proc = spawn(workload.command, workload.args)
  proc.stdout.on('data', function (data) {
    process.stdout.write(data)
  });
  proc.stderr.on('data', function (data) {
    process.stderr.write(data)
  });
  proc.on('close', function (code) {
    process.exit(code)
  });
});

var stream = JSONStream.parse(['rows', true, 'doc']) //rows, ANYTHING, doc

stream.on('data', function(data) {
  console.log('received:', data);
});

stream.on('root', function(root, count) {
  if (!count) {
    console.log('no matches found:', root);
  }
});
