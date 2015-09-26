player = require '../src/player'

describe 'player', ->

  it 'should return gameState.testBet', (done) ->

    testBet = 100
    player.betRequest testBet, (err, bet) ->
      Should.not.exist err
      Should.exist bet
      bet.should.equal testBet
      done()
