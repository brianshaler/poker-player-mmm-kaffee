pkg = require '../package.json'

decodeRank = require './decodeRank'

module.exports =
  version: ->
    pkg.version
  betRequest: (gameState, next) ->
    if gameState.testBet
      return next null, gameState.testBet
    minBet = gameState.small_blind * 2
    bet = gameState.current_buy_in
    bet = minBet unless bet > minBet

    me = gameState?.players?[gameState?.in_action]
    if me.hole_cards?.length == 1
      card = me.hole_cards[0]
      value = decodeRank card.rank
      if value < 10
        return next null, 0

    unless me.hole_cards?.length > 1
      return next null, bet

    next null, bet
  showdown: (gameState, next) ->
    next()
