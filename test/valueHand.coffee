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

  it 'should value 3/6/8/Q/K lowly', ->
    myCards = [
      {rank: 'K', suit: 'diamonds'}
      {rank: '3', suit: 'clubs'}
    ]

    communityCards = [
      {rank: '6', suit: 'hearts'}
      {rank: '8', suit: 'diamonds'}
      {rank: 'Q', suit: 'spades'}
    ]

    value = valueHand analyzeHand myCards, communityCards

    value.should.be.lessThan 0.2
