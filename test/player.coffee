path = require 'path'

player = require '../src/player'

describe 'player', ->

  it 'should return gameState.testBet', (done) ->
    player.betRequest @bet4, (err, bet) ->
      Should.not.exist err
      Should.exist bet
      console.log 'bet', bet
      done()
