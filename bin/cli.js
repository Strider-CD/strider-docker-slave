
/**
 * The command line entry point. No options at this point. Treats stdout/stdin
 * as a JSON eventemitter
 */

var Runner = require('strider-simple-runner')

var emitter = new EE()
var runner = new Runner(emitter, {});

// yaay mokeypatch it up
emitter.receive = emitter.emit
emitter.emit = function () {
}


