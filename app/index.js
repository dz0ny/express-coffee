// Generated by CoffeeScript 1.3.3
var app, assets, express, port, stylus;

express = require('express');

stylus = require('stylus');

assets = require('connect-assets');

app = express();

app.use(assets());

app.use(express["static"](process.cwd() + '/public'));

app.set('view engine', 'jade');

app.use(express.logger());

app.enable('trust proxy');

app.use(express.cookieParser("fZFlzqGvCW0JnbxUO825hPGBaQaD7eYe2nVIosTjHUpTWqV6cg8HNo63pr8nyZnU"));

app.use(express.session());

app.use(express.bodyParser());

require('./wiki')(app);

app.use(function(err, req, res, next) {
  if (~err.message.indexOf('not found')) {
    return next();
  }
  console.error(err.stack);
  return res.status(500).render('5xx');
});

app.use(function(req, res, next) {
  return res.status(404).render('404', {
    url: req.originalUrl
  });
});

port = process.env.PORT || process.env.VMC_APP_PORT || 3000;

app.listen(port, function() {
  return console.log("Listening on " + port + "\nPress CTRL-C to stop server.");
});
