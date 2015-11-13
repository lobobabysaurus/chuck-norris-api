assert = require('assert')
ChuckApi = require('../src/index.coffee')

describe 'Chuck Api Reader', ->
  describe 'count', ->
    it 'should return the number of jokes', ->
      chuck = ChuckApi()
      chuck.getCount().then (data) ->
        assert.equal(data, 546)
