path = require 'path'

player = require '../src/player'

describe 'player', ->

  it 'should return an integer for bet1', (done) ->
    player.betRequest @bet1, (err, bet) ->
      Should.not.exist err
      Should.exist bet
      # console.log 'bet', bet
      done()

  it 'should return an integer for bet2', (done) ->
    player.betRequest @bet2, (err, bet) ->
      Should.not.exist err
      Should.exist bet
      # console.log 'bet', bet
      done()

  it 'should return an integer for bet3', (done) ->
    player.betRequest @bet3, (err, bet) ->
      Should.not.exist err
      Should.exist bet
      # console.log 'bet', bet
      done()

  it 'should return an integer for bet4', (done) ->
    player.betRequest @bet4, (err, bet) ->
      Should.not.exist err
      Should.exist bet
      # console.log 'bet', bet
      done()
