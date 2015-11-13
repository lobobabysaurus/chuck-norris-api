Http = require('http')
Promise = require('promise')


class ChuckNorrisApi

  constructor: -> @apiHost = 'http://api.icndb.com/'

  getCount: -> @_requestData 'jokes/count'

  getRandom: -> @_requestData 'jokes/count'

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
