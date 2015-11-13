Http = require('http')
Promise = require('promise')


class ChuckNorrisApi

  constructor: -> @apiHost = 'http://api.icndb.com/'

  getAllJokes: -> @_requestData 'jokes/'

  getCategories: -> @_requestData 'categories'

  getCount: -> @_requestData 'jokes/count'

  getJoke: (joke_id) -> @_requestData "jokes/#{joke_id}"

  getRandom: -> @_requestData 'jokes/random'

  _requestData: (resource) ->
    return new Promise(((resolve, reject)->
      Http.get "#{@apiHost}#{resource}", (response) ->
        body = ''
        response.on 'data', (d) ->
          body += d
        response.on 'end', ->
          data = JSON.parse body
          resolve(data)
    ).bind(this))

module.exports = ChuckNorrisApi
