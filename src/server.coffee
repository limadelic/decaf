port = process.argv[2]
net = require 'net'
{ writeFile } = require 'fs'

server = net.createServer (stream) ->

  console.log "started on #{port}"
  stream.setEncoding 'utf8'
  stream.write 'Slim -- V0.3\n'

  exit = ->
    stream.end()
    server.close()
    console.log "i'm rich"

  value_of = (data) -> data.toString().substring 7

  stream.on 'data', (data) ->
    value = value_of data
    console.log "#{value.length}:#{value}"
    return exit() if value is 'bye'
    stream.write '000054:[000001:000037:[000002:000010:import_0_0:000002:OK:]:]'

server.listen port

