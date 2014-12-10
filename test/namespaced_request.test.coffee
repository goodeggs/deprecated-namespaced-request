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

  it 'works', ->
    r = namespacedRequest "http://#{host}:#{port}"
    r.get '/hello-world'
    expect(request.Request).to.have.been.calledOnce
    expect(request.Request).to.have.been.calledWithMatch uri: "http://#{host}:#{port}/hello-world"
