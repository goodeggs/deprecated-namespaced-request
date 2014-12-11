namespacedRequest = require '..'
request = require 'request'

{expect} = chai = require 'chai'
sinon = require 'sinon'
chai.use require 'sinon-chai'

describe 'namespaced-request', ->
  beforeEach ->
    request.Request = sinon.stub()

  it 'lets you supply a string url', ->
    r = namespacedRequest "http://herp-derp.biz"
    r.get '/hello-world'
    expect(request.Request).to.have.been.calledOnce
    expect(request.Request).to.have.been.calledWithMatch uri: "http://herp-derp.biz/hello-world"

  it 'lets you supply a url object', ->
    r = namespacedRequest
      protocol: 'http:'
      hostname: 'herp-derp.biz'
      port: 39481

    r.get uri:
      pathname: 'foo-bar'
      query: {baz: 'bax'}

    expect(request.Request).to.have.been.calledOnce
    expect(request.Request).to.have.been.calledWithMatch uri: "http://herp-derp.biz:39481/foo-bar?baz=bax"

  it 'works with no supplied url', ->
    r = namespacedRequest "http://herp-derp.biz"
    r.get()
    expect(request.Request).to.have.been.calledOnce
    expect(request.Request).to.have.been.calledWithMatch uri: "http://herp-derp.biz/"

  it 'works if you supply a URL instead of a URI object', ->
    r = namespacedRequest "http://herp-derp.biz"
    r.get url: '/herp/derp'
    expect(request.Request).to.have.been.calledOnce
    expect(request.Request).to.have.been.calledWithMatch uri: "http://herp-derp.biz/herp/derp"
