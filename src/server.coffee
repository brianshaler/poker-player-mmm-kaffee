player = require './player'
express = require 'express'

module.exports = ->
  app = express()

  app.use express.json()
  app.use express.urlencoded()

  app.all '/', (req, res, next) ->
    console.log '/', action
    action = req.body?.action ? req.query?.action
    gameState = req.body?.game_state ? req.query?.game_state
    if typeof gameState is 'string'
      try
        gameState = JSON.parse gameState
      catch err
        return next err

    if action == 'bet_request'
      player.betRequest gameState, (err, bet) ->
        return next err if err
        res.send 200, bet
    else if action == 'showdown'
      player.showdown gameState, (err) ->
        res.send 200, 'OK'
    else if action == 'version'
      res.send 200, player.version()
    else
      res.send 200, 'OK'

  port = parseInt process.env['PORT'] ? 1337
  host = "0.0.0.0"
  app.listen port, host
  console.log "Listening at http://#{host}:#{port}"
