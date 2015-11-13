Http = require('http')
Promise = require('promise')


class ChuckNorrisApi

  constructor: -> @apiHost = 'http://api.icndb.com/'

  getAllJokes: -> @_requestData 'jokes/'

  getCategories: -> @_requestData 'categories'

  getCount: -> @_requestData 'jokes/count'

  getJoke: (joke_id, first, last) ->
    resource = @_addNamesToResource("jokes/#{joke_id}", first, last)
    @_requestData resource


  getRandom: -> @_requestData 'jokes/random'

  _addNamesToResource: (resource, first, last) ->
    if first and last
      resource += "?firstName=#{first}&lastName=#{last}"
    else if first
      resource += "?firstName=#{first}"
    else if last
      resource += "?lastName=#{last}"
    return resource

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
