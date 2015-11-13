assert = require('assert')
ChuckApi = require('../src/index.coffee')

describe 'Chuck Api Reader', ->
  describe 'count', ->
    it 'should return the number of jokes', ->
      console.log(ChuckApi)
      chuck = new ChuckApi()
      chuck.getCount().then (data) ->
        assert.equal(data, 546)
