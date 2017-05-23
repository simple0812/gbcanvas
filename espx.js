var espx, exports, persist, router, server, store, web;

exports = module.exports = espx = {};

web = require('esp/lib/web');

persist = require('esp/lib/persist');

store = persist.Store.instance();

router = new web.Router;

server = new web.Server(router);

espx.Model = persist.Model;

espx.run = function(port) {
  store.load(function() {
    return console.log("store loaded");
  });
  return server.run(port);
};

espx.route = function(callback) {
  if (callback != null) {
    return callback.apply(router);
  }
};

espx.auth = function(login, auth) {
  router.login = login;
  if (auth != null) {
    return router.auth = auth;
  }
};

espx.store = store;
espx.router = router;
espx.server = server;
espx.store = store;

