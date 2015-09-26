decodeRank = require '../src/decodeRank'

describe 'decodeRank', ->

  it 'should decode rank of a number', ->
    decodeRank('2').should.equal 0
    decodeRank(2).should.equal 0
    decodeRank('10').should.equal 8
    decodeRank(10).should.equal 8

  it 'should decode rank of a face card', ->
    decodeRank('q').should.equal 10
    decodeRank('Q').should.equal 10

  it 'should return -1 for unknown values', ->
    decodeRank('!').should.equal -1
    decodeRank().should.equal -1
    decodeRank('z').should.equal -1
