require 'mocha'
global.Should = require 'should'
path = require 'path'

before ->
  @fixtures = path.resolve __dirname, './fixtures'
  @bet1 = require path.join @fixtures, 'bet1.json'
  @bet2 = require path.join @fixtures, 'bet2.json'
  @bet3 = require path.join @fixtures, 'bet3.json'
  @bet4 = require path.join @fixtures, 'bet4.json'
