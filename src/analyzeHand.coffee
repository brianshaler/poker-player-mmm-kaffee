_ = require 'lodash'

decodeRank = require './decodeRank'

module.exports = (myCards, communityCards) ->

  processCards = (cards = []) ->
    _.map cards, (card) ->
      rankString: card.rank
      rank: decodeRank card.rank
      suit: card.suit

  hole = processCards myCards
  community = processCards communityCards

  hole: hole
  community: community
  all: hole.concat community
