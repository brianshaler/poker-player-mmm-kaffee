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

    myCards = gameState.players[gameState.in_action].hole_cards
    communityCards = gameState.community_cards
    hand = analyzeHand myCards, communityCards
    value = valueHand hand

    if commitment == 0
      if seriousness > 2 and value < 0.5
        console.log 'too serious'
        return next null, 0
      if seriousness > 5 and value < 0.8
        console.log 'too serious'
        return next null, 0

    if communityCards.length == 0
      if value >= 0.5
        return next null, 600

    if value > 0
      bet = (gameState.small_blind * 2) * 2
      bet = minBet if bet < minBet
      if value < 0.5 and seriousness > 2
        return next null, 0
      return next null, bet

    if seriousness > value * 5
      return next null, 0

    next null, minBet
  showdown: (gameState, next) ->
    next()
