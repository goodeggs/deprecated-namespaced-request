namespacedRequest = require '..'
request = require 'request'

{expect} = chai = require 'chai'
sinon = require 'sinon'
chai.use require 'sinon-chai'

port = process.env['PORT'] || 28103
host = '127.0.0.1'

describe 'namespaced-request', ->
  beforeEach ->
    request.Request = sinon.stub()

  it 'lets you supply a string url', ->
    r = namespacedRequest "http://#{host}:#{port}"
    r.get '/hello-world'
    expect(request.Request).to.have.been.calledOnce
    expect(request.Request).to.have.been.calledWithMatch uri: "http://#{host}:#{port}/hello-world"

  it 'lets you supply a url object', ->
    r = namespacedRequest
      protocol: 'http:'
      hostname: host
      port: port

    r.get uri:
      pathname: 'foo-bar'
      query: {baz: 'bax'}

    expect(request.Request).to.have.been.calledOnce
    expect(request.Request).to.have.been.calledWithMatch uri: "http://#{host}:#{port}/foo-bar?baz=bax"

  it 'works with no supplied url', ->
    r = namespacedRequest "http://#{host}:#{port}"
    r.get()
    expect(request.Request).to.have.been.calledOnce
    expect(request.Request).to.have.been.calledWithMatch uri: "http://#{host}:#{port}/"

  it 'works if you supply a URL instead of a URI object', ->
    r = namespacedRequest "http://#{host}:#{port}"
    r.get url: '/herp/derp'
    expect(request.Request).to.have.been.calledOnce
    expect(request.Request).to.have.been.calledWithMatch uri: "http://#{host}:#{port}/herp/derp"
