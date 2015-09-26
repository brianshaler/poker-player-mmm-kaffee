path = require 'path'

player = require '../src/player'

describe 'player', ->

  it 'should return gameState.testBet', (done) ->
    player.betRequest @bet1, (err, bet) ->
      Should.not.exist err
      Should.exist bet
      done()
