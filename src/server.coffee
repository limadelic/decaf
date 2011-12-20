port = process.argv[2]
net = require 'net'
{ writeFile } = require 'fs'

_log = ''
log = (msg) -> writeFile 'log.txt', _log += msg

server = net.createServer (socket) =>

  log "started on #{port}"
  socket.write 'Slim -- V0.3'

  exit = ->
    write_log()
    socket.end()
    server.close()

  is_bye = (data) -> data.slice(0,3).toString() is 'bye'

  socket.on 'data', (data) ->
    log data.toString()
    return exit() if is_bye data

server.listen port
