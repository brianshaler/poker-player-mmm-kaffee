_ = require 'lodash'

module.exports = (allCards) ->
  variance = 8 - allCards.length

  pairs = _ myHand.all
  .groupBy (card) -> card.rankString
  .filter (group) -> group.length > 1
  .value()

  cpairs = _ myHand.community
  .groupBy (card) -> card.rankString
  .filter (group) -> group.length > 1
  .value()

  myPairs = pairs.length - cpairs.length

  value = 0

  if myPairs > 0
    value = 100

  if value > 0
    value /= variance
  value
