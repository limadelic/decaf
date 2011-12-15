app = require('express').createServer()
io = require('socket.io').listen(app)

port =  process.argv[2]

console.log "
=============================\n
decaf running on port:#{port}\n
slim -- v0.3                 \n
=============================\n
"

app.listen port

io.on 'connection', -> console.log 'yay!!'