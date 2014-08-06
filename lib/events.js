
var EventEmitter2 = require('eventemitter2').EventEmitter2
var es = require('event-stream')

module.exports = Events

function Events(emitter) {
  this.listen()
  this.emitter = emitter || new EventEmitter2()
}

Events.prototype = {
  emit: function (event) {
    process.stdout.write(JSON.stringify({
      event: event,
      arguments: [].slice.call(arguments, 1)
    }) + '\n')
  },
  on: function () {
    this.emitter.on.apply(this.emitter, arguments)
  },
  listen: function () {
    var that = this
    process.stdin
      .pipe(es.split())
      .pipe(es.parse())
      .pipe(es.through(function write(data) {
        if (!data.event || !data.arguments) {
          console.error('bad event came through!', data)
          return
        }

        that.emitter.emit.apply(that.emitter, [data.event].concat(data.arguments))
      }, function end() {
        console.error('Closing up shop!')
      }))
  }
}

