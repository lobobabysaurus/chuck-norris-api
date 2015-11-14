Http = require('http')

_ = require('lodash')
Promise = require('promise')

###*
# Wrapper arount the [Internet Chuck Norris Database API][api-url]
#
# [api-url]: http://www.icndb.com/api/
# @class ChuckNorrisApi
###
class ChuckNorrisApi

  ###*
  # URL for the api server
  # @property apiHost
  # @type String
  # @default 'http://api.icndb.com/'
  ###
  constructor: -> @apiHost = 'http://api.icndb.com/'

  ###*
  # Get all jokes that are available from the icndb
  #
  # @method getAllJokes
  # @param {Object} options All available filter parameters. Currently supports
  #  *first* and *last* as replacements for Chuck's first and last name in jokes
  # @return {Object} Json object with all jokes.  Follows the format:
  #   {type:"success", value: [{id: 1, joke: "Some chuck norris joke",
  #   categories:[category1,...]},...]}
  ###
  getAllJokes: (options)->
    resource = @_addNamesToResource "jokes/", options
    @_requestData resource

  ###*
  # Get all jokes categories available from the icndb
  #
  # @method getCategories
  # @return {Object} All available categories. Follows the format
  #   {type:"success", value: ['category1',...]}
  ###
  getCategories: -> @_requestData 'categories'


  ###*
  # Get total number of jokes on the icndb
  #
  # @method getCount
  # @return {Object} Total number of jokes. Follows the format
  #   {type:"success", value: 494}
  ###
  getCount: -> @_requestData 'jokes/count'

  ###*
  # Get a specific joke from the icndb
  #
  # @method getJoke
  # @param {Number} joke_id The id of the joke to retrieve
  # @param {Object} options All available filter parameters. Currently supports
  #  *first* and *last* as replacements for Chuck's first and last name in jokes
  # @return {Object} Json object with all jokes.  Follows the format:
  #   {type:"success", value: {id: 1, joke: "Some chuck norris joke",
  #   categories:[category1,...]}}
  ###
  getJoke: (joke_id, options) ->
    resource = @_addNamesToResource "jokes/#{joke_id}", options
    @_requestData resource

  ###*
  # Get a random joke from the icndb
  #
  # @method getRandom
  # @param {Object} options All available filter parameters. Currently supports
  #  *first* and *last* as replacements for Chuck's first and last name in jokes
  # @return {Object} Json object with the joke.  Follows the format:
  #   {type:"success", value: {id: 1, joke: "Some chuck norris joke",
  #   categories:[category1,...]}}
  ###
  getRandom: (options) ->
    resource = @_addNamesToResource "jokes/random", options
    @_requestData resource

  _addNamesToResource: (resource, options) ->
    options = _.merge({}, options)
    if options.first and options.last
      resource += "?firstName=#{options.first}&lastName=#{options.last}"
    else if options.first
      resource += "?firstName=#{options.first}"
    else if options.last
      resource += "?lastName=#{options.last}"
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
