var player = require('./lib/player');
var express = require('express');
var app = express();

app.use(express.json());
app.use(express.urlencoded());

app.get('/', function(req, res){
  console.log('/', req.query);
  if(req.query.action == 'bet_request') {
    gameState = JSON.parse(req.query.game_state);
    player.betRequest(gameState, function (err, bet) {
      if (err) return next(err);
      res.send(200, bet);
    });
    // res.send(200, player.bet_request(JSON.parse(req.query.game_state)).toString());
  } else if(req.query.action == 'showdown') {
    gameState = JSON.parse(req.query.game_state);
    player.showdown(gameState, function (err) {
      res.send(200, 'OK');
    });
  } else if(req.query.action == 'version') {
    res.send(200, player.version());
  } else {
    res.send(200, 'OK')
  }
});

app.post('/', function(req, res, next){
  if(req.body.action == 'bet_request') {
    gameState = JSON.parse(req.body.game_state).toString();
    player.betRequest(gameState, function (err, bet) {
      if (err) return next(err);
      res.send(200, bet);
    });
    // res.send(200, player.bet_request(JSON.parse(req.body.game_state)).toString());
  } else if(req.body.action == 'showdown') {
    player.showdown(JSON.parse(req.body.game_state));
    res.send(200, 'OK');
  } else if(req.body.action == 'version') {
    res.send(200, player.VERSION);
  } else {
    res.send(200, 'OK')
  }

});

port = parseInt(process.env['PORT'] || 1337);
host = "0.0.0.0";
app.listen(port, host);
console.log('Listening at http://' + host + ':' + port)
