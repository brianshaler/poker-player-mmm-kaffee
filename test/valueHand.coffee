analyzeHand = require '../src/analyzeHand'
valueHand = require '../src/valueHand'

describe 'valueHand', ->

  it 'should value 8/2 lowly', ->
    myCards = [
      {rank: '8', suit: 'clubs'}
      {rank: '2', suit: 'hearts'}
    ]
    communityCards = []

    value = valueHand analyzeHand myCards, communityCards

    value.should.be.lessThan 0

  it 'should value A/A highly', ->
    myCards = [
      {rank: 'A', suit: 'clubs'}
      {rank: 'A', suit: 'hearts'}
    ]
    communityCards = []

    value = valueHand analyzeHand myCards, communityCards

    value.should.be.greaterThan 0.9
