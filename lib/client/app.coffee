
port = 8080 # TODO

callApi = (endpoint, data, done = ->) ->
  $.ajax
    type: 'POST'
    contentType: 'application/json'
    url: "http://localhost:#{port}/api/v1/#{endpoint}"
    data: JSON.stringify data
    success: (data) -> done null, data
    error: (err) -> done err


app = new Vue
  el: '#app'
  data:
    user:
      userName: ''
      password: ''
    token: null
    projects: []
  computed:
    validation: ->
      userName: !!@user.userName.trim()
      password: !!@user.password.trim()
    isValid: -> Object.keys(@validation).every (key) => @validation[key]
  methods:
    login: ->
      return unless @isValid
      callApi 'login', @user, (err, res) =>
        return unless @token = res.token
        callApi 'list', token: @token, (err, res) =>
          return unless @projects = res.data
          $("#form").hide()
          callApi 'log', level: 'debug', message: 'DONE'


