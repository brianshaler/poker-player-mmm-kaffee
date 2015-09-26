_ = require 'lodash'

detectStraight = require './detectStraight'

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

  suits = _ hand.all
  .groupBy (card) -> card.suit
  .value()

  myPairs = pairs.length - cpairs.length

  threeOrMore = _.find pairs, (group) ->
    group.length > 2
  if !!threeOrMore
    return 1

  value = 0

  if myPairs > 0 and pairs.length > 0
    return 1

  if detectStraight hand.all, 5
    return 1

  if hand.all.length < 6 and detectStraight hand.all, 4
    return 0.5

  if hand.all.length < 7 and detectStraight hand.all, 4
    value = 0.5

  if suits.length == 1
    value = value + (1 - value) * 0.5

  if myPairs > 0
    if hand.all.length < 4
      return 1
    else
      value = 1
  else
    value -= 0.1

  if hand.community.length == 0
    if hand.hole[0].suit == hand.hole[1].suit
      return 1
    if detectStraight hand.all, 2
      return 0.5

  if hand.community.length < 3 or value > 0
    highCards = _.filter hand.hole, (card) -> card.rank > 10
    if highCards.length > 0
      value = value + (highCards.length / hand.all.length - value) * 0.5
      if hand.community.length == 0
        return highCards.length / 2
    else
      value -= 0.1

  if value > 0
    value /= variance

  value
