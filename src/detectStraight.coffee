_ = require 'lodash'

module.exports = (cards, threshold = 5) ->
  ranks = _.pluck cards, 'rank'
  ranks.sort()

  for rank in ranks
    tally = 1
    for i in [rank+1..rank+4] by 1
      if -1 < ranks.indexOf i
        tally++
    if tally >= threshold
      return true
  false
