pkg = require '../package.json'

decodeRank = require './decodeRank'

module.exports =
  version: ->
    pkg.version
  betRequest: (gameState, next) ->
    if gameState.testBet
      return next null, gameState.testBet
    bigBlind = gameState.small_blind * 2
    minBet = bigBlind
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

    cards = _.map me.hole_cards, (card) ->
      suit: card.suit
      rank: decodeRank card.rank

    communityCards = _.map (me.community_cards ? []), (card) ->
      suit: card.suit
      rank: decodeRank card.rank

    if cards[0]?.rank == cards[0]?.rank
      return next null, bigBlind

    allCards = cards.concat communityCards

    pairs = _ allCards
    .groupBy (card) -> String card.rank
    .filter (group) -> group.length > 1
    .value()

    if pairs.length > 0
      return next null, bigBlind

    next null, bet
  showdown: (gameState, next) ->
    next()
