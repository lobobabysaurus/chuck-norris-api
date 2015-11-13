Http = require('http')
Promise = require('promise')


class ChuckNorrisApi

  getCount: ->
    return new Promise((resolve, reject) ->
      count = Http.get 'http://api.icndb.com/jokes/count/', (response) ->
        # Continuously update stream with data
        body = ''
        response.on 'data', (d) ->
          body += d
        response.on 'end', ->
          # Data reception is done, do whatever with it!
          data = JSON.parse body
          resolve(data.value)
    )

module.exports = ChuckNorrisApi
