const repl = require('repl');

const r = repl.start({
  ignoreUndefined: true
});

r.context.rxjs = require('rxjs');
