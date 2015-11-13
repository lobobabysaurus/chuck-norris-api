assert = require('assert')
ChuckApi = require('../src/index.coffee')

before ->
  @chuck = new ChuckApi()

describe 'Chuck Api Reader', ->
  describe 'all', ->
    it 'should return the number of jokes', ->
      @chuck.getAllJokes().then (data) ->
        assert.equal(data.type, "success")
        assert.equal(data.value.length, 546)

  describe 'count', ->
    it 'should return the number of jokes', ->
      @chuck.getCount().then (data) ->
        assert.equal(data.type, "success")
        assert.equal(data.value, 546)

  describe 'random', ->
    it 'should return a random joke', ->
      @chuck.getRandom().then (data) ->
        assert.equal(data.type, "success")
