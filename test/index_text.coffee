assert = require('assert')
ChuckApi = require('../src/index.coffee')

before ->
  @chuck = new ChuckApi()

describe 'Chuck Api Reader', ->
  describe 'all', ->
    it 'should return the number of jokes', ->
      @chuck.getAllJokes().then (jokes) ->
        assert.equal jokes.type, "success", "All joke request unsuccessful"
        assert.equal jokes.value.length, 546,
          "Unexpected number of jokes present"

  describe 'categories', ->
    it 'should get all categories', ->
      @chuck.getCategories().then (categories) ->
        assert.equal categories.type, "success", "Category request unsuccessful"
        assert.deepEqual categories.value, ["explicit", "nerdy"],
          "Unexpected categories present"

  describe 'count', ->
    it 'should return the number of jokes', ->
      @chuck.getCount().then (count) ->
        assert.equal count.type, "success", "Joke count request unsuccesful"
        assert.equal count.value, 546, "Unexpected joke count recieved"

  describe 'random', ->
    it 'should return a random joke', ->
      @chuck.getRandom().then (random) ->
        assert.equal random.type, "success", "Random joke request unsucccesful"

  describe 'specific', ->
    it 'should return a specific joke by Id', ->
      @chuck.getJoke(69).then (joke) ->
        assert.equal joke.type, "success",
          "Specific joke request unsucccesful"
        assert.equal joke.value.joke,
          "Scientists have estimated that the energy given off during the " +
          "Big Bang is roughly equal to 1CNRhK (Chuck Norris Roundhouse Kick).",
          "Unexpected specific joke text"
