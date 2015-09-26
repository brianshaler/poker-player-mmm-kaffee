(function() {
  var express, player;

  player = require('./player');

  express = require('express');

  module.exports = function() {
    var app, host, port, ref;
    app = express();
    app.use(express.json());
    app.use(express.urlencoded());
    app.get('/', function(req, res) {
      var action, gameState, ref;
      action = req.query.action;
      gameState = JSON.parse((ref = req.query.game_state) != null ? ref : '{}');
      console.log('/', req.query);
      if (req.query.action === 'bet_request') {
        return player.betRequest(gameState, function(err, bet) {
          if (err) {
            return next(err);
          }
          return res.send(200, bet);
        });
      } else if (req.query.action === 'showdown') {
        return player.showdown(gameState, function(err) {
          return res.send(200, 'OK');
        });
      } else if (req.query.action === 'version') {
        return res.send(200, player.version());
      } else {
        return res.send(200, 'OK');
      }
    });
    app.post('/', function(req, res, next) {
      var action, gameState, ref;
      action = req.body.action;
      gameState = JSON.parse((ref = req.body.game_state) != null ? ref : '{}');
      if (req.body.action === 'bet_request') {
        return player.betRequest(gameState, function(err, bet) {
          if (err) {
            return next(err);
          }
          return res.send(200, bet);
        });
      } else if (req.body.action === 'showdown') {
        return player.showdown(gameState, function(err) {
          return res.send(200, 'OK');
        });
      } else if (req.body.action === 'version') {
        return res.send(200, player.version());
      } else {
        return res.send(200, 'OK');
      }
    });
    port = parseInt((ref = process.env['PORT']) != null ? ref : 1337);
    host = "0.0.0.0";
    app.listen(port, host);
    return console.log("Listening at http://" + host + ":" + port);
  };

}).call(this);
