player = require './player'
express = require 'express'

module.exports = ->
  app = express()

  app.use express.json()
  app.use express.urlencoded()

  app.get '/', (req, res) ->
    action = req.query.action
    gameState = JSON.parse req.query.game_state ? '{}'

    console.log '/', req.query
    if req.query.action == 'bet_request'
      player.betRequest gameState, (err, bet) ->
        return next err if err
        res.send 200, bet
    else if req.query.action == 'showdown'
      player.showdown gameState, (err) ->
        res.send 200, 'OK'
    else if req.query.action == 'version'
      res.send 200, player.version()
    else
      res.send 200, 'OK'

  app.post '/', (req, res, next) ->
    action = req.body.action
    gameState = JSON.parse req.body.game_state ? '{}'

    if req.body.action == 'bet_request'
      player.betRequest gameState, (err, bet) ->
        return next err if err
        res.send 200, bet
      # res.send(200, player.bet_request(JSON.parse(req.query.game_state)).toString());
    else if req.body.action == 'showdown'
      player.showdown gameState, (err) ->
        res.send 200, 'OK'
    else if req.body.action == 'version'
      res.send 200, player.version()
    else
      res.send 200, 'OK'

  port = parseInt process.env['PORT'] ? 1337
  host = "0.0.0.0"
  app.listen port, host
  console.log "Listening at http://#{host}:#{port}"
