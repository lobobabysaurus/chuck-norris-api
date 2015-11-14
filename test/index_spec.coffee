should = require('chai').should()
ChuckApi = require('../src/index.coffee')

before ->
  @chuck = new ChuckApi()

describe 'Chuck Api Reader', ->
  describe 'all', ->
    it 'should return the corret number of jokes', ->
      @chuck.getAllJokes().then (jokes) ->
        console.log(jokes.value[455].joke)
        jokes.type.should.equal "success", "All joke request unsuccessful"
        jokes.value.length.should.equal 546,
          "Unexpected number of jokes present"

    it 'should return jokes as expected', ->
      @chuck.getAllJokes().then (jokes) ->
        jokes.type.should.equal "success", "All joke request unsuccessful"
        jokes.value[455].joke.should.equal "Chuck Norris "+
          "can access private methods."
          "Unexpected number of jokes present"

    it 'should return jokes as expected with new first name', ->
      @chuck.getAllJokes(first:"Phil").then (jokes) ->
        jokes.type.should.equal "success", "All joke request unsuccessful"
        jokes.value[455].joke.should.equal "Phil Norris "+
          "can access private methods."
          "Unexpected number of jokes present"

    it 'should return jokes as expected with new last name', ->
      @chuck.getAllJokes(last:"Simmons").then (jokes) ->
        jokes.type.should.equal "success", "All joke request unsuccessful"
        jokes.value[455].joke.should.equal "Chuck Simmons "+
          "can access private methods."
          "Unexpected number of jokes present"

    it 'should return jokes as expected with new full name', ->
      @chuck.getAllJokes({first:"Phil", last:"Simmons"}).then (jokes) ->
        jokes.type.should.equal "success", "All joke request unsuccessful"
        jokes.value[455].joke.should.equal "Phil Simmons "+
          "can access private methods."
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
        random.value.joke.should.contain "Chuck",
          "Random joke not a Chuck Norris joke"

    it 'should return a random joke with new first name', ->
      @chuck.getRandom(first:"Phil").then (random) ->
        random.type.should.equal "success", "Random joke request unsucccesful"
        random.value.joke.should.contain "Phil",
          "Random joke not a Chuck Norris joke with new first name"

    it 'should return a random joke with new last name', ->
      @chuck.getRandom(last:"Simmons").then (random) ->
        random.type.should.equal "success", "Random joke request unsucccesful"
        random.value.joke.should.contain "Simmons",
          "Random joke not a Chuck Norris joke with new last name"

    it 'should return a random joke with new full name', ->
      @chuck.getRandom({first:"Phil", last:"Simmons"}).then (random) ->
        random.type.should.equal "success", "Random joke request unsucccesful"
        random.value.joke.should.contain "Phil Simmons",
          "Random joke not a Chuck Norris joke with new full name"

  describe 'specific', ->
    it 'should return a specific joke by Id', ->
      @chuck.getJoke(469).then (joke) ->
        joke.type.should.equal "success", "Specific joke request unsucccesful"
        joke.value.joke.should.equal "Chuck Norris can unit test entire " +
          "applications with a single assert.",
          "Unexpected specific joke text"

    it 'should return a specific joke by Id with new first name', ->
      @chuck.getJoke(469, first:"Phil").then (joke) ->
        joke.type.should.equal "success", "Specific joke request unsucccesful"
        joke.value.joke.should.equal "Phil Norris can unit test entire " +
          "applications with a single assert.",
          "Unexpected specific joke text with new first name"

    it 'should return a specific joke by Id with new last name', ->
      @chuck.getJoke(469, last:"Simmons").then (joke) ->
        joke.type.should.equal "success", "Specific joke request unsucccesful"
        joke.value.joke.should.equal "Chuck Simmons can unit test entire " +
          "applications with a single assert."
          "Unexpected specific joke text with new last name"

    it 'should return a specific joke by Id with new first and last name', ->
      @chuck.getJoke(469, {first:"Phil", last:"Simmons"}).then (joke) ->
        joke.type.should.equal "success", "Specific joke request unsucccesful"
        joke.value.joke.should.equal "Phil Simmons can unit test entire " +
          "applications with a single assert."
          "Unexpected specific joke text with new full name"
