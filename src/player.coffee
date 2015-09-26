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

    me = gameState.players[gameState.in_action]
    commitment = me.bet
    minBet = getMinBet gameState
    minBet = minBet + Math.round Math.random() * 2
    maxBet = me.stack * 0.8
    maxBet = minBet unless maxBet < minBet
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
        bet = if gameState.players[0]?.status == 'active'
          700
        else
          200
        bet = maxBet unless bet < maxBet
        bet = minBet unless bet > minBet
        return next null, maxBet
      unless value < 0.1
        return next null, minBet

    if value > 0
      bet = (gameState.small_blind * 2) * 2
      bet = minBet unless bet > minBet
      if value >= 0.5
        bet = me.stack * 0.5
      if value < 0.5 and seriousness > 2
        unless minBet < me.bet * 1.2
          return next null, 0
      return next null, bet

    if seriousness > value * 5 and minBet > me.bet * 1.2
      return next null, 0

    next null, minBet
  showdown: (gameState, next) ->
    next()
