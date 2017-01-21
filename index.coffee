express = require 'express'
path = require 'path'
bodyParser = require 'body-parser'
cookieParser = require 'cookie-parser'

config = require('cson-config').load()
logger = require('./lib/server/logger')()
router = require('./lib/server/router')

app = express()

app.set 'views', path.join __dirname, 'views'
app.set 'view engine', 'pug'

app.use bodyParser.json()
app.use cookieParser()
app.use express.static path.join __dirname, 'public'

app = router app, logger

# catch 404 and forward to error handler
app.use (req, res, next) ->
  err = new Error 'Not Found'
  err.status = 404
  next err

# error handler
app.use (err, req, res, next) ->
  # set locals, only providing error in development
  res.locals.message = err.message
  res.locals.error = if req.app.get('env') is 'development' then err else {}

  # render the error page
  res.status err.status or 500
  res.render 'error'

app.listen config.port, () ->
  console.log "App running on: http://localhost:#{config.port}"
