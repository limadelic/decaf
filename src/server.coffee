port = process.argv[2]

{ writeFile } = require 'fs'

writeFile 'out.txt', "
=============================\n
decaf running on port:#{port}\n
slim -- v0.3                 \n
=============================\n
"

log = (msg) -> writeFile 'log.txt', msg

log "i'm here on #{port}"

require('zappa') port, ->

  log 'yeah got a server'

  @on connection: ->
    log 'im here now'
    #@emit 'Slim -- v0.3'
    #log @data
