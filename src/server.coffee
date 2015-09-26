player = require './player'
express = require 'express'

analyzeHand = require './analyzeHand'

module.exports = ->
  app = express()

  app.use express.json()
  app.use express.urlencoded()

  app.all '/', (req, res, next) ->
    action = req.body?.action ? req.query?.action
    gameState = req.body?.game_state ? req.query?.game_state
    console.log '/', action, gameState
    if typeof gameState is 'string'
      try
        gameState = JSON.parse gameState
      catch err
        # return next err
        console.log err
        return res.send null, 0

    if action == 'bet_request'
      player.betRequest gameState, (err, bet) ->
        if err
          console.log err
          return res.send null, 0
        hand = analyzeHand gameState
        logs = [
          JSON.stringify gameState
          JSON.stringify hand.hole
          "betting #{bet}"
        ].join '\n'
        console.log logs
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
