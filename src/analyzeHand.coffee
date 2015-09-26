_ = require 'lodash'

decodeRank = require './decodeRank'

module.exports = (gameState) ->
  me = gameState.players[gameState.in_action]

  processCards = (cards = []) ->
    _.map cards, (card) ->
      rankString: card.rank
      rank: decodeRank card.rank
      suit: card.suit

  hole = processCards me.hole_cards
  community = processCards me.community_cards

  hole: hole
  community: community
  all: hole.concat community
