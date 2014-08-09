#!/usr/bin/env node
/* Run the command -- execute one 
 * {"command":"sh","args":["-x","-c","echo 'hello'"]}
 * or
 * {"type": "kill"} to kill the previously run command
 *
 * The stdout contains jsonified events,
 * {event: 'stdout', data: 'string'}
 * {event: 'stderr', data: 'string'}
 * {event: 'exit', code: int}
 */
var spawn = require('child_process').spawn
  , es = require('event-stream')
  , json = ""

process.stdin.resume();
process.stdin.setEncoding('utf8');
process.stdin
  .pipe(es.split())
  .pipe(es.parse())
  .pipe(es.mapSync(queue))

var _queue = []
var running = false

function queue(data) {
  if (data.type === 'kill') {
    if (running && !_queue.length) running.kill()
    else _queue[_queue.length-1].killed = true
  } else {
    _queue.push(data)
    if (!running) next()
  }
}

function next() {
  if (!_queue.length) return running = false
  var first = _queue.shift()
  run(first, next)
}

function run(data, cb) {
  if (data.killed) {
    done(500)
    return cb()
  }

  var proc
  try {
    proc = spawn(data.command, data.args)
  } catch (e) {
    done(127)
    return cb()
  }

  proc.on('error', function (err) {
    event("stderr", {data: "Error: " + err.message})
  })

  proc.stdout.setEncoding('utf8')
  proc.stderr.setEncoding('utf8')

  proc.stdout
    .pipe(out('stdout'))
    .pipe(process.stdout)
  proc.stderr
    .pipe(out('stderr'))
    .pipe(process.stdout)
  proc.on('close', function (code) {
    done(code)
    running = false
    cb(null, code + '')
  })

  running = proc
}

function done(code) {
  event('exit', {code: code})
}

function event(name, body) {
  body.event = name
  process.stdout.write(JSON.stringify(body) + '\n')
}

function out(which) {
  return es.map(function (data, cb) {
    cb(null, JSON.stringify({event: which, data: data}) + '\n')
  })
}

