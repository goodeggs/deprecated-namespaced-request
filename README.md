# Deprecation notice

In April 2015, `request` implemented `baseUrl`. You should use that feature instead of this library.
More details here: https://github.com/request/request/pull/1469

# Namespaced Request

Client HTTP requests with a default hostname, port, and protocol.

[![NPM version](http://img.shields.io/npm/v/namespaced-request.svg?style=flat-square)](https://www.npmjs.org/package/namespaced-request)
[![Build Status](http://img.shields.io/travis/goodeggs/namespaced-request.svg?style=flat-square)](https://travis-ci.org/goodeggs/namespaced-request)
[![MIT License](http://img.shields.io/badge/license-MIT-blue.svg?style=flat-square)](https://github.com/goodeggs/namespaced-request/blob/master/LICENSE.md)

## Usage

Super simple:

```javascript
var namespacedRequest = require('namespaced-request');
var request = namespacedRequest("http://github.com/");

process.stdout.pipe(request.get('/goodeggs/namespaced-request'));
// goes to http://github.com/goodeggs/namespaced-request
process.stdout.pipe(request.get('/request/request'));
// goes to http://github.com/request/request
```

No more having to manually add the host and port! Great for cases where you have
to do lots and lots of requests, like in tests.

`namespacedRequest` returns an instance of the `request` module's request
object. If you're curious what that looks like, check out [the documentation for
`request`.](https://www.npmjs.com/package/request)

What if you want to circumvent the namespace? Simple:

```javascript
var request = namespacedRequest("http://github.com/");
process.stdout.pipe(request.get("https://www.npmjs.com/package/namespaced-request"));
// goes to https://www.npmjs.com/package/namespaced-request
```

What if you want to namespace a request to a directory? You can do that too!

```javascript
var request = namespacedRequest("http://github.com/goodeggs/");
process.stdout.pipe(request.get("resource-schema"));
// goes to http://github.com/goodeggs/resource-schema
```

## Contributing

Please follow our [Code of Conduct](https://github.com/goodeggs/namespaced-request/blob/master/CODE_OF_CONDUCT.md)
when contributing to this project.

```
$ git clone https://github.com/goodeggs/namespaced-request && cd namespaced-request
$ npm install
$ npm test
```
