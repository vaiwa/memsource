_ = require 'lodash'
async = require 'async'
request = require 'request'
expect = require('chai').expect
config = require('cson-config').load('./config.cson')

apiPath = "http://localhost:#{config.port}/api/"
token = null


describe 'test apis', ->

  describe 'v1/log', ->
    endpoint = 'v1/log'

    it 'ok', (done) ->
      body = level: 'debug', message: 'api-test'
      request.post "#{apiPath}#{endpoint}", {body, json: yes}, (err, res, resBody) ->
        return done err if err
        expect resBody
        .to.eql status: 'ok'
        done()


  describe 'v1/login', ->
    endpoint = 'v1/login'

    it 'ok', (done) ->
      body = {userName, password} = config
      request.post "#{apiPath}#{endpoint}", {body, json: yes}, (err, res, resBody) ->
        return done err if err
        expect resBody
        .to.have.property 'token'
        .to.be.ok
        token = resBody.token
        done()


  describe 'v1/list', ->
    endpoint = 'v1/list'

    it 'ok', (done) ->
      body = {token}
      request.post "#{apiPath}#{endpoint}", {body, json: yes}, (err, res, resBody) ->
        return done err if err
        expect resBody
        .to.have.property 'data'
        .to.be.an 'array'
        .to.not.be.empty
        done()
