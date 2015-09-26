(function() {
  var pkg;

  pkg = require('../package.json');

  module.exports = {
    version: function() {
      return pkg.version;
    },
    betRequest: function(gameState, next) {
      var bet, minBet;
      if (gameState.testBet) {
        return next(null, gameState.testBet);
      }
      minBet = gameState.small_blind * 2;
      bet = gameState.current_buy_in;
      if (!(bet > minBet)) {
        bet = minBet;
      }
      return next(null, bet);
    },
    showdown: function(gameState, next) {
      return next();
    }
  };

}).call(this);
