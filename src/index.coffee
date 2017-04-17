Http = require('http')
querystring = require('querystring');

Promise = require('promise')

###*
# Wrapper around the [Internet Chuck Norris Database API][api-url]
#
# [api-url]: http://www.ICNDb.com/api/
# @class ChuckNorrisApi
###
class ChuckNorrisApi

  ###*
  # URL for the api server
  #
  # @property apiHost
  # @type String
  # @default 'http://api.ICNDb.com/'
  ###
  constructor: -> @apiHost = 'http://api.ICNDb.com/'

  ###*
  # Get all jokes that are available from the ICNDb
  #
  # @method getAllJokes
  # @param {Object} options query options
  # @return {Object} Json object with all jokes.  Follows the format:
  #   `{type:"success", value: [{id: 1, joke: "Some chuck norris joke",
  #   categories:[category1,...]},...]}`
  ###
  getAllJokes: (options) ->
    @_requestJoke 'jokes/', options

  ###*
  # Get all joke categories available from the ICNDb
  #
  # @method getCategories
  # @return {Object} All available categories. Follows the format
  #   `{type:"success", value: ['category1',...]}`
  ###
  getCategories: ->
    @_requestJoke 'categories'


  ###*
  # Get total number of jokes on the ICNDb
  #
  # @method getCount
  # @return {Object} Total number of jokes. Follows the format
  #   `{type:"success", value: 494}`
  ###
  getCount: ->
    @_requestJoke 'jokes/count'

  ###*
  # Get a specific joke from the ICNDb
  #
  # @method getJoke
  # @param {Number} joke_id The id of the joke to retrieve
  # @param {Object} options query options. Currently supports
  #  *firstName* and *lastName* as replacements for Chuck's first and last name
  #  in jokes
  # @return {Object} Json object with all jokes.  Follows the format:
  #   `{type:"success", value: {id: 1, joke: "Some chuck norris joke",
  #   categories:[category1,...]}}`
  ###
  getJoke: (joke_id, options) ->
    @_requestJoke "jokes/#{joke_id}", options

  ###*
  # Get a random joke from the ICNDb
  #
  # @method getRandom
  # @param {Object} options All standard options as well as *number* for the
  #   number of random jokes to retrieve
  # @return {Object} Json object with the joke.  Follows the format:
  #   `{type:"success", value: {id: 1, joke: "Some chuck norris joke",
  #   categories:[category1,...]}}` for individual joke and `{type:"success",
  #   value: [{id: 1, joke: "Some chuck norris joke",
  #   categories:[category1,...]}]}` for multiple jokes
  ###
  getRandom: (options) ->
    resource = 'jokes/random'
    if options?.number
      resource += "/#{options.number}"
      delete options.number

    @_requestJoke resource, options

  ###
  # Obtains the requested data from the API
  #
  # @method _requestJoke
  # @param {String} resource API resource to request data from
  # @param {Object} options query parameters.  Currently supports
  #  *firstName* and *lastName* as strings to replace Chuck's first and last
  #  name in jokes, *limitTo* and *exclude* as arrays to filter categories
  #  in jokes,
  ###
  _requestJoke: (resource, options) ->
    url = "#{@apiHost}#{resource}"
    if options
      url += "?#{querystring.stringify(options)}"

    return new Promise (resolve, reject) =>
      Http.get url, (response) ->
        body = ''
        response.on 'data', (d) ->
          body += d
        response.on 'end', ->
          data = JSON.parse body
          resolve(data)

module.exports = new ChuckNorrisApi()
