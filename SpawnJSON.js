#!/usr/bin/env node
/* Pipe JSON like the following into me to spawn it
 * {"command":"sh","args":["-x","-c","echo 'hello'"]}
 */
var spawn = require('child_process').spawn
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
