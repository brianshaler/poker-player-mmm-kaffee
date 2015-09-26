module.exports =
  betRequest: (gameState, next) ->
    if gameState.testBet
      return next null, gameState.testBet
    next null, gameState.current_buy_in
