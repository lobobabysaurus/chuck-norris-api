(function() {
  var ChuckNorrisApi, Http, Promise;

  Http = require('http');

  Promise = require('promise');

  ChuckNorrisApi = (function() {
    function ChuckNorrisApi() {}

    ChuckNorrisApi.prototype.getCount = function() {
      return new Promise(function(resolve, reject) {
        var count;
        return count = Http.get('http://api.icndb.com/jokes/count/', function(response) {
          var body;
          body = '';
          response.on('data', function(d) {
            return body += d;
          });
          return response.on('end', function() {
            var data;
            data = JSON.parse(body);
            return resolve(data.value);
          });
        });
      });
    };

    return ChuckNorrisApi;

  })();

  module["export"] = ChuckNorrisApi;

}).call(this);
