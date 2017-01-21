
memsourceApi = require './services/memsource-api'


module.exports = (app, logger) ->

  memApi = memsourceApi logger

  app.get '/', (req, res) ->
    res.sendfile './public/index.html'

  app.post '/api/v1/login', (req, res) ->
    body = req.body
    logger.info 'Login', body # log every attempt
    {userName, password} = body
    memApi.login userName, password, (err, data) ->
      return res.send err if err
      res.json data

  app.post '/api/v1/list', (req, res) ->
    memApi.list req.body?.token, (err, data) ->
      return res.send err if err
      res.json data

  app.post '/api/v1/log', (req, res) ->
    {level, message, data} = req.body
    
    method = switch level
      when 'debug' then 'info'
      else 'error'

    logger[method] message, data
    res.json status: 'ok'

  app