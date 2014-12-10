# Namespaced Request

Client HTTP requests with a default hostname, port, and protocol.

[![NPM version](http://img.shields.io/npm/v/namespaced-request.svg?style=flat-square)](https://www.npmjs.org/package/namespaced-request)
[![Build Status](http://img.shields.io/travis/goodeggs/namespaced-request.svg?style=flat-square)](https://travis-ci.org/goodeggs/namespaced-request)
[![MIT License](http://img.shields.io/badge/license-MIT-blue.svg?style=flat-square)](https://github.com/goodeggs/namespaced-request/blob/master/LICENSE.md)

## Usage

```
npm install namespaced-request
```

```javascript
var namespacedRequest = require('namespaced-request');
var request = namespacedRequest("http://github.com/");

process.stdout.pipe(request.get('/goodeggs/namespaced-request'));
process.stdout.pipe(request.get('/goodeggs/resource-schema'));
```

No more having to manually add the host and port! Great for cases where you have
to do lots and lots of requests, like in tests.

## Contributing

Please follow our [Code of Conduct](https://github.com/goodeggs/namespaced-request/blob/master/CODE_OF_CONDUCT.md)
when contributing to this project.

```
$ git clone https://github.com/goodeggs/namespaced-request && cd namespaced-request
$ npm install
$ npm test
```
