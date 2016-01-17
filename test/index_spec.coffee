should = require('chai').should()
Promise = require('promise')

chuckApi = require('../src/index.coffee')


describe 'Chuck Api Reader', ->

  describe 'all', ->

    it 'should return the correct number of jokes', ->
      chuckApi.getAllJokes().then (jokes) ->
        jokes.type.should.equal 'success', 'All joke request unsuccessful'
        jokes.value.length.should.be.above 500,
          'Unexpected number of jokes present'

    it 'should return jokes as expected', ->
      chuckApi.getAllJokes().then (jokes) ->
        jokes.type.should.equal 'success', 'All joke request unsuccessful'
        jokes.value[455].joke.should.equal 'Chuck Norris '+
          'can access private methods.'
          'Unexpected number of jokes present'

    it 'should return jokes as expected with new first name', ->
      chuckApi.getAllJokes(firstName:'Phil').then (jokes) ->
        jokes.type.should.equal 'success', 'All joke request unsuccessful'
        jokes.value[455].joke.should.equal 'Phil Norris '+
          'can access private methods.'
          'Unexpected number of jokes present'

    it 'should return jokes as expected with new last name', ->
      chuckApi.getAllJokes(lastName:'Simmons').then (jokes) ->
        jokes.type.should.equal 'success', 'All joke request unsuccessful'
        jokes.value[455].joke.should.equal 'Chuck Simmons '+
          'can access private methods.'
          'Unexpected number of jokes present'

    it 'should return jokes as expected with new full name', ->
      chuckApi.getAllJokes({firstName:'Phil', lastName:'Simmons'})
        .then (jokes) ->
          jokes.type.should.equal 'success', 'All joke request unsuccessful'
          jokes.value[455].joke.should.equal 'Phil Simmons '+
            'can access private methods.'
            'Unexpected number of jokes present'

    it 'should only return jokes with specified category in limitTo', ->
      chuckApi.getAllJokes({limitTo:['explicit']}).then (jokes) ->
        jokes.type.should.equal 'success', 'All joke request unsuccessful'
        for joke in jokes.value
          joke.categories.should.contain 'explicit',
            'Not returning jokes with proper category'

    it 'should not return jokes with specified category in exclude', ->
      chuckApi.getAllJokes({exclude:['explicit']}).then (jokes) ->
        jokes.type.should.equal 'success', 'All joke request unsuccessful'
        for joke in jokes.value
          joke.categories.should.not.contain 'explicit',
            'Returning jokes with excluded category'


  describe 'categories', ->

    it 'should get all categories', ->
      chuckApi.getCategories().then (categories) ->
        categories.type.should.equal 'success', 'Category request unsuccessful'
        categories.value.should.deep.equal ['explicit', 'nerdy'],
          'Unexpected categories present'


  describe 'count', ->

    it 'should return the number of jokes', ->
      chuckApi.getCount().then (count) ->
        count.type.should.equal 'success', 'Joke count request unsuccesful'
        count.value.should.be.above 500, 'Unexpected joke count recieved'


  describe 'random', ->

    it 'should return a random joke', ->
      chuckApi.getRandom().then (random) ->
        random.type.should.equal 'success', 'Random joke request unsucccesful'
        random.value.joke.should.contain 'Chuck',
          'Random joke not a Chuck Norris joke'

    it 'should return multiple random jokes when specified', ->
      chuckApi.getRandom(number:3).then (random) ->
        random.type.should.equal 'success', 'Random joke request unsucccesful'
        random.value.length.should.equal 3,
          'Unexpected number of random jokes returned'

    it 'should return a random joke with new first name', ->
      has_name = false
      for i in [1..10]
        chuckApi.getRandom(firstName:'Phil').then (random) ->
          random.type.should.equal 'success', 'Random joke request unsucccesful'
          if random.value.joke.indexOf('Phil') > -1
            has_name = true
      setTimeout -> has_name.should.be.true 'Random joke not a Chuck Norris' +
        'joke with new first name', 2500

    it 'should return a random joke with new last name', ->
      has_name = false
      for i in [1..10]
        chuckApi.getRandom(lastName:'Simmons').then (random) ->
          random.type.should.equal 'success', 'Random joke request unsucccesful'
          if random.value.joke.indexOf('Simmons') > -1
            has_name = true
      setTimeout -> has_name.should.be.true 'Random joke not a Chuck Norris' +
        'joke with new last name', 2500

    it 'should return a random joke with new full name', ->
      has_name = false
      for i in [1..10]
        chuckApi.getRandom(firstName:'Phil', lastName:'Simmons')
          .then (random) ->
            random.type.should.equal 'success',
              'Random joke request unsucccesful'
            if random.value.joke.indexOf('Phil Simmons') > -1
              has_name = true
      setTimeout -> has_name.should.be.true 'Random joke not a Chuck Norris' +
        'joke with new full name', 2500

      it 'should only return jokes with specified category in limitTo', ->
        for i in [1..1000]
          chuckApi.getRandom({limitTo:['nerdy']}).then (random) ->
            random.type.should.equal 'success',
              'Random joke request unsuccessful'
            random.categories.should.contain 'nerdy',
                'Not returning random joke with proper category'

      it 'should not return jokes with specified category in exclude', ->
        for i in [0..1000]
          chuckApi.getRandom({exclude:['explicit']}).then (random) ->
            random.type.should.equal 'success',
              'Random joke request unsuccessful'
            joke.categories.should.not.contain 'explicit',
              'Returning random joke with excluded category'


  describe 'specific', ->

    it 'should return a specific joke by Id', ->
      chuckApi.getJoke(469).then (joke) ->
        joke.type.should.equal 'success', 'Specific joke request unsucccesful'
        joke.value.joke.should.equal 'Chuck Norris can unit test entire ' +
          'applications with a single assert.',
          'Unexpected specific joke text'

    it 'should return a specific joke by Id with new first name', ->
      chuckApi.getJoke(469, firstName:'Phil').then (joke) ->
        joke.type.should.equal 'success', 'Specific joke request unsucccesful'
        joke.value.joke.should.equal 'Phil Norris can unit test entire ' +
          'applications with a single assert.',
          'Unexpected specific joke text with new first name'

    it 'should return a specific joke by Id with new last name', ->
      chuckApi.getJoke(469, lastName:'Simmons').then (joke) ->
        joke.type.should.equal 'success', 'Specific joke request unsucccesful'
        joke.value.joke.should.equal 'Chuck Simmons can unit test entire ' +
          'applications with a single assert.'
          'Unexpected specific joke text with new last name'

    it 'should return a specific joke by Id with new first and last name', ->
      chuckApi.getJoke(469, {firstName:'Phil', lastName:'Simmons'})
        .then (joke) ->
          joke.type.should.equal 'success',
            'Specific joke request unsucccesful'
          joke.value.joke.should.equal 'Phil Simmons can unit test entire ' +
            'applications with a single assert.'
            'Unexpected specific joke text with new full name'
