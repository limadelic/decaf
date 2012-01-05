stuff = '000054:[000001:000037:[000002:000010:import_0_0:000002:OK:]:]'
bye = '000003:bye'

port = process.argv[2]
net = require 'net'
{ writeFile } = require 'fs'

server = net.createServer (stream) ->

  stream.setEncoding 'utf8'
  stream.write 'Slim -- V0.3\n'

  stream.on 'data', (message) ->
    if message is bye then do exit else process message

  process = (message) -> stream.write stuff

  exit = ->
    stream.end()
    server.close()
    console.log "i'm rich"

server.listen port

