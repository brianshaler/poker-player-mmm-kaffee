_ = require 'lodash'

pkg = require '../package.json'

getMinBet = require './getMinBet'
analyzeHand = require './analyzeHand'
valueHand = require './valueHand'

module.exports =
  version: ->
    pkg.version
  betRequest: (gameState, next) ->
    if gameState.testBet
      return next null, gameState.testBet

    commitment = gameState.players[gameState.in_action]?.bet
    minBet = getMinBet gameState
    seriousness = minBet / (gameState.small_blind * 2)

    hand = analyzeHand gameState
    value = valueHand hand

    if commitment == 0 and seriousness > 2
      unless value > 0
        console.log 'too serious'
        return next null, 0

    if value > 0
      bet = (gameState.small_blind * 2) * 2
      bet = minBet if bet < minBet
      return next null, bet

    if seriousness > value * 5
      return next null, 0

    next null, minBet
  showdown: (gameState, next) ->
    next()
