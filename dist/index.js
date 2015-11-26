(function() {
  var ChuckNorrisApi, Http, Promise;

  Http = require('http');

  Promise = require('promise');


  /**
   * Wrapper around the [Internet Chuck Norris Database API][api-url]
   *
   * [api-url]: http://www.ICNDb.com/api/
   * @class ChuckNorrisApi
   */

  ChuckNorrisApi = (function() {

    /**
     * URL for the api server
     *
     * @property apiHost
     * @type String
     * @default 'http://api.ICNDb.com/'
     */
    function ChuckNorrisApi() {
      this.apiHost = 'http://api.ICNDb.com/';
    }


    /**
     * Get all jokes that are available from the ICNDb
     *
     * @method getAllJokes
     * @param {Object} options All available filter parameters. Currently supports
     *  *firstName* and *lastName* as strings to replace Chuck's first and last
     *  name in jokes and *limitTo* and *exclude* as arrays to filter categories
     * @return {Object} Json object with all jokes.  Follows the format:
     *   `{type:"success", value: [{id: 1, joke: "Some chuck norris joke",
     *   categories:[category1,...]},...]}`
     */

    ChuckNorrisApi.prototype.getAllJokes = function(options) {
      return this._requestData(this._addQueryToResource('jokes/', options));
    };


    /**
     * Get all joke categories available from the ICNDb
     *
     * @method getCategories
     * @return {Object} All available categories. Follows the format
     *   `{type:"success", value: ['category1',...]}`
     */

    ChuckNorrisApi.prototype.getCategories = function() {
      return this._requestData('categories');
    };


    /**
     * Get total number of jokes on the ICNDb
     *
     * @method getCount
     * @return {Object} Total number of jokes. Follows the format
     *   `{type:"success", value: 494}`
     */

    ChuckNorrisApi.prototype.getCount = function() {
      return this._requestData('jokes/count');
    };


    /**
     * Get a specific joke from the ICNDb
     *
     * @method getJoke
     * @param {Number} joke_id The id of the joke to retrieve
     * @param {Object} options All available filter parameters. Currently supports
     *  *firstName* and *lastName* as replacements for Chuck's first and last name
     *  in jokes
     * @return {Object} Json object with all jokes.  Follows the format:
     *   `{type:"success", value: {id: 1, joke: "Some chuck norris joke",
     *   categories:[category1,...]}}`
     */

    ChuckNorrisApi.prototype.getJoke = function(joke_id, options) {
      return this._requestData(this._addQueryToResource("jokes/" + joke_id, options));
    };


    /**
     * Get a random joke from the ICNDb
     *
     * @method getRandom
     * @param {Object} options All available filter parameters. Currently supports
     *  *firstName* and *lastName* as strings to replace Chuck's first and last
     *  name in jokes, *limitTo* and *exclude* as arrays to filter categories
     *  in jokes, as well as *number* for the number of random jokes to retrieve
     * @return {Object} Json object with the joke.  Follows the format:
     *   `{type:"success", value: {id: 1, joke: "Some chuck norris joke",
     *   categories:[category1,...]}}` for individual joke and `{type:"success",
     *   value: [{id: 1, joke: "Some chuck norris joke",
     *   categories:[category1,...]}]}` for multiple jokes
     */

    ChuckNorrisApi.prototype.getRandom = function(options) {
      var resource_root;
      resource_root = 'jokes/random';
      if (options != null ? options.number : void 0) {
        resource_root += "/" + options.number;
      }
      return this._requestData(this._addQueryToResource(resource_root, options));
    };


    /*
     * Adds names to the query string where provided
     *
     * @param {String} resource Root API resource string
     * @param {Object} options Filter parameters, currently firstName, lastName,
     *   limitTo and exclude
     */

    ChuckNorrisApi.prototype._addQueryToResource = function(resource, options) {
      resource += '?escape=javascript';
      if (options != null ? options.firstName : void 0) {
        resource += "&firstName=" + options.firstName;
      }
      if (options != null ? options.lastName : void 0) {
        resource += "&lastName=" + options.lastName;
      }
      if (options != null ? options.limitTo : void 0) {
        resource += "&limitTo=" + options.limitTo;
      }
      if (options != null ? options.exclude : void 0) {
        resource += "&exclude=" + options.exclude;
      }
      return resource;
    };


    /*
     * Obtains the requested data from the API
     *
     * @param {String} resource API resource to request data from
     */

    ChuckNorrisApi.prototype._requestData = function(resource) {
      return new Promise((function(_this) {
        return function(resolve, reject) {
          return Http.get("" + _this.apiHost + resource, function(response) {
            var body;
            body = '';
            response.on('data', function(d) {
              return body += d;
            });
            return response.on('end', function() {
              var data;
              data = JSON.parse(body);
              return resolve(data);
            });
          });
        };
      })(this));
    };

    return ChuckNorrisApi;

  })();

  module.exports = ChuckNorrisApi;

}).call(this);
