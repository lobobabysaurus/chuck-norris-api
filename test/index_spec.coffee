should = require('chai').should()
Promise = require('promise')

api = require('../src/index.coffee')


describe 'Chuck Api Reader', ->

  describe 'getAllJokes', ->

    it 'should return the correct number of jokes', ->
      api.getAllJokes().then (jokes) ->
        jokes.type.should.equal 'success'
        jokes.value.length.should.be.above 500

    it 'should return jokes as expected', ->
      api.getAllJokes().then (jokes) ->
        jokes.type.should.equal 'success'
        jokes.value[455].joke.should.equal 'For Chuck Norris, NP-Hard = O(1).'

    it 'should return jokes as expected with new first name', ->
      api.getAllJokes(firstName: 'Phil').then (jokes) ->
        jokes.type.should.equal 'success'
        jokes.value[455].joke.should.equal 'For Phil Norris, NP-Hard = O(1).'

    it 'should return jokes as expected with new last name', ->
      api.getAllJokes(lastName: 'Simmons').then (jokes) ->
        jokes.type.should.equal 'success'
        jokes.value[455].joke.should.equal 'For Chuck Simmons, NP-Hard = O(1).'

    it 'should return jokes as expected with new full name', ->
      api.getAllJokes(firstName: 'Phil', lastName: 'Simmons').then (jokes) ->
        jokes.type.should.equal 'success'
        jokes.value[455].joke.should.equal 'For Phil Simmons, NP-Hard = O(1).'

    it 'should only return jokes with specified category in limitTo', ->
      api.getAllJokes(limitTo: ['explicit']).then (jokes) ->
        jokes.type.should.equal 'success'
        for joke in jokes.value
          joke.categories.should.contain 'explicit'

    it 'should not return jokes with specified category in exclude', ->
      api.getAllJokes(exclude: ['explicit']).then (jokes) ->
        jokes.type.should.equal 'success'
        for joke in jokes.value
          joke.categories.should.not.contain 'explicit'


  describe 'getCategories', ->

    it 'should get all categories', ->
      api.getCategories().then (categories) ->
        categories.type.should.equal 'success'
        categories.value.should.deep.equal ['explicit', 'nerdy']


  describe 'getCount', ->

    it 'should return the number of jokes', ->
      api.getCount().then (count) ->
        count.type.should.equal 'success'
        count.value.should.be.above 500


  describe 'getRandom', ->

    it 'should return a random joke', ->
      api.getRandom().then (random) ->
        random.type.should.equal 'success'
        random.value.joke.should.contain 'Chuck'

    it 'should return multiple random jokes when specified', ->
      api.getRandom(number: 3).then (random) ->
        random.type.should.equal 'success'
        random.value.length.should.equal 3

    it 'should return a random joke with new first name', ->
      has_name = false
      for i in [1..10]
        api.getRandom(firstName: 'Phil').then (random) ->
          random.type.should.equal 'success',
          if random.value.joke.indexOf('Phil') > -1
            has_name = true
      setTimeout -> has_name.should.be.true 'Random joke not a Chuck Norris' +
        'joke with new first name', 2500

    it 'should return a random joke with new last name', ->
      has_name = false
      for i in [1..10]
        api.getRandom(lastName:'Simmons').then (random) ->
          random.type.should.equal 'success'
          if random.value.joke.indexOf('Simmons') > -1
            has_name = true
      setTimeout -> has_name.should.be.true 'Random joke not a Chuck Norris' +
        'joke with new last name', 2500

    it 'should return a random joke with new full name', ->
      has_name = false
      for i in [1..10]
        api.getRandom(firstName:'Phil', lastName:'Simmons')
          .then (random) ->
            random.type.should.equal 'success'
            if random.value.joke.indexOf('Phil Simmons') > -1
              has_name = true
      setTimeout -> has_name.should.be.true 'Random joke not a Chuck Norris' +
        'joke with new full name', 2500

      it 'should only return jokes with specified category in limitTo', ->
        for i in [1..1000]
          api.getRandom({limitTo:['nerdy']}).then (random) ->
            random.type.should.equal 'success'
            random.categories.should.contain 'nerdy'

      it 'should not return jokes with specified category in exclude', ->
        for i in [0..1000]
          api.getRandom({exclude:['explicit']}).then (random) ->
            random.type.should.equal 'success'
            joke.categories.should.not.contain 'explicit'


  describe 'getJoke', ->

    it 'should return a specific joke by Id', ->
      api.getJoke(469).then (joke) ->
        joke.type.should.equal 'success'
        joke.value.joke.should.equal 'Chuck Norris can unit test entire ' +
          'applications with a single assert.'

    it 'should return a specific joke by Id with new first name', ->
      api.getJoke(469, firstName: 'Phil').then (joke) ->
        joke.type.should.equal 'success'
        joke.value.joke.should.equal 'Phil Norris can unit test entire ' +
          'applications with a single assert.'

    it 'should return a specific joke by Id with new last name', ->
      api.getJoke(469, lastName: 'Simmons').then (joke) ->
        joke.type.should.equal 'success'
        joke.value.joke.should.equal 'Chuck Simmons can unit test entire ' +
          'applications with a single assert.'

    it 'should return a specific joke by Id with new first and last name', ->
      api.getJoke(469, {firstName: 'Phil', lastName: 'Simmons'}).then (joke) ->
        joke.type.should.equal 'success',
        joke.value.joke.should.equal 'Phil Simmons can unit test entire ' +
          'applications with a single assert.'
