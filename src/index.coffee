Http = require('http')
Promise = require('promise')


class ChuckNorrisApi

  constructor: -> @apiHost = 'http://api.icndb.com/jokes/'

  getAllJokes: -> @_requestData('')

  getCount: -> @_requestData 'count'

  getRandom: -> @_requestData 'random'

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
