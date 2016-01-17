# chuck-norris-api
Node JS interface into the [Internet Chuck Norris Database API][api-url]

All calls return [promises][promises-url] which can be accessed by calling  
`.then( function(data) {...})`  

Full technical documentation available [here][docs-url]

## Example
```
var cn = require('chuck_norris_api');
cn.getRandom(options).then(function (data) {
    console.log(data.value.joke);
});
```
[api-url]: http://www.ICNDb.com/api/
[docs-url]: https://phil-simmons.com/chuck-api-docs/
[promises-url]: https://www.npmjs.com/package/promise
