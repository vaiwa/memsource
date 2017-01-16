express = require 'express'
bodyParser = require 'body-parser'

config = require('cson-config').load()
logger = require('./lib/server/logger')()
router = require('./lib/server/router')

app = express()
app.use bodyParser.json()
app = router app, logger

app.listen config.port, () ->
  console.log "App running on: http://localhost:#{config.port}"
