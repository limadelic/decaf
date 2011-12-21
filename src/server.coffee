port = process.argv[2]
net = require 'net'
{ writeFile } = require 'fs'

server = net.createServer (socket) ->

  console.log "started on #{port}"
  socket.write 'Slim -- V0.3\n'

  exit = ->
    socket.end()
    server.close()

  is_bye = (data) -> data.slice(6,3).toString() is 'bye'

  socket.on 'data', (data) ->
    data = data.toString()
    console.log data
    return exit() if is_bye data
    socket.write '[000002:000010:import_0_0:000002:OK:]'
    socket.write '[000001:000037:[000002:000010:import_0_0:000002:OK:]:]'

server.listen port
