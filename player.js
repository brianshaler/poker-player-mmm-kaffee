var pkg = require('./package.json');

module.exports = {

  VERSION: pkg.version,

  bet_request: function(game_state) {
    return 100;
  },

  showdown: function(game_state) {

  }
};
