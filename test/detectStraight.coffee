detectStraight = require '../src/detectStraight'

describe 'detectStraight', ->

  it 'should detect a straight', ->
    cards = [
      {rank: 4}
      {rank: 1}
      {rank: 3}
      {rank: 2}
      {rank: 0}
    ]
    detectStraight(cards).should.equal true

  it 'should return false for not a straight', ->
    cards = [
      {rank: 4}
      {rank: 1}
      {rank: 5}
      {rank: 2}
      {rank: 0}
    ]
    detectStraight(cards).should.equal false

  it 'should return false for a partial straight', ->
    cards = [
      {rank: 1}
      {rank: 5}
      {rank: 2}
      {rank: 0}
    ]
    detectStraight(cards).should.equal false

  it 'should return true for a partial straight with a lower threshold', ->
    cards = [
      {rank: 1}
      {rank: 4}
      {rank: 2}
      {rank: 0}
    ]
    detectStraight(cards, cards.length).should.equal true
