_ = require 'lodash'

module.exports = (hand) ->
  variance = 8 - hand.all.length

  pairs = _ hand.all
  .groupBy (card) -> card.rankString
  .filter (group) -> group.length > 1
  .value()

  cpairs = _ hand.community
  .groupBy (card) -> card.rankString
  .filter (group) -> group.length > 1
  .value()

  myPairs = pairs.length - cpairs.length

  value = 0

  if myPairs > 0
    value += 1
  else
    value -= 0.1

  highCards = _.filter hand.hole, (card) -> card.rank > 10

  if highCards.length > 0
    value = value + (highCards.length / hand.all.length) * 0.5

  if value > 0
    value /= variance

  value
