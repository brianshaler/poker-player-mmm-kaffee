module.exports =
  betRequest: (gameState, next) ->
    if gameState.testBet
      return next null, gameState.testBet
    minBet = gameState.small_blind * 2
    bet = gameState.current_buy_in
    bet = minBet unless bet > minBet
    next null, bet
