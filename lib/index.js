var request = require('request');
var helpers = require('request/lib/helpers');
var url = require('url');
var path = require('path');
path.sep = '/';

module.exports = function namespacedRequest(uri) {
  var wrap = wrapRequest.bind(null, uri);

  var baseRequest = request.defaults({
    json: true,
  });

  var newRequest = wrap(baseRequest);

  ['get', 'patch', 'post', 'put', 'head', 'del'].forEach(function(method) {
    newRequest[method] = wrap(baseRequest[method]);
  });

  ['cookie', 'jar', 'defaults'].forEach(function(extra) {
    newRequest[extra] = baseRequest[extra];
  });

  return newRequest;
};

function wrapRequest(baseUri, baseRequest) {
  var baseComponents = uriComponents(baseUri);

  return function namespacedRequest(uri, options, callback) {
    callback = helpers.filterForCallback([options, callback]);
    options = helpers.constructOptionsFrom(uri, options);
    if(options.url) options.uri = options.url;

    components = uriComponents(options.uri);
    combinedComponents = {
      protocol: components.protocol || baseComponents.protocol,
      auth: components.auth || baseComponents.auth,
      port: components.port || baseComponents.port,
      hostname: components.hostname || baseComponents.hostname,
      hash: components.hash || baseComponents.hash,
      search: components.search || baseComponents.search,
      query: components.query || baseComponents.query,
      pathname: path.join(baseComponents.pathname, components.pathname)
    };

    options.uri = url.format(combinedComponents);

    return baseRequest(options.uri, options, callback);
  };
}

function uriComponents(uri) {
  var components = {};
  var parsed = (typeof uri == 'string') ? url.parse(uri) : (uri || {});
  if (!parsed.pathname) parsed.pathname = '';

  ['protocol', 'auth', 'hostname', 'port', 'search', 'query', 'pathname'].forEach(function(component) {
    var val = parsed[component];
    if(val === undefined || val === null) return;
    else if(typeof val == 'object') components[component] = val;
    else components[component] = String(val);
  });

  return components;
}
