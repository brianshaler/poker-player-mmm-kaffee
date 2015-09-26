_ = require 'lodash'

module.exports = (gameState) ->
  minBuyIn = _.max [
    gameState.current_buy_in ? 0
    (gameState.min_blind ? 0) * 2
  ]
  myBet = gameState?.players?[gameState?.in_action]?.bet ? 0
  minBet = minBuyIn - myBet
