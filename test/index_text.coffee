should = require('chai').should()
ChuckApi = require('../src/index.coffee')

before ->
  @chuck = new ChuckApi()

describe 'Chuck Api Reader', ->
  describe 'all', ->
    it 'should return the number of jokes', ->
      @chuck.getAllJokes().then (jokes) ->
        jokes.type.should.equal "success", "All joke request unsuccessful"
        jokes.value.length.should.equal 546,
          "Unexpected number of jokes present"

  describe 'categories', ->
    it 'should get all categories', ->
      @chuck.getCategories().then (categories) ->
        categories.type.should.equal "success", "Category request unsuccessful"
        categories.value.should.deep.equal ["explicit", "nerdy"],
          "Unexpected categories present"

  describe 'count', ->
    it 'should return the number of jokes', ->
      @chuck.getCount().then (count) ->
        count.type.should.equal "success", "Joke count request unsuccesful"
        count.value.should.equal 546, "Unexpected joke count recieved"

  describe 'random', ->
    it 'should return a random joke', ->
      @chuck.getRandom().then (random) ->
        random.type.should.equal "success", "Random joke request unsucccesful"

  describe 'specific', ->
    it 'should return a specific joke by Id', ->
      @chuck.getJoke(69).then (joke) ->
        joke.type.should.equal "success", "Specific joke request unsucccesful"
        joke.value.joke.should.equal "Scientists have estimated that the "+
          "energy given off during the Big Bang is roughly equal to 1CNRhK "+
          "(Chuck Norris Roundhouse Kick).",
          "Unexpected specific joke text"
