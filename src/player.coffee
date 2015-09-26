_ = require 'lodash'

pkg = require '../package.json'

getMinBet = require './getMinBet'
analyzeHand = require './analyzeHand'

module.exports =
  version: ->
    pkg.version
  betRequest: (gameState, next) ->
    if gameState.testBet
      return next null, gameState.testBet

    commitment = gameState.players[gameState.in_action]?.bet
    minBet = getMinBet gameState
    seriousness = minBet / (gameState.small_blind * 2)

    myHand = analyzeHand gameState

    pairs = _ myHand.all
    .groupBy (card) -> card.rankString
    .filter (group) -> group.length > 1
    .value()

    cpairs = _ myHand.community
    .groupBy (card) -> card.rankString
    .filter (group) -> group.length > 1
    .value()

    if cpairs.length == pairs.length
      pairs = []

    if commitment == 0 and seriousness > 2
      unless pairs.length > 0
        console.log 'too serious'
        return next null, 0

    if pairs.length > 0
      return next null, minBet * 10

    if seriousness > 3
      return next null, 0

    next null, minBet
  showdown: (gameState, next) ->
    next()
