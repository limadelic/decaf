port = process.argv[2]
net = require 'net'

server = net.createServer (socket) =>

  socket.write 'hello\n'

  exit = ->
    socket.write 'bye'
    socket.end()
    server.close()

  is_bye = (data) -> data.slice(0,3).toString() is 'bye'

  socket.on 'data', (data) ->
    return exit() if is_bye data
    console.log "#{data}"


server.listen port
