(function() {
  var cards;

  cards = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A'];

  module.exports = function(rank) {
    rank = String(rank).toUpperCase();
    return cards.indexOf(rank);
  };

}).call(this);
