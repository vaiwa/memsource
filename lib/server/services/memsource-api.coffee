_ = require 'lodash'
request = require 'request'


module.exports = (logger) ->

  memsourceApiPath = 'https://cloud.memsource.com/web/api/v3'


  login: (userName, password, done) ->
    url = "#{memsourceApiPath}/auth/login"
    params = {userName, password}
    request.post url, {form: params, json: yes}, (err, res, data) ->
      logger.error 'login api error', err if err
      done err, data

  list: (token, done) ->
    params = {token}
    url = "#{memsourceApiPath}/project/list"
    request.post url, {form: params, json: yes}, (err, res, projects) ->
      if err
        logger.error 'list api error', err
        done err
      data = _.map projects, (project) -> _.pick project, ['id', 'name', 'dateCreated', 'sourceLang', 'targetLangs', 'status']
      done null, {data}
