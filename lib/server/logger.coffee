
module.exports = () ->

  info: (message, data) -> console.log 'INFO:', message, data
  
  error: (message, data) -> console.log 'ERROR:', message, data
